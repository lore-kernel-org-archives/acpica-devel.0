Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8CB330650
	for <acpica-devel@lists.linux.dev>; Fri,  9 Jan 2026 09:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767949373; cv=none; b=slQQWRCTjHXsS0NtVPird+g8M/upGtMlhsO3ttT0bXoVLE0tdIncEkAzuvrcD/IyMyvyWlQoPc9AEfq46bmV1qard8kXcKIwmE8jv5d5UpARJCZMkdSThjFTbxYetTEgySUT+yAT/UYxcQp6nDB169FHKWdBdaj8UpI/lUfGBc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767949373; c=relaxed/simple;
	bh=W9Z8ad/AN+KNVWAE5HEzWUcd28KekPEPytmpsuBKjhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mPXKSA+QccnkYVLhMnbUf77HzODowpy66RD3tbx6xQ4EjMVHCCdEmopc0FmiOBPshPr7w7Dle+tAjc2/gBLJP/FIGiSPCNJLYHI25dRknB0sK03nXJ/AAcp5WGQeFf5aWSIDgao1JkdwfyzrulOOnO6PjRCvxg6w9qx7UgBd+xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oXL+N6Dr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IpUksdXE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oXL+N6Dr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IpUksdXE"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60982d7w2184045
	for <acpica-devel@lists.linux.dev>; Fri, 9 Jan 2026 09:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IQxw9pRj4KjsMr71sZ2t5x+9tK+jz2fwPiFRsDjX/i0=; b=oXL+N6Dr7UqfcymO
	YOAN4imTr5a2HEp9O15FtDGt3bopjHJxqZLVAMt+55EhAz9PZPqW7E++GKXgoUDq
	znXArl/vK2K0oU/X3IuUN/mOzE3n+vnKN6Pv+cRlZAU+ukslMdTx8WYjajdG+mi8
	BQKCTU3v9ft++o8G53U6ip5sOCJMUK0BnnoXlo4MV3dRniiX9wF0zny1lxUm54tI
	ikqHC4xGhmhGskTyAaBT9pKIfZnLplawfcuFj5T5YhlgoA3pUTNnHjZvNB5CSvJw
	Wry3zeANBB2n0MitQB9duLkc6yLIQcWgPUjsFNqEm3GDLmFj4om1ME0K8pKSmtD8
	fny63A==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjwtn8656-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Fri, 09 Jan 2026 09:02:51 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7bad1cef9bcso7173232b3a.1
        for <acpica-devel@lists.linux.dev>; Fri, 09 Jan 2026 01:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767949371; x=1768554171; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQxw9pRj4KjsMr71sZ2t5x+9tK+jz2fwPiFRsDjX/i0=;
        b=IpUksdXE6JrJ9zNqDi4iEArZAJbC+Lgi7Jc6MBe9JcEG0iF+ofjigiAuBARrINK5x8
         n9+u7fFvwyXMS0EeO1J30RefyIzXGEMy4XUEsHwp9adRopCvq24UitdhH0XDaJSNSs9a
         C+KrKpNnGUeh/9ycbNgSSQo97hM/RIfvnR2wbd8SGDDhOjwQy9++7QxsUIyfRjoefSrO
         Hnaj8dTP8K2EbCXU38hprBRTqPN3eaX41dF5sNWO0bnzdRcXKN8xVFAaANP4jZTHnP4n
         e5a80gHgdgtK8O2Hdoku2zuE9LR6t3rTU3/miuc4qjq1EWwkrbNWWdA/+/MW5hRdzy1r
         rtww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767949371; x=1768554171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IQxw9pRj4KjsMr71sZ2t5x+9tK+jz2fwPiFRsDjX/i0=;
        b=chmBnLQtBjumshVKVa0ZW1FeSScGqS3vrrPBwgx8DsYOdGrgabowzZ6NUjsXY685zl
         y8PwltecwUHBDe+E8y6ZzcWl1LnCoXeIYtoT0DEkOrLk1THqMEx7AI3Y5oK6E5N9wA2Z
         4OWuZWig8xyoMXGmL2VVBQG8uL6ZPXF9lVyanZDZbsBeY/6HsZdonAsSS2l8H+rEz5lF
         oXvAkKnkxSGYE9gI+4wHhgU4BjMOaFMpUolfTvTRt5PBaQeCf3hK6ES9a282+O1em7h9
         H1WSo80p9tGUk7Op4rhsQtg30isyd4k9XDVUrYfeMMgnl9ZvEJ/dAjprHH+m9kIWePo5
         BuKg==
