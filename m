Return-Path: <mika.westerberg@linux.intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 021F483F2C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4BE9F83F21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698139817; x=1729675817;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=mSD40iH+sPX+DrU5ENcXUhxksvpVp9Sfw5JZjf5AJFA=;
 b=AuWZOgjVLErxBuXTTLy1PkWq1YJ5c00mCOyzLJo4Zlw1Eqto3NjlaBNp
 yfWkMpPMMILsuCtlYBoW9atIgWVXGsNcTvm+jTsmIlcEI5d7b6DmBcE5Z
 mrLxzKpYRWr71jE8Nc6jQ8GfFw1VV8hcZ8svhfikdkm+Z5UqboCwR3AtT
 L5erIOd8GKyjr8fE2oSHpDbXcw407FxjB0yG8Pcv8oAHBrfgpUU4PlXRj
 kiIEQF5Ic3ph77AEvQfFFRKSmQDt97I2mu99jZGrQ0N1ik5hbqdYjUkU9
 f+J3RTtRejb8hd/mJb0Oar0UIv8pBbpO0sgyx4kIT6smzqDKhsNBUMzVv A==;
Date: Tue, 24 Oct 2023 12:30:10 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
Message-ID: <20231024093010.GF3208943@black.fi.intel.com>
References: <20231024062018.23839-1-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231024062018.23839-1-raag.jadav@intel.com>
Subject: Re: [Acpica-devel] [PATCH v3 0/6] Refine _UID references across
	kernel
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
To: Raag Jadav <raag.jadav@intel.com>
Cc: mark.rutland@arm.com, len.brown@intel.com, linux-hwmon@vger.kernel.org, linux-gpio@vger.kernel.org, mallikarjunappa.sangannavar@intel.com, robert.moore@intel.com, bala.senthil@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jonathan.Cameron@huawei.com, acpica-devel@lists.linuxfoundation.org, andriy.shevchenko@linux.intel.com, will@kernel.org, linux@roeck-us.net

On Tue, Oct 24, 2023 at 11:50:12AM +0530, Raag Jadav wrote:
> This series refines _UID references across kernel by:
> 
> - Extracting _UID matching functionality from acpi_dev_hid_uid_match()
>   helper and introducing it as a separate acpi_dev_uid_match() helper.
> 
> - Converting manual _UID references to use the standard ACPI helpers.
> 
> Changes since v2:
> - Drop review tags as suggested by Andy.
> 
> Changes since v1:
> - Change acpi_dev_uid_match() to return false in case of NULL argument.
> - Drop accepted patches.
> 
> Raag Jadav (6):
>   ACPI: utils: Introduce acpi_dev_uid_match() for matching _UID
>   pinctrl: intel: use acpi_dev_uid_match() for matching _UID
>   ACPI: utils: use acpi_dev_uid_match() for matching _UID
>   ACPI: x86: use acpi_dev_uid_match() for matching _UID
>   hwmon: nct6775: use acpi_dev_hid_uid_match() for matching _HID and
>     _UID
>   perf: arm_cspmu: use acpi_dev_hid_uid_match() for matching _HID and
>     _UID

For the series,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

>  drivers/acpi/utils.c                  | 34 ++++++++++++++++++++++-----
>  drivers/acpi/x86/utils.c              |  3 +--
>  drivers/hwmon/nct6775-platform.c      |  4 +---
>  drivers/perf/arm_cspmu/arm_cspmu.c    |  8 +++----
>  drivers/pinctrl/intel/pinctrl-intel.c |  2 +-

This pinctrl one is also fine by me so if Andy does not have objections,
feel free to add my,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

>  include/acpi/acpi_bus.h               |  1 +
>  include/linux/acpi.h                  |  5 ++++
>  7 files changed, 40 insertions(+), 17 deletions(-)
> 
> 
> base-commit: a4ed5bffbeb19cfb7e21ac3b3f09d7bfe39a849b
> -- 
> 2.17.1
