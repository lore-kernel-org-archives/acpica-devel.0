Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79EC219A89
	for <acpica-devel@lists.linux.dev>; Mon, 17 Mar 2025 06:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742193503; cv=none; b=qAROtEAU5xqqAqTPpt+SgMh57kLLDf9lbS2JPJ6jyPzD/iFQlhOnF2ZMONoqfOeDKsWP//M7cImBwy6rBC3vF+MNQCkZTPU9wz4hiz9ynN7LgoPlTNp7Cq54kfOiQwM5n3diSVC789jYoahvKaj9FeIASX986XGGrpc9AzMnA74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742193503; c=relaxed/simple;
	bh=eruNzRwTOpaRmrW/71RoAXKODrnvfE3/jBaveuW3O1o=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=BNErobb9ftp6bDzScvcOq7XWSCcv29+vPMXfoz8cLF7JWwg0bLK6SBFMtXaMaeHvVjTH0mUWGrn6PmD9Ev0h4S61XAjbMfb2M/Ws7VlwQHOkeOvIpok1A1y5P6YUbT9R9x8XBKf49f9BmGa1Jwp08xWc/x5UifsmAi/tC3z9BLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZGQK60J68z5B1J4;
	Mon, 17 Mar 2025 14:38:18 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 52H6c46Z033413;
	Mon, 17 Mar 2025 14:38:04 +0800 (+08)
	(envelope-from feng.wei8@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 17 Mar 2025 14:38:06 +0800 (CST)
Date: Mon, 17 Mar 2025 14:38:06 +0800 (CST)
X-Zmail-TransId: 2afc67d7c34e210-9c6d8
X-Mailer: Zmail v1.0
Message-ID: <20250317143806244wrGxYdlssPbWp7T7W5Gbr@zte.com.cn>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
From: <feng.wei8@zte.com.cn>
To: <robert.moore@intel.com>
Cc: <rafael.j.wysocki@intel.com>, <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBBQ1BJQ0E6IFJlcGxhY2UgZGVwcmVjYXRlZCBzdHJuY3B5KCkgd2l0aCBzdHJzY3B5KCk=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 52H6c46Z033413
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67D7C35A.000/4ZGQK60J68z5B1J4

From: FengWei <feng.wei8@zte.com.cn>

strncpy() is deprecated for NUL-terminated destination buffers. Use
strscpy() instead and remove the manual NUL-termination.

Signed-off-by: FengWei <feng.wei8@zte.com.cn>
---
 drivers/acpi/acpica/utnonansi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/utnonansi.c b/drivers/acpi/acpica/utnonansi.c
index ff0802ace19b..1da9b8246011 100644
--- a/drivers/acpi/acpica/utnonansi.c
+++ b/drivers/acpi/acpica/utnonansi.c
@@ -168,8 +168,7 @@ void acpi_ut_safe_strncpy(char *dest, char *source, acpi_size dest_size)
 {
 	/* Always terminate destination string */

-	strncpy(dest, source, dest_size);
-	dest[dest_size - 1] = 0;
+	strscpy(dest, source, dest_size);
 }

 #endif
-- 
2.25.1
