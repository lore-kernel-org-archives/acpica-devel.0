Content-Type: multipart/mixed; boundary="===============6548693321017629936=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: Remove unnecessary '\n' in the end of
 ACPI_INFO output
Date: Mon, 08 Aug 2016 21:38:41 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E4DE3BA@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 1AE640813FDE7649BE1B193DEA596E883BC0AEDE@SHSMSX101.ccr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6548693321017629936==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I put that \n in there to break up the output from AcpiExec. This comes up =
every year or so, I think I'll give up -- without really seeing the harm in=
 an extra \n.



> -----Original Message-----
> From: Zheng, Lv
> Sent: Sunday, August 7, 2016 5:56 PM
> To: Alexander Kuleshov <kuleshovmail(a)gmail.com>; Moore, Robert
> <robert.moore(a)intel.com>
> Cc: Wysocki, Rafael J <rafael.j.wysocki(a)intel.com>; Len Brown
> <lenb(a)kernel.org>; linux-acpi(a)vger.kernel.org; devel(a)acpica.org; li=
nux-
> kernel(a)vger.kernel.org
> Subject: RE: [PATCH] ACPICA: Remove unnecessary '\n' in the end of
> ACPI_INFO output
> =

> > From: Alexander Kuleshov [mailto:kuleshovmail(a)gmail.com]
> > Subject: [PATCH] ACPICA: Remove unnecessary '\n' in the end of
> > ACPI_INFO output
> >
> > as the ACPI_INFO already prints `\n` in the end itself.
> [Lv Zheng]
> Looks good.
> Acked-by: Lv Zheng <lv.zheng(a)intel.com>
> However this patch should go through ACPICA upstream.
> =

> Thanks
> -Lv
> =

> >
> > Signed-off-by: Alexander Kuleshov <kuleshovmail(a)gmail.com>
> > ---
> >  drivers/acpi/acpica/tbxfload.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/acpica/tbxfload.c
> > b/drivers/acpi/acpica/tbxfload.c index ac71abc..e7119b7 100644
> > --- a/drivers/acpi/acpica/tbxfload.c
> > +++ b/drivers/acpi/acpica/tbxfload.c
> > @@ -240,7 +240,7 @@ acpi_status acpi_tb_load_namespace(void)
> >  	}
> >
> >  	if (!tables_failed) {
> > -		ACPI_INFO(("%u ACPI AML tables successfully acquired and
> > loaded\n", tables_loaded));
> > +		ACPI_INFO(("%u ACPI AML tables successfully acquired and
> > loaded", tables_loaded));
> >  	} else {
> >  		ACPI_ERROR((AE_INFO,
> >  			    "%u table load failures, %u successful",
> > --
> > 2.8.0.rc3.1353.gea9bdc0


--===============6548693321017629936==--

