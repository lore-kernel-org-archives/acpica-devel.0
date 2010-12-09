Content-Type: multipart/mixed; boundary="===============4712312080234233995=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20101209 released
Date: Thu, 09 Dec 2010 10:51:39 -0800
Message-ID: <4911F71203A09E4D9981D27F9D830858BCADE90E@orsmsx503.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4712312080234233995==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

09 December 2010. Summary of changes for version 20101209:

This release is available at www.acpica.org/downloads

1) ACPI CA Core Subsystem:

Completed the major overhaul of the GPE support code that was begun in July=
 2010. Major features include: removal of _PRW execution in ACPICA (host ex=
ecutes _PRWs anyway), cleanup of "wake" GPE interfaces and processing, chan=
ges to existing interfaces, simplification of GPE handler operation, and a =
handful of new interfaces:

    AcpiUpdateAllGpes
    AcpiFinishGpe
    AcpiSetupGpeForWake
    AcpiSetGpeWakeMask
    One new file, evxfgpe.c to consolidate all external GPE interfaces.

See the ACPICA Programmer Reference for full details and programming inform=
ation. See the new section 4.4 "General Purpose Event (GPE) Support" for a =
full overview, and section 8.7 "ACPI General Purpose Event Management" for =
programming details. ACPICA BZ 858,870,877. Matthew Garrett, Lin Ming, Bob =
Moore, Rafael Wysocki.

Implemented a new GPE feature for Windows compatibility, the "Implicit Wake=
 GPE Notify". This feature will automatically issue a Notify(2) on a device=
 when a Wake GPE is received if there is no corresponding GPE method or han=
dler. ACPICA BZ 870.

Fixed a problem with the Scope() operator during table parse and load phase=
. During load phase (table load or method execution), the scope operator sh=
ould not enter the target into the namespace. Instead, it should open a new=
 scope at the target location. Linux BZ 19462, ACPICA BZ 882.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 6.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Previous Release:
    Non-Debug Version:  89.8K Code, 18.9K Data, 108.7K Total
    Debug Version:     166.6K Code, 52.1K Data, 218.7K Total
  Current Release:
    Non-Debug Version:  89.9K Code, 19.0K Data, 108.9K Total
    Debug Version:     166.3K Code, 52.1K Data, 218.4K Total

2) iASL Compiler/Disassembler and Tools:

iASL: Relax the alphanumeric restriction on _CID strings. These strings are=
 "bus-specific" per the ACPI specification, and therefore any characters ar=
e acceptable. The only checks that can be performed are for a null string a=
nd perhaps for a leading asterisk. ACPICA BZ 886.

iASL: Fixed a problem where a syntax error that caused a premature EOF cond=
ition on the source file emitted a very confusing error message. The premat=
ure EOF is now detected correctly. ACPICA BZ 891.

Disassembler: Decode the AccessSize within a Generic Address Structure (byt=
e access, word access, etc.) Note, this field does not allow arbitrary bit =
access, the size is encoded as 1=3Dbyte, 2=3Dword, 3=3Ddword, and 4=3Dqword.

New: AcpiNames utility - Example namespace dump utility. Shows an example o=
f ACPICA configuration for a minimal namespace dump utility. Uses table and=
 namespace managers, but no AML interpreter. Does not add any functionality=
 over AcpiExec, it is a subset of AcpiExec. The purpose is to show how to p=
artition and configure ACPICA. ACPICA BZ 883.

AML Debugger: Increased the debugger buffer size for method return objects.=
 Was 4K, increased to 16K. Also enhanced error messages for debugger method=
 execution, including the buffer overflow case.


--===============4712312080234233995==--

