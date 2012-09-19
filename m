Content-Type: multipart/mixed; boundary="===============0861353913651285741=="
MIME-Version: 1.0
From: trenn at suse.de
Subject: [Devel] [patch 6/6] acpcia: Fixes some minor Tab vs whitespace issues
 in Makefiles.
Date: Wed, 19 Sep 2012 13:14:47 +0200
Message-ID: <20120919111905.944436733@ett.arch.suse.de>
In-Reply-To: 20120919111441.021908206@ett.arch.suse.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0861353913651285741==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Thomas Renninger <trenn(a)suse.de>
---
 generate/unix/acpibin/Makefile |    2 +-
 generate/unix/iasl/Makefile    |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

Index: acpica-unix2-20120913/generate/unix/acpibin/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- acpica-unix2-20120913.orig/generate/unix/acpibin/Makefile
+++ acpica-unix2-20120913/generate/unix/acpibin/Makefile
@@ -27,7 +27,7 @@ HEADERS =3D \
     $(wildcard $(ACPIBIN)/*.h)
 =

 OBJECTS =3D \
-   	$(OBJDIR)/abcompare.o \
+	$(OBJDIR)/abcompare.o \
 	$(OBJDIR)/abmain.o \
 	$(OBJDIR)/utalloc.o \
 	$(OBJDIR)/utcache.o \
Index: acpica-unix2-20120913/generate/unix/iasl/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- acpica-unix2-20120913.orig/generate/unix/iasl/Makefile
+++ acpica-unix2-20120913/generate/unix/iasl/Makefile
@@ -192,13 +192,13 @@ INTERMEDIATES =3D \
 	$(OBJDIR)/prparserparse.c
 =

 MISC =3D \
-   	$(OBJDIR)/aslcompilerparse.h \
+	$(OBJDIR)/aslcompilerparse.h \
 	$(OBJDIR)/aslcompiler.y.h \
 	$(OBJDIR)/aslcompilerparse.output \
-   	$(OBJDIR)/dtparserparse.h \
+	$(OBJDIR)/dtparserparse.h \
 	$(OBJDIR)/dtparser.y.h \
 	$(OBJDIR)/dtparserparse.output \
-   	$(OBJDIR)/prparserparse.h \
+	$(OBJDIR)/prparserparse.h \
 	$(OBJDIR)/prparser.y.h \
 	$(OBJDIR)/prparserparse.output
 =



--===============0861353913651285741==--

