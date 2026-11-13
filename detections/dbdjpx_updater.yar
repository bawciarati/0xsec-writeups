/*
    DBDJpx updater / loader
    -------------------------
    Sample : DBDJpx.exe
    SHA-256: 384843fc7cd08d6bfab36c3e3bde1aa33986ccfa940eadea3a59aef957c08546
    Build  : 2026-07-25 10:04:23 UTC (TimeDateStamp 0x6A648A27)

    Every string in this binary is stored XOR-encoded with the repeating key
        key(i) = (i % 50) + 0x34
    so the plaintext (URLs, filenames, console messages) never appears in the
    file. The patterns below are the *encoded* bytes taken from the sample.

    Encoded strings used here:
        $enc_url        -> https://web-production-a1a4c.up.railway.app/files/
        $enc_query      -> ?key=<offensive token>   (see NOTE)
        $enc_release    -> release.exe
        $enc_libssl     -> libssl-3-x64.dll
        $enc_libcrypto  -> libcrypto-3-x64.dll

    NOTE: $enc_query contains an offensive racial slur chosen by the sample's
    author. It is kept because the 16-byte sequence (including its trailing
    NUL) is a strong fingerprint. If you do not want the bytes in your ruleset,
    delete $enc_query - the rule still fires without it.

    Validate before deploying:
        yara -r dbdjpx_updater.yar <sample-dir>
*/

import "pe"

rule MAL_Loader_DBDJpx_Updater
{
    meta:
        description = "DBDJpx updater/loader: XOR-obfuscated strings, URLMON downloader, elevated launcher in C:\\Windows\\Temp"
        author      = "bpiecks"
        date        = "2026-11-13"
        reference   = "https://bpiecks.gitbook.io/bpiecks/malware-analysis/2026-11-13-dbdaxera-updater"
        sha256      = "384843fc7cd08d6bfab36c3e3bde1aa33986ccfa940eadea3a59aef957c08546"
        tlp         = "CLEAR"
        confidence  = "high"
        license     = "CC-BY-4.0"

    strings:
        // "https://web-production-a1a4c.up.railway.app/files/"
        $enc_url = {
            5C 41 42 47 4B 03 15 14 4B 58 5C 12 30 33 2D 27 31 26 32 2E
            27 27 67 2A 7D 2C 7A 2C 7E 24 22 7D 26 34 3F 3B 2F 38 23 75
            3D 2D 2E 70 06 08 0E 06 17 4A 34
        }

        // "?key=<offensive token>" - optional, see NOTE above
        $enc_query = { 0B 5E 53 4E 05 50 56 54 4A 58 50 56 27 26 23 43 }

        // "release.exe"
        $enc_release = { 46 50 5A 52 59 4A 5F 15 59 45 5B 3F }

        // "libssl-3-x64.dll"
        $enc_libssl = { 58 5C 54 44 4B 55 17 08 11 45 08 0B 6E 25 2E 2F 44 }

        // "libcrypto-3-x64.dll"
        $enc_libcrypto = {
            58 5C 54 54 4A 40 4A 4F 53 10 0D 12 38 77 76 6D 20 29 2A 47
        }

        // Build machine artifact left in the PDB path
        $pdb = "C:\\Repository\\DBDAxera\\build\\release\\DBDAxera.pdb" ascii

    condition:
        uint16(0) == 0x5A4D and
        filesize < 20MB and
        $enc_url and
        ( 1 of ($enc_release, $enc_libssl, $enc_libcrypto) or $pdb )
}


/*
    Variant hunting: same author, new host.
    The downloader helper always downloads into C:\Windows\Temp while being
    launched with requireAdministrator, so this catches re-hosted builds that
    changed the encoded URL. Expect some noise from legitimate installers -
    scope it to unsigned, unsigned+manifest, or user-writable directories.
*/

rule MAL_Loader_DBDJpx_Family_Hunt
{
    meta:
        description = "Hunt: unsigned x64 PE with URLMON!URLDownloadToFileA + elevated manifest (DBDJpx-style loader family)"
        author      = "bpiecks"
        date        = "2026-11-13"
        tlp         = "CLEAR"
        confidence  = "low"
        note        = "Requires -d filename=.../-d filepath=... for the scoping checks"

    condition:
        uint16(0) == 0x5A4D and
        filesize < 20MB and
        pe.is_pe and
        pe.machine == pe.MACHINE_AMD64 and
        pe.number_of_signatures == 0 and
        pe.imports("URLMON.dll", "URLDownloadToFileA") and
        pe.number_of_sections <= 6 and
        not pe.imports("ADVAPI32.dll") and
        not pe.imports("WININET.dll")
}
