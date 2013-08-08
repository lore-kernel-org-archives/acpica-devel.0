Content-Type: multipart/mixed; boundary="===============7819627688742676516=="
MIME-Version: 1.0
From: Andrew McDermott <andrew.mcdermott at linaro.org>
Subject: [Devel] [PATCH] generate/unix/iasl: fix parallel build
Date: Thu, 08 Aug 2013 17:20:01 +0100
Message-ID: <1375978801-1020-1-git-send-email-andrew.mcdermott@linaro.org>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7819627688742676516==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A parallel build fails because the rules for generating the YACC
derived files get invoked twice, given the current dependency graph,
and the simultaneous invocation trashes the generated headers.

This commit makes the YACC generated headers depend on the YACC
generated source files which serialises that part of the build.  By
making all $(OBJECTS) depend on the headers we have a dependency graph
that will first generate the YACC derived .c's, then the .h's which,
when complete, will allow all the $(OBJECTS) to be built in parallel.

Signed-off-by: Andrew McDermott <andrew.mcdermott(a)linaro.org>
---
 generate/unix/iasl/Makefile |   33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/generate/unix/iasl/Makefile b/generate/unix/iasl/Makefile
index e9520ed..672e519 100644
--- a/generate/unix/iasl/Makefile
+++ b/generate/unix/iasl/Makefile
@@ -212,13 +212,10 @@ INTERMEDIATES =3D \
 MISC =3D \
 	$(OBJDIR)/aslcompilerparse.h\
 	$(OBJDIR)/aslcompiler.y.h\
-	$(OBJDIR)/aslcompilerparse.output\
 	$(OBJDIR)/dtparserparse.h\
 	$(OBJDIR)/dtparser.y.h\
-	$(OBJDIR)/dtparserparse.output\
 	$(OBJDIR)/prparserparse.h\
-	$(OBJDIR)/prparser.y.h\
-	$(OBJDIR)/prparserparse.output
+	$(OBJDIR)/prparser.y.h
 =

 #
 # Flags specific to iASL compiler
@@ -240,21 +237,29 @@ include ../Makefile.rules
 $(OBJDIR)/aslcompilerlex.c :   $(ASL_COMPILER)/aslcompiler.l $(ASL_COMPILE=
R)/aslsupport.l
 	$(LEX) $(LFLAGS) -PAslCompiler -o$@ $(ASL_COMPILER)/aslcompiler.l
 =

-$(OBJDIR)/aslcompilerparse.c $(OBJDIR)/aslcompilerparse.h : $(ASL_COMPILER=
)/aslcompiler.y
+$(OBJDIR)/aslcompilerparse.c : $(ASL_COMPILER)/aslcompiler.y
 	$(YACC) $(YFLAGS) -pAslCompiler -o$@ $?
 =

 $(OBJDIR)/dtparserlex.c :      $(ASL_COMPILER)/dtparser.l
 	$(LEX) $(LFLAGS) -PDtParser -o$@ $?
 =

-$(OBJDIR)/dtparserparse.c $(OBJDIR)/dtparserparse.h : $(ASL_COMPILER)/dtpa=
rser.y
+$(OBJDIR)/dtparserparse.c : $(ASL_COMPILER)/dtparser.y
 	$(YACC) $(YFLAGS) -pDtParser -o$@ $?
 =

 $(OBJDIR)/prparserlex.c :      $(ASL_COMPILER)/prparser.l
 	$(LEX) $(LFLAGS) -PPrParser -o$@ $?
 =

-$(OBJDIR)/prparserparse.c $(OBJDIR)/prparserparse.h : $(ASL_COMPILER)/prpa=
rser.y
+$(OBJDIR)/prparserparse.c : $(ASL_COMPILER)/prparser.y
 	$(YACC) $(YFLAGS) -pPrParser -o$@ $?
 =

+$(OBJDIR)/aslcompilerparse.h : $(OBJDIR)/aslcompilerparse.c
+	touch $@
+
+$(OBJDIR)/dtparserparse.h : $(OBJDIR)/dtparserparse.c
+	touch $@
+
+$(OBJDIR)/prparserparse.h:  $(OBJDIR)/prparserparse.c
+	touch $@
 =

 #
 # Rename the headers produced by bison/yacc
@@ -279,19 +284,21 @@ $(OBJDIR)/prparser.y.h: $(OBJDIR)/prparserparse.h
 # by the utilities above and they are not necessarily ANSI C, etc.
 #
 $(OBJDIR)/aslcompilerlex.o :   $(OBJDIR)/aslcompilerlex.c
-	$(CC) -c $(CFLAGS) -Wall -Werror -o$@ $?
+	$(CC) -c $(CFLAGS) -Wall -Werror -o$@ $<
 =

 $(OBJDIR)/aslcompilerparse.o : $(OBJDIR)/aslcompilerparse.c
-	$(CC) -c $(CFLAGS) -Wall -Werror -o$@ $?
+	$(CC) -c $(CFLAGS) -Wall -Werror -o$@ $<
 =

 $(OBJDIR)/dtparserlex.o :      $(OBJDIR)/dtparserlex.c
-	$(CC) -c $(CFLAGS) -Wall -Werror -o$@ $?
+	$(CC) -c $(CFLAGS) -Wall -Werror -o$@ $<
 =

 $(OBJDIR)/dtparserparse.o :    $(OBJDIR)/dtparserparse.c
-	$(CC) -c $(CFLAGS) -Wall -Werror -o$@ $?
+	$(CC) -c $(CFLAGS) -Wall -Werror -o$@ $<
 =

 $(OBJDIR)/prparserlex.o :      $(OBJDIR)/prparserlex.c
-	$(CC) -c $(CFLAGS) -Wall -Werror -o$@ $?
+	$(CC) -c $(CFLAGS) -Wall -Werror -o$@ $<
 =

 $(OBJDIR)/prparserparse.o :    $(OBJDIR)/prparserparse.c
-	$(CC) -c $(CFLAGS) -Wall -Werror -o$@ $?
+	$(CC) -c $(CFLAGS) -Wall -Werror -o$@ $<
+
+$(OBJECTS): $(HEADERS)
-- =

1.7.9.5


--===============7819627688742676516==--

