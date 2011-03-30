Content-Type: multipart/mixed; boundary="===============6633581623034530954=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] Fix build with latest release
Date: Wed, 30 Mar 2011 08:57:05 -0700
Message-ID: <4911F71203A09E4D9981D27F9D830858D3BC12B4@orsmsx503.amr.corp.intel.com>
In-Reply-To: 201103301754.18618.trenn@suse.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6633581623034530954==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I think we've got this fixed in our git tree, see commit #

8b3f242f8d97c961370012008a4d95a0707430eb

It's a slightly different change than yours, can you please check that it w=
orks for you?

Thanks,
Bob


> -----Original Message-----
> From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] On
> Behalf Of Thomas Renninger
> Sent: Wednesday, March 30, 2011 8:54 AM
> To: devel(a)acpica.org
> Subject: [Devel] Fix build with latest release
> =

> Hi,
> =

> I got this error with latest sources (20110316):
> =

> make: *** No rule to make target `utdecode.o', needed by `acpiexec'.
> Stop.
> make: Leaving directory `/usr/src/packages/BUILD/acpica-unix-
> 20110316/tools/acpiexec'
> error: Bad exit status from /var/tmp/rpm-tmp.twh18w (%build)
> =

> Here is the fix:
> =

> acpica: fix build
> =

> Signed-off-by: Thomas Renninger <trenn(a)suse.de>
> =

> ---
>  tools/acpiexec/Makefile |    3 +++
>  1 file changed, 3 insertions(+)
> =

> Index: acpica-unix-20110316/tools/acpiexec/Makefile
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- acpica-unix-20110316.orig/tools/acpiexec/Makefile
> +++ acpica-unix-20110316/tools/acpiexec/Makefile
> @@ -591,6 +591,9 @@ utdebug.o :         $(ACPICA_CORE)/utili
>  utdebug.o :         $(ACPICA_CORE)/utilities/utdebug.c
>  	$(COMPILE)
> =

> +utdecode.o :         $(ACPICA_CORE)/utilities/utdecode.c
> +	$(COMPILE)
> +
>  utdelete.o :        $(ACPICA_CORE)/utilities/utdelete.c
>  	$(COMPILE)
>=20

--===============6633581623034530954==--

