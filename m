Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D2B357CE1
	for <acpica-devel@lists.linux.dev>; Wed, 13 May 2026 08:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778661827; cv=none; b=T3yds7Z3cPDtaWM+XCrRBPRTW6oM2RkZcwPLmtQ7t5Bx7UHY33y0rCfxeodQk/eUfaKRFVrJX7eR9jxld+0/4IXby8M9lMHdMQ7uttumFPVhkjjCTgP9wCe32Pt6v6MtNZB5StP0HEQ3iyFgMLcJNpMrcBoeYfo538yj2yiHNuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778661827; c=relaxed/simple;
	bh=zsnExNJxHb5CwPG/1WZiVXnXOtJfrgVhK0JTNumtgK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CqGXPopTwOFALdcaKqgMNCpljtdDCmdfBNG+cZjuY99njQJ8fRJ+o0T1u5xW02jBT29cJtobqmCEsXKLbjDjp/sNTsCSqjXCDd1FVcYrhmVo9/J2KMDeuVUmUjLtvGV1VNwTxR/5HeqPIgPDMJwJyg5UnccjHgycTuRSxVKZrsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hwR7gbVU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gEKIlaWL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hwR7gbVU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gEKIlaWL"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D4pCuT2331504
	for <acpica-devel@lists.linux.dev>; Wed, 13 May 2026 08:43:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=3aWzzWqgV1S+DaS5mlIRnU
	gf5ktWPNv26+QnmRkT+ME=; b=hwR7gbVUoxjURX6qLYAEAxMb+yk0dRG5EZ51x/
	dcXzldklHMzJYhJvk3EqH3s3UdMsgBWSt8bQ9ZADjslw4ciyf9IToJhxJCNvySQi
	isOf3KapTjbRuUG2qXNi92TTYlZfiCKt8HbhpAYZldXTCt1V/P5Rc30lM3tlC066
	NPTZviIYlHcFof+2pKdHhaQ+7RxyGjgotNU5iScDn3Io6YLzFu/OSeZnKzUTV0MN
	e+gIvbaxU+7XeDYSAvdT1xKhTpu4Te2mtjam8/70wbwXtlAiKt+/UP3MaixxEv+j
	GwGWOkUKak7iiRwD8LhOPgUfIRnRsLEzdsAvtKVh+INJSa8g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e43ypc8du-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Wed, 13 May 2026 08:43:42 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3663cbff31cso11490421a91.2
        for <acpica-devel@lists.linux.dev>; Wed, 13 May 2026 01:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778661821; x=1779266621; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3aWzzWqgV1S+DaS5mlIRnUgf5ktWPNv26+QnmRkT+ME=;
        b=gEKIlaWLSVJ/ZH/P7FbJVJl+dTxu8A9rPU6TbyojMCEXOSTSA+tGSrboD2pSzROs+l
         INzIUlUSQ0GYGcw4hLXTihN8EX7yk3men5DzyXRrzJV97jfD7FT0KNvAWoEyVKX63LwD
         6Ik4BEnXSpMvkcuUlnTccaplmbeuVUZb4MS4Ih4JFun8+0LyrNNCvo/+xXhhJqgrdQ0P
         FNlnGStiPXLXbWfbK/t3JXQTDeYZKoVhveEEvjsEKNa2E6s6+j94R+D6M/abJzDCVIo3
         LmYK2e3plHg/mLGAxdpd/iww2Q5jm9u+azVCK+5cUNS6sO9VvdDLfSV/gLoR8pE/FsYy
         l9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778661821; x=1779266621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3aWzzWqgV1S+DaS5mlIRnUgf5ktWPNv26+QnmRkT+ME=;
        b=Nhh0s8F6vEQPSkgQdflWi9qIfA6MXYn+FBpTEZV2qU1fG167gSciJgPdfr7M9uuaJW
         tlfymPi+8kqZxDXTIQIvzXAzYGZfA0djuaWgON9lhfxm4UITaGYz/KmOzWWgpUUbJhxj
         /bE2TkF7mY8jRo6XsmNNOCASdOPz8//JVXIHI5vMO16Ix94+P49xdAmpsy0wgW+itt/m
         UKpljt/CdXUgo6Gqd2AyXX7PbZbdnb3uXWa0kJOXBx8piZtXImReJAdQOAvwECnjpoaQ
         95+VxH1IXeoBn7/EHmBuzeHVnjEL02Xnjf9oECTlZmxVbOWUnPb2TCd6h6GGG6Wp4zyQ
         e7rQ==
