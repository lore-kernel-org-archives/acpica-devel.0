Content-Type: multipart/mixed; boundary="===============2206275471940652555=="
MIME-Version: 1.0
From: malattia at linux.it
Subject: [Devel] [patch 1/5] Allow overriding some of the CFLAGS
Date: Mon, 05 Jul 2010 21:03:25 +0900
Message-ID: <20100705120817.527713917@linux.it>
In-Reply-To: 20100705120324.581857151@linux.it
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2206275471940652555==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It makes it easier for package maintainers to override CFLAGS without touch=
ing
iasl specific defines and includes.

Signed-off-by: Mattia Dongili <malattia(a)linux.it>
---
 compiler/Makefile         |    6 +++++-
 tools/acpiexec/Makefile   |    6 +++++-
 tools/acpisrc/Makefile    |    5 ++++-
 tools/acpixtract/Makefile |    5 ++++-
 4 files changed, 18 insertions(+), 4 deletions(-)

Index: b/compiler/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/compiler/Makefile	2010-07-02 21:42:26.849349488 +0900
+++ b/compiler/Makefile	2010-07-04 11:18:15.830519370 +0900
@@ -125,7 +125,8 @@
 	../osunixxf.c
 =

 NOMAN=3D	YES
-CFLAGS+=3D -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I..=
/include -I../compiler
+MK_CFLAGS =3D -DACPI_ASL_COMPILER -I../include -I../compiler
+CFLAGS=3D -Wall -Wstrict-prototypes -O2
 =

 #YACC=3D	yacc
 YACC=3D	bison
@@ -141,6 +142,9 @@
 =

 LDLIBS =3D -lpthread -lrt
 =

+%.o: %.c
+	$(CC) $(MK_CFLAGS) $(CFLAGS) -c -o $@ $<
+
 aslmain : $(patsubst %.c,%.o, $(SRCS))
 	$(CC) $(LDFLAGS) $(patsubst %.c,%.o, $(SRCS)) \
 		$(LOADLIBES) $(LDLIBS) -o iasl
Index: b/tools/acpiexec/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/tools/acpiexec/Makefile	2010-07-02 21:42:26.893349116 +0900
+++ b/tools/acpiexec/Makefile	2010-07-04 11:18:15.830519370 +0900
@@ -139,8 +139,12 @@
 	../../osunixxf.c
 =

 =

-CFLAGS+=3D -Wall -g -D_LINUX -DNDEBUG -D_CONSOLE -DACPI_EXEC_APP -D_MULTI_=
THREADED -Wstrict-prototypes -I../../include =

+MK_CFLAGS =3D -DNDEBUG -D_CONSOLE -DACPI_EXEC_APP -D_MULTI_THREADED \
+            -I../../include
+CFLAGS =3D -Wall -Wstrict-prototypes -O2 -g
 =

+%.o: %.c
+	$(CC) $(MK_CFLAGS) $(CFLAGS) -c -o $@ $<
 =

 acpiexec : $(patsubst %.c,%.o, $(SRCS))
 	$(CC) $(LDFLAGS) $(patsubst %.c,%.o, $(SRCS)) -lrt -lpthread -o $(PROG)
Index: b/tools/acpisrc/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/tools/acpisrc/Makefile	2010-07-02 21:42:26.877349353 +0900
+++ b/tools/acpisrc/Makefile	2010-07-04 11:18:15.838518967 +0900
@@ -4,8 +4,11 @@
 SRCS=3D	ascase.c asconvrt.c asfile.c asmain.c asremove.c astable.c \
         asutils.c osunixdir.c ../../common/getopt.c
 =

-CFLAGS+=3D -Wall -O2 -D_LINUX -DACPI_APPLICATION -Wstrict-prototypes -I../=
../include =

+MK_CFLAGS=3D -DACPI_APPLICATION -I../../include
+CFLAGS=3D -Wall -Wstrict-prototypes -O2
 =

+%.o: %.c
+	$(CC) $(MK_CFLAGS) $(CFLAGS) -c -o $@ $<
 =

 aslmain : $(patsubst %.c,%.o, $(SRCS))
 	$(CC) $(LDFLAGS) $(patsubst %.c,%.o, $(SRCS)) -o $(PROG)
Index: b/tools/acpixtract/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/tools/acpixtract/Makefile	2010-07-02 21:42:26.861349031 +0900
+++ b/tools/acpixtract/Makefile	2010-07-04 11:18:15.838518967 +0900
@@ -3,8 +3,11 @@
 PROG=3D	acpixtract
 SRCS=3D	acpixtract.c
 =

-CFLAGS+=3D -Wall -O2 -D_LINUX -DACPI_APPLICATION -Wstrict-prototypes -I../=
../include =

+MK_CFLAGS=3D -DACPI_APPLICATION -I../../include
+CFLAGS=3D -Wall -Wstrict-prototypes -O2
 =

+%.o: %.c
+	$(CC) $(MK_CFLAGS) $(CFLAGS) -c -o $@ $<
 =

 acpixtract : $(patsubst %.c,%.o, $(SRCS))
 	$(CC) $(LDFLAGS) $(patsubst %.c,%.o, $(SRCS)) -o $(PROG)


--===============2206275471940652555==--

