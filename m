Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67F338B7DC
	for <acpica-devel@lists.linux.dev>; Wed, 13 May 2026 08:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778661881; cv=none; b=F+yXOJ4Elssxl21/Emz/EoocCfZdf2TMVLYs5onxxJ2W8nkSj+RMVaYkR5jnSIPMTP/JHeRLCtiYHDExzKndw7w8IdGyJyPtCAGbiUDpaBykQKMlkOvrAxX4muwT2fdKZ2SSntT73NOZljHB0VuGX2jyDMGN6Bn5fNClw5vOCnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778661881; c=relaxed/simple;
	bh=x20EfRadjM6gyYzz8ZMp33hiN2k9tRrW3Dio918LssE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aigz/GtKBsIR/22Hu2jG6Vlg3DfenjEyMsILbmetLcCG2lYXygfUaAeejg/imoLTyLKo4sixgQBOwNPiZ28PINuQxfuvjWEsAPLblAakpvFwDSHPuJyuy5txdNybyD9JV623tTo6J+X9FvKr7vFFVdOJCPTsPPVhT4TRDn4Rc4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iVz425xm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TScmMph/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iVz425xm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TScmMph/"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D4pP3M3595422
	for <acpica-devel@lists.linux.dev>; Wed, 13 May 2026 08:44:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=zmAbegcUREx
	UMu9LBa5XbR8BKHL2qZB12gzd9RXImJ0=; b=iVz425xm8NrnarAFsAX5H+HUYOk
	UupNDRM0cum8UeBq+sX4nbv6ktka9JpEftA+rUacYqi1jirP8l1ku/xlW47Z/SmQ
	gBg6/yreQLGjB/YhRmi3TDQ9+BDohxcLaw7Lp4WHKRPiS8gAYSyB2DfEWcbXXNzX
	ZGoxnZZVb240KftcGC9Za+JzSgFh+2tAY7ZlTs9Bu199r/EX7K3yGQfQEt/zNmaH
	f7FKO8Qeisg4eu5QEIoUHSaDwHHgxaq2dhKFA24DAqnIQQBq5FbGmh8umsTneYvu
	cN0DiryRjmRxMnumLqySOn021o/3lSjwwH60BeVLTnsEmOIIdJm67l57apQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e463dkkw3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Wed, 13 May 2026 08:44:39 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ba6ca20ceeso72138455ad.2
        for <acpica-devel@lists.linux.dev>; Wed, 13 May 2026 01:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778661878; x=1779266678; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmAbegcURExUMu9LBa5XbR8BKHL2qZB12gzd9RXImJ0=;
        b=TScmMph/Bv5pjB4qbcGqcDPLVNQhWZM0buUbbMSkBY8CTY4FLEs6RDEOEKxY3Jqkp2
         zDtCzBcFnn9xNYFQwSyvKyuhn6b/oid15cG8SPx7y4jO0nKwdF1LEMOk6IP47/Op/3Ft
         ibUOpXziA9rQY0uO5KzIAnw08AjeGxky/DAPKG4umdI8BpCxDijj6069WB9FxnicT1Wo
         zkOYB0w88g/ZY6Ba7+/DblnIWyIaDslGZwOgKh+/Kik1CFh9j19ReISSapqmpbLAlWue
         vNeftFGbq9JZcAN5uY4ErT3kJhwl5sI3Nxr5ctbVk+NFXyStRiybr5N0JWf7udEw8gh/
         ZUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778661878; x=1779266678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zmAbegcURExUMu9LBa5XbR8BKHL2qZB12gzd9RXImJ0=;
        b=UY7voM3+Or71f4vljfiAqzujrKc44wIg8v1tzl/lPoP8/uJWbsAMA2baIKJZi0pEVj
         0GDDJzqNZ/NmmysZUrQ1wIVYQigJas1BP05fWZorKNqQJVVbLGWePKhB0OE5bwy8pbVd
         twIA1QWrLRGeOxy4n8G8wdtTrocWWGIe7TQjNF5MLMM/o+T0GqmbL0Zw1UC8IvqLsR32
         kVqPBWOJ1ijy4LUno5S3b/sbmpld68sCP2LO6+y/JbgakuJw2OASw+tp6mi/0PI4NpBh
         8irZlT5/B/BrUU9qWHRWwTODQ4Qw4qekhVdwoWSWS2jF7GmxcTsbH82j1enesePuHsNy
         scKA==
X-Forwarded-Encrypted: i=1; AFNElJ9mLCXjy8T8AmHLTTPlKvo8G3oVg7VPqNoGP7s4a/8s11S0AKtz/bBg5qjA0DJBnkljUzZLs5H6lgBgfXk=@lists.linux.dev
X-Gm-Message-State: AOJu0YwFcOtMVnForCDd7WqQ3tJ1he13e5+XpWUWDaOnVRX+7YG7B682
	2/A9Jnjh8sl0uFxMV7FcNp/Yv2ekApyXwd7wnDaJgmSE+oAUaMiZSBT/XLFaKiIU7UayzggaQQd
	TDK4EQBhKUqw24lJxg6M4SRBdJavI9D39w0aE+2VGcst8QnDYar3gRYRY3FuAEve+Aog=
