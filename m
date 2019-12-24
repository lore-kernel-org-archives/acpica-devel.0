Content-Type: multipart/mixed; boundary="===============3679071386274485402=="
MIME-Version: 1.0
From: kbuild test robot <lkp at intel.com>
Subject: [Devel] [pm:bleeding-edge 59/60]
 drivers/power/avs/qcom-cpr.c:1081:15: sparse: sparse: symbol
 'cpr_get_opp_hz_for_req' was not declared. Should it be static?
Date: Wed, 25 Dec 2019 06:18:33 +0800
Message-ID: <201912250622.SScsrif7%lkp@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3679071386274485402==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git=
 bleeding-edge
head:   89eba9e38dc4ed4576eaf7711c60403568663291
commit: bf6910abf54871b0e976e52f56fb3b3dd1b90e48 [59/60] power: avs: Add su=
pport for CPR (Core Power Reduction)
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-129-g341daf20-dirty
        git checkout bf6910abf54871b0e976e52f56fb3b3dd1b90e48
        make ARCH=3Dx86_64 allmodconfig
        make C=3D1 CF=3D'-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp(a)intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/power/avs/qcom-cpr.c:1081:15: sparse: sparse: symbol 'cpr_get_op=
p_hz_for_req' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                 Open Source Technology Cen=
ter
https://lists.01.org/hyperkitty/list/kbuild-all(a)lists.01.org Intel Corpor=
ation
--===============3679071386274485402==--

