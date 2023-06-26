Return-Path: <andriy.shevchenko@linux.intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F2C354099A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 25228409BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687777222; x=1719313222;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=4I4jFx9s8H+UCd6OuK/ZZ1rbZacxqwP2cPh7/sdpD38=;
 b=dEo8XuSyohYh5XSa0ryYoJnYApMi+r4O6nQeAVCE3w0VCvex6Ww57BNF
 AVIyR71AJz+wsjM0YmSH9qKsqb9Pz1Qze3Rjv7N/loHuU+wmS9/Vcd5Ut
 X8+PRIKFO4IJQs+ihevW9E1kv6mfZaEFISjAQKi8KErM7vhzOyHKDNmEV
 nsAMp0qc3s4LUB4py9GqDLmiU9BJRn4U9YvHOzszrC4sc2yO1abVIACL1
 9FVMh1z3aQG82stpVHpMrj9O8YYc6zcFcNeeXhmUGGdtsYNyUKYNUA6xZ
 rr7RtXxFMOIayLkYYl8PHh6p8k9M4h4wv0ZYLmIw7ntyY2pcHIwqH3SUh g==;
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Message-Id: <20230626110026.65825-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Acpica-devel] [PATCH v3 0/4] ACPI: platform: Fix SMB0001
	enumeration on Kontron devices
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Mon, 26 Jun 2023 11:00:24 -0000
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, acpica-devel@lists.linuxfoundation.org
Cc: Robert Moore <robert.moore@intel.com>, Michael Walle <michael@walle.cc>, Len Brown <lenb@kernel.org>, Andi Shyti <andi.shyti@kernel.org>

After switching i2c-scmi driver to be a plaform one, it stopped
being enumerated on number of Kontron platforms, because it's
listed in the forbidden_id_list.

To resolve the situation, add a flag and count the resources of the
forbiden device. If the count is non-zero, the device must be skipped.

Changelog v3:
- provided completely rewritten solution (Rafael)
- due to above, added two new patches
- due to above, dropped tags from patch 3

Andy Shevchenko (4):
  ACPI: bus: Constify acpi_companion_match() returned value
  ACPI: bus: Introduce acpi_match_acpi_device() helper
  ACPI: platform: Ignore SMB0001 only when it has resources
  ACPI: platform: Move SMB0001 HID to the header and reuse

 drivers/acpi/acpi_platform.c  | 31 +++++++++++++++++++++++++++----
 drivers/acpi/bus.c            | 21 ++++++++++++++-------
 drivers/acpi/device_sysfs.c   |  2 +-
 drivers/acpi/internal.h       |  2 +-
 drivers/i2c/busses/i2c-scmi.c |  3 ---
 include/acpi/acpi_drivers.h   |  2 ++
 include/linux/acpi.h          |  9 +++++++++
 7 files changed, 54 insertions(+), 16 deletions(-)

-- 
2.40.0.1.gaa8946217a0b

