Content-Type: multipart/mixed; boundary="===============5288857975873972336=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
Subject: [Devel] [rafael-pm:testing 12/12] drivers/idle/intel_idle.c:1854:13:
 warning: conflicting types for 'c1e_promotion_enable'; have 'void(void)'
Date: Thu, 28 Apr 2022 15:04:53 +0800
Message-ID: <202204281547.5qD9L1sw-lkp@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5288857975873972336==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git=
 testing
head:   55ecda6f25ef6de769ae64f162828aee4812c313
commit: 55ecda6f25ef6de769ae64f162828aee4812c313 [12/12] Merge branch 'inte=
l-idle' into linux-next
config: x86_64-randconfig-c001 (https://download.01.org/0day-ci/archive/202=
20428/202204281547.5qD9L1sw-lkp(a)intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=3D1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.g=
it/commit/?id=3D55ecda6f25ef6de769ae64f162828aee4812c313
        git remote add rafael-pm https://git.kernel.org/pub/scm/linux/kerne=
l/git/rafael/linux-pm.git
        git fetch --no-tags rafael-pm testing
        git checkout 55ecda6f25ef6de769ae64f162828aee4812c313
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=3D1 O=3Dbuild_dir ARCH=3Dx86_64 SHELL=3D/bin/bash drivers/id=
le/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp(a)intel.com>

All warnings (new ones prefixed by >>):

   drivers/idle/intel_idle.c: In function 'adl_idle_state_table_update':
   drivers/idle/intel_idle.c:1701:17: error: 'disable_promotion_to_c1e' und=
eclared (first use in this function)
    1701 |                 disable_promotion_to_c1e =3D true;
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/idle/intel_idle.c:1701:17: note: each undeclared identifier is r=
eported only once for each function it appears in
   drivers/idle/intel_idle.c:1706:9: error: implicit declaration of functio=
n 'c1e_promotion_enable' [-Werror=3Dimplicit-function-declaration]
    1706 |         c1e_promotion_enable();
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/idle/intel_idle.c: At top level:
>> drivers/idle/intel_idle.c:1854:13: warning: conflicting types for 'c1e_p=
romotion_enable'; have 'void(void)'
    1854 | static void c1e_promotion_enable(void)
         |             ^~~~~~~~~~~~~~~~~~~~
   drivers/idle/intel_idle.c:1854:13: error: static declaration of 'c1e_pro=
motion_enable' follows non-static declaration
   drivers/idle/intel_idle.c:1706:9: note: previous implicit declaration of=
 'c1e_promotion_enable' with type 'void(void)'
    1706 |         c1e_promotion_enable();
         |         ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +1854 drivers/idle/intel_idle.c

1aefbd7aeb7695 Rafael J. Wysocki 2020-01-10  1853  =

da0e58c038e60e Artem Bityutskiy  2022-03-02 @1854  static void c1e_promotio=
n_enable(void)
da0e58c038e60e Artem Bityutskiy  2022-03-02  1855  {
da0e58c038e60e Artem Bityutskiy  2022-03-02  1856  	unsigned long long msr_=
bits;
da0e58c038e60e Artem Bityutskiy  2022-03-02  1857  =

da0e58c038e60e Artem Bityutskiy  2022-03-02  1858  	rdmsrl(MSR_IA32_POWER_C=
TL, msr_bits);
da0e58c038e60e Artem Bityutskiy  2022-03-02  1859  	msr_bits |=3D 0x2;
da0e58c038e60e Artem Bityutskiy  2022-03-02  1860  	wrmsrl(MSR_IA32_POWER_C=
TL, msr_bits);
da0e58c038e60e Artem Bityutskiy  2022-03-02  1861  }
da0e58c038e60e Artem Bityutskiy  2022-03-02  1862  =


:::::: The code at line 1854 was first introduced by commit
:::::: da0e58c038e60e7e65d30813ebdfe91687aa8a24 intel_idle: add 'preferred_=
cstates' module argument

:::::: TO: Artem Bityutskiy <artem.bityutskiy(a)linux.intel.com>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki(a)intel.com>

-- =

0-DAY CI Kernel Test Service
https://01.org/lkp
--===============5288857975873972336==--

