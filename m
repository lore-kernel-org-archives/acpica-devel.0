Content-Type: multipart/mixed; boundary="===============5796649342169857855=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: [Devel] Re: [PATCH v3 0/6] Introduce intel_skl_int3472 module
Date: Mon, 22 Feb 2021 16:15:48 +0200
Message-ID: <CAHp75Vfu678RQ1-p4rXOkp5UPDuxgW4ctm1w+uEFhumcfGXf1g@mail.gmail.com>
In-Reply-To: 20210222130735.1313443-1-djrscally@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5796649342169857855==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 22, 2021 at 3:11 PM Daniel Scally <djrscally(a)gmail.com> wrote:
>
> v1 for this series was originally 14-18 of this series:
> https://lore.kernel.org/linux-media/20201130133129.1024662-1-djrscally(a)=
gmail.com/T/#m91934e12e3d033da2e768e952ea3b4a125ee3e67
>
> v2 was here:
> https://lore.kernel.org/platform-driver-x86/20210118003428.568892-1-djrsc=
ally(a)gmail.com/
>
> Series level changelog:
>
>         - Dropped the patch moving acpi_lpss_dep() to utils since it's no=
t used
>         in acpi_dev_get_dependent_dev() anymore.
>         - Replaced it with a patch extending acpi_walk_dep_device_list() =
to be
>         able to apply a given callback against each device in acpi_dep_li=
st
>         - Dropped the patch creating acpi_i2c_dev_name() and simply open =
coded
>         that functionality.
>
> This has been tested on a number of devices, but currently **not** on a d=
evice
> designed for ChromeOS, which we ideally need to do to ensure no regression
> caused by replacing the tps68470 MFD driver. Sakari / Tomasz, is there an=
y way
> you could help with that? Unfortunately, I don't have a device to test it=
 on
> myself.

+Cc: Dmitry and Guenter. Guys, do you know by a chance who can help
with the above request from Daniel?


> Original cover letter:
>
> At the moment in the kernel the ACPI _HID INT3472 is taken by the tps68470
> MFD driver, but that driver can only handle some of the cases of that _HID
> that we see. There are at least these three possibilities:
>
> 1. INT3472 devices that provide GPIOs through the usual framework and run
>    power and clocks through an operation region; this is the situation th=
at
>    the current module handles and is seen on ChromeOS devices
> 2. INT3472 devices that provide GPIOs, plus clocks and regulators that are
>    meant to be driven through the usual frameworks, usually seen on devic=
es
>    designed to run Windows
> 3. INT3472 devices that don't actually represent a physical tps68470, but
>    are being used as a convenient way of grouping a bunch of system GPIO
>    lines that are intended to enable power and clocks for sensors which
>    are called out as dependent on them. Also seen on devices designed to
>    run Windows.
>
> This series introduces a new module which registers:
>
> 1. An i2c driver that determines which scenario (#1 or #2) applies to the
>    machine and registers platform devices to be bound to GPIO, OpRegion,
>    clock and regulator drivers as appropriate.
> 2. A platform driver that binds to the dummy INT3472 devices described in
>    #3
>
> The platform driver for the dummy device registers the GPIO lines that
> enable the clocks and regulators to the sensors via those frameworks so
> that sensor drivers can consume them in the usual fashion. The existing
> GPIO and OpRegion tps68470 drivers will work with the i2c driver that's
> registered. Clock and regulator drivers are available but have not so far=
 been
> tested, so aren't part of this series.
>
> The existing mfd/tps68470.c driver being thus superseded, it is removed.
>
> Thanks
> Dan
>
> Daniel Scally (6):
>   ACPI: scan: Extend acpi_walk_dep_device_list()
>   ACPI: scan: Add function to fetch dependent of acpi device
>   i2c: core: Add a format macro for I2C device names
>   gpiolib: acpi: Export acpi_get_gpiod()
>   platform/x86: Add intel_skl_int3472 driver
>   mfd: tps68470: Remove tps68470 MFD driver
>
>  MAINTAINERS                                   |   5 +
>  drivers/acpi/ec.c                             |   2 +-
>  drivers/acpi/pmic/Kconfig                     |   2 +-
>  drivers/acpi/pmic/intel_pmic_chtdc_ti.c       |   2 +-
>  drivers/acpi/scan.c                           |  92 ++-
>  drivers/gpio/Kconfig                          |   2 +-
>  drivers/gpio/gpiolib-acpi.c                   |  38 +-
>  drivers/i2c/i2c-core-acpi.c                   |   2 +-
>  drivers/i2c/i2c-core-base.c                   |   4 +-
>  drivers/mfd/Kconfig                           |  18 -
>  drivers/mfd/Makefile                          |   1 -
>  drivers/mfd/tps68470.c                        |  97 ---
>  drivers/platform/surface/surface3_power.c     |   2 +-
>  drivers/platform/x86/Kconfig                  |   2 +
>  drivers/platform/x86/Makefile                 |   1 +
>  drivers/platform/x86/intel-int3472/Kconfig    |  31 +
>  drivers/platform/x86/intel-int3472/Makefile   |   4 +
>  .../intel-int3472/intel_skl_int3472_common.c  | 106 ++++
>  .../intel-int3472/intel_skl_int3472_common.h  | 110 ++++
>  .../intel_skl_int3472_discrete.c              | 592 ++++++++++++++++++
>  .../intel_skl_int3472_tps68470.c              | 113 ++++
>  include/acpi/acpi_bus.h                       |   8 +
>  include/linux/acpi.h                          |   4 +-
>  include/linux/gpio/consumer.h                 |   7 +
>  include/linux/i2c.h                           |   3 +
>  25 files changed, 1100 insertions(+), 148 deletions(-)
>  delete mode 100644 drivers/mfd/tps68470.c
>  create mode 100644 drivers/platform/x86/intel-int3472/Kconfig
>  create mode 100644 drivers/platform/x86/intel-int3472/Makefile
>  create mode 100644 drivers/platform/x86/intel-int3472/intel_skl_int3472_=
common.c
>  create mode 100644 drivers/platform/x86/intel-int3472/intel_skl_int3472_=
common.h
>  create mode 100644 drivers/platform/x86/intel-int3472/intel_skl_int3472_=
discrete.c
>  create mode 100644 drivers/platform/x86/intel-int3472/intel_skl_int3472_=
tps68470.c
>
> --
> 2.25.1
>


-- =

With Best Regards,
Andy Shevchenko
--===============5796649342169857855==--