X-Forwarded-Encrypted: i=1; AJvYcCUaUjwpHrYAByULWKiPCxGlE8jrbU6vgMNwM6ySg+PYh0pq4zvpmyDwsrEKvY2SjktPdTbSWN4oauyttWY=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx1J47ZY2C/C6m8psAEDogtaBmpJLgYQJcikqNzoQ39Jk0i1Yu4
	O2xpLpBryIACgHOSM/GgTMJPf2tQLKvJijYCFquUAudBwtyQ3Bs2xnvSWGnM47IaMnI1DfGSvjv
	8H8pKzIFOoY2zvOo7/rK8NZn5kmbMnEkHihUAq4erxBBEOQ73wRz2EOJ1bTclw6o6l5w=
X-Gm-Gg: AY/fxX5Ftu9Lf7I3M5XhIbnmJtRwzjFm3QDhZHZprvx3szC3MU1WISq2RsNZfDStu/z
	sY57V3CZMEihKOggK5ufcYcnAayG/1sNF3ZIe/0mv0rkEGk2EC2PUfN3/BdfAkKbe3eYykzFz0R
	CrphiOUKoU0D4L0RXq+aCivQAvxQfd0cR/5GWQoErcEH3gPvqQojSegiW00vU+Ng1fC7WdwR3r/
	dlc2KuQM4AbQaKNcLEuvrWggS729EMTYTmAawoZm6u7nl9w6a/7tqLqlFpe129Rmj3xkYKIDNYh
	5d0DjoAN+BH9nsiJr8eb3Y2YQgJEMftnz8LXe/pEtmg8+NXkhbPr0NIZ7DcCnkw7a+JJea8BnbJ
	QtnQ1v2T5Bh2NbSqWkH6WTFkxvoBFY+85NKCUgU6THhqqUqf6QMGFBmwxN3AHJ87TiK1ZmhTC62
	j+Xa9OyJFrzEHYwckh3+m8Omz7E//U1nNlHA==
X-Received: by 2002:a05:6a00:3019:b0:806:1719:295a with SMTP id d2e1a72fcca58-81b7fdc3515mr7977774b3a.47.1767949371252;
        Fri, 09 Jan 2026 01:02:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtfwiA+2BFdveZ7B0QFne8hWPdA9OtjKKcqFuxwp7fzla1g4pqTzNpr3/SfNjQP+cNiU4jrg==
X-Received: by 2002:a05:6a00:3019:b0:806:1719:295a with SMTP id d2e1a72fcca58-81b7fdc3515mr7977725b3a.47.1767949370599;
        Fri, 09 Jan 2026 01:02:50 -0800 (PST)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c59e826asm9831562b3a.54.2026.01.09.01.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 01:02:50 -0800 (PST)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com, sunilvl@oss.qualcomm.com,
        anup.patel@oss.qualcomm.com
Cc: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v3 04/10] riscv: Add fixmap indices for GHES IRQ and SSE contexts
Date: Fri,  9 Jan 2026 14:32:18 +0530
Message-ID: <20260109090224.3105465-5-himanshu.chauhan@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109090224.3105465-1-himanshu.chauhan@oss.qualcomm.com>
References: <20260109090224.3105465-1-himanshu.chauhan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: THJWzSuCsDuuaOXdWD52S_M9DeX58mvq
X-Proofpoint-ORIG-GUID: THJWzSuCsDuuaOXdWD52S_M9DeX58mvq
X-Authority-Analysis: v=2.4 cv=Uohu9uwB c=1 sm=1 tr=0 ts=6960c43b cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=h0uksLzaAAAA:8
 a=0wheRbxtA0UXKxI4o1AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=MSi_79tMYmZZG2gvAgS0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA2NCBTYWx0ZWRfX98/r1a4eRlXu
 k1szs/y45Ts2E/eJOCMRm5Le15LVOdYhtm5ZH4f5H+k34+I9plrj/0Zpj6oNcFm0Us1Dz5GuH6z
 0nkzkLnZ2sqB6SrZrqis9I2BuwPmBJh3Cu7s8GnFvZ/l8iooivzQm9g0GleyIfBDt7TV/cA9AeI
 0G6TDYW+JCVBdlcqJF4OAHhG2M+TSerU/jD9e7FNCuYVmz8UeAWRV5kup/EBfakxvG8BpAN3zT/
 HT08Ny8mA+R6GMV3DFnqTesgCmVNXzT9l3xbMrce1x0uE/NhBKFOW89H/GaDNtgbYahGqRt7LTb
 rNY2N4A+2ly3yQaU2EPddWh49R7/h6Gx7kTCcD4WTu9TB3c0rUTtQn0hqHrzfdZJoPj7qGQKmkj
 WEhoVh0xNVeXSLLRGqchE7Qp4AkPgXyzmpNAyfHKs9uAUfE8XPibAS+Zr/UMJ7mIfNFDwFTHD5g
 19kIrOIxWliSIEIIgaA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601090064

GHES error handling requires fixmap entries for IRQ notifications.
Add fixmap indices for IRQ, SSE Low and High priority notifications.

Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Reviewed-By: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/asm/fixmap.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
index 0a55099bb734..e874fd952286 100644
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

