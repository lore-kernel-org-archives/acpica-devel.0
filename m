Content-Type: multipart/mixed; boundary="===============6971737458178516680=="
MIME-Version: 1.0
From: Dongjiu Geng <gengdongjiu at huawei.com>
Subject: [Devel] [PATCH] arm64: clean the additional checks before calling
 ghes_notify_sea()
Date: Thu, 26 Jul 2018 17:01:47 -0400
Message-ID: <1532638907-46129-1-git-send-email-gengdongjiu@huawei.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6971737458178516680==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In order to remove the additional check before calling the
ghes_notify_sea(), make stub definition when !CONFIG_ACPI_APEI_SEA.

Signed-off-by: Dongjiu Geng <gengdongjiu(a)huawei.com>
---

This cleanup is ever mentioned by Mark Rutland in [1]

[1]:
https://lkml.org/lkml/2018/5/31/289
---
 arch/arm64/mm/fault.c | 7 +------
 include/acpi/ghes.h   | 4 ++++
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index b8eecc7..9ffe01d 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -727,12 +727,7 @@ static int do_sea(unsigned long addr, unsigned int esr=
, struct pt_regs *regs)
 =

 int handle_guest_sea(phys_addr_t addr, unsigned int esr)
 {
-	int ret =3D -ENOENT;
-
-	if (IS_ENABLED(CONFIG_ACPI_APEI_SEA))
-		ret =3D ghes_notify_sea();
-
-	return ret;
+	return ghes_notify_sea();
 }
 =

 asmlinkage void __exception do_mem_abort(unsigned long addr, unsigned int =
esr,
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index 1624e2b..82cb4eb 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -118,6 +118,10 @@ static inline void *acpi_hest_get_next(struct acpi_hes=
t_generic_data *gdata)
 	     (void *)section - (void *)(estatus + 1) < estatus->data_length; \
 	     section =3D acpi_hest_get_next(section))
 =

+#ifdef CONFIG_ACPI_APEI_SEA
 int ghes_notify_sea(void);
+#else
+static inline int ghes_notify_sea(void) { return -ENOENT; }
+#endif
 =

 #endif /* GHES_H */
-- =

1.9.1


--===============6971737458178516680==--

