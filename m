Content-Type: multipart/mixed; boundary="===============2905858946992362974=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rjw at rjwysocki.net>
Subject: Re: [Devel] [PATCH 1/1] tools: power/acpi, revert to LD = gcc
Date: Mon, 30 Apr 2018 10:00:54 +0200
Message-ID: <6842093.byeXVzAmGC@aspire.rjw.lan>
In-Reply-To: 20180424074344.23029-1-jslaby@suse.cz
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2905858946992362974==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tuesday, April 24, 2018 9:43:44 AM CEST Jiri Slaby wrote:
> Commit 7ed1c1901fe5 (tools: fix cross-compile var clobbering) removed
> setting of LD to $(CROSS_COMPILE)gcc. This broke build of acpica
> (acpidump) in power/acpi:
>  ld: unrecognized option '-D_LINUX'
> =

> The tools pass CFLAGS to the linker (incl. -D_LINUX), so revert this
> particular change and let LD be $(CC) again. Note that the old behaviour
> was a bit different, it used $(CROSS_COMPILE)gcc which was eliminated by
> the commit 7ed1c1901fe5. We use $(CC) for that reason.
> =

> Signed-off-by: Jiri Slaby <jslaby(a)suse.cz>
> Cc: Martin Kelly <martin(a)martingkelly.com>
> Cc: "Rafael J. Wysocki" <rjw(a)rjwysocki.net>
> Cc: Len Brown <lenb(a)kernel.org>
> Cc: Robert Moore <robert.moore(a)intel.com>
> Cc: Erik Schmauss <erik.schmauss(a)intel.com>
> Cc: linux-acpi(a)vger.kernel.org
> Cc: devel(a)acpica.org
> ---
>  tools/power/acpi/Makefile.config | 1 +
>  1 file changed, 1 insertion(+)
> =

> diff --git a/tools/power/acpi/Makefile.config b/tools/power/acpi/Makefile=
.config
> index 2cccbba64418..f304be71c278 100644
> --- a/tools/power/acpi/Makefile.config
> +++ b/tools/power/acpi/Makefile.config
> @@ -56,6 +56,7 @@ INSTALL_SCRIPT =3D ${INSTALL_PROGRAM}
>  # to compile vs uClibc, that can be done here as well.
>  CROSS =3D #/usr/i386-linux-uclibc/usr/bin/i386-uclibc-
>  CROSS_COMPILE ?=3D $(CROSS)
> +LD =3D $(CC)
>  HOSTCC =3D gcc
>  =

>  # check if compiler option is supported
> =


Applied, thanks!



--===============2905858946992362974==--

