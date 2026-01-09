Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2E0330656
	for <acpica-devel@lists.linux.dev>; Fri,  9 Jan 2026 09:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767949398; cv=none; b=KG1fFFSK8YjXz8S7mvHkkzum/YvIQQzbmWZXfWbSeirx4rEwdxfoetGRSlkornDCrDAWsvLUk1l1uihPfx0W8AvSTCJdXdqJ2Jmcj6ZuRWy9QNPyujpPDdzZEh6lSXpQeDk+l92cq006evZnupjKNHSmozBc6aaqIgh+y0xSzHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767949398; c=relaxed/simple;
	bh=5AbkwUe4KSHUvslJtTs9okt35cK2ziGtjk7b0QstlZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XPSJ9fmKZV7jL5OF9miPVEhVJdxlbEDXO1iE8y7S2VmxuAca7mzGfA3UDRfKP2zErXfZebSccD5L0+CmeCi8zVoE40R/MCc/YDft7z7Qmgo+YJSmvLIDgVHOQ7iyN22cOoAFJW6Kya927NIAOHbByrfw99KU7a5iXNnQLCzvFVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ntRZbJyg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ch6peseE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ntRZbJyg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ch6peseE"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6096MUS52986626
	for <acpica-devel@lists.linux.dev>; Fri, 9 Jan 2026 09:03:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=V1pVonEOJuX
	JcP7BoStX++5XFX/aG8G2NnylegJ0870=; b=ntRZbJyg+8my8ljnN0AGP/4c3n3
	nCAtVLnBl9pTa3b2lggy65Q7ADypQisdrHZExjNrjnO5Z5uMomhdJzwelhbMxUmt
	lhl+3bPl1KFvyJ+v//7x6a6vnjHfY7/OzVAECTsPKpwZjq+SOYyaIPPPIa2XG52N
	e12ksXNY5bubRJEnCadm1c8u6UMd8DiRXP4zIj6Xh7jLywh+NKoMDJ93Ts3y4hEs
	P6swjzvLc4gk01QCiB3cLhAJWkJIH5oQcPEb6KWiC8yfCBScy30F0u62mMsVWzq4
	0sDADrmHWOUncbNf7NFqD3ZfvLDoW04Q+JF1x6p7y0pqUDjXi+NQTa2NEeA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjhwx2419-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Fri, 09 Jan 2026 09:03:14 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7b8a12f0cb4so4070829b3a.3
        for <acpica-devel@lists.linux.dev>; Fri, 09 Jan 2026 01:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767949394; x=1768554194; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V1pVonEOJuXJcP7BoStX++5XFX/aG8G2NnylegJ0870=;
        b=Ch6peseEqJz8KrjDWgnQwEb6H/iqzuBaZqVgjleZpW9zLvnYwb0nzpDVcon0n1EGwq
         aZxOICezy6udvi4xqbKBJa3zvUS8idcxTst9IdauIkAG98cM+Z+boUdtJ0w95KA4+EQe
         zHPPvC3WDpRzlN64PqcKIKJheGWzqKSrdsa5b2hTy7oTV3Ag4yT8FSPTmlMCcweW+GaP
         qVc31SSJFJC5YSvXVX/u5sKwIB2BNyj0ZTp+dI31/8b+dO5xGpw18sl6NH4q7QtbJpGC
         q8CI4fWV+jJZy9G2mCXxrefP6apqtp5F7kC2Rz13aA0mcqE0y5lU42F8lZtRmV/Hkf2K
         0QJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767949394; x=1768554194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V1pVonEOJuXJcP7BoStX++5XFX/aG8G2NnylegJ0870=;
        b=mutMHUSvrGU4ohQJvEMrMfbOU2KqnDich0e/96xf45BWzlbtgt2yUxzBtYJvsCPRz/
         sdhKjt3d+oiXA9XbbDSN/uVB/h3W+HIiWBGND7uQ2Tiq7smVotGO+5OLqXksYI6LN1mG
         GaNrx1J5/9I8adl0Yw/JPdkicTGv0eSLZfu9eR6nlwY/wgP5lHEzJtTp1WkBoIENxMiE
         g+UuYF6QqorJb88DQQ41yBJ1Qp5GzIWm5bs7m7a03qTXTEAtALuLpl0ZFRtjMjpkWLff
         M8b7897Ja1RrWl07GrMhews+fvxwKKoFGHFcD5rT1jmDrzx29FIkauGwnvWAJbi6NVjW
         f8gA==
X-Forwarded-Encrypted: i=1; AJvYcCV10f8iiT5GNyZALkmSmIO9tEqWeRthpWTGTeE+TX9NZEaoldGmyw2JN09T6vOtbEG8opjpP1s1+STFthw=@lists.linux.dev
X-Gm-Message-State: AOJu0YzcpraiU54iV7gJQnHHvzB7KUYtx4V3+tgUqd1ExQj5xUL68Z5l
	gMnN/0XgT5KC8vBe4y05PJnxtSfpve1e7nW7XajSG3QTqr6KVJ2xupkJFWdO/QU4NdLWv+pEc1k
	KJfC6IsVdaZgU3VHDqqNL8EjOjzlwuCoViz9Jf0K1MXN0+0q2JmZfILwB8bf8FaTnrBE=
