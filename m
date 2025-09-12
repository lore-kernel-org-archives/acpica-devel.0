Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13806259C9C
	for <acpica-devel@lists.linux.dev>; Fri, 12 Sep 2025 15:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757692071; cv=none; b=IXb3ETyLn81s2/HHK+KokXcQsK6wEaWYpRJ7pDLiVdVwFdqT1i2QhFsCy/NusxOuztXH6TaU/6kWX5vR1NBP4WaIeuqmb8yragxASKPmRbRY1X1DJiUMr7HuGMDa2Qn0/+TiV8bg0tpo6dOHMq+jYc6k9E7ipznrm2zx6zt2Nlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757692071; c=relaxed/simple;
	bh=jPe1pdv9rph8uVbl98SfuP23RiP7V6VDtBfkTK5lkSI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bQcTSDnCdCKDj2mRKBTWC3HV/ItHA++ihgBzaKp4rVvxiatsMGc1yFPtMGAqAyq9v+OyA6VXvZHwkSz8tmWk+E/qHYAsU49YLHNVdGgFC4Njy1Kovu4yGWu8chq07DWiN08Aomidq+GHTUnqlcychvpeGTemEBvoNbhs99Hy8a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=Xo/rFNoS; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="Xo/rFNoS"
Received: from LAPTOP-N070L597.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 22a15e980;
	Fri, 12 Sep 2025 23:47:39 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: rafael@kernel.org
Cc: robert.moore@intel.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH] acpi: replace ACPI_FREE with acpi_ut_delete_object_desc
Date: Fri, 12 Sep 2025 15:47:35 +0000
Message-Id: <20250912154735.158537-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a993e9c5da603a1kunmf7421b2a2a66ff
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGU4fVklDT09KGk8YS0weHVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZS1VLVUtVS1kG
DKIM-Signature: a=rsa-sha256;
	b=Xo/rFNoS1dz+c0yx+HedhqhhqKgS6VOs02EpGJlZ+ROoYv3jt7JF0MFeEBwRqFvpp11mzAIkZZLDxwUOpXYrhRiw50Jd+FuLdoEc2zPJPv6pXoBkOpLLkYcX8GLEagXU/Y8JaNKHoB/+jsESq0aDeDCcpuSree6Z4H178pAaWPo=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=b9yWIDSto645FMwYolwTKJoPgHsiJq2d08oXP46kQO4=;
	h=date:mime-version:subject:message-id:from;

acpi_ut_create_internal_object may allocate memory from a slab cache
via kmem_cache_zalloc, but the code currently frees it with ACPI_FREE,
which calls kfree. This mismatch prevents the object from being
released properly and may lead to memory leaks or other issues.

Fix this by replacing ACPI_FREE with acpi_ut_delete_object_desc, which
matches the allocation method used for internal objects.

Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 drivers/acpi/acpica/nsxfname.c | 2 +-
 drivers/acpi/acpica/utobject.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
index 1db831545ec8..b6895a48ae68 100644
--- a/drivers/acpi/acpica/nsxfname.c
+++ b/drivers/acpi/acpica/nsxfname.c
@@ -601,7 +601,7 @@ acpi_status acpi_install_method(u8 *buffer)
 error_exit:
 
 	ACPI_FREE(aml_buffer);
-	ACPI_FREE(method_obj);
+	acpi_ut_delete_object_desc(method_obj);
 	return (status);
 }
 ACPI_EXPORT_SYMBOL(acpi_install_method)
diff --git a/drivers/acpi/acpica/utobject.c b/drivers/acpi/acpica/utobject.c
index 272e46208263..8362204b57b5 100644
--- a/drivers/acpi/acpica/utobject.c
+++ b/drivers/acpi/acpica/utobject.c
@@ -148,7 +148,7 @@ union acpi_operand_object *acpi_ut_create_package_object(u32 count)
 	package_elements = ACPI_ALLOCATE_ZEROED(((acpi_size)count +
 						 1) * sizeof(void *));
 	if (!package_elements) {
-		ACPI_FREE(package_desc);
+		acpi_ut_delete_object_desc(package_desc);
 		return_PTR(NULL);
 	}
 
-- 
2.34.1

