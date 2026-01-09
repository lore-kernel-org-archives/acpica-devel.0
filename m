Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDFF330670
	for <acpica-devel@lists.linux.dev>; Fri,  9 Jan 2026 09:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767949381; cv=none; b=RgmUYqNaweMaZVjQJkMiGf6jNEm2wLvL04ZDU8L7d7XE+S741eGwO/jTYyezfcqd1EqyqXhvrDg+5xBGWAVdkoD4F4pDqQgS9ZvP2FROBSt2XCMnOigHGaQYHJkQpHEuxWwaXf+FnIGRZ9yBbxWElSEBhFaG7q7kCCxAdk1hhY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767949381; c=relaxed/simple;
	bh=oEof/wOPgbWYhhNlnzJuAEyOdqQayAwN+vF30IVWeww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cy5/GQMB0ENBTYM5RZf3jxB0GkM/CCccU5WgJnrnPxZ17B2d9iSRNugrLt8hLRB7p0BK+tj2l6ChX4kDBQMYKHuWtT8Qb9bdXM3NHBMzObq3OYq36oHB7y2L/WxchHFUU9iDRChpvPm8KjrFQf4NJj73PzJLXrrPG38GDBWW7dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BZYzt1Zl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fWvf0pRh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BZYzt1Zl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fWvf0pRh"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60982Y6N2184011
	for <acpica-devel@lists.linux.dev>; Fri, 9 Jan 2026 09:02:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=d4ucWhJ3h8W
	TC/Vx88wr4lDxFFX8PD/AphAsZy//mrg=; b=BZYzt1ZlebyBfYGZ1iZvKCvxRjV
	/XsXeUmeVGCAr7Y/ZQEnwO5sFv30zU5TIBxzC9+AUfTcMKqD6ZVDQ8fGvZyTe8j0
	l9I01Tn84VvmtT6LkpSzRccL8RZ7ufW7619ncKlnP2UUHefYRSfp1D5rgQcaGkSv
	aT86WU/PP+MUzWVx526bRJt4sfdX9iaxjMgcPiazyxNnGyIHEXsRQ5mtHQIvIV06
	YhCwxiCsHsH0zGPQavn4ccYKouL6LMEjN7hg8k1seu/hQNkT4SX9p/RpcF0okiPS
	foUowAjdtVI0ouAkGy1eDwyDZXSBIZ7wjH5+hqFYENhpp+mR26yLsk+h5Cw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjwtn865k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Fri, 09 Jan 2026 09:02:56 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7f66686710fso8153807b3a.3
        for <acpica-devel@lists.linux.dev>; Fri, 09 Jan 2026 01:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767949376; x=1768554176; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4ucWhJ3h8WTC/Vx88wr4lDxFFX8PD/AphAsZy//mrg=;
        b=fWvf0pRhVMuMTjd0eq+8R/pMIAewhtW5vAe4M0EN+gRJBaDDDruTYEp9iKjOK4vppB
         zJzWqiFS5UkAXZn7li+KutIy3NtCqF1T375hWjWBxF7lt9T6uEjO19W8emkFFpgixwYs
         SAJKdAGOawZTOcbfWE1v40eE/8vvWQLAhYRsRTNVLmHlgldT9U+Qg6AxP2sWnwVmMYhj
         1MZJPNhjPU3DaNSfTisANWneD3ZNQtQvX52xv1qfqUZwv26KKRzRNijSwL8Qo1a/yhiA
         GSn7rXhp+A3eNei5xVMy+7btiSdLKc38ss0iCVVBE95nkbSMrTkNw+fjOmXX2pJ7j0Z/
         tzsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767949376; x=1768554176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d4ucWhJ3h8WTC/Vx88wr4lDxFFX8PD/AphAsZy//mrg=;
        b=wEx+r+sLhIXWliQiaJBjQ5/ek2GOpNMXgknZXlKImox5p260BKXBOJiLMVxq3tGD6B
         23h4kgN2tK5/qAPd3uICchzM1l9eifKNH1vYObDX3diO77gtrWd16UW9AIxxI2F3cDZn
         oFnkb8l9AAJqEe5/p7fJ2g6LAOKiWGVSCvJ3WoO5SEXQ7JPcANHy6Ystx17t+ZU5kei2
         H6lyg/53NVF44yraxJZVxcY3gYXyDMw2q78KhcZrWmDQkpAmcxPpEOwxgiPYklv0lLDP
         XPl73UyjQ+1UsZYuhPtY4N28EJPuNbXODS1BA2XA71sWR06aDPIMyTx/sUmQoPDdb+vA
         0d7A==
X-Forwarded-Encrypted: i=1; AJvYcCX0Ptff+vQyMZpqUYLM1aJyQFI68i5+5ly92mb4wE2s36qOKR2gcLJMH+goZ2+2bC7hFh4ref9nfFt2+Fk=@lists.linux.dev
X-Gm-Message-State: AOJu0YzF5nQtUKDacOufJlNPzI80G9Exjzl35sp0NPFImYUw9Fmd1THJ
	hj69TbQodIkaDBRfonngR9vizks+jXh+Q7O1KUKnigWxZxAdd04njoHzn69QMYBmNNmOWR45I/Q
	Q5HaIUIb4JjL9F34lt9JfR8/5zsvGAPha39qv/G6vK/Kl4vpQXtCQ+1htR8V0YYxoar0=
