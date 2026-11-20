Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195229;
	b=vZ4fPtz0aEEB9Y4tmzLEr7xCMjWLaYm9B2bQnokXyveLAUE87A2AfD0iR40aHH6cLy6W
	 nRsnCQNuv3eKhX5gzVYrcEMLobmwN7BhQIYNOHBRlApkaeyhzMF+cjhWmvKhaezm4A4+I
	 y134R0rl4WfKad7qqMwreefyieIUXOSee5WLcbLth2kSh/QUCfgRGguHLoMc7y6tSBAPO
	 lytotpYy7/ZOuO6BTlCSRQKGLk2pxYylRrabaHk6ciraDDqylozI/odQ/FhTA/P4LwmBT
	 FXILfZcAimWsmajy9CYk2pNvyMoYH0QYR9rZyziVeuivGl7+hjGBIqdIber3GptLBlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195229;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tC0y5OPQI+lgwvTV+5FizcoEFO9EStGTpf/MJaL1HrY=;
	b=MLqq0dAzUQR2FkRBpc2pdm0GZUJU9dd2RQk7MFh+Z26h6fBrjuOYVw/DKGD56AGgWykN
	 Qweq3qt/zxUuArysQDky8rn3vNmk6QBy58z0bme6brlA9VOjrZlClglKPw9ZvDY+YcmXp
	 PKglNl+VxxrX9D6kxmK/pNPxsNHQN7fZRJK/fz57l4Sxwi15Z7oHT0m7MVWVKw+DvzbWn
	 w3NqdsmG2n06kPTo0ok+Zx6AhztJRmpCkH39vpTBRPyiCTpwgFAQJzYl/qDgZ9/lrdRvm
	 Wi5cNP4zGCyWwLSyszHPCfmO0h4PRy+6LloCo7CLW1Q9CBn3jSejttoSPLkFfNrl37Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=If1YAY0o;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB04606A336
	for <acpica-devel@lists.linux.dev>; Fri, 20 Nov 2026 17:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EB04606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=If1YAY0o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195226; x=1826731226;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FXDw8y1OPfs5v27YAVnr+SYY4fb37hufK8wKV9W4ylM=;
  b=If1YAY0o1gqJtdjZn5oa+IKnhte1MERmm0y1qxpM4weCPpfo4WuDUhtC
   1pdkW+fqCJdHA4b1N84sP6AEoFS56nf3kdoEGXRQgSp2GT0mMhm6+suw/
   z1NMJwC4Jld1InzT34/Pk9U8fQAUbU3OYV6v69w3LR7pEmEYXilNjvLf6
   ZkIfkeIaX8ua1jzyyuwYg/mu2jEyrI764LK7NZVM8dx6oT5i3+48lrtIl
   g3f7kWKdTZbANLaN/WYDonLbZlsFnXwc03xzoE7mf4pmOeXh8vXGjt1eb
   atmT0gyMg7KAGSQrXzTAK0rVSEFuhvK0POc8gT9Meey98j8C30cMOPakE
   g==;
X-CSE-ConnectionGUID: 6+qY+JrXQm6sw9fEGPhpMA==
X-CSE-MsgGUID: q9ms78QdTzGiRKkf3/95sQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157303"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157303"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:20:26 -0800
X-CSE-ConnectionGUID: vbnLXLy8Q+mVHcHGr9p37g==
X-CSE-MsgGUID: bPR38W2KS5Ke8YWGIdkzxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10867865"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:20:23 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/42] ACPICA: CEDT: RDPAS: Fix incorrect field positions for RDPAS
Date: Fri, 20 Nov 2026 18:18:27 +0100
Message-ID: <24493c0a326677bef5c42fc8ed0f09397b13ddbc.1795194329.git.maciej.wieczor-retman@intel.com>
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

From: Dave Jiang <dave.jiang@intel.com>

The 'Address' and 'Protocol' fields for RDPAS are reversed.
Correct them by swapping the positions.

Link: https://github.com/acpica/acpica/commit/041416c33eab
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 include/acpi/actbl1.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 5b4207af046a..3fa9cd46271f 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -588,8 +588,8 @@ struct acpi_cedt_rdpas {
 	struct acpi_cedt_header header;
 	u16 segment;
 	u16 bdf;
-	u8 protocol;
 	u64 address;
+	u8 protocol;
 	u8 reserved[3];
 };
 
-- 
2.56.0

