Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792421863;
	b=DToVS5W9s9p3g+eAYZnprKb3OFAvz3+UNDHdvFEUkBWQYv0shqU2Hx0lXWPyiyByyBuZ
	 j4XrkueQkX0jwkV1o2dP7V2mWPLbUfeT072Z5GGxQrYvgFH1wptGlh9R+j4CfrlWInhGo
	 Fewb2cGBXpmkj+EWLN2XE4rOrQX658HmYKsk1LnD4XJpjNFXXWabAyX2FGo5S874MARp6
	 2xSy3Evdx7+FFCQ85X7pzSY/b84ZG56KbF+2qMji2WWQJVMh7ZLD/g5AMIksvx+QrOVHK
	 ANrA/FAwrAZ2uX+MdlydKc930NwvHBHLV28QS9jizfDb8B4P4J/j4QqFToaMxtqjvcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792421863;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UzY0WV17KtoguFGC5HPs6JnZnsTzj7BsHSqpC9j8C1s=;
	b=tCqf1yQwxtR5T0rowsH3JBry2SUcOaFqi5JAvHaLrbK5yNeN9UX1O4GP5NS1/y0BPMgq
	 1VzrqbJPfdIZXh8MhHrQgzopdEzXyVxg3hO8nmdt4MWDAbW0A/+XGto4H3LO1Ym6R5K6R
	 lLXgPj/8f0CsODS1+8e1BJwQ+PT4CbyBZISM0I9hSN1PgYdKVISUwD9R076T38Vn6UDDU
	 GqbIY2bAAeOoSNi3y970XJ/8tF4E1syxBGKr6Q+LwkRT9GM2evaANZkIqM08q6YWxCubp
	 e0BVz/EvJLzpurCv7u+GXNQR3IPqsobWsd/HlGSMhs5eMohC0YOglPvbnEe5s+xA5VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=CqqIcGKZ;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17786075501
	for <acpica-devel@lists.linux.dev>; Mon, 19 Oct 2026 14:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F17786075501
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=CqqIcGKZ
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 237471F91;
	Mon, 19 Oct 2026 07:57:38 -0700 (PDT)
Received: from e135073.nice.Arm.com (e135073.arm.com [10.34.111.131])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 626AD3F673;
	Mon, 19 Oct 2026 07:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792421861; bh=xsAU47rIG+fvtnlYzCeM96L00uwBVp59abpxrB9Ib0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CqqIcGKZnza3kQ+PgaE2l08cnDrkf4UuPxLndNBM3jADzYCqNXCnijbJAn7MaonUV
	 JYcy5vuCaSg1cqx/G2cPFNFDcE39N+P173GcMlfSIiHpMF+hzHJtzd+fw2kgvS/Rzv
	 awbOmMaN8zd49nahNx8ALUFR8L6SYA5ScSNcB3eE=
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: James Morse <james.morse@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Dave Jiang <dave.jiang@intel.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Breno Leitao <leitao@debian.org>,
	Terry Bowman <terry.bowman@amd.com>,
	Dan Williams <djbw@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Morduan Zang <zhangdandan@uniontech.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH 5/6] ACPI: APEI: add separate Memory Error Section 2 handlers
Date: Mon, 19 Oct 2026 16:56:12 +0200
Message-ID: <20261019145643.1877246-6-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019145643.1877246-1-pierre.gondois@arm.com>
References: <20261019145643.1877246-1-pierre.gondois@arm.com>
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

Add dedicated GHES and EDAC callbacks for Memory Error Section 2
records. Use a separate GHES notifier chain so existing consumers
continue to receive legacy memory error sections.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/acpi/apei/ghes.c |  49 ++++++++++++-
 drivers/edac/ghes_edac.c | 150 +++++++++++++++++++++++++++++++++++++++
 include/acpi/ghes.h      |   2 +
 3 files changed, 200 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index fe10ab0e02f6..c7fb15543b56 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -101,6 +101,7 @@
 #endif
 
 static ATOMIC_NOTIFIER_HEAD(ghes_report_chain);
+static ATOMIC_NOTIFIER_HEAD(ghes_report_mem2_chain);
 
 static inline bool is_hest_type_generic_v2(struct ghes *ghes)
 {
@@ -551,6 +552,29 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
 	return false;
 }
 
