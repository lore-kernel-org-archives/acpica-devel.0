Content-Type: multipart/mixed; boundary="===============8307260929090230121=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20180209 released
Date: Fri, 09 Feb 2018 17:33:52 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B7571335@ORSMSX110.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8307260929090230121==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

09 February 2018. Summary of changes for version 20180209:

This release is available at https://acpica.org/downloads


1) ACPICA kernel-resident subsystem:

Completed the final integration of the recent changes to Package Object han=
dling and the module-level AML code support. This allows forward references=
 from individual package elements when the package object is declared from =
within module-level code blocks. Provides compatibility with other ACPI imp=
lementations.

The new architecture for the AML module-level code has been completed and i=
s now the default for the ACPICA code. This new architecture executes the m=
odule-level code in-line as the ACPI table is loaded/parsed instead of the =
previous architecture which deferred this code until after the table was fu=
lly loaded. This solves some ASL code ordering issues and provides compatib=
ility with other ACPI implementations. At this time, there is an option to =
fallback to the earlier architecture, but this support is deprecated and is=
 planned to be completely removed later this year.

Added a compile-time option to ignore AE_NOT_FOUND exceptions during resolu=
tion of named reference elements within Package objects. Although this is p=
otentially a serious problem, it can generate a lot of noise/errors on plat=
forms whose firmware carries around a bunch of unused Package objects. To d=
isable these errors, define ACPI_IGNORE_PACKAGE_RESOLUTION_ERRORS in the OS=
-specific header. All errors are always reported for ACPICA applications su=
ch as AcpiExec.

Fixed a regression related to the explicit type-conversion AML operators (T=
oXXXX). The regression was introduced early in 2017 but was not seen until =
recently because these operators are not fully supported by other ACPI impl=
ementations and are thus rarely used by firmware developers. The operators =
are defined by the ACPI specification to not implement the "implicit result=
 object conversion". The regression incorrectly introduced this object conv=
ersion for the following explicit conversion operators:
    ToInteger
    ToString
    ToBuffer
    ToDecimalString
    ToHexString
    ToBCD
    FromBCD


2) iASL Compiler/Disassembler and Tools:

iASL: Fixed a problem with the compiler constant folding feature as related=
 to the ToXXXX explicit conversion operators. These operators do not suppor=
t the "implicit result object conversion" by definition. Thus, ASL expressi=
ons that use these operators cannot be folded to a simple Store operator be=
cause Store implements the implicit conversion. This change uses the CopyOb=
ject operator for the ToXXXX operator folding instead. CopyObject is define=
d to not implement implicit result conversions and is thus appropriate for =
folding the ToXXXX operators.

iASL: Changed the severity of an error condition to a simple warning for th=
e case where a symbol is declared both locally and as an external symbol. T=
his accommodates existing ASL code.

AcpiExec: The -ep option to enable the new architecture for module-level co=
de has been removed. It is replaced by the -dp option which instead has the=
 opposite effect: it disables the new architecture (the default) and enable=
s the legacy architecture. When the legacy code is removed in the future, t=
he -dp option will be removed also.



--===============8307260929090230121==--

