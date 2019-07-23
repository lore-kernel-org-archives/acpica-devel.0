Content-Type: multipart/mixed; boundary="===============1017021326531518255=="
MIME-Version: 1.0
From: kbuild test robot <lkp at intel.com>
Subject: [Devel] [pm:bleeding-edge 21/23]
 drivers/base/power/wakeup_stats.c:143:1-3: WARNING: PTR_ERR_OR_ZERO can be
 used
Date: Tue, 23 Jul 2019 22:03:37 +0800
Message-ID: <201907232235.iRDGgF0x%lkp@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1017021326531518255==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/rafael/lin=
ux-pm.git bleeding-edge
head:   14b99dcec44e7bca9f01e042002f57e9f0dda133
commit: 0b050f7fb8a1e45c72ca945bac2821a59d4a0101 [21/23] PM / wakeup: show =
wakeup sources stats in sysfs

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp(a)intel.com>


coccinelle warnings: (new ones prefixed by >>)

>> drivers/base/power/wakeup_stats.c:143:1-3: WARNING: PTR_ERR_OR_ZERO can =
be used

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Cent=
er
https://lists.01.org/pipermail/kbuild-all                   Intel Corporati=
on

--===============1017021326531518255==--

