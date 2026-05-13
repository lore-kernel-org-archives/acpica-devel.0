Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880FF3E5591
	for <acpica-devel@lists.linux.dev>; Wed, 13 May 2026 08:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778661858; cv=none; b=jElBGOp+KBJL8SDiabPdnWpFhNGSUqF9CSGxKm86MQB9F2sFsDKUHYXKq85nJgZwp0+oQ/iq380n03vux1gg9gy0Vju0VCefdCGh8VP4ImeVO4+jNOIuUFOp2JltPwe9RM1iPlHAdCVTnpRqC6qQbhExp8pSHpV8MD4I4C92Wvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778661858; c=relaxed/simple;
	bh=wsh7T9Es8tm7G5+cVDm4V2UDNK5E6+Q1OUCLkFOrdYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eOmjcyEBKPpIAGloYZWTal16I3nlOWnPpfyG6Sy9iQxP1dDDQrUPiSTPriFAJLMvcH4wcEFl7NniwB4QV3NQSxXnsNJG62otIJv0f5X2R4rmp+GTtE8kZV1ARxMCgwpj4+IIcZ2JmRZU+QjDwAbnXsxSpwNpRTSpJU7s0Hz2Qg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ew1B5Uch; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VdIbjcJT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ew1B5Uch";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VdIbjcJT"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D4pP6v2331990
	for <acpica-devel@lists.linux.dev>; Wed, 13 May 2026 08:44:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=V0HbiZ4P78p
	MMZLzC1v2KdG7nYX9gwkT4Ii7QaESwzY=; b=Ew1B5Uchu+VjkXeGWc9d3N/Pnp0
	nZzD6LFWdy1C5JumSy6HgxxxatVH7CrcEpiAr9tS75N2AIkHFhcuhJRYTQ8mgoyP
	k1wM/NjaJOAmnExQUkI3ZQALvNKL7NR6A92epgC9W1XZK9labvSiOzprUknX81XP
	UpnV7m3Y4Bttu2nKW79QfqCF4PFIRGybDVKuPRjTLw9qc4t2aI1vB8yBu89fjwzP
	fFdMdlBWmDobbsttc8VESNOP/+UnbmbEa23zIA9ufpAF+GWKY/+Ag75US69WBBTB
	h7+ga4OgAag/YdzmegpAqGLCjlOoUX3Xj2wXtuqPlacEWT0VTmuGmhuIz4g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e43ypc8gs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Wed, 13 May 2026 08:44:12 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ba838d3fa4so72791375ad.3
        for <acpica-devel@lists.linux.dev>; Wed, 13 May 2026 01:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778661851; x=1779266651; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0HbiZ4P78pMMZLzC1v2KdG7nYX9gwkT4Ii7QaESwzY=;
        b=VdIbjcJTOk/TZbE9NwoLqRWRg8fVIlxnEegB0FcAaB/WjJuS7HdsouhVIF3QItfrdg
         dzv6jBy+wN7F8WdqOuQIOiramEdrLE2qio9FvINUYO5YgLeFmDui4UK2APLiRJIISrIF
         7dZE/2QCTy+w5eMmUlRCkTrzqltGz9JNR2V7JqE4bl+q+/NVmoqu71i2o1f6zQCV9if8
         waAOpdfsPZFcsU7n+1Oylm5+tvoxkH6Z/aqiNuATzzXUxwPOlynX9D+D7TpfgvmXSrKl
         VkYlQwkZ/nu2X/SANh2i1JWJ3lbWKWylJynPYrbFk2ga6sjyt1eLOumzZW6tgo93nA5G
         TJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778661851; x=1779266651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V0HbiZ4P78pMMZLzC1v2KdG7nYX9gwkT4Ii7QaESwzY=;
        b=fsF9vQkxhVo/ALpMPi/S/mD5cSqVg1EuUfy8hWbhR/UC/wwI8cs/v7+VAdsokY32q0
         Sqz6isPTieM57uWtroyewvzwle8IOWwkGwmYuACBqE0JWjDkrb4abj+ZqFKbWe5FhwI1
         OrfTAZJYl+vTK/m4GhT1yYaIxKjZrHYH8a5JnNN1xtuJ3RpDVL2afUn4/DewE2EnqaK/
         jTtgXsF8uxL/N9XYJFcZGx/CKTrCbA8hsCxV1pVvum8TGFCEz0z5fXcUuDxl0laPa0Ew
         3joBtMdsWzpfU1Bi4yIBVCUJoDbIshbHphq2fGlNXhcClyeRFKpDwcTjFo6220N+fgI0
         w4TA==
X-Forwarded-Encrypted: i=1; AFNElJ/EtkE+b9rDZ22esaeT/HjhGyz3OSQWSB24vBNutGASETTuPT5tdlt5DanZW/jN1fpEP741+e+HiP/sjgg=@lists.linux.dev
X-Gm-Message-State: AOJu0YwjOuWaYaM+/J/BEYEW6Y/CTjfT5GA20Whngl7BmrRi3aEcaLEr
	6sW/IdUuy4OuUDQUIxA9IiDOp8TM5p31w0wByeDheBXmDO16IPItgFvokV2va4KzwHrKe4FVog+
	DUTdtNjQn9hfO8xsjKFFGSJzPoz9soTUNa4HbxTEy+crA+MlQs8Vk6kvUL7HPliN+jHI=
