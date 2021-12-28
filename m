Content-Type: multipart/mixed; boundary="===============6016027756407807390=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
Subject: [Devel] [rafael-pm:bleeding-edge 97/119]
 drivers/acpi/acpica/exregion.c:519:17: warning: performing pointer
 subtraction with a null pointer has undefined behavior
Date: Tue, 28 Dec 2021 09:56:38 +0800
Message-ID: <202112280907.gTYYYuB4-lkp@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6016027756407807390==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git=
 bleeding-edge
head:   86e4182dd2d1465f6446863dd26da97ea069c8a2
commit: ca25f92b72d25457653dbf2a81f322235804fb05 [97/119] ACPICA: Use origi=
nal data_table_region pointer for accesses
config: i386-randconfig-a012-20211228 (https://download.01.org/0day-ci/arch=
ive/20211228/202112280907.gTYYYuB4-lkp(a)intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 7171af=
744543433ac75b232eb7dfdaef7efd4d7a)
reproduce (this is a W=3D1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/=
make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.g=
it/commit/?id=3Dca25f92b72d25457653dbf2a81f322235804fb05
        git remote add rafael-pm https://git.kernel.org/pub/scm/linux/kerne=
l/git/rafael/linux-pm.git
        git fetch --no-tags rafael-pm bleeding-edge
        git checkout ca25f92b72d25457653dbf2a81f322235804fb05
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=3D=
1 O=3Dbuild_dir ARCH=3Di386 SHELL=3D/bin/bash drivers/acpi/acpica/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp(a)intel.com>

All warnings (new ones prefixed by >>):

>> drivers/acpi/acpica/exregion.c:519:17: warning: performing pointer subtr=
action with a null pointer has undefined behavior [-Wnull-pointer-subtracti=
on]
               (address - ACPI_PTR_TO_PHYSADDR(mapping->pointer));
                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/acpi/actypes.h:513:41: note: expanded from macro 'ACPI_PTR_TO_PH=
YSADDR'
   #define ACPI_PTR_TO_PHYSADDR(i)         ACPI_TO_INTEGER(i)
                                           ^~~~~~~~~~~~~~~~~~
   include/acpi/actypes.h:510:41: note: expanded from macro 'ACPI_TO_INTEGE=
R'
   #define ACPI_TO_INTEGER(p)              ACPI_PTR_DIFF (p, (void *) 0)
                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/acpi/actypes.h:505:79: note: expanded from macro 'ACPI_PTR_DIFF'
   #define ACPI_PTR_DIFF(a, b)             ((acpi_size) (ACPI_CAST_PTR (u8,=
 (a)) - ACPI_CAST_PTR (u8, (b))))
                                                                           =
      ^ ~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +519 drivers/acpi/acpica/exregion.c

   486	=

   487	/*******************************************************************=
************
   488	 *
   489	 * FUNCTION:    acpi_ex_data_table_space_handler
   490	 *
   491	 * PARAMETERS:  function            - Read or Write operation
   492	 *              address             - Where in the space to read or =
write
   493	 *              bit_width           - Field width in bits (8, 16, or=
 32)
   494	 *              value               - Pointer to in or out value
   495	 *              handler_context     - Pointer to Handler's context
   496	 *              region_context      - Pointer to context specific to=
 the
   497	 *                                    accessed region
   498	 *
   499	 * RETURN:      Status
   500	 *
   501	 * DESCRIPTION: Handler for the Data Table address space (Op Region)
   502	 *
   503	 *******************************************************************=
***********/
   504	=

   505	acpi_status
   506	acpi_ex_data_table_space_handler(u32 function,
   507					 acpi_physical_address address,
   508					 u32 bit_width,
   509					 u64 *value,
   510					 void *handler_context, void *region_context)
   511	{
   512		struct acpi_data_table_space_context *mapping;
   513		char *pointer;
   514	=

   515		ACPI_FUNCTION_TRACE(ex_data_table_space_handler);
   516	=

   517		mapping =3D (struct acpi_data_table_space_context *) region_context;
   518		pointer =3D ACPI_CAST_PTR(char, mapping->pointer) +
 > 519		    (address - ACPI_PTR_TO_PHYSADDR(mapping->pointer));

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all(a)lists.01.org
--===============6016027756407807390==--

