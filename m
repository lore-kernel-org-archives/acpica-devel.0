Content-Type: multipart/mixed; boundary="===============6303453439222022890=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: [Devel] Re: [PATCH v5 5/6] platform/x86: Add intel_skl_int3472 driver
Date: Wed, 16 Jun 2021 21:08:11 +0300
Message-ID: <CAHp75VccZbv8+u-jO8wYSsyQrw+Bd_zeDa==aiTvkh=fteuT3w@mail.gmail.com>
In-Reply-To: ea322abe-fa78-bbc3-b4c5-b372a4f28235@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6303453439222022890==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 16, 2021 at 8:58 PM Hans de Goede <hdegoede(a)redhat.com> wrote:
> On 6/4/21 12:40 AM, Daniel Scally wrote:
> > ACPI devices with _HID INT3472 are currently matched to the tps68470
> > driver, however this does not cover all situations in which that _HID
> > occurs. We've encountered three possibilities:
> >
> > 1. On Chrome OS devices, an ACPI device with _HID INT3472 (representing
> > a physical TPS68470 device) that requires a GPIO and OpRegion driver
> > 2. On devices designed for Windows, an ACPI device with _HID INT3472
> > (again representing a physical TPS68470 device) which requires GPIO,
> > Clock and Regulator drivers.
> > 3. On other devices designed for Windows, an ACPI device with _HID
> > INT3472 which does **not** represent a physical TPS68470, and is instead
> > used as a dummy device to group some system GPIO lines which are meant
> > to be consumed by the sensor that is dependent on this entry.
> >
> > This commit adds a new module, registering a platform driver to deal
> > with the 3rd scenario plus an i2c driver to deal with #1 and #2, by
> > querying the CLDB buffer found against INT3472 entries to determine
> > which is most appropriate.
> >
> > Suggested-by: Laurent Pinchart <laurent.pinchart(a)ideasonboard.com>
> > Signed-off-by: Daniel Scally <djrscally(a)gmail.com>
>
> Thank you for your patch, I've applied this patch to my review-hans
> branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x8=
6.git/log/?h=3Dreview-hans
>
> I've fixed up the missing static marking of skl_int3472_tps68470_calc_typ=
e()
> spotted by lkp(a)intel.com while applying the patch to my tree.

Are you going to apply patch 6 as well?
IIRC it's acked by Lee.

-- =

With Best Regards,
Andy Shevchenko
--===============6303453439222022890==--

