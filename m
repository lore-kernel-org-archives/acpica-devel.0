Return-Path: <groeck7@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5ED2A706B1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 65A317064D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698199510; x=1698804310;
 darn=lists.linuxfoundation.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:sender
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WbdytW0refUglybCsXX0Y9h8CNgKWOlTE2eFIrGTl4M=;
 b=EvBys5XUEycFNT7LTzBn8GQ56/Ele3GkIBqQDcdrKO+h5MUcDuW1kfNoPxmgsq7bA9
 ZXApAv1T02HxQTM20JYPSNPjDL3pZK/ujHb6tolZvY8Qojnreg032vqGIkgpS79PWEn/
 5b700MihlqVliya7a90X2QKBl/0JhS1IyC4myrPneKNt5h8h0qz7KLY/9Tu3vwtqyfFW
 I7xFfrAmFWgjx1xOkdAighgA5tDAXtp1ln8RpYK7i8prDtHTfQhDi6YgmMN+r3Uyl8Zo
 kDEI2vNq1SL6vpW9Sc1RGFdtqFWmq10FOJtO+Ukq6Io9wD4Ot9wnbubOlc/8RZCbS9g6
 IwFA==
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 24 Oct 2023 19:05:08 -0700
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <16cf6c19-20d2-4d11-80b1-b8e3c7e58803@roeck-us.net>
References: <20231024062018.23839-1-raag.jadav@intel.com>
 <20231024093010.GF3208943@black.fi.intel.com>
 <CAJZ5v0hLYcN_CxUOocKoN8EsQTwyL-sLbWENfFaQ+f3fjHRvqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hLYcN_CxUOocKoN8EsQTwyL-sLbWENfFaQ+f3fjHRvqw@mail.gmail.com>
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
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: mark.rutland@arm.com, len.brown@intel.com, linux-hwmon@vger.kernel.org, linux-gpio@vger.kernel.org, will@kernel.org, Raag Jadav <raag.jadav@intel.com>, robert.moore@intel.com, bala.senthil@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Jonathan.Cameron@huawei.com, mallikarjunappa.sangannavar@intel.com, acpica-devel@lists.linuxfoundation.org, andriy.shevchenko@linux.intel.com, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-arm-kernel@lists.infradead.org

On Tue, Oct 24, 2023 at 09:51:08PM +0200, Rafael J. Wysocki wrote:
> On Tue, Oct 24, 2023 at 11:30 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > On Tue, Oct 24, 2023 at 11:50:12AM +0530, Raag Jadav wrote:
> > > This series refines _UID references across kernel by:
> > >
> > > - Extracting _UID matching functionality from acpi_dev_hid_uid_match()
> > >   helper and introducing it as a separate acpi_dev_uid_match() helper.
> > >
> > > - Converting manual _UID references to use the standard ACPI helpers.
> > >
> > > Changes since v2:
> > > - Drop review tags as suggested by Andy.
> > >
> > > Changes since v1:
> > > - Change acpi_dev_uid_match() to return false in case of NULL argument.
> > > - Drop accepted patches.
> > >
> > > Raag Jadav (6):
> > >   ACPI: utils: Introduce acpi_dev_uid_match() for matching _UID
> > >   pinctrl: intel: use acpi_dev_uid_match() for matching _UID
> > >   ACPI: utils: use acpi_dev_uid_match() for matching _UID
> > >   ACPI: x86: use acpi_dev_uid_match() for matching _UID
> > >   hwmon: nct6775: use acpi_dev_hid_uid_match() for matching _HID and
> > >     _UID
> > >   perf: arm_cspmu: use acpi_dev_hid_uid_match() for matching _HID and
> > >     _UID
> >
> > For the series,
> >
> > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> >
> > >  drivers/acpi/utils.c                  | 34 ++++++++++++++++++++++-----
> > >  drivers/acpi/x86/utils.c              |  3 +--
> > >  drivers/hwmon/nct6775-platform.c      |  4 +---
> > >  drivers/perf/arm_cspmu/arm_cspmu.c    |  8 +++----
> > >  drivers/pinctrl/intel/pinctrl-intel.c |  2 +-
> >
> > This pinctrl one is also fine by me so if Andy does not have objections,
> > feel free to add my,
> >
> > Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Whole series applied as 6.7 material with tags as per the above, thanks!

Ok, that means I will _not_ apply the hwmon patch through
the hwmon tree.

FWIW, please note that I would have very much preferred applying
it through the hwmon tree, and I did _not_ Ack it.

Guenter
