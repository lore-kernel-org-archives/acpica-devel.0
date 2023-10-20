Return-Path: <raag.jadav@intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 35F2161001
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6DE8560EE4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697791691; x=1729327691;
 h=from:to:cc:subject:date:message-id;
 bh=55kFwQ1dJ+2JNO1s52sQQCyE+DnzabG8i8c9Ir2rEwI=;
 b=VZ30RWDAkS7fYu6q6OSjIMWgi9LVUvJPkfAq0pbtGxSPsAoJoo84guA3
 N3mqpN0RJXYtMBcbbG3DPgJTLilhdFt2fAGzTpPIk2uf0bIx5ka9ZaIjw
 YgfUgqerV1mEIxppy2gcfzSI2FtiGZDoDAKfY1A8bxNPkhjfCAgpre8BW
 tIYqd8yVSx1hfBalw5vBWSojnmL48dN2o9LD4RfZA5YA8LMIF1QY7xH3w
 uqUQ+je+WD4EjEF+rvN0nbpgD9tepX5/M1hMm24Y7KYYnlw44mJJ2d2F6
 SyCQ0sYSc2z82IYUQdNfw28CIIA1evboXbNNVYmf73X9dPI2GqeLl+3Qq Q==;
From: Raag Jadav <raag.jadav@intel.com>
Date: Fri, 20 Oct 2023 14:17:24 +0530
Message-Id: <20231020084732.17130-1-raag.jadav@intel.com>
Subject: [Acpica-devel] [PATCH v1 0/8] Refine _UID references across kernel
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
To: rafael@kernel.org, len.brown@intel.com, robert.moore@intel.com, mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com, mark.rutland@arm.com, will@kernel.org, linux@roeck-us.net
Cc: linux-hwmon@vger.kernel.org, linux-gpio@vger.kernel.org, Raag Jadav <raag.jadav@intel.com>, mallikarjunappa.sangannavar@intel.com, linux-kernel@vger.kernel.org, bala.senthil@intel.com, linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, linux-arm-kernel@lists.infradead.org

This series refines _UID references across kernel by:

- Extracting _UID matching functionality from acpi_dev_hid_uid_match()
  helper and introducing it as a separate acpi_dev_uid_match() helper.

- Converting manual _UID references to use standard ACPI helpers.

Raag Jadav (8):
  ACPI: utils: Introduce acpi_dev_uid_match() for matching _UID
  pinctrl: intel: use acpi_dev_uid_match() for matching _UID
  ACPI: sysfs: use acpi_device_uid() for fetching _UID
  ACPI: utils: use acpi_dev_uid_match() for matching _UID
  ACPI: x86: use acpi_dev_uid_match() for matching _UID
  perf: qcom: use acpi_device_uid() for fetching _UID
  hwmon: nct6775: use acpi_dev_hid_uid_match() for matching _HID and
    _UID
  perf: arm_cspmu: use acpi_dev_hid_uid_match() for matching _HID and
    _UID

 drivers/acpi/device_sysfs.c           |  6 ++--
 drivers/acpi/utils.c                  | 43 +++++++++++++++++++++------
 drivers/acpi/x86/utils.c              |  3 +-
 drivers/hwmon/nct6775-platform.c      |  4 +--
 drivers/perf/arm_cspmu/arm_cspmu.c    |  8 ++---
 drivers/perf/qcom_l3_pmu.c            |  4 +--
 drivers/pinctrl/intel/pinctrl-intel.c |  2 +-
 include/acpi/acpi_bus.h               |  1 +
 include/linux/acpi.h                  |  5 ++++
 9 files changed, 51 insertions(+), 25 deletions(-)


base-commit: 9bc2fb9a7e41542a193658deff3df572fa24cb68
-- 
2.17.1

