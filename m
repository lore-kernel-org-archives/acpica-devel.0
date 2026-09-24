Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B41413D69
	for <acpica-devel@lists.linux.dev>; Thu, 24 Sep 2026 07:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790235451; cv=none; b=s+pDOzEOPJajHVqFBQ4lSkXmfl6rNryyqbZjgSA0CvMKcm1YBcQ7x19M8CmvrUImtSu/oGbb4PCsTiXFOdxw3bSoujtaqFeaKBDLzukEO5tSKQ+MtsX5Iopj7tYd9r4U1lkNn7+gONV5/IjDg0fuoxOfXXskrQOrm7pSkhN7jJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790235451; c=relaxed/simple;
	bh=F4YOZAyT9+v8BeHVzPq74zObDOFmFJurwkYTVqXLnB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tbPSUJVntDt6W4RWg4wN7wQXsQwriPivttZfRvDdXdNzUIJvtSSVdGqpZ6K1Yaptm9RzKLrpOL7NHtIQoNh8KEXcls9qAlOAhAQy5hOftdPMyBfGtjJnmTrou73jyaO+MRdlmdJ2y2MzlL+HB8Sm4GZ41f0b/AC5YwYbwNPFNDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LNqk74+4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KlUa2esn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LNqk74+4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KlUa2esn"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5e3Vs567391
	for <acpica-devel@lists.linux.dev>; Thu, 24 Sep 2026 07:37:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=1w+JvUxZEw++QK9Ap9uSoi
	au1BeWaNj5tUGjJMjv4GE=; b=LNqk74+4dX6OYzqukgQbkxoGDF9EAogd+Vog7G
	Oy8WOvhHAhroaNh2WSzDheNIlFVtHlT9G/L70F79XJ7gY1TLe7MPSzmExEolF2Bj
	dl64xnNyM2H/N1hgDNY1lWPvmZfhH0ez72qIxYNnbjvmgYQhoOAHYpPUN9Gp4LqI
	r3kS7BYhp9zSYry8RQ0PoW3v5IvHBYEt97rEbWfxNvge+F2FbyGwvn5LqVCTOn5u
	K6kUroWsXpUsgQ6bmom8jy5NDznWPLVKNr2HpZ4eglKIoZe01CVYIdTFWEABWFs9
	fM3SYGS7LLuMcN2ZC5yACZ7qa/op0CZeC4zMhG2jkmUuGFBQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvvgh8qtu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Thu, 24 Sep 2026 07:37:28 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30bcb065bfdso2647068eec.0
        for <acpica-devel@lists.linux.dev>; Thu, 24 Sep 2026 00:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790235448; x=1790840248; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1w+JvUxZEw++QK9Ap9uSoiau1BeWaNj5tUGjJMjv4GE=;
        b=KlUa2esn8YCaS+pUIzaFD2v44GZawcYup2ab3YuKPKm3A6yusMudA5vcJdruve4a7x
         gIKcfrRcbCv+sxB6yyZbsygMUz8gtLEC4kICo0/UhMxyg9Frx10HPDu99twjBdUcsLUS
         MuEyrC05dT2aJQPIQqA9Pj7DJ9bEFdsS4B8SGNQ4K3uweP5qeowMGkmeW4wK4a07q4A5
         fWVsBJ0su2pAYWNykPRavK1JsCF9DRHqyJUFNCUXJoJDVh25bqfydpH3FCYOjpf3aOu5
         zFcOw0gRA7Qw6p8AXRyC6bpfuN6TFlm/JKGXR0UjTpN3UmGyCqxOBabcMwLbafvFlLlL
         do8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790235448; x=1790840248;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1w+JvUxZEw++QK9Ap9uSoiau1BeWaNj5tUGjJMjv4GE=;
        b=SL0fWhUH5DZbMF2hodpji7DgpyS21es6z9teBed+WNeKJesHvVvjZ23M/3rBIOdzEW
         ijEZK45E3SohmxH4MqlSfEA/G2Li4U8jEjhouuFYeVHM0tq/ffD8Uj5V30GCZ/g2NsgZ
         9ApjgRDyxnfSxt9wRAv3vx1/6nw7coHZnnUidpeZoGr2aQ/TDs/MGwsaly0NjrckS3Em
         eeBKiytuyDS5/P5Yz/NVo7AtAgeFu9Rzi/HI8qZFMjiimmybRZQQbcsXIGxB1w3zFDFE
         bLCuM8Diz4um3BNjMXfF7VTof5yvPkZqLEA9JwwvuGy8zt0OXIJ4sY57ME6QwOsHFMoR
         8PfA==
