Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792421847;
	b=rAiY1nI83hpo8B24Cm/D+nWJoQ4MZkZwF1yBQWp5a2dJIieq2p3KRtT9H0i2AkOKfq5p
	 rATFPjZfg1ZOuCycKbD/6mw7szsIkeEdT6/NU6lYQiOfL7OW1eeeLY6fSQaTbbDy9Ahe0
	 /f6vr1mGMGGwixkdkiXYgxA4o9x5lYF/4cpwKEhS4azFv8zeDQrOUpqTM8I1O/hY55zs0
	 K6qK7a5qI0VqKBBunQFhsWCt26jCoQPNt1IEA4CLtpimNolYannnV+a5OWd+UJTouqnMN
	 S2NQw5dP1KJViMVHNstRECtK2Zu908J3mOk4o7hIJibd8gxtAJA6eJLTu0q6qPDr/wA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792421847;
	h=Received:Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NvZu5wAJw7wVPwGw1941BiGwWVRqareyrBT9GYgLIkE=;
	b=KJER+cqTZQqYGfB5FlKBz/ih2vRZnT5tOfwRLPsmwP8dVnabSpq/nU4X+Mq0DRJHxnSO
	 ut6WJgaSUOidaUclvGHc8H4n8zUmAHdtOluAfHVVyJLhoNKJpgTjPnSIoQAmBHrrHd78x
	 NXrDbAAo/Zw8MVvXWrUz7aNRDJy4eS9639tgmKNqjM4oi9r8oysa1B4ilNOnUIml2/0iC
	 xlw73ZwT6iL3iEDmYwMNTlRhno06mKskuhmbMhTfspNQQ/hVwa4Nj6dM8dMCBXqeMx3zO
	 aiar0m0E5hbvsPlD6V06VsTjnLcdEyk5Un67FWkBNvTM8LOIKnaNblvaSU89nRNKPog==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=qtmv+HAV;
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D384C60740A8
	for <acpica-devel.lists.linux.dev@localhost.mlmmj>; Mon, 19 Oct 2026 14:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=qtmv+HAV
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E886513FF
	for <acpica-devel@lists.linux.dev>; Mon, 19 Oct 2026 14:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421847; cv=none; b=JDUTUlarG/MHyqKxZ2cGn9zUynwdI0MKFekHgmhv6jn1uqyvBOWv+xMrHReUwx/z/v0i6fHLnz21U2eL/v0qEpTqjwzIeki0UVKUR01PF8+IzqLf6FDyJ2HliIRoBRLDW+PZRKaio7WRMHwbo/HqosnBUvk7KbcsAADilMnicO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421847; c=relaxed/simple;
	bh=rE811uniw/BcAF7L49r/y3yDjO8KixIySFYExBZD9xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nr2AfDlmsmoz9Y/MCXnPx+bY3/XPUdgAyMtHnpKLoQHajWqGFOiJbmHDeDfei24Kkch/21nATNEs7cBc/GFxVrqNF6yelP829YdmVuAX9Z63hCiToc0BBRMzvcKc/LXbjoZcTci7dWZV2uZJpLNUZu0XXDuhd+WltIhFihQBea8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=qtmv+HAV; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A2A71DB5;
	Mon, 19 Oct 2026 07:57:21 -0700 (PDT)
Received: from e135073.nice.Arm.com (e135073.arm.com [10.34.111.131])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 642BB3F673;
	Mon, 19 Oct 2026 07:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792421844; bh=rE811uniw/BcAF7L49r/y3yDjO8KixIySFYExBZD9xw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qtmv+HAVTq9Cvc0K/BhiNQ6Z6rdp24l+LcGFiO85RezJgmz3yFTwNuIc2TiEihB2E
	 dWQhyEn9vk6VH032MNp50yPFKiyJBMKeRydNmKp7HSFw6oB0IGCd4712rs57Q+9BL8
	 Nx1v1KH+zs5ldj9rwz89EGE4jps1gZErK9WhJ4Sc=
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
	Dan Williams <djbw@kernel.org>,
	Terry Bowman <terry.bowman@amd.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Morduan Zang <zhangdandan@uniontech.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH 3/6] cper: use BIT_ULL() for processor and memory validation bits
Date: Mon, 19 Oct 2026 16:56:10 +0200
Message-ID: <20261019145643.1877246-4-pierre.gondois@arm.com>
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

