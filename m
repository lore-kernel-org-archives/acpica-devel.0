Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F38330675
	for <acpica-devel@lists.linux.dev>; Fri,  9 Jan 2026 09:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767949372; cv=none; b=gBlR8nypWsh1dcEcso+Fr0TVoZhf/ZLehdh8YUF8r8a28X5MH08l1aFVU9auqbplTu41opCfjsE9D+/joL9MBy4FnSrEfRh0c4dcOrHK036QFL1KgC02Iji7fvxVvWt5MRxz0CMiAo9q8a9ogtz9m0HyTqwIO5qk03yqP1Llj90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767949372; c=relaxed/simple;
	bh=NJobAjoWQ8xOwxJzStK6E/I8/WwLZImunxfC0L1FZrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gxj7zQLRF3i9gjP68DUOLBNpHbt5CaxIxq3/rY0IOYq7XRlAwibNHhbB3khjsR8ASU0Ji/ujVYMCgEsk8XFkQcyV6/wUEpqCdYzB9YF1PBqP2b61ZwI1MZRHMyVEB2NDEuG1Fjg/CHdxeYYVmVimzXmmFRipXt6FpTqFl6xHsfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VCs9IKIy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JqSFqMeS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VCs9IKIy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JqSFqMeS"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6094gRQj2707180
	for <acpica-devel@lists.linux.dev>; Fri, 9 Jan 2026 09:02:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HvgWc29jzN/49P/rhW+5yK4jRWn0OB7E4Hh0dtdA5Ik=; b=VCs9IKIyu32kpsAI
	ZeiVo0iZDOppFqssC/Ozh8WGL/AqHT1FywG55nAc7ebhALPJp9boD9FebpsEeqnf
	19Z367Nv/06PSRrWvndZvvmp3wPvN8k9Hsjr2p31TTfcpLPtjzxWLgBklXfGJUvI
	JExUbyqIkjniDZLc/1xVF+o51yZfnTJWqlknLYgB/acFJTMY3EfscQUJX8p6kSvQ
	q1kAgD9v0ETtNPNEBuMpybQjS6AQS5vgzmoSThKHC8HkI0VEv/4czhQU7oxIog4H
	DGhA47D3YJ04urCV4QrEmHs8r2gIyZp0cP5Tz3npEl5j7QrtUP2Xf34b/YkDsSEG
	U4sH3g==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bj9hquy3a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Fri, 09 Jan 2026 09:02:47 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c552bbd1b03so934909a12.0
        for <acpica-devel@lists.linux.dev>; Fri, 09 Jan 2026 01:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767949366; x=1768554166; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvgWc29jzN/49P/rhW+5yK4jRWn0OB7E4Hh0dtdA5Ik=;
        b=JqSFqMeS3Ztd9HDrrkfbkJruoXbaD6ExY8zfZYBNHdnZf6/PlbP81+Go66brd0N3Mq
         8Q686yyFyCSN9MyJRSgnqyLASB4RhmvgTRqhtaFQFfC4kWKV+ZhVYEZoNpgTt37C23Kl
         Cn0CFdc0CBdLZlOayeWLWxbGGy76cRlNhCFEikcAcGLwFNKXLO+hjCjnN2l/FD2NgJ2c
         GUU+Sl6Lm+hPfDyHm1nnSgusL1JAl1HjQq8VubNg+vk11Qf7tbriRp9CdD/qsCdE8wbF
         J1vR0IREdYJExkZuuLdpKJ0WPHgKZVetxsHHzDxUO4aXk8liB11MPQJ2jK7waMvMVCOr
         AIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767949366; x=1768554166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HvgWc29jzN/49P/rhW+5yK4jRWn0OB7E4Hh0dtdA5Ik=;
        b=NFv+PfeT+XyILZeaHXhgKfO9GAUucafZBWZvEpWt0o+6mVyZjsoryDWdr01YaiGeXO
         bGF4wJx6ETIeulqbYBwau6nyMfKGgU/ZTizKWRzT5aJ4m5J8Uslst/kRMGyDKiTway4P
         TYUMJc7pCayYq1DTMnLAtXMGDOGGuMiEXWlcZjkRzbXhaZ/SIO+bSgPzajF/LlbJCrHl
         JUSiqttLQ+A1MAuRoohqVMymadZW166RtGbZvkkeIzOyzmQNBY5nSXjk+DYL1HvhqZeU
         vKb6k8h4mZSROo9cSMhE1FfkGvpC2xEKj2/Ft8JWJZwpj2wT2JK62LGj3tQLi3UKXJ3W
         FhkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTDTdyKa3Q79/pT856l2KAT/P61whjJjQqff+61xYmSPCzmsu8MvgOuj7MDD3V9V6C7dYF7Cqr8uVb2vo=@lists.linux.dev
X-Gm-Message-State: AOJu0YxJ1CMcdXoLhDBYyaA10rdev0gq8RZ/djfVkbQzrOh6sXgEn2I+
	bNtpohpVMnz/T7Oi5OLdaEzvGdx5pe+Z1igOOdaQzX5bHSo/mubE9n8d2nQmIaD3ZGzU7ejUQPq
	cMo9YjesD90ApayDOcZ7gjNotSVviTDEqkXhB3XsR461gGpxR59UoM3RyUypZudjj8lg=
