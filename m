Content-Type: multipart/mixed; boundary="===============4885701919472787853=="
MIME-Version: 1.0
From: Thomas Renninger <trenn at suse.de>
Subject: Re: [Devel] [patch 7/6] Fix Itanium build - v2
Date: Wed, 19 Sep 2012 17:27:58 +0200
Message-ID: <201209191727.59232.trenn@suse.de>
In-Reply-To: 201209191656.03066.trenn@suse.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4885701919472787853==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

acpica: IA64 does not know about -m64

Otherwise you get on Itanium:
gcc: error: unrecognized command line option '-m64'

Signed-off-by: Thomas Renninger <trenn(a)suse.de>

---
 generate/unix/Makefile.config |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: acpica-unix-20120913/generate/unix/Makefile.config
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- acpica-unix-20120913.orig/generate/unix/Makefile.config
+++ acpica-unix-20120913/generate/unix/Makefile.config
@@ -37,7 +37,9 @@ CC =3D    gcc
 #
 OBJDIR =3D     obj$(BITS)
 BINDIR =3D     bin$(BITS)
-BITSFLAG =3D   -m$(BITS)
+ifneq ($(shell uname -m),ia64)
+	BITSFLAG =3D   -m$(BITS)
+endif
 COMPILEOBJ =3D $(CC) -c $(CFLAGS) -o$@ $<
 LINKPROG =3D   $(CC) $(OBJECTS) -o $(PROG) $(LDFLAGS)
 INSTALLDIR =3D /usr/bin

--===============4885701919472787853==--