Use the BIT_ULL() macro to describe flag bits instead of
hexadecimal values which are harder to read.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 include/linux/cper.h | 72 ++++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/include/linux/cper.h b/include/linux/cper.h
index 76e82a8d29a2..ed355b240685 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -229,42 +229,42 @@ enum {
 	GUID_INIT(0x036F84E1, 0x7F37, 0x428c, 0xA7, 0x9E, 0x57, 0x5F,	\
 		  0xDF, 0xAA, 0x84, 0xEC)
 
-#define CPER_PROC_VALID_TYPE			0x0001
-#define CPER_PROC_VALID_ISA			0x0002
-#define CPER_PROC_VALID_ERROR_TYPE		0x0004
-#define CPER_PROC_VALID_OPERATION		0x0008
-#define CPER_PROC_VALID_FLAGS			0x0010
-#define CPER_PROC_VALID_LEVEL			0x0020
-#define CPER_PROC_VALID_VERSION			0x0040
-#define CPER_PROC_VALID_BRAND_INFO		0x0080
-#define CPER_PROC_VALID_ID			0x0100
-#define CPER_PROC_VALID_TARGET_ADDRESS		0x0200
-#define CPER_PROC_VALID_REQUESTOR_ID		0x0400
-#define CPER_PROC_VALID_RESPONDER_ID		0x0800
-#define CPER_PROC_VALID_IP			0x1000
-
-#define CPER_MEM_VALID_ERROR_STATUS		0x0001
-#define CPER_MEM_VALID_PA			0x0002
-#define CPER_MEM_VALID_PA_MASK			0x0004
-#define CPER_MEM_VALID_NODE			0x0008
-#define CPER_MEM_VALID_CARD			0x0010
-#define CPER_MEM_VALID_MODULE			0x0020
-#define CPER_MEM_VALID_BANK			0x0040
-#define CPER_MEM_VALID_DEVICE			0x0080
-#define CPER_MEM_VALID_ROW			0x0100
-#define CPER_MEM_VALID_COLUMN			0x0200
-#define CPER_MEM_VALID_BIT_POSITION		0x0400
-#define CPER_MEM_VALID_REQUESTOR_ID		0x0800
-#define CPER_MEM_VALID_RESPONDER_ID		0x1000
-#define CPER_MEM_VALID_TARGET_ID		0x2000
-#define CPER_MEM_VALID_ERROR_TYPE		0x4000
-#define CPER_MEM_VALID_RANK_NUMBER		0x8000
-#define CPER_MEM_VALID_CARD_HANDLE		0x10000
-#define CPER_MEM_VALID_MODULE_HANDLE		0x20000
-#define CPER_MEM_VALID_ROW_EXT			0x40000
-#define CPER_MEM_VALID_BANK_GROUP		0x80000
-#define CPER_MEM_VALID_BANK_ADDRESS		0x100000
-#define CPER_MEM_VALID_CHIP_ID			0x200000
+#define CPER_PROC_VALID_TYPE			BIT_ULL(0)
+#define CPER_PROC_VALID_ISA			BIT_ULL(1)
+#define CPER_PROC_VALID_ERROR_TYPE		BIT_ULL(2)
+#define CPER_PROC_VALID_OPERATION		BIT_ULL(3)
+#define CPER_PROC_VALID_FLAGS			BIT_ULL(4)
+#define CPER_PROC_VALID_LEVEL			BIT_ULL(5)
+#define CPER_PROC_VALID_VERSION			BIT_ULL(6)
+#define CPER_PROC_VALID_BRAND_INFO		BIT_ULL(7)
+#define CPER_PROC_VALID_ID			BIT_ULL(8)
+#define CPER_PROC_VALID_TARGET_ADDRESS		BIT_ULL(9)
+#define CPER_PROC_VALID_REQUESTOR_ID		BIT_ULL(10)
+#define CPER_PROC_VALID_RESPONDER_ID		BIT_ULL(11)
+#define CPER_PROC_VALID_IP			BIT_ULL(12)
+
+#define CPER_MEM_VALID_ERROR_STATUS		BIT_ULL(0)
+#define CPER_MEM_VALID_PA			BIT_ULL(1)
+#define CPER_MEM_VALID_PA_MASK			BIT_ULL(2)
+#define CPER_MEM_VALID_NODE			BIT_ULL(3)
+#define CPER_MEM_VALID_CARD			BIT_ULL(4)
+#define CPER_MEM_VALID_MODULE			BIT_ULL(5)
+#define CPER_MEM_VALID_BANK			BIT_ULL(6)
+#define CPER_MEM_VALID_DEVICE			BIT_ULL(7)
+#define CPER_MEM_VALID_ROW			BIT_ULL(8)
+#define CPER_MEM_VALID_COLUMN			BIT_ULL(9)
+#define CPER_MEM_VALID_BIT_POSITION		BIT_ULL(10)
+#define CPER_MEM_VALID_REQUESTOR_ID		BIT_ULL(11)
+#define CPER_MEM_VALID_RESPONDER_ID		BIT_ULL(12)
+#define CPER_MEM_VALID_TARGET_ID		BIT_ULL(13)
+#define CPER_MEM_VALID_ERROR_TYPE		BIT_ULL(14)
+#define CPER_MEM_VALID_RANK_NUMBER		BIT_ULL(15)
+#define CPER_MEM_VALID_CARD_HANDLE		BIT_ULL(16)
+#define CPER_MEM_VALID_MODULE_HANDLE		BIT_ULL(17)
+#define CPER_MEM_VALID_ROW_EXT			BIT_ULL(18)
+#define CPER_MEM_VALID_BANK_GROUP		BIT_ULL(19)
+#define CPER_MEM_VALID_BANK_ADDRESS		BIT_ULL(20)
+#define CPER_MEM_VALID_CHIP_ID			BIT_ULL(21)
 
 /* Memory Error Section 2 validation bits, UEFI v2.11 sec N.2.6. */
 #define CPER_MEM2_VALID_ERROR_STATUS		BIT_ULL(0)
-- 
2.43.0

