Return-Path: <raag.jadav@intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0CE384020B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 134CB40146
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698039384; x=1729575384;
 h=from:to:cc:subject:date:message-id;
 bh=A+HHnsIqeJDnLwMTstSYgBGn2R5+0SVjEsJpoHcWuWs=;
 b=WNkX67jBnpTEX7/I4NAluRTOfIiMnySR9MK9znHaWu2wYRpVnu4gjzU1
 n2apnufqvv1kBGOOtfdlY6I22/O4HROfl1qPDWmIcYGEXumqLmeTS06H+
 pAEFi/cUQzjgmW+qXYi9re/cyxA6sJp0SAM3JfgOJa/KcPIOegepw51T9
 yvENWiJu8S3mx6MPnhAQvzP4K8G+QjmwQiW5VeGf3fydlAaaTAB2Gh2gI
 VtCnAhlJDLAdaTM2ATUEiuS5IXzt1XaKqPLylsDLgRMEcmv6VsPnoDa36
 yDbSgvaisieQTXrCAvP30QJG0Fm28WMkGWO9ByNRFpypV3qckOjzW1HxG g==;
From: Raag Jadav <raag.jadav@intel.com>
Date: Mon, 23 Oct 2023 11:05:24 +0530
Message-Id: <20231023053530.5525-1-raag.jadav@intel.com>
Subject: [Acpica-devel] [PATCH v2 0/6] Refine _UID references across kernel
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


base-commit: 64b6555f2fe6b43fb6782aa3e2cbb34bfe39047d
-- 
2.17.1

