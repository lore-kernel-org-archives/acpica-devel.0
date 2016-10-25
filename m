Content-Type: multipart/mixed; boundary="===============1437247483651209731=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] 4.9-rc1: [TMP_] ACPI namespace lookup failure,
 AE_ALREADY_EXISTS
Date: Tue, 25 Oct 2016 14:26:34 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886A259D4B@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 1477399707.11683.14.camel@intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1437247483651209731==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, Imre

> From: Deak, Imre
> Subject: Re: 4.9-rc1: [TMP_] ACPI namespace lookup failure, AE_ALREADY_EX=
ISTS
> =

> On ti, 2016-10-25 at 04:14 +0300, Zheng, Lv wrote:
> > Hi, Imre
> >
> > I think this is the root cause fix:
> > https://github.com/zetalog/linux/commit/108009d0
> > Which seems to be an old trap triggered by the good fix.
> >
> > Could you give the fix commit a try?
> > It=E2=80=99s better to use this branch, where more improvements are inc=
luded:
> > git clone linux-acpica https://github.com/zetalog/linux
> > git branch acpica-lock linux-acpica/acpica-lock
> > git checkout acpica-lock
> =

> Yes, with the above branch I couldn't reproduce the problem during
> suspend/resume while reverting 108009d0 made the problem reappear.

Thanks for the bug report.
I've sent the patches to the ACPI mailinglist.

Best regards
Lv

--===============1437247483651209731==--

