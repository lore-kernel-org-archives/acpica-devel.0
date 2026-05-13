Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FCF3E558F
	for <acpica-devel@lists.linux.dev>; Wed, 13 May 2026 08:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778661852; cv=none; b=XodR8IiDmQGK7NCpKzCa1CvVbjXWM2xFwxBPIuAuxKno4qsBzg1p5UWNoqVFLf8QTEBrQFI8RVtwt84pG3JRscP3jFvr3AhBKt4UqRST9sjar0OsyG9h8R8hvq+DIEDexTMrr3J0CcKaCwsFYyUzvjfakmDDg9Ok2As1unCndSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778661852; c=relaxed/simple;
	bh=W9Z8ad/AN+KNVWAE5HEzWUcd28KekPEPytmpsuBKjhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UXxK9iMrIoTtmfA4ycXT7My/x1qEo4yYU3V2ZqVuRVPYEjTP4cxJ0L0u+Y3LCq9eF1VeXZIc/bqFF88ppcUmE3iTUmOvL5A8F++Zo2R5Xy3Dc2EO7REJWPFPg52NzlDi8/VE5d778Xjg1KkqQvmfY+5we+0BsNRLcMyT/t7LA8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KV2ULzrU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X35+4pKI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KV2ULzrU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X35+4pKI"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D4pXBb2653257
	for <acpica-devel@lists.linux.dev>; Wed, 13 May 2026 08:44:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IQxw9pRj4KjsMr71sZ2t5x+9tK+jz2fwPiFRsDjX/i0=; b=KV2ULzrUF+A121l9
	z9f955kn0s1jVBhILxSnebPtKiWic4KBX9jO7+5bV701hVPYAjoFWfFKYQ+w8bv+
	IfQMCgOpvfz8pP6wHuqSO/wlu4nYnTUCvi2m4sYEQ5S/4uTatQGRTCkM3yWtXvFj
	LhiT+JOzzI7Sd+i4bkvpSxa7avNl6uwHRRVCbKksMhULwrlXHg7wXa6xbADYoYT/
	S/LOfwG6PsNRU4CaR/RudRWeqhdn+ATc0Z3N5cEHpm9QfzrrpvLKkqNbsPBuPbhG
	aqxJzS1/PcCVa5l3Ggulq0N5DfhG01kxnRqLYbJ+kWSU6oq1480UIYiAvW8Q5zqE
	Vaap8g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e45avku62-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Wed, 13 May 2026 08:44:07 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ba15e384c7so39782745ad.3
        for <acpica-devel@lists.linux.dev>; Wed, 13 May 2026 01:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778661846; x=1779266646; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQxw9pRj4KjsMr71sZ2t5x+9tK+jz2fwPiFRsDjX/i0=;
        b=X35+4pKIRj8t+CFEdAYFQNmCPB05nS868ZJNyP2TNXZ1+GXPL72YBXL1CyK42PdDil
         RYsxqHL+mwXzjsOlonB31aBAf0IBAZ3235Z6M7KiR0wZBd0pY745ncUnystbl425mZkd
         wY/NPvxeBSB1xIFEYqb7MOcvfY08hFIw5RYW+eCIUGRAZitHQrxaTYRpwUTkZb7LhcgU
         Ywr+G+4GRbB1cKz+DrJDU9pb9gEWAiwnfbHpEApbR+jm3lNsbMS8eQ+7gHB6wOLlQvER
         Rk674WrF9CdmRlS9h90jaSinIQrpFig6X1NBxpcehb5sa02UITinLwT8GLDOfb56W8lU
         0L+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778661846; x=1779266646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IQxw9pRj4KjsMr71sZ2t5x+9tK+jz2fwPiFRsDjX/i0=;
        b=QzuvrxVxFkiC31JLdT26zUxemi0ewEtcwFyVXpYLm3kaIx8FDE6lU7LIpZTcOVN761
         z4b6ZkeQQMiJ9ifZ6LuxrvXUU2FvWI/NizTH5w6sPbQZEnyfTnCN1LGNsIRswJ3b7dOu
         yDVItmgrn5HzrF6Tj8AiUGCZnux0Sty61wdWX7ccrFQOesQZeb1rYC5G54c1/wnasm0w
         mlRW19H7rlXhdxxA6g5SXAAjViBn0EvLNT6Z8411stmh4EujAXUhCHLYj+XpfJN+Zc5U
         kM4LLgcOuO7/iFDcDzi1dCKihjmEFXlUpg10h+L6NHhJRBTkCsAD+oaKvClF+8y1Za3f
         KXfg==
X-Forwarded-Encrypted: i=1; AFNElJ+EJXT8oqBX6u6nyGVojsQFsNCi7ddiYYUJpaRaLUxCEILuumccu1Y27gxSlU0fEXDY9SAIBSpzXoSkwpQ=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5EBXJChbKrXjKsTFv1U8sBi+h56z3g9NbikEntPp4qZBsIHnr
	zyZH4X1Ysq5FsIjZl79AHFfFA2VhU0FZi8atnMUCkd+uXIj1gWctaFkLjVOaiRD0tOOwmnqbYdI
	bUv3veSeIZGOA8wUE/G6+7rxowqFdcm/EKxc8wJKpFVBNwdRumwZErH8rh5yYSgUVlSA=
