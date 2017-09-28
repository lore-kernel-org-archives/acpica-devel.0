Content-Type: multipart/mixed; boundary="===============9068426172242311524=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] linux-4.14-rc2/drivers/acpi/acpica/utmath.c: 2 *
 suspicious expression ?
Date: Thu, 28 Sep 2017 02:58:40 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CF6DECD@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: VI1PR0802MB2336780579C44CE8DA2DD5CF9C7A0@VI1PR0802MB2336.eurprd08.prod.outlook.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============9068426172242311524==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, David

Not a fancy way, but just a bit clearing.
OK, style is changed here:
https://github.com/acpica/acpica/pull/321
And bug is recorded here:
https://bugs.acpica.org/show_bug.cgi?id=3D1422

Thanks for the report.

Best regards
Lv

> From: David Binderman [mailto:dcb314(a)hotmail.com]
> Subject: linux-4.14-rc2/drivers/acpi/acpica/utmath.c: 2 * suspicious expr=
ession ?
> =

> Hello there,
> =

> [linux-4.14-rc2/drivers/acpi/acpica/utmath.c:137] -> [linux-4.14-rc2/driv=
ers/acpi/acpica/utmath.c:137]:
> (style) Same expression on both sides of '^=3D'.
> [linux-4.14-rc2/drivers/acpi/acpica/utmath.c:174] -> [linux-4.14-rc2/driv=
ers/acpi/acpica/utmath.c:174]:
> (style) Same expression on both sides of '^=3D'.
> =

>     operand_ovl.part.lo ^=3D operand_ovl.part.lo;
> =

> Is this just a fancy way to zero the field or should something more clever
> be happening ?
> =

> Regards
> =

> David Binderman
>=20

--===============9068426172242311524==--

