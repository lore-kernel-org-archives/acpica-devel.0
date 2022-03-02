Content-Type: multipart/mixed; boundary="===============1746454761971003422=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
Subject: [Devel] [rafael-pm:bleeding-edge 113/118]
 arch/x86/kernel/acpi/boot.c:1476:8: warning: excess elements in array
 initializer
Date: Wed, 02 Mar 2022 10:51:19 +0800
Message-ID: <202203020737.wa9uc4gW-lkp@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1746454761971003422==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git=
 bleeding-edge
head:   f7307721a01f4f14d21c699b270a870370cf34b9
commit: ed00b2b8d737f87a2437d7bd7c7f90124b50da05 [113/118] x86 / ACPI: Work=
 around broken XSDT on SEGA AALE board
config: i386-randconfig-a011 (https://download.01.org/0day-ci/archive/20220=
302/202203020737.wa9uc4gW-lkp(a)intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc=
04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=3D1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/=
make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.g=
it/commit/?id=3Ded00b2b8d737f87a2437d7bd7c7f90124b50da05
        git remote add rafael-pm https://git.kernel.org/pub/scm/linux/kerne=
l/git/rafael/linux-pm.git
        git fetch --no-tags rafael-pm bleeding-edge
        git checkout ed00b2b8d737f87a2437d7bd7c7f90124b50da05
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=3D=
1 O=3Dbuild_dir ARCH=3Di386 SHELL=3D/bin/bash arch/x86/kernel/acpi/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp(a)intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/acpi/boot.c:1476:8: warning: excess elements in array in=
itializer [-Wexcess-initializers]
                        DMI_MATCH(DMI_BIOS_DATE, "02/01/2011"),
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mod_devicetable.h:587:25: note: expanded from macro 'DMI_M=
ATCH'
   #define DMI_MATCH(a, b) { .slot =3D a, .substr =3D b }
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +1476 arch/x86/kernel/acpi/boot.c

  1389	=

  1390	/*
  1391	 * If your system is blacklisted here, but you find that acpi=3Dforce
  1392	 * works for you, please contact linux-acpi(a)vger.kernel.org
  1393	 */
  1394	static const struct dmi_system_id acpi_dmi_table[] __initconst =3D {
  1395		/*
  1396		 * Boxes that need ACPI disabled
  1397		 */
  1398		{
  1399		 .callback =3D dmi_disable_acpi,
  1400		 .ident =3D "IBM Thinkpad",
  1401		 .matches =3D {
  1402			     DMI_MATCH(DMI_BOARD_VENDOR, "IBM"),
  1403			     DMI_MATCH(DMI_BOARD_NAME, "2629H1G"),
  1404			     },
  1405		 },
  1406	=

  1407		/*
  1408		 * Boxes that need ACPI PCI IRQ routing disabled
  1409		 */
  1410		{
  1411		 .callback =3D disable_acpi_irq,
  1412		 .ident =3D "ASUS A7V",
  1413		 .matches =3D {
  1414			     DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC"),
  1415			     DMI_MATCH(DMI_BOARD_NAME, "<A7V>"),
  1416			     /* newer BIOS, Revision 1011, does work */
  1417			     DMI_MATCH(DMI_BIOS_VERSION,
  1418				       "ASUS A7V ACPI BIOS Revision 1007"),
  1419			     },
  1420		 },
  1421		{
  1422			/*
  1423			 * Latest BIOS for IBM 600E (1.16) has bad pcinum
  1424			 * for LPC bridge, which is needed for the PCI
  1425			 * interrupt links to work. DSDT fix is in bug 5966.
  1426			 * 2645, 2646 model numbers are shared with 600/600E/600X
  1427			 */
  1428		 .callback =3D disable_acpi_irq,
  1429		 .ident =3D "IBM Thinkpad 600 Series 2645",
  1430		 .matches =3D {
  1431			     DMI_MATCH(DMI_BOARD_VENDOR, "IBM"),
  1432			     DMI_MATCH(DMI_BOARD_NAME, "2645"),
  1433			     },
  1434		 },
  1435		{
  1436		 .callback =3D disable_acpi_irq,
  1437		 .ident =3D "IBM Thinkpad 600 Series 2646",
  1438		 .matches =3D {
  1439			     DMI_MATCH(DMI_BOARD_VENDOR, "IBM"),
  1440			     DMI_MATCH(DMI_BOARD_NAME, "2646"),
  1441			     },
  1442		 },
  1443		/*
  1444		 * Boxes that need ACPI PCI IRQ routing and PCI scan disabled
  1445		 */
  1446		{			/* _BBN 0 bug */
  1447		 .callback =3D disable_acpi_pci,
  1448		 .ident =3D "ASUS PR-DLS",
  1449		 .matches =3D {
  1450			     DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
  1451			     DMI_MATCH(DMI_BOARD_NAME, "PR-DLS"),
  1452			     DMI_MATCH(DMI_BIOS_VERSION,
  1453				       "ASUS PR-DLS ACPI BIOS Revision 1010"),
  1454			     DMI_MATCH(DMI_BIOS_DATE, "03/21/2003")
  1455			     },
  1456		 },
  1457		{
  1458		 .callback =3D disable_acpi_pci,
  1459		 .ident =3D "Acer TravelMate 36x Laptop",
  1460		 .matches =3D {
  1461			     DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
  1462			     DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 360"),
  1463			     },
  1464		 },
  1465		/*
  1466		 * Boxes that need ACPI XSDT use disabled due to corrupted tables
  1467		 */
  1468		{
  1469		 .callback =3D disable_acpi_xsdt,
  1470		 .ident =3D "SEGA AALE",
  1471		 .matches =3D {
  1472			     DMI_MATCH(DMI_SYS_VENDOR, "NEC"),
  1473			     DMI_MATCH(DMI_PRODUCT_NAME, "Bearlake CRB Board"),
  1474			     DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
  1475			     DMI_MATCH(DMI_BIOS_VERSION, "V1.12"),
> 1476			     DMI_MATCH(DMI_BIOS_DATE, "02/01/2011"),
  1477			     },
  1478		},
  1479		{}
  1480	};
  1481	=


---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all(a)lists.01.org
--===============1746454761971003422==--

