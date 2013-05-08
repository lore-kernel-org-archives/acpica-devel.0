Content-Type: multipart/mixed; boundary="===============6877984634217310157=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH 1/2] Fix config so it will compile with GCC
 versions	that do not have -m32/-m64
Date: Wed, 08 May 2013 19:45:23 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E36FE54574@ORSMSX103.amr.corp.intel.com>
In-Reply-To: 1368021217-19585-2-git-send-email-naresh.bhat@linaro.org
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6877984634217310157==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We just removed the cross-compilation support from the ACPICA application m=
akefiles, so this should cease to be a problem.

See the acpica git tree for the commit.
Bob

> -----Original Message-----
> From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] On B=
ehalf
> Of Naresh Bhat
> Sent: Wednesday, May 08, 2013 6:54 AM
> To: devel(a)acpica.org
> Cc: al.stone(a)linaro.org
> Subject: [Devel] [PATCH 1/2] Fix config so it will compile with GCC
> versions that do not have -m32/-m64
> =

> Signed-off-by: Naresh Bhat <naresh.bhat(a)linaro.org>
> Signed-off-by: Al Stone <ahs3(a)redhat.com>
> =

> While compiling the ACPI test suite on ARM architecture got the following
> compilation error .
> ...
> ....
> Copy intermediate file:
> `obj32/prparserparse.h' -> `obj32/prparser.y.h'
> gcc -c -m32 -D_CYGWIN -D_GNU_SOURCE -I../../../source/include -
> DACPI_ASL_COMPILER -I../../../source/compiler -Iobj32 -Wall -Werror -
> oobj32/as
> gcc: error: unrecognized command line option '-m32'
> make[1]: *** [obj32/aslcompilerlex.o] Error 1 ....
> .....
> =

> This patch fix config so it will compile with GCC versions that do not
> have -m32/-m64
> ---
>  generate/unix/Makefile.config |    1 -
>  1 file changed, 1 deletion(-)
> =

> diff --git a/generate/unix/Makefile.config b/generate/unix/Makefile.config
> index 65242e0..fcda7a6 100644
> --- a/generate/unix/Makefile.config
> +++ b/generate/unix/Makefile.config
> @@ -41,7 +41,6 @@ CC =3D    gcc
>  #
>  OBJDIR =3D     obj$(BITS)
>  BINDIR =3D     bin$(BITS)
> -BITSFLAG =3D   -m$(BITS)
>  COMPILEOBJ =3D $(CC) -c $(CFLAGS) $(OPT_CFLAGS) -o $@ $<
>  LINKPROG =3D   $(CC) $(OBJECTS) -o $(PROG) $(LDFLAGS)
>  INSTALLDIR =3D /usr/bin
> --
> 1.7.9.5
> =

> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> https://lists.acpica.org/mailman/listinfo/devel

--===============6877984634217310157==--

