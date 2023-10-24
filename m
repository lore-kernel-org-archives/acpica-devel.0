Return-Path: <rjwysocki@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4C817430B8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6C55F405C7
MIME-Version: 1.0
References: <20231024062018.23839-1-raag.jadav@intel.com>
 <20231024093010.GF3208943@black.fi.intel.com>
In-Reply-To: <20231024093010.GF3208943@black.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 24 Oct 2023 21:51:08 +0200
Message-ID: <CAJZ5v0hLYcN_CxUOocKoN8EsQTwyL-sLbWENfFaQ+f3fjHRvqw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Raag Jadav <raag.jadav@intel.com>
Cc: mark.rutland@arm.com, len.brown@intel.com, linux-hwmon@vger.kernel.org, linux-gpio@vger.kernel.org, mallikarjunappa.sangannavar@intel.com, robert.moore@intel.com, bala.senthil@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jonathan.Cameron@huawei.com, acpica-devel@lists.linuxfoundation.org, andriy.shevchenko@linux.intel.com, will@kernel.org, linux@roeck-us.net

On Tue, Oct 24, 2023 at 11:30=E2=80=AFAM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Tue, Oct 24, 2023 at 11:50:12AM +0530, Raag Jadav wrote:
> > This series refines _UID references across kernel by:
> >
> > - Extracting _UID matching functionality from acpi_dev_hid_uid_match()
> >   helper and introducing it as a separate acpi_dev_uid_match() helper.
> >
> > - Converting manual _UID references to use the standard ACPI helpers.
> >
> > Changes since v2:
> > - Drop review tags as suggested by Andy.
> >
> > Changes since v1:
> > - Change acpi_dev_uid_match() to return false in case of NULL argument.
> > - Drop accepted patches.
> >
> > Raag Jadav (6):
> >   ACPI: utils: Introduce acpi_dev_uid_match() for matching _UID
> >   pinctrl: intel: use acpi_dev_uid_match() for matching _UID
> >   ACPI: utils: use acpi_dev_uid_match() for matching _UID
> >   ACPI: x86: use acpi_dev_uid_match() for matching _UID
> >   hwmon: nct6775: use acpi_dev_hid_uid_match() for matching _HID and
> >     _UID
> >   perf: arm_cspmu: use acpi_dev_hid_uid_match() for matching _HID and
> >     _UID
>
> For the series,
>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>
> >  drivers/acpi/utils.c                  | 34 ++++++++++++++++++++++-----
> >  drivers/acpi/x86/utils.c              |  3 +--
> >  drivers/hwmon/nct6775-platform.c      |  4 +---
> >  drivers/perf/arm_cspmu/arm_cspmu.c    |  8 +++----
> >  drivers/pinctrl/intel/pinctrl-intel.c |  2 +-
>
> This pinctrl one is also fine by me so if Andy does not have objections,
> feel free to add my,
>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Whole series applied as 6.7 material with tags as per the above, thanks!
