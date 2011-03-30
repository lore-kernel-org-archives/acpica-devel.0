Content-Type: multipart/mixed; boundary="===============1567123340428476572=="
MIME-Version: 1.0
From: Thomas Renninger <trenn at suse.de>
Subject: [Devel] Fix build with latest release
Date: Wed, 30 Mar 2011 17:54:18 +0200
Message-ID: <201103301754.18618.trenn@suse.de>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1567123340428476572==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I got this error with latest sources (20110316):

make: *** No rule to make target `utdecode.o', needed by `acpiexec'.  Stop.
make: Leaving directory `/usr/src/packages/BUILD/acpica-unix-20110316/tools=
/acpiexec'
error: Bad exit status from /var/tmp/rpm-tmp.twh18w (%build)

Here is the fix:

acpica: fix build

Signed-off-by: Thomas Renninger <trenn(a)suse.de>

---
 tools/acpiexec/Makefile |    3 +++
 1 file changed, 3 insertions(+)

Index: acpica-unix-20110316/tools/acpiexec/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- acpica-unix-20110316.orig/tools/acpiexec/Makefile
+++ acpica-unix-20110316/tools/acpiexec/Makefile
@@ -591,6 +591,9 @@ utdebug.o :         $(ACPICA_CORE)/utili
 utdebug.o :         $(ACPICA_CORE)/utilities/utdebug.c
 	$(COMPILE)
 =

+utdecode.o :         $(ACPICA_CORE)/utilities/utdecode.c
+	$(COMPILE)
+
 utdelete.o :        $(ACPICA_CORE)/utilities/utdelete.c
 	$(COMPILE)
=20

--===============1567123340428476572==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="acpiexec_fix_build_missing_utdecode.patch"

YWNwaWNhOiBmaXggYnVpbGQKClNpZ25lZC1vZmYtYnk6IFRob21hcyBSZW5uaW5nZXIgPHRyZW5u
QHN1c2UuZGU+CgotLS0KIHRvb2xzL2FjcGlleGVjL01ha2VmaWxlIHwgICAgMyArKysKIDEgZmls
ZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKCkluZGV4OiBhY3BpY2EtdW5peC0yMDExMDMxNi90
b29scy9hY3BpZXhlYy9NYWtlZmlsZQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBhY3BpY2EtdW5peC0yMDExMDMx
Ni5vcmlnL3Rvb2xzL2FjcGlleGVjL01ha2VmaWxlCisrKyBhY3BpY2EtdW5peC0yMDExMDMxNi90
b29scy9hY3BpZXhlYy9NYWtlZmlsZQpAQCAtNTkxLDYgKzU5MSw5IEBAIHV0ZGVidWcubyA6ICAg
ICAgICAgJChBQ1BJQ0FfQ09SRSkvdXRpbGkKIHV0ZGVidWcubyA6ICAgICAgICAgJChBQ1BJQ0Ff
Q09SRSkvdXRpbGl0aWVzL3V0ZGVidWcuYwogCSQoQ09NUElMRSkKIAordXRkZWNvZGUubyA6ICAg
ICAgICAgJChBQ1BJQ0FfQ09SRSkvdXRpbGl0aWVzL3V0ZGVjb2RlLmMKKwkkKENPTVBJTEUpCisK
IHV0ZGVsZXRlLm8gOiAgICAgICAgJChBQ1BJQ0FfQ09SRSkvdXRpbGl0aWVzL3V0ZGVsZXRlLmMK
IAkkKENPTVBJTEUpCiAK

--===============1567123340428476572==--