X-Gm-Message-State: AFuF++npwtt0yOV8ppg8bpmFUQ8fk8hln1oLzOdb+oGUsU4cBxrwOY5W
	8kH9tFR+y6DQtAODoRo0P9VEzVmlqrjAY026OpLffuMhyKmzUmcy3Ok2H1QurgA4nrzC2dCzFHD
	6Xuz/fe33EQ97jOQ7cNFl11j1FN8iKIrMq+znlq3E+7ZjaSUA1m/s4WoH5PLGsb56bwk=
X-Gm-Gg: AYBFou2qnRNMAb2Dqja0dTjaOyeoa6JQFYKlzPFTk1g3JrSE61fg15+0s8zxb7sv2zN
	rK6l8z64HPEEvhC4JL9DnNu/H0RA9bi6y9diuZT38sYcSsTSsmIsFPl8fIrV84u6UK+8f/r4n2k
	17cqeqY6BtNffXRQc56PkA8nANnza7hVa02NHC1eg+F7fW/jIQFzxvrA2JEQl9PeYeoPyu39QHG
	mSY6DIgCdw1ix/wibbl7PK15P5FwYegclMlQBWJ3PJ/AFSQwAcGJOV6vd8X/WN0UGFzkwOAvgsA
	NnxV9ghgvP9AOki0Y9IqekcOu7+M1H81/qalxbmpQ3RiPjCkQM9eV4Dv31+OGfzPfWE7EgeYlNl
	WgkOsbAgaxV/sI0FTItnm27MLb3ZEGFDav9X+SfZf7aUxar4XVuKboI+pCz/VChA4gN05EhdmOi
	Bc/JsJb9x9f1j0ZjVAQyeUVOkR
X-Received: by 2002:a05:693c:8087:b0:33b:f062:a674 with SMTP id 5a478bee46e88-34000643243mr1469579eec.21.1790235447197;
        Thu, 24 Sep 2026 00:37:27 -0700 (PDT)
X-Received: by 2002:a05:693c:8087:b0:33b:f062:a674 with SMTP id 5a478bee46e88-34000643243mr1469548eec.21.1790235446486;
        Thu, 24 Sep 2026 00:37:26 -0700 (PDT)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e95c7cfd9sm12120680eec.5.2026.09.24.00.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:37:26 -0700 (PDT)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org
Cc: acpica-devel@lists.linux.dev, anup.patel@oss.qualcomm.com, ardb@kernel.org,
        conor@kernel.org, james.morse@arm.com, lenb@kernel.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robert.moore@intel.com,
        sunilvl@oss.qualcomm.com, tony.luck@intel.com,
        zhangzhanpeng.jasper@bytedance.com,
        Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v5 0/9] Add RAS support for RISC-V architecture
Date: Thu, 24 Sep 2026 13:07:05 +0530
Message-ID: <20260924073714.1650588-1-himanshu.chauhan@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KYhHIgYD c=1 sm=1 tr=0 ts=6ab4d338 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=NEAV23lmAAAA:8 a=V1jnuoLLAAAA:20 a=VwQbUJbxAAAA:8 a=h0uksLzaAAAA:8
 a=968KyxNXAAAA:8 a=dw0t6H4-AAAA:8 a=j7arexpxAAAA:20 a=WC7QRpXXAAAA:20
 a=F-tpdftpAAAA:20 a=5RlsHsUcgChCSPQ6cREA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=MSi_79tMYmZZG2gvAgS0:22 a=wVJa4CU9-Z26yuRAZDil:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: AzVK383feZ2NI2PCScMovSDyjVn-Darf