+static bool ghes_handle_memory_failure2(struct acpi_hest_generic_data *gdata,
+					int sev, bool sync)
+{
+	int flags = -1;
+	int sec_sev = ghes_severity(gdata->error_severity);
+	struct cper_sec_mem_err2 *mem_err = acpi_hest_get_payload(gdata);
+
+	if (!(mem_err->validation_bits & CPER_MEM2_VALID_PA))
+		return false;
+
+	/* iff following two events can be handled properly by now */
+	if (sec_sev == GHES_SEV_CORRECTED &&
+	    (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED))
+		flags = MF_SOFT_OFFLINE;
+	if (sev == GHES_SEV_RECOVERABLE && sec_sev == GHES_SEV_RECOVERABLE)
+		flags = sync ? MF_ACTION_REQUIRED : 0;
+
+	if (flags != -1)
+		return ghes_do_memory_failure(mem_err->physical_addr, flags);
+
+	return false;
+}
+
 static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 				     int sev, bool sync)
 {
@@ -915,7 +939,8 @@ static void ghes_log_hwerr(int sev, guid_t *sec_type)
 		return;
 	}
 
-	if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
+	if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM) ||
+	    guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM2)) {
 		hwerr_log_error_type(HWERR_RECOV_MEMORY);
 		return;
 	}
@@ -952,6 +977,16 @@ static void ghes_do_proc(struct ghes *ghes,
 
 			arch_apei_report_mem_error(sev, mem_err);
 			queued = ghes_handle_memory_failure(gdata, sev, sync);
+		} else if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM2)) {
+			struct cper_sec_mem_err2 *mem_err = acpi_hest_get_payload(gdata);
+
+			if (gdata->error_data_length < sizeof(*mem_err)) {
+				pr_warn(FW_WARN "Memory Error Section 2 length is too small\n");
+				continue;
+			}
+
+			atomic_notifier_call_chain(&ghes_report_mem2_chain, sev, mem_err);
+			queued = ghes_handle_memory_failure2(gdata, sev, sync);
 		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
 			ghes_handle_aer(gdata);
 		} else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
@@ -1973,3 +2008,15 @@ void ghes_unregister_report_chain(struct notifier_block *nb)
 	atomic_notifier_chain_unregister(&ghes_report_chain, nb);
 }
 EXPORT_SYMBOL_GPL(ghes_unregister_report_chain);
+
+void ghes_register_report_mem2_chain(struct notifier_block *nb)
+{
+	atomic_notifier_chain_register(&ghes_report_mem2_chain, nb);
+}
+EXPORT_SYMBOL_GPL(ghes_register_report_mem2_chain);
+
+void ghes_unregister_report_mem2_chain(struct notifier_block *nb)
+{
+	atomic_notifier_chain_unregister(&ghes_report_mem2_chain, nb);
+}
+EXPORT_SYMBOL_GPL(ghes_unregister_report_mem2_chain);
diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index d80c88818691..b18460ba8f40 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -386,6 +386,154 @@ static struct notifier_block ghes_edac_mem_err_nb = {
 	.priority	= 0,
 };
 
