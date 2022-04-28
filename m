Content-Type: multipart/mixed; boundary="===============6010063594483303728=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
Subject: [Devel] [rafael-pm:testing 12/12] drivers/idle/intel_idle.c:1701:17:
 error: 'disable_promotion_to_c1e' undeclared
Date: Thu, 28 Apr 2022 16:56:19 +0800
Message-ID: <202204281634.Ho3eVKJ7-lkp@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6010063594483303728==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git=
 testing
head:   55ecda6f25ef6de769ae64f162828aee4812c313
commit: 55ecda6f25ef6de769ae64f162828aee4812c313 [12/12] Merge branch 'inte=
l-idle' into linux-next
config: x86_64-randconfig-c001 (https://download.01.org/0day-ci/archive/202=
20428/202204281634.Ho3eVKJ7-lkp(a)intel.com/config)
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
        make W=3D1 O=3Dbuild_dir ARCH=3Dx86_64 SHELL=3D/bin/bash drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp(a)intel.com>

All errors (new ones prefixed by >>):

   drivers/idle/intel_idle.c: In function 'adl_idle_state_table_update':
>> drivers/idle/intel_idle.c:1701:17: error: 'disable_promotion_to_c1e' und=
eclared (first use in this function)
    1701 |                 disable_promotion_to_c1e =3D true;
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/idle/intel_idle.c:1701:17: note: each undeclared identifier is r=
eported only once for each function it appears in
>> drivers/idle/intel_idle.c:1706:9: error: implicit declaration of functio=
n 'c1e_promotion_enable' [-Werror=3Dimplicit-function-declaration]
    1706 |         c1e_promotion_enable();
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/idle/intel_idle.c: At top level:
   drivers/idle/intel_idle.c:1854:13: warning: conflicting types for 'c1e_p=
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


vim +/disable_promotion_to_c1e +1701 drivers/idle/intel_idle.c

64233338499126 Chen Yu   2021-05-28  1685  =

cc6e234b826408 Zhang Rui 2022-04-15  1686  /**
cc6e234b826408 Zhang Rui 2022-04-15  1687   * adl_idle_state_table_update -=
 Adjust AlderLake idle states table.
cc6e234b826408 Zhang Rui 2022-04-15  1688   */
cc6e234b826408 Zhang Rui 2022-04-15  1689  static void __init adl_idle_stat=
e_table_update(void)
cc6e234b826408 Zhang Rui 2022-04-15  1690  {
cc6e234b826408 Zhang Rui 2022-04-15  1691  	/* Check if user prefers C1 ove=
r C1E. */
cc6e234b826408 Zhang Rui 2022-04-15  1692  	if (preferred_states_mask & BIT=
(1)) {
cc6e234b826408 Zhang Rui 2022-04-15  1693  		if (preferred_states_mask & BI=
T(2))
cc6e234b826408 Zhang Rui 2022-04-15  1694  			/* Both can't be enabled, sti=
ck to the defaults. */
cc6e234b826408 Zhang Rui 2022-04-15  1695  			goto end;
cc6e234b826408 Zhang Rui 2022-04-15  1696  =

cc6e234b826408 Zhang Rui 2022-04-15  1697  		cpuidle_state_table[0].flags &=
=3D ~CPUIDLE_FLAG_UNUSABLE;
cc6e234b826408 Zhang Rui 2022-04-15  1698  		cpuidle_state_table[1].flags |=
=3D CPUIDLE_FLAG_UNUSABLE;
cc6e234b826408 Zhang Rui 2022-04-15  1699  =

cc6e234b826408 Zhang Rui 2022-04-15  1700  		/* Disable C1E by clearing the=
 "C1E promotion" bit. */
cc6e234b826408 Zhang Rui 2022-04-15 @1701  		disable_promotion_to_c1e =3D t=
rue;
cc6e234b826408 Zhang Rui 2022-04-15  1702  		return;
cc6e234b826408 Zhang Rui 2022-04-15  1703  	}
cc6e234b826408 Zhang Rui 2022-04-15  1704  end:
cc6e234b826408 Zhang Rui 2022-04-15  1705  	/* Make sure C1E is enabled by =
default */
cc6e234b826408 Zhang Rui 2022-04-15 @1706  	c1e_promotion_enable();
cc6e234b826408 Zhang Rui 2022-04-15  1707  }
cc6e234b826408 Zhang Rui 2022-04-15  1708  =


:::::: The code at line 1701 was first introduced by commit
:::::: cc6e234b8264089d11c34f82d6be925281ca52ba intel_idle: Add AlderLake s=
upport

:::::: TO: Zhang Rui <rui.zhang(a)intel.com>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki(a)intel.com>

-- =

0-DAY CI Kernel Test Service
https://01.org/lkp
--===============6010063594483303728==--

