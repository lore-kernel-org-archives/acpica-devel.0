Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5205487B8
	for <acpica-devel@lists.linux.dev>; Fri,  2 Feb 2024 08:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706861703; cv=none; b=HmzxYG65yVVYB/9ec/bxmAKf3VqRkIXeKqyugqgKdsM6pnAkyK/GOsLk0+NrX4Y02Lj65v2zwxV1zyY8YXepbr5RC33ezX1h5JJj9e0C9JL6a99ZGXaqZFLurIv5VeheJTj9sD8CX0af35kqg9OqnPOZWelkcpuFRNk5lnsvJuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706861703; c=relaxed/simple;
	bh=MKELfN/liQILzbsoAJhhsGuJidlhOwTtBA1W19GP9to=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=haStVSqH5HjRpQQxQi0GcF3ONCCTF6U2oJcMxtcQZZn9Nok/4InLfFaV1a4wvV1ERvDi+Dnhu4nz7wMiYogpB1T+KJrGWlABiw8YNF4JBqCAdCSdnaJRO/+EjRFY+GvkmbmW00YdX0rACR4rP2EevfiNGMxjIAWS98lYBw7XLJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fXR5uLs+; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fXR5uLs+"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706861694; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=UDm1iREhmWJkprQXJzTP/PsdWlr/hSrAJos2XAwg6I0=;
	b=fXR5uLs+Mizp9fimrwB33m89xsIbhhUfQKj/7Hcu8qHPqi5Xt0glJJThA8DSSrcesDkF+9Iq3UKr9MKLV60R9dV1TGpzcTUtF/8DxO/kHloetN2JyI5+5Abu3tyTO2TrzPgRMivzzku+zjw2SKU0+sQdLvmiqvpUlGNhaSm68eA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W.wPoio_1706861684;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W.wPoio_1706861684)
          by smtp.aliyun-inc.com;
          Fri, 02 Feb 2024 16:14:53 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: robert.moore@intel.com
Cc: rafael.j.wysocki@intel.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] ACPICA: Use swap() instead of open coding it
Date: Fri,  2 Feb 2024 16:14:43 +0800
Message-Id: <20240202081443.1099-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Swap is a function interface that provides exchange function. To avoid
code duplication, we can use swap function.

./drivers/acpi/acpica/nsrepair2.c:896:33-34: WARNING opportunity for swap().

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8168
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/acpi/acpica/nsrepair2.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index 1bb7b71f07f1..ccd89a82a4e6 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -875,7 +875,6 @@ acpi_ns_sort_list(union acpi_operand_object **elements,
 {
 	union acpi_operand_object *obj_desc1;
 	union acpi_operand_object *obj_desc2;
-	union acpi_operand_object *temp_obj;
 	u32 i;
 	u32 j;
 
@@ -892,9 +891,7 @@ acpi_ns_sort_list(union acpi_operand_object **elements,
 			    || ((sort_direction == ACPI_SORT_DESCENDING)
 				&& (obj_desc1->integer.value <
 				    obj_desc2->integer.value))) {
-				temp_obj = elements[j - 1];
-				elements[j - 1] = elements[j];
-				elements[j] = temp_obj;
+				swap(elements[j], elements[j - 1]);
 			}
 		}
 	}
-- 
2.20.1.7.g153144c

