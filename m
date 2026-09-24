Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3CD42E42F
	for <acpica-devel@lists.linux.dev>; Thu, 24 Sep 2026 07:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790235455; cv=none; b=eXvqWifpr7hbR3lDN6HPs257mHF0QFpFNe7KPl3gacR0BRVzRdnEra1jujX0m9rOZevM2pUppgnbG6muioQ89aBGywnJMJ5ALBjtiZvb0vmx+OeTImMV67lIENc4eJaA0TJeDOZnHUE0/Hqau5xU2pqQFIVQ8v6OElVifWzZueQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790235455; c=relaxed/simple;
	bh=1hUFZzk8I02wwaixbUr5fn1Bm9Ue3PrxhfLlWreilAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OI5KRJZM5EWJJIBlf/U6A149/bnPjsF/u/uEpQUJ2EbXS6ZczDLjEu3CFpd2srsqHA5Qrngc1O1qcJux2Ndj3okqr+9jeF009XT3PAl5czeRV+qbMvCtqOhK8GgUq/JnnoWROQ7x7iPpT938vO1onzxR618DFEiGn1KJxypgcog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=io4eAL92; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XfMemza7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="io4eAL92";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XfMemza7"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5e9Uo567584
	for <acpica-devel@lists.linux.dev>; Thu, 24 Sep 2026 07:37:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=COCHYx8vdlE
	VpwnqbwXHA67D8m795QMTNoWQg+xmxzc=; b=io4eAL92O4D+jrHD1TDM984uvmu
	64MNZODOVo+7yMikxK8gsjzkZxX8wiQ4zhpAZuPVaAyxz39onl+JYOvjErO4hcas
	SilhHoOcf2rWdtFS3lAzjrktbneNePETTvo0awaKTCyVoMJuTZq82Gz1S0vR52L4
	MKxMXM0iWqSs5UdzxHdljpL6CKc5kMz5PG6wdRSP5jQpCI4dpEUxlbGB9wXtI42A
	klsbyaa05UMMVwjWejhvqhuOsU2ZGlvp4Xk7DOPoaf0ndxWXxUXgjb5wXOoU289T
	JtiL9OQsOi4otO250ShDu2rZNeTDkvUK1YQXe8mbmjMDNruFZL4E9J+1hRA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvvgh8qu6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Thu, 24 Sep 2026 07:37:33 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-333543ac378so2104195eec.1
        for <acpica-devel@lists.linux.dev>; Thu, 24 Sep 2026 00:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790235453; x=1790840253; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=COCHYx8vdlEVpwnqbwXHA67D8m795QMTNoWQg+xmxzc=;
        b=XfMemza7SALoVCUoXQYzQ0ktwR7mQfO6EsDWtspJy5eX57638NAdtN6+B6VMqxAkOa
         6QZMnXc70ZzBAITQwlktbU4dZ1VE5ZMCFdQcZVy4CNej8dROKbtwqkZlBuwzM8jnwC05
         r3C2oO7bBgXRsVYoEr2SqRaUKWn6JBd3xZU3rR7nbUjcapUZReutCA3xe0rbAjid/HQd
         MZ1zNSgX+YSSjAtPSYXY7HkGPoJNzXQlTdAtU0lZ+8miUDtzB1rNFvQRR79vjWNveMFL
         IMPZUQ7rwi2S4d+87i6ApVLDbUQPvt+wqIjIZ1jQQ7Gs+GdW8SfruYUuCFebRbwdpaut
         i1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790235453; x=1790840253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=COCHYx8vdlEVpwnqbwXHA67D8m795QMTNoWQg+xmxzc=;
        b=r4n/deb02T9DsOTIoUfWRZEZzFKN4+SLXE6PLp9v9cNzghSQpLhbk16ldxqhy6OFcD
         x1nrndikaqZOW478arwGkgYOf/BC2my4qBIJiZqIoETwaFqoJUB8kNrGPn4lw+T9mZxZ
         JjsYMjlWU42ttuVmqztXOgQhyDxy2/6iB9AgL63gCk6hgfOyT41b3w8XAbLDlVqcknYv
         8UYZQAfrtmjH/F/ebsICNaA85LUieJXLuRNqx/uI/LHWmuAz86FJNHv9/F6BawKIZLU5
         7XBNCcktDn+GBdFJArSPj9BEyzm6Nt07VT7sCH9VAUCEbLRcld2/e1DvkQ7CzwoPlJjD
         WlWw==
X-Gm-Message-State: AFuF++kvbfFGBvBwlkReMW+jvNQ3W5p9x1fljeR3VY3KbJgJNsYoHt4t
	+1ecnL8eeHhoTpQzc2gukrugxKqGAHQsUnv49PvYmO+F6XlXMd5db57AQAHyHZQpFoQ0+z8vH9s
	7t6txLDv72qmU2H5ObX0MDhlf5MFWY2XLKBU4WZpTtcUHs45nnYPAaZeEn2b4Wp+1sW0=
