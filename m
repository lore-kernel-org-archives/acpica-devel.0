Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F12D3E4C81
	for <acpica-devel@lists.linux.dev>; Wed, 13 May 2026 08:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778661877; cv=none; b=mhcJ1sY4wemgu791U+1Oeumty3eU/OOzty+pBMJs1x3cwurAfu0qSK6rKDdtvoO8Wix3F2yO+TJTVPi6BgiwhhA55gBglx4A821PY8FV4foSuqDeRHM1OU8L/t7BlMA3eA1T0w8nUChTuOGJJN7chg7tTy2RRjrQnEADchEWWbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778661877; c=relaxed/simple;
	bh=Z9H2IrGiWap4bBYZmAUQVqDaXWdawcf9g8slb/LeoRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UCmMOG3/3sIatd55vGmwEiF/pYFQ2HHMzuc08yNr/yIyxti+9fSPLukUq6M1R2Da8CZGG7ZRFVw8AzcaVmYVgnLvVV18rB1YM6x9uWg6n5dNRNZJPWfDXpmwFChikY1jVRS9MrQk3h4LPOavqLGWQZyCpx6gJwbgGYGnppmmqH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UmLLDQ0e; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FS3qOSH/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UmLLDQ0e";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FS3qOSH/"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D4p9aw3527643
	for <acpica-devel@lists.linux.dev>; Wed, 13 May 2026 08:44:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=BpdgYqVS356
	+a0fEP+B5YTQRF4fTcXzt0S0SRfD6Nlc=; b=UmLLDQ0eXSzNMvpwnLG5/XnOyZN
	3Y8BRA1m+a4WyZcjb9sgMyCKUQ+NPMzjS84X2m6RKMGTWNoehW5uJYRVawYCpZuV
	Tbnomd29MYOIGQHX0OQgiB9yJWSKfVgJu06ejrnP+U5bmKH+GWLPkJb1yrAkWDsY
	oJbWG5cENFhsctGn8qCpK23+br2yfOw31dTRp9Hrc8vg17He39SpmTyuFgD3iZhh
	wjxDYdpLW0HsnJc6xnTcfF4hsU5vzG8v0szRlR1Dam/7j6LrjXQ9oBRKxHm6RpgI
	4QeY50BLqf8/+vSQQM7jgNWPN3QX25XADJ3vP0T6WrYl5kx7TePxCt0A9uQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e44f340rc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Wed, 13 May 2026 08:44:33 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2babbeff9e4so77896415ad.0
        for <acpica-devel@lists.linux.dev>; Wed, 13 May 2026 01:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778661873; x=1779266673; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BpdgYqVS356+a0fEP+B5YTQRF4fTcXzt0S0SRfD6Nlc=;
        b=FS3qOSH/F50+ox3opNW0d7EqALhwjRRf6hL96CEi2r3ksKSGAqP0darCxFA/pf2P1f
         Zh4iaSD1nQbCt63dUh9P4+5t0ewe5i4xPyzMzzpgSA9zt2X/AvR0ZcT8mvxD3rWFsQs8
         kXk7QIXioA6+hdFtFL6lP0OItZg8WUG9orABgc5mbKzFjcZEE62LAaUq25usyfnb/F+U
         xGBgrpqGOPonHIor0vdL2tvjpgYXEQU/2y67cS2cHpQq/sT3eWqTGjykqCvTIzoyY2a4
         Kiztwg/ZpxxNzmDkRG+q2pnZ7JL40+bcpVVZEwnQhWn3Lb6GdU6J+ojEAD8nKZTPrabT
         eB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778661873; x=1779266673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BpdgYqVS356+a0fEP+B5YTQRF4fTcXzt0S0SRfD6Nlc=;
        b=UtIMR4QpqETy3VR2HBVm5aNN6XPa+GNcGZOfGwGOa0TVmLEAUtEi55E7AmINMoHUB4
         UFve6LFQJa0yXscuCrv5ypR7YlBN7aax+W1CaowDGhoqngvCUgDIzWUnAcpK1PgPy0rY
         AYSxDOylIFKp5ltDtWX2NloQW5c7Fo4NpE4WrwURq1rVuoTnNXVL5MnzoXYVusSCBpz+
         ay/SQl4+hhg9lsVFT5hyTZZIECjXNXGvhwRY0+f3T2MTeP4bBtBL8miaInHBDrRvknrS
         Y4BgKGNM55pWwIuwVdmANa6b2QAgcYEoNW7eKW7lbe4JXMYKg4mxM1NhMsG4tA0JcqVp
         lyqg==
