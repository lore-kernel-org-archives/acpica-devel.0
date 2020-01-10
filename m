Content-Type: multipart/mixed; boundary="===============1936471463749770590=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20200110 released
Date: Fri, 10 Jan 2020 18:18:16 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B96C58CC@ORSMSX110.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1936471463749770590==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

10 January 2020. Summary of changes for version 20200110:

This release is available at https://acpica.org/downloads


1) ACPICA kernel-resident subsystem:

Updated all copyrights to 2020. This affects all ACPICA source code modules.


2) iASL Compiler/Disassembler and ACPICA tools:

ASL test suite (ASLTS): Updated all copyrights to 2020.

Tools and utilities: Updated all signon copyrights to 2020.

iASL: fix forward reference analysis for field declarations. Fixes forward =
reference analysis for field declarations by searching the parent scope for=
 the named object when the object is not present in the current scope.

iASL: Improved the error output for ALREADY_EXISTS errors. Now, the full pa=
thname of the name that already exists is printed.

iASL: Enhance duplicate Case() detection for buffers. Add check for buffers=
 with no initializer list (these buffers will be filled with zeros at runti=
me.)


--===============1936471463749770590==--

