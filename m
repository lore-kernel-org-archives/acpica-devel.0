Content-Type: multipart/mixed; boundary="===============6246314955320627851=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20110413 released
Date: Wed, 13 Apr 2011 10:30:12 -0700
Message-ID: <4911F71203A09E4D9981D27F9D830858D3F47BA5@orsmsx503.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6246314955320627851==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

13 April 2011. Summary of changes for version 20110413:

This release is available at www.acpica.org/downloads

1) ACPI CA Core Subsystem:

Implemented support to execute a so-called "orphan" _REG method under the E=
C device. This change will force the execution of a _REG method underneath =
the EC device even if there is no corresponding operation region of type Em=
beddedControl. Fixes a problem seen on some machines and apparently is comp=
atible with Windows behavior. ACPICA BZ 875.

Added more predefined methods that are eligible for automatic NULL package =
element removal. This change adds another group of predefined names to the =
list of names that can be repaired by having NULL package elements dynamica=
lly removed. This group are those methods that return a single variable-len=
gth package containing simple data types such as integers, buffers, strings=
. This includes: _ALx, _BCL, _CID,_ DOD, _EDL, _FIX, _PCL, _PLD, _PMD, _PRx=
, _PSL, _Sx, and _TZD. ACPICA BZ 914.

Split and segregated all internal global lock functions to a new file, evgl=
ock.c.

Updated internal address SpaceID for DataTable regions. Moved this internal=
 space id in preparation for ACPI 5.0 changes that will include some new sp=
ace IDs. This change should not affect user/host code.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Previous Release (VC 9.0):
    Non-Debug Version:  89.8K Code, 23.8K Data, 113.6K Total
    Debug Version:     164.2K Code, 67.9K Data, 232.1K Total
  Current Release (VC 9.0):
    Non-Debug Version:  90.0K Code, 23.8K Data, 113.8K Total
    Debug Version:     164.5K Code, 68.0K Data, 232.5K Total

2) iASL Compiler/Disassembler and Tools:

iASL/DTC: Major update for new grammar features. Allow generic data types i=
n custom ACPI tables. Field names are now optional. Any line can be split t=
o multiple lines using the continuation char (\). Large buffers now use lin=
e-continuation character(s) and no colon on the continuation lines. See the=
 grammar update in the iASL compiler reference. ACPI BZ 910,911. Lin Ming, =
Bob Moore.

iASL: Mark ASL "Return()" and the simple "Return" as "Null" return statemen=
ts. Since the parser stuffs a "zero" as the return value for these statemen=
ts (due to the underlying AML grammar), they were seen as "return with valu=
e" by the iASL semantic checking. They are now seen correctly as "null" ret=
urn statements.

iASL: Check if a_REG declaration has a corresponding Operation Region. Adds=
 a check for each _REG to ensure that there is in fact a corresponding oper=
ation region declaration in the same scope. If not, the _REG method is not =
very useful since it probably won't be executed. ACPICA BZ 915.

iASL/DTC: Finish support for expression evaluation. Added a new expression =
parser that implements c-style operator precedence and parenthesization. AC=
PICA bugzilla 908.

Disassembler/DTC: Remove support for () and <> style comments in data table=
s. Now that DTC has full expression support, we don't want to have comment =
strings that start with a parentheses or a less-than symbol. Now, only the =
standard /* and // comments are supported, as well as the bracket [] commen=
ts.

AcpiXtract: Fix for RSDP and dynamic SSDT extraction. These tables have "un=
usual" headers in the acpidump file. Update the header validation to suppor=
t these tables. Problem introduced in previous AcpiXtract version in the ch=
ange to support "wrong checksum" error messages emitted by acpidump utility.

iASL: Add a * option to generate all template files (as a synonym for ALL) =
as in "iasl -T *" or "iasl -T ALL".

iASL/DTC: Do not abort compiler on fatal errors. We do not want to complete=
ly abort the compiler on "fatal" errors, simply should abort the current co=
mpile. This allows multiple compiles with a single (possibly wildcard) comp=
iler invocation.


--===============6246314955320627851==--

