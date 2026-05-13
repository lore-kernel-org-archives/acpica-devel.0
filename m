Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B7E3E5A23
	for <acpica-devel@lists.linux.dev>; Wed, 13 May 2026 08:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778661866; cv=none; b=ItivJvW4mzmwBP0sSijnWIuSeyWuqj6AfnDHU3mAiDYb1LSrQIuM6VMx367fG0Qhk1fpcqTrl/qhgRwOLIHxuWePAK2VYrnFsCH94FUdK3yflLEYQ34M527NjsrVim02M3Rr9Dwook1nfj5R2giO6siT6lChqSEKc9TP4hYOKBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778661866; c=relaxed/simple;
	bh=nvHY3EcHTYRY9I9aMgWPVt8VieEY0jbt8ogsXLJbOJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QrfUxYFQ8sNeyALRyPlyaVmqN2n+cfjI57OPrY2yiXaWZoxFmUDbrxfUQZancXvO1G/qYI4LZ9FqgyZF7TAglve2Av5fypoUa58fzpkSBEq871CAa0SyrUZiHhFTjt6cQxGm57Pgx4IjE5qdNgn3lEjZVvHISQXw77qEsmMexaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YRekJzfF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c3qaF9dj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YRekJzfF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c3qaF9dj"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D4pLVK3595353
	for <acpica-devel@lists.linux.dev>; Wed, 13 May 2026 08:44:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=NUjop8bIgjc
	4kzn5Txli1zlGm+BpePPllAZ0mN/qO84=; b=YRekJzfFZ/MHDlciDtRpJz040hC
	BlbOFPswO1P456inpjHtRnZ9ouyRtT0MY0O4FkMSeLeSm1WNmh194NcDk1zClm1d
	LbNeJVxalCUmw4bhrKN4xCzQkcIyfPhdcmwfo+iLf/3WxeLsfCKiihuINxAYP+2m
	RcwuHFrhocW4/fVs4vP6a2UQLSAUhBMHI3m03Img7RZCX0gsjPivVnUPBVVXmUv1
	1Gro2I3fb6r5zZXpJgY62ZBZa7c7q38FbGCX2x2mcmro4L+rq1eISBTCY2JWHnXc
	ZTDAXySzbbSg2F99Xq1tIZkMB8xu0zPxhHMBXjHWKHn1bBdiWssE2BjcCLQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e463dkkux-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Wed, 13 May 2026 08:44:22 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-365d4d2fa04so6259326a91.3
        for <acpica-devel@lists.linux.dev>; Wed, 13 May 2026 01:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778661862; x=1779266662; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NUjop8bIgjc4kzn5Txli1zlGm+BpePPllAZ0mN/qO84=;
        b=c3qaF9djLwBqzyE+Ho+YhUlmc/Hav1AQjMA8Td5A/8/dkKTysvAuHMPDgcffQDzre5
         +4DiIfNphtJ2UgysUMZ/VD69pXXLfbPpF5yjB+WfG6QMIrPYUhyiLhSAHo/zrR9FvgH3
         9iFBnNY1fCNnpjUdHHLcVpaQMQqxDyy5z2uq59CWO94bKfOVW2RbYBV2L36QS3OCrE3v
         +7Yo5UcdutMd8okXZXsS/fQhG05BL3Dd4zVrtPEHNfC9sE0JO9iG8TohGysZrZAmjtrH
         V0fP4RWAkA7sRFJg7sPy/T1K/HSIgB/u+Jdhdu964ROf0/0LRZrQtsIkWLIy5RDjDr53
         KI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778661862; x=1779266662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NUjop8bIgjc4kzn5Txli1zlGm+BpePPllAZ0mN/qO84=;
        b=IL4SBWLwZfBXHMkRZy6pAsyX1+PZmZJZhJq/naHCXP7GQxIUetSPZENTePXo3s8o4P
         /6mHcOrZBZCqfKBfIL4W58+JQOkU5G2zpFE6OpLJC4EIZFnXYYnCXkHM2SMi9ID9jUtu
         2R6UcFnFUtWUK2RYPel8OR63FJmFWiVuqItBYn39f14i5RRYQPghDyxMkirSMVZWXGEH
         yWGMYlKRgzm9LQPLV+eb19eZ8QnSz655pj572G4TuLSECP2+6Z7tFiRj7UCQYLJMGy7n
         w77L155c2ZvRt8nyTKqsXhdUHRNe125nQIKvZrNtaQlD3mpA25g/MVOqoM7ue+GZNjRM
         UwkA==
X-Forwarded-Encrypted: i=1; AFNElJ8PciZiifyt3ZMqMWUPKbGQrW35pUKxbgmXZ2gBLM+LLBJVjvfOvNJVDezeArTOBYIB6cI+/eYrInqQexU=@lists.linux.dev
X-Gm-Message-State: AOJu0YxJrhupX7fLUdtk5THPCjj92kxXsxYrIOfbLDL47Um+C2pFXib8
	P+wMXGJV8zrfSXDrOd0sDRRF3jvn9xIoeiZLEuX/Wd5eaxT8KxUADhpkfLjEt2T3AkH6mBqYtce
	lXnwlamedFomhU4tWHBXprRARpP/lw9bNXYDU2dw1E31kLMfA7EgcN/g46ZIU3A+7Y+Y=
