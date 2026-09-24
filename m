Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B68341D4F4
	for <acpica-devel@lists.linux.dev>; Thu, 24 Sep 2026 07:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790235474; cv=none; b=Z42O4i4JQHfuv145uiRd6tHQ06BpFHGYrHf3bCo5SmE59i4HcnqvY7oo2WEmgaj4qQlTp6yCcbJio8AfRlzPZgHLrywLZvKbnE74/eYtfkX6cjgYcuIyaSGRi1ovKv2xFF6E1HHbcg4yc9R8A6o92xVLyCms5Xij2T/FgWph0pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790235474; c=relaxed/simple;
	bh=yPs54dR1sQ34iP9KP9L79uS4Msk6zBOQyyBaMkNA7CI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uXx5wZESZd2uvgq1cfyUvRTysXAIQFxibzVLvCnPIvtkIbsME+33zsyiEMtslWhufMm+KBHXAopE2pHh3lvJSeBvQHwZ0FNEKj1N8meBK7iRVVYmAnODltD7itjT7mirPHNk6oaDMSafBHsh3t9YG20oYn6x2uZFkJ5UOV10+xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nUwXmaQA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Qs7WLknw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nUwXmaQA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qs7WLknw"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5eEHa4147379
	for <acpica-devel@lists.linux.dev>; Thu, 24 Sep 2026 07:37:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mknxxgoL3HW6ZUvafxGrZ8mdSHeN5aHUem6OHhh1IYY=; b=nUwXmaQA9SMdg14Q
	CXyYKtbH9a8HcwYYPNRPLL6vT2m1D8krKkkSA4YBkS2eP0MV8JkK9O5m11/XUA89
	tLX88fNfcSsuulD+yOq4DqZJWoqcNrCA7VDBIYFoHXNMIi9bpEHMYRvs/nQ5ulqh
	/IuKUrkYPPbOxBzCj05KTR/PGz/xFO14YZBpeT9dBWEbUj9IhD0d0IYfG6Gkxeg0
	HrtSVptcKdJM1q4ISr5ViAY/oscqbogbcyKNX3hqV7t1H8DOuYjlggAMVIxhsDsy
	xyk3BmtvLVUFZKDxRwGgD3K1/c1PJdIxfXQzbPXlq/G1J1+1fke6GR0E5kr5O4Jc
	CXltPA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfjv3w3t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Thu, 24 Sep 2026 07:37:51 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30f1b904861so2472024eec.0
        for <acpica-devel@lists.linux.dev>; Thu, 24 Sep 2026 00:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790235471; x=1790840271; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mknxxgoL3HW6ZUvafxGrZ8mdSHeN5aHUem6OHhh1IYY=;
        b=Qs7WLknwKH586b0uPutXYce1GGDux5SJ8XAbFVrk+cYeWkz329e698yXKS17jAzkIR
         PM5506Y6Vf5zt/ha4UvjgkNEnZkQywxt0HTQxVjq0zHtasYWGgUM5rwwqAEVuLG83s+O
         axHQMoYANb+VJ4X1bmbdRpeqLyfgJOXoOKA8MZUiq1ztq7ncv6DtKzkFcM+r1ohHlvXJ
         ZFKeDJzHN+lqVober0vWRsZ4TICRpQczDP6Sm0vEn1P35nkEQuHbPZT5DkrCC5pVJsLy
         o9nwQgz4KB2sg2rEy5VaQ0LmE4ngmgMn3L15GJ5HKqDCiKclL7s7T1NO8nup4KjWQuwz
         qmFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790235471; x=1790840271;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mknxxgoL3HW6ZUvafxGrZ8mdSHeN5aHUem6OHhh1IYY=;
        b=MmAj5NIUKRWqat/96Uybj9AzbZbA6E5/Gimre7vvqL9PpbJ9rRxsvyRfU4AgFM4LNf
         81bgRGQbtPkcfghzEpDA1qWHTEsziYN0/fis9iYgKHkpyAsZodOiy9kFLJ0mVVU0rHME
         Oi1tffb+8XIgl07lg9IQw5JMtJ42xHGNjsxCdORaM1DQWzHxOIj8GXsaywu0pp0fZ5jm
         c2miI95Y9Uc78HuuvUHO8mmVqEGkNIKkEbIAX60E2D5Nu/+oIuuTQ/FKjdvMeXFdxwwZ
         54G0qtnzaKxb6rEOh39zTFhQCoZ2rW4YBmSNlOJLmqRZTdhZ9+w4hOBzvHr6dkETBjj+
         BkZA==
X-Gm-Message-State: AFuF++mzMGpzxpk5FmkwjIXDnJT+PGg/PyzBw8VORub90Hw7eoTuE1sD
	vo1QQcIAPiC7KfHgf028FrI/SEeBr0c6Jbn3kvMSsHLH1fZiFtjlMo+skeqPEPouCF49d9ZEpz+
	jR8Ea8z1j6MgqQMsRu/8JLhL/a+dM/IEJR7GtsX295PT8NAQuC8Wh1Bis0vA+7Q2zE+U=
