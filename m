Content-Type: multipart/mixed; boundary="===============0955031944970949474=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] _REV method changed in ACPI/ACPICA
Date: Fri, 22 May 2015 15:53:07 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D2EED94@ORSMSX112.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0955031944970949474==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Recently, the _REV method in ACPICA was changed to return '2' instead of '5=
' or '6'. This is because it was discovered that some BIOS vendors are usin=
g _REV to differentiate between Linux and Windows (Windows returns '2' and =
has no plans to ever change it).

In the face of this, the ACPI Working Group decided to do the following:
1) Redefine _REV to permanently return '2'
2) Deprecate the _REV method in a future revision of the ACPI specification.

This is why ACPICA was changed _REV to return '2', and why this change shou=
ld be supported in Linux.

Bob




--===============0955031944970949474==--

