Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9ED3559F4
	for <acpica-devel@lists.linux.dev>; Fri,  9 Jan 2026 09:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767949388; cv=none; b=bbejYOwbwFid0EUxlQCNX+jpSTh4R1wrf9ukrHxYKXE2qvfU+IGWIqX+5jlXBANqZIeg1HrTpeg7FKTGNoKIOqAgNsG5LqcLNtFPNAQ43pmWA0e1UkE05Y0kD009RD8ghLzLPbUnnAUDa9sCefth0MZ2QpYXsChPrHyVCGbA3pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767949388; c=relaxed/simple;
	bh=EP/YRbXVni6KnkHqzoLkfNZUBJCRLmzZeoDK8CqJDaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZHXuOEU4bYLxlXopBhTvtXxsEpvFLIbyhIF1s5e0RjLxGRbEi/twT6n7w6oZVyBJ+BY8RvDylR5HsRvyhAacxXirvv7cG1KUmRmr4r2uA9Ejxh4gAhTW1fAamFb8x8UE745QsRke/X6OXVQtckdvR+BIljmP5hD/5mnJVxbKnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j9naqlU7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i2A/sg31; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j9naqlU7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i2A/sg31"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 609673Ei3141619
	for <acpica-devel@lists.linux.dev>; Fri, 9 Jan 2026 09:03:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=asLWQeaR4rF
	QlIKMK2s38SWm7Eqp5rcJ/qvyglZlI+Y=; b=j9naqlU7FvOy/xPALLlXbSgEqH3
	n9vTSdmk2dj0lEWOCOz8hG7TiXaBDugBCyDyE6a8HXeuIOAi2OYqXvwrrOn7MUJh
	07XALIKMgcCv86VYtLSvU+wEzidral4Ejc0vPTx6pq+S/lBvYAHIazkLHKuWyBro
	DEX3HhPVk49ZnIheyBZaTwBIfX6+coq60a7g+KvTmtxpPCuNVaF0Nk9FP5sbaSi4
	bNt9wmwYL9KZatmrw/TeBEicrfN1+b8ZpwZx3nRw/AUneHycuZ0JrQF6rKCqIDs5
	4FNf+Q9mlTC0VsNJeCveoWhxw91bIlNYZZTkXpKUeFTJPgaZfi9UydAuV0A==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjj8j21c1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Fri, 09 Jan 2026 09:03:05 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-815f9dc8f43so4564805b3a.3
        for <acpica-devel@lists.linux.dev>; Fri, 09 Jan 2026 01:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767949385; x=1768554185; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asLWQeaR4rFQlIKMK2s38SWm7Eqp5rcJ/qvyglZlI+Y=;
        b=i2A/sg31Fj0JFKx/vr3kpVeMhAyPqAWD7/7aMNubngIR7CqAmKKzTxidXtqH6ud0VA
         JgD/8LQu66wBoqfXSjepJeCizDtJXa8MunLbdiawNORwcbCqcUPocFzucpeL6C/BCDwB
         1l+lEaCtRgYK2eQY/MgPOnlaQhi9xs5ijutMtSU57bL++H8r8zGAjyHZfY2YmvCBgfZT
         RfuPTCCMXbPCgRE4aJPMtmRCO/YokzALEUT/ZPqyNJ5uB3sppLT7BJ4mzooxBXgryVQT
         0AJ3A7dBNVyOCPQ7zfEIWRnObXU+7gLYBXDXL/No47xsqa3IJOYJ8IYT1/8q6AZLYoIw
         hVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767949385; x=1768554185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=asLWQeaR4rFQlIKMK2s38SWm7Eqp5rcJ/qvyglZlI+Y=;
        b=p9jqrnoB+V4ExyB32xQSoFPO2VF6+6/D6VlPUBHFzvuPpbbX3DDegqUY0sdC5OnYs8
         UTH5rmshSi82coU2G+4jOkpt9HvdC4VN5MggZNeQuotYxsQCwz7giEWmA2PKFNe3oWD8
         dxjLmRD4HCfiazjJckAFN7KJfynT9K80K/hvJsn9UwE0SclgO+xn+ziRQ0sjCJQG0+GS
         UU0mFRbgZTRShdwC80QTiABeIDb408PlmfeY+4ANTJ9Rfx20QZjDaEXdPRYg7iLNlxbh
         Yn2SzVztiaLQbgJ1etJBhvaotCDLLY4sorvK+a3U/2EhMosRUVVAgZVYkXizNbwHfwqh
         R/2w==
X-Forwarded-Encrypted: i=1; AJvYcCWvaJ787t2xwY70JXyE2ZrYmyRBCsk9+zsjtRvzlg6dNuDM5FBYxdf/e+eWf5CX+BcxIsaWu6fS6lJw8Co=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2oBLPgjjUeG7uL1kcvJkOVVXuwEV0PFTQaTVtChDXKJOdd9UD
	2gA+LYoezJC1dFIgbEke9od0yLAw/2LQyYrODpHD8E7jR57Uom4gWKfZc1QrUbWB/IJPVuwScxa
	gxnuMXrBbBSwXFa7cHxxvYWfsdf0aP0fOt6yimOlDYXdrFaItSkEhOeFZfN5fD4HattA=
