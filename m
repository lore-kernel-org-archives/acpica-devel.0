Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80086329C7D
	for <acpica-devel@lists.linux.dev>; Fri,  9 Jan 2026 09:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767949359; cv=none; b=EvQBJH0NXGApFRpXh+UmjMedkstt/joDLVMVnHQhmVd91X5V4/2RYv3Ay0yru0zuVC3+7cNue0qZ1omNEdDSFUS347mPJm3EvMKGjW3pUC43rg2TtnrATc1qTNr147H5QjxmYg+2k01W6v8YCgpaf8s00mTUt4G655nUuBDFH6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767949359; c=relaxed/simple;
	bh=43UXhApAkBbdyL5srItP+jv6EOFCQfwD3JkEtU+Yv8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QTVCMG6zsgwSbVy4bFHx9r8UINZq4css5d9wjT4BhN7S/D0qk4+6EDQ5XZ+T96Y57DeG+2INiY7eeD0qujeXyGKNenrH76o7CwAS9ySD0UeZynjD62Jbj1wxSZhjIbaxSTYp/MxLva4K1NdCtq7j5VIyHNWPIqlLsILbcW/4FmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lUvItflC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Fz5iUIh/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lUvItflC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Fz5iUIh/"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6091qSDt3324802
	for <acpica-devel@lists.linux.dev>; Fri, 9 Jan 2026 09:02:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=jaPeZjaEm2rmsGcviI7wax
	bXzFXJxMs5/kStWwjIs8k=; b=lUvItflCX5293Zm0gWhsCNMlaC3RNDoOoumpL+
	Sf6LfIxKeTAFIjC/PVZAxejpqqzyr0gb6W1Nw/aLtw+C6zuZrbt+DmcG+39DIlfq
	NRNkrd76Y/wc5u1WWex3F3tiaqUzc9Hp2ddwa8c9/j4Cij+hGDBlnh4eraXVXKui
	W1wFmowcuoZaSXqZ4J9wD6BI8tTPt676/kCum5PJmh/PIyTMAv19IMb+FjU8ZsR1
	d6jI42x6ywBrQy0F4H4Hmjhe68CX4bE8KUV0CLJ7A2vyuvHSbJPd6JYn5Gm9opef
	gz9W9AjpxYScfyGWqKGjKNJgWXH55jmTJ3JS1fGeybWNQjdg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjrd6h4t6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Fri, 09 Jan 2026 09:02:34 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7b9321b9312so7416414b3a.1
        for <acpica-devel@lists.linux.dev>; Fri, 09 Jan 2026 01:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767949353; x=1768554153; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jaPeZjaEm2rmsGcviI7waxbXzFXJxMs5/kStWwjIs8k=;
        b=Fz5iUIh/agrXobNCGFZ5W2W0rMMgIzfPNSUjjFfd4vW9anmeFH2vxJGiW8V4YphfZK
         h0U2jNGs0840pz6FTCRnWjkILSJ2G9zhdAsDJSQqR0hjbBgftwGgkznq3+Vmi4loq1p9
         mSagM0aTsN4cvwloA11rnOzwAcmp2gSCT765QXToFThILKyd0bap3mM24l/E4FdQFi0n
         spkiyv7LvdU/WS6xIbBbPndsJtj+Qewz1AOfJnijVtM85TpGcH9QYO/4b9G6yiYfBB85
         yEa8K8EyJI6TphloW+tUD0Hng2lxB7uyG91xCU2MAjpS7/pDTECAIUnHKS2b5dR7LD5v
         H9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767949353; x=1768554153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jaPeZjaEm2rmsGcviI7waxbXzFXJxMs5/kStWwjIs8k=;
        b=g2AXMO+rAdJL++N/4IajbJ93HTNMgA919Dkw9u0T1x9vtuWKTo0uL5a5Om/bTx6BX5
         RRI8vSHrklSPvz951tQk+sofQNCQOCO0AxfYMQdApIWAdvBLp0iEItu6rSq7BKOD21nb
         HS4EkEm3PraLHxtlpQQP0Dvj+bez8mNNfCvpw3/Ms1g8jwdsCAKOlw174T2YSO69Kn6x
         DjP/CVge7loP4mCurzlT3fwt10r5xnU12O75VLZFiAplCFDkR/B5R2ad1Unf9KouMaIW
         mxrCxksWGsAQ/w/lMC8upWhYUd8BPL9vyjCpNPm04Uyj4ahJNdfs9pu8SKr9wd9GODZh
         M7gg==
X-Forwarded-Encrypted: i=1; AJvYcCX9qwdiBBpjoJgyIMpzvBtkc/ruZnvdo0AEmzfFi/s7tosgo3YV0iySXV6CllxC5WJMPSUlRU7J5+K8bhg=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/CsqUO1gjaXFbNMa3wqqoH8y/I4Jxvm4w9dAp0IJMPX16ZEU+
	AHhk5QyS3QTvCxaMD9nXjW5YjR5ooqnoSNPuAUv3nwLQXnyZ9+tyHW1ZH+jAt2Fygn9w8uGmFIw
	oLgy4r+1zy/fdPCarweO4hbcvoCG8x8moEugXQyWDtTpV+K6mjkzXHaVBSz1GN4cAN54=
