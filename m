Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF00A330339
	for <acpica-devel@lists.linux.dev>; Fri,  9 Jan 2026 09:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767949367; cv=none; b=RDWM967+35EjMBVARDp1W41EienDt/WwxLBPsAlj5u1PY0QTn6WdPggkGKByI4YEOJt30ZB4z1Eg3Y8vuoA2F46AkM4Ov5TedeQ58NXKrcNFDn5SvcMYy2kvS4alYJQwS7nkmHVGB/6Czz1340UhoBICUjmU+AlqrIKY2YluZIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767949367; c=relaxed/simple;
	bh=e6foTb0AMN9HIN6gj2PSEn4vtPlZHgKWuphSixUcW9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iZST/NQsZ0pAmYxMJNheF8ZpMC2zOm1Eho8drN5sflEYcvvPmH66VGvvfsCGZrVGfVM0n64P9G9lZiukyGGUwM7ZavCarML+3TiJyQ4aIaLOsDasWAAclyriiKLSBwkrNcEAK6cygnjWN8K7waAkWCKC4JiXWcbtg0FXLuvs3eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VLYnbIfi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Nk1m2vw9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VLYnbIfi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Nk1m2vw9"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6095wub93019775
	for <acpica-devel@lists.linux.dev>; Fri, 9 Jan 2026 09:02:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=m2SLt+ibhBF
	eKeTazqX12oxB+MUF6EudEtGynVS4dKk=; b=VLYnbIfi+3ZbXTAor5IETt3WWB6
	pieuPY13RqGZL2vjDCN6I3r2xswRglaQbWCepMrq3DT0vLSx0INPxWUHNHxYekOo
	AO6cUKlzhACVZaqMR4K6n9z6y6H5v4oQZG2FkglLrcR3JxaJRKEhjAiKKtsyzfUl
	1Q5gAlKqiHIduWatuQRpDsqyFIrcA7uT+rKs8gQbCd55YtY4q+0EUeta2qDXUO5b
	SAnsUkazdaXPvyhmDHsoO+cVqRIMpL77FfOGb97LBC50kFv1jR+AoUzy98ye77ST
	yzRJyAhd57Y9rXZuQNC26xpFU16wFNmpL3qKYSIDpNzNK/19aXugTegD8Vw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjjk3j21u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Fri, 09 Jan 2026 09:02:42 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-81c68fef4d4so3379160b3a.2
        for <acpica-devel@lists.linux.dev>; Fri, 09 Jan 2026 01:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767949362; x=1768554162; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2SLt+ibhBFeKeTazqX12oxB+MUF6EudEtGynVS4dKk=;
        b=Nk1m2vw9qEJYOvHy+y2BKa0R2EFOEbcwOrLVftmB5MVi51ecFB5hHPDObQZjjMrtv6
         bv0Xm+JyAloAJ5ObzLAIODnKozjzFZKMQdMCjwEWUrz318RHr6FdFqzkU+sj08PFxoe5
         7CMUBAh2+0Iu7vVvGMRku8aF3wc8UDKnS5ZzrSQCatLlBQPHWrmVwIz/W8RNs3piyXla
         Due1i5h0Wkzns9Y100wxynHrqAqcw3D6adVYCeXcK62IRfKXKOG8z5GWYEZCKmLdNMK9
         qrlczJ7oDUr2jzkqcpQ33RN0tWxz1lKtF0UMPncMM7vjT7g7/XgWvIinvyc9vxfxUMXi
         Btcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767949362; x=1768554162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m2SLt+ibhBFeKeTazqX12oxB+MUF6EudEtGynVS4dKk=;
        b=roY6XESQWEiQOQe+midLRMfIccSOnyQPrqT7C6ph74lM7xt0awS/ksmCmFXcjJrwL9
         dN3zt8epDy9qCXg+zmlEf6GKnLQekPkU9CA4YZgEp1/UM+2D63h8bezQTfnti79dKi3W
         eyzvcTjP70ZH3ZfQ9hR/m7zK4mFnM54f+H9iwQofXdFMLLXFzikh/vpfBywQjIz7pqWQ
         7iJ8iTHFGb6xmm1VhfU3pBXq9ItitQjYgQj8ywXn/WFEtYCkQnrdzrCSCkD7Q4l2I1nS
         y9Xvq5igCS4vcpVDxP8HhPnQROMyHDfKBBDXwgz6xw3T/IoAfZLbaYv5cz1gTsf47XCG
         7fiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjvUCM3GWPVOGwMHur76dH9OMfzzfk2H2KBEeOyToyiltZnKYOsT3fJ7Hg/VJFVRaifEI2w0tWcolWGEs=@lists.linux.dev
X-Gm-Message-State: AOJu0YzpckZVzuncBwps2p1Vx0TRmQTytADIQIeCpCi8/Z5fdM3DBLk9
	L0dNSBffP2A7uOQV8ftUeTUrpJ47GJmU7y8EDgQDod7c5BtEME+r6iUF7weVGedy4gfHoozUnPv
	cca0SQGuRB0vP9O2+a4e4Lxpwod6DMuRaVlTfQoXZijJseEaDjAT0zuMxGK2b1niL+RI=