+static int print_mem_error2_other_detail(const struct cper_sec_mem_err2 *mem, char *msg,
+					 const char *location, unsigned int len)
+{
+	u32 n;
+
+	if (!msg)
+		return 0;
+
+	n = 0;
+	len -= 1;
+
+	n += scnprintf(msg + n, len - n, "APEI location: %s ", location);
+
+	if (mem->validation_bits & CPER_MEM2_VALID_ERROR_STATUS) {
+		n += scnprintf(msg + n, len - n, "status(0x%016llx): ", mem->error_status);
+		n += scnprintf(msg + n, len - n, "%s ",
+			       cper_mem_err_status_str(mem->error_status));
+	}
+	if (mem->validation_bits & CPER_MEM2_VALID_STATUS)
+		n += scnprintf(msg + n, len - n, "section_status:0x%02x ",
+			       mem->status);
+
+	msg[n] = '\0';
+
+	return n;
+}
+
+static int ghes_edac_report_mem_error2(struct notifier_block *nb,
+				       unsigned long val, void *data)
+{
+	struct cper_sec_mem_err2 *mem_err = data;
+	struct edac_raw_error_desc *e;
+	struct mem_ctl_info *mci;
+	unsigned long sev = val;
+	struct ghes_pvt *pvt;
+	unsigned long flags;
+	char *p;
+
+	/*
+	 * We can do the locking below because GHES defers error processing
+	 * from NMI to IRQ context. Whenever that changes, we'd at least
+	 * know.
+	 */
+	if (WARN_ON_ONCE(in_nmi()))
+		return NOTIFY_OK;
+
+	spin_lock_irqsave(&ghes_lock, flags);
+
+	pvt = ghes_pvt;
+	if (!pvt)
+		goto unlock;
+
+	mci = pvt->mci;
+	e = &mci->error_desc;
+
+	/* Cleans the error report buffer */
+	memset(e, 0, sizeof(*e));
+	e->error_count = 1;
+	e->grain = 1;
+	e->msg = pvt->msg;
+	e->other_detail = pvt->other_detail;
+	e->top_layer = -1;
+	e->mid_layer = -1;
+	e->low_layer = -1;
+	*pvt->other_detail = '\0';
+	*pvt->msg = '\0';
+
+	switch (sev) {
+	case GHES_SEV_CORRECTED:
+		e->type = HW_EVENT_ERR_CORRECTED;
+		break;
+	case GHES_SEV_RECOVERABLE:
+		e->type = HW_EVENT_ERR_UNCORRECTED;
+		break;
+	case GHES_SEV_PANIC:
+		e->type = HW_EVENT_ERR_FATAL;
+		break;
+	default:
+	case GHES_SEV_NO:
+		e->type = HW_EVENT_ERR_INFO;
+	}
+
+	edac_dbg(1, "error validation_bits: 0x%08llx\n",
+		 (long long)mem_err->validation_bits);
+
+	/* Error type, mapped on e->msg */
+	if (mem_err->validation_bits & CPER_MEM2_VALID_ERROR_TYPE) {
+		u8 etype = mem_err->error_type;
+
+		p = pvt->msg;
+		p += snprintf(p, sizeof(pvt->msg), "%s", cper_mem_err_type_str(etype));
+	} else {
+		strscpy(pvt->msg, "unknown error");
+	}
+
+	/* Error address */
+	if (mem_err->validation_bits & CPER_MEM2_VALID_PA) {
+		e->page_frame_number = PHYS_PFN(mem_err->physical_addr);
+		e->offset_in_page = offset_in_page(mem_err->physical_addr);
+	}
+
+	/* Error grain */
+	if (mem_err->validation_bits & CPER_MEM2_VALID_PA_MASK)
+		e->grain = ~mem_err->physical_addr_mask + 1;
+
+	/* Memory error location, mapped on e->location */
+	p = e->location;
+	p += cper_mem_err2_location(mem_err, p);
+
+	if (mem_err->validation_bits & CPER_MEM2_VALID_MODULE_HANDLE) {
+		struct dimm_info *dimm = NULL;
+
+		p += cper_dimm_err2_location(mem_err, p);
+		if (mem_err->mem_dev_handle <= U16_MAX)
+			dimm = find_dimm_by_handle(mci, mem_err->mem_dev_handle);
+		else
+			pr_warn(FW_WARN "Memory Error Section 2 module handle 0x%x exceeds SMBIOS range\n",
+				mem_err->mem_dev_handle);
+		if (dimm) {
+			e->top_layer = dimm->idx;
+			strscpy(e->label, dimm->label);
+		}
+	}
+	if (p > e->location)
+		*(p - 1) = '\0';
+
+	if (!*e->label)
+		strscpy(e->label, "unknown memory");
+
+	/* All other fields are mapped on e->other_detail */
+	p = pvt->other_detail;
+	p += print_mem_error2_other_detail(mem_err, p, e->location, OTHER_DETAIL_LEN);
+	if (p > pvt->other_detail)
+		*(p - 1) = '\0';
+
+	edac_raw_mc_handle_error(e);
+
+unlock:
+	spin_unlock_irqrestore(&ghes_lock, flags);
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block ghes_edac_mem_err2_nb = {
+	.notifier_call	= ghes_edac_report_mem_error2,
+	.priority	= 0,
+};
+
 static int ghes_edac_register(struct device *dev)
 {
 	bool fake = false;
@@ -490,6 +638,7 @@ static int ghes_edac_register(struct device *dev)
 	spin_unlock_irqrestore(&ghes_lock, flags);
 
 	ghes_register_report_chain(&ghes_edac_mem_err_nb);
+	ghes_register_report_mem2_chain(&ghes_edac_mem_err2_nb);
 
 	/* only set on success */
 	refcount_set(&ghes_refcount, 1);
@@ -533,6 +682,7 @@ static void ghes_edac_unregister(struct ghes *ghes)
 	if (mci)
 		edac_mc_free(mci);
 
+	ghes_unregister_report_mem2_chain(&ghes_edac_mem_err2_nb);
 	ghes_unregister_report_chain(&ghes_edac_mem_err_nb);
 
 unlock:
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index 8d7e5caef3f1..73d099a4ea7d 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -143,4 +143,6 @@ static inline int ghes_notify_sea(void) { return -ENOENT; }
 struct notifier_block;
 extern void ghes_register_report_chain(struct notifier_block *nb);
 extern void ghes_unregister_report_chain(struct notifier_block *nb);
+extern void ghes_register_report_mem2_chain(struct notifier_block *nb);
+extern void ghes_unregister_report_mem2_chain(struct notifier_block *nb);
 #endif /* GHES_H */
-- 
2.43.0

