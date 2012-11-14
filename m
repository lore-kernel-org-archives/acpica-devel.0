Content-Type: multipart/mixed; boundary="===============1852305204915094386=="
MIME-Version: 1.0
From: Thomas Renninger <trenn at suse.de>
Subject: [Devel] [RESEND] [PATCH 1/2] acpica Makefile: Make it possible to
 pass additional CFLAGS when invoking make
Date: Wed, 14 Nov 2012 15:52:29 +0100
Message-ID: <201211141552.29440.trenn@suse.de>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1852305204915094386==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

acpcia: Make it possible to pass additional CFLAGS when invoking make

-D_FORTIFY_SOURCE=3D2 without -O2 can cause:
--
  /usr/include/features.h:314:4: error: #warning _FORTIFY_SOURCE requires
  compiling with optimization (-O) [-Werror=3Dcpp]
--
Such compiler flags must be able to get passed when invoking make.
OpenSUSE packages require to build binaries with CLFAGS=3D"$RPM_OPT_FLAGS",
to make sure debuginfo can be obtained, security/optimization/test flags of
the compiler for the distribution built against are passed, etc.

This patch differs between:
  1) Optional CFLAGS (OPT_CFLAGS) which have a sane default:
     -D_FORTIFY_SOURCE=3D2 -O2 and warning flags
     These will get replaced if OPT_CFLAGS=3D are passed via
     make OPT_CFLAGS=3D".." invokation
  2) Elementary CFLAGS (-I includes, -Dxy, ...) which are
     mandatory for a successful compile run

Signed-off-by: Thomas Renninger <trenn(a)suse.de>
CC: arjan(a)linux.intel.com
---
 generate/unix/Makefile.config |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

Index: acpica-unix2-20120913/generate/unix/Makefile.config
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- acpica-unix2-20120913.orig/generate/unix/Makefile.config
+++ acpica-unix2-20120913/generate/unix/Makefile.config
@@ -38,7 +38,7 @@ CC =3D    gcc
 OBJDIR =3D     obj$(BITS)
 BINDIR =3D     bin$(BITS)
 BITSFLAG =3D   -m$(BITS)
-COMPILEOBJ =3D $(CC) -c $(CFLAGS) $(CWARNINGFLAGS) -o$@ $<
+COMPILEOBJ =3D $(CC) -c $(CFLAGS) -o$@ $<
 LINKPROG =3D   $(CC) $(OBJECTS) -o $(PROG) $(LDFLAGS)
 INSTALLDIR =3D /usr/bin
 INSTALLPROG =3D install -D ../$(BINDIR)/$(PROG) $(DESTDIR)$(INSTALLDIR)/$(=
PROG)
@@ -103,11 +103,15 @@ ACPICA_HEADERS =3D \
 # Common compiler flags. The warning flags in addition to -Wall are not
 # automatically included in -Wall.
 #
+OPT_CFLAGS ?=3D \
+    -D_FORTIFY_SOURCE=3D2 -O2 \
+    $(CWARNINGFLAGS)
+
 CFLAGS +=3D \
+    $(OPT_CFLAGS) \
     $(BITSFLAG) \
     -D$(HOST) \
     -D_GNU_SOURCE \
-    -D_FORTIFY_SOURCE=3D2 \
     -I$(ACPICA_INCLUDE)
 =

 LDFLAGS +=3D $(BITSFLAG)

--===============1852305204915094386==
Content-Type: text/plain
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="acpica_make_CFLAGS_overridable.ksh"

