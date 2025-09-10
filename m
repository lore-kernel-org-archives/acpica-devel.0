Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852FE306492
	for <acpica-devel@lists.linux.dev>; Wed, 10 Sep 2025 09:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497198; cv=none; b=Vy2t1S8zwAG7ykWgSIVwNijFJoSRQ0IjS/ghz+iFOQHO31qngETdGBuUr4XKsH0ZPgnBZa8pCCPCJC680IPBQOTjKxF05nNZ1/TuDQ/NdWq4k4HPV9h8B6l3RgKd7fx/RU0ulv5BHIEq+lD85zJici1j8cZRAcc8I6z8tWDCVng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497198; c=relaxed/simple;
	bh=UxDHk+nyHGn6znzf9nre7X54TYbPp1T3sedDzWOhoZM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h+ElTD1HcfN76AUx2VL7DFwAulznXnuVFkn4r7Er4GzcyMCBlr5kSI/J0fLE8A/0dGHTUPvqsSG3U1pfJeFzWYTwtV3+lPtWN+qmkq48856u07rJsXQZkEJ4tA2Qc2x21Lbj2AlSuD6iGoSIQtdQ0ZGoMqNNMsdT2y5MU+sqyto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=p8XW8qij; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="p8XW8qij"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757497193; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=NDjRMqnwvSDtCzogc+S2Va17N1AuCGT5lTb/FjGa+Hk=;
	b=p8XW8qijwazIsQQ6nYTWMCkRGg5baa6ZIEoT6MWDRUsP0W8ad3qyjCnFsX556h1YLPSl1mZ+FNXbl0U5cZMCA56FDO+dVVERRFKmJJRZXb+2o7zX7nC/bzko0DtHzAPSEv+WKehSHnmHdnNOkCNgftCoG3+pFilqAjqQlcryGJM=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WnhXu7j_1757497190 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 10 Sep 2025 17:39:52 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	robert.moore@intel.com
Cc: andrew@kernel.org,
	bfaccini@nvidia.com,
	eahariha@linux.microsoft.com,
	dan.j.williams@intel.com,
	thorsten.blum@linux.dev,
	gourry@gourry.net,
	xueshuai@linux.alibaba.com,
	nunodasneves@linux.microsoft.com,
	wangyuquan1236@phytium.com.cn,
	Jonathan.Cameron@huawei.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH] acpi,srat: Fix incorrect device handle check for Generic Initiator
Date: Wed, 10 Sep 2025 17:39:49 +0800
Message-Id: <20250910093949.5793-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Generic Initiator Affinity Structure in SRAT table uses device
handle type field to indicate the device type. According to ACPI
specification, the device handle type value of 1 represents PCI device,
not 0.

Fix this by defining explicit macros for device handle types and using
the correct check for PCI devices:

- ACPI_SRAT_ACPI_DEVICE_HANDLE (0): ACPI device handle
- ACPI_SRAT_PCI_DEVICE_HANDLE (1): PCI device handle

Fixes: 894c26a1c274 ("ACPI: Support Generic Initiator only domains")
Reported-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/acpi/numa/srat.c | 2 +-
 include/acpi/actbl3.h    | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 53816dfab645..de71b370a275 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -237,7 +237,7 @@ acpi_table_print_srat_entry(struct acpi_subtable_header *header)
 		struct acpi_srat_generic_affinity *p =
 			(struct acpi_srat_generic_affinity *)header;
 
-		if (p->device_handle_type == 0) {
+		if (p->device_handle_type == ACPI_SRAT_PCI_DEVICE_HANDLE) {
 			/*
 			 * For pci devices this may be the only place they
 			 * are assigned a proximity domain
diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index 79d3aa5a4bad..c8488614429c 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -284,6 +284,9 @@ struct acpi_srat_gic_its_affinity {
  * 6: ACPI_SRAT_TYPE_GENERIC_PORT_AFFINITY
  */
 
+#define ACPI_SRAT_APCI_DEVICE_HANDLE	(0)
+#define ACPI_SRAT_PCI_DEVICE_HANDLE	(1)
+
 #define ACPI_SRAT_DEVICE_HANDLE_SIZE	16
 
 struct acpi_srat_generic_affinity {
-- 
2.39.3

