Content-Type: multipart/mixed; boundary="===============7411397298666002943=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20200430 released 
Date: Thu, 30 Apr 2020 16:40:14 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3C68BD11C@ORSMSX110.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7411397298666002943==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

30 April 2020. Summary of changes for version 20200430:

This release is available at https://acpica.org/downloads


1) ACPICA kernel-resident subsystem:

Cleaned up the coding style of a couple of global variables (AcpiGbl_NextCm=
dNum and AcpiProtocolLengths) caught by static analyzers. AcpiProtocolLengt=
hs was made static, and the definition of AcpiGbl_NextCmdNum was moved to a=
cglobal.h.


2) iASL Compiler/Disassembler and ACPICA tools: =


iASL DataTable Compiler:  Fixed a segfault on errors that aren't directly a=
ssociated with a field.

Disassembler: has been made more resilient so that it will continue to pars=
e AML even if it the AML generates ACPI namespace errors. This enables iASL=
 to disassemble some AML that may have been compiled using older versions o=
f iASL that no longer compile with newer versions of iASL.

iASL: Fixed the required parameters for _NIH and _NIG. Previously, there wa=
s a mixup where _NIG required one parameter and _NIH required zero paramete=
rs. This change swaps these parameter requirements. Now it is required that=
 _NIH must be called with one parameter and _NIG requires zero parameters.

iASL: Allow use of undefined externals as long as they are protected by an =
if (CondRefOf (...)) block when compiling multiple definition blocks.

iASL: Fixed the type override behavior of named objects that are declared a=
s External. External declarations will no longer override the type of the a=
ctual definition if it already exists.

AcpiNames: Added setargv.obj to the MSVC 2017 link sequence to enable comma=
nd line wildcard support on Windows. Note: the AcpiNames utility is essenti=
ally redundant with the AcpiExec utility (using the "namespace" command) an=
d is therefore deprecated. It will be removed in future releases of ACPICA.

Disassembler: ignore AE_ALREADY_EXISTS status when parsing create* operator=
s. The disassembler is intended to emit existing ASL code as-is. Therefore,=
 error messages emitted during disassembly should be ignored or handled in =
a way such that the disassembler can continue to parse the AML. This change=
 ignores AE_ALREADY_EXISTS errors during the deferred Op parsing for create=
 operators in order to complete parsing ASL termlists.

iASL DataTable Compiler: IVRS table: fix potentially uninitialized variable=
 warning. Some compilers catch potential uninitialized variables. This is d=
one by examining branches of if/else statements. This change replaces an "e=
lse if" with an "else" to fix the uninitialized variable warning.

--===============7411397298666002943==--

