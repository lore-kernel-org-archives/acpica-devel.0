Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8193DD533
	for <acpica-devel@lists.linux.dev>; Wed, 13 May 2026 08:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778661835; cv=none; b=E340SFOpf0FiBNhnHe1giWsGZyf/VjW4yKY0KtpzwIINZhVuAGcves6xMck+1z+4QM9P1VK9Kd1hpTvrqbGjggm/a7fjqnZL7q65nZxga7mgUuKf0Wd4qG3ygFZFjmFNKATGp3IhoJrMy0zlQtsgudKK+3E2WWqvQIQdm0Obsq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778661835; c=relaxed/simple;
	bh=qUtIRS+qNGJhjFA+Y3AJFh/1zZDEKWdPV6JngSIVVUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gzTuAPUaDUSQNfeatgSGnUUsC0Lrbk5vFcf6WOSd86amYbODs3pYUzpEq4I/m6DvcCAMIxF1g3eleSokg9PmzXfFo6NDZZlftQ8K7lmpt34ce+W9xMnxi5Rwc19Jwl4D0uZfqI9D+p2CuTRMT322Gsw13fDD773YONGFcSLpj1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PVY2NhZl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c+JP2lBZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PVY2NhZl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c+JP2lBZ"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D4pG802331553
	for <acpica-devel@lists.linux.dev>; Wed, 13 May 2026 08:43:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ZsTYqbukSC2
	gNcKAlH0Q1txs/g5j4eHRax/TlmVURj0=; b=PVY2NhZlOkpU5eEQdbYJr4v0WnJ
	eIU3l3b4LkvTNgWgMVIRW+4hg75jgGW1/4vqAk3rZLMDnlAfjuVhNMG++U0GU/4w
	dIw5jlcVN8NbIRjnDnPEVgiAxxAgB0X4GMija/rkWozakzeCKgKLz8094lHyoppB
	tPGFgr/Svl2T8KfPmH1IGfY/NadkGKKRYTjQr+r0+t9msxR2o2HC4mAGgRcM1KUU
	sUCSppWNRf6WvBkvadAB2qDj3DVGpzCg+37USjAa1AqiE6j9ZzAcOCefL4qX7uKw
	+mPdyJKnp7PcIjK5agkIWNClHGkkugHJBUeZSQL4YSuQ1TD5qOCCgx6KAKA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e43ypc8ed-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Wed, 13 May 2026 08:43:51 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b2e8bba2e6so85368745ad.1
        for <acpica-devel@lists.linux.dev>; Wed, 13 May 2026 01:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778661830; x=1779266630; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZsTYqbukSC2gNcKAlH0Q1txs/g5j4eHRax/TlmVURj0=;
        b=c+JP2lBZNldHHEHFmj995zcVXjXyyDFF9dvbjUJ1uYuMfdQHw13aATeLZ8nvru0Uit
         Y7DX5z53SzDkb23a3BO7DejXmdv7VjRPT/+x03su2kurfIMXWEFfYy+2/nQ/rtfh/ql2
         1E6SyzdAUzHDN4AHIn4Wq47dU4DGs/qSYuH+iIjuLjG77/gSYCIs/OtX5IdYAXAxESvc
         IXcFIVFPoBedFIcTuM633I+3xuWxzrW07+zu5TvfQ6mNtmtBXTtx/nCrr/9MPrYOzdNc
         56DIIuh5H54hBaXIyJdjziv/144EV6C44RI48DVsk8djM9pAd+4ODWAF2+d1qGiem1ud
         mlUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778661830; x=1779266630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZsTYqbukSC2gNcKAlH0Q1txs/g5j4eHRax/TlmVURj0=;
        b=pA4W7d2pkghlVB9nspP7RuEQ9cXxFn0aC1Zx4N2ZPbyTqAv6Qwugj4bLAH6BdMCUle
         UVHwM1R4G9cjEx+3P7vQi4DSx0FPs1AHb/Dct3287KPS6ANqzqERYrRRXmLjkJOJLHCM
         SDb4qO/O2mnJKu9XVauDfw1zoJZ5hT0XGXEa2vQHIQ6eThTJ66iYVV+Kfphr2Ce2mIEV
         8H087XoksgLiogABcQkG6CI1137WvlM1pQ1kiSNpCaF9SUagD1vMa3QL3xHphJoYJhrb
         dIm6V365/v+HGAxsF3W6dGvNH32dzBrxKmCbOqQrvbDy6iA9U9+E6JbTNuMO7YjuuAVG
         TBqQ==
