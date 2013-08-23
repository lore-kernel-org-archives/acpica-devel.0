Content-Type: multipart/mixed; boundary="===============5135921314920210866=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20130823 released
Date: Fri, 23 Aug 2013 17:15:47 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E36FED0212@ORSMSX103.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5135921314920210866==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

23 August 2013. Summary of changes for version 20130823:

This release is available at https://acpica.org/downloads


1) ACPICA kernel-resident subsystem:

Implemented support for host-installed System Control Interrupt (SCI) handl=
ers. Certain ACPI functionality requires the host to handle raw SCIs. For e=
xample, the "SCI Doorbell" that is defined for memory power state support r=
equires the host device driver to handle SCIs to examine if the doorbell ha=
s been activated. Multiple SCI handlers can be installed to allow for futur=
e expansion. New external interfaces are AcpiInstallSciHandler, AcpiRemoveS=
ciHandler; see the ACPICA reference for details. Lv Zheng, Bob Moore. ACPIC=
A BZ 1032.

Operation region support: Never locally free the handler "context" pointer.=
 This change removes some dangerous code that attempts to free the handler =
context pointer in some (rare) circumstances. The owner of the handler owns=
 this pointer and the ACPICA code should never touch it. Although not seen =
to be an issue in any kernel, it did show up as a problem (fault) under Acp=
iExec. Also, set the internal storage field for the context pointer to zero=
 when the region is deactivated, simply for sanity. David Box. ACPICA BZ 10=
39.

AcpiRead: On error, do not modify the return value target location. If an e=
rror happens in the middle of a split 32/32 64-bit I/O operation, do not mo=
dify the target of the return value pointer. Makes the code consistent with=
 the rest of ACPICA. Bjorn Helgaas.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Current Release:
    Non-Debug Version:  96.7K Code, 27.1K Data, 123.9K Total
    Debug Version:     184.4K Code, 76.8K Data, 261.2K Total
  Previous Release:
    Non-Debug Version:  96.2K Code, 27.1K Data, 123.3K Total
    Debug Version:     185.4K Code, 77.1K Data, 262.5K Total


2) iASL Compiler/Disassembler and Tools:

AcpiDump: Implemented several new features and fixed some problems:
1) Added support to dump the RSDP, RSDT, and XSDT tables.
2) Added support for multiple table instances (SSDT, UEFI).
3) Added option to dump "customized" (overridden) tables (-c).
4) Fixed a problem where some table filenames were improperly constructed.
5) Improved some error messages, removed some unnecessary messages.

iASL: Implemented additional support for disassembly of ACPI tables that co=
ntain invocations of external control methods. The -fe<file> option allows =
the import of a file that specifies the external methods along with the req=
uired number of arguments for each -- allowing for the correct disassembly =
of the table. This is a workaround for a limitation of AML code where the d=
isassembler often cannot determine the number of arguments required for an =
external control method and generates incorrect ASL code. See the iASL refe=
rence for details. ACPICA BZ 1030.

Debugger: Implemented a new command (paths) that displays the full pathname=
s (namepaths) and object types of all objects in the namespace. This is an =
alternative to the namespace command.

Debugger: Implemented a new command (sci) that invokes the SCI dispatch mec=
hanism and any installed handlers.

iASL: Fixed a possible segfault for "too many parent prefixes" condition. T=
his can occur if there are too many parent prefixes in a namepath (for exam=
ple, ^^^^^^PCI0.ECRD). ACPICA BZ 1035.

Application OSLs: Set the return value for the PCI read functions. These fu=
nctions simply return AE_OK, but should set the return value to zero also. =
This change implements this. ACPICA BZ 1038.

Debugger: Prevent possible command line buffer overflow. Increase the size =
of a couple of the debugger line buffers, and ensure that overflow cannot h=
appen. ACPICA BZ 1037.

iASL: Changed to abort immediately on serious errors during the parsing pha=
se. Due to the nature of ASL, there is no point in attempting to compile th=
ese types of errors, and they typically end up causing a cascade of hundred=
s of errors which obscure the original problem.


--===============5135921314920210866==--

