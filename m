Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794576395;
	b=V+nZX9eqeNb+YVjdQKfADwO0MQAUCvLmPN0ozGqEDB8o2FOkzoZemGzm9L71qlDIAfwg
	 izGfY5QwHNzgPiwonYKS5Xbnns/aAIV8K/MCdeRXD+uLhDGB17PkgLeqABj/q3L69VwsL
	 9vBLnrn9QPabpJN5E92eRjdgCe/XJvP+m4bTnpMeEKzbR6wCMRks+uphixzAfOur4enze
	 jdaencQLyClvzcsFggD7bEgg1mXzokD4XwA8bBwT8uVfBVI9UetxJ0xo4G3E4tfdQ3Qg9
	 g0S3SRciZKSms5o0+Chl1gCkRtceEuqLLJdVOQgCa8kF7Xj7uZzcA1Yt4ghwP3NTNUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576395;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yWn9u4tD+84c6x7/nV1XUypo0WI5wdNfcTUj+B81vhM=;
	b=Usm5ucnerl9mXYekisx6RaL5LGYYvrz7qri+MsKy1yciLArV7PGGYqBMWI/cGGFTjpT5
	 ItSQjSJmuk38151+JSkhkalNKgQqRb3o/SklbDy67KD1Rpv49PivSKFlAMKSZlbgjj2Y6
	 mObBsoLK5XfUjk+hYM9aN6HC1Wvq38kwYe03vHwO5S/GVuqBE86i/E1BU0+PuWIWJQ+Xy
	 1LvL/RXOPg91ymyrXf96JafwdRMVRjuHj1qnGiK+ELL5QeN512rOngJ7cFDwmxBwLmlh0
	 WsPPoJUoc618adu6EL01u1mtiktEXFY97AzftGaJTO6jwvw9LYk+aO7m9Rd/pEG42gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="C9k4sq1/";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAAC606A89E
	for <acpica-devel@lists.linux.dev>; Fri, 13 Nov 2026 13:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FAAC606A89E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=C9k4sq1/
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 941DB1516;
	Fri, 13 Nov 2026 05:26:31 -0800 (PST)
Received: from e135073.arm.com (unknown [10.57.14.137])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7FDC73F85F;
	Fri, 13 Nov 2026 05:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794576394; bh=A/iGec4Uv9uoJL/kSrig5hUGHKwOZqLz/hPd/NTBX9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C9k4sq1/Dgi8b8RMcBx3vwphWVM06nHnj2qBHYE2OQjYvlQToW6FtnUNv+E/H9ON5
	 1upCErNMY+rKtDL83WxePE/iM6cvWpcWeItOxoZgNQfkf7yA3N4es1Ht7GnrLpuR2P
	 MKPituZLJqVAfdhbeOCUWCSOtCFWglCu7v83jEMA=
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Ashok Raj <ashok.raj@oss.qualcomm.com>,
	James Morse <james.morse@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Breno Leitao <leitao@debian.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Dan Williams <djbw@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Morduan Zang <zhangdandan@uniontech.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v4 02/12] cper: add Memory Error Section 2 structures
Date: Fri, 13 Nov 2026 14:24:44 +0100
Message-ID: <20261113132600.3355836-3-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261113132600.3355836-1-pierre.gondois@arm.com>
References: <20261113132600.3355836-1-pierre.gondois@arm.com>
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