X-Gm-Gg: AY/fxX4ao/3fRYFyps5ya2skPzpUWWe11Wv6sOh6NHcxdGuFjAGtr4CB+ApQNLDygX1
	3Lnxca1nHOhTGnIUviZYaJ0q5corPmfDc+YwNK0WXhpA24wWHTVWbiIkX4OvZ/3Tf2CD8qPDxC7
	ZuEL9su+utgttXh6aU3JL4VgqxxUHEFMgol31M6OicNlASY7eYFNO//fAEBs2zdXWm9kT2EXc2+
	rmbE2KY96EW9jUHZ68efiIIZs2XpaXZAW3pCDt4fmLbIFNRP8Lt+x3BUOW9gj/uCttaFYP/4346
	sQN+Z2xEYb4GQK22bczi2wzKWss2LEWmE5eBz1p9UHfBrBLyypvgBYgtJBtA5kjrrxUo13IoALS
	cOEXuuKfi6XTKNHnY58Eh405PZ7XZBnmUVqkCbYlLNTdpyTx1j4LMEyzUDh9xTpM32I0H5D9rNv
	WPA5O+Y8KcbT+/fv/g2ZCo7I4LP6Eauj9x5g==
X-Received: by 2002:a05:6a00:909b:b0:7ff:ce33:e6b0 with SMTP id d2e1a72fcca58-81b7d3584dcmr8600305b3a.10.1767949353037;
        Fri, 09 Jan 2026 01:02:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKauFosRUhftJAAnZIqR7HI0iWGjeOb7mTBwr//VM09K21Q9R/ybDsy4S6rU/Qg0jctDgUNQ==
X-Received: by 2002:a05:6a00:909b:b0:7ff:ce33:e6b0 with SMTP id d2e1a72fcca58-81b7d3584dcmr8600210b3a.10.1767949352262;
        Fri, 09 Jan 2026 01:02:32 -0800 (PST)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c59e826asm9831562b3a.54.2026.01.09.01.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 01:02:31 -0800 (PST)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com, sunilvl@oss.qualcomm.com,
        anup.patel@oss.qualcomm.com
Cc: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v3 00/10] Add RAS support for RISC-V architecture
Date: Fri,  9 Jan 2026 14:32:14 +0530
Message-ID: <20260109090224.3105465-1-himanshu.chauhan@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA2NCBTYWx0ZWRfX7AnImaTD0jF2
 2BXTWiOdJGeEJWMEfkqmkktEfgenJw54sYtbB1T35KJP5+XVqH0ohbpCZ92EvqWJk4nzjQhSLfm
 80y8iDiEFYrbGGBJCydobaTRhnpX8+MZYnCKoY5sjC5lwyAFW5BDjaxRYSUPfYtPjQmfNcbkkYG
 aROULGsajEfi8XPWz82k9V4R+dc41PpSr4cWSr6UdFDTiuhDF3czjvxnTVwoEFHqRNAu3wVs4ts
 9JO2i1+/m3olUE4RZCxemEaMso8RBHANPbObt99jTAv3N5LLivh4smGOF7qDwxOtnT5xGBXSxBC
 tsvScf+JgXfaHUe6kWR+g9iumgP8o/u8dSFauuvdwipBEIpxohhDGPm98wRLTkRhamtM5ICd24H
 iPIa8pdjWsPT6yRXRAQMJl05HV4ZUDur4y+9b9uJreBM80mdbbUjXE86e1yzneEXMvmlHxcv0EN
 b9CIA0AMuJCur4Kj9zQ==
X-Proofpoint-GUID: m5JPCY73wsQENps3nCpMAv4MmBvR29Wy
X-Proofpoint-ORIG-GUID: m5JPCY73wsQENps3nCpMAv4MmBvR29Wy
X-Authority-Analysis: v=2.4 cv=Xtf3+FF9 c=1 sm=1 tr=0 ts=6960c42a cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=h0uksLzaAAAA:8
 a=dw0t6H4-AAAA:8 a=j7arexpxAAAA:20 a=WC7QRpXXAAAA:20 a=F-tpdftpAAAA:20
 a=NM_uERPgrM2pg5U9BGAA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=MSi_79tMYmZZG2gvAgS0:22 a=wVJa4CU9-Z26yuRAZDil:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 malwarescore=0 adultscore=0 clxscore=1011 suspectscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601090064

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
 arch/riscv/include/asm/acpi.h          |  20 ++++
 arch/riscv/include/asm/fixmap.h        |   8 ++
 arch/riscv/include/asm/io.h            |   3 +
 drivers/acpi/apei/Kconfig              |   5 +
 drivers/acpi/apei/ghes.c               | 102 +++++++++++++++--
 drivers/firmware/efi/cper.c            |   3 +
 drivers/firmware/riscv/riscv_sbi_sse.c | 146 +++++++++++++++++++++++++
 include/acpi/actbl1.h                  |   3 +-
 include/linux/riscv_sbi_sse.h          |  16 +++
 11 files changed, 298 insertions(+), 12 deletions(-)

-- 
2.43.0

