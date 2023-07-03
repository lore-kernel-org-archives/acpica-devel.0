Return-Path: <andriy.shevchenko@linux.intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2A325405FA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6398640565
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688386454; x=1719922454;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=B+0o99RwmPnmItgZGhKKF+qA0QI/Xs8dXHq+Uwdmz44=;
 b=IOR+gha1pn9VnQd0SPSR1CY8yb2zoMzOSvJJiA/jrVYbJ+yg3SjcgyYt
 nokOmOLKKOQhfSHsvau2rQQgRstoUFOItqVymoTMFnjK4SCaYUtgCzljN
 AMuSn0u+ExDqt/h+qY96a9BnQBLXmAYi2rEmPPlmAsJ491Q2WsHskWZlZ
 2LK0G6WQrc/VPQvuPKkBZ22J+EhWTCJz9YPOmnXJPoofdBwziWt2VCpJf
 P/g6Tm9hWQ9citFv+6Rlute523G8RH1r1EVvSdqbs5Zu2Fo3To2AkkFqF
 4SPnmTrt2I9W1nywgOWQ2Manml1ToJH+/z/3TyrKqm4aTfCUOZGVnL665 w==;
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Message-Id: <20230703121411.69606-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Acpica-devel] [PATCH v4 0/5] ACPI: platform: Fix SMB0001
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
Date: Mon, 03 Jul 2023 12:14:15 -0000
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Wolfram Sang <wsa@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, acpica-devel@lists.linuxfoundation.org
Cc: Michael Walle <michael@walle.cc>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>

After switching i2c-scmi driver to be a plaform one, it stopped
being enumerated on number of Kontron platforms, because it's
listed in the forbidden_id_list.

To resolve the situation, add a flag and check if there are resources
privided for the forbiden device. If it is the case, the device must
be skipped.

Changelog v4:
- dropped applied patch
- added kernel doc for new helper (Rafael)
- rewritten the commit message for the reason of a new helper (Rafael)
- added a couple of patches for ACPI scan.c that can be applied later on

Changelog v3:
- provided completely rewritten solution (Rafael)
- due to above, added two new patches
- due to above, dropped tags from patch 3

Andy Shevchenko (5):
  ACPI: bus: Introduce acpi_match_acpi_device() helper
  ACPI: platform: Ignore SMB0001 only when it has resources
  ACPI: platform: Move SMB0001 HID to the header and reuse
  ACPI: scan: Use the acpi_match_acpi_device() helper
  ACPI: scan: Provide symbol declarations

 drivers/acpi/acpi_platform.c  | 30 +++++++++++++++++++++++++++---
 drivers/acpi/bus.c            | 25 +++++++++++++++++++++----
 drivers/acpi/scan.c           | 22 +++++++++++++---------
 drivers/i2c/busses/i2c-scmi.c |  3 ---
 include/acpi/acpi_drivers.h   |  2 ++
 include/linux/acpi.h          |  9 +++++++++
 6 files changed, 72 insertions(+), 19 deletions(-)

-- 
2.40.0.1.gaa8946217a0b

