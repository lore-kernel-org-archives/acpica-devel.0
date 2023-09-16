Return-Path: <xueshuai@linux.alibaba.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3552B4031F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DAA8240235
From: Shuai Xue <xueshuai@linux.alibaba.com>
Message-Id: <20230916130316.65815-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Acpica-devel] [RFC PATCH 0/9] [RFC PATCH 0/9] Use ERST for
	persistent storage of MCE and APEI errors
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Sat, 16 Sep 2023 13:03:30 -0000
To: keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com, rafael@kernel.org, lenb@kernel.org, james.morse@arm.com, bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, ardb@kernel.org, robert.moore@intel.com
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-hardening@vger.kernel.org, baolin.wang@linux.alibaba.com, xueshuai@linux.alibaba.com, acpica-devel@lists.linuxfoundation.org, linux-edac@vger.kernel.org

In certain scenarios (ie. hosts/guests with root filesystems on NFS/iSCSI
where networking software and/or hardware fails, and thus kdump fails), it
is necessary to serialize hardware error information available for
post-mortem debugging. Save the hardware error log into flash via ERST
before go panic, the hardware error log can be gotten from the flash after
system boot successful again, which is very useful in production.

On X86 platform, the kernel has supported to serialize and deserialize MCE
error record by commit 482908b49ebf ("ACPI, APEI, Use ERST for persistent
storage of MCE"). The process involves two steps:

- MCE Producer: When a hardware error is detected, MCE raised and its
  handler writes MCE error record into flash via ERST before panic
- MCE Consumor: After system reboot, /sbin/mcelog run, it reads /dev/mcelog
  to check flash for error record of previous boot via ERST

After /dev/mcelog character device deprecated by commit 5de97c9f6d85
("x86/mce: Factor out and deprecate the /dev/mcelog driver"), the
serialized MCE error record, of previous boot in persistent storage is not
collected via APEI ERST.

This patch set include two part:

- PATCH 1-3: rework apei_{read,write}_mce to use pstore data structure and emit
  the mce_record tracepoint, enabling the collection of MCE records by the
  rasdaemon tool.
- PATCH 4-9: use ERST for persistent storage of APEI errors, and emit
  tracepoints for CPER sections, enabling the collection of MCE records by the
  rasdaemon tool.

Shuai Xue (9):
  pstore: move pstore creator id, section type and record struct to
    common header
  ACPI: APEI: Use common ERST struct to read/write serialized MCE record
  ACPI: APEI: ERST: Emit the mce_record tracepoint
  ACPI: tables: change section_type of generic error data as guid_t
  ACPI: APEI: GHES: Use ERST to serialize APEI generic error before
    panic
  ACPI: APEI: GHES: export ghes_report_chain
  ACPI: APEI: ESRT: kick ghes_report_chain notifier to report serialized
    memory errors
  ACPI: APEI: ESRT: print AER to report serialized PCIe errors
  ACPI: APEI: ESRT: log ARM processor error

 arch/x86/kernel/cpu/mce/apei.c | 82 +++++++++++++++-------------------
 drivers/acpi/acpi_extlog.c     |  2 +-
 drivers/acpi/apei/erst.c       | 51 ++++++++++++---------
 drivers/acpi/apei/ghes.c       | 48 +++++++++++++++++++-
 drivers/firmware/efi/cper.c    |  2 +-
 fs/pstore/platform.c           |  3 ++
 include/acpi/actbl1.h          |  5 ++-
 include/acpi/ghes.h            |  2 +-
 include/linux/pstore.h         | 29 ++++++++++++
 9 files changed, 150 insertions(+), 74 deletions(-)

-- 
2.41.0

