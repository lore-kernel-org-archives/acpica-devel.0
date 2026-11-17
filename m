Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794914192;
	b=Q8ctuHGMnkaYPrwOm8gQP4yuWmcMXH8xYE48vnIrTZcTl0466m/jFkkF8Ijq6AKNpnPi
	 uMd/+9fKgdnxESjiH0r9Tnwh93ZXcOrpa+XeBBXMQk4cYEFPCsjp3XzLfAtKcS9XZJtwI
	 xMvZUoeacDHg1VkIIfNFCQLouSTnwARQl9m4yHAEvP2HLnH1pbiY04PVnH0sHZw6VePL+
	 ByyqsNLDuVJwnHHV16qXgHTgQZpLZElYNIIvAwLQfZ1rRGFmH77Z4V+X2g37GToOz4LWD
	 1q34ZXclipci5LYqGfznv7AucLY/BAbRT2HoY/vAKPX4zJoor+vHdG80EGQSOit2/7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794914192;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=G2N13G5utyTe7izqnWDvvwrQ2fOwakujOweKmNqrGrA=;
	b=H3tPgXK968/hp5waMaKOOhNl3u2gkMLwr6jQnXuCGtR6hRfO2W3eaTzwQiiLB9F+UPd4
	 ZKaV/hkjhpQJm+C3TsukkYzLHysSZ6HYuCepERn9abNc9KuekXa8+d392yz3ByT/gDSCM
	 b3YDJG4As1EXnDE6p5hT1KwCQQqiG1tryG3B//SxThrggY7Ws3WR39J3Bk3ds/OovkSSv
	 8/1qPdGmuJryQOY0o1lyMfFYstGW02ENATm/Cdw1qRaVxzBIVHXLhJ0OulMc5WKATcFnL
	 uyEBzduWDNWdQHsJebtB4Sx2ybsGeee4Vx/i/ASPXz5p0Xnnh2Yde7KP61gXvFWbaEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=UE0kJdzu;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79941606A31C
	for <acpica-devel@lists.linux.dev>; Tue, 17 Nov 2026 11:16:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79941606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=UE0kJdzu
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E28441682;
	Tue, 17 Nov 2026 03:16:28 -0800 (PST)
Received: from e135073.nice.Arm.com (e135073.arm.com [10.34.111.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0A46E3F763;
	Tue, 17 Nov 2026 03:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794914191; bh=nQ/pGewZ6c/kd9JIrH7S2KTGuPSpp1O8X6Rcs0KcnQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UE0kJdzuB5u+54VYGkLHh9IxD6zwtneuQSgzckgRUphS2F6ekg0cdSJG4nhoBtzyj
	 eVdZ3PQcTpnwHS/ywvKtG7aSuAIbf9QXDXq3ei3yhCzJcRN9Ig9Bdk8ebrsbSfPjYZ
	 9WkL0MWcxwOgbX0INOdI6xO0+nf5fQKsj4viqusA=
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
	Avadhut Naik <avadhut.naik@amd.com>,
	Jonathan Cameron <jic23@kernel.org>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Terry Bowman <terry.bowman@amd.com>,
	Dan Williams <djbw@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v1 03/19] ras: Bound CPER FRU strings in trace events
Date: Tue, 17 Nov 2026 12:10:13 +0100
Message-ID: <20261117111444.4185512-4-pierre.gondois@arm.com>
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

CPER FRU text occupies a fixed 20-byte field and need not contain a NUL
terminator. Using __string() can read past the field and, for a short
nonstandard section, past the end of the firmware record.

Bound FRU text in the legacy memory and nonstandard trace events with
__string_len() and strnlen(), as already done for the Section 2 event.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 include/ras/ras_event.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index ce759ee1cf4cc..069c7b3a5e6c0 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -39,7 +39,7 @@ TRACE_EVENT(extlog_mem_event,
 		__field(u64, pa)
 		__field(u8, pa_mask_lsb)
 		__field_struct(guid_t, fru_id)
-		__string(fru_text, fru_text)
+		__string_len(fru_text, fru_text, strnlen(fru_text, 20))
 		__field_struct(struct cper_mem_err_compact, data)
 	),
 
@@ -370,7 +370,7 @@ TRACE_EVENT(non_standard_event,
 	TP_STRUCT__entry(
 		__array(char, sec_type, UUID_SIZE)
 		__array(char, fru_id, UUID_SIZE)
-		__string(fru_text, fru_text)
+		__string_len(fru_text, fru_text, strnlen(fru_text, 20))
 		__field(u8, sev)
 		__field(u32, len)
 		__dynamic_array(u8, buf, len)
-- 
2.43.0

