Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794914465;
	b=127/fWIiFVaT3ZT44A/gAzD0JG++OU/TEwMde+YPCW7p1ryAnygZYxcN11Kt68AiBxnL
	 fPk8wfM8FpSe7G3xnX8gz9tnIgR0kFxG9G3m9Tf1R2ljRwxIN64vh2VrRhB2dlhBJn1y3
	 iiwet7KqT0Pntk7bIJvwZsZgyt//maRkv5a+DtjCAwrNNnlj041QE4d3TyknQ4vhkElgu
	 B/PJNnZV7HcCrCRd8I3j3dmQNJvvTMM50DQZQ0wIxodKE89V9pYBtDnvD7kxsYUJSgn6A
	 F0GG49k9IbqTYoI/8tNsGNeQnpgbsovd2aWIN78FszQ3yAkoKMs3dc/wyhRPTI0JeHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794914465;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oCmAMcMI6wViFsbDTZiBivpWPFRE88xH8DYMWGs3M2E=;
	b=JRbOE9dW3CZMPhXVZl34zl9+7eg06La6tCEjwQbasaZ1rL6zUnNFN+9C54uj1GthSjO3
	 R7O3u7TcIBeYdnhA61ArXMQzyMNSOrlR6ZwNezaXQR6ObKmPTX5jKMewb2VfHBXSTCXac
	 lhTbOGACSuMZ+ffVhgoJ3Ix5POXe1pHoAe3RCFj5nfpCV7GVZ/L16hVCZlgJ7mTDWRYHC
	 2qKSeDToYKzfsHQBqnVVYGZgDsAHoqKbpTIsj/RPg2WQxRiesY1BCKOOxJypXFjnSRK4K
	 g3ZadTUo18CM9KbVNSz9pyG7RYYScgXDCc3HcLsQbKZTuLkMD2jltRt8khGitUnKBHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=NFER0dRw;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB66606A33A
	for <acpica-devel@lists.linux.dev>; Tue, 17 Nov 2026 11:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CB66606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=NFER0dRw
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96FAC1C25;
	Tue, 17 Nov 2026 03:21:00 -0800 (PST)
