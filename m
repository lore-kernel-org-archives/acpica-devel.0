Return-Path: <raag.jadav@intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 99F976F7BC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8AAF96F7B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698128438; x=1729664438;
 h=from:to:cc:subject:date:message-id;
 bh=6u6XekGST951M7tNhGalGj6hn+WiLeARLcL22/cN7BU=;
 b=Gi61zR0ogklQ576kt4jcILUDH0jXY88L/2Skh8wODnSEaQeZV4mw7OFR
 fJIXtvhV6M13Co/PLLzahOLfzUzCYJN1/Fgl6CqdCLfpVxd0n+Tutcrox
 7h6A4UBPYaILyEEKtV3NIgP+xxp9e7Fw/PR5YcZIWBjNNOIdK7azHYSoC
 etZr2fGTgy4W3cvoPjNBEOfXYwm8OignAAXHjb554dS9Io8l11iKu6Luk
 SQh59FUjTyLEGg9BoPMM+F4ewrfcvWyeNspbaomvQcFfseXxwjx3GsAcj
 /2iKGrp9qn335H72uYmxQhyHqj2I5Vj36AyQi0V+eZkTTitJh9tzUlSQd w==;
From: Raag Jadav <raag.jadav@intel.com>
Date: Tue, 24 Oct 2023 11:50:12 +0530
Message-Id: <20231024062018.23839-1-raag.jadav@intel.com>
Subject: [Acpica-devel] [PATCH v3 0/6] Refine _UID references across kernel
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
To: rafael@kernel.org, len.brown@intel.com, robert.moore@intel.com, mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com, mark.rutland@arm.com, will@kernel.org, linux@roeck-us.net, Jonathan.Cameron@Huawei.com
Cc: linux-hwmon@vger.kernel.org, linux-gpio@vger.kernel.org, Raag Jadav <raag.jadav@intel.com>, mallikarjunappa.sangannavar@intel.com, linux-kernel@vger.kernel.org, bala.senthil@intel.com, linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, linux-arm-kernel@lists.infradead.org

This series refines _UID references across kernel by:

- Extracting _UID matching functionality from acpi_dev_hid_uid_match()
  helper and introducing it as a separate acpi_dev_uid_match() helper.

- Converting manual _UID references to use the standard ACPI helpers.

Changes since v2:
- Drop review tags as suggested by Andy.

Changes since v1:
- Change acpi_dev_uid_match() to return false in case of NULL argument.
- Drop accepted patches.

Raag Jadav (6):
  ACPI: utils: Introduce acpi_dev_uid_match() for matching _UID
  pinctrl: intel: use acpi_dev_uid_match() for matching _UID
  ACPI: utils: use acpi_dev_uid_match() for matching _UID
  ACPI: x86: use acpi_dev_uid_match() for matching _UID
  hwmon: nct6775: use acpi_dev_hid_uid_match() for matching _HID and
    _UID
  perf: arm_cspmu: use acpi_dev_hid_uid_match() for matching _HID and
    _UID

 drivers/acpi/utils.c                  | 34 ++++++++++++++++++++++-----
 drivers/acpi/x86/utils.c              |  3 +--
 drivers/hwmon/nct6775-platform.c      |  4 +---
 drivers/perf/arm_cspmu/arm_cspmu.c    |  8 +++----
 drivers/pinctrl/intel/pinctrl-intel.c |  2 +-
 include/acpi/acpi_bus.h               |  1 +
 include/linux/acpi.h                  |  5 ++++
 7 files changed, 40 insertions(+), 17 deletions(-)


base-commit: a4ed5bffbeb19cfb7e21ac3b3f09d7bfe39a849b
-- 
2.17.1

