Content-Type: multipart/mixed; boundary="===============8476398081455659472=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] Re: [PATCH] service_layers: osunixmap: Remove unnecessary
 brackets in acpi_os_map_memory()
Date: Thu, 09 Jul 2020 14:49:17 +0000
Message-ID: <BYAPR11MB3256999B714C7F5598E3213687640@BYAPR11MB3256.namprd11.prod.outlook.com>
In-Reply-To: 20200709080806.14328-1-vulab@iscas.ac.cn
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8476398081455659472==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

-		return (NULL);
+		return NULL;

This is the ACPICA coding standard, and it does not affect anything.
Bob

-----Original Message-----
From: Xu Wang <vulab(a)iscas.ac.cn> =

Sent: Thursday, July 09, 2020 1:08 AM
To: Moore, Robert <robert.moore(a)intel.com>; Kaneda, Erik <erik.kaneda(a)i=
ntel.com>; Wysocki, Rafael J <rafael.j.wysocki(a)intel.com>; lenb(a)kernel.=
org; vulab(a)iscas.ac.cn; linux-acpi(a)vger.kernel.org; devel(a)acpica.org
Cc: linux-kernel(a)vger.kernel.org
Subject: [PATCH] service_layers: osunixmap: Remove unnecessary brackets in =
acpi_os_map_memory()

Remove extra brackets.

Signed-off-by: Xu Wang <vulab(a)iscas.ac.cn>
---
 tools/power/acpi/os_specific/service_layers/osunixmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/acpi/os_specific/service_layers/osunixmap.c b/tool=
s/power/acpi/os_specific/service_layers/osunixmap.c
index c565546e85bc..52f3e70b5c81 100644
--- a/tools/power/acpi/os_specific/service_layers/osunixmap.c
+++ b/tools/power/acpi/os_specific/service_layers/osunixmap.c
@@ -70,7 +70,7 @@ void *acpi_os_map_memory(acpi_physical_address where, acp=
i_size length)
 	fd =3D open(SYSTEM_MEMORY, O_RDONLY | O_BINARY);
 	if (fd < 0) {
 		fprintf(stderr, "Cannot open %s\n", SYSTEM_MEMORY);
-		return (NULL);
+		return NULL;
 	}
 =

 	/* Align the offset to use mmap */
@@ -85,7 +85,7 @@ void *acpi_os_map_memory(acpi_physical_address where, acp=
i_size length)
 	if (mapped_memory =3D=3D MAP_FAILED) {
 		fprintf(stderr, "Cannot map %s\n", SYSTEM_MEMORY);
 		close(fd);
-		return (NULL);
+		return NULL;
 	}
 =

 	close(fd);
-- =

2.17.1

--===============8476398081455659472==--

