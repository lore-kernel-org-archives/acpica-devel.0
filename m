Content-Type: multipart/mixed; boundary="===============6701647715395028153=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] acpica: fix -Wnull-pointer-arithmetic warnings
Date: Wed, 24 Jul 2019 14:17:00 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B96618DB@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 1563975605.11067.8.camel@lca.pw
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6701647715395028153==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



-----Original Message-----
From: Qian Cai [mailto:cai(a)lca.pw] =

Sent: Wednesday, July 24, 2019 6:40 AM
To: Moore, Robert <robert.moore(a)intel.com>; Nick Desaulniers <ndesaulnier=
s(a)google.com>
Cc: Wysocki, Rafael J <rafael.j.wysocki(a)intel.com>; Schmauss, Erik <erik.=
schmauss(a)intel.com>; jkim(a)freebsd.org; Len Brown <lenb(a)kernel.org>; l=
inux-acpi(a)vger.kernel.org; devel(a)acpica.org; clang-built-linux <clang-b=
uilt-linux(a)googlegroups.com>; LKML <linux-kernel(a)vger.kernel.org>
Subject: Re: [PATCH] acpica: fix -Wnull-pointer-arithmetic warnings

On Tue, 2019-07-23 at 20:49 +0000, Moore, Robert wrote:
> > > Signed-off-by: Qian Cai <cai(a)lca.pw>
> > > ---
> > > include/acpi/actypes.h | 4 ++--
> > > 1 file changed, 2 insertions(+), 2 deletions(-)
> > > =

> > > diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h index
> > > ad6892a24015..25b4a32da177 100644
> > > --- a/include/acpi/actypes.h
> > > +++ b/include/acpi/actypes.h
> > > @@ -500,13 +500,13 @@ typedef u64 acpi_integer;
> > > =

> > > #define ACPI_CAST_PTR(t, p)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0((t *) (acpi_uintptr_t) =

> > > (p)) #define ACPI_CAST_INDIRECT_PTR(t, p)=C2=A0=C2=A0=C2=A0=C2=A0((t =
**) =

> > > (acpi_uintptr_t) (p)) -#define ACPI_ADD_PTR(t, a, b)=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > ACPI_CAST_PTR (t, (ACPI_CAST_PTR (u8, (a)) + (acpi_size)(b)))
> > > +#define ACPI_ADD_PTR(t, a, b)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0ACPI_CAST_PTR (t, (a) +
> > > (acpi_size)(b))
> =

> We have some questions concerning this change. If (a) is not cast to a =

> u8, the addition will be in whatever units are appropriate for (a) =

> i.e., the type of (a). However, we want ACPI_ADD_PTR (And =

> ACPI_SUB_PTR) to simply perform a byte addition or subtraction - thus =

> the cast to u8. I believe that is the original thinking behind the macros.

I posted a v2 a while ago, and should clear this concern.

OK then this change only affects ACPI_TO_POINTER?

+#define ACPI_TO_POINTER(i)              ACPI_CAST_PTR (void, i)


> =

> > > #define ACPI_SUB_PTR(t, a, b)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0ACPI_CAST_PTR (t, =

> > > (ACPI_CAST_PTR (u8, (a)) - (acpi_size)(b))) #define =

> > > ACPI_PTR_DIFF(a, b)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0((acpi_size) (ACPI_CAST_PTR (u8,
> > > (a)) - ACPI_CAST_PTR (u8, (b))))
> > > =

> > > /* Pointer/Integer type conversions */
> > > =

> > > -#define ACPI_TO_POINTER(i)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ACPI_ADD_PTR (void, (void =

> > > *) 0,
> > > (acpi_size) (i))
> > > +#define ACPI_TO_POINTER(i)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ACPI_ADD_PTR (void, 0,
> > > (acpi_size) (i))
> > =

> > IIUC, these are adding `i` to NULL (or (void*)0)? X + 0 =3D=3D X ?
> > --
> > Thanks,
> > ~Nick Desaulniers
> =

>=20

--===============6701647715395028153==--

