Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19A7439346
	for <acpica-devel@lists.linux.dev>; Thu, 24 Sep 2026 07:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790235486; cv=none; b=lmuJ+C9zqJWwnwkLrBLBsyPKeo3waJA2xBoyNQ1pHG+IuI04uQEgjqR58IGGEjVWmVB3vC8ECxTh9M52rxWTmSTPcrjrUIKuwDJFns1HfWqGITe3BA3X3ds7RRAcZY4XwizMuHppZEu/rY+IUje9GmwEiokBRS1x2VNuTnn5FU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790235486; c=relaxed/simple;
	bh=PL8UoLF+ygZWvMxeFtx85isf5jQ4edZiCN25qkiuVPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HMor+2WkVLNLBgh1ZzObwCmef02CtxSgxyZwlu0XWvxlpzGIi1nQWeHt3CACyawVwhk6E/lshC7JYUOviKTQQNuYEwyUipdnNXNB8CGR4xFPm1HYGVuiNM3Pk8v3FLyO/gF395B/rUBEHlJ4eGY2bylynv0P6+Ahq+G/c/BJLWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Sww/9JMG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Eo75uf4z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sww/9JMG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Eo75uf4z"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5e9ep772433
	for <acpica-devel@lists.linux.dev>; Thu, 24 Sep 2026 07:38:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=9ko9wYXNb1l
	9AJ4BTleLCn1bm6Eblo34heY8xr2hrJM=; b=Sww/9JMGycO/MuG9UC6K+WzENPb
	Ik/71spcOH+1tGG/HaLWYAHINktuuyBGK3SROiojJndlkOsmfbeUEC05l3LPaAFQ
	m+XZaOqGc4/KUqv9jRERX/+W600Q7J443C7rTtIwft7ddRjU71oLEIBe5Lu89ywx
	mNIxMEDVc7UROB2DLovIbWv8F0Rk356pjV/L0NIm+EHLgozUs7r5vmhDgsVtuRtW
	3EYaGt4H6yRXZE36c04XUxOwJuGYFZi3s0HPF7XIMIXzEccSn+VW7C1bLPGIJdJA
	MjF8AVgSt5lWVCWsUHnocS/U8b8kYA+7GWtMGWEXz0IA7pW+H/bXST6B8QA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvr909n2v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Thu, 24 Sep 2026 07:38:03 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30c0d568830so3295414eec.1
        for <acpica-devel@lists.linux.dev>; Thu, 24 Sep 2026 00:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790235483; x=1790840283; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9ko9wYXNb1l9AJ4BTleLCn1bm6Eblo34heY8xr2hrJM=;
        b=Eo75uf4z8+ciXF1FPjXKSHZTsWSWWNubKdbqX6aHKsVpZ5oJEs4CnubYlg+1ugXZS+
         D2xJoHsFxXM0Qo9Asdlr87nFANswEIW7pO6HUCzRMv7iodjezSMk0Xphl4HRew7YoRW1
         r/mqVZ+QgXXHP9J7bs+I53y9W4MykprNK5OTsFHwkejtl124nNwJqbWSIztUtxvILwKd
         GqQECqMmJZvrS5GoE7UQB4HQg7Ps9/Gk6hAsA0uOV8TrA0hQfZ+BeLKwOHPF+70anXxf
         TEd+q711X3oJt2XJMNmEdsoC2qrzTEIsmXsSEFM+3mfpkHtBRfSaU5jtjWeBWyytZVZs
         VDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790235483; x=1790840283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9ko9wYXNb1l9AJ4BTleLCn1bm6Eblo34heY8xr2hrJM=;
        b=PsUNKmMZ0+dyJoqg1bYScBUw5aWuvnJStohREwVCpZQVHnEua0hktYL/2tk9OxjJW+
         1PNzaD9jYjd61JBmHvI39RTI11HMlIA2T613XkO/BaodUymK83h+W7DHvj7ceQQ5+XQL
         uCFc6/PL5nJa+mP885wqRqQNhZGkKAIk+WA3vIyJt5epf40kKCSSxFRALLsEGtd1n0t6
         UV1adKsixkZkcxjliuSXlP94dlNjVeKt60/BsqadA8SYPVQQJRLyUcnBluGOqTEaQIeI
         +pS7CdI1WiboYC4sy+lSn1gzheZJwm0tyhXKt9SCGdPYdHUDzZI2dIXd7wBFUKC5aSks
         Sl6A==
X-Gm-Message-State: AFuF++lAbMAwkt6BAj7ybq58dqoywdRIZnolyBPvcKZg9wTf92Bmhrwv
	1Ae0yHD7OgL1Tw0w+HiUKAJXi9GqQbpVQTEazr1/Z1GPR1Rg1y2SVXxqN/3UzgUcFGyVSavuaA3
	kduMXvdRWa3vImSNsXaW7K/Rp5Ft3E3Mz+fWX1VvkQd+zovztIo/F6UL7SdUFtAeRkzA=
