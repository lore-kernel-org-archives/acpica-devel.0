Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA9B1531D7
	for <acpica-devel@lists.linux.dev>; Fri, 30 Aug 2024 07:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725003959; cv=none; b=bHwx4SrkfrqzUX6cNlc50D3SFGV6yBMESlPdaa58GLH8Ly1QKyFY/fvrtiFB555NhWcncbWAqadfDr6EIIzV9EYFu5U+h4UFPVvRwn3K/0iagD0uk7E4PD9tngGID5YbfLYIdfUbF70pyLGxBoau9nUub1qj9SdGpY8OPCqizjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725003959; c=relaxed/simple;
	bh=ycx7Af3gGC2XDqHn8dU+KgLtCV6QPuz0Wv4IRaTBr88=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VEg7AokjAcIhgxqXlYJmvnOqfCNV7bRuybTqNVezBb12O4T3+IeumOs5ZGf2FgtENlYun/XXfSLClOmwVWM6E3OF8ssbqBND9mj4xcDhltiI2I4eWCo7aymiHgD2k2vvuAlhe8YGkqfS5i7KaJGQa4gwQ9tUQOlLvMX3IRVDBpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Ww9951Kw4z1HHs8;
	Fri, 30 Aug 2024 15:42:33 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 0955214011D;
	Fri, 30 Aug 2024 15:45:55 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 30 Aug
 2024 15:45:54 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <robert.moore@intel.com>, <rafael.j.wysocki@intel.com>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<lihongbo22@huawei.com>
Subject: [PATCH -next] ACPICA: Use swap() to improve code
Date: Fri, 30 Aug 2024 15:54:03 +0800
Message-ID: <20240830075403.3540985-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Use the swap() macro to simplify the code and improve its
readability.

The target code segment uses the bubble sort, we can use
this macro to simplify the code.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 drivers/acpi/acpica/nsrepair2.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index 1bb7b71f07f1..5d56b2fd9151 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -875,7 +875,6 @@ acpi_ns_sort_list(union acpi_operand_object **elements,
 {
 	union acpi_operand_object *obj_desc1;
 	union acpi_operand_object *obj_desc2;
-	union acpi_operand_object *temp_obj;
 	u32 i;
 	u32 j;
 
@@ -891,11 +890,8 @@ acpi_ns_sort_list(union acpi_operand_object **elements,
 			      obj_desc2->integer.value))
 			    || ((sort_direction == ACPI_SORT_DESCENDING)
 				&& (obj_desc1->integer.value <
-				    obj_desc2->integer.value))) {
-				temp_obj = elements[j - 1];
-				elements[j - 1] = elements[j];
-				elements[j] = temp_obj;
-			}
+				    obj_desc2->integer.value)))
+				swap(elements[j - 1], elements[j]);
 		}
 	}
 }
-- 
2.34.1

