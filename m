Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA7B411FA4
	for <acpica-devel@lists.linux.dev>; Thu, 24 Sep 2026 07:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790235504; cv=none; b=rXgYD8oOETcnr7pACBlL8ReyIvKZ2hg+8dxDXysi7NyZkghMuub6D6yD0f1OxhlORGs/sqDMRp5s2+/PQXiuQX4dlBYJacOMPiFbBm3YNaSE+BsXuc+e5YJ5jWdAoik2Sdvh4kJ0U/msygwkUbT+e5/jEkA6GtRS06d//LbXZEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790235504; c=relaxed/simple;
	bh=8XXN0JGE+aNQHVmkja0kyVPhb+92/XFFTPds/Qxn2ME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KB9nDHBZTbhbIf5zaNUfE/OiDtcZH8IMeSx83FhDP5lZsslHPKvp2goWXRVeYron+ilsVqydmrIiW+P+zLVTECVURU4sB9Qd30utkcv1CxeLYGTrNie9P5PjOLnY072Mo868xqPJBDRk0Kc9qjczhJwxrGfvuhrCNuiSsnMTtQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YvApSJIg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g8Tad7Ol; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YvApSJIg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g8Tad7Ol"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5eHBf1898746
	for <acpica-devel@lists.linux.dev>; Thu, 24 Sep 2026 07:38:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=LEuz0IYkO3v
	v3NkIV9hKvUGxpNw0DLo4XFrqlBEvznA=; b=YvApSJIg26yiUkCIqtY49o2Rn2S
	RQZLEU/0abNuxebWy1i691/5YtILrNLLRVrmrdr0Zs/dvgXDOj+HT1Mx7i7YvCwt
	VqSJ00sq6XIdnsMNrLa38U96SbH/QtvcrCz5HRZXMI+OWyOQb3tcIE5Se/zls/z9
	fH5r+OhALjcfF/bOM0BCBSouBgsqHyNKQGnx5ANzOTZi57NUdzqw1TbwZOetXhHP
	mUAuO9IzAK+kwKxdqvtlSAQ0RNPttMR6f8ilttFqK9QY/j1+4UCSTPnbPIMC/Xih
	DTcrRfL0m7D2nGcBTIifQyTDXcGFmkdVdj7UwWe+NdWfMzZI4uxzAc9WlcA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvdb64fre-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Thu, 24 Sep 2026 07:38:21 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso3003580eec.1
        for <acpica-devel@lists.linux.dev>; Thu, 24 Sep 2026 00:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790235501; x=1790840301; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LEuz0IYkO3vv3NkIV9hKvUGxpNw0DLo4XFrqlBEvznA=;
        b=g8Tad7Ol3CL9duRGf7D9mmcm2YYSGmmkrUiMfBSCEK6Qf7ZH/sZ13YxNVRkDubCgpK
         Jr8Qu/boDxcRL6vIWbJtKdc54fam7Lse8mU+yby0G2Fy9HR2o6CIWkgdnmKtIlFG+hXJ
         rL3MvjHKpiexcsUPPXI95WT3JX8vUiB5HFGneKF1XV0vPmX7GLFMvcjY1Y3MWqCzDRFP
         h8YRZ4vxhRcURxnY+8kyXul8fUpuB/P21VELnJCTBLUQ2tq0uPJzLHqZubl3zq6Hiiij
         dCZmroC/8X5U/gz9+gxDEOlBNvKBrwFEPSFOWjmG10JIbfKNDOnZpPG2wBxoyOovesjM
         Yu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790235501; x=1790840301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LEuz0IYkO3vv3NkIV9hKvUGxpNw0DLo4XFrqlBEvznA=;
        b=DAP64ophYzypKN+PPo9wyK8Bq/PmGXsMnXUvVEnKCGWfkSoeMRghEkRmk1dzNAI++G
         dwE1Sww8q5wDyNXgt7XGUN4OhIpKdL/+4UcykMjabNPIuVi3w41lisxaLeDY3y/oYdek
         XUNv8dFAztIv2L1f+d45K65aJpkDRkhR4m4Y4w3ETTErIomXqJa/FyP3bBKyOnhy/ZOk
         vAmF2Z1VENVg6C21Ti2F+MRSRxo3xpPyedwfYfNgoXFsy63F8u6RJMkQ6ZWHNdpnO2/t
         MGOcMZGPY633T76+6+28joTyHw6eWPDkFJCZgbH0sHh5ZrZFqzdvuva1RNEfmw3/YOty
         y67w==
X-Gm-Message-State: AFuF++mw8606KUJzNeQ1qtLnEspO3Fxx841L9tsWIjBGgsmSmaeX6ZEU
	eN5aaYblqjdq6o+wHh+PvLf2oNSURgFO74ZL15TFLcaRsP9XXIPZ1tseRnlNt6PJycvuuw8Dpvl
	FfOXpH0LCkINn0W6D5xalwguJ1Z9ehOSCJ/aKVgka7A5rkQCaR/IZ/oCaOGz/9IhUPyM=
