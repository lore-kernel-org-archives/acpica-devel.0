Content-Type: multipart/mixed; boundary="===============4019589153045792046=="
MIME-Version: 1.0
From: Jung-uk Kim <jkim at FreeBSD.org>
Subject: Re: [Devel] _CRS/_PRS for address space range
Date: Fri, 22 Jul 2011 14:43:37 -0400
Message-ID: <201107221443.40077.jkim@FreeBSD.org>
In-Reply-To: 201107221245.44245.jkim@FreeBSD.org
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4019589153045792046==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Friday 22 July 2011 12:45 pm, Jung-uk Kim wrote:
> ACPI Spec. 4.0a, 6.4.3.5 Address Space Range Descriptor, Table 6-40
> on page 260 implies _LEN > 0, _MIF =3D 1, and _MAF =3D 1 is the only
> valid combination for _CRS.  However, I found a _CRS example on
> page, which has _LEN =3D _MIF =3D _MAF =3D 0.  Can you please clarify? =

> If the table is correct, iasl should have warned about it.  I think
> iasl currently treats _PRS and _CRS equally.

John Baldwin <jhb(a)FreeBSD.org> pointed out iASL's address space range =

check introduced in ACPI-CA 20100428 is just bogus.  It is often =

times dynamically recalculated from a template.  Therefore, OS must =

do the sanity check at *runtime*, at least for _CRS.

Jung-uk Kim

--===============4019589153045792046==--

