Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB033D7D60
	for <acpica-devel@lists.linux.dev>; Wed, 13 May 2026 08:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778661841; cv=none; b=tzPT9xWvTCDcN6sY47a3NUemMo8AtfdZnWgEEJq8k7nZiVV3IDJz6bqfpUOCjwcojtek6QVfrlI/nRCHFaFGW2GEgACwHgLvKnwaqsMTkMQvrA0bXkx+p3sviYyQQaXbMaER0FpHsbRzmwz0BlNuu3k0yuiZAZoTcYd2kGfarMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778661841; c=relaxed/simple;
	bh=Z4ltDVtB39Gu5KX9iCO88y5JLOWBAk8es078Y80/iFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YmYDeZaB8/Q/cj/gu7kP+rjmwP3Jv3yCdsFCf1rCcVky6lv6S9tDj7ooyV3RuaWzIPU1MXf0IJoLlma5udBGTOLAUXJrudQ99kQ0W6NNLtkEiDCXX86C8h7/PO37+6xuI1nXTpZj7r+GBllKhwMD5KjLDgB5WdO+k1Pui31QM0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=khGZ0Nny; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UX1BcjD3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="khGZ0Nny";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UX1BcjD3"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D4p7wK2932908
	for <acpica-devel@lists.linux.dev>; Wed, 13 May 2026 08:43:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ZktuxFKbZoJ
	xn+4CgM4kaOVJh9P4Xaw+uozUmzXsWPk=; b=khGZ0Nnyp4YYx9eMqzTrHGOSLJt
	yp6TarjLJRwnDAd9pOEmLPPBDiwreDO3XEuzRiFgosLbCmKgyMCPghK9Z8N3btH6
	od4Z5l+o9xne+x0N2Hmkr7gr/SwsBBdDmjZBE+KzkJH5mZqTqME0qMMmm45yXG3N
	iYbAlGvE//QJRO9HXDkbTcDuPQ0jI8nYobZncMMMh1OTd1pN4ZJFPlsXYTYJl3SI
	Sh3mPtZYU2u6Utf1cyxRbZl72JbjXV5h7IpUGZA5neNsZN10uN58bsTW3kgzs/yG
	LFYsJrwcCOhF/VzgOdVfGmHgu25JW7pXF6uxxNnmHO6wPxj+o1PAm0X4G8g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4319vje8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Wed, 13 May 2026 08:43:56 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2baedd2fd43so40206015ad.1
        for <acpica-devel@lists.linux.dev>; Wed, 13 May 2026 01:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778661835; x=1779266635; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZktuxFKbZoJxn+4CgM4kaOVJh9P4Xaw+uozUmzXsWPk=;
        b=UX1BcjD3Kl9yf/hibac1P0i/H3CU1DYbUmnEhOnAcAx5rUC5grSdVOLuxRJI3UIWSQ
         eAHFNqOCFptNQArbOxnrZQg6WcYjgqcy1L6IsMdCHrBVnECET1blnkfrcvCPIypRgvr/
         QgJFmut0vR3Si9n6sUDkosEbPvsyqr7A1ViUi6HiYMFYbx3dat0sr1SEp3xCvkI3jVH+
         hC2AgPMAW2cmqDaDb+SvyAbKoYrcPI7dPzijJPpVijkgonGC41lrvinsqWTQfn/QP2xO
         RKEFcPsuQrGDR+8mUrTZT1Qk36qzVT5685XIKNDQr8N70JD+g4f3yvYW2kluJY/wJbln
         JehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778661835; x=1779266635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZktuxFKbZoJxn+4CgM4kaOVJh9P4Xaw+uozUmzXsWPk=;
        b=Iez3d0X8YNAkhlrmS9VGlsRresSMN8PQpCxH9QftibVIRastM4kudav/dcJg9G6dDb
         5FxwJ1B43kWNiQlDoa+dxZBe+YUZtJo4eZqDMBhotn57pFLMPWvrY6aXTPYY9y2erAjE
         kB18KwZjR6UbGVSH022QBVCYj6C51ci747zPdMB6hn6rGPp3SV7euaLYHlshX70Ap5Xg
         l/lb+lUISmOz2Bo6u0HU3WYyp5CBA3Mu0EyNJPuADExZC4Iq1NFw4FT0fuJu/MjFhCq9
         0gBFDo0wQGjTG5fd+M2PoLKjL+xNGOE+617Lnhrus0Cg60S4D7a+QQ64xXCuCwUbqPxV
         y2Zw==
X-Forwarded-Encrypted: i=1; AFNElJ+a4paanUPnaMVvXPZXy6ZbDmDSeGzyMUMMEoYt/C4lcFB0aPh/qMr0BTlg2HZdRsf21YhQcwqrmbgO7is=@lists.linux.dev
X-Gm-Message-State: AOJu0YxK/Svvp0QxoWjrRMSREPCTmEQByBLcpt5SBfqxv9D0P1mEyWmQ
	1GBFSH4g058EQlhyaBdN3Kt4CW1+fjExVO6NzE5Q2jyxotZDZ6hC61fUt3DwPikdDpsrdRqUYxq
	jVfit9jYDKyp4pGMLELJuIK0oH4KvGzl5G3rwuhMqAm3dhxbv/eugQNBXYPFAlNz5Mss=