X-Gm-Gg: AY/fxX7PLEskwSri6ZSeB+blnuBcZ3a1kht4HZO59kNhSQuvVqd7cU4z9lHgLDjBy5f
	kEuMcq2UCXrL/32aKyiSYH+qYWzeTb6tbg8Y28u7l+OBXEIaX0K5wJ95XzPgc06aHXtaGOX+fF/
	5TTstwSOKsMv104OCUwYRMvdDhOcMU6AuvnuZKdv3gVwmxEa9z1WB0HPV/r77cY2zQUQSEVEvWf
	Skzdek9eEhIV6QSJGawHlbaQiClpUUc7FWy4v5x8RgmD7rL6cdhEa2VWyp5Ase031hIyHo30vZb
	J43VClGIE8LDonn/bssUAFvtc3gfVQ9U2+aO2mP+wIyuDUunz74ExxVy4xqm2x4NRBYj74QMX6E
	mPdtJsuO6/NMI5zPJ18oQMbUfINiIkq/A0dG00nB6Be/MXxcZ0fyvbAsgOmh6+eWrf/iLkqtTnQ
	cd+6M95AEACwVwZLp0/pJfL9DNGkVokrwyXw==
X-Received: by 2002:a05:6a00:299a:b0:817:9a85:549f with SMTP id d2e1a72fcca58-81b7d850288mr9071303b3a.20.1767949361938;
        Fri, 09 Jan 2026 01:02:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIp5ZpFALhNPNu+WcxBmPwkXjHrQyIuUsng8/3QgDICBnsVVjJqmXuPHr0vGK3StfS35fRmA==
X-Received: by 2002:a05:6a00:299a:b0:817:9a85:549f with SMTP id d2e1a72fcca58-81b7d850288mr9071263b3a.20.1767949361442;
        Fri, 09 Jan 2026 01:02:41 -0800 (PST)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c59e826asm9831562b3a.54.2026.01.09.01.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 01:02:40 -0800 (PST)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com, sunilvl@oss.qualcomm.com,
        anup.patel@oss.qualcomm.com
Cc: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v3 02/10] riscv: Define arch_apei_get_mem_attribute for RISC-V
Date: Fri,  9 Jan 2026 14:32:16 +0530
Message-ID: <20260109090224.3105465-3-himanshu.chauhan@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: GP6b9a3o9m8AEFepb9HUHzIjrb2al03G
X-Authority-Analysis: v=2.4 cv=EazFgfmC c=1 sm=1 tr=0 ts=6960c432 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=I3DjZvlWSiOXn3_7CcgA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: GP6b9a3o9m8AEFepb9HUHzIjrb2al03G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA2NCBTYWx0ZWRfX4706/gWFD4Iy
 aOPIyhij8ThT8eqpE4lfKP2fEdJEMcV/UJuf/uOoMZk/yVBamQLCrh6stXVyX2OCcTqoIeyr22d
 ffTSPSw9I6T34FvMiS+DRuO7rvocwUT86tDZavhqYCu+4yKkc83kJscfmSbOUm+7Nm50iCmZ5CQ
 cnCwju2TKaiWve3TXsxZ4hUGxAq9s4Noq1DNnmCcv9k4IJUEIv4mjJPi5sfnpb44PJsJTRPxKNG
 3QBXG3Xg5xIFs+y5XuajPtnZWx69e77G5CuenThyOXbf8bs8IBdj95ioQW7+mCNaUzA9E9JRgm0
 +sg0jcGtOcV0Qo2WQo4M8ietR9gj96NKc2oNW9216bBtzn7UquavinzNTVQYoxmj1eeOoxnITUL
 UyAhuPaGgYUlRB9t7kPST241XE/X+uF4pwqKeFsUdrgSd8ER+/fhtQ/n7XTmbi8osHBBgGvOLbG
 3o8oWewHSWIiEl2Fdxg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601090064

ghes_map function uses arch_apei_get_mem_attribute to get the
protection bits for a given physical address. These protection
bits are then used to map the physical address.

Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
---
 arch/riscv/include/asm/acpi.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index 6e13695120bc..0c599452ef48 100644
--- a/arch/riscv/include/asm/acpi.h
+++ b/arch/riscv/include/asm/acpi.h
@@ -27,6 +27,26 @@ extern int acpi_disabled;
 extern int acpi_noirq;
 extern int acpi_pci_disabled;
 
+#ifdef	CONFIG_ACPI_APEI
+/*
+ * acpi_disable_cmcff is used in drivers/acpi/apei/hest.c for disabling
+ * IA-32 Architecture Corrected Machine Check (CMC) Firmware-First mode
+ * with a kernel command line parameter "acpi=nocmcoff". But we don't
+ * have this IA-32 specific feature on ARM64, this definition is only
+ * for compatibility.
+ */
+#define acpi_disable_cmcff 1
+static inline pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
+{
+	/*
+	 * Until we have a way to look for EFI memory attributes.
+	 */
+	return PAGE_KERNEL;
+}
+#else /* CONFIG_ACPI_APEI */
+#define acpi_disable_cmcff 0
+#endif /* !CONFIG_ACPI_APEI */
+
 static inline void disable_acpi(void)
 {
 	acpi_disabled = 1;
-- 
2.43.0

