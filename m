Content-Type: multipart/mixed; boundary="===============6699257901018566505=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] Re: [PATCH -next] ACPICA: Remove unneeded semicolon
Date: Wed, 23 Sep 2020 17:03:42 +0000
Message-ID: <BYAPR11MB325605CF9CC0C660510F0BE687380@BYAPR11MB3256.namprd11.prod.outlook.com>
In-Reply-To: 1600760929-102547-1-git-send-email-zou_wei@huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6699257901018566505==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Got it, thanks.
Bob


-----Original Message-----
From: Zou Wei <zou_wei(a)huawei.com> =

Sent: Tuesday, September 22, 2020 12:49 AM
To: Moore, Robert <robert.moore(a)intel.com>; Kaneda, Erik <erik.kaneda(a)i=
ntel.com>; Wysocki, Rafael J <rafael.j.wysocki(a)intel.com>; lenb(a)kernel.=
org
Cc: linux-acpi(a)vger.kernel.org; devel(a)acpica.org; linux-kernel(a)vger.k=
ernel.org; Zou Wei <zou_wei(a)huawei.com>
Subject: [PATCH -next] ACPICA: Remove unneeded semicolon

Fixes coccicheck warning:

./drivers/acpi/acpica/nsalloc.c:297:2-3: Unneeded semicolon

Signed-off-by: Zou Wei <zou_wei(a)huawei.com>
---
 drivers/acpi/acpica/nsalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/nsalloc.c b/drivers/acpi/acpica/nsalloc.c =
index fe9b363..83d26ab 100644
--- a/drivers/acpi/acpica/nsalloc.c
+++ b/drivers/acpi/acpica/nsalloc.c
@@ -294,7 +294,7 @@ void acpi_ns_delete_children(struct acpi_namespace_node=
 *parent_node)
 		node_to_delete =3D next_node;
 		next_node =3D next_node->peer;
 		acpi_ns_delete_node(node_to_delete);
-	};
+	}
 =

 	/* Clear the parent's child pointer */
 =

--
2.6.2

--===============6699257901018566505==--