X-Gm-Gg: AYBFou3zKKK3G7zgJKphZvsUOrVVWAHAgxdAj4uGart3qVa7XZjNa53mN9ItoCbe8if
	xNRfqEK1+Pot4ns+oXry7POn/tWZl+uL/zPX1Hm73JgA6RJ4ko9BrNjRoEXohfwMzWqsGQeLRTO
	Ukrl/HG9eXneWEMj9Gy62J9eIrV6K+UKlWRpimHBy01j8jXpRjb8Vnn8HoZbhNQ4czkFtcTYRL4
	feFo1A+f/wr7XpcPC2qOIIqIZYccszgYA3A89NXOFONNcd6sux7lfkrywgrEvgFdpwR6c/Q0Ps4
	dHUx6ohm4elTuETf5D1DGeXmv7bI4KfrxWYghjqqJlbG5X5AhInF1eTZS4yzlOjVPOstTehBGAY
	ymNIPhJ8uw8p/wgd+FbmkOTOvn28jty4/NzZNIGo33fY3Vt9JQ6E8e82xtpOvHPcrP4DDfbUZYq
	WqrdCbwpJt/65remOUmlvqNjYg
X-Received: by 2002:a05:7301:90e:b0:33b:fc9d:947f with SMTP id 5a478bee46e88-3400566e970mr1106752eec.40.1790235452832;
        Thu, 24 Sep 2026 00:37:32 -0700 (PDT)
X-Received: by 2002:a05:7301:90e:b0:33b:fc9d:947f with SMTP id 5a478bee46e88-3400566e970mr1106736eec.40.1790235452334;
        Thu, 24 Sep 2026 00:37:32 -0700 (PDT)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e95c7cfd9sm12120680eec.5.2026.09.24.00.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:37:31 -0700 (PDT)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org
Cc: acpica-devel@lists.linux.dev, anup.patel@oss.qualcomm.com, ardb@kernel.org,
        conor@kernel.org, james.morse@arm.com, lenb@kernel.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robert.moore@intel.com,
        sunilvl@oss.qualcomm.com, tony.luck@intel.com,
        zhangzhanpeng.jasper@bytedance.com,
        Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v5 1/9] riscv: Define ioremap_cache for RISC-V
Date: Thu, 24 Sep 2026 13:07:06 +0530
Message-ID: <20260924073714.1650588-2-himanshu.chauhan@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=KYhHIgYD c=1 sm=1 tr=0 ts=6ab4d33d cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=JWN5yfGi9shfayy-Z8YA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: cgQKmXeOZzaFQ3Lsu2wF3RDWihdKqRs5
X-Proofpoint-ORIG-GUID: cgQKmXeOZzaFQ3Lsu2wF3RDWihdKqRs5
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAzMiBTYWx0ZWRfX2dheWd8iE9zo
 ofunbLuYIiyZ5k95D5TabSTqLl1ImfoSw95jPMDwILK9jcYC95hDZVJRf0UUGsbQ2D48V0fZg4I
 e4h5+mHD7f7SoX5wQvBJ/LazxsZSf1Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAzMiBTYWx0ZWRfX/mSPJ0II+WAq
 G0DEfefpcPKjVJAy/Thv10tfFS8Ofddxftm63GHU2p2sQJXvm5xPbs4wLW9xF2b5j4B3eztHmzI
 pQtBwVQZlam87SPRTebk0rPDii6EFSZd4/gxKFs7RlCMZbjHW66+e3oUBLndqJSQ6g8rRsBjk7K
 hD4usyFW4bMjfrFLhGs/emv3gd2WxywOZWQKiFQlID9JhfN9bu8lXaY8uUXY0etlSWaOXrDs+p3
 07deTsk0lwjod5+j8zmj13qSxOEDr4+b10lpT13yqT6+D51SQHhX2eUxWojGmgDRvOfXsk2A2+R
 RrERCqHV4hi8dtMsL1hcGZI6PQA2wudXSgUwHZY4jRW2CYoVHo/7xXN+OMG+q1ryrA/ltZU4eim
 9GCgpfyzZJ8NMFN/syvJcz3yw9rtVHfCUM97tTWWCOFvFjQD1uhrazMWPpJmYnZQbKC8MpZg9CV
 18iBi016mQbmUEAcBKA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240032

bert and einj drivers use ioremap_cache for mapping entries
but ioremap_cache is not defined for RISC-V.

Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
---
 arch/riscv/include/asm/io.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
index 92d5f831f349..a51904a6c79b 100644
--- a/arch/riscv/include/asm/io.h
+++ b/arch/riscv/include/asm/io.h
@@ -150,6 +150,9 @@ __io_writes_outs(outs, u64, q, __io_pbr(), __io_paw())
 #ifdef CONFIG_MMU
 #define arch_memremap_wb(addr, size, flags)	\
 	((__force void *)ioremap_prot((addr), (size), __pgprot(_PAGE_KERNEL)))
+
+#define ioremap_cache(addr, size)					\
+	((__force void *)ioremap_prot((addr), (size), PAGE_KERNEL))
 #endif
 
 #endif /* _ASM_RISCV_IO_H */
-- 
2.43.0

