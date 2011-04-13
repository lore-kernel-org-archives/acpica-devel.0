Content-Type: multipart/mixed; boundary="===============8927067478744343134=="
MIME-Version: 1.0
From: Jung-uk Kim <jkim at FreeBSD.org>
Subject: Re: [Devel] ACPICA version 20110413 released
Date: Wed, 13 Apr 2011 19:32:56 -0400
Message-ID: <201104131932.59163.jkim@FreeBSD.org>
In-Reply-To: 4911F71203A09E4D9981D27F9D830858D3F47BA5@orsmsx503.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8927067478744343134==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wednesday 13 April 2011 01:30 pm, Moore, Robert wrote:
> 13 April 2011. Summary of changes for version 20110413:
>
> This release is available at www.acpica.org/downloads
>
> 1) ACPI CA Core Subsystem:
>
> Implemented support to execute a so-called "orphan" _REG method
> under the EC device. This change will force the execution of a _REG
> method underneath the EC device even if there is no corresponding
> operation region of type EmbeddedControl. Fixes a problem seen on
> some machines and apparently is compatible with Windows behavior.
> ACPICA BZ 875.
>
> Added more predefined methods that are eligible for automatic NULL
> package element removal. This change adds another group of
> predefined names to the list of names that can be repaired by
> having NULL package elements dynamically removed. This group are
> those methods that return a single variable-length package
> containing simple data types such as integers, buffers, strings.
> This includes: _ALx, _BCL, _CID,_ DOD, _EDL, _FIX, _PCL, _PLD,
> _PMD, _PRx, _PSL, _Sx, and _TZD. ACPICA BZ 914.
>
> Split and segregated all internal global lock functions to a new
> file, evglock.c.
>
> Updated internal address SpaceID for DataTable regions. Moved this
> internal space id in preparation for ACPI 5.0 changes that will
> include some new space IDs. This change should not affect user/host
> code.
>
> Example Code and Data Size: These are the sizes for the
> OS-independent acpica.lib produced by the Microsoft Visual C++ 9.0
> 32-bit compiler. The debug version of the code includes the debug
> output trace mechanism and has a much larger code and data size.
>
>   Previous Release (VC 9.0):
>     Non-Debug Version:  89.8K Code, 23.8K Data, 113.6K Total
>     Debug Version:     164.2K Code, 67.9K Data, 232.1K Total
>   Current Release (VC 9.0):
>     Non-Debug Version:  90.0K Code, 23.8K Data, 113.8K Total
>     Debug Version:     164.5K Code, 68.0K Data, 232.5K Total
>
> 2) iASL Compiler/Disassembler and Tools:
>
> iASL/DTC: Major update for new grammar features. Allow generic data
> types in custom ACPI tables. Field names are now optional. Any line
> can be split to multiple lines using the continuation char (\).
> Large buffers now use line-continuation character(s) and no colon
> on the continuation lines. See the grammar update in the iASL
> compiler reference. ACPI BZ 910,911. Lin Ming, Bob Moore.
>
> iASL: Mark ASL "Return()" and the simple "Return" as "Null" return
> statements. Since the parser stuffs a "zero" as the return value
> for these statements (due to the underlying AML grammar), they were
> seen as "return with value" by the iASL semantic checking. They are
> now seen correctly as "null" return statements.
>
> iASL: Check if a_REG declaration has a corresponding Operation
> Region. Adds a check for each _REG to ensure that there is in fact
> a corresponding operation region declaration in the same scope. If
> not, the _REG method is not very useful since it probably won't be
> executed. ACPICA BZ 915.
>
> iASL/DTC: Finish support for expression evaluation. Added a new
> expression parser that implements c-style operator precedence and
> parenthesization. ACPICA bugzilla 908.
>
> Disassembler/DTC: Remove support for () and <> style comments in
> data tables. Now that DTC has full expression support, we don't
> want to have comment strings that start with a parentheses or a
> less-than symbol. Now, only the standard /* and // comments are
> supported, as well as the bracket [] comments.
>
> AcpiXtract: Fix for RSDP and dynamic SSDT extraction. These tables
> have "unusual" headers in the acpidump file. Update the header
> validation to support these tables. Problem introduced in previous
> AcpiXtract version in the change to support "wrong checksum" error
> messages emitted by acpidump utility.
>
> iASL: Add a * option to generate all template files (as a synonym
> for ALL) as in "iasl -T *" or "iasl -T ALL".
>
> iASL/DTC: Do not abort compiler on fatal errors. We do not want to
> completely abort the compiler on "fatal" errors, simply should
> abort the current compile. This allows multiple compiles with a
> single (possibly wildcard) compiler invocation.

iASL doesn't build on BSD any more.  Please see the attached patch.

Makefile:	Fix object dependencies and fix "clean" target.
dtparser.l:	Add missing EOF.
dtparser.y:	Declare DtParserparse() properly and fix yytname.

Jung-uk Kim

--===============8927067478744343134==
Content-Type: text/plain
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="iasl.diff"

LS0tIGNvbXBpbGVyL01ha2VmaWxlCTIwMTEtMDQtMTMgMTI6NTY6MjAuMDAwMDAwMDAwIC0wNDAw
CisrKyBjb21waWxlci9NYWtlZmlsZQkyMDExLTA0LTEzIDE3OjMzOjUyLjAwMDAwMDAwMCAtMDQw
MApAQCAtMTY2LDExICsxNjYsMTUgQEAgT0JKUyA9IFwKIAogSU5URVJNRURJQVRFUyA9IFwKIAlh
c2xjb21waWxlcmxleC5jIFwKLQlhc2xjb21waWxlcnBhcnNlLmMKKwlhc2xjb21waWxlcnBhcnNl
LmMgXAorCWR0cGFyc2VybGV4LmMgXAorCWR0cGFyc2VycGFyc2UuYwogCiBNSVNDID0gXAogCWFz
bGNvbXBpbGVyLnkuaCBcCi0JYXNsY29tcGlsZXJwYXJzZS5vdXRwdXQKKwlhc2xjb21waWxlcnBh
cnNlLm91dHB1dCBcCisJZHRwYXJzZXIueS5oIFwKKwlkdHBhcnNlcnBhcnNlLm91dHB1dAogCiAK
ICMKLS0tIGNvbXBpbGVyL2R0cGFyc2VyLmwJMjAxMS0wNC0xMyAxMjo1NjoxOS4wMDAwMDAwMDAg
LTA0MDAKKysrIGNvbXBpbGVyL2R0cGFyc2VyLmwJMjAxMS0wNC0xMyAxNjozNTozNi4wMDAwMDAw
MDAgLTA0MDAKQEAgLTEzMCw0ICsxMzAsNCBAQCBEdFRlcm1pbmF0ZUxleGVyICgKIHsKIAogICAg
IHl5X2RlbGV0ZV9idWZmZXIgKExleEJ1ZmZlcik7Ci19ClwgTm8gbmV3bGluZSBhdCBlbmQgb2Yg
ZmlsZQorfQotLS0gY29tcGlsZXIvZHRwYXJzZXIueQkyMDExLTA0LTEzIDEyOjU2OjE5LjAwMDAw
MDAwMCAtMDQwMAorKysgY29tcGlsZXIvZHRwYXJzZXIueQkyMDExLTA0LTEzIDE5OjIyOjQzLjAw
MDAwMDAwMCAtMDQwMApAQCAtNTMsNyArNTMsOCBAQAogCiBVSU5UNjQgICAgICAgICAgICAgICAg
ICBEdFBhcnNlclJlc3VsdDsgICAgLyogR2xvYmFsIGZvciBleHByZXNzaW9uIHJldHVybiB2YWx1
ZSAqLwogCi1pbnQgRHRQYXJzZXJsZXggKHZvaWQpOyAvKiBUQkQ6IG5vdCBzdXJlIHdoeSB0aGlz
IGlzIG5lZWRlZCAqLworaW50IER0UGFyc2VybGV4ICh2b2lkKTsKK2ludCBEdFBhcnNlcnBhcnNl
ICh2b2lkKTsKIGV4dGVybiBjaGFyKiAgICAgICAgICAgIER0UGFyc2VydGV4dDsKIGV4dGVybiB2
b2lkICAgICAgICAgICAgIER0UGFyc2VyZXJyb3IgKGNoYXIgY29uc3QgKiBtc2cpOwogI2RlZmlu
ZSBZWUZMQUcgICAgICAgICAgLTMyNzY4CkBAIC0xNzEsNyArMTcyLDcgQEAgZXh0ZXJuIERUX0ZJ
RUxEICAgICAgICAgICAgICAgICAqR2JsX0N1cgogI2RlZmluZSBQUl9ZWVROQU1FX1NUQVJUICAg
ICAgICAzCiAKICNpZmRlZiBfVVNFX0JFUktFTEVZX1lBQ0MKLSNkZWZpbmUgeXl0bmFtZSBEdFBh
cnNlcm5hbWVbXTsKKyNkZWZpbmUgeXl0bmFtZSBEdFBhcnNlcm5hbWUKICNlbmRpZgogCiAK

--===============8927067478744343134==--