X-Forwarded-Encrypted: i=1; AFNElJ+z5YyOjR6b7DJBB4HfmsKhzOgl+En2hjRpiXzVjq8olI46qNzZqAEyFh1Kxdg3X5w4stzSNOW6zLyWgBw=@lists.linux.dev
X-Gm-Message-State: AOJu0YxdVZKK2slkkM6+4/epvOH/Bhew7ZgyTIOy1wBH+y/hFwuiqjEv
	XX79giBR6mTAJrkx2tpGRIGRKumCiyT7PLv+EpZgfbjepXUA3lNmpNXe8EtFjk0op6hBgep0JGY
	tVjMpHSHsg7M5ustKI8X4xvEaWdoDTi90tp/boGRDtNE7p7OniBc3vWpne01EO7vZvFI=
X-Gm-Gg: Acq92OHOFAhKciz+IJtWCta3dMTIgwjcR0k+A1voQe+4an00l1s7/YoHFxOat/tsSup
	zmK3psnAghXnLvboD7Sqx/UuJFcXnmYabTXdPIlVQZj5rd7L4XONQUuNnmjCPb0aNMiDq1c8vGU
	Sr3MKeYCSSrGOWoTlnG9GU1/aiuMvr2KvPbihW0K2sp236HkLbzEErZkd2DxmrpcB83eRl0lNst
	roktL9Lq/L+8XOAHkSjp1xH2NyqWa9E4RNEgznnQU0JZY66RcLCKCH9eSLJJyO9R9F9F88TxM9E
	4m+ubQZmtywKezVvKlD5vGv7qhY8L8JrPVCrvNWYHoVi5yMHOB694b8aQqNpp6IDUJrbSl5yBxy
	sTJabjL1IXogMbowM7mapIoYWRb+QpdustWMG+e55XDObeKPhnc7iqfFUmBcDkAXTbfHAMKlVVA
	q4kFoRBWh+SlW2u+IX5JtolydPk1iQZtQ/PYWkiR/+ucd6IA==
X-Received: by 2002:a17:902:aa8e:b0:2b2:4bbc:14b0 with SMTP id d9443c01a7336-2bcfd48a8bdmr42628655ad.20.1778661873030;
        Wed, 13 May 2026 01:44:33 -0700 (PDT)
X-Received: by 2002:a17:902:aa8e:b0:2b2:4bbc:14b0 with SMTP id d9443c01a7336-2bcfd48a8bdmr42628535ad.20.1778661872580;
        Wed, 13 May 2026 01:44:32 -0700 (PDT)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d2709bsm169158725ad.5.2026.05.13.01.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 01:44:32 -0700 (PDT)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com, sunilvl@oss.qualcomm.com,
        anup.patel@oss.qualcomm.com
Cc: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v4 09/10] riscv: Select HAVE_ACPI_APEI required for RAS
Date: Wed, 13 May 2026 14:13:24 +0530
Message-ID: <20260513084325.2176952-10-himanshu.chauhan@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: Ali_fbTTSFNl16gc2r3Ys0_riEIdm0zY
X-Authority-Analysis: v=2.4 cv=SpSgLvO0 c=1 sm=1 tr=0 ts=6a0439f1 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=cq_Hu0Mfxj2oTTqF29wA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA4OSBTYWx0ZWRfX4DvvRpkFHESW
 dfAM5zmDL2fTm4eBy60A0W5K7mcqQj4OyILwWs0QrpkS3ygy7dA/Gy+aIRm9sOmabo+kfzqpE9G
 Vj8KRdZ6oBgHcHi6chIDCv6HixZW1y0BfSvs8Tunjn5xBin7uJad/q4jeOx09SquqdeSpnG/6nf
 bdZaKIS6ZRdc5+BAWdvGTS4PfEaP8Abn55SjQ1gfCuNIaBvs1Y7G0dwDpDYNYDFyzdRoKdSxb7K
 uLQf0UECnUJT50qlBBiznt+PRsgVTsb5KPkR39RfA5/bH5MJyg4bWXTfF2k8yuu9rVe70Bsr/er
 j3FQz2OzyzCD9m8P+q9vYSuVC5zgTBikSsOYM/s29aXTA+9Tcek8nPLTecqkDSlQ/z99dVjWMpO
 y+Ku/usEEvqy9PUd2b4PA5P20I61sVKogUAGRpPXzsXn3fEVyzFPqcdpTXnhhqbpflVwQblvgwc
 8BLWsNTB90dqUwk+nJQ==
X-Proofpoint-GUID: Ali_fbTTSFNl16gc2r3Ys0_riEIdm0zY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130089

Select the HAVE_ACPI_APEI option so that APEI GHES config options
are visible.

Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d235396c4514..b94b19fb4249 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -187,6 +187,7 @@ config RISCV
 	select HAVE_MOVE_PUD
 	select HAVE_PAGE_SIZE_4KB
 	select HAVE_PCI
+	select HAVE_ACPI_APEI if ACPI
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
-- 
2.43.0

