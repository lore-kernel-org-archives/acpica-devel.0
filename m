Content-Type: multipart/mixed; boundary="===============5305319068076349075=="
MIME-Version: 1.0
From: Lukas Wunner <lukas at wunner.de>
Subject: [Devel] [PATCH 0/5] Add acpi_dev_present
Date: Mon, 23 Nov 2015 14:35:08 +0000
Message-ID: <cover.1448282995.git.lukas@wunner.de>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5305319068076349075==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi everyone,

I need to detect the presence of apple-gmux (ACPI HID "APP000B")
in several DRM drivers to handle backlight, runtime pm and
deferred probing properly.

There's an idiom in use by 7 other drivers to detect presence of
a particular ACPI HID which involves calling acpi_get_devices()
and passing it a minimal callback that does no further filtering.
However this approach results in lots of duplicate code.

This series adds acpi_dev_present(), the ACPI equivalent to
pci_dev_present(). It takes a HID string and returns a bool,
allowing us to simplify the drivers considerably by removing
all the duplicate callbacks and other boilerplate.

I've pushed these patches to GitHub to ease reviewing:
https://github.com/l1k/linux/commits/acpi_dev_present

Should this series find acceptance, it would probably be best if
we could agree to merge everything through a single repository,
e.g. acpi (git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm).
or alternatively alsa (which contains 5 of the 7 drivers involved).
Consequently I would like to invite the driver maintainers to
kindly provide acks (or raise objections, if any).

The series should not result in any functional changes, however
I lack the hardware to actually verify this for every driver
involved. I did test it with apple-gmux though.

Thanks,

Lukas


Lukas Wunner (5):
  ACPICA: Add acpi_dev_present
  eeepc-wmi: Use acpi_dev_present
  acer-wmi: Use acpi_dev_present
  ALSA: hda - Use acpi_dev_present
  ASoC: Intel: Use acpi_dev_present

 drivers/acpi/acpica/nsxfeval.c               | 46 ++++++++++++++++++++++++=
++++
 drivers/platform/x86/acer-wmi.c              | 16 +++-------
 drivers/platform/x86/eeepc-wmi.c             | 24 ++-------------
 include/acpi/acpixf.h                        |  7 +++++
 sound/pci/hda/thinkpad_helper.c              | 17 ++--------
 sound/soc/intel/atom/sst/sst_acpi.c          | 12 +-------
 sound/soc/intel/boards/cht_bsw_max98090_ti.c | 17 ++--------
 sound/soc/intel/boards/cht_bsw_rt5645.c      | 13 +-------
 sound/soc/intel/common/sst-acpi.c            | 12 +-------
 9 files changed, 66 insertions(+), 98 deletions(-)

-- =

1.8.5.2 (Apple Git-48)


--===============5305319068076349075==--