X-Gm-Gg: Acq92OHY4P0Xk4jr9xgqRlZykpRzpdgBdJmub7pjGJcHXE40osq4scpkIKlFbpt2HgV
	XjwOboh0jTCrTCqpSmhN51OT4Bop808GoLUCd6dQqa1nxdOabQlkHEMNxC8bphcjzyzxmkeFcps
	wtrMrqFdDwcX5Om1Tz0G9j4R30hajm6NZiUTLXFnr8UbZY3KC0g1OGmuQiNfnLCrJmXLiUT9O8M
	ffP/lSy7c/fVRfCBczhtp54DX5r5/5DF0Up1X2hAD5IPWUNe9sn8Naa/7JdC7N8Od1iLvCGNBWk
	qaf8m5w2jqsmaw4w2cjXGwef5UmSwjcNvEEgDNHwlcOlE1pAB5G261YSa/eLe24MN5OoI4zOkfp
	Y8HGu/A9QH2l26jfeGVH5IhFfg95SkNvmDk59SSo3VyS8+wdbOUbeVjpbsPXh0izJBDw5u4nG2p
	S2Zz22sxYnFr+iVztvgq6Zh5XygtzG/vr4T4mzJHunQCfJ6g==
X-Received: by 2002:a17:903:907:b0:2b0:5ae9:ee4 with SMTP id d9443c01a7336-2bd2713c355mr27371355ad.5.1778661878564;
        Wed, 13 May 2026 01:44:38 -0700 (PDT)
X-Received: by 2002:a17:903:907:b0:2b0:5ae9:ee4 with SMTP id d9443c01a7336-2bd2713c355mr27371015ad.5.1778661877861;
        Wed, 13 May 2026 01:44:37 -0700 (PDT)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d2709bsm169158725ad.5.2026.05.13.01.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 01:44:37 -0700 (PDT)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com, sunilvl@oss.qualcomm.com,
        anup.patel@oss.qualcomm.com
Cc: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v4 10/10] riscv: Enable APEI GHES driver in defconfig
Date: Wed, 13 May 2026 14:13:25 +0530
Message-ID: <20260513084325.2176952-11-himanshu.chauhan@oss.qualcomm.com>
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
X-Proofpoint-GUID: EeqTSB6TCRnl5J_WhaZgE8Y8T6kgV5KE
X-Proofpoint-ORIG-GUID: EeqTSB6TCRnl5J_WhaZgE8Y8T6kgV5KE
X-Authority-Analysis: v=2.4 cv=aLTAb79m c=1 sm=1 tr=0 ts=6a0439f7 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=xUlk1AThICIXWUt23vsA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA4OSBTYWx0ZWRfXx87DukIvmWPB
 KxnamoOCVBmI8zjlz9VLGuKfenN5AAaQXR7PGnEmIxdUINSC020cId0wuV183DgxANqP0d4D60E
 7P9vduiEb9+MrnnPSnXBlB8F4v+NhMHGZG/rTKt8eY2FAGZzEElIz2Ul+s2trMU6Rs2yfPg//Si
 w8HgouOfaml00jS9hh4MUZcVBdF0BY7qc4TvNskFLkEqGPYZCHlSGhVTZBOuC7TYosCvjMbJfYQ
 QLyLOiw3M7M6g+0q9KotklkuIp9oWsp3/mpBH5mQ5O/NM9DwW0dZEYz05mdtw8T3YoE1TclxyKi
 Ln3A21hfOrQ9dkzeks+AhkID8RRCb7JWAo3V43wJFOkpyufXZvBdAgmBXpLekoxxLPYGTfgTEOY
 so7B/ToZx6xUzY7+vNGLwjRDbDvcZFTrI7QNoMqrmgIp6vV9eNfMaE4zUOxUybyI+J752cTFw2V
 9/t73Svyw9+ndhiv7vw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130089

The APEI GHES driver is very important for error handling on ACPI
based platforms so enable it in defconfig.

Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
---
 arch/riscv/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index c2c37327b987..eb0c45405cd4 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -46,6 +46,9 @@ CONFIG_ACPI_CPPC_CPUFREQ=m
 CONFIG_VIRTUALIZATION=y
 CONFIG_KVM=m
 CONFIG_ACPI=y
+CONFIG_ACPI_APEI=y
+CONFIG_ACPI_APEI_GHES=y
+CONFIG_ACPI_APEI_ERST_DEBUG=y
 CONFIG_JUMP_LABEL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-- 
2.43.0