X-Forwarded-Encrypted: i=1; AFNElJ8UUP3qY64ZuRNb4nPn+Aw+xYKaGFCBq4+YinTwMKePjoKlSDq8H2IeLRP88qEBlBran+IvzV9IVEj8mf4=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxp05fgB72Q4uayRGmo5ykuJIDeaLuL/RZZYcFbEAlKZ+iHrWqo
	f02NtFNclVXHB0JZuNUESuHwQfwNLTHf6PKzfOSnZY85MTce2eEGRIATuZZsPo9sTE7nF77680S
	eoVmd5PaQrOmAUdGotdBQ8DPhuo9deuxvt3DoGVHSmMTF6Svf5eAV8bfpqjCOd8nsu7U=
X-Gm-Gg: Acq92OEEntwT23+wSckGttvzksfxezC4PHcZQ3EExXbUkwhzRWphTQwtpi2J6B9aBDo
	Nuz5iR9oRyy2Pd+dU83poo0rlbSVvMInGcxJzIIVkwxlDE3f3Pk1sAqW6l54jaCeELvPpdiHZiF
	GnL+WbdHDZMiqxaM/aJiQeupoqiJJE5f68RuS2fdcpLikW+kL+jiU5YXYghjr6R3xEwUR4S8oae
	zpo6D2poYR+UQ2sI1fmJFTN2/aBiINH45pRHTMlZRIQ+sz3aUKmkgaqzg+5C1zlHYngfkyL3wIx
	vIWQ8w6LiGluxZJCq5pF8wTGbEUkvFhZh2aCFP+aSg5NK64/iSyGvmb7uQMXmrdv9Bq90UG1LCv
	pgae6O/UeA68qAPZhEV8IEDUTnNYUcptUmY4Kvbx02xX50CgYDYeiM99riKg5DW7vrmYuSbPGv4
	aE5OLNPlJ7qMfAVlwsRWsFEXSf1s9ckNXiJQlJ5ygufcD3eA==
X-Received: by 2002:a17:90b:2ccb:b0:367:db13:aca6 with SMTP id 98e67ed59e1d1-368f7a26e42mr2102560a91.26.1778661820922;
        Wed, 13 May 2026 01:43:40 -0700 (PDT)
X-Received: by 2002:a17:90b:2ccb:b0:367:db13:aca6 with SMTP id 98e67ed59e1d1-368f7a26e42mr2102502a91.26.1778661820245;
        Wed, 13 May 2026 01:43:40 -0700 (PDT)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d2709bsm169158725ad.5.2026.05.13.01.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 01:43:39 -0700 (PDT)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com, sunilvl@oss.qualcomm.com,
        anup.patel@oss.qualcomm.com
Cc: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v4 00/10] Add RAS support for RISC-V architecture
Date: Wed, 13 May 2026 14:13:15 +0530
Message-ID: <20260513084325.2176952-1-himanshu.chauhan@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _oK6bdyvXkMKxZpGZLuEpP96WTHY6WGg
X-Authority-Analysis: v=2.4 cv=R5kz39RX c=1 sm=1 tr=0 ts=6a0439be cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=NEAV23lmAAAA:8 a=V1jnuoLLAAAA:20 a=VwQbUJbxAAAA:8 a=h0uksLzaAAAA:8
 a=dw0t6H4-AAAA:8 a=j7arexpxAAAA:20 a=WC7QRpXXAAAA:20 a=F-tpdftpAAAA:20
 a=hVMvMyeA2jgiXT6_RH4A:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=MSi_79tMYmZZG2gvAgS0:22 a=wVJa4CU9-Z26yuRAZDil:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA4OSBTYWx0ZWRfX0NkFRzV/hy5A
 CD5rM5VRZfUaY1Cm6ciwY2/rnOMO2ML7P76zxRzQsJJOhX7grZJKW31+V1JLBV+GEu23n7fxgbz
 5oZiF/c0e5As6omhLRWbRdUOur2lAyN/Vsvzg2koVHEWVd6x3UuFpoS2qU1KgCLpk/iL/gdcK5K
 vfdK0vXIQXL4KyzvmHuY7zQuxCR2PCXC8oKnO9hW70Okjk2H9E8ZnB8wQGDEcbdBTo3o8XmuW/2
 8KuzM/Hti+CZKoUj2vGu19y3F9SzP5v5CbG2Vll4eKFr4b1B3JXnh7G17VZMqlOH1WxIbajcfan
 yKnabZ/mCAiN9gEsRMF6LHkERUe8s05Li7zX7VNnR952Ot8pqf9TKZBACLWh4S4kU8fWlc67grZ
 WMSeOxuF1dluo3adjbZWmgGKKPiU28o+tBZrHBCnCIEIBLQCbRIhBMRQTKit+zGU46t/gpr6aLY
 yOD+WTvLjEHwHedqozw==
