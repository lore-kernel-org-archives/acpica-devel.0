Content-Type: multipart/mixed; boundary="===============7548899941078001306=="
MIME-Version: 1.0
From: Jung-uk Kim <jkim at FreeBSD.org>
Subject: [Devel] _CRS/_PRS for address space range
Date: Fri, 22 Jul 2011 12:45:41 -0400
Message-ID: <201107221245.44245.jkim@FreeBSD.org>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7548899941078001306==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

ACPI Spec. 4.0a, 6.4.3.5 Address Space Range Descriptor, Table 6-40 on =

page 260 implies _LEN > 0, _MIF =3D 1, and _MAF =3D 1 is the only valid =

combination for _CRS.  However, I found a _CRS example on page, which =

has _LEN =3D _MIF =3D _MAF =3D 0.  Can you please clarify?  If the table is =

correct, iasl should have warned about it.  I think iasl currently =

treats _PRS and _CRS equally.

Jung-uk Kim

--===============7548899941078001306==--

