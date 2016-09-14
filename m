Content-Type: multipart/mixed; boundary="===============7059548877299099093=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA / Interpreter: Remove redundant newline
Date: Wed, 14 Sep 2016 14:03:42 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E4FC413@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 1AE640813FDE7649BE1B193DEA596E886A1849EF@SHSMSX101.ccr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7059548877299099093==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Zheng, Lv
> Sent: Tuesday, September 13, 2016 8:11 PM
> To: Moore, Robert <robert.moore(a)intel.com>; Moore, Robert
> <robert.moore(a)intel.com>; Borislav Petkov <bp(a)alien8.de>; LKML <linux-
> kernel(a)vger.kernel.org>
> Cc: linux-acpi(a)vger.kernel.org; devel(a)acpica.org; Wysocki, Rafael J
> <rafael.j.wysocki(a)intel.com>; Box, David E <david.e.box(a)intel.com>
> Subject: RE: [PATCH] ACPICA / Interpreter: Remove redundant newline
> =

> Hi,
> =

> > From: linux-acpi-owner(a)vger.kernel.org
> > [mailto:linux-acpi-owner(a)vger.kernel.org] On Behalf Of Moore, Robert
> > David E <david.e.box(a)intel.com>
> > Subject: RE: [PATCH] ACPICA / Interpreter: Remove redundant newline
> >
> > Well, I never thought I would write a couple lines of code like this,
> > but here is a solution that should make everyone happy.
> >
> > diff --git a/source/components/tables/tbxfload.c
> > b/source/components/tables/tbxfload.c
> > index 6a937b1..73ee1a2 100644
> > --- a/source/components/tables/tbxfload.c
> > +++ b/source/components/tables/tbxfload.c
> > @@ -334,7 +334,7 @@ AcpiTbLoadNamespace (
> >      if (!TablesFailed)
> >      {
> >          ACPI_INFO ((
> > -            "%u ACPI AML tables successfully acquired and loaded\n",
> > +            "%u ACPI AML tables successfully acquired and loaded",
> >              TablesLoaded));
> >      }
> >      else
> > @@ -348,6 +348,11 @@ AcpiTbLoadNamespace (
> >          Status =3D AE_CTRL_TERMINATE;
> >      }
> >
> > +#ifdef ACPI_APPLICATION
> > +    ACPI_DEBUG_PRINT_RAW ((ACPI_DB_INIT, "\n")); #endif
> > +
> > +
> =

[Moore, Robert] =


I have no problem with this, I just want to get it over with.
It is not a big deal, let's leave it at that and not make it a big issue.





> IMO, these lines should be in ACPICA upstream, in a file under
> tools/acpiexec.
> =

> Thanks
> Lv
> =

> >  UnlockAndExit:
> >      (void) AcpiUtReleaseMutex (ACPI_MTX_TABLES);
> >      return_ACPI_STATUS (Status);
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi"
> > in the body of a message to majordomo(a)vger.kernel.org More majordomo
> > info at  http://vger.kernel.org/majordomo-info.html

--===============7059548877299099093==--