Add CPER Memory Error Section 2 definitions to the CPER headers.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 include/linux/cper.h | 54 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/include/linux/cper.h b/include/linux/cper.h
index f532a8a01411..56a73c981ce1 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -199,6 +199,10 @@ enum {
 #define CPER_SEC_PLATFORM_MEM						\
 	GUID_INIT(0xA5BC1114, 0x6F64, 0x4EDE, 0xB8, 0x63, 0x3E, 0x83,	\
 		  0xED, 0x7C, 0x83, 0xB1)
+/* Platform Memory 2 */
+#define CPER_SEC_PLATFORM_MEM2						\
+	GUID_INIT(0x61EC04FC, 0x48E6, 0xD813, 0x25, 0xC9, 0x8D, 0xAA,	\
+		  0x44, 0x75, 0x0B, 0x12)
 #define CPER_SEC_PCIE							\
 	GUID_INIT(0xD995E954, 0xBBC1, 0x430F, 0xAD, 0x91, 0xB4, 0x4D,	\
 		  0xCB, 0x3C, 0x6F, 0x35)
@@ -263,6 +267,30 @@ enum {
 #define CPER_MEM_VALID_BANK_ADDRESS		BIT_ULL(20)
 #define CPER_MEM_VALID_CHIP_ID			BIT_ULL(21)
 
+/* Memory Error Section 2 validation bits, UEFI v2.11 sec N.2.6. */
+#define CPER_MEM2_VALID_ERROR_STATUS		BIT_ULL(0)
+#define CPER_MEM2_VALID_PA			BIT_ULL(1)
+#define CPER_MEM2_VALID_PA_MASK			BIT_ULL(2)
+#define CPER_MEM2_VALID_NODE			BIT_ULL(3)
+#define CPER_MEM2_VALID_CARD			BIT_ULL(4)
+#define CPER_MEM2_VALID_MODULE			BIT_ULL(5)
+#define CPER_MEM2_VALID_BANK			BIT_ULL(6)
+#define CPER_MEM2_VALID_DEVICE			BIT_ULL(7)
+#define CPER_MEM2_VALID_ROW			BIT_ULL(8)
+#define CPER_MEM2_VALID_COLUMN			BIT_ULL(9)
+#define CPER_MEM2_VALID_RANK_NUMBER		BIT_ULL(10)
+#define CPER_MEM2_VALID_BIT_POSITION		BIT_ULL(11)
+#define CPER_MEM2_VALID_CHIP_ID			BIT_ULL(12)
+#define CPER_MEM2_VALID_ERROR_TYPE		BIT_ULL(13)
+#define CPER_MEM2_VALID_STATUS			BIT_ULL(14)
+#define CPER_MEM2_VALID_REQUESTOR_ID		BIT_ULL(15)
+#define CPER_MEM2_VALID_RESPONDER_ID		BIT_ULL(16)
+#define CPER_MEM2_VALID_TARGET_ID		BIT_ULL(17)
+#define CPER_MEM2_VALID_CARD_HANDLE		BIT_ULL(18)
+#define CPER_MEM2_VALID_MODULE_HANDLE		BIT_ULL(19)
+#define CPER_MEM2_VALID_BANK_GROUP		BIT_ULL(20)
+#define CPER_MEM2_VALID_BANK_ADDRESS		BIT_ULL(21)
+
 #define CPER_MEM_EXT_ROW_MASK			0x3
 #define CPER_MEM_EXT_ROW_SHIFT			16
 
@@ -507,6 +535,32 @@ struct cper_sec_mem_err {
 	u16	mem_dev_handle;		/* "module handle" in UEFI 2.4 */
 };
 
+/* Memory Error Section 2, UEFI v2.11 sec N.2.6 */
+struct cper_sec_mem_err2 {
+	u64	validation_bits;
+	u64	error_status;
+	u64	physical_addr;
+	u64	physical_addr_mask;
+	u16	node;
+	u16	card;
+	u16	module;
+	u16	bank;
+	u32	device;
+	u32	row;
+	u32	column;
+	u32	rank;
+	u32	bit_pos;
+	u8	chip_id;
+	u8	error_type;
+	u8	status;
+	u8	reserved;
+	u64	requestor_id;
+	u64	responder_id;
+	u64	target_id;
+	u32	mem_array_handle;	/* "card handle" */
+	u32	mem_dev_handle;		/* "module handle" */
+};
+
 struct cper_mem_err_compact {
 	u64	validation_bits;
 	u16	node;
-- 
2.43.0

