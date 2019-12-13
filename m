Content-Type: multipart/mixed; boundary="===============8644085567134232027=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20191213 released
Date: Fri, 13 Dec 2019 16:29:23 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B96C0F0C@ORSMSX110.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8644085567134232027==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

13 December 2019. Summary of changes for version 20191213:

This release is available at https://acpica.org/downloads


1) ACPICA kernel-resident subsystem:

Return a Buffer object for all fields created via the CreateField operator.=
 Previously, an Integer would be returned if the size of the field was less=
 than or equal to the current size of an Integer. Although this goes agains=
t the ACPI specification, it provides compatibility with other ACPI impleme=
ntations. Also updated the ASLTS test suite to reflect this new behavior.

2) iASL Compiler/Disassembler and ACPICA tools:

iASL: Implemented detection of (and throw an error for) duplicate values fo=
r Case statements within a single Switch statement. Duplicate Integers, Str=
ings, and Buffers are supported.

iASL: Fix error logging issue during multiple file compilation -- Switch to=
 the correct input file during error node creation.

iASL: For duplicate named object creation, now emit an error instead of a w=
arning - since this will cause a runtime error.

AcpiSrc: Add unix line-ending support for non-Windows builds.

iASL: Add an error condition for an attempt to create a NameString with > 2=
55 NameSegs (the max allowable via the AML definition).

--===============8644085567134232027==--

