Content-Type: multipart/mixed; boundary="===============2423375218628031668=="
MIME-Version: 1.0
From: kbuild test robot <lkp at intel.com>
Subject: Re: [Devel] [PATCH 1/3 v7] battery: Add the battery hooking API
Date: Sat, 23 Dec 2017 19:04:30 +0800
Message-ID: <201712231804.7u889GA9%fengguang.wu@intel.com>
In-Reply-To: 20171220151536.GA12278@thinkpad
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2423375218628031668==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ognjen,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on platform-drivers-x86/for-next]
[also build test WARNING on v4.15-rc4 next-20171222]
[cannot apply to pm/linux-next]
[if your patch is applied to the wrong git tree, please drop us a note to h=
elp improve the system]

url:    https://github.com/0day-ci/linux/commits/Ognjen-Galic/battery-Add-t=
he-battery-hooking-API/20171223-144855
base:   git://git.infradead.org/users/dvhart/linux-platform-drivers-x86.git=
 for-next
reproduce:
        # apt-get install sparse
        make ARCH=3Dx86_64 allmodconfig
        make C=3D1 CF=3D-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)


Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Cent=
er
https://lists.01.org/pipermail/kbuild-all                   Intel Corporati=
on

--===============2423375218628031668==--