Received: from e135073.nice.Arm.com (e135073.arm.com [10.34.111.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D92AD3F763;
	Tue, 17 Nov 2026 03:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794914463; bh=vh/3DW9oXPoEO7P7wcOum7s0VizOF+DCqp/Q3/nuvbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NFER0dRwXIg+hJAi+1uyUu6nQgIflMDr2B1SWVTqNH4ykm4nGfi/+i+WJZbhCwlcw
	 TOChtXZ0BxRhkn2e/Dtj5GaSdD3KOwQPl400vG4rdDOsIxfLksOmF48fmf5ZD07LY0
	 K5xB6SjDzusFbGxTZsqypxaoHuCJSfZ2pyeXg8Ds=
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Ashok Raj <ashok.raj@oss.qualcomm.com>,
	James Morse <james.morse@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Radu Rendec <radu@rendec.net>,
	Avadhut Naik <avadhut.naik@amd.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Breno Leitao <leitao@debian.org>,
	Dan Williams <djbw@kernel.org>,
	Terry Bowman <terry.bowman@amd.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v1 17/19] ACPI: APEI: Share the extlog PCIe handler with GHES
Date: Tue, 17 Nov 2026 12:10:27 +0100
Message-ID: <20261117111444.4185512-18-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117111444.4185512-1-pierre.gondois@arm.com>
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Post: <mailto:acpica-devel@lists.linux.dev>
List-Help: <mailto:acpica-devel+help@lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:acpica-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove ghes_handle_aer() and re-use the existing extlog_print_pcie()
to have a common PCIe logging handler. Update the function
documentation.

Except for the warning ("PCIe error section too small"),
no functional change intended.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/acpi/apei/apei-internal.h |  1 +
 drivers/acpi/apei/extlog.c        | 14 +++++++-
 drivers/acpi/apei/ghes.c          | 54 ++-----------------------------
 3 files changed, 16 insertions(+), 53 deletions(-)

diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei-internal.h
index 5063c743b4cf0..22a33a21017a3 100644
--- a/drivers/acpi/apei/apei-internal.h
+++ b/drivers/acpi/apei/apei-internal.h
@@ -14,6 +14,7 @@ int ghes_severity(int severity);
 int cxl_cper_post_event(enum cxl_event_type event_type,
 			struct cxl_cper_event_rec *rec, u32 len);
 u32 acpi_extlog_mem_err_min_len(u64 validation_bits);
+void extlog_print_pcie(struct acpi_hest_generic_data *gdata);
 void acpi_extlog_report(const struct acpi_hest_generic_status *estatus);
 
 struct apei_exec_context;
diff --git a/drivers/acpi/apei/extlog.c b/drivers/acpi/apei/extlog.c
index bd407436928b4..42ba8ba13804f 100644
--- a/drivers/acpi/apei/extlog.c
+++ b/drivers/acpi/apei/extlog.c
@@ -19,7 +19,19 @@
 
 #include "apei-internal.h"
 
-static void extlog_print_pcie(struct acpi_hest_generic_data *gdata)
+/*
+ * PCIe AER errors need to be sent to the AER driver for reporting and
+ * recovery. The CPER severities map to the following AER severities and
+ * require the following handling:
+ *
+ * CPER_SEV_CORRECTED or CPER_SEV_INFORMATIONAL -> AER_CORRECTABLE
+ *     These need to be reported by the AER driver but no recovery is
+ *     necessary.
+ * CPER_SEV_RECOVERABLE -> AER_NONFATAL
+ * CPER_SEV_FATAL or CPER_SEC_RESET -> AER_FATAL
+ *     These both need to be reported and recovered from by the AER driver.
+ */
+void extlog_print_pcie(struct acpi_hest_generic_data *gdata)
 {
 #ifdef CONFIG_ACPI_APEI_PCIEAER
 	struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 623ac2a7f7a75..7d2864fa14503 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -18,6 +18,7 @@
  */
 
 #include <linux/arm_sdei.h>
+#include <linux/atomic.h>
 #include <linux/kernel.h>
 #include <linux/moduleparam.h>
 #include <linux/init.h>
@@ -37,9 +38,7 @@
 #include <linux/llist.h>
 #include <linux/genalloc.h>
 #include <linux/kfifo.h>
-#include <linux/pci.h>
 #include <linux/pfn.h>
-#include <linux/aer.h>
 #include <linux/nmi.h>
 #include <linux/sched/clock.h>
 #include <linux/uuid.h>
@@ -627,55 +626,6 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 	return queued;
 }
 
-/*
- * PCIe AER errors need to be sent to the AER driver for reporting and
- * recovery. The GHES severities map to the following AER severities and
- * require the following handling:
- *
- * GHES_SEV_CORRECTABLE -> AER_CORRECTABLE
- *     These need to be reported by the AER driver but no recovery is
- *     necessary.
- * GHES_SEV_RECOVERABLE -> AER_NONFATAL
- * GHES_SEV_RECOVERABLE && CPER_SEC_RESET -> AER_FATAL
- *     These both need to be reported and recovered from by the AER driver.
- * GHES_SEV_PANIC does not make it to this handling since the kernel must
- *     panic.
- */
-static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
-{
-#ifdef CONFIG_ACPI_APEI_PCIEAER
-	struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
-
-	if (gdata->error_data_length < sizeof(*pcie_err))
-		return;
-
-	if (pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
-	    pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO) {
-		struct aer_capability_regs aer_info;
-		unsigned int devfn;
-		int aer_severity;
-
-		devfn = PCI_DEVFN(pcie_err->device_id.device,
-				  pcie_err->device_id.function);
-		aer_severity = cper_severity_to_aer(gdata->error_severity);
-
-		/*
-		 * If firmware reset the component to contain
-		 * the error, we must reinitialize it before
-		 * use, so treat it as a fatal AER error.
-		 */
-		if (gdata->flags & CPER_SEC_RESET)
-			aer_severity = AER_FATAL;
-
-		aer_cap_regs_unpack(&aer_info, pcie_err->aer_info, sizeof(pcie_err->aer_info));
-
-		aer_recover_queue(pcie_err->device_id.segment,
-				  pcie_err->device_id.bus,
-				  devfn, aer_severity, &aer_info);
-	}
-#endif
-}
-
 static BLOCKING_NOTIFIER_HEAD(vendor_record_notify_list);
 
 int ghes_register_vendor_record_notifier(struct notifier_block *nb)
@@ -995,7 +945,7 @@ static void ghes_do_proc(struct ghes *ghes,
 			arch_apei_report_mem_error2(sev, mem_err);
 			queued |= ghes_handle_memory_failure2(gdata, sev, sync);
 		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
-			ghes_handle_aer(gdata);
+			extlog_print_pcie(gdata);
 		} else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
 			queued |= ghes_handle_arm_hw_error(gdata, sev, sync);
 		} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
-- 
2.43.0

