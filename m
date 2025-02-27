Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C563B22F3AB
	for <acpica-devel@lists.linux.dev>; Thu, 27 Feb 2025 12:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740659801; cv=none; b=NyTibfOaCz8vdlhct4F8w2uT00G/FjNyNA3FCiAAb3aAmzIsbzb0GhIliT8VvQ3DGrTKxAsX8XRwm4sGg4LKeWV7vB+phmSp3w+uyKr+pVxN8ZqdBdIapzqg9ppgYZVfIP1ZR+W6WQZ/pHF10riMMI1gO6XqqVVNypoO/vH8aWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740659801; c=relaxed/simple;
	bh=jVNWxl4WmX/uXUCzIy5O6n0LejX0fZ69NtkSB8CPtZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C5DeqSPJJPyFfeYDR1BQp3bePYBKi9RdYnmFzkkj2agbMO3qsKbs/1OqJ42NOZ/mfWJFWSukd5j3ZWBVea34E7LXmfgG601YOJqyNo5GU2DE+Xi28bA5OPn47DGUC502ICHHTaYnDEWolRNO9xDOLnA/gAXV0hKLBOcFKUXz84E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ITuKS7DY; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ITuKS7DY"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2233622fdffso15879485ad.2
        for <acpica-devel@lists.linux.dev>; Thu, 27 Feb 2025 04:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1740659799; x=1741264599; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xtME809Eew76HgNd2VZgiOyw7ntFEPKx2r2sqfXdyNY=;
        b=ITuKS7DY8aZacO/b1SKrnp9hNVy0igaRNwdfNuFwcZ5tINUx1HJl/vjRt6HkCXo++7
         QRYrbw80UoRXUal4r1tqv95wTDsqz92Tg+VsBMSH9Fu8zQn5r+lYh6xRIqjoDfNfeG0P
         0MgRVlsLyzzC2CIKC9Nv3UKmv+uCvCVZagPtgzf/SG8Cty4NMO5JJpHxMXPHsA6rTZ8a
         ur4uAvLYeDO6gSU44vpYnNwr5fNgSnRbOjjwp3ip8wOulZaz0O0XI21ovx7SFwXlu4z5
         E0ilni8XvAQxPs6fE+WIggIfOrUr7Sz/hM0oFR24/8NMWmrzZK8Vq2v6X40zt5PbOP6H
         vtSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740659799; x=1741264599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xtME809Eew76HgNd2VZgiOyw7ntFEPKx2r2sqfXdyNY=;
        b=DYuaewR0dAGbNpwFke9/5+RCg//CM1vUAInBIbq6oW9h7ICTq3Jhakg/Tu9CFmm7EZ
         XmSXVeb4waHIJFeE3UcqCoqYF2rofTrDKd9/ek8TMg1bsYGUYt36vpSU/MbmPuCfvCxJ
         X6WuoFoA0Sa5t+NW5xs3uCVMPxujw+RCR6xc22pl0MQe4kS1dLvgU/+ahgUQkQQZx/aj
         +yjJqYtqxyrp/maQ9jXBHjT9kOyuKat55ekv/FiDWh+eb0ZFo/+i51DaYP+6hJ/HLaR+
         tt0wwI0Y9mixrSoJXz3hAQinwA1GwkBGlecycBTl+BP1+ppqA37rXAgTadgq8DUATf3I
         Qz8A==
X-Forwarded-Encrypted: i=1; AJvYcCUiFCem0JLIVuUx5ufRSueOXwMVbuIyuF10MmGJNef7foPVuGWOtk0cT7Al+Wfs7gcrDi8wG64Bq1kCDpM=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz0e3ULbk2muceVPqkDtdpjMUw/cUPIOLQGJas2BeCpGM3cOgmE
	dSfbnped8GUXWae6rar0tDTFFSktK3H2zVJyz3pm3jDVohQ2E8iJUJZ2/WMMTIU=