X-Gm-Gg: AY/fxX532lIsf5shZtWDc2nrBlX2KlDvMgIGkqbwNEnISioeLd2JB0u+b9VaSc90AyT
	HZxAlIlRsutXYLf9p0q6MrqFoPspkUUekI1b8fflZXfg5FqERZ1VMgOEo8XktIdYkrJlc/8WH1E
	298MY9j8OwphYuzBabi5HfdV4zChywaYH7JslH5hLsKnBBkCs+0TRpaIWHFcezmCOeJ+gji47Y5
	oYFogtBs5i+R6RyPa3ctXCxSx/TJ16d+eSh5R2QXZCY9/01EDe9ZMzbV1aLeb3dGnpvjCHLQVnn
	U4mQUIk5+W5rOQLDawnbAuwW8qIvAms7sYcKlvDg7lvsnF8Rp6ZR80UowSU/Y4LPaPNpFSDi2lH
	GTjVH7aOJalMgh+GP3u7JEDtIdMLA4aX6hT/LqbtH4v6bJmkOK43DBKw+sYxz6ubSvWURgg8b7d
	qkJY5kPd77esK8JXEjtZtmO6/xhw+mBA9W/w==
X-Received: by 2002:a05:6a00:1d19:b0:7e8:4433:8fa0 with SMTP id d2e1a72fcca58-81b7f8dab26mr8201865b3a.40.1767949366471;
        Fri, 09 Jan 2026 01:02:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKnKdQCBa6kDhoymUf+Gyb4nrZ7PDDZAan9h/ZOlpJJiP8XQhbILGsfxIu865gK5xfMhg2Xg==
X-Received: by 2002:a05:6a00:1d19:b0:7e8:4433:8fa0 with SMTP id d2e1a72fcca58-81b7f8dab26mr8201843b3a.40.1767949366033;
        Fri, 09 Jan 2026 01:02:46 -0800 (PST)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c59e826asm9831562b3a.54.2026.01.09.01.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 01:02:45 -0800 (PST)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com, sunilvl@oss.qualcomm.com,
        anup.patel@oss.qualcomm.com
Cc: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v3 03/10] acpi: Introduce SSE in HEST notification types
Date: Fri,  9 Jan 2026 14:32:17 +0530
Message-ID: <20260109090224.3105465-4-himanshu.chauhan@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=GN8F0+NK c=1 sm=1 tr=0 ts=6960c437 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=h0uksLzaAAAA:8
 a=6zSMeUNXk5_XeOI1LAoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=MSi_79tMYmZZG2gvAgS0:22
X-Proofpoint-GUID: WV-c4U3WBkF3OGhuvZZLvuPAqltk93rW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA2NCBTYWx0ZWRfX396eOXHR35Um
 pld/MDklHFgD/zzSnBP1eIplqeUPU80ixXmiVnis2n0mLnGFOf/TkJZv89sQYl+gQ1pRvhTY0ej
 +80dXJE4Vz7PfdQC8hUA0HJ6HDZb6U6N0C/ovsPyAc+7ReXnTkDeP4RAS+q7TjRGuO0aWvxAzTG
 y8Cjj41+bvb0p8pndDUye5M6w2UAVH61hOLQxDGIetJ36IHg3EFk/9sQE4F6KQcB1QufRCvuO7q
 1mMkL7a4ZspIrqCKXNhzG65b6vcc7Wt/m5Hl4V2AXjIIlk47jY5KxJsGm0/0pa0OMRkY9D0XOgm
 LZH3ozVUvJj6D7J/ysx+r3RBzJssEsoxO/c31RjfltbzhHC/Nw9FEkZNAmd17lJHPicPdBfgwr4
 y6uabQBCEjA/CxP/152J0m51H0Uf/biAlR7xuPy8AfN1a9HA5bq6jTm0aueFGbTFch77EHPgc4N
 Rqp548HvOBAYmqyZMNQ==
X-Proofpoint-ORIG-GUID: WV-c4U3WBkF3OGhuvZZLvuPAqltk93rW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1011 phishscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601090064

Introduce a new HEST notification type for RISC-V SSE events.
The GHES entry's notification structure contains the notification
to be used for a given error source. For error sources delivering
events over SSE, it should contain the new SSE notification type.

Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Reviewed-by: Clément Léger <cleger@rivosinc.com>
---
 include/acpi/actbl1.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 7f35eb0e8458..20b490227398 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1535,7 +1535,8 @@ enum acpi_hest_notify_types {
 	ACPI_HEST_NOTIFY_SEI = 9,	/* ACPI 6.1 */
 	ACPI_HEST_NOTIFY_GSIV = 10,	/* ACPI 6.1 */
 	ACPI_HEST_NOTIFY_SOFTWARE_DELEGATED = 11,	/* ACPI 6.2 */
-	ACPI_HEST_NOTIFY_RESERVED = 12	/* 12 and greater are reserved */
+	ACPI_HEST_NOTIFY_SSE = 12, /* RISCV SSE */
+	ACPI_HEST_NOTIFY_RESERVED = 13	/* 13 and greater are reserved */
 };
 
 /* Values for config_write_enable bitfield above */
-- 
2.43.0

