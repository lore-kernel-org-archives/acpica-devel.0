Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D89D42E404
	for <acpica-devel@lists.linux.dev>; Thu, 24 Sep 2026 07:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790235461; cv=none; b=be0TkU/VmYdKgOlJ54Q3Oc0oDCwQhoV60QLkNRS4QHJn3qzRB8XSI3RoIebQQ10mXS++ryCnf3842wK044jAnLxUZ7rqgiL7FAUFSbk0BUSYPjqvnrmWNcolQRRf5IDtD54glvS0Wo/Ae3wk0V4JEPgwqNiFVIqwmmpk2tMFmcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790235461; c=relaxed/simple;
	bh=v8z3bs/wKomA6O762f46n+RIupf/AQfAQtYjTHMBK64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gHJOyeRjGMaZJBuSk8qU5lEEF2XZVgOOwT7AVI1fRwWZUw2WVcUe9xGqxaOeBGoj3rZi/9FsE05nnaeMh5SOISHd3rCdV/xS2CKX/3Kp5dW5McMPGbitFKthP7DNPzO/xdWFpSnG+KxlJDLPHcHdVRw2Wl2ttIwjF/l0MxqqjY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SGWP3EFX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X2/0MSuX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SGWP3EFX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X2/0MSuX"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5eE142277208
	for <acpica-devel@lists.linux.dev>; Thu, 24 Sep 2026 07:37:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=qPsTlQAM/LB
	nJylXg8OveQ+2HeryYn1OqFxtCZ6vpxA=; b=SGWP3EFXzqW2CbC0eoctGT8Jq2/
	dnut85dn8ztldhowjK0vriSqCD2uXChvmsgOEkhjzSZstsy8/AMhVYNZCwXGF7M3
	e685BogjiciCNsQSPmxw8wRIJlS1TNBahME2++C12ASkU0vNscbqPgYK5AIC07jo
	7Ydn0jcYTq3WBlQGANptp8MpjdbZKe576gW+xm1lwo1TB3FeFprIClMcTMYGrYBS
	iILgMCQe2aLRszr1pdHQXgTEJf+w8z8OPn3DXCdClNv4yZAsYrMLEOFwgvcBCspc
	ssuQ5LDI4ggg2wKyBOXiEr9sN/86/mvInNeaeOnMMwsVJK+dgsOvHA095Kw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfjxuwx9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Thu, 24 Sep 2026 07:37:39 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3286d2bac04so2110873eec.0
        for <acpica-devel@lists.linux.dev>; Thu, 24 Sep 2026 00:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790235459; x=1790840259; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qPsTlQAM/LBnJylXg8OveQ+2HeryYn1OqFxtCZ6vpxA=;
        b=X2/0MSuXdc6iNrFn1qgXuZfYAe0ySNCgexWBL/od+nQmNqVFN18ADHICAShGb1bDsw
         5gl4UW3lQXoIBe4mIwIR+PMdfstSlplBZjQhJcaGjFLh7dde0zK8xQyDCRP50FG9ysZi
         8Xi6jKj1SLmiraCcCwNTtr3aAku3fbqG2cxwhBeAuOA1v3dfk98O7bJmhnMhgwPAiD3n
         Y/7gZwJbVqS2d6H0VslZ3y9/LVeZArOllfbYIZEsJ8nsdYV6wmOcYQWFNLpuoHuiUfoH
         qcRWJj70FUc6unNpcVTipSViMtH4/nISMWJbkbpz/NxKG7bQWFsQY18st+SBv7lc+20f
         gaRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790235459; x=1790840259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qPsTlQAM/LBnJylXg8OveQ+2HeryYn1OqFxtCZ6vpxA=;
        b=Xl3hwNuvUMyzeo83/P9AthrETlLUh9smP8b+WgdidxYuRpy7Y7MnSzdMuAPfW1b7nU
         wXMlGrcOswg4e+sdxLNjcLNxSL9k/hZh3z4H2DQfo3Kprek7F1mhJmf9/ztUbPFz7ydD
         r8Cce+McSh0c/2b7MmCZvPlqbToVm8EHhdCtLruEOe2VTzj1e7G4n6B4R8rkK/74qmL8
         xKlYN6F/OTL1Pdd6WFfcjdkWq7o0jotmubn2hst1eLfh+Hwzo49CVPxFI7jbyZ/Mthxs
         nwYMtjH/rqX7wfNWHB+WlvxhE8FDlz2Y2eeQxLKH+JhW8DLjLnz7qFaIIFdFbTyWfAIS
         4yhw==
X-Gm-Message-State: AFuF++kz9A9JPG/8idC+xhktcTRWafhBnPgTsSIQHqIZW4vq5cKS1szM
	Kplbpt80lHlbJbY5knBu56k69E6jwKbbC2+CqZ9H/ZriU0DBk/bU60E7MlIZCyecen0ZPFhjujW
	h8xXeDVVfYE/IDSnY4FZiwdjFOSVpGcCryRz0g6idux170ssMG2DyoUn5UNH8HamMl8A=
