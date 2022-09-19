Content-Type: multipart/mixed; boundary="===============8334566447638710239=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH v3 0/8] ACPI: unify _UID handling as integer
Date: Mon, 19 Sep 2022 18:37:14 +0200
Message-ID: <CAJZ5v0hC5Tif=nR2CjDcStUp+SZx3v7d7RCykzcYGYDHsNcYsg@mail.gmail.com>
In-Reply-To: 20220913163147.24258-1-andriy.shevchenko@linux.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8334566447638710239==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 13, 2022 at 6:32 PM Andy Shevchenko
<andriy.shevchenko(a)linux.intel.com> wrote:
>
> This series is about unification on how we handle ACPI _UID when
> it's known to be an integer-in-the-string.
>
> The idea of merging either all via ACPI tree, or taking ACPI stuff
> for the v6.1 while the rest may be picked up later on by respective
> maintainers separately (currently only perf patch is not tagged).
>
> Partially compile-tested (x86-64).
>
> Changelog v3:
> - fixed dev_dbg() specifier to be in align with the variable type (LKP)
> - made use of temporary dev variable beyond the ACPI scope (LKP)
> - added tags to I=C2=B2C patches (Wolfram)

I've replaced the previous version of this patch series in my tree
with this one.

Thanks!


> Changelog v2:
> - rebased pxa2xx patch to be applied against current Linux kernel code
> - fixed uninitialized variable adev in use (mlxbf)
> - dropped unneeded temporary variable adev (qcom_l2_pmu)
> - changed type for ret in patch 8 (Hans)
> - swapped conditions to check ret =3D=3D 0 first (Ard)
> - added tags (Mark, Ard, Hans)
>
> Andy Shevchenko (8):
>   ACPI: utils: Add acpi_dev_uid_to_integer() helper to get _UID as
>     integer
>   ACPI: LPSS: Refactor _UID handling to use acpi_dev_uid_to_integer()
>   ACPI: x86: Refactor _UID handling to use acpi_dev_uid_to_integer()
>   i2c: amd-mp2-plat: Refactor _UID handling to use
>     acpi_dev_uid_to_integer()
>   i2c: mlxbf: Refactor _UID handling to use acpi_dev_uid_to_integer()
>   perf: qcom_l2_pmu: Refactor _UID handling to use
>     acpi_dev_uid_to_integer()
>   spi: pxa2xx: Refactor _UID handling to use acpi_dev_uid_to_integer()
>   efi/dev-path-parser: Refactor _UID handling to use
>     acpi_dev_uid_to_integer()
>
>  drivers/acpi/acpi_lpss.c               | 15 +++++------
>  drivers/acpi/utils.c                   | 24 +++++++++++++++++
>  drivers/acpi/x86/utils.c               | 14 +++++++---
>  drivers/firmware/efi/dev-path-parser.c | 10 ++++---
>  drivers/i2c/busses/i2c-amd-mp2-plat.c  | 27 +++++++------------
>  drivers/i2c/busses/i2c-mlxbf.c         | 20 +++++---------
>  drivers/perf/qcom_l2_pmu.c             | 10 +++----
>  drivers/spi/spi-pxa2xx.c               | 37 +++++++-------------------
>  include/acpi/acpi_bus.h                |  1 +
>  include/linux/acpi.h                   |  5 ++++
>  10 files changed, 83 insertions(+), 80 deletions(-)
>
> --
> 2.35.1
>
--===============8334566447638710239==--