X-Proofpoint-GUID: _oK6bdyvXkMKxZpGZLuEpP96WTHY6WGg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130089

RAS stands for Reliability, Availability and Serviceability.

This series implements the RAS support for RISC-V architecture using
RISC-V RERI specification. It is conformant to ACPI platform error
interfaces (APEI). It uses the highest priority Supervisor Software
Events (SSE)[2] to deliver the hardware error events to the kernel.
The SSE implementation has already been merged in OpenSBI. Clement
has sent a patch series for its implemenation in Linux kernel.[5]

The GHES driver framework is used as is with the following changes for RISC-V:
	1. Register each ghes entry with SSE layer. Ghes notification vector is SSE event.
	2. Add RISC-V specific entries for processor type and ISA string
	3. Add fixmap indices GHES SSE Low and High Priority to help map and read from
	   physical addresses present in GHES entry.
	4. Other changes to build/configure the RAS support

Changes in v4:
 - Rebased to Linux v7.1-rc3
 - Changed RISCV to RISC-V
 - RISCV32 and RISCV64 to RV32/RV32E and RV64 respectively
 - Raised a review request for patch "Introduce SSE in HEST notification types" in ACPICA
   https://github.com/acpica/acpica/pull/1170
   Keeping the patch here for complete functionality

Changes in v3:
 - Dropped RFC tag because the related ECRs are now approved [6][7][8][9]
 - Changes to be conformant with SSE v8 patches

Changes in v2:
 - Made changes to be conformant with SSE v7 patches
 - Fixed some bot warnings

How to Use:
----------
This RAS stack consists of Qemu[3], OpenSBI, EDK2[4], Linux kernel and devmem utility to inject and trigger
errors. Qemu [Ref.] has support to emulate RISC-V RERI. The RAS agent is implemented in OpenSBI which
creates CPER records. EDK2 generates HEST table and populates it with GHES entries with the help of
OpenSBI.

Qemu Command:
------------
<qemu-dir>/build/qemu-system-riscv64 \
    -s -accel tcg -m 4096 -smp 2 \
    -cpu rv64,smepmp=false \
    -serial mon:stdio \
    -d guest_errors -D ./qemu.log \
    -bios <opensbi-dir>/build/platform/generic/firmware/fw_dynamic.bin \
    -monitor telnet:127.0.0.1:55555,server,nowait \
    -device virtio-gpu-pci -full-screen \ 
    -device qemu-xhci \
    -device usb-kbd \
    -blockdev node-name=pflash0,driver=file,read-only=on,filename=<edk2-build-dir>/RiscVVirtQemu/RELEASE_GCC5/FV/RISCV_VIRT_CODE.fd \
    -blockdev node-name=pflash1,driver=file,filename=<edk2-build-dir>/RiscVVirtQemu/RELEASE_GCC5/FV/RISCV_VIRT_VARS.fd \
    -M virt,pflash0=pflash0,pflash1=pflash1,rpmi=true,reri=true,aia=aplic-imsic \
    -kernel <kernel image> \
    -initrd <rootfs image> \
    -append "root=/dev/ram rw console=ttyS0 earlycon=uart8250,mmio,0x10000000"

