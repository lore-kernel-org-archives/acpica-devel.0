Content-Type: multipart/mixed; boundary="===============8838415647702917570=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: [Devel] Re: [PATCH v3 6/6] mfd: tps68470: Remove tps68470 MFD driver
Date: Mon, 22 Feb 2021 16:12:35 +0200
Message-ID: <CAHp75Veb=0OOE=iyt5ua46HkMuG6_Xu1bWAxzZX5d3378CrfNg@mail.gmail.com>
In-Reply-To: 20210222130735.1313443-7-djrscally@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8838415647702917570==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 22, 2021 at 3:12 PM Daniel Scally <djrscally(a)gmail.com> wrote:
>
> This driver only covered one scenario in which ACPI devices with _HID
> INT3472 are found, and its functionality has been taken over by the
> intel-skl-int3472 module, so remove it.

As long as patch 5 accepted
Acked-by: Andy Shevchenko <andy.shevchenko(a)gmail.com>

> Reviewed-by: Laurent Pinchart <laurent.pinchart(a)ideasonboard.com>
> Signed-off-by: Daniel Scally <djrscally(a)gmail.com>
> ---
> Changes in v3:
>         - Replaced Kconfig dependencies with INTEL_SKL_INT3472 for the tp=
s68470
>           OpRegion and GPIO drivers.
>
>  drivers/acpi/pmic/Kconfig |  2 +-
>  drivers/gpio/Kconfig      |  2 +-
>  drivers/mfd/Kconfig       | 18 --------
>  drivers/mfd/Makefile      |  1 -
>  drivers/mfd/tps68470.c    | 97 ---------------------------------------
>  5 files changed, 2 insertions(+), 118 deletions(-)
>  delete mode 100644 drivers/mfd/tps68470.c
>
> diff --git a/drivers/acpi/pmic/Kconfig b/drivers/acpi/pmic/Kconfig
> index 56bbcb2ce61b..f84b8f6038dc 100644
> --- a/drivers/acpi/pmic/Kconfig
> +++ b/drivers/acpi/pmic/Kconfig
> @@ -52,7 +52,7 @@ endif # PMIC_OPREGION
>
>  config TPS68470_PMIC_OPREGION
>         bool "ACPI operation region support for TPS68470 PMIC"
> -       depends on MFD_TPS68470
> +       depends on INTEL_SKL_INT3472
>         help
>           This config adds ACPI operation region support for TI TPS68470 =
PMIC.
>           TPS68470 device is an advanced power management unit that powers
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index c70f46e80a3b..998898c72af8 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -1343,7 +1343,7 @@ config GPIO_TPS65912
>
>  config GPIO_TPS68470
>         bool "TPS68470 GPIO"
> -       depends on MFD_TPS68470
> +       depends on INTEL_SKL_INT3472
>         help
>           Select this option to enable GPIO driver for the TPS68470
>           chip family.
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index bdfce7b15621..9a1f648efde0 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1520,24 +1520,6 @@ config MFD_TPS65217
>           This driver can also be built as a module.  If so, the module
>           will be called tps65217.
>
> -config MFD_TPS68470
> -       bool "TI TPS68470 Power Management / LED chips"
> -       depends on ACPI && PCI && I2C=3Dy
> -       depends on I2C_DESIGNWARE_PLATFORM=3Dy
> -       select MFD_CORE
> -       select REGMAP_I2C
> -       help
> -         If you say yes here you get support for the TPS68470 series of
> -         Power Management / LED chips.
> -
> -         These include voltage regulators, LEDs and other features
> -         that are often used in portable devices.
> -
> -         This option is a bool as it provides an ACPI operation
> -         region, which must be available before any of the devices
> -         using this are probed. This option also configures the
> -         designware-i2c driver to be built-in, for the same reason.
> -
>  config MFD_TI_LP873X
>         tristate "TI LP873X Power Management IC"
>         depends on I2C
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 14fdb188af02..5994e812f479 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -105,7 +105,6 @@ obj-$(CONFIG_MFD_TPS65910)  +=3D tps65910.o
>  obj-$(CONFIG_MFD_TPS65912)     +=3D tps65912-core.o
>  obj-$(CONFIG_MFD_TPS65912_I2C) +=3D tps65912-i2c.o
>  obj-$(CONFIG_MFD_TPS65912_SPI)  +=3D tps65912-spi.o
> -obj-$(CONFIG_MFD_TPS68470)     +=3D tps68470.o
>  obj-$(CONFIG_MFD_TPS80031)     +=3D tps80031.o
>  obj-$(CONFIG_MENELAUS)         +=3D menelaus.o
>
> diff --git a/drivers/mfd/tps68470.c b/drivers/mfd/tps68470.c
> deleted file mode 100644
> index 4a4df4ffd18c..000000000000
> --- a/drivers/mfd/tps68470.c
> +++ /dev/null
> @@ -1,97 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * TPS68470 chip Parent driver
> - *
> - * Copyright (C) 2017 Intel Corporation
> - *
> - * Authors:
> - *     Rajmohan Mani <rajmohan.mani(a)intel.com>
> - *     Tianshu Qiu <tian.shu.qiu(a)intel.com>
> - *     Jian Xu Zheng <jian.xu.zheng(a)intel.com>
> - *     Yuning Pu <yuning.pu(a)intel.com>
> - */
> -
> -#include <linux/acpi.h>
> -#include <linux/delay.h>
> -#include <linux/i2c.h>
> -#include <linux/init.h>
> -#include <linux/mfd/core.h>
> -#include <linux/mfd/tps68470.h>
> -#include <linux/regmap.h>
> -
> -static const struct mfd_cell tps68470s[] =3D {
> -       { .name =3D "tps68470-gpio" },
> -       { .name =3D "tps68470_pmic_opregion" },
> -};
> -
> -static const struct regmap_config tps68470_regmap_config =3D {
> -       .reg_bits =3D 8,
> -       .val_bits =3D 8,
> -       .max_register =3D TPS68470_REG_MAX,
> -};
> -
> -static int tps68470_chip_init(struct device *dev, struct regmap *regmap)
> -{
> -       unsigned int version;
> -       int ret;
> -
> -       /* Force software reset */
> -       ret =3D regmap_write(regmap, TPS68470_REG_RESET, TPS68470_REG_RES=
ET_MASK);
> -       if (ret)
> -               return ret;
> -
> -       ret =3D regmap_read(regmap, TPS68470_REG_REVID, &version);
> -       if (ret) {
> -               dev_err(dev, "Failed to read revision register: %d\n", re=
t);
> -               return ret;
> -       }
> -
> -       dev_info(dev, "TPS68470 REVID: 0x%x\n", version);
> -
> -       return 0;
> -}
> -
> -static int tps68470_probe(struct i2c_client *client)
> -{
> -       struct device *dev =3D &client->dev;
> -       struct regmap *regmap;
> -       int ret;
> -
> -       regmap =3D devm_regmap_init_i2c(client, &tps68470_regmap_config);
> -       if (IS_ERR(regmap)) {
> -               dev_err(dev, "devm_regmap_init_i2c Error %ld\n",
> -                       PTR_ERR(regmap));
> -               return PTR_ERR(regmap);
> -       }
> -
> -       i2c_set_clientdata(client, regmap);
> -
> -       ret =3D tps68470_chip_init(dev, regmap);
> -       if (ret < 0) {
> -               dev_err(dev, "TPS68470 Init Error %d\n", ret);
> -               return ret;
> -       }
> -
> -       ret =3D devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE, tps68470s,
> -                             ARRAY_SIZE(tps68470s), NULL, 0, NULL);
> -       if (ret < 0) {
> -               dev_err(dev, "devm_mfd_add_devices failed: %d\n", ret);
> -               return ret;
> -       }
> -
> -       return 0;
> -}
> -
> -static const struct acpi_device_id tps68470_acpi_ids[] =3D {
> -       {"INT3472"},
> -       {},
> -};
> -
> -static struct i2c_driver tps68470_driver =3D {
> -       .driver =3D {
> -                  .name =3D "tps68470",
> -                  .acpi_match_table =3D tps68470_acpi_ids,
> -       },
> -       .probe_new =3D tps68470_probe,
> -};
> -builtin_i2c_driver(tps68470_driver);
> --
> 2.25.1
>


-- =

With Best Regards,
Andy Shevchenko
--===============8838415647702917570==--

