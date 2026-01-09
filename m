Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4932B28AAEB
	for <acpica-devel@lists.linux.dev>; Fri,  9 Jan 2026 09:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767949363; cv=none; b=iy/NNtq1UtB9quqXcSXHLGjQdSUZb4Ua9EEjDGxWQqACvL9p6ak7xk/4zsdRgVMq1ZVwdAwVhf1sUoWq1YnGIQuCdaj0pGaEJJfAx7gPxEDmvq5ko2j3dkIBBfFNbZNtWfHgSCZQG3cyK1Aq4GqIr3NhhmJ5ipavLHWdRVnrqzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767949363; c=relaxed/simple;
	bh=qUtIRS+qNGJhjFA+Y3AJFh/1zZDEKWdPV6JngSIVVUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lyqI+JjSzFZV68SAaL4kpcWZRcgLzWzmP9W5s+xlxWUeJULFAEvneeDq0ZfqyC6xU0WqoWBHSgqj3mr+R2FMEo9X5k2kfWLZz/wM6v/geSlFBknksa3l6xkwq6dLpkZAk/fASm/BZCbxj6+LC/EXav+1xOZExn1fjwOunyn4/vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=agkzSWv+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FrHkT8JQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="agkzSWv+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FrHkT8JQ"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6091qSDu3324802
	for <acpica-devel@lists.linux.dev>; Fri, 9 Jan 2026 09:02:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ZsTYqbukSC2
	gNcKAlH0Q1txs/g5j4eHRax/TlmVURj0=; b=agkzSWv+DE+oAq68amCweJIWpoJ
	/NiyfB3BYLDFKySSNqiCb62EPqctf7XfQlJWtXnBD4MZZtRbcLz6HsWAJcX67ToQ
	2ONq1FWeJRRjPFt2Cdjm9NNd5WmyOmR9d1eX+3NByk2NsAGILA6plcT63buTOdqa
	8aGZHCmqwdk8nW6qv6+25Q81XUGIcPlB3vgxjAl2SU+geCq/9Z3DT4X0+7oE3J6n
	iB42mfEfTAZWCXKCf1OcmtdZlvFW9Otg6BvH3TFa4q2FfoHehv3D8PEcvHLtyR50
	851YLZushoahf4sWd9jeuJz4kL9vfj87xsefXli4zYhqjAp1e66fasEUJyw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjrd6h4tb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Fri, 09 Jan 2026 09:02:37 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7b90740249dso4750962b3a.0
        for <acpica-devel@lists.linux.dev>; Fri, 09 Jan 2026 01:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767949357; x=1768554157; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZsTYqbukSC2gNcKAlH0Q1txs/g5j4eHRax/TlmVURj0=;
        b=FrHkT8JQRmVtMpTsPM0lGC+sTZUn6sgrTxv8D9Nfho3zd+MX74v7O37lKcrrClMLvL
         aoAt8BcdScO1NhqaM09/fDA3emRhlhABhSDGm8HxsOCFN4ksYW0gK0kAzSUDEPtFy9ab
         /G5i5tFxveEF29aAzKyqTeBexfFKUQa1jjvNgbN0F0RyyxFfMgvbMvC7Z/QGGQwzAKMN
         ZnEDcS62Xl6wBB0wfhSsppD0xjqg7ZUv1an5YTXm68taq0yJukUwnPy2bKbdL/gThk9V
         CzfmgQYXwoDQWceeJgzsDyKvoAMg1jDVxnxG0d8LQY1mcX02MJK0yiP6Zu3ZVUXQzcou
         vkrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767949357; x=1768554157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZsTYqbukSC2gNcKAlH0Q1txs/g5j4eHRax/TlmVURj0=;
        b=lPJVH9jmYanyLQhyfGen7zE2+LLMEYGW1pYwg3nclL71o8/QcgkUJpiws5GnCjedlA
         QWPpQNfGdoSgMwBbOEE+Sv5yXlqLnzRYDf2K6qujhCcGrBmqRM4ILOEvUfxPgxRs7CWJ
         GHpeQbJT8Phrpg90eLiUWWDTGv6b2OqCXZthZSZWSNFBnFAFarHIaGF2OOyWmGm0NHnY
         LoA2gjM2bi7xyzIxLcttBNK1P+2MB94z8yP7xEM7H9GVbKvgttDMZYBmudBuxjY7USOU
         86jiyUxeru1/XAd+qDr22ds0Hqmi4M4ILDC5WPsuajIzGSbZwwhXO1iivNJmKkx8B3IW
         dr6A==