X-Gm-Gg: ASbGnculKNSgUjsSIMP2sHh0i4RLkDLSRPpATDtkDJBJCe6aLsZhKc51NSWQUkQB0IU
	SVRfatY5ij1xEc2Xdy3F3yq0bjQn1H/KW5o+GI7hCSdQW1XRcmuFTOx/CCgCqdqqNKbr6qhktTq
	LbU05uye9kOc5FbrG8YkuSf1SoDQnCAIwo3BlOj7H7exRuUAHPawt/vYgnMOQEaZd2VRBrgFE34
	sfRI0rGT1qaV/Fh5MSZh7FMUCALbseoFxeXt0ABZcf37v4uimnKXk3Je+qGtcGrXJ65hzBoDEIr
	sfIJiBvg0jq3RyP6yqHvQGz2h2ByzGHH8tWR
X-Google-Smtp-Source: AGHT+IH56tY+4vK57WuCNQiVCZOgB7TNFoVCq9IHBAMlZTCbUrlVJLG7r/B7T96EdJnPgpthhW1GjA==
X-Received: by 2002:a17:902:ecd0:b0:21f:542e:dd0a with SMTP id d9443c01a7336-22307e6586fmr197711655ad.41.1740659799030;
        Thu, 27 Feb 2025 04:36:39 -0800 (PST)
Received: from ventana-bhyve.. ([49.37.249.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5bddsm13219135ad.140.2025.02.27.04.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:36:38 -0800 (PST)
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
Subject: [RFC PATCH v1 00/10] Add RAS support for RISC-V architecture
Date: Thu, 27 Feb 2025 18:06:18 +0530
Message-ID: <20250227123628.2931490-1-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series implements the RAS (Reliability, Availability and Serviceability)
support for RISC-V architecture using RISC-V RERI specification. It is conformant
to ACPI platform error interfaces (APEI). It uses the highest priority
Supervisor Software Events (SSE)[2] to deliver the hardware error events to the kernel.
The SSE implemetation has already been merged in OpenSBI. Clement has sent a patch series for
its implemenation in Linux kernel.[5]

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
[2] SSE Section in OpenSBI v3.0: https://github.com/riscv-non-isa/riscv-sbi-doc/releases/download/v3.0-rc3/riscv-sbi.pdf
[3] Qemu source (with RERI emulation support): https://github.com/ventanamicro/qemu.git (branch: dev-upstream)
[4] EDK2: https://github.com/ventanamicro/edk2.git (branch: dev-upstream)
[5] SSE Kernel Patches: https://lore.kernel.org/linux-riscv/649fdead-09b0-4f94-a6ff-099fc970d890@rivosinc.com/T/

Himanshu Chauhan (10):
  riscv: Define ioremap_cache for RISC-V
  riscv: Define arch_apei_get_mem_attribute for RISC-V
  acpi: Introduce SSE in HEST notification types
  riscv: Add fixmap indices for GHES IRQ and SSE contexts
  riscv: conditionally compile GHES NMI spool function
  riscv: Add functions to register ghes having SSE notification
  riscv: Add RISC-V entries in processor type and ISA strings
  riscv: Introduce HEST SSE notification handlers
  riscv: Add config option to enable APEI SSE handler
  riscv: Enable APEI and NMI safe cmpxchg options required for RAS

 arch/riscv/Kconfig                 |   2 +
 arch/riscv/include/asm/acpi.h      |  20 ++++
 arch/riscv/include/asm/fixmap.h    |   8 ++
 arch/riscv/include/asm/io.h        |   3 +
 drivers/acpi/apei/Kconfig          |   5 +
 drivers/acpi/apei/ghes.c           | 102 +++++++++++++++++---
 drivers/firmware/efi/cper.c        |   3 +
 drivers/firmware/riscv/riscv_sse.c | 147 +++++++++++++++++++++++++++++
 include/acpi/actbl1.h              |   3 +-
 include/linux/riscv_sse.h          |  15 +++
 10 files changed, 296 insertions(+), 12 deletions(-)

-- 
2.43.0