X-Proofpoint-ORIG-GUID: AzVK383feZ2NI2PCScMovSDyjVn-Darf
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAzMiBTYWx0ZWRfX1g4TuT79Fa3l
 gScGRfiU1lKhaJFr/QekuLkKomw8aG28904b38uckG/cRDmXVLrfnRfepqDQUbatdWvUwxre+xN
 1/em/FcdN3lCrU1kFE6aiQpVz6ILYuM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAzMiBTYWx0ZWRfXwFro6MRxOtSy
 CoioDwq+Ac3HZwWAApm3t/RDjTJaYWNnz8TJI4rKamUi0FUZm92I4rf38DMwE91lGq1EWnsBKix
 AU8XSqqs6fAbNKjvjVKzXW7pbpV/KxEt34YtsVxjHH69OAraeemgTkX+nYhasH5zt0zm4SqQItE
 RRrJSU4pMk6HYBVgR/j/yHBBjpO6A+Dh0gh48naxqGT7Gnma4g9Jnzy1Y/RRQThO11omMHJMZtF
 Db33sIqlNSCdTKqdBFiKcmuZmNz8G9oaq08eaqBVG3PaWWLHLTlog0yGB02nqmyXWPjoUFf0E3L
 azIgQdt+WxytyWo30WvxNzBPWqO8NmjHf2SJNr1kXkXDoFNRGxsyKoIbhezIRzDFqv9P6Gfhe53
 2l4n6PX6ooaFkzXeqZI9kfqv63TrWMVXOWdZUTxZIujoajv519N+lCZjGlsgWPK/1XUcsVdzJcX
 MjKWKLrQQwHqs6CXShg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1011 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240032

RAS stands for Reliability, Availability and Serviceability.

This series implements the RAS support for RISC-V architecture using
RISC-V RERI specification. It is conformant to ACPI platform error
interfaces (APEI). It uses the highest priority Supervisor Software
Events (SSE)[2] to deliver the hardware error events to the kernel.
The SSE implementation has already been merged in OpenSBI. Clement/Zhanpeng Zhang
have sent a patch series for its implemenation in Linux kernel.[6]

The GHES driver framework is used as is with the following changes for RISC-V:
	1. Register each ghes entry with SSE layer. Ghes notification vector is SSE event.
	2. Add RISC-V specific entries for processor type and ISA string
	3. Add fixmap indices GHES SSE Low and High Priority to help map and read from
	   physical addresses present in GHES entry.
	4. Other changes to build/configure the RAS support

Changes in v5:
 - Rebased to 7.3-rc3
 - Based on SSE v10 Patch series
 - Notificate type patch is generated from acpica gen-patch.sh script since the review request in v4 is now merged.
 - Since 7bfd21e828504, takes care of conditionally compiling ghes_in_nmi_spool_from_list, 5th patch in v4 is dropped.
 - Moved from kzalloc to kzalloc_obj for sse event allocation

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
[6] [SSE Kernel Patches (v10)    ]: https://lore.kernel.org/all/cover.1789974241.git.zhangzhanpeng.jasper@bytedance.com/
[7] [ACPI ECR for HEST changes   ]: https://mantis.uefi.org/mantis/view.php?id=2522
[8] [RISC-V CPER Table ECR       ]: https://mantis.uefi.org/mantis/view.php?id=2551
[9] [RISC-V CPER Proposed Changes]:
	[PART 1] https://docs.google.com/document/d/1-Dd-T_QIUqjq3muyjfK8IUeXWr9QWkFAkFyzweXQL30/edit?tab=t.0
	[PART 2] https://docs.google.com/document/d/13y8kQqbVtCAPCMI4oJ80MtcUS5FL4xuO914NmfCi5vI/edit?tab=t.0
[10] [RISC-V APEI Proposed Changes]: https://docs.google.com/document/d/18rxA6JTyFTelEj0aiKdSFzxPgwyHyThj8EP8lXqWZdY/edit?tab=t.0

Himanshu Chauhan (9):
  riscv: Define ioremap_cache for RISC-V
  riscv: Define arch_apei_get_mem_attribute for RISC-V
  Introduce a new HEST notification type for RISC-V SSE events.
  riscv: Add fixmap indices for GHES IRQ and SSE contexts
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
 drivers/acpi/apei/ghes.c               |  99 +++++++++++++++--
 drivers/firmware/efi/cper.c            |   3 +
 drivers/firmware/riscv/riscv_sbi_sse.c | 146 +++++++++++++++++++++++++
 include/acpi/actbl1.h                  |   3 +-
 include/linux/riscv_sbi_sse.h          |  16 +++
 12 files changed, 303 insertions(+), 12 deletions(-)

-- 
2.43.0

