Content-Type: multipart/mixed; boundary="===============3656808362877020317=="
MIME-Version: 1.0
From: Lin Ming <ming.m.lin at intel.com>
Subject: Re: [Devel] ACPICA version 20100702 released
Date: Tue, 06 Jul 2010 14:44:50 +0800
Message-ID: <1278398690.4398.17.camel@minggr.sh.intel.com>
In-Reply-To: 4C2E31AD.4020001@coresystems.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3656808362877020317==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Would you please try below patch?

diff --git a/compiler/Makefile b/compiler/Makefile
index 962ab67..c8c477b 100644
--- a/compiler/Makefile
+++ b/compiler/Makefile
@@ -7,7 +7,7 @@ PROG=3D	iasl
 ACPICA_SRC =3D    ..
 ASL_COMPILER =3D  $(ACPICA_SRC)/compiler
 ACPICA_COMMON =3D $(ACPICA_SRC)/common
-ACPICA_CORE =3D   $(ACPICA_SRC)/components
+ACPICA_CORE =3D   $(ACPICA_SRC)
 ACPICA_TOOLS =3D  $(ACPICA_SRC)/tools
 ACPICA_OSL =3D    $(ACPICA_SRC)/os_specific/service_layers
 =

diff --git a/tools/acpiexec/Makefile b/tools/acpiexec/Makefile
index b9e892a..31f2338 100644
--- a/tools/acpiexec/Makefile
+++ b/tools/acpiexec/Makefile
@@ -4,9 +4,9 @@
 =

 PROG =3D acpiexec
 =

-ACPICA_SRC =3D    ../../../source
+ACPICA_SRC =3D    ../..
 ACPICA_COMMON =3D $(ACPICA_SRC)/common
-ACPICA_CORE =3D   $(ACPICA_SRC)/components
+ACPICA_CORE =3D   $(ACPICA_SRC)
 ACPICA_TOOLS =3D  $(ACPICA_SRC)/tools
 ACPICA_OSL =3D    $(ACPICA_SRC)/os_specific/service_layers
 =




On Sat, 2010-07-03 at 02:36 +0800, Stefan Reinauer wrote:
> On 7/2/10 6:48 PM, Moore, Robert wrote:
> > Added support for Mac OS X in the Unix OSL used for iASL and AcpiExec. =
Use the #define __APPLE__ to enable this support.
> Are there specific build instructions for this? I get the following
> error message on my MacBook Pro:
> =

> make: *** No rule to make target `../components/debugger/dbfileio.c',
> needed by `dbfileio.o'.  Stop.
> =

> =

> Best regards,
> Stefan
> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> http://lists.acpica.org/listinfo/devel


--===============3656808362877020317==--

