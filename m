Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE3D1428FD
	for <acpica-devel@lists.linux.dev>; Mon, 25 Mar 2024 12:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711370097; cv=none; b=LB4vZqRuAsaIQb6wkJmiSFbL7fL2ljccrPDnKvb59EPyZlROGkhvlIQlEEs1VrQHlqd06d/sxxLWXdeOTx7S24UF8N7sD0XKThhW1SFNcC1ri5mcJp8QwviSWPopVp4biIrxnj0HC8CKmfxg4WlWU2uehrinqLYYOaYOpk+2fn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711370097; c=relaxed/simple;
	bh=xP4F0Dzs6Z1vnbHfWvIrP7rhalwxftEshnlKle1DX1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FhB8F+Sqce2TwfSUNSfxnvh0M34Nl1CFgzVvIBCjStVDQonFwjvFFiAW7+U3UMKTckVo/9plioiLk7XAvpJrlD13/l91W0Zd6iOGdY5N2MNcefLz4eopIGXt1R/Aho8guhd2TiG2bz1l0hQYF7N3gYNduLcb58N6CalpC5rFiJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WYPZyPhF; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WYPZyPhF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711370095; x=1742906095;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xP4F0Dzs6Z1vnbHfWvIrP7rhalwxftEshnlKle1DX1g=;
  b=WYPZyPhFFL4l7bT+rgPUwlgFPt9DrHukW7mSzdhpHfk6yMS1ftJ8XC8C
   2DiH4eAftC+/DowQ+B4r4My+na3uOvVKeSR3937IVLB4miha6Vj9OAIrV
   cO7L4ALoE2lClNrGmAbw4bc5pCZN2fRJVXXcMRWiLV056Zd6DmPWnN1ba
   iegkkYTJ3WtuXi031M8sJWharfFQziV4znwpfOBWxRxkg2ef2H+anU4uJ
   yKSP7GcqrKpaE0VCCK6oHs4cCwtiMgI6+qbFRWQDkVxA9MvAdHRJatHW2
   PEq2Q2rqHOferp4Nmlz8UJThcAWEh4zrRl1lZ/bDkb2YCIbrk8qv3Pqam
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6549684"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="6549684"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 05:34:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="937070327"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="937070327"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Mar 2024 05:34:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C4A14233; Mon, 25 Mar 2024 14:34:46 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>
Subject: [PATCH v1 3/7] ACPI: scan: Replace infinite for-loop with finite while-loop
Date: Mon, 25 Mar 2024 14:32:59 +0200
Message-ID: <20240325123444.3031851-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240325123444.3031851-1-andriy.shevchenko@linux.intel.com>
References: <20240325123444.3031851-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The infinite loops is harder to understand (as one has to go
over the body in order to find main exit conditional) and it's
more verbose than usual approach with a while-loop.

Note, we may not use list_for_each_entry_safe() as there is locking
involved and the saved pointer may become invalid behind our back.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/scan.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 7c157bf92695..5e4118970285 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -530,15 +530,10 @@ static DEFINE_MUTEX(acpi_device_del_lock);
 
 static void acpi_device_del_work_fn(struct work_struct *work_not_used)
 {
-	for (;;) {
-		struct acpi_device *adev;
+	struct acpi_device *adev;
 
-		mutex_lock(&acpi_device_del_lock);
-
-		if (list_empty(&acpi_device_del_list)) {
-			mutex_unlock(&acpi_device_del_lock);
-			break;
-		}
+	mutex_lock(&acpi_device_del_lock);
+	while (!list_empty(&acpi_device_del_list)) {
 		adev = list_first_entry(&acpi_device_del_list,
 					struct acpi_device, del_list);
 		list_del(&adev->del_list);
@@ -555,7 +550,10 @@ static void acpi_device_del_work_fn(struct work_struct *work_not_used)
 		 */
 		acpi_power_transition(adev, ACPI_STATE_D3_COLD);
 		acpi_dev_put(adev);
+
+		mutex_lock(&acpi_device_del_lock);
 	}
+	mutex_unlock(&acpi_device_del_lock);
 }
 
 /**
-- 
2.43.0.rc1.1.gbec44491f096

