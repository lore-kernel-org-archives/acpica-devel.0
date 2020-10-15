Content-Type: multipart/mixed; boundary="===============1603360842528675896=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [pm:acpica-osl 6/6] drivers/acpi/osl.c:1748:46: sparse:
 sparse: incorrect type in assignment (different address spaces)
Date: Thu, 15 Oct 2020 13:35:19 +0200
Message-ID: <CAJZ5v0he6mFq339L2o_r=ugG5auX4AUtZwABsFNFFBRcCBJszQ@mail.gmail.com>
In-Reply-To: BYAPR11MB3256FDBA54924A32BE878CF787050@BYAPR11MB3256.namprd11.prod.outlook.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1603360842528675896==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2020 at 10:37 PM Moore, Robert <robert.moore(a)intel.com> w=
rote:
>
> I believe the file " drivers/acpi/osl.c " is part of the core linux, not =
ACPICA.

Yes, it is.

> -----Original Message-----
> From: kernel test robot <lkp(a)intel.com>
> Sent: Saturday, September 05, 2020 11:34 AM
> To: Rafael J. Wysocki <rjw(a)rjwysocki.net>
> Cc: kbuild-all(a)lists.01.org; linux-acpi(a)vger.kernel.org; devel(a)acpi=
ca.org; linux-pm(a)vger.kernel.org
> Subject: [Devel] [pm:acpica-osl 6/6] drivers/acpi/osl.c:1748:46: sparse: =
sparse: incorrect type in assignment (different address spaces)
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.g=
it acpica-osl
> head:   c32c3c4079f8a62616413abbead45b6622fb7602
> commit: c32c3c4079f8a62616413abbead45b6622fb7602 [6/6] ACPI: OSL: Make AC=
PICA use logical addresses of GPE blocks
> config: x86_64-randconfig-s022-20200904 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.2-191-g10164920-dirty
>         git checkout c32c3c4079f8a62616413abbead45b6622fb7602
>         # save the attached .config to linux build tree
>         make W=3D1 C=3D1 CF=3D'-fdiagnostic-prefix -D__CHECK_ENDIAN__' AR=
CH=3Dx86_64
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp(a)intel.com>
>
>
> sparse warnings: (new ones prefixed by >>)
>
>    drivers/acpi/osl.c:376:17: sparse: sparse: cast removes address space =
'__iomem' of expression
> >> drivers/acpi/osl.c:1748:46: sparse: sparse: incorrect type in assignme=
nt (different address spaces) @@     expected void *extern [addressable] [t=
oplevel] acpi_gbl_xgpe0_block_logical_address @@     got void [noderef] __i=
omem * @@
> >> drivers/acpi/osl.c:1748:46: sparse:     expected void *extern [address=
able] [toplevel] acpi_gbl_xgpe0_block_logical_address
>    drivers/acpi/osl.c:1748:46: sparse:     got void [noderef] __iomem *
> >> drivers/acpi/osl.c:1750:46: sparse: sparse: incorrect type in assignme=
nt (different address spaces) @@     expected void *extern [addressable] [t=
oplevel] acpi_gbl_xgpe1_block_logical_address @@     got void [noderef] __i=
omem * @@
> >> drivers/acpi/osl.c:1750:46: sparse:     expected void *extern [address=
able] [toplevel] acpi_gbl_xgpe1_block_logical_address
>    drivers/acpi/osl.c:1750:46: sparse:     got void [noderef] __iomem *
>    drivers/acpi/osl.c:1760:20: sparse: sparse: incorrect type in assignme=
nt (different address spaces) @@     expected void *rv @@     got void [nod=
eref] __iomem * @@
>    drivers/acpi/osl.c:1760:20: sparse:     expected void *rv
>    drivers/acpi/osl.c:1760:20: sparse:     got void [noderef] __iomem *
>    drivers/acpi/osl.c:708:1: sparse: sparse: context imbalance in 'acpi_o=
s_read_memory' - wrong count at exit
>    drivers/acpi/osl.c:741:1: sparse: sparse: context imbalance in 'acpi_o=
s_write_memory' - wrong count at exit
>
> # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/com=
mit/?id=3Dc32c3c4079f8a62616413abbead45b6622fb7602
> git remote add pm https://git.kernel.org/pub/scm/linux/kernel/git/rafael/=
linux-pm.git
> git fetch --no-tags pm acpica-osl
> git checkout c32c3c4079f8a62616413abbead45b6622fb7602
> vim +1748 drivers/acpi/osl.c
>
>   1742
>   1743  acpi_status __init acpi_os_initialize(void)
>   1744  {
>   1745          acpi_os_map_generic_address(&acpi_gbl_FADT.xpm1a_event_bl=
ock);
>   1746          acpi_os_map_generic_address(&acpi_gbl_FADT.xpm1b_event_bl=
ock);
>   1747
> > 1748          acpi_gbl_xgpe0_block_logical_address =3D
>   1749                  acpi_os_map_generic_address(&acpi_gbl_FADT.xgpe0_=
block);
> > 1750          acpi_gbl_xgpe1_block_logical_address =3D
>   1751                  acpi_os_map_generic_address(&acpi_gbl_FADT.xgpe1_=
block);
>   1752
>   1753          if (acpi_gbl_FADT.flags & ACPI_FADT_RESET_REGISTER) {
>   1754                  /*
>   1755                   * Use acpi_os_map_generic_address to pre-map the=
 reset
>   1756                   * register if it's in system memory.
>   1757                   */
>   1758                  void *rv;
>   1759
>   1760                  rv =3D acpi_os_map_generic_address(&acpi_gbl_FADT=
.reset_register);
>   1761                  pr_debug(PREFIX "%s: map reset_reg %s\n", __func_=
_,
>   1762                           rv ? "successful" : "failed");
>   1763          }
>   1764          acpi_os_initialized =3D true;
>   1765
>   1766          return AE_OK;
>   1767  }
>   1768
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation https://lists.01.org/hype=
rkitty/list/kbuild-all(a)lists.01.org
--===============1603360842528675896==--

