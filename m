Content-Type: multipart/mixed; boundary="===============4171058387139490905=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20200326 released
Date: Thu, 26 Mar 2020 20:50:41 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B96FCF7E@ORSMSX110.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4171058387139490905==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

26 March 2020. Summary of changes for version 20200326:

This release is available at https://acpica.org/downloads


1) ACPICA kernel-resident subsystem:

Performed a code clean-up to prevent build errors on early versions of GCC-=
10.

Added the NHLT table signature. iASL data table compiler/disassembler suppo=
rt for this table is coming soon.


2) iASL Compiler/Disassembler and ACPICA tools: =


AcpiExec: Fixed several problems with the namespace initialization file (-f=
i<filename> option). Includes fixes to prevent AE_ALREADY_EXISTS errors, se=
veral seg faults, and enhancements to line parsing within the init file. In=
 addition, each object found in the init file and it's new value is display=
ed, as well as any such entries that do not have a corresponding name in th=
e namespace. For reference, the syntax for the various supported data types=
 are presented below
	PCHG 0x777788889999BBBB	// Integer
	\DEV1.STR1 "XYZ"		// String
	BUF1 (88 99 AA)		// Buffer
	PKG1 [0x1111 0x2222]		// Package
	\BF1 0x7980			// BufferField
	RCRV 0x0123456789ABCDEF	// Field Unit

iASL: Added a custom iASL macro __EXPECT__(iASL-Error-Code). This macro can=
 be used anywhere in a given ASL file to configure iASL to expect an iASL c=
ompiler error code on the line where this macro was placed. If the error co=
de does not exist, an error is generated. This is intended to be used for A=
CPICA's ASL test suite, but can be used by ASL developers as well.

iASL: table compiler: Implemented IVRS IVHD type 11h parsing. The AMD IVRS =
table parsing supported only IVHD type 10h structures. Parsing an IVHD type=
 11h caused the iasl to report unknown subtable type. Add necessary structu=
re definition for IVHD type 11h and apply correct parsing method based on s=
ubtable type. Micha=C5=82 =C5=BBygowski.

iASL: table compiler: Fixed IVRS table IVHD type 10h reserved field name Ac=
cording to AMD IOMMU Specification Revision 3.05 the reserved field should =
be IOMMU Feature Reporting. Change the name of the field to the correct one=
. Micha=C5=82 =C5=BBygowski.

acpiexec: removed redeclaration of AcpiGbl_DbOpt_NoRegionSupport. Patch bas=
ed on suggestions by David Seifert and Benjamin Berg.

iASL: table compiler: removed unused variable (DtCompilerParserResult) caus=
ing linking errors. Patch based on suggestions by David Seifert and Benjami=
n Berg.

iASL: table compiler: make LexBuffer static to avoid linking errors in newe=
r compilers. Patch based on suggestions by David Seifert and Benjamin Berg.

iASL: fixed type matching between External and Named objects. External obje=
ct types can only be expressed with ACPI object type values that are define=
d in the ACPI spec. However, iASL uses ACPI object type values that are loc=
al to ACPICA in addition to the values defined in the ACPI spec. This chang=
e implements type matching to map some object type values specific to ACPIC=
A to ones that are defined in the ACPI spec.

iASL: Droped the type mismatch compiler error that can arise from External =
declarations to a warning. This warning can occur when there is a type diff=
erence between the external declaration and the actual object declaration (=
when compiling multiple files/modules simultaneously).

iASL: removed an incorrect error message regarding externals. This change r=
emoves an incorrect error that is emitted when a duplicate external declara=
tion does not contain a type that opens a scope. This is incorrect because =
the duplicate external with conflicting types are already caught by iASL an=
d it doesn't make any sense to enforce what this conflicting type should be.

AcpiXtract: fix AX_IS_TABLE_BLOCK_HEADER macro. This macro needs to be surr=
ounded by parens. Otherwise, a logical statement that applies a logical not=
 operator to this macros could result in a computation that applies the ope=
rator to the left side of the logical and but not the right. Reported-by: J=
ohn Levon <john.levon(a)joyent.com>

Fixed a problem with the local version of sprint(): On 32-bit, the provided=
 sprintf() is non-functional: with a size of ACPI_UINT32_MAX, String + Size=
 will wrap, meaning End < Start, and AcpiUtBoundStringOutput() will never o=
utput anything as a result. The symptom seen of this was acpixtract failing=
 to output anything -- with a custom build that included utprint.c. Signed-=
off-by: John Levon <john.levon(a)joyent.com>

iASL: Changed the "PlatformCommChannel" ASL keyword to "PCC", as per the AC=
PI specification.

--===============4171058387139490905==--