X-Gm-Gg: Acq92OHkcqRYYJNrzH2+JM8/Tz+Seg+i/YGhAhib+h1ObtHoP1OtTuEYx6o4h/uIAiQ
	7w1fv1J0Kesspk7e6Z2FGwUFjaNi9wmj750CwMR25FBMWVGfQiTtwnetXKIpX4YY6IyIg/DPV8k
	cHR7+786t7CEVqM2F9K6CEnyoB07Mf/NC63pnAbrHOK03rYFawmTdgTQz4YoqHJsZjEJISbpuFI
	hWQjX74o8f4Vph4pL56/HfLrffMqJl2xWjnmURbs5EBncfC8JhjzxEk+n3wW3JmI8VVh+2IFM6z
	4ojo1WezO4LnsUpuuKE0XUKHYlp2pqGoJAMjcFPQd+7coU9OmK0+v59hToXSflllBdbGnJ43xpg
	jJq9yMZhi3dXPlqxUj+PdkivHv82ukWSgVRId+y0KEClID6gMQEyC5n/oY0MdjhL7lTgC3CIGlj
	Beqv6KzEJ9bOauJLm4s+E/+RzsHh3baIhQwWRSSSbt6+Ggcg==
X-Received: by 2002:a17:903:238b:b0:2bd:a5e:4c66 with SMTP id d9443c01a7336-2bd27161669mr28108195ad.14.1778661846214;
        Wed, 13 May 2026 01:44:06 -0700 (PDT)
X-Received: by 2002:a17:903:238b:b0:2bd:a5e:4c66 with SMTP id d9443c01a7336-2bd27161669mr28107795ad.14.1778661845699;
        Wed, 13 May 2026 01:44:05 -0700 (PDT)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d2709bsm169158725ad.5.2026.05.13.01.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 01:44:05 -0700 (PDT)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com, sunilvl@oss.qualcomm.com,
        anup.patel@oss.qualcomm.com
Cc: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v4 04/10] riscv: Add fixmap indices for GHES IRQ and SSE contexts
Date: Wed, 13 May 2026 14:13:19 +0530
Message-ID: <20260513084325.2176952-5-himanshu.chauhan@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513084325.2176952-1-himanshu.chauhan@oss.qualcomm.com>
References: <20260513084325.2176952-1-himanshu.chauhan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 6Rh_yzr3EPRCnlJUD_4gRZrTDa3oNkb7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA4OSBTYWx0ZWRfX/4Lb9zX8cUFh
 QJDrUn3NPFtxSlvo9u7MOLhwcfIIPKeI42kfmqFHD7gBcVMUnTzKNxf7yzy2yWVsmT/iarGmcIc
 /gX9ob394hEnumgml+C3cLQpL0iKc+bqPtE44os8Cj+KgFWrNSs4hOUMnVghmrzypG4XEGUQGe2
 ddAgv2HurJYJ3s1ZKa186ztajlrQZ162Uf8ccXaZucuOxcXY/j/GYY6Toa6QP22LpUGzfwc13Bp
 4NLwgJd8rUkeIlSV4Of3Uw5HNFNC9H3RStkKhmPNAhDOSQEDU1YC00vpy7wSG9/YbeOypiXbLeE
 2JvQ5sY5OnLP3a9WzZ7pxebq9h40ms/LvqmbtjuCL4rXlsBzmNeHXp15gPg0JBJKl0joFKsfsgF
 dgig24dXGvzXjRAexcEjDO3ij+6MW6MmvB3h+dcr23wzqPICcCI+0mszemJLJhVV+agFPMNRLyf
 zqNUe3rr+25F2iMZ/ZA==
X-Authority-Analysis: v=2.4 cv=bOwm5v+Z c=1 sm=1 tr=0 ts=6a0439d7 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=h0uksLzaAAAA:8 a=0wheRbxtA0UXKxI4o1AA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=MSi_79tMYmZZG2gvAgS0:22
X-Proofpoint-ORIG-GUID: 6Rh_yzr3EPRCnlJUD_4gRZrTDa3oNkb7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0
 malwarescore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130089

GHES error handling requires fixmap entries for IRQ notifications.
Add fixmap indices for IRQ, SSE Low and High priority notifications.

Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Reviewed-By: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/asm/fixmap.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
index 0a55099bb734..e874fd952286 100644
--- a/arch/riscv/include/asm/fixmap.h
+++ b/arch/riscv/include/asm/fixmap.h
@@ -38,6 +38,14 @@ enum fixed_addresses {
 	FIX_TEXT_POKE0,
 	FIX_EARLYCON_MEM_BASE,
 
+#ifdef CONFIG_ACPI_APEI_GHES
+	/* Used for GHES mapping from assorted contexts */
+	FIX_APEI_GHES_IRQ,
+#ifdef CONFIG_RISCV_SBI_SSE
+	FIX_APEI_GHES_SSE_LOW_PRIORITY,
+	FIX_APEI_GHES_SSE_HIGH_PRIORITY,
+#endif /* CONFIG_RISCV_SBI_SSE */
+#endif /* CONFIG_ACPI_APEI_GHES */
 	__end_of_permanent_fixed_addresses,
 	/*
 	 * Temporary boot-time mappings, used by early_ioremap(),
-- 
2.43.0

