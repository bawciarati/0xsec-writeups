/*
   LNK stager + AppDomainManager redirect
   --------------------------------------

   Two rules, because the attack is two files and only one of them is
   suspicious on its own.

   Rule 1 looks at the shortcut. The strings are the ones the .lnk carries in
   its StringData: a PowerShell command line that base64-decodes a blob out of
   the .lnk itself. They were read off a real sample's LNK properties, so the
   casing and spacing match what is stored in the file.

   Rule 2 looks at the .config that is dropped next to a copied signed binary.
   `appDomainManagerType` plus `appDomainManagerAssembly` is the pair that
   makes the CLR load a foreign assembly before Main runs. Shipped
   application configs do not contain either of them, which is what makes the
   rule usable: the real dfsvc.exe.config on this machine has a <runtime>
   section with supportedRuntime and AppContextSwitchOverrides and does not
   match.

   Rule 2 does not require an XML declaration, because a config that starts
   with a BOM, or with <configuration> and no declaration at all, is just as
   valid. Both attribute names are matched in ASCII and in UTF-16, because the
   file is tiny and getting that wrong would be a quiet miss.

   Both rules were tested with a Python re-implementation of the conditions
   against synthetic files and against the real dfsvc.exe.config, because
   yara is not installed here. They have not been run through yara itself.
*/

rule T1204_002_LNK_PowerShellBase64Stager
{
    meta:
        description   = "Windows shortcut that decodes a base64 payload out of its own bytes with PowerShell"
        author        = "bpiecks"
        date          = "2026-11-13"
        reference     = "https://bpiecks.gitbook.io/bpiecks/malware-analysis/2026-11-13-lnk-appdomain-hijack"
        tlp           = "CLEAR"

    strings:
        // MS-SHLLINK stores StringData as single-byte text, so ascii is the
        // primary form. wide is kept for shortcut tools that rewrite it.
        $exec    = "-ExecutionPolicy Bypass" ascii wide
        $nop     = "-nop " ascii wide
        $b64     = "FromBase64CharArray" ascii wide
        $seek    = "Seek(" ascii wide
        $origin  = "[IO.SeekOrigin]::Begin" ascii wide
        $split   = "-split" ascii wide
        $tempvar = "$env:temp" ascii wide

    condition:
        uint32(0) == 0x0000004C and          // HeaderSize, i.e. a shell link
        filesize > 100KB and
        $exec and $b64 and $seek and $origin and $split and 1 of ($nop, $tempvar)
}

rule T1574_014_AppDomainManager_ConfigRedirect
{
    meta:
        description = "Application config that redirects the CLR AppDomainManager to a side-loaded assembly"
        author      = "bpiecks"
        date        = "2026-11-13"
        reference   = "https://bpiecks.gitbook.io/bpiecks/malware-analysis/2026-11-13-lnk-appdomain-hijack"
        tlp         = "CLEAR"

    strings:
        $xml_hdr  = "<?xml" ascii
        $type     = "appDomainManagerType" ascii wide
        $assembly = "appDomainManagerAssembly" ascii wide
        $runtime  = "<runtime>" ascii wide

    condition:
        filesize < 10KB and
        all of ($type, $assembly, $runtime)
}
