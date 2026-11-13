Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794576436;
	b=mQrDTMmUPFg4wqOitAk0WkNQWczOQm4pdCMjgBxO1YvVjefcdD1YWoCq1yXmHF/VEmwv
	 U4Mf65U6xR56y3pN5gzSCWnYnANI1H2YLX9aDbkDDip0E3paNNzB2PzfTr1oHSLvV9OsD
	 t0KIcZGEe5GO0qE7aXOVMHbA0YSHDUJjI33WUwscXjpUPknNfm21pLYxY6ByZCswrJng9
	 c+UO07kvgdhrvRGL+u7kKi631u7p7R20Y5HuNlc4/BcmQhownKOgEeSQ3h63HQOWpRuxN
	 0c4a4NBddqCJVcWQsiiiYWvIctW3RW28wac05+jizbTJD43OWPtfTNUqPhqUXCoBS+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576436;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zWO9fTY1l00I493GwG+dvXsBJFpaNYO5JVcgTmMBdGw=;
	b=oqx0xL9QlnKhCL3m+xN0vGKlQb7CNDQrEa9F4EoT0gLyKidagCKszWydEPVdjkKn6DTf
	 CwERdjnnGAYLSTx1BYGpmtqqJo5k94u43TSmY0t4Kj4St6AsEhAHpyiAqw5sEgDd6VNEh
	 ckP3ifL99vPuDL8bJqT5NMS+pa8bt3w+3WmR2oirEv785siofsH10zJeosu6eglBmtWHt
	 L5bzbNndG2NQcyhBz0Hwo7ODGVRB1cCP+mhiybQnzSfucAviWoemq5bvv9GUhxy2zGQKg
	 35yrdfKxr6Ibf/3JgremV8DVqnFhHrv8hfZZ1iEgxpyQ5QdqdywGj7q1Zhpy8LqCeaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Y0RIv9vK;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BAD606ABAD
	for <acpica-devel@lists.linux.dev>; Fri, 13 Nov 2026 13:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5BAD606ABAD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Y0RIv9vK
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11E351476;
	Fri, 13 Nov 2026 05:27:12 -0800 (PST)
Received: from e135073.arm.com (unknown [10.57.14.137])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2A24C3F85F;
	Fri, 13 Nov 2026 05:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794576435; bh=XXjfz1gd37X3boaZweOwGCsLH8DHwjpk9PRswkXYj20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y0RIv9vKI8srtvsbK0zbZfHPs1cxq9pYzTWnADUfK/JSymF8W5/5Q/kyECEOFnADy
	 x7HsDr7h9sc+ig2nisyohdCFE9fMdpUOqulLdPU3C0SbzgZmoZK3vTgeSjQVSSongp
	 fF2z5YyJc4k0dN8V5s6oPRkpaAlb9GgSd+Kq2U08=
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Ashok Raj <ashok.raj@oss.qualcomm.com>,
	James Morse <james.morse@arm.com>,
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
	Dan Williams <djbw@kernel.org>,
	Terry Bowman <terry.bowman@amd.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Morduan Zang <zhangdandan@uniontech.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v4 06/12] ACPI: APEI: Extract common memory failure handling
Date: Fri, 13 Nov 2026 14:24:48 +0100
Message-ID: <20261113132600.3355836-7-pierre.gondois@arm.com>
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

Extract ghes_handle_memory_failure_common() to share the severity checks
and memory failure dispatch with the upcoming Memory Error Section 2
handler.

No functional change.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/acpi/apei/ghes.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 663dc2e601cf..d6bbee466b48 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -528,15 +528,11 @@ static bool ghes_do_memory_failure(u64 physical_addr, int flags)
 	return true;
 }
 
-static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
-				       int sev, bool sync)
+static bool ghes_handle_memory_failure_common(struct acpi_hest_generic_data *gdata,
+					      int sev, bool sync, u64 physical_addr)
 {
 	int flags = -1;
 	int sec_sev = ghes_severity(gdata->error_severity);
-	struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
-
-	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
-		return false;
 
 	/* iff following two events can be handled properly by now */
 	if (sec_sev == GHES_SEV_CORRECTED &&
@@ -546,11 +542,22 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
 		flags = sync ? MF_ACTION_REQUIRED : 0;
 
 	if (flags != -1)
-		return ghes_do_memory_failure(mem_err->physical_addr, flags);
+		return ghes_do_memory_failure(physical_addr, flags);
 
 	return false;
 }
 
+static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
+				       int sev, bool sync)
+{
+	struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
+
+	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
+		return false;
+
+	return ghes_handle_memory_failure_common(gdata, sev, sync, mem_err->physical_addr);
+}
+
 static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 				     int sev, bool sync)
 {
-- 
2.43.0