X-Gm-Gg: Acq92OEInYV3DldnEKQFqI1RWUZTHqAhbP70IyxR35ps2AI76hS7laZIqgvJgR5AqBv
	/MlmmMVNyNAMBwJdsq1nvJTdJkwVQFoT3YvzVTWGWserhfe5V+DMfKlCqBLy45zTqn+3d/perj/
	i0+L+goXFa96LXJ7fk+MK4mxZT8jvr3Jk2904WBmaSIVkd3DIMt/uOm2UyY2zjuqUeUnEphXi2w
	oa/X/2RKCt7Rumkmhk0aN/C+stWHBOXBsQCH2EfiYzkDEOGawRgK6ovedpJLG7n0yEtCnxGNsry
	6R6tVTwLFcwfcJSXnEMuVII0XTkNR7ld4AONaEjRagLkFe17uA3GUwhG5nkoPZRn2zVHxtETMIN
	ruMWql7HI4BZkYWAKJz6zNokz2a/DLDCaaiWGpWyhS4yNrY8Ptfj23HCNl8lOjiQwyjYQInrmNu
	3TRSQqdmDVXVZgNHxR4c9HHpxnS6GejVWQPDbpIxzaAqqqtg==
X-Received: by 2002:a17:903:11c3:b0:2b0:608d:d8a8 with SMTP id d9443c01a7336-2bd2f4cb703mr20265475ad.1.1778661851549;
        Wed, 13 May 2026 01:44:11 -0700 (PDT)
X-Received: by 2002:a17:903:11c3:b0:2b0:608d:d8a8 with SMTP id d9443c01a7336-2bd2f4cb703mr20264915ad.1.1778661851092;
        Wed, 13 May 2026 01:44:11 -0700 (PDT)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d2709bsm169158725ad.5.2026.05.13.01.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 01:44:10 -0700 (PDT)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com, sunilvl@oss.qualcomm.com,
        anup.patel@oss.qualcomm.com
Cc: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v4 05/10] riscv: conditionally compile GHES NMI spool function
Date: Wed, 13 May 2026 14:13:20 +0530
Message-ID: <20260513084325.2176952-6-himanshu.chauhan@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513084325.2176952-1-himanshu.chauhan@oss.qualcomm.com>
References: <20260513084325.2176952-1-himanshu.chauhan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: dAxqymMSEA1riBxpKZ74438k0ud9W0Nm
X-Authority-Analysis: v=2.4 cv=R5kz39RX c=1 sm=1 tr=0 ts=6a0439dc cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=-FlRX8pefk0TmyAjS3oA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA4OSBTYWx0ZWRfX+8OLo+nmlga1
 hq3d0BKOAXKvCIRXlrRJo1vhl5aJ2ms3su55tzcX77joit+Ydxj9Ch9BHBoPxPpzJ3fX57iA/Bh
 3Robj0I+5/T+06D02Fq4JSqk09xZr6ypNn6Q+wrL8+a1Mb8j4f4gBul/gm13CVIoku2aMFB7Mux
 vskGqHegOq4U+HtDYkIzKhimK7vCZdx0ut4YMW8JPy5Zo1o405QpU9Bg7tZ33uiCiw1mlxwh6L1
 xDBwdqs+9v4fOn8vfcFJ4E/d4E2tzythBM8f5wxqVXM4rUnPpmF5rli75XEEfb5pyeH4q5LyY2S
 sEdV3nOfbFFLiQOwG8Tpybf6IHD5hY96313JOGKMcN96xSraiaiqhCr5Ez9Apyjh929eCk+iJT3
 gPJ89Vmr0g+T3++XFSFRXK8qG+29WckSPFnzyS63x/MrQuBZ1ax7qMIEdObZqAw5CZTpFzSW+y4
 sxHlrN6B5VdeRQSqOLQ==
X-Proofpoint-GUID: dAxqymMSEA1riBxpKZ74438k0ud9W0Nm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130089

Compile ghes_in_nmi_spool_from_list only when NMI and SEA
is enabled. Otherwise compilation fails with "defined but
not used" error.

Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
---
 drivers/acpi/apei/ghes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 3236a3ce79d6..8edc2c8db1bb 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1397,6 +1397,7 @@ static int ghes_in_nmi_queue_one_entry(struct ghes *ghes,
 	return rc;
 }
 
+#if defined(CONFIG_HAVE_ACPI_APEI_NMI) || defined(CONFIG_ACPI_APEI_SEA)
 static int ghes_in_nmi_spool_from_list(struct list_head *rcu_list,
 				       enum fixed_addresses fixmap_idx)
 {
@@ -1415,6 +1416,7 @@ static int ghes_in_nmi_spool_from_list(struct list_head *rcu_list,
 
 	return ret;
 }
+#endif
 
 /**
  * ghes_has_active_errors - Check if there are active errors in error sources
-- 
2.43.0