Error Injection & Triggering:
----------------------------
devmem 0x4010040 32 0x2a1
devmem 0x4010048 32 0x9001404
devmem 0x4010044 8 1

The above commands injects a TLB error on CPU 0.

Sample Output (CPU 0):
---------------------
[   34.370282] {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
[   34.371375] {1}[Hardware Error]: event severity: recoverable
[   34.372149] {1}[Hardware Error]:  Error 0, type: recoverable
[   34.372756] {1}[Hardware Error]:   section_type: general processor error
[   34.373357] {1}[Hardware Error]:   processor_type: 3, RISCV
[   34.373806] {1}[Hardware Error]:   processor_isa: 6, RISCV64
[   34.374294] {1}[Hardware Error]:   error_type: 0x02
[   34.374845] {1}[Hardware Error]:   TLB error
[   34.375448] {1}[Hardware Error]:   operation: 1, data read
[   34.376100] {1}[Hardware Error]:   target_address: 0x0000000000000000

References:
----------
[1] [RERI Specification          ]: https://github.com/riscv-non-isa/riscv-ras-eri/releases/download/v1.0/riscv-reri.pdf
[2] [Chap-19 SSE RISC-V SBI v3.0 ]: https://github.com/riscv-non-isa/riscv-sbi-doc/releases/download/v3.0/riscv-sbi.pdf
[3] [Qemu source (RERI Support)  ]: https://github.com/ventanamicro/qemu.git (branch: dev-upstream)
[4] [EDK2                        ]: https://github.com/ventanamicro/edk2.git (branch: dev-upstream)
[5] [SSE Kernel Patches (v8)     ]: https://lore.kernel.org/all/20251105082639.342973-1-cleger@rivosinc.com/
[6] [ACPI ECR for HEST changes   ]: https://mantis.uefi.org/mantis/view.php?id=2522
[7] [RISC-V CPER Table ECR       ]: https://mantis.uefi.org/mantis/view.php?id=2551
[8] [RISC-V CPER Proposed Changes]:
	[PART 1] https://docs.google.com/document/d/1-Dd-T_QIUqjq3muyjfK8IUeXWr9QWkFAkFyzweXQL30/edit?tab=t.0
	[PART 2] https://docs.google.com/document/d/13y8kQqbVtCAPCMI4oJ80MtcUS5FL4xuO914NmfCi5vI/edit?tab=t.0
[9] [RISC-V APEI Proposed Changes]: https://docs.google.com/document/d/18rxA6JTyFTelEj0aiKdSFzxPgwyHyThj8EP8lXqWZdY/edit?tab=t.0

Himanshu Chauhan (10):
  riscv: Define ioremap_cache for RISC-V
  riscv: Define arch_apei_get_mem_attribute for RISC-V
  acpi: Introduce SSE in HEST notification types
  riscv: Add fixmap indices for GHES IRQ and SSE contexts
  riscv: conditionally compile GHES NMI spool function
  riscv: Add functions to register ghes having SSE notification
  riscv: Add RISC-V entries in processor type and ISA strings
  riscv: Introduce HEST SSE notification handlers
  riscv: Select HAVE_ACPI_APEI required for RAS
  riscv: Enable APEI GHES driver in defconfig

 arch/riscv/Kconfig                     |   1 +
 arch/riscv/configs/defconfig           |   3 +
 arch/riscv/include/asm/acpi.h          |  16 +++
 arch/riscv/include/asm/fixmap.h        |   8 ++
 arch/riscv/include/asm/io.h            |   3 +
 arch/riscv/kernel/acpi.c               |  12 ++
 drivers/acpi/apei/Kconfig              |   5 +
 drivers/acpi/apei/ghes.c               | 101 +++++++++++++++--
 drivers/firmware/efi/cper.c            |   3 +
 drivers/firmware/riscv/riscv_sbi_sse.c | 146 +++++++++++++++++++++++++
 include/acpi/actbl1.h                  |   3 +-
 include/linux/riscv_sbi_sse.h          |  16 +++
 12 files changed, 305 insertions(+), 12 deletions(-)

-- 
2.43.0