X-Gm-Gg: AYBFou3t5GsOLCSnmpUrdlmNTAfcRaSgw4DFfq0goLeaWB32e75IkmTtUBPJKhTA1Mb
	C4HHw5411aC9emu6EwvbCO2IBOB9RcdKzNIMj7Jogl9rf7ljcL2PyIck1NDDXvNywAsVwqf+54d
	la+ZBAInMOoyQK3PN3fV/Qu5Hn2Je0/dfrpACNN48BTQgpKwWnHhhBzncg/wzzA02l8qX2rZwE9
	OXapS9JcAWyQofCV0eXoosE3Utbwguf2plCeIvcM359t/tB6Rt3mYTdTm0YyTfto6rUurlyZzN8
	33aMDUnPCxdzcwxUdt1ioUM6O4c0fMAxNn+lOHtPJRh1hNegCLvfSj7YPtFK2iXkzRCt00EcgCr
	uQvqz17Qk4Vd6adOpOi+EkuIp5FU2uPMN7MOAKz+wsvsBUtjviZyq0LOxRxXLorr6Wv3irWSxe/
	jwEiaCyBdqNYaAn7ia+1v3eO9d
X-Received: by 2002:a05:7300:7315:b0:33b:e9a7:d81f with SMTP id 5a478bee46e88-340031cca3cmr1644056eec.11.1790235458671;
        Thu, 24 Sep 2026 00:37:38 -0700 (PDT)
X-Received: by 2002:a05:7300:7315:b0:33b:e9a7:d81f with SMTP id 5a478bee46e88-340031cca3cmr1644026eec.11.1790235458107;
        Thu, 24 Sep 2026 00:37:38 -0700 (PDT)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e95c7cfd9sm12120680eec.5.2026.09.24.00.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:37:37 -0700 (PDT)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org
Cc: acpica-devel@lists.linux.dev, anup.patel@oss.qualcomm.com, ardb@kernel.org,
        conor@kernel.org, james.morse@arm.com, lenb@kernel.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robert.moore@intel.com,
        sunilvl@oss.qualcomm.com, tony.luck@intel.com,
        zhangzhanpeng.jasper@bytedance.com,
        Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v5 2/9] riscv: Define arch_apei_get_mem_attribute for RISC-V
Date: Thu, 24 Sep 2026 13:07:07 +0530
Message-ID: <20260924073714.1650588-3-himanshu.chauhan@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: mjEtzpAXmtx6TOXfweBzEVwgUT6SiDCN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAzMiBTYWx0ZWRfXxIYHKqXuzUdP
 GOU47x7ho3vNVy2R/Q0X9xSnqt5MuAIFrR90AVfeRcPruJJlkDaSzQN02XmlO86UDlNxFbYxJkx
 fU+BpHsMbITgQrsw83+0af8Bsci5g92WfXx0OCv8QZxq1z4RERG7pru4f0flVOik+IWu5cRBUq9
 H4grtplWdHOwE69YxTaMLSTFgcPhJAFX1s01yyGs5GjUEeGGGl/FSRMLbs8ZS+NKRxltKqwl92a
 X+Ffa+E8wHJdkLrtrD3SVv2ay4Be9oWNwMN6Y1ahBo/j/qeFTQVDTO724ctc+s4vPTKNWjjJcz8
 8vFudyAlxOXSzGuOo81/BuU7RrC+UQT9SzA54rRPQPlVPMVhH2tDhqbbi+TB8UngJgUHDqen5YF
 N4ZpW3gWsaZGaEkE9r6Z0bXRaXODZDHkkvD0jY0558CDTlqLSAqr63v1x1fuC9xusKt+sG1jmj3
 SbFa4WgAjLiLZ7kH/AQ==
X-Proofpoint-GUID: mjEtzpAXmtx6TOXfweBzEVwgUT6SiDCN
X-Authority-Analysis: v=2.4 cv=NLpAaE6g c=1 sm=1 tr=0 ts=6ab4d343 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=eGWCFza2bnmXRcdnH9YA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAzMiBTYWx0ZWRfX22vj837YqsJ0
 HY6TnR70xZkdQK7cFY9qj4wciqJNrGvNF7lXPw8831OZ+U5ytT8zOTz076MlnFD16g3qW3dMdm7
 o1WwZLQ0YSB4Pc8noCJeayWQdDW5MDE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240032

ghes_map function uses arch_apei_get_mem_attribute to get the
protection bits for a given physical address. These protection
bits are then used to map the physical address.

Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
---
 arch/riscv/include/asm/acpi.h | 16 ++++++++++++++++
 arch/riscv/kernel/acpi.c      | 12 ++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index cdefa1f2d67d..c7dee956cdb1 100644
--- a/arch/riscv/include/asm/acpi.h
+++ b/arch/riscv/include/asm/acpi.h
@@ -16,6 +16,7 @@
 
 /* Basic configuration for ACPI */
 #ifdef CONFIG_ACPI
+pgprot_t __acpi_get_mem_attribute(phys_addr_t addr);
 
 typedef u64 phys_cpuid_t;
 #define PHYS_CPUID_INVALID INVALID_HARTID
@@ -29,6 +30,21 @@ extern int acpi_disabled;
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
index efd52a5d05b5..d1e472ce0878 100644
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

