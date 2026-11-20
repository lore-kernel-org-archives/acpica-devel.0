Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195248;
	b=IaOATzaUDTGPgNLmY1j8Pyv5FARRIgG2FHEHvvBQ8cD6pwE/tz3n2uDvl1R04Q8PIt6u
	 lpyLjk5EEVOXazK0FtW+A7ILQe7hUjL5Cl/KWhn4LyALLmPNb4MJcgQkd8pm1Kov7JdAs
	 7WisPW/HM5K/jm0U8eNTT2sRgeZboO+N5XnkLinXdYU5NzLBEUirl0fIRUpN+KMDM9LzO
	 r/sbF6CThRj8dmfD+Liy5PCwWYzciEZSAypWiPjdBI6VUmGDxxoBE4ed+BkSBsfR67Tud
	 Tg8ByTnB06Abjn9cFb02hFeNIno8bGBDT3EVDZp5YTAERIRolzasfHPkrc9AYIFhwDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195248;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oPl6Fm7k6C0w0fOYmre6kId3JLuNwQWiJIvWNgvEQuQ=;
	b=J1EnpmfEOuwynq391vGH8cSD/kV+jJprXxpKyPrLU8pmBAmbbttVleOjdd0jLZrNpG1h
	 y9W6Glw8e+Dwags8+N888pA4vwHVdQiBw4nf52T+DxA0ood1iif19E5bPbvp24gI+CvWh
	 Uhegwnqk0oOelpr0mLUkJgKAEEWehw+Vh24aHax5Eiu/78qm7S13XLaoWXBpgKkXfiC8D
	 ywJ1t9B0la2VnFtqr/6HjI+dF/xMMjX0uW09S2wFJ1OiCs1KENmkTlqa0LrfYR4l8zXuD
	 AgHDQQ364Lzi6X7Gq9jeAG2m8s/cr2gz1lyYqBPpW6iY1dTncvpnOhrn/0iL4BJhEwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LKO7Dyr7;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D216160A3820
	for <acpica-devel@lists.linux.dev>; Fri, 20 Nov 2026 17:20:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D216160A3820
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LKO7Dyr7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195247; x=1826731247;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jjzuCUGTPS9NeooTCYIT0kb2dtW5hLkhmusAkgysMUk=;
  b=LKO7Dyr7nIhoi/qQKpZ0Siw/Tr2VTwXQrPaTRFLQyUCyUVX4QdKvmRYL
   L6fZcCPWU/Wc4YhZt0v7SyQtBs5bu9ltlncjSi0kOBDCMNARuZZIYV9/A
   5dfo+M2n7QOQBSRNMqWaWtNRe5p0pPbKL5V8F3dGJnHvknhQQ6TqyTVIC
   HfUNrkVQ7ZmPfuRS4VYWFlNjp0SjtwY8jVeggoLLzH27GXDlZwOGUhrYL
   LvYWPCtkL9DTFcuuq77WvTxA2WjMb3lCL4A8wzTvmk/ZMEn8yVpTLDIxa
   cCZkDsBWbGEVXSjXGd/hRhix51o3jtYX88dtRSnNB+J2X77LH9Red6Wfw
   Q==;
X-CSE-ConnectionGUID: Ktxno3/ZTeu5EiLF2aOB3Q==
X-CSE-MsgGUID: E3iePUmGQCCzC3YL4fxOlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157371"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157371"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:20:46 -0800
X-CSE-ConnectionGUID: Xu7fnT3vQz+CiKSOqkdLpw==
X-CSE-MsgGUID: fqqPAZU4RF6SoVn+DfFp4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10867973"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:20:43 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: ikaros <void0red@gmail.com>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/42] ACPICA: Fix object reference update to skip non-local notify types
Date: Fri, 20 Nov 2026 18:18:34 +0100
Message-ID: <acd59dc3f22a2bcb19980f5919d070583c4e9251.1795194329.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1795194329.git.maciej.wieczor-retman@intel.com>
References: <cover.1795194329.git.maciej.wieczor-retman@intel.com>
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

From: ikaros <void0red@gmail.com>

Link: https://github.com/acpica/acpica/commit/53d7ddc850a8
Closes: https://github.com/open-acpica/acpica/issues/1181
Signed-off-by: ikaros <void0red@gmail.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 drivers/acpi/acpica/utdelete.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/acpica/utdelete.c b/drivers/acpi/acpica/utdelete.c
index e8180099d01f..57a0de6a49d6 100644
--- a/drivers/acpi/acpica/utdelete.c
+++ b/drivers/acpi/acpica/utdelete.c
@@ -517,6 +517,10 @@ acpi_ut_update_object_reference(union acpi_operand_object *object, u16 action)
 				prev_object =
 				    object->common_notify.notify_list[i];
 				while (prev_object) {
+					if (prev_object->common.type !=
+					    ACPI_TYPE_LOCAL_NOTIFY) {
+						break;
+					}
 					next_object =
 					    prev_object->notify.next[i];
 					acpi_ut_update_ref_count(prev_object,
-- 
2.56.0

