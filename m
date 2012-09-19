Content-Type: multipart/mixed; boundary="===============8291164169769642918=="
MIME-Version: 1.0
From: trenn at suse.de
Subject: [Devel] [patch 2/6] Make it possible to extend CFLAGS when invoking
 make
Date: Wed, 19 Sep 2012 13:14:43 +0200
Message-ID: <20120919111905.072264712@ett.arch.suse.de>
In-Reply-To: 20120919111441.021908206@ett.arch.suse.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8291164169769642918==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Thomas Renninger <trenn(a)suse.de>

---
 acpidump/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: acpica-unix-20110413/acpidump/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- acpica-unix-20110413.orig/acpidump/Makefile
+++ acpica-unix-20110413/acpidump/Makefile
@@ -1,7 +1,7 @@
 PROG=3D acpidump
 SRCS=3D	acpidump.c
 KERNEL_INCLUDE :=3D ../include
-CFLAGS +=3D -Wall -Wstrict-prototypes -Wdeclaration-after-statement -Os -s=
 -D_LINUX -DDEFINE_ALTERNATE_TYPES -I$(KERNEL_INCLUDE) =

+override CFLAGS +=3D -Wall -Wstrict-prototypes -Wdeclaration-after-stateme=
nt -Os -s -D_LINUX -DDEFINE_ALTERNATE_TYPES -I$(KERNEL_INCLUDE)
 =

 all: acpidump
 $(PROG) : $(SRCS)


--===============8291164169769642918==--

