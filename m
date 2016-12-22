Content-Type: multipart/mixed; boundary="===============5974283352515644914=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20161222 released
Date: Thu, 22 Dec 2016 16:30:42 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E5496DF@ORSMSX110.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5974283352515644914==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

22 December 2016. Summary of changes for version 20161222:

This release is available at https://acpica.org/downloads


1) ACPICA kernel-resident subsystem:

AML Debugger: Implemented a new mechanism to simplify and enhance debugger =
integration into all environments, including kernel debuggers and user-spac=
e utilities, as well as remote debug services. This mechanism essentially c=
onsists of new OSL interfaces to support debugger initialization/terminatio=
n, as well as wait/notify interfaces to perform the debugger handshake with=
 the host. Lv Zheng.

    New OSL interfaces:
        AcpiOsInitializeDebugger (void)
        AcpiOsTerminateDebugger (void)
        AcpiOsWaitCommandReady (void)
        AcpiOsNotifyCommandComplete (void)

    New OS services layer:
        osgendbg.c -- Example implementation, and used for AcpiExec

Update for Generic Address Space (GAS) support: Although the AccessWidth an=
d/or BitOffset fields of the GAS are not often used, this change now fully =
supports these fields. This affects the internal support for FADT registers=
, registers in other ACPI data tables, and the AcpiRead and AcpiWrite publi=
c interfaces. Lv Zheng.

Sleep support: In order to simplify integration of ACPI sleep for the vario=
us host operating systems, a new OSL interface has been introduced. AcpiOsE=
nterSleep allows the host to perform any required operations before the fin=
al write to the sleep control register(s) is performed by ACPICA. Lv Zheng.

    New OSL interface:
        AcpiOsEnterSleep(SleepState, RegisterAValue, RegisterBValue)

    Called from these internal interfaces:
        AcpiHwLegacySleep
        AcpiHwExtendedSleep

EFI support: Added a very small EFI/ACPICA example application. Provides a =
simple demo for EFI integration, as well as assisting with resolution of is=
sues related to customer ACPICA/EFI integration. Lv Zheng. See:

    source/tools/efihello/efihello.c

Local C library: Implemented several new functions to enhance ACPICA portab=
ility, for environments where these clib functions are not available (such =
as EFI). Lv Zheng:
    putchar
    getchar
    strpbrk
    strtok
    memmove

Fixed a regression where occasionally a valid resource descriptor was incor=
rectly detected as invalid at runtime, and a AE_AML_NO_RESOURCE_END_TAG was=
 returned.

Fixed a problem with the recently implemented support that enables control =
method invocations as Target operands to many ASL operators. Warnings of th=
is form: "Needed type [Reference], found [Processor]" were seen at runtime =
for some method invocations.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Current Release:
    Non-Debug Version: 141.5K Code, 58.5K Data, 200.0K Total
    Debug Version:     201.7K Code, 82.7K Data, 284.4K Total
  Previous Release:
    Non-Debug Version: 140.5K Code, 58.5K Data, 198.9K Total
    Debug Version:     201.3K Code, 82.7K Data, 284.0K Total


2) iASL Compiler/Disassembler and Tools:

Disassembler: Enhanced output by adding the capability to detect and disass=
emble ASL Switch/Case statements back to the original ASL source code inste=
ad of if/else blocks. David Box.

AcpiHelp: Split a large file into separate files based upon functionality/p=
urpose. New files are:
    ahaml.c
    ahasl.c


--===============5974283352515644914==--