X-Gm-Gg: AY/fxX5hRvzcf5Ae1r7WW6Cdke5I6CLKgMBWfqSA8PcFJL6pChrv8Pw2LkN2XmH1irA
	MmbMs2u/ZZTn4x+SYoai7suxlyEq0KTP+zN/11BhyqAcREJW7OkKUOg0mlVq0gjLMVctxgt5txM
	XXrC8O2cADqh66AIrYXQlbvCXRSB+YmOyOKO8Y7s0hRunqJaONEF/PyapdMFzhLdNuo1lCb7qru
	+/O1i/hKSVub0EqYmZNWgxnnwwC/x+/t2SeSjDVGsyZrExdK+nK+24Qyxp/VsikK2wk+S8nywWU
	0yM6HpcW/q4Eyt6LdiOJcKz+MZnE6fdIfPRGRMWMPRN0qdHcd16Eb6Be+koRDlLHXw+Qb5/KoZ3
	0RwSxiAFpRLdrNKklDvm7IDUuHsGv9rkwVA/NBIwIZA3wPirTQgdTmxaY7FLrjVKpE3VW5z5/k2
	8IIQzhLGplsJKDUaIXU6+DmmHQCjWtnsTjBg==
X-Received: by 2002:a05:6a00:4394:b0:7ff:e71d:49a4 with SMTP id d2e1a72fcca58-81b7d85305cmr7454250b3a.11.1767949393896;
        Fri, 09 Jan 2026 01:03:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGu6Dzzr3vQDc5S1B/XHUHzgN4IyrQ0Y+ZBxjQJDn6l/lNEm6JmdGsaCaXI4BvbmrSGPo9+sQ==
X-Received: by 2002:a05:6a00:4394:b0:7ff:e71d:49a4 with SMTP id d2e1a72fcca58-81b7d85305cmr7454225b3a.11.1767949393427;
        Fri, 09 Jan 2026 01:03:13 -0800 (PST)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c59e826asm9831562b3a.54.2026.01.09.01.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 01:03:13 -0800 (PST)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com, sunilvl@oss.qualcomm.com,
        anup.patel@oss.qualcomm.com
Cc: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v3 09/10] riscv: Select HAVE_ACPI_APEI required for RAS
Date: Fri,  9 Jan 2026 14:32:23 +0530
Message-ID: <20260109090224.3105465-10-himanshu.chauhan@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109090224.3105465-1-himanshu.chauhan@oss.qualcomm.com>
References: <20260109090224.3105465-1-himanshu.chauhan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA2NCBTYWx0ZWRfX+D10SA/7+To5
 EgAucSpCzJ1OcqRAP5VhBaVpqblfyTJFLoT5rs44MM6y24t5S8zZtWEf25syi4a7+AcV3bqo3GB
 iGvGopiWM4oXNZDmtg3xuqg6xd8ukM1DJuv9w63I0TcKxyHvSDt+DLXz7W9F9Jl1eG9PDgyy81C
 4poIIlgFmh+T7psETfWGfqCxjUM7/yWOWy1lNKTZWT4fZMTB5XMXo6hju/pVtdzz5Y54F7T/22y
 Vs/ET6Au1Ll9vLfztWF1xxmeIcgpvqcYMJtyd4DFbKfbwDb3VtmuWJf0ydw00IxEvPxCElqeCpl
 gVpa/uvpU2ZLw2BzMbjAJQSXDKFoL1L9yEyV2MpaHlZbyNIfGoxv+yUEmi5hEklW5BXWLjthEvD
 NzOd3yqF5SClRg8Tmf8Uv3jVZmjNMjsdzfFNP/cvhzP1Hfzpymzai6di4So6cr7aJkIxSf38Obp
 1B4cLaHIKP4wmjd5H5w==
X-Proofpoint-ORIG-GUID: CBtm3S3oWDE6t_n-mcges9cBAOjR02Gm
X-Authority-Analysis: v=2.4 cv=ENILElZC c=1 sm=1 tr=0 ts=6960c452 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=B44PnEIMzw-PxGPnmokA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: CBtm3S3oWDE6t_n-mcges9cBAOjR02Gm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 clxscore=1011 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601090064

Select the HAVE_ACPI_APEI option so that APEI GHES config options
are visible.

Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 6b39f37f769a..ef3f052e97c5 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -187,6 +187,7 @@ config RISCV
 	select HAVE_MOVE_PUD
 	select HAVE_PAGE_SIZE_4KB
 	select HAVE_PCI
+	select HAVE_ACPI_APEI if ACPI
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
-- 
2.43.0

