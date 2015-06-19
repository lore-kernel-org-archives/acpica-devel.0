Content-Type: multipart/mixed; boundary="===============7798446171685889575=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20150619 released
Date: Fri, 19 Jun 2015 14:15:23 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D3037D9@ORSMSX112.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7798446171685889575==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

19 June 2015. Summary of changes for version 20150619:

This release is available at https://acpica.org/downloads

Two regressions in version 20150616 have been addressed:

Fixes some problems/issues with the C library macro removal (ACPI_STRLEN, e=
tc.) This update changes ACPICA to only use the standard headers for functi=
ons, or (optionally) the local prototypes for the local versions of the C l=
ibrary functions. Across the source code, this required some additional cas=
ts for some Clib invocations for portability. Moved all local prototypes to=
 a new file, acclib.h

Fixes several problems with recent changes to the handling of the FACS tabl=
e that could cause some systems not to boot.



--===============7798446171685889575==--