X-Gm-Gg: AYBFou1qrcWGvDwJnI3EpCujKh8DTJRLiscQey8MUztLevaIcfbxgAgMKyfFXyzuxhq
	9oY9i2oi4ynxMaVC86lh4G83ytF85k4WcE/riHPkvQbKQMkWPmEx+wa4JsC7ruvOC6iPdWcNVch
	wdH2Z8Rl+K7JN3ErZqI/bXTiWO4prc7OvKGMLOiiOpgMbJ80rjfJgS6oDSTHT48snPa3XWuTgSU
	e23s+J7NIgZnuPJdaMcXn3bsD/Z5eefzB/J7wyfKCel0No7ayRdoPwvO2WBD6vWIdQwt8as0+np
	BBC/nThTeo+R8CyNlALsPA8qFLWzBj9ZaALl5R5qiHUHJNQoFD/AFVF1egZTQ9LNs01Mm1t0PPt
	3Fz6xLoEklRvIu4kf3pBhuM0UMAxMO0KvJRcb0ShSe6gaM6Nns+eScFfJHZdm9EIAcQLnm0G0yX
	y+19HXdsJ8MzJ4ngD09IbKWeuI
X-Received: by 2002:a05:7300:d115:b0:33c:e82:70c6 with SMTP id 5a478bee46e88-34000b32287mr1161306eec.29.1790235483008;
        Thu, 24 Sep 2026 00:38:03 -0700 (PDT)
X-Received: by 2002:a05:7300:d115:b0:33c:e82:70c6 with SMTP id 5a478bee46e88-34000b32287mr1161277eec.29.1790235482398;
        Thu, 24 Sep 2026 00:38:02 -0700 (PDT)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e95c7cfd9sm12120680eec.5.2026.09.24.00.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:38:01 -0700 (PDT)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org
Cc: acpica-devel@lists.linux.dev, anup.patel@oss.qualcomm.com, ardb@kernel.org,
        conor@kernel.org, james.morse@arm.com, lenb@kernel.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robert.moore@intel.com,
        sunilvl@oss.qualcomm.com, tony.luck@intel.com,
        zhangzhanpeng.jasper@bytedance.com,
        Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v5 6/9] riscv: Add RISC-V entries in processor type and ISA strings
Date: Thu, 24 Sep 2026 13:07:11 +0530
Message-ID: <20260924073714.1650588-7-himanshu.chauhan@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAzMiBTYWx0ZWRfX2Oqtry7oo4Ay
 7r4RaZnJhEeCR0FnpQpo1c9T7v/mrgtzPu7tcjJy2DocUr/qSgpoLd7vLdWvx1NkXroK2QZWu/e
 6BWYSsfyEaB5fTgx9FUovdwFHv37qu8=
X-Proofpoint-GUID: TJcFZ0QfZEytHphxUsbkZAJRWsp7jXo1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAzMiBTYWx0ZWRfX5eyTNAbEojmX
 EYuN72acHQ9DLe7LuLDynfdV6skE9UroH+zE5nYVP0ei1wkXZ9BPZYlXeAWf7UyjxpVgNoWWCCD
 GDJYppFZuhm1o93vKG2q1woJmLPYv4NOD6QLzDaHPoyV6V5X6yiYRzE19ZGcechFKVAnCLhhe/x
 OBQEQKRmLrp6ioRibko821EeqW4pEGjj35FpcUi9d2tGgEEBB56f1g3suz54JwtpDxPLX9Lak0Q
 s0LxQtDlNdA1+0TRzicppUSDMWtFBWNRCOqxFKM9Nrk4runYvFflcn7CbwMmXNhMT5nwJMH2xHO
 5Dtitg10DBeeVYj1D8SSEsOZZxUojH+99FurZKBsbfhYPVYqWRkKUy3/AyQQzHzYzWdnZOoI1BE
 uscXqRilX9+SiwEznW1ksYq57g+wAT71ZCoUT3akYKvMkOMDF20T/vxb/iaywaxiHYwoDSb9JLe
 HuS1OQYfX1SJVeR4n9Q==
X-Proofpoint-ORIG-GUID: TJcFZ0QfZEytHphxUsbkZAJRWsp7jXo1
X-Authority-Analysis: v=2.4 cv=fMusTpae c=1 sm=1 tr=0 ts=6ab4d35b cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=osVkw33_48dge00NZUcA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240032

Add RISCV and RISCV32/64 strings in the in processor type and ISA strings
respectively. These are defined for cper records.

Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
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

