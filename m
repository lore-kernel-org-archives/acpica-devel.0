Content-Type: multipart/mixed; boundary="===============3055688411880977706=="
MIME-Version: 1.0
From: Dongjiu Geng <gengdongjiu at huawei.com>
Subject: [Devel] [PATCH v10 5/5] arm64: handle NOTIFY_SEI notification by the
 APEI driver
Date: Sun, 04 Mar 2018 00:09:40 +0800
Message-ID: <1520093380-42577-6-git-send-email-gengdongjiu@huawei.com>
In-Reply-To: 1520093380-42577-1-git-send-email-gengdongjiu@huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3055688411880977706==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a helper to handle the NOTIFY_SEI notification, when kernel
gets the NOTIFY_SEI notification, call this helper and let APEI
driver to handle this notification.

Signed-off-by: Dongjiu Geng <gengdongjiu(a)huawei.com>
---
 arch/arm64/include/asm/system_misc.h |  1 +
 arch/arm64/kernel/traps.c            |  4 ++++
 arch/arm64/mm/fault.c                | 10 ++++++++++
 3 files changed, 15 insertions(+)

diff --git a/arch/arm64/include/asm/system_misc.h b/arch/arm64/include/asm/=
system_misc.h
index 07aa8e3..9ee13ad 100644
--- a/arch/arm64/include/asm/system_misc.h
+++ b/arch/arm64/include/asm/system_misc.h
@@ -57,6 +57,7 @@ void hook_debug_fault_code(int nr, int (*fn)(unsigned lon=
g, unsigned int,
 })
 =

 int handle_guest_sea(phys_addr_t addr, unsigned int esr);
+int handle_guest_sei(void);
 =

 #endif	/* __ASSEMBLY__ */
 =

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index e88096a..6cb280f 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -681,6 +681,10 @@ bool arm64_is_fatal_ras_serror(struct pt_regs *regs, u=
nsigned int esr)
 {
 	u32 aet =3D arm64_ras_serror_get_severity(esr);
 =

+	/* The APEI driver may handle this RAS error. */
+	if (!handle_guest_sei())
+		return false;
+
 	switch (aet) {
 	case ESR_ELx_AET_CE:	/* corrected error */
 	case ESR_ELx_AET_UEO:	/* restartable, not yet consumed */
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index f76bb2c..8f29bd8 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -683,6 +683,16 @@ int handle_guest_sea(phys_addr_t addr, unsigned int es=
r)
 	return ret;
 }
 =

+int handle_guest_sei(void)
+{
+	int ret =3D -ENOENT;
+
+	if (IS_ENABLED(CONFIG_ACPI_APEI_SEI))
+		ret =3D ghes_notify_sei();
+
+	return ret;
+}
+
 asmlinkage void __exception do_mem_abort(unsigned long addr, unsigned int =
esr,
 					 struct pt_regs *regs)
 {
-- =

1.9.1


--===============3055688411880977706==--

