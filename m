Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FD3328B41
	for <acpica-devel@lists.linux.dev>; Wed, 29 Oct 2025 11:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737226; cv=none; b=Gc2yRx0mdikEu2ZVQj9uabvcqaWoFDPeWXi7/R/5vcuopqYqm8gJB2GQ0c+EXUhRsFVjayaF3g8QYSm/RHCJXGhy+2NE32XorDTZvVl2WFUNFenePqcSHiXgZMuVQntLnZXGkElD+6VXBeoikJa6Bx63mPrQUDKIYMzq6N2q33w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737226; c=relaxed/simple;
	bh=Hjkf53zqmGuffTDA/lEf7CNxn/oGC5EWuEOnSQGpNUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g7OmN18gOy6qaZSCn+aT7VCimjR6vAjhYo+byugWU4pO8DsS3f7op2FDgCLlEDetMO5mci7rVhuHcZA4tjlZTdOIjQVQWVjUchvB3jKiDcbEICJrbzDOdZYsdeLPmWU/Pk3h/0uReM6e05DHRYA++8sx9p3xxEgPZ5Q6G5MrVlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=CiCWJUbp; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="CiCWJUbp"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-33bbc4e81dfso7658256a91.1
        for <acpica-devel@lists.linux.dev>; Wed, 29 Oct 2025 04:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1761737224; x=1762342024; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o/A6oM3VT03v+OO6JYlGjLYI0SFwHFSmDU7wY8ZWBxg=;
        b=CiCWJUbpKv1Wq5L+8P0S+AfOjKP2qk6ZU4ZSJ2+B82zM4EVQ/eq/ZS5o9uV9ypbq2K
         Y6yZ+NzY6s+xfXpbkHOIoJZHodjLB8Xt50Ayzcr+3ItITQSR1f8mb1Rj6Nrqqmp2yihG
         v77ZLXZ5PFYjPnX3pnftD86/Au9un1RTg7/uJ69AySQTTqOIzGNr7/74favRaCjkTSJN
         iyoCwE6dqV6nutOqxPLRvdHSPcFTblDl13nEb9G2w7kXxMAxHVR2zPPhrWD0pinh6A7k
         MElRK86RNZ1iBw/xiyTnoS8DL+YIWWQhrj+8YUQFND8CO85ZO0/6aFNpjVweJ3Scauhe
         XmTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761737224; x=1762342024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o/A6oM3VT03v+OO6JYlGjLYI0SFwHFSmDU7wY8ZWBxg=;
        b=fWE4Jvz9LumyPJHXGoUXRp6TZglyu56ifwZQitJwNCpi3l3CATUKVM5w5Nd30Wd3x0
         XtMVj88wcI6ng2niCW7ta5wTD0OIBopYRVc1acUxeV0Wo8TwjuBPmpbiv6HH8jwuiYZ2
         cjryscrKBgsUrd9op0RqcRZiCPI2nyl7blHKKNsnZBW+rQhtGgEqIYz3cLknDK/4XBTl
         MovtFy+Jmcrg9Sdk8kNLfhJJLIqdYpn3kFPgUziaM/nCHfnkBI7zvm0F/1a9v5jmQtwU
         Zpz9eWscsa3itnZMgQ47nECBbz56MBos2FcGccERjzGvUSYvl68hZ6jia10Sa2ptrODn
         WLBg==
X-Forwarded-Encrypted: i=1; AJvYcCV4oUAsOWS7Q1htoZguW3SYSm5a9WHttM97p7MXOflb7OZhVzM9RaT1qWBGNFxHrWvikAdtj/tSW/hZ65c=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6Hf5doYIJoXy4J8Y+2lmtVIgBwItugA8lcu6Uei+c1z4s64ky
	s0D2zSytgJZHdvcQeefzEQyCnhP4Q7Lta6h/SO4+MyXPEJrgEltCdFykOIPXTPVqzlU=
X-Gm-Gg: ASbGncsjhog2TiC6aWg58uYtvz3MJD9t1qFqzF5P8NHCwaRZCu5AFB0g5+psbwgNcQF
	Z/zRPvCcN0AKZVUarPnjuc8WAcMuWGj51+S4GrlNkcrK9DFSywfWZ1jcztZ8N0ARryklWyPFi34
	zH+QFQaQ6nSATxBgGwRxMM1oJS54002G4i6IdG0bcgXq2WDRXiLes2oPoRV3rUI7HetnoGb6MOp
	n3BCdWSWHebWQBtUA0ORy0nMj494z5mmy69qJIZCOUtd2AsX9wxVvfgxcRm6uyFG/8cRT7wNEPl
	tyxk6VhEoanshstjwT0fm8vFqPIREdUVvvM7wVBWNr84aMVnwGuNSrSVAHw1OsyLKdiYakdYvzV
	5Mj317I4HMXsLnPhH8m9QTUTuzgYTXP58VH9ClfOgZsLiI616ZmG8iOoxsI6fYYRThPtcWmVkJo
	pLCcsqmKhK4mToXyWajBPeux/JWgjF
X-Google-Smtp-Source: AGHT+IHpjKO2jUEb6+cQytmuQWp7mpQLNMuWE1ztXt3I54KFHlYNvHVC4AHhBNanzFdemT5w+k0ovA==
X-Received: by 2002:a17:90b:134b:b0:32d:db5b:7636 with SMTP id 98e67ed59e1d1-3403a28efb0mr2855484a91.27.1761737223563;
        Wed, 29 Oct 2025 04:27:03 -0700 (PDT)
Received: from ventana-desktop.localhost ([2405:201:d019:c0ce:f7f5:7789:48e5:c03f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7f6040sm15316918a91.16.2025.10.29.04.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:27:03 -0700 (PDT)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-efi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	ardb@kernel.org,
	conor@kernel.org,
	cleger@rivosinc.com,
	robert.moore@intel.com,
	sunilvl@ventanamicro.com,
	apatel@ventanamicro.com,
	Himanshu Chauhan <hchauhan@ventanamicro.com>
Subject: [RFC PATCH v2 00/10] Add RAS support for RISC-V architecture
Date: Wed, 29 Oct 2025 16:56:38 +0530
Message-ID: <20251029112649.3811657-1-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
[1] RERI Specification: https://github.com/riscv-non-isa/riscv-ras-eri/releases/download/v1.0/riscv-reri.pdf
[2] SSE Section in OpenSBI v3.0: https://github.com/riscv-non-isa/riscv-sbi-doc/releases/download/v3.0/riscv-sbi.pdf
[3] Qemu source (with RERI emulation support): https://github.com/ventanamicro/qemu.git (branch: dev-upstream)
[4] EDK2: https://github.com/ventanamicro/edk2.git (branch: dev-upstream)
[5] SSE Kernel Patches (v7): https://lore.kernel.org/all/20250908181717.1997461-1-cleger@rivosinc.com/

Changes in v2:
 - Made changes to be conformant with SSE v7 patches
 - Fixed some bot warnings

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
 drivers/acpi/apei/ghes.c               | 103 +++++++++++++++--
 drivers/firmware/efi/cper.c            |   3 +
 drivers/firmware/riscv/riscv_sbi_sse.c | 147 +++++++++++++++++++++++++
 include/acpi/actbl1.h                  |   3 +-
 include/linux/riscv_sbi_sse.h          |  16 +++
 11 files changed, 300 insertions(+), 12 deletions(-)

-- 
2.43.0