X-Gm-Gg: AY/fxX7hKlG9eeCtqcn7cXuHg+81cRAAjpdWfHGiGycHHFT2vMZjQrauwouJEEdjwbN
	kbNbWkHKU6hyiPtwO4VgvULrlXaHEtDQFHiB6vbAhlGEp4m7XYYI+hHNGwuM2PDmiJahX/qYIxj
	p/pQpHO3HlCV43vORyL5iRhOgjObcHuH+Dpw4nDIt3xjwN1hryImdvdM7ZJlZdkK/guKxFhd1Wl
	rRd/LCXGgfs4dPXjmkkRLILMBxRvhPjYQurLEDxQVY1moY9Kqrery1VeSXqBUtTnz8yKNQ1Qyei
	h3ITpc6RrErED1Mt4j2BWSlwcduyeZJSC6BHLol/RW3RyFxZxzL57kPaX4vJlUUQSiUx5rDb4os
	cLLLW9FH4xRqbP9SMsN/THcY+0SGjCn4CvroTxHVjnb1MlZBSFyKWiC2wNPT9fb4vx0JGz3c0OH
	86dcE+iJv5YO7FAjOJoavY62Gz+2jrgmIDQw==
X-Received: by 2002:aa7:808a:0:b0:81e:96c9:1335 with SMTP id d2e1a72fcca58-81e96c9166amr509865b3a.21.1767949384612;
        Fri, 09 Jan 2026 01:03:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQwj/yWlof0KqeGRkT5R3hBYh980k6Id0SZ+6+0ezp1wE4OVTwE/4kvoozGGXmSkIj0VWIKw==
X-Received: by 2002:aa7:808a:0:b0:81e:96c9:1335 with SMTP id d2e1a72fcca58-81e96c9166amr509835b3a.21.1767949384107;
        Fri, 09 Jan 2026 01:03:04 -0800 (PST)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c59e826asm9831562b3a.54.2026.01.09.01.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 01:03:03 -0800 (PST)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com, sunilvl@oss.qualcomm.com,
        anup.patel@oss.qualcomm.com
Cc: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v3 07/10] riscv: Add RISC-V entries in processor type and ISA strings
Date: Fri,  9 Jan 2026 14:32:21 +0530
Message-ID: <20260109090224.3105465-8-himanshu.chauhan@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA2NCBTYWx0ZWRfX8yu0Ktdazav5
 P55xWMoAl0fKzdX2LU9B9ua9BFQwNAVEx53HEAGC7PC/1WPwVEeOxNOa99KnxdWnUKDPFF6fA/i
 qSTkHkuSSg05kciMyUbFWdJESPr41XFkJOWzm8QmgsE3CcB7RZysMF/vhTI5F1Ic0VsFWnD3f8h
 wuMtuVpqlRh9HDkWgHX9OZFYVdfo/NSqRf22Nsq6XjVmxEcjAKkczHqxJTWUzep1UPeZxAl9Pcv
 nmcrSLRt/dw+zbRJtC0qFil9PWgrCIt0H5ZKG1/KmrHpwZPfaQND4ZXAYm176LWp6YRiWsWQV/2
 89B1fnbcyINV5awFT6VAxDj+gDq/6eMYR0nuMfK/qFpi+BUphy7UXLFNN8z2sSsYAJtvdQbMrbG
 RX3kEcGu6wjGEsHZKmD7V7JaswTpkuxfLIcJIJlvEQ0iZg0UcnNEdyYTYfRcdw/+LHo+aIJo/f8
 sdgIynqVljN0cJ4X0qw==
X-Authority-Analysis: v=2.4 cv=JIs2csKb c=1 sm=1 tr=0 ts=6960c449 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=aZI88Kzba1cNDf5AQqoA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: xvaogFokYePLwFWqjBXmierTwgFuWP-l
X-Proofpoint-ORIG-GUID: xvaogFokYePLwFWqjBXmierTwgFuWP-l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601090064

Add RISCV and RISCV32/64 strings in the in processor type and ISA strings
respectively. These are defined for cper records.

Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
---
 drivers/firmware/efi/cper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 0232bd040f61..9d591a294327 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -170,6 +170,7 @@ static const char * const proc_type_strs[] = {
 	"IA32/X64",
 	"IA64",
 	"ARM",
+	"RISCV",
 };
 
 static const char * const proc_isa_strs[] = {
@@ -178,6 +179,8 @@ static const char * const proc_isa_strs[] = {
 	"X64",
 	"ARM A32/T32",
 	"ARM A64",
+	"RISCV32",
+	"RISCV64",
 };
 
 const char * const cper_proc_error_type_strs[] = {
-- 
2.43.0

