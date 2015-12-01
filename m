Content-Type: multipart/mixed; boundary="===============8615182147172466076=="
MIME-Version: 1.0
From: Lukas Wunner <lukas at wunner.de>
Subject: Re: [Devel] [PATCH v2 2/2] ACPI / utils: Add acpi_dev_present()
Date: Tue, 01 Dec 2015 13:58:14 +0100
Message-ID: <20151201125814.GA28094@wunner.de>
In-Reply-To: 565C086B.4000000@huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8615182147172466076==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Hanjun Guo,

thank you for taking a look at the patches.

On Mon, Nov 30, 2015 at 04:27:23PM +0800, Hanjun Guo wrote:
> If the driver can't pass the "dev" as the argument form acpi device or
> platform device, this is the way to match HIDs.
> =

> But if we get the pointer to acpi device or platform device structure
> before calling this function, I think acpi_match_device_ids() can match
> what you need, and we don't need to invent another function.

Of the 7 users,

* 4 detect the presence of a particular HID to activate platform-
  specific quirks (acer-wmi.c, eeepc-wmi.c, thinkpad_helper.c,
  cht_bsw_max98090_ti.c). The drivers never obtain a pointer to the
  struct acpi_device. This is also the reason why I need to detect
  the presence of apple-gmux in several DRM drivers, to activate
  quirks specific to MacBook Pros with dual GPUs, and the one thing
  they have in common is the presence of the gmux controller.
  The DRM drivers likewise never have a need to hold a pointer to
  apple-gmux' struct acpi_device.

* 2 detect the presence of a particular HID and *afterwards*
  instantiate a platform_device (atom/sst/sst_acpi.c and
  common/sst-acpi.c). So we can't use acpi_match_device_ids()
  there either.

* 1 is a driver for a platform_device (cht_bsw_rt5645.c) which was
  instantiated by atom/sst/sst_acpi.c. The driver is responsible
  for two chips and differentiates between the two by detecting the
  presence of a particular HID. It would be possible to refactor the
  code so that atom/sst/sst_acpi.c passes down the matched HID to
  cht_bsw_rt5645.c, then it wouldn't be necessary to match for a
  second time. Also, the only difference between the two chipsets
  seems to be a minute change in struct snd_soc_dapm_route, so I'm
  wondering if it's necessary to differentiate between the chipsets
  at all. Mark Brown may want to poke the developers of the driver to
  refactor the code.

TL;DR: 6 of the 7 users can't use acpi_match_device_ids() and the
7th could be refactored so that it doesn't have to detect the presence
of a specific HID at all.

Best regards,

Lukas

--===============8615182147172466076==--

