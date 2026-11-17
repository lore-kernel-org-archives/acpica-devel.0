Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794914153;
	b=zPHUBg//KvEeYljVnDt62TCVsDfllb+b5fle+G2M0uhu4sXUFJ6hs0mrm2PiKJzdlKMP
	 erPzNETjt3QsQ1AyKWbyCV7fg5svJ6/GK/jebbIV84ySvBflTVaAtXCUq/ueKpelOZ/Zc
	 j7V0/+4NETWUmDlNZ8TTOwkVn4G5422A5WOBU5ukv+fXWVAJjuVCvhCNDtE6vlYb0aEvX
	 CiZPUxNUqop7yZo1yGa+FI9Zvlre1qivvQhQScUw6ytP9OYbMxQyFdKzCH6Bxa7e5vcIC
	 hNhi21JJtszCDZwN9Dz1IrkKBjc2G/1RUStGIYN98jRkpXqFC67jwjz/79w2yjdLQeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794914153;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mQgaO4mrJ1/PGb5G6f2VYZd+cZSDJVZYowDL8wylwCo=;
	b=He7DQAVPFSg4eYHg+34aE/wlANeGPxHmWXb9v4X1YAS4VkGczSUjo8g+3sqLj4Jv9wXg
	 3cvhD12gtOFAY8kZmU6H1WAQGoLcMUibucNXFnuacIgqCjx0En4qWQiX3vnmkLFzkmPQY
	 hVT+O9EeXFh/j5zxSUFVEiGTFjm1Ls0WxkbQv1RF3ufoE84txiWfmGhQSyJ6SgvNvTpuh
	 XnALBuxaXZ7t8kCVdmoT51kC6UtHBfU/AqTspB7ygjx1FJXd2gXH1FvTcYs/7YYwOyoqY
	 EwJ18YqF4XFVxCvQZwtUg1h3ElyKc3DmqZDAGKyGt4nKmvmVhbN0pHKm3aCVJuw0lOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ey53Fz+d;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E121B606A323
	for <acpica-devel@lists.linux.dev>; Tue, 17 Nov 2026 11:15:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E121B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ey53Fz+d
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D10014BF;
	Tue, 17 Nov 2026 03:15:48 -0800 (PST)
Received: from e135073.nice.Arm.com (e135073.arm.com [10.34.111.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 341773F763;
	Tue, 17 Nov 2026 03:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794914151; bh=hApODwvFYZ3XYDnq9Y8ZuF8YD8vDXmjk4z8lFM6Cyuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ey53Fz+d5RDQs83ECGw1AmAhQ+qHQ9sl4eduhb/EusQi+ClN+OEp159tnvmtm+6E4
	 8gJ+Q66+Fl7k0xfIjAX50e+vh4UrpPwOKRpJQZlQM2vBwa31m8Ljha5iDvwuwf9GDz
	 kc4Ga55mItNZhNIpYzEJGyr/ebPbSsEP1sx25kFQ=
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
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
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
Subject: [PATCH v1 01/19] x86/APEI: Extract common CPER memory error reporting helper
Date: Tue, 17 Nov 2026 12:10:11 +0100
Message-ID: <20261117111444.4185512-2-pierre.gondois@arm.com>
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

Prepare for reporting CPER Memory Error Section 2 records through MCE
by extracting apei_mce_report_mem_error_common().

No functional change.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 arch/x86/kernel/cpu/mce/apei.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index 0a89947e47bc8..b993ac78a3b36 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -26,24 +26,15 @@
 
 #include "internal.h"
 
-void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
+static void apei_mce_report_mem_error_common(int severity, u64 physical_addr,
+					     u64 physical_addr_mask)
 {
 	struct mce_hw_err err;
 	struct mce *m;
 	int lsb;
 
-	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
-		return;
-
-	/*
-	 * Even if the ->validation_bits are set for address mask,
-	 * to be extra safe, check and reject an error radius '0',
-	 * and fall back to the default page size.
-	 */
-	if (mem_err->validation_bits & CPER_MEM_VALID_PA_MASK)
-		lsb = find_first_bit((void *)&mem_err->physical_addr_mask, PAGE_SHIFT);
-	else
-		lsb = PAGE_SHIFT;
+	/* Missing or zero masks default to page granularity. */
+	lsb = find_first_bit((void *)&physical_addr_mask, PAGE_SHIFT);
 
 	mce_prep_record(&err);
 	m = &err.m;
@@ -60,9 +51,21 @@ void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
 		m->tsc = rdtsc();
 	}
 
-	m->addr = mem_err->physical_addr;
+	m->addr = physical_addr;
 	mce_log(&err);
 }
+
+void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
+{
+	u64 mask = 0;
+
+	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
+		return;
+	if (mem_err->validation_bits & CPER_MEM_VALID_PA_MASK)
+		mask = mem_err->physical_addr_mask;
+
+	apei_mce_report_mem_error_common(severity, mem_err->physical_addr, mask);
+}
 EXPORT_SYMBOL_GPL(apei_mce_report_mem_error);
 
 int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
-- 
2.43.0

