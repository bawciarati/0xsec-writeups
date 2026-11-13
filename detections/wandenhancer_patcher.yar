/*
   WandEnhancer / WeMod patcher
   ----------------------------
   Two rules:

     1. MAL_Tool_WandEnhancer_Patcher     - the .NET front end (WandEnhancer.exe)
     2. MAL_Tool_WandEnhancer_VersionProxy - the version.dll proxy it drops next to Wand.exe

   Every pattern below was pulled from the sample and checked byte for byte.
   The .NET string literals live in the #US heap as UTF-16, so most of them
   are matched with "wide".

   Sample (WandEnhancer.exe)
     sha256  f3bbbf159bc0118d61c590b0ec381acc126fcde6c87f3f624748133120423974
     size    1,177,088 bytes
     note    .NET assembly, ILRepack-merged, unsigned, manifest asInvoker

   Sample (version.dll, embedded in the resource "proxydll")
     sha256  b06cb1563cf60fe36f77673da794e3b61d09a1c30c368d079cc4afb89441d1ac
     size    14,336 bytes
     note    native x64, exports all 17 VERSION.dll functions, unsigned
*/

import "pe"

rule MAL_Tool_WandEnhancer_Patcher
{
    meta:
        description = "WandEnhancer: .NET patcher that rewrites WeMod's app.asar, ships a version.dll proxy and can start an unauthenticated remote panel"
        author      = "bpiecks"
        date        = "2026-11-13"
        sha256      = "f3bbbf159bc0118d61c590b0ec381acc126fcde6c87f3f624748133120423974"
        reference   = "https://bpiecks.gitbook.io/bpiecks/malware-analysis/2026-11-13-wandenhancer"
        tlp         = "CLEAR"

    strings:
        // IPC channel names of the remote panel bridge (UTF-16 in the #US heap)
        $ipc_bind      = "wand-remote-set-handler-bind" wide
        $ipc_value     = "wand-remote-value-changed" wide
        // the bridge writes its errors to %TEMP%\wand-remote-bridge.log
        $bridge_log    = "wand-remote-bridge.log" wide
        // files it creates inside the target's resources directory
        $asar_backup   = "app.asar.backup" wide
        $panel_dir     = "remote-panel" wide
        // self-updater: GitHub API + a hidden PowerShell replace of the running exe
        $update_api    = "api.github.com/repos/k1tbyte/Wand-Enhancer/releases/latest" wide
        $ps_bypass    = "-ExecutionPolicy Bypass" wide
        // the embedded resource name of the proxy DLL
        $proxy_res     = "proxydll" ascii

    condition:
        uint16(0) == 0x5A4D and filesize < 30MB and pe.is_dotnet and
        3 of them
}

rule MAL_Tool_WandEnhancer_VersionProxy
{
    meta:
        description = "Unsigned VERSION.dll proxy that patches Electron's fuse wire in memory (embeddedAsarIntegrityValidation)"
        author      = "bpiecks"
        date        = "2026-11-13"
        sha256      = "b06cb1563cf60fe36f77673da794e3b61d09a1c30c368d079cc4afb89441d1ac"
        reference   = "https://bpiecks.gitbook.io/bpiecks/malware-analysis/2026-11-13-wandenhancer"
        tlp         = "CLEAR"

    strings:
        /*
           The 32-byte Electron fuse sentinel, but stored as four mov immediates
           rather than as one string, which is what a fuse-patcher looks like:

             48 B9 "dL7pKGdn"   49 B8 "Nz796Pbb"
             49 B9 "jQWNKmHX"   49 BA "BZaB9tsX"

           file offset 0xAB5, VA 0x1800016B5
        */
        $fuse_sentinel = {
            48 B9 64 4C 37 70 4B 47 64 6E
            49 B8 4E 7A 37 39 36 50 62 62
            49 B9 6A 51 57 4E 4B 6D 48 58
            49 BA 42 5A 61 42 39 74 73 58
        }
        // its own export name, and two forwarded VERSION functions
        $dll_name      = "VERSION.dll" ascii
        $ver_install   = "VerInstallFileW" ascii
        $ver_query     = "VerQueryValueW" ascii
        // it forwards by loading system32\version.dll by hand
        $sysdir        = "GetSystemDirectoryW" ascii

    condition:
        uint16(0) == 0x5A4D and filesize < 2MB and
        pe.number_of_exports > 10 and
        $fuse_sentinel and 2 of ($dll_name, $ver_install, $ver_query, $sysdir)
}
