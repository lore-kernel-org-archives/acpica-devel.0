Content-Type: multipart/mixed; boundary="===============1843887574083014142=="
MIME-Version: 1.0
From: kbuild test robot <lkp at intel.com>
Subject: [Devel] [pm:bleeding-edge 80/85]
 drivers/platform/x86/intel_cht_int33fe.c:98:1-3: WARNING: PTR_ERR_OR_ZERO can
 be used
Date: Wed, 17 Apr 2019 08:52:13 +0800
Message-ID: <201904170807.nArPTXtw%lkp@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1843887574083014142==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git=
 bleeding-edge
head:   98438d88cbe65037744bdc071720389797f9c575
commit: 7ea0bcd165658c84544d5f241126b782d14fbb7f [80/85] platform/x86: inte=
l_cht_int33fe: Register max17047 in its own function


coccinelle warnings: (new ones prefixed by >>)

>> drivers/platform/x86/intel_cht_int33fe.c:98:1-3: WARNING: PTR_ERR_OR_ZER=
O can be used

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Cent=
er
https://lists.01.org/pipermail/kbuild-all                   Intel Corporati=
on

--===============1843887574083014142==--

