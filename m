Content-Type: multipart/mixed; boundary="===============8340219652403797055=="
MIME-Version: 1.0
From: Thomas Renninger <trenn at suse.de>
Subject: [Devel] [RESEND] [PATCH 2/2] acpica Makefile: Fixes some minor Tab vs
 whitespace issues in Makefiles
Date: Wed, 14 Nov 2012 15:52:37 +0100
Message-ID: <201211141552.37590.trenn@suse.de>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8340219652403797055==
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
=20

--===============8340219652403797055==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="acpica_makefile_whitespace_cleanup.patch"

YWNwY2lhOiBGaXhlcyBzb21lIG1pbm9yIFRhYiB2cyB3aGl0ZXNwYWNlIGlzc3VlcyBpbiBNYWtl
ZmlsZXMuCgpTaWduZWQtb2ZmLWJ5OiBUaG9tYXMgUmVubmluZ2VyIDx0cmVubkBzdXNlLmRlPgot
LS0KIGdlbmVyYXRlL3VuaXgvYWNwaWJpbi9NYWtlZmlsZSB8ICAgIDIgKy0KIGdlbmVyYXRlL3Vu
aXgvaWFzbC9NYWtlZmlsZSAgICB8ICAgIDYgKysrLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDQgaW5z
ZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCkluZGV4OiBhY3BpY2EtdW5peDItMjAxMjA5MTMv
Z2VuZXJhdGUvdW5peC9hY3BpYmluL01ha2VmaWxlCj09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGFjcGljYS11bml4
Mi0yMDEyMDkxMy5vcmlnL2dlbmVyYXRlL3VuaXgvYWNwaWJpbi9NYWtlZmlsZQorKysgYWNwaWNh
LXVuaXgyLTIwMTIwOTEzL2dlbmVyYXRlL3VuaXgvYWNwaWJpbi9NYWtlZmlsZQpAQCAtMjcsNyAr
MjcsNyBAQCBIRUFERVJTID0gXAogICAgICQod2lsZGNhcmQgJChBQ1BJQklOKS8qLmgpCiAKIE9C
SkVDVFMgPSBcCi0gICAJJChPQkpESVIpL2FiY29tcGFyZS5vIFwKKwkkKE9CSkRJUikvYWJjb21w
YXJlLm8gXAogCSQoT0JKRElSKS9hYm1haW4ubyBcCiAJJChPQkpESVIpL3V0YWxsb2MubyBcCiAJ
JChPQkpESVIpL3V0Y2FjaGUubyBcCkluZGV4OiBhY3BpY2EtdW5peDItMjAxMjA5MTMvZ2VuZXJh
dGUvdW5peC9pYXNsL01ha2VmaWxlCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGFjcGljYS11bml4Mi0yMDEyMDkx
My5vcmlnL2dlbmVyYXRlL3VuaXgvaWFzbC9NYWtlZmlsZQorKysgYWNwaWNhLXVuaXgyLTIwMTIw
OTEzL2dlbmVyYXRlL3VuaXgvaWFzbC9NYWtlZmlsZQpAQCAtMTkyLDEzICsxOTIsMTMgQEAgSU5U
RVJNRURJQVRFUyA9IFwKIAkkKE9CSkRJUikvcHJwYXJzZXJwYXJzZS5jCiAKIE1JU0MgPSBcCi0g
ICAJJChPQkpESVIpL2FzbGNvbXBpbGVycGFyc2UuaCBcCisJJChPQkpESVIpL2FzbGNvbXBpbGVy
cGFyc2UuaCBcCiAJJChPQkpESVIpL2FzbGNvbXBpbGVyLnkuaCBcCiAJJChPQkpESVIpL2FzbGNv
bXBpbGVycGFyc2Uub3V0cHV0IFwKLSAgIAkkKE9CSkRJUikvZHRwYXJzZXJwYXJzZS5oIFwKKwkk
KE9CSkRJUikvZHRwYXJzZXJwYXJzZS5oIFwKIAkkKE9CSkRJUikvZHRwYXJzZXIueS5oIFwKIAkk
KE9CSkRJUikvZHRwYXJzZXJwYXJzZS5vdXRwdXQgXAotICAgCSQoT0JKRElSKS9wcnBhcnNlcnBh
cnNlLmggXAorCSQoT0JKRElSKS9wcnBhcnNlcnBhcnNlLmggXAogCSQoT0JKRElSKS9wcnBhcnNl
ci55LmggXAogCSQoT0JKRElSKS9wcnBhcnNlcnBhcnNlLm91dHB1dAogCg==

--===============8340219652403797055==--

