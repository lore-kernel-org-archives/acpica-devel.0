Content-Type: multipart/mixed; boundary="===============0518216747824234959=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20171214 released
Date: Thu, 14 Dec 2017 22:13:59 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B74FC7D7@ORSMSX110.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0518216747824234959==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

14 December 2017. Summary of changes for version 20171214:

This release is available at https://acpica.org/downloads


1) ACPICA kernel-resident subsystem:

Fixed a regression in the external (public) AcpiEvaluateObjectTyped interfa=
ce where the optional "pathname" argument had inadvertently become a requir=
ed argument returning an error if omitted (NULL pointer argument).

Fixed two possible memory leaks related to the recently developed "late res=
olution" of reference objects within ASL Package Object definitions.

Added two recently defined _OSI strings: "Windows 2016" and "Windows 2017".=
 Mario Limonciello.

Implemented and deployed a safer version of the C library function strncpy:=
  AcpiUtSafeStrncpy. The intent is to at least prevent the creation of unte=
rminated strings as a possible result of a standard strncpy.

Cleaned up and restructured the global variable file (acglobal.h). There ar=
e many changes, but no functional changes.


2) iASL Compiler/Disassembler and Tools:

iASL Table Compiler: Fixed a problem with the DBG2 ACPI table where the opt=
ional OemData field at the end of the table was incorrectly required for pr=
oper compilation. It is now correctly an optional field.

ASLTS: The entire suite was converted from standard ASL to the ASL+ languag=
e, using the ASL-to-ASL+ converter which is integrated into the iASL compil=
er. A binary compare of all output files has verified the correctness of th=
e conversion.

iASL: Fixed the source code build for platforms where "char" is unsigned. T=
his affected the iASL lexer only. Jung-uk Kim.



--===============0518216747824234959==--

