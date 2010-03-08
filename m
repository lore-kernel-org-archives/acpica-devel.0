Content-Type: multipart/mixed; boundary="===============8039131892335826195=="
MIME-Version: 1.0
From: Thomas Renninger <trenn at suse.de>
Subject: Re: [Devel] Name object change produces unexpected errors.
Date: Mon, 08 Mar 2010 10:52:00 +0100
Message-ID: <201003081052.00899.trenn@suse.de>
In-Reply-To: 1268012324.3356.7.camel@minggr.sh.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8039131892335826195==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I also run into this and I can confirm that this patch
fixes this issue.

JFI, If someone needs an rpm package of the latest acpica version
(including this fix):
http://software.opensuse.org/search?baseproject=3DopenSUSE%3AFactory&p=3D1&=
q=3Dacpica

Thanks,

     Thomas

On Monday 08 March 2010 02:38:44 Lin Ming wrote:
> On Sun, 2010-03-07 at 16:43 +0800, master chief wrote:
> > I was kind of expecting this to happen:
> > =

> > ----------------------------------------------------------------------
> > ssdt.dsl    80:             Name (_ADR, Zero)
> > Error    4080 -                            ^ Invalid object type for re=
served name, must be (Integer)
> > =

> > ssdt.dsl    81:             Name (_SUN, One)
> > Error    4080 -                           ^ Invalid object type for res=
erved name, must be (Integer)
> > =

> > ASL Input:  ssdt.dsl - 328 lines, 9645 bytes, 79 keywords
> > Compilation complete. 2 Errors, 0 Warnings, 0 Remarks, 0 Optimizations
> > ----------------------------------------------------------------------
> > =

> > But aren't the constants 'Zero' and 'One' supposed to be of type intege=
r already?
> =

> Yes, they are integer.
> There is a bug in the latest release(20100304).
> =

> > =

> > We can't use 0x00 and 0x01 here, because then we are stuck with two "Op=
timizations".  That is a no go since I have to deliver a product without er=
rors, warnings and =

optimizations.  I am confused.  What are we supposed to use now?
> > =

> =

> Would you please apply this patch or use the old release?
> =

> diff --git a/compiler/aslpredef.c b/compiler/aslpredef.c
> index 04cd2d4..30d33d5 100644
> --- a/compiler/aslpredef.c
> +++ b/compiler/aslpredef.c
> @@ -535,6 +535,9 @@ ApCheckObjectType (
>      switch (Op->Asl.ParseOpcode)
>      {
>      case PARSEOP_INTEGER:
> +    case PARSEOP_ZERO:
> +    case PARSEOP_ONE:
> +    case PARSEOP_ONES:
>          ReturnBtype =3D ACPI_RTYPE_INTEGER;
>          break;
>  =

> ---
> Lin Ming
> =

> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> http://lists.acpica.org/listinfo/devel
> =



--===============8039131892335826195==--

