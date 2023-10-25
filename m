Return-Path: <rjwysocki@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 35F1B84844
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 69489847F3
MIME-Version: 1.0
References: <20231024062018.23839-1-raag.jadav@intel.com>
 <20231024093010.GF3208943@black.fi.intel.com>
 <CAJZ5v0hLYcN_CxUOocKoN8EsQTwyL-sLbWENfFaQ+f3fjHRvqw@mail.gmail.com>
 <16cf6c19-20d2-4d11-80b1-b8e3c7e58803@roeck-us.net>
In-Reply-To: <16cf6c19-20d2-4d11-80b1-b8e3c7e58803@roeck-us.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 25 Oct 2023 13:32:28 +0200
Message-ID: <CAJZ5v0ge6_GK6DXcWM-OkjRszxBbPx+ArW76S8W9pf=YOzGyPQ@mail.gmail.com>
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
To: Guenter Roeck <linux@roeck-us.net>
Cc: mark.rutland@arm.com, len.brown@intel.com, linux-hwmon@vger.kernel.org, will@kernel.org, linux-gpio@vger.kernel.org, Raag Jadav <raag.jadav@intel.com>, robert.moore@intel.com, bala.senthil@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Jonathan.Cameron@huawei.com, mallikarjunappa.sangannavar@intel.com, acpica-devel@lists.linuxfoundation.org, andriy.shevchenko@linux.intel.com, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-arm-kernel@lists.infradead.org

On Wed, Oct 25, 2023 at 4:05=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On Tue, Oct 24, 2023 at 09:51:08PM +0200, Rafael J. Wysocki wrote:
> > On Tue, Oct 24, 2023 at 11:30=E2=80=AFAM Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> > >
> > > On Tue, Oct 24, 2023 at 11:50:12AM +0530, Raag Jadav wrote:
> > > > This series refines _UID references across kernel by:
> > > >
> > > > - Extracting _UID matching functionality from acpi_dev_hid_uid_matc=
h()
> > > >   helper and introducing it as a separate acpi_dev_uid_match() help=
er.
> > > >
> > > > - Converting manual _UID references to use the standard ACPI helper=
s.
> > > >
> > > > Changes since v2:
> > > > - Drop review tags as suggested by Andy.
> > > >
> > > > Changes since v1:
> > > > - Change acpi_dev_uid_match() to return false in case of NULL argum=
ent.
> > > > - Drop accepted patches.
> > > >
> > > > Raag Jadav (6):
> > > >   ACPI: utils: Introduce acpi_dev_uid_match() for matching _UID
> > > >   pinctrl: intel: use acpi_dev_uid_match() for matching _UID
> > > >   ACPI: utils: use acpi_dev_uid_match() for matching _UID
> > > >   ACPI: x86: use acpi_dev_uid_match() for matching _UID
> > > >   hwmon: nct6775: use acpi_dev_hid_uid_match() for matching _HID an=
d
> > > >     _UID
> > > >   perf: arm_cspmu: use acpi_dev_hid_uid_match() for matching _HID a=
nd
> > > >     _UID
> > >
> > > For the series,
> > >
> > > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > >
> > > >  drivers/acpi/utils.c                  | 34 ++++++++++++++++++++++-=
----
> > > >  drivers/acpi/x86/utils.c              |  3 +--
> > > >  drivers/hwmon/nct6775-platform.c      |  4 +---
> > > >  drivers/perf/arm_cspmu/arm_cspmu.c    |  8 +++----
> > > >  drivers/pinctrl/intel/pinctrl-intel.c |  2 +-
> > >
> > > This pinctrl one is also fine by me so if Andy does not have objectio=
ns,
> > > feel free to add my,
> > >
> > > Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> >
> > Whole series applied as 6.7 material with tags as per the above, thanks=
!
>
> Ok, that means I will _not_ apply the hwmon patch through
> the hwmon tree.
>
> FWIW, please note that I would have very much preferred applying
> it through the hwmon tree, and I did _not_ Ack it.

OK, I'll drop it now and please feel free to pick it up (whenever it
is convenient to do so), or if you'd rather let me carry it, please
let me know.

It's only been in my bleeding-edge branch so far.