X-Gm-Gg: AY/fxX7VRZlrgrFFocsfygw1mUqzV+8tCP2uGQ70PPFBuyReZjt4dTEBkMMLC8yA9Er
	zeOSRZdPst3Q2sigIbJeXAi50zUDEAIQSh5lxr/CxQxuhouiNZDHuYw8RTIhLJHn3OlIe+gM73X
	vRql5gOMiFlRWrVTLnpEx50qu1C2ZjFwfp+di/Q9uZsdnP4AVT8C13dWBV64EBA0kklIF+vHNa3
	ssDUzWvNcI46pV3T2r3sNErsuvYVCIs24waOcPZ57bLhrK/JTEWFtlpClXMWGRapF/Olv0qAPYB
	zYwr2WAe2rhnJ6ZipGIEXjzSjck56qHzZEGuk5Dda+evrb7J1A5OfhqvFk8jK9qf4aaIIAUW/Ur
	dz1dQznGBSiMbLtIrosa5mKc2ffZpJ+MJzTPPrGo5UXd0bHrSx+cvAyL+aGtgGnE20vVDqhAp5P
	yZdUSiyS96PBVxUuY0GIYfFfv0eqXlRFWSdg==
X-Received: by 2002:a05:6a00:909d:b0:7f7:4dc8:55e with SMTP id d2e1a72fcca58-81b7d8621dfmr8786986b3a.7.1767949375618;
        Fri, 09 Jan 2026 01:02:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7zW5d+nSu+0wcfE2eze2NWNEmecsW0E5hntD0qHwPd/5r9VK82uccFBhoCMXa8NAbj/Emew==
X-Received: by 2002:a05:6a00:909d:b0:7f7:4dc8:55e with SMTP id d2e1a72fcca58-81b7d8621dfmr8786945b3a.7.1767949375086;
        Fri, 09 Jan 2026 01:02:55 -0800 (PST)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c59e826asm9831562b3a.54.2026.01.09.01.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 01:02:54 -0800 (PST)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com, sunilvl@oss.qualcomm.com,
        anup.patel@oss.qualcomm.com
Cc: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v3 05/10] riscv: conditionally compile GHES NMI spool function
Date: Fri,  9 Jan 2026 14:32:19 +0530
Message-ID: <20260109090224.3105465-6-himanshu.chauhan@oss.qualcomm.com>
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
X-Proofpoint-GUID: P8Rzf7mhRI__IZx3HdxjAyIC-mKphO4O
X-Proofpoint-ORIG-GUID: P8Rzf7mhRI__IZx3HdxjAyIC-mKphO4O
X-Authority-Analysis: v=2.4 cv=Uohu9uwB c=1 sm=1 tr=0 ts=6960c440 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=-FlRX8pefk0TmyAjS3oA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA2NCBTYWx0ZWRfX+4KtUQK+i20s
 vg0Nv731p8UOaP3zmvuW3lJ85shITZlPiKnrkvJr7WhEX9dKNQVjOpDEm4BqYB2derX0fmUYPFI
 ij+/6/CpwitrBESLC5FnrKv1tn780ED9jjAa9RZ5wAI3qRddPL2yIraTAc7/U398MxUSR8AomfT
 Qo2WxPca63GCCXMsTBu49k6fIUeOUmXs4201BILRwYtcI+l6SsE0uf7ebwSqGkevkKyiAk0tRFV
 ZU5hrKka9e5gH+Tol/+IXiYRB+SKHH7mGhAc389Ep6V/8RDhcdpCLJI8GYAvENySIXUIroDpzgP
 TU3R4bMdch4b8qQxJfw2GUjEQTeto9DLS4jZHvveJRZ3L0PPVn4pwsJB1SWQAROespNgYvVMYCq
 9A06tB7CnVzkwkqH1/5kikZDd4wWXLoG/44K0B2G1BKuCr/oSmAUhf/6cib5ZFR6bHQpWrubhMH
 Qwd/qg4csfAz1SJ18Zg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1011 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601090064

Compile ghes_in_nmi_spool_from_list only when NMI and SEA
is enabled. Otherwise compilation fails with "defined but
not used" error.

Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
---
 drivers/acpi/apei/ghes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 0dc767392a6c..6fd84a1772c6 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1387,6 +1387,7 @@ static int ghes_in_nmi_queue_one_entry(struct ghes *ghes,
 	return rc;
 }
 
+#if defined(CONFIG_HAVE_ACPI_APEI_NMI) || defined(CONFIG_ACPI_APEI_SEA)
 static int ghes_in_nmi_spool_from_list(struct list_head *rcu_list,
 				       enum fixed_addresses fixmap_idx)
 {
@@ -1405,6 +1406,7 @@ static int ghes_in_nmi_spool_from_list(struct list_head *rcu_list,
 
 	return ret;
 }
+#endif
 
 #ifdef CONFIG_ACPI_APEI_SEA
 static LIST_HEAD(ghes_sea);
-- 
2.43.0