X-Gm-Gg: Acq92OH9/a2MlXETWxh4+b0BbYtqJThKCO2eSBGv7zPgHQw9/bo7sUPH6x+XasuKtWf
	h6g3yCKOGQI3mdbZ6hy+neEilYSRfQwx4EeHCcKCfgkObV+sAliXDISndpdvB1Yd85Xy48NKaf5
	gBD6PYLIX1RcViZMficSmt3dur5XMSmw/GJAa4oKMBTOj7JsAQQLRFiGPzGFqsqBE2F12mOR3ZP
	T124V9om5CFCK/v/EZus210NvYrGDBTRqcbCBjuG4kU54d7Qvtx31aqlmC+MKOe79p8Sma+VFAt
	6K/6PLY2lsNp8N3G3R69zUIbxJfpYbmtBo8OGxIZdSP8haVGdwou8KOqVRzT0P10fCLOu40hyXd
	AHKEtQvf8rvA4Jej+sl4nywUwS3/B4uztNueo9kuoThLzCZIJblyF1sHt3/HZ0w6ZDSlWvgUplF
	OYQnW2Drw7pXIiaEkuAEtEJXh8mxvQKxMYKfyQKLnwfC3jaQ==
X-Received: by 2002:a17:90b:3845:b0:368:1064:62f2 with SMTP id 98e67ed59e1d1-368f3bd83ecmr2662360a91.3.1778661862222;
        Wed, 13 May 2026 01:44:22 -0700 (PDT)
X-Received: by 2002:a17:90b:3845:b0:368:1064:62f2 with SMTP id 98e67ed59e1d1-368f3bd83ecmr2662325a91.3.1778661861767;
        Wed, 13 May 2026 01:44:21 -0700 (PDT)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d2709bsm169158725ad.5.2026.05.13.01.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 01:44:21 -0700 (PDT)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com, sunilvl@oss.qualcomm.com,
        anup.patel@oss.qualcomm.com
Cc: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v4 07/10] riscv: Add RISC-V entries in processor type and ISA strings
Date: Wed, 13 May 2026 14:13:22 +0530
Message-ID: <20260513084325.2176952-8-himanshu.chauhan@oss.qualcomm.com>
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
X-Proofpoint-GUID: 1SD1hzPOfSgdhNbENHT1hjkDM9UiTKDB
X-Proofpoint-ORIG-GUID: 1SD1hzPOfSgdhNbENHT1hjkDM9UiTKDB
X-Authority-Analysis: v=2.4 cv=aLTAb79m c=1 sm=1 tr=0 ts=6a0439e6 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=osVkw33_48dge00NZUcA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA4OSBTYWx0ZWRfX/+yrg5cT1Yf6
 8RjrQeTK5+lEsjapnPJQOu4tU3ZH1t7xUjFRp+KmnthJIsDSyQyNziN7ZcXum8/6+VASkl2x5Ir
 DCd61DZRPoSgYrtBxBwgw1jqN7MSSzGmn+Sp9jW745Vj5KxuJYrsJ2qTjhBTxqBkT/LZjQT1rBn
 560G2qTklNtAgYB5FwjTKB+W1gZSwb0Tz7e4rBPFQ1Pw3XCj02HQV1OKRebzRty0fToJ/+OqaaW
 K/AMmzXU+jl6sgNBQs7qKoroq8itCqIvV/0O5nYU7uebRC6BLoBqgNn2ixx9xNP01fkNYOYAC1K
 AE5cVZ15aUHmh/1cVSB6mvVeEHZdJLTHFNQSTjRHKyEv9cBmJNmrm0+gWYAiov+LO3BZrFuGg3X
 C6SKLn96nPdGxycwrhx9W5B/aL6+NYsE3x/6YnMKjK8Zd0EwDvcClNBw7peMcvIZ+Y9zpYZMMsQ
 cwt+ZcYVvHr/84n0n1w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130089

Add RISCV and RISCV32/64 strings in the in processor type and ISA strings
respectively. These are defined for cper records.

Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
---
 drivers/firmware/efi/cper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 06b4fdb59917..1b1ab2f1355b 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -170,6 +170,7 @@ static const char * const proc_type_strs[] = {
 	"IA32/X64",
 	"IA64",
 	"ARM",
+	"RISC-V",
 };
 
 static const char * const proc_isa_strs[] = {
@@ -178,6 +179,8 @@ static const char * const proc_isa_strs[] = {
 	"X64",
 	"ARM A32/T32",
 	"ARM A64",
+	"RV32/RV32E",
+	"RV64",
 };
 
 const char * const cper_proc_error_type_strs[] = {
-- 
2.43.0