X-Gm-Gg: Acq92OFmWFnPa+mhUCUVYT5xmPDX7BpUqjRx4cx6L9bHUFNhNeUsQuJsqej7fpRrCGD
	yemadCGpWgyfK22qMPjdnDuguD+ZWhinbQ++A2iBjXzX1J8WYoaObKTE60nzWaIXPqV6NHLC5Hm
	G+ydANDu7ANmLBMSBZ0j3+u62h4q3UpKGya8wZY2IS6RQuP+8WAIeTFa/W2+UiQEXhlATymYsOp
	IbNqEcPl/xBB0U/tJ7xO3RlvTddRWqcRqkwymrKlS9AUj1mg2prEWBuMI8VK7bN54cHS50pFURY
	dKmtywV411YH1ppB08T/NWyIGj8PrcpYOJgrJiudphUdQ4YIV3OR7bnTOIW6QiaHE8m3NUBWs76
	k9zj5krTMPkIHeHi8k2xYkx48bQ2+4p+ZnOM/uveiWOlAQxy/TWtL07tUfsC9kSBosmKDA2QK+D
	45+OR7J2o3GrkB4NL8es98iIliAaH5JZU/u5rcecyosbI6QA==
X-Received: by 2002:a17:902:e156:b0:2bc:b80f:677e with SMTP id d9443c01a7336-2bd2fe21b60mr14244525ad.25.1778661835405;
        Wed, 13 May 2026 01:43:55 -0700 (PDT)
X-Received: by 2002:a17:902:e156:b0:2bc:b80f:677e with SMTP id d9443c01a7336-2bd2fe21b60mr14244275ad.25.1778661834836;
        Wed, 13 May 2026 01:43:54 -0700 (PDT)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d2709bsm169158725ad.5.2026.05.13.01.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 01:43:54 -0700 (PDT)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com, sunilvl@oss.qualcomm.com,
        anup.patel@oss.qualcomm.com
Cc: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v4 02/10] riscv: Define arch_apei_get_mem_attribute for RISC-V
Date: Wed, 13 May 2026 14:13:17 +0530
Message-ID: <20260513084325.2176952-3-himanshu.chauhan@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA4OSBTYWx0ZWRfX5IdMZpXE5v/t
 AEuD12cTRtNRRIUngvDoIEdL6iT/G2dHqqi43Ij+IVXJCbCmAovDHYx5PTmIprIQhI+k5k3aq0V
 DvyVB/S3c3VS0mezRrjrKNt7Ns7D8sPEhvYeyWHAY/6NE7wq0MLZHCsDP8OBHmr5ZabRsoSTWW/
 HK76Quvevz5/OjMGssxDDfWBtMEXN31KBDBLzC2lY6ipikgSEmi4jAYCLqrynNZTCS4ibpTUu0C
 2ckMYYRuXsZCNKzUP4DhKWNo6RP819KzSvS8w8Gu4YWojgF+ORGBMmq//ll98uRQXY8LWaTM9h8
 u9uKISyPkvKjgc20xqCuLTT1MoBlChqmNv3CF4FTsp6R4/WVgfHTfKSaWqgsR1ITJ1I0qDyBWiL
 1Az1gP+DgTJsdD6nGMdnVjC9DYCNXCX8wVhEDh1ouDkbwis4Fzb6pQbTkk6RRn4hMRMU1QwzZXg
 vsC+6F4N9U4yGdtDIUw==
X-Proofpoint-GUID: nTST_8pfmyLSfAUsmnZ2QKl-g33CgYHl
X-Authority-Analysis: v=2.4 cv=bp98wkai c=1 sm=1 tr=0 ts=6a0439cc cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=eGWCFza2bnmXRcdnH9YA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: nTST_8pfmyLSfAUsmnZ2QKl-g33CgYHl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130089

ghes_map function uses arch_apei_get_mem_attribute to get the
protection bits for a given physical address. These protection
bits are then used to map the physical address.

Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
---
 arch/riscv/include/asm/acpi.h | 16 ++++++++++++++++
 arch/riscv/kernel/acpi.c      | 12 ++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index 26ab37c171bc..c142db9f81a7 100644
--- a/arch/riscv/include/asm/acpi.h
+++ b/arch/riscv/include/asm/acpi.h
@@ -14,6 +14,7 @@
 
 /* Basic configuration for ACPI */
 #ifdef CONFIG_ACPI
+pgprot_t __acpi_get_mem_attribute(phys_addr_t addr);
 
 typedef u64 phys_cpuid_t;
 #define PHYS_CPUID_INVALID INVALID_HARTID
@@ -27,6 +28,21 @@ extern int acpi_disabled;
 extern int acpi_noirq;
 extern int acpi_pci_disabled;
 
+#ifdef	CONFIG_ACPI_APEI
+/*
+ * acpi_disable_cmcff to disable IA-32 Corrected Machine Check (CMC)
+ * Firmware-First mode. It is not required in RISC-V architecture
+ * and is present for compatibility
+ */
+#define acpi_disable_cmcff 1
+static inline pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
+{
+	return  __acpi_get_mem_attribute(addr);
+}
+#else /* CONFIG_ACPI_APEI */
+#define acpi_disable_cmcff 0
+#endif /* !CONFIG_ACPI_APEI */
+
 static inline void disable_acpi(void)
 {
 	acpi_disabled = 1;
diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
index 068e0b404b6f..7a6770697999 100644
--- a/arch/riscv/kernel/acpi.c
+++ b/arch/riscv/kernel/acpi.c
@@ -204,6 +204,18 @@ struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
 	return &cpu_madt_rintc[cpu];
 }
 
+pgprot_t __acpi_get_mem_attribute(phys_addr_t addr)
+{
+	u64 attr;
+
+	attr = efi_mem_attributes(addr);
+	if (attr & EFI_MEMORY_WB)
+		return PAGE_KERNEL;
+	if ((attr & EFI_MEMORY_WC) || (attr & EFI_MEMORY_WT))
+		return pgprot_writecombine(PAGE_KERNEL);
+	return PAGE_KERNEL;
+}
+
 /*
  * __acpi_map_table() will be called before paging_init(), so early_ioremap()
  * or early_memremap() should be called here to for ACPI table mapping.
-- 
2.43.0

