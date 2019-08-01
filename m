Content-Type: multipart/mixed; boundary="===============6523675307608331663=="
MIME-Version: 1.0
From: Schmauss, Erik <erik.schmauss at intel.com>
Subject: Re: [Devel] [PATCH v2] acpica: fix -Wnull-pointer-arithmetic warnings
Date: Thu, 01 Aug 2019 20:17:55 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53C618109@ORSMSX122.amr.corp.intel.com>
In-Reply-To: 1564686979.11067.48.camel@lca.pw
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6523675307608331663==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Qian Cai [mailto:cai(a)lca.pw]
> Sent: Thursday, August 1, 2019 12:16 PM
> To: Moore, Robert <robert.moore(a)intel.com>; Wysocki, Rafael J
> <rafael.j.wysocki(a)intel.com>
> Cc: Schmauss, Erik <erik.schmauss(a)intel.com>; jkim(a)FreeBSD.org;
> lenb(a)kernel.org; ndesaulniers(a)google.com; linux-acpi(a)vger.kernel.or=
g;
> devel(a)acpica.org; clang-built-linux(a)googlegroups.com; linux-
> kernel(a)vger.kernel.org
> Subject: Re: [PATCH v2] acpica: fix -Wnull-pointer-arithmetic warnings
> =

> On Fri, 2019-07-26 at 19:35 +0000, Moore, Robert wrote:
> > We've taken the change to ACPI_TO_POINTER.
> =

> I am a bit confused here. I saw the commit in the acpia repo.
> =

> https://github.com/acpica/acpica/commit/02bbca5070e42d298c9b824300aa0
> eb8a082d797
> =

> but how does that change will go into the linux kernel? Suppose Rafael wi=
ll
> need to pick it up manually?

I do that after every ACPICA release

Erik
> =

> >
> >
> > -----Original Message-----
> > From: Qian Cai [mailto:cai(a)lca.pw]
> > Sent: Thursday, July 18, 2019 12:49 PM
> > To: Wysocki, Rafael J <rafael.j.wysocki(a)intel.com>
> > Cc: Moore, Robert <robert.moore(a)intel.com>; Schmauss, Erik
> > <erik.schmauss(a)inte l.com>; jkim(a)FreeBSD.org; lenb(a)kernel.org;
> > ndesaulniers(a)google.com; linux-acpi @vger.kernel.org;
> > devel(a)acpica.org; clang-built-linux(a)googlegroups.com; linux-
> > kernel(a)vger.kernel.org; Qian Cai <cai(a)lca.pw>
> > Subject: [PATCH v2] acpica: fix -Wnull-pointer-arithmetic warnings
> >
> > Clang generate quite a few of those warnings.
> >
> > drivers/acpi/scan.c:759:28: warning: arithmetic on a null pointer
> > treated as a cast from integer to pointer is a GNU extension [-Wnull-po=
inter-
> arithmetic]
> > 		status =3D acpi_get_handle(ACPI_ROOT_OBJECT,
> > obj->string.pointer,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0^~~~~~~~~~~~~~~~
> > ./include/acpi/actypes.h:458:56: note: expanded from macro
> 'ACPI_ROOT_OBJECT'
> > =C2=A0#define ACPI_ROOT_OBJECT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0((acpi_handle)
> > ACPI_TO_POINTER
> > (ACPI_MAX_PTR))
> > 							^~~~~~~~~~~~~~~
> > ./include/acpi/actypes.h:509:41: note: expanded from macro
> 'ACPI_TO_POINTER'
> > =C2=A0#define ACPI_TO_POINTER(i)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ACPI_ADD_PTR (void, (void *)
> > 0,
> > (acpi_size) (i))
> >
> > ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > ./include/acpi/actypes.h:503:84: note: expanded from macro 'ACPI_ADD_PT=
R'
> > =C2=A0#define ACPI_ADD_PTR(t, a, b)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ACPI_CAST_PTR (t,
> > (ACPI_CAST_PTR (u8, (a)) + (acpi_size)(b)))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0^~~~~~~~~~~~~~~~~
> > ./include/acpi/actypes.h:501:66: note: expanded from macro
> 'ACPI_CAST_PTR'
> > =C2=A0#define ACPI_CAST_PTR(t, p)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0((t *) (acpi_uintptr_t) (p))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0^
> > This is because pointer arithmetic on a pointer not pointing to an
> > array is an undefined behavior (C11 6.5.6, constraint 8). Fix it by
> > just casting the corresponding pointers using ACPI_CAST_PTR() and skip
> > the arithmetic. Also, fix a checkpatch warning together.
> >
> > ERROR: Macros with complex values should be enclosed in parentheses
> > =C2=A0#45: FILE: include/acpi/actypes.h:509:
> > +#define ACPI_TO_POINTER(i)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ACPI_CAST_PTR (void, i)
> >
> > Signed-off-by: Qian Cai <cai(a)lca.pw>
> > ---
> >
> > v2: Use ACPI_CAST_PTR() in ACPI_TO_POINTER() directly without
> > =C2=A0=C2=A0=C2=A0=C2=A0arithmetic.
> >
> > =C2=A0include/acpi/actypes.h | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h index
> > ad6892a24015..163181e2d884 100644
> > --- a/include/acpi/actypes.h
> > +++ b/include/acpi/actypes.h
> > @@ -506,7 +506,7 @@ typedef u64 acpi_integer;
> >
> > =C2=A0/* Pointer/Integer type conversions */
> >
> > -#define ACPI_TO_POINTER(i)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ACPI_ADD_PTR (void, (void *)
> > 0,
> > (acpi_size) (i))
> > +#define ACPI_TO_POINTER(i)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(ACPI_CAST_PTR (void, i))
> > =C2=A0#define ACPI_TO_INTEGER(p)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ACPI_PTR_DIFF (p, (void *) 0)
> > =C2=A0#define ACPI_OFFSET(d, f)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ACPI_PTR_DIFF (&(((d *)
> > 0)->f), (void
> > *) 0)
> > =C2=A0#define ACPI_PHYSADDR_TO_PTR(i)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0ACPI_TO_POINTER(i)
> > --
> > 2.20.1 (Apple Git-117)
> >

--===============6523675307608331663==--

