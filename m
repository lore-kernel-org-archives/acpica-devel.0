Content-Type: multipart/mixed; boundary="===============7188735048441151678=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: remove duplicate u8 typedef
Date: Wed, 29 Apr 2015 00:29:44 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E880270FB14@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 1624281.lNzTEna4Ru@vostro.rjw.lan
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7188735048441151678==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> From: Rafael J. Wysocki [mailto:rjw(a)rjwysocki.net]
> Sent: Wednesday, April 29, 2015 8:44 AM
> Subject: Re: [PATCH] ACPICA: remove duplicate u8 typedef
> =

> On Tuesday, April 28, 2015 04:54:04 PM Olaf Hering wrote:
> > During commit e252652fb2664d42de19f933aa3688bbc470de3f ("ACPICA:
> > acpidump: Remove integer types translation protection.") two 'unsigned
> > char' types got converted to 'u8'.
> >
> > The result does not compile with gcc-4.5, it can not cope with duplicate
> > typedefs.
> >
> > Signed-off-by: Olaf Hering <olaf(a)aepfle.de>
> =

> Applied, thanks!
> =

> Lv, can you please see if that's an upstream issue too?

In ACPICA, one u8 is UINT8 and the other is for BOOLEAN.
Pleas merge this first.
I'll think about a solution to reduce this divergence.

Thanks and best regards
-Lv

> =

> > ---
> >  include/acpi/actypes.h | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
> > index f5ca0e9..1c3002e 100644
> > --- a/include/acpi/actypes.h
> > +++ b/include/acpi/actypes.h
> > @@ -124,7 +124,6 @@
> >  #ifndef ACPI_USE_SYSTEM_INTTYPES
> >
> >  typedef unsigned char u8;
> > -typedef unsigned char u8;
> >  typedef unsigned short u16;
> >  typedef short s16;
> >  typedef COMPILER_DEPENDENT_UINT64 u64;
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo(a)vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> =

> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.

--===============7188735048441151678==--

