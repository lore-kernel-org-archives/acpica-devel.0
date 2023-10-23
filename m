Return-Path: <rjwysocki@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 697FA82F20
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2D05382EA5
MIME-Version: 1.0
References: <20231023053530.5525-1-raag.jadav@intel.com>
 <20231023053530.5525-3-raag.jadav@intel.com>
 <ZTZacR86hSmV04M9@smile.fi.intel.com> <ZTaGaDweYpBlxBez@black.fi.intel.com>
In-Reply-To: <ZTaGaDweYpBlxBez@black.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 23 Oct 2023 20:45:55 +0200
Message-ID: <CAJZ5v0g1nTXRD9D5KxQ2DoSRkaavLGjXVAOWbe3wfDLeoTtV8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Acpica-devel] [PATCH v2 2/6] pinctrl: intel: use
 acpi_dev_uid_match() for matching _UID
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
Cc: mark.rutland@arm.com, len.brown@intel.com, linux-hwmon@vger.kernel.org, will@kernel.org, linux-gpio@vger.kernel.org, mallikarjunappa.sangannavar@intel.com, robert.moore@intel.com, bala.senthil@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jonathan.Cameron@huawei.com, acpica-devel@lists.linuxfoundation.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, mika.westerberg@linux.intel.com, linux@roeck-us.net

On Mon, Oct 23, 2023 at 4:43=E2=80=AFPM Raag Jadav <raag.jadav@intel.com> w=
rote:
>
> On Mon, Oct 23, 2023 at 02:35:13PM +0300, Andy Shevchenko wrote:
> > On Mon, Oct 23, 2023 at 11:05:26AM +0530, Raag Jadav wrote:
> > > Convert manual _UID references to use the standard ACPI helper.
> >
> > > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > It has a hidden logic that is not aligned with acpi_dev_hid_uid_match()=
.
> > Or revert to your v1 I assume.
>
> I don't see how this has to be aligned with acpi_dev_hid_uid_match() or
> if acpi_dev_hid_uid_match() implementation concerns this specific change,
> since that's not what we intend to do here.
>
> Also, I think acpi_dev_uid_match() implementation in v2 is actually more
> aligned with the previous logic that we're replacing here, since it gives
> us a guaranteed match result as originally intended with strcmp in this
> case. And the "hidden logic" in v1 implementation (match with @uid2 =3D=
=3D NULL)
> is what ends up breaking it in my opinion.
>
> Regardless, for any version (v1 or v2) the usage still remains the same
> in this case.

Right, so it is a bit unclear what all of the fuss is about.

> > As I asked you, please drop this one.
>
> But okay, as you wish :(
>
> Rafael, should I send a v3 with dropped tags?

No need to resend in general, I can drop tags from the patches just fine.

For this one, though, I'd like to get a maintainer's ACK, so it may be
necessary to resend it without the tag.