X-Forwarded-Encrypted: i=1; AJvYcCWGxD9qTBs/JYrnDZwcQGuFbyUqtPqZtGW7U1zl9q1KpGCUU1LCdi0oLqrpn/fOnKbzAjB7v/bInZZeFjc=@lists.linux.dev
X-Gm-Message-State: AOJu0YzxwbqUJYWJRo6avEK/GJbf+nMKAFmi1qCCu1dcNCkOeGnHIynK
	ra4yJUX7DlhKYRkaQ9A4C0jVMxUuqPQuV3KXC7sCqinZTBTgaUF8y7ApeZU4TbdOYZM1u2RqsG/
	MLcECHL+wOxC5B6VZUdPHgetYXCvgWEWDEylZ801lFgyswTWMZYNAB7Tj4slcPuobAlo=
X-Gm-Gg: AY/fxX58gQm/TXx/apygnUSjoV2YOLnWzEoIHbxhD6zk+cTXF/Be5lVk96ZN4nIhHnJ
	w918ggQlrdQXzUot4WXZ7ubsJGlL9IsN/xTlKlWjrQE7CPpIWqobsuGBO1R2TeqcZEgT0nEWYq1
	JUp1tK8XX/Fxq/kQOl0cPPM6hHmTo+ZDN79VXtl5D+x8IvwmA/8r9vDePD5dBioOeaUUypMS8T3
	K9XOaCIJ8Zr7v4yV2JEAUCe6wZ0GkjAKMy/wQ43+7v+HAu4/ozCCbHJGF2epLDVgDtI/HLr2ZNb
	jkUt3iL+as4p8KiecgdlELlQsynMYIwJ8CIY88ix4C+d/GrxeLaRl7MWu4w20pCPTx7JIz7nGbF
	KJjfPzpUx9wH5tpIEQ/Bw0ohdN/0ZZH2O1xDb8C+CeQNpv3I39SxUpnB6SMwCSqNwjQpOLnfrE6
	B6LpscItBeEHPk0l/WVW9PoXFewn+FmFMPUA==
X-Received: by 2002:a05:6a00:4388:b0:81d:a1b1:7319 with SMTP id d2e1a72fcca58-81da1c0ba5fmr3618458b3a.8.1767949357318;
        Fri, 09 Jan 2026 01:02:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOyqXvuG3s1YsXIvbbegM8dNOFmUKr/zAttl62kuwT5+fBNngo2bTFR2q6zm58OKrXld9U8g==
X-Received: by 2002:a05:6a00:4388:b0:81d:a1b1:7319 with SMTP id d2e1a72fcca58-81da1c0ba5fmr3618430b3a.8.1767949356857;
        Fri, 09 Jan 2026 01:02:36 -0800 (PST)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c59e826asm9831562b3a.54.2026.01.09.01.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 01:02:36 -0800 (PST)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com, sunilvl@oss.qualcomm.com,
        anup.patel@oss.qualcomm.com
Cc: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v3 01/10] riscv: Define ioremap_cache for RISC-V
Date: Fri,  9 Jan 2026 14:32:15 +0530
Message-ID: <20260109090224.3105465-2-himanshu.chauhan@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA2NCBTYWx0ZWRfXzDsCW+qEn2jh
 F8OdmDSvLRetJ1zwEzE6PNf16VOCbWn8fN+JkdTx+RJCw4JHLqevTAUMSLfWfsWhqc1fQz2WRNQ
 uFgFhsTmbRgzfucUYxSuD+A9pRRq+I5JDadQ1hqgRclqbPgjPTEajsO4LO7sz5u5V+84Qp9c109
 xWury+CoqCRvSr+Qnwx+sUcBnp51gxrAMDvtVql6lsYlqACWEIBHIy4pMrwrefOchsoU0GwH3NE
 +Sb711Slikp5dLoE2AK1KP/aVUR4bOb9eg4IDM//ThPHUURGfV6CWqf+l4yFOtsbIb64zHFt/uf
 OUUgUKkZHWmUCCLpWjqeLjv58NOHb67bKNC778yLjUOj8GchQFzFSQQR/ORgdawwi0vdmoeVtFQ
 wdeDLXtIdik9bg8Lsg4XmusIQtHwxZgEi0sN5suLIC5v4dfdtCCOf9LegUSkGjnQ6w1AufV3OWd
 5MAoQuYlJwrvT7BRGAA==
X-Proofpoint-GUID: Iw1X0XOwlTTv1V1OOYYVmB0btDs3z67A
X-Proofpoint-ORIG-GUID: Iw1X0XOwlTTv1V1OOYYVmB0btDs3z67A
X-Authority-Analysis: v=2.4 cv=Xtf3+FF9 c=1 sm=1 tr=0 ts=6960c42d cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=JWN5yfGi9shfayy-Z8YA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 malwarescore=0 adultscore=0 clxscore=1011 suspectscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601090064

bert and einj drivers use ioremap_cache for mapping entries
but ioremap_cache is not defined for RISC-V.

Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
---
 arch/riscv/include/asm/io.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
index 09bb5f57a9d3..5550b28f38db 100644
--- a/arch/riscv/include/asm/io.h
+++ b/arch/riscv/include/asm/io.h
@@ -142,6 +142,9 @@ __io_writes_outs(outs, u64, q, __io_pbr(), __io_paw())
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