X-Gm-Gg: AYBFou02/4TGM7ZJCHQUro2pTK99kqsb9tlqe64aiNVlLBmbbX0pQ+p3zS7ZUIJIs+Y
	h2W6/lkMPv6iphypFt47MjqIAYj3CZQ9FRBJK9+ioXllQpNgiLyjlwRJcyFNZ2BVeu54wTOj00o
	Mls0gD/VErLNd2Tz6AbaLry9/XGxlpBWgKH45nqFtWsNhFl3snecQt6AdIp/HuchX+u0k2PQC1K
	2W0902eEWf0jP0WzgQKncPqc/0FxCivlZ8oaN+I/fQnVlpZGHd9UWFXH0gliBj83puPT6A7D+2u
	QC+oozigNjnVM7JBbxN4saozVd/hKYj2URs3ySn78SJa/X9lQqzbi7k5Mnghklkj6S2CAhivoDf
	zzNRUkunGIzPrqXcqw3FBeEBP4EkvKKbW7QPssxRsPjh4OhBjwMWpTWoAkRL26vuBnh888ndRsO
	122wilkA5VpcYKetLG5l2Y2rn4
X-Received: by 2002:a05:7301:4441:b0:33c:1ff7:8681 with SMTP id 5a478bee46e88-33ffee597f0mr1649413eec.15.1790235500395;
        Thu, 24 Sep 2026 00:38:20 -0700 (PDT)
X-Received: by 2002:a05:7301:4441:b0:33c:1ff7:8681 with SMTP id 5a478bee46e88-33ffee597f0mr1649373eec.15.1790235499750;
        Thu, 24 Sep 2026 00:38:19 -0700 (PDT)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e95c7cfd9sm12120680eec.5.2026.09.24.00.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:38:19 -0700 (PDT)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org
Cc: acpica-devel@lists.linux.dev, anup.patel@oss.qualcomm.com, ardb@kernel.org,
        conor@kernel.org, james.morse@arm.com, lenb@kernel.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robert.moore@intel.com,
        sunilvl@oss.qualcomm.com, tony.luck@intel.com,
        zhangzhanpeng.jasper@bytedance.com,
        Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v5 9/9] riscv: Enable APEI GHES driver in defconfig
Date: Thu, 24 Sep 2026 13:07:14 +0530
Message-ID: <20260924073714.1650588-10-himanshu.chauhan@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924073714.1650588-1-himanshu.chauhan@oss.qualcomm.com>
References: <20260924073714.1650588-1-himanshu.chauhan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: OGFFM2yozwqo72EDQwomoR5GGLETL5Jz
X-Proofpoint-ORIG-GUID: OGFFM2yozwqo72EDQwomoR5GGLETL5Jz
X-Authority-Analysis: v=2.4 cv=QeXzLcbv c=1 sm=1 tr=0 ts=6ab4d36d cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=xUlk1AThICIXWUt23vsA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAzMiBTYWx0ZWRfX6pmgw2n75BX8
 Ayqpqr2ZFJSslB3+mJdRWuliIMhDnwgsmrw1+ER9On+RA8ml06/QyuImxwaAa8Vpipzu68RW6NS
 s/B7OZkvZ9aPeoY8gT4y5jk+XpRzEOg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAzMiBTYWx0ZWRfX9NEB5iKqDDil
 E63Re5hVVXd+xU4pZ5OQo+mVXSPbObxK13URMN0KFobnZ4oiuXb2fo0/hnHxtp5tweqeLeuN7VM
 hOwujQ2mq8OQ7Sa1aHTNhO967gu3iFFdYmtNqCymJL200P/AwcMMJQHR5YBGXVTKUAcOqQY9pxm
 xRa33ZepNsEME5dQj1febFa3n5LvTWIn8NNCapPzEZsiDBCTlIwFfY6h1epkD7hHqlAr+Q8beCN
 n0V18qKjr0oKBeZIvnozo9pY4e8x7rJTKNBxJLcK9GcTDtfAWSzggF2nZxeXSe8xEdUl9BZ4Kdc
 MXGHzewO9XaPT53lqVzL/9giOx3/lHte3+fISLKymK9JH9Q3VjcAbgMAW5235fUPjKIhKQqjBkR
 5Gj/UjOZxynBYeVmz1cg8fY9M2jGnSVdfjEVE0gyGh4QhsrpepQGRbKV62UESGvDn9hu+pqK6rr
 mf6Z9rpGHKzXCt8+M9A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240032

The APEI GHES driver is very important for error handling on ACPI
based platforms so enable it in defconfig.

Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
---
 arch/riscv/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 04ae305d5511..66353b22298f 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -48,6 +48,9 @@ CONFIG_ACPI_CPPC_CPUFREQ=m
 CONFIG_VIRTUALIZATION=y
 CONFIG_KVM=m
 CONFIG_ACPI=y
+CONFIG_ACPI_APEI=y
+CONFIG_ACPI_APEI_GHES=y
+CONFIG_ACPI_APEI_ERST_DEBUG=y
 CONFIG_JUMP_LABEL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-- 
2.43.0

