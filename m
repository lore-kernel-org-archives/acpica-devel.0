Content-Type: multipart/mixed; boundary="===============4194721921100074999=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20131218 released
Date: Wed, 18 Dec 2013 21:44:47 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37C7BA660@ORSMSX103.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4194721921100074999==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

18 December 2013. Summary of changes for version 20131218:

This release is available at https://acpica.org/downloads

Global note: The ACPI 5.0A specification was released this month. There are=
 no changes needed for ACPICA since this release of ACPI is an errata/clari=
fication release. The specification is available at acpi.info.


1) ACPICA kernel-resident subsystem:

Added validation of the XSDT root table if it is present. Some older platfo=
rms contain an XSDT that is ill-formed or otherwise invalid (such as contai=
ning some or all entries that are NULL pointers). This change adds a new fu=
nction to validate the XSDT before actually using it. If the XSDT is found =
to be invalid, ACPICA will now automatically fall back to using the RSDT in=
stead. Original implementation by Zhao Yakui. Ported to ACPICA and enhanced=
 by Lv Zheng and Bob Moore.

Added a runtime option to ignore the XSDT and force the use of the RSDT. Th=
is change adds a runtime option that will force ACPICA to use the RSDT inst=
ead of the XSDT (AcpiGbl_DoNotUseXsdt). Although the ACPI spec requires tha=
t an XSDT be used instead of the RSDT, the XSDT has been found to be corrup=
t or ill-formed on some machines. Lv Zheng.

Added a runtime option to favor 32-bit FADT register addresses over the 64-=
bit addresses. This change adds an option to favor 32-bit FADT addresses wh=
en there is a conflict between the 32-bit and 64-bit versions of the same r=
egister. The default behavior is to use the 64-bit version in accordance wi=
th the ACPI specification. This can now be overridden via the AcpiGbl_Use32=
BitFadtAddresses flag. ACPICA BZ 885. Lv Zheng.

During the change above, the internal "Convert FADT" and "Verify FADT" func=
tions have been merged to simplify the code, making it easier to understand=
 and maintain. ACPICA BZ 933.

Improve exception reporting and handling for GPE block installation. Return=
 an actual status from AcpiEvGetGpeXruptBlock and don't clobber the status =
when exiting AcpiEvInstallGpeBlock. ACPICA BZ 1019.

Added helper macros to extract bus/segment numbers from the HEST table. Thi=
s change adds two macros to extract the encoded bus and segment numbers fro=
m the HEST Bus field - ACPI_HEST_BUS and ACPI_HEST_SEGMENT. Betty Dall <bet=
ty.dall(a)hp.com>

Removed the unused ACPI_FREE_BUFFER macro. This macro is no longer used by =
ACPICA. It is not a public macro, so it should have no effect on existing O=
SV code. Lv Zheng.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Current Release:
    Non-Debug Version:  96.1K Code, 27.0K Data, 123.1K Total
    Debug Version:     185.6K Code, 77.3K Data, 262.9K Total
  Previous Release:
    Non-Debug Version:  95.9K Code, 27.0K Data, 122.9K Total
    Debug Version:     185.1K Code, 77.2K Data, 262.3K Total


2) iASL Compiler/Disassembler and Tools:

Disassembler: Improved pathname support for emitted External() statements. =
This change adds full pathname support for external names that have been re=
solved internally by the inclusion of additional ACPI tables (via the iASL =
-e option). Without this change, the disassembler can emit multiple externa=
ls for the same object, or it become confused when the Scope() operator is =
used on an external object. Overall, greatly improves the ability to actual=
ly recompile the emitted ASL code when objects a referenced across multiple=
 ACPI tables. Reported by Michael Tsirkin (mst(a)redhat.com).

Tests/ASLTS: Updated functional control suite to execute with no errors. Da=
vid Box. Fixed several errors related to the testing of the interpreter sla=
ck mode. Lv Zheng.

iASL: Added support to detect names that are declared within a control meth=
od, but are unused (these are temporary names that are only valid during th=
e time the method is executing). A remark is issued for these cases. ACPICA=
 BZ 1022.

iASL: Added full support for the DBG2 table. Adds full disassembler, table =
compiler, and template generator support for the DBG2 table (Debug Port 2 t=
able).

iASL: Added full support for the PCCT table, update the table definition. U=
pdates the PCCT table definition in the actbl3.h header and adds table comp=
iler and template generator support.

iASL: Added an option to emit only error messages (no warnings/remarks). Th=
e -ve option will enable only error messages, warnings and remarks are supp=
ressed. This can simplify debugging when only the errors are important, suc=
h as when an ACPI table is disassembled and there are many warnings and rem=
arks -- but only the actual errors are of real interest.

Example ACPICA code (source/tools/examples): Updated the example code so th=
at it builds to an actual working program, not just example code. Added ACP=
I tables and execution of an example control method in the DSDT. Added make=
file support for Unix generation.


--===============4194721921100074999==--