YWNwY2lhOiBNYWtlIGl0IHBvc3NpYmxlIHRvIHBhc3MgYWRkaXRpb25hbCBDRkxBR1Mgd2hlbiBp
bnZva2luZyBtYWtlCgotRF9GT1JUSUZZX1NPVVJDRT0yIHdpdGhvdXQgLU8yIGNhbiBjYXVzZToK
LS0KICAvdXNyL2luY2x1ZGUvZmVhdHVyZXMuaDozMTQ6NDogZXJyb3I6ICN3YXJuaW5nIF9GT1JU
SUZZX1NPVVJDRSByZXF1aXJlcwogIGNvbXBpbGluZyB3aXRoIG9wdGltaXphdGlvbiAoLU8pIFst
V2Vycm9yPWNwcF0KLS0KU3VjaCBjb21waWxlciBmbGFncyBtdXN0IGJlIGFibGUgdG8gZ2V0IHBh
c3NlZCB3aGVuIGludm9raW5nIG1ha2UuCk9wZW5TVVNFIHBhY2thZ2VzIHJlcXVpcmUgdG8gYnVp
bGQgYmluYXJpZXMgd2l0aCBDTEZBR1M9IiRSUE1fT1BUX0ZMQUdTIiwKdG8gbWFrZSBzdXJlIGRl
YnVnaW5mbyBjYW4gYmUgb2J0YWluZWQsIHNlY3VyaXR5L29wdGltaXphdGlvbi90ZXN0IGZsYWdz
IG9mCnRoZSBjb21waWxlciBmb3IgdGhlIGRpc3RyaWJ1dGlvbiBidWlsdCBhZ2FpbnN0IGFyZSBw
YXNzZWQsIGV0Yy4KClRoaXMgcGF0Y2ggZGlmZmVycyBiZXR3ZWVuOgogIDEpIE9wdGlvbmFsIENG
TEFHUyAoT1BUX0NGTEFHUykgd2hpY2ggaGF2ZSBhIHNhbmUgZGVmYXVsdDoKICAgICAtRF9GT1JU
SUZZX1NPVVJDRT0yIC1PMiBhbmQgd2FybmluZyBmbGFncwogICAgIFRoZXNlIHdpbGwgZ2V0IHJl
cGxhY2VkIGlmIE9QVF9DRkxBR1M9IGFyZSBwYXNzZWQgdmlhCiAgICAgbWFrZSBPUFRfQ0ZMQUdT
PSIuLiIgaW52b2thdGlvbgogIDIpIEVsZW1lbnRhcnkgQ0ZMQUdTICgtSSBpbmNsdWRlcywgLUR4
eSwgLi4uKSB3aGljaCBhcmUKICAgICBtYW5kYXRvcnkgZm9yIGEgc3VjY2Vzc2Z1bCBjb21waWxl
IHJ1bgoKU2lnbmVkLW9mZi1ieTogVGhvbWFzIFJlbm5pbmdlciA8dHJlbm5Ac3VzZS5kZT4KQ0M6
IGFyamFuQGxpbnV4LmludGVsLmNvbQotLS0KIGdlbmVyYXRlL3VuaXgvTWFrZWZpbGUuY29uZmln
IHwgICAgOCArKysrKystLQogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkKCkluZGV4OiBhY3BpY2EtdW5peDItMjAxMjA5MTMvZ2VuZXJhdGUvdW5peC9NYWtl
ZmlsZS5jb25maWcKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PQotLS0gYWNwaWNhLXVuaXgyLTIwMTIwOTEzLm9yaWcvZ2Vu
ZXJhdGUvdW5peC9NYWtlZmlsZS5jb25maWcKKysrIGFjcGljYS11bml4Mi0yMDEyMDkxMy9nZW5l
cmF0ZS91bml4L01ha2VmaWxlLmNvbmZpZwpAQCAtMzgsNyArMzgsNyBAQCBDQyA9ICAgIGdjYwog
T0JKRElSID0gICAgIG9iaiQoQklUUykKIEJJTkRJUiA9ICAgICBiaW4kKEJJVFMpCiBCSVRTRkxB
RyA9ICAgLW0kKEJJVFMpCi1DT01QSUxFT0JKID0gJChDQykgLWMgJChDRkxBR1MpICQoQ1dBUk5J
TkdGTEFHUykgLW8kQCAkPAorQ09NUElMRU9CSiA9ICQoQ0MpIC1jICQoQ0ZMQUdTKSAtbyRAICQ8
CiBMSU5LUFJPRyA9ICAgJChDQykgJChPQkpFQ1RTKSAtbyAkKFBST0cpICQoTERGTEFHUykKIElO
U1RBTExESVIgPSAvdXNyL2JpbgogSU5TVEFMTFBST0cgPSBpbnN0YWxsIC1EIC4uLyQoQklORElS
KS8kKFBST0cpICQoREVTVERJUikkKElOU1RBTExESVIpLyQoUFJPRykKQEAgLTEwMywxMSArMTAz
LDE1IEBAIEFDUElDQV9IRUFERVJTID0gXAogIyBDb21tb24gY29tcGlsZXIgZmxhZ3MuIFRoZSB3
YXJuaW5nIGZsYWdzIGluIGFkZGl0aW9uIHRvIC1XYWxsIGFyZSBub3QKICMgYXV0b21hdGljYWxs
eSBpbmNsdWRlZCBpbiAtV2FsbC4KICMKK09QVF9DRkxBR1MgPz0gXAorICAgIC1EX0ZPUlRJRllf
U09VUkNFPTIgLU8yIFwKKyAgICAkKENXQVJOSU5HRkxBR1MpCisKIENGTEFHUyArPSBcCisgICAg
JChPUFRfQ0ZMQUdTKSBcCiAgICAgJChCSVRTRkxBRykgXAogICAgIC1EJChIT1NUKSBcCiAgICAg
LURfR05VX1NPVVJDRSBcCi0gICAgLURfRk9SVElGWV9TT1VSQ0U9MiBcCiAgICAgLUkkKEFDUElD
QV9JTkNMVURFKQogCiBMREZMQUdTICs9ICQoQklUU0ZMQUcpCg==

--===============1852305204915094386==--