X-Forwarded-Encrypted: i=1; AFNElJ+nFsWw091Og4hqUNRwcd3oNQ5DcVeG9VevV0394shWM6mXWU+ax4UFsNirThJXABnLPKOKeirK8Uluy4g=@lists.linux.dev
X-Gm-Message-State: AOJu0YxV88k9OIVwiFr4eqmdUTT5QoauDQkHkhKdd2k267gPNUY9lxcD
	Dey8GqdgkoMx/QjwkONExJIARbhFcgeqlbaWXsrzUqQnRo/z39xF1FFvrqgovvN1m+ALgPnX/EY
	a8ojPFihtJtXsHwIhp+vo3192tqA5phLjNRxgKuQ1FA7l9EvWhaUdNLgyRDmt5n41YAE=
X-Gm-Gg: Acq92OGOfpOsnO8gxTr5QInGuen3+5d0xmytrtVvqlqZeA10w3es9ASYJh5PbWDN8Am
	RgC/LJnmfLbJwfUqFB1NSI+31520evUsXnRQJxt+7lmQIxEXwvWRf4qKGauAysJREr/dn1R8yIS
	PJbclomzNZrM6+wa1etjtYBVaUXQaJrBlgQqG15/Qcr9JZIlf1OvAYsFDPuXKuPVFgN/L1h77ce
	RPNSgYq1ottybNirsv5ZK6EycrohoBEYvXm0DoLcHy2DNKJUlYA05T2wF+YoCH16g7P/SYWP9NN
	giKArWpvqjMFaKb8gJijt9dnEfogP+yuDgvp+idxHV8VeMRA16siV8t8GPps+Kx8Sys7iGw/8S6
	caNneCk+3QrJZzkr5Sht5oMiT6dgPxSUUT6Bh07cRYEDU2eatwnfRlq2z75bAxfHW4/lUOK+Ee5
	jabqS6IpJwoaCbTiMOZ3otLD0dPzq2NrgKsjEP62YOSrn6XA==
X-Received: by 2002:a17:903:31d5:b0:2b4:5cea:f61c with SMTP id d9443c01a7336-2bd2718bf40mr20937025ad.4.1778661829995;
        Wed, 13 May 2026 01:43:49 -0700 (PDT)
X-Received: by 2002:a17:903:31d5:b0:2b4:5cea:f61c with SMTP id d9443c01a7336-2bd2718bf40mr20936745ad.4.1778661829451;
        Wed, 13 May 2026 01:43:49 -0700 (PDT)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d2709bsm169158725ad.5.2026.05.13.01.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 01:43:49 -0700 (PDT)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com, sunilvl@oss.qualcomm.com,
        anup.patel@oss.qualcomm.com
Cc: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v4 01/10] riscv: Define ioremap_cache for RISC-V
Date: Wed, 13 May 2026 14:13:16 +0530
Message-ID: <20260513084325.2176952-2-himanshu.chauhan@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: AuEaI2DBuE5M9aLtCvOjHQCi4UWcUfEt
X-Authority-Analysis: v=2.4 cv=R5kz39RX c=1 sm=1 tr=0 ts=6a0439c7 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=JWN5yfGi9shfayy-Z8YA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA4OSBTYWx0ZWRfX6w9W+NB8WESH
 Ii17bP7vKzKLMQ8b5xcgU+M+nG84lFt19XylrC8YyuI79YX6AHy+AOWFAyRwS1U48vVqvpkssGz
 BTHT1dkHcGJ07YEu0EjbvpkeI/WiRkBLFNw8kSCbeRvSifm/cYMA7ChstZLhNHz6LcxM8IeLpYG
 4R5k0I7+CRxkZoZp5x79E/rPz/rQENQ0zB6ULXwLoKkNyZGTjSlTERWJEUx+0WJWK00LObRQ2W3
 YZF8N8jAx+hbJ2ClPSU+MKNMX+SJ6p4lZFBfbL8/GcBpI28hp2H9w6jjXPX3ddjhyLxVI599P4I
 u++7IyIZ/SRt38c1HVYs7BTckA5rDVwiUL+Ku74wFPaH2CZSkbOBXRBp9kRFWWxe0Qj4Ll739P+
 XXh2HmuIDNh2QCsefYxlanGHC1WxRI1uDf41p9jq7K2AK+7XcsEbwZfYlZCRu6o5oPaY4TT66OF
 sjfsssKE/nrYFmlgHJA==
X-Proofpoint-GUID: AuEaI2DBuE5M9aLtCvOjHQCi4UWcUfEt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130089

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

