Content-Type: multipart/mixed; boundary="===============4640189720547539577=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: Use acpi_os_allocate_zeroed
Date: Mon, 20 Jun 2016 17:23:37 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E4C01BC@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 20160620055234.GA3104@amitoj-Inspiron-3542
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4640189720547539577==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Got it, thanks. Will appear in next acpica release.


-----Original Message-----
From: Amitoj Kaur Chawla [mailto:amitoj1606(a)gmail.com] =

Sent: Sunday, June 19, 2016 10:53 PM
To: Moore, Robert; Zheng, Lv; Wysocki, Rafael J; lenb(a)kernel.org; linux-a=
cpi(a)vger.kernel.org; devel(a)acpica.org; linux-kernel(a)vger.kernel.org
Cc: julia.lawall(a)lip6.fr
Subject: [PATCH] ACPICA: Use acpi_os_allocate_zeroed

acpi_os_allocate_zeroed combines acpi_os_allocate and memset 0.

The Coccinelle semantic patch used to make this change is as follows:
@@
type T;
T *d;
expression e;
statement S;
@@

        d =3D
-            acpi_os_allocate
+            acpi_os_allocate_zeroed
             (...);
        if (!d) S
-       memset(d, 0, sizeof(T));

Signed-off-by: Amitoj Kaur Chawla <amitoj1606(a)gmail.com>
---
 drivers/acpi/acpica/utcache.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/utcache.c b/drivers/acpi/acpica/utcache.c =
index f8e9978..862f963 100644
--- a/drivers/acpi/acpica/utcache.c
+++ b/drivers/acpi/acpica/utcache.c
@@ -77,14 +77,13 @@ acpi_os_create_cache(char *cache_name,
 =

 	/* Create the cache object */
 =

-	cache =3D acpi_os_allocate(sizeof(struct acpi_memory_list));
+	cache =3D acpi_os_allocate_zeroed(sizeof(struct acpi_memory_list));
 	if (!cache) {
 		return (AE_NO_MEMORY);
 	}
 =

 	/* Populate the cache object and return it */
 =

-	memset(cache, 0, sizeof(struct acpi_memory_list));
 	cache->list_name =3D cache_name;
 	cache->object_size =3D object_size;
 	cache->max_depth =3D max_depth;
--
1.9.1


--===============4640189720547539577==--

