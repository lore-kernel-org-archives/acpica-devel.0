Content-Type: multipart/mixed; boundary="===============8704546111300098913=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] Fwd: question about _PTS invocation - mandatory ?
Date: Fri, 04 Jan 2013 04:24:30 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88BDD13B@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 50E3EC4E.1070908@canonical.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8704546111300098913==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> Hi,
> =

> I checked ACPI spec 5.0 and it states as below:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 7.3.2 \_PTS (Prepare To Sleep)
> The _PTS control method is executed by the OS during the sleep transition
> process for S1, S2, S3, S4, and for orderly S5 shutdown ...
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> So it seems it is mandatory.

_WAK is also mandatory.
In Linux, there are different platform ops for "suspend to mem" and "suspen=
d to disk", it's better to have an API provided by ACPICA that can be invok=
ed by both s2m and s2d.

Best regards
-Lv

> =

> On 01/02/2013 03:17 PM, Yaron Weinsberg wrote:
> > Hi Guys,
> > is it mandatory for the OSPM to invoke _PTS before switching to the S5
> > state ?
> > I've noticed that during power loss, the BIOS settings sometimes reset.
> > E.g. all user settings in the BIOS retrun to their default values.
> > Could it be related ?
> > what possibly cause the BIOS to reset its settings ? (the battery is
> > new..) thanks,
> > - Yaron
> >
> >
> >
> > _______________________________________________
> > Devel mailing list
> > Devel(a)acpica.org
> > http://lists.acpica.org/listinfo/devel
> >
> =

> =

> =

> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> http://lists.acpica.org/listinfo/devel

--===============8704546111300098913==--