X-Gm-Gg: AYBFou2O5ywnEkFx64YZaruZaVRhOwY8igKTkr34f2AHk0sm28kYp5sMy3AKw+YCW9l
	cg5hQngVBNR1y483CKqvTbRut6/OZy+mgWttz3UGAOpHQY+L8DqI7ZhvNNEzE66/hg2ouVQz1OL
	HSUXVpiag6aQbS8Y77ySka+7WjU1jWO1SsIfP9NHfj5YFzJhLQZhvfk83x+284kwfGSK3qUG36t
	qcOtq0eAN9BnV1LjKqPeiYOk2xVi5QbXZLKexQ0FC83GIehfY/3W5wKSQyEnky22ABuOm6gPiIv
	kaXtGYi7qIDPJTnIS+NHbP3JBtofl9aHUtHbQQ4qcglTwTr8gt9kMYPu2aX/aWZwxbLnER+XCHp
	W2D2gB3z0lbFesdiLJ/KWCjkZf7TkP1p1FpCipifoJy+Eqr2ggC7bFzgzn/y9u5B+yluX3csQPo
	XBhIbAKTdC9BR7eL4T9FLORyBA
X-Received: by 2002:a05:7300:f810:b0:33b:fc68:9790 with SMTP id 5a478bee46e88-34005c6210bmr1298365eec.21.1790235470887;
        Thu, 24 Sep 2026 00:37:50 -0700 (PDT)
X-Received: by 2002:a05:7300:f810:b0:33b:fc68:9790 with SMTP id 5a478bee46e88-34005c6210bmr1298326eec.21.1790235470219;
        Thu, 24 Sep 2026 00:37:50 -0700 (PDT)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e95c7cfd9sm12120680eec.5.2026.09.24.00.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:37:49 -0700 (PDT)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org
Cc: acpica-devel@lists.linux.dev, anup.patel@oss.qualcomm.com, ardb@kernel.org,
        conor@kernel.org, james.morse@arm.com, lenb@kernel.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robert.moore@intel.com,
        sunilvl@oss.qualcomm.com, tony.luck@intel.com,
        zhangzhanpeng.jasper@bytedance.com,
        Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
Subject: [PATCH v5 4/9] riscv: Add fixmap indices for GHES IRQ and SSE contexts
Date: Thu, 24 Sep 2026 13:07:09 +0530
Message-ID: <20260924073714.1650588-5-himanshu.chauhan@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924073714.1650588-1-himanshu.chauhan@oss.qualcomm.com>
References: <20260924073714.1650588-1-himanshu.chauhan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAzMiBTYWx0ZWRfX3Mn0dZiBXE3w
 SgZhWwlmZiGmwq3QRNBPoe2irEAdCzIap+aSbBVumg2+h4XW+bWyU//XTZzxAAHHcpUddXwnIcM
 uaCnmLOLrydzxTNYd3hFmzDaJWJJAymZ2FgNJkYHcwsK3EHiMvM+xX3e0VuGjXXCZeORyUDizfv
 YnUCpwi5LCqYQDajLtMYhCs8Z9JlT8MCkcUFA4u6Y8M1z40j5QEoz1DVbNvIBQIVoLi3lOXXhaW
 ouXidS3G1Ub9iIp9I8GpJeLFznWcN6+2gvzovnAGW1VkBDbF0f8Xlsa1K3LfZyUOVHsjLn/inxX
 SFZyEwwAgkBDj8e05qehsTS8Dmz/j7hFsXmlqf+UeX55bzs67hqsP4JUNY8fx/QxJMYLqmwcbEO
 QVIAbyTaH5xejoOwFPjOUuIhS9FjWAoeYUVPzylSH4GodDJ9Nb3ckoiMnPG6Qk/Hw3pOgqsojD7
 lqLGb7RxFryyCuZ+Veg==
X-Authority-Analysis: v=2.4 cv=aIxlOr9m c=1 sm=1 tr=0 ts=6ab4d34f cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=h0uksLzaAAAA:8 a=EUspDBNiAAAA:8 a=0wheRbxtA0UXKxI4o1AA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=MSi_79tMYmZZG2gvAgS0:22
X-Proofpoint-GUID: Tzq0q7Eia6UjK4lEe5YMijCqPDDudBVN
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAzMiBTYWx0ZWRfX3y9AMBVBr4iT
 1dBCOGB5qDhOBLpYe1TajJKFAaZI+zrRxb6mduTgz9kNgm6BQskL0zi0oQyDrRyTlnEei4Q4v1g
 rQBHfV5E4aqTYXKF1mRdb6tOzvirFPc=
X-Proofpoint-ORIG-GUID: Tzq0q7Eia6UjK4lEe5YMijCqPDDudBVN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240032

GHES error handling requires fixmap entries for IRQ notifications.
Add fixmap indices for IRQ, SSE Low and High priority notifications.

Reviewed-by: Clément Léger <cleger@rivosinc.com>
Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
---
 arch/riscv/include/asm/fixmap.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
index a81823c5ee4a..3a775b8d0cdd 100644
--- a/arch/riscv/include/asm/fixmap.h
+++ b/arch/riscv/include/asm/fixmap.h
@@ -38,6 +38,14 @@ enum fixed_addresses {
 	FIX_TEXT_POKE0,
 	FIX_EARLYCON_MEM_BASE,
 
+#ifdef CONFIG_ACPI_APEI_GHES
+	/* Used for GHES mapping from assorted contexts */
+	FIX_APEI_GHES_IRQ,
+#ifdef CONFIG_RISCV_SBI_SSE
+	FIX_APEI_GHES_SSE_LOW_PRIORITY,
+	FIX_APEI_GHES_SSE_HIGH_PRIORITY,
+#endif /* CONFIG_RISCV_SBI_SSE */
+#endif /* CONFIG_ACPI_APEI_GHES */
 	__end_of_permanent_fixed_addresses,
 	/*
 	 * Temporary boot-time mappings, used by early_ioremap(),
-- 
2.43.0

