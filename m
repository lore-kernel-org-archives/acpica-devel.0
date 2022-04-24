Content-Type: multipart/mixed; boundary="===============5723699516853278433=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
Subject: [Devel] [rafael-pm:bleeding-edge 8/20] WARNING: modpost:
 vmlinux.o(.text+0xfdc8e4): Section mismatch in reference from the function
 component_compare_dev_name() to the variable .exit.text:.LFB4478
Date: Sun, 24 Apr 2022 14:23:05 +0800
Message-ID: <202204241452.pAvKt2JP-lkp@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5723699516853278433==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git=
 bleeding-edge
head:   f23bedef4354b1e8a69a25d8c9c1201e6d8e8762
commit: 9d66f8243f05815087050993644c46a71ffc3d04 [8/20] Merge branches 'the=
rmal-int340x' and 'thermal-misc' into linux-next
config: riscv-buildonly-randconfig-r002-20220421 (https://download.01.org/0=
day-ci/archive/20220424/202204241452.pAvKt2JP-lkp(a)intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0
reproduce (this is a W=3D1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/=
make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.g=
it/commit/?id=3D9d66f8243f05815087050993644c46a71ffc3d04
        git remote add rafael-pm https://git.kernel.org/pub/scm/linux/kerne=
l/git/rafael/linux-pm.git
        git fetch --no-tags rafael-pm bleeding-edge
        git checkout 9d66f8243f05815087050993644c46a71ffc3d04
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-11.2.0 make.cross=
 W=3D1 O=3Dbuild_dir ARCH=3Driscv SHELL=3D/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp(a)intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text+0xfdc8e4): Section mismatch in referen=
ce from the function component_compare_dev_name() to the variable .exit.tex=
t:.LFB4478
The function component_compare_dev_name() references a variable in an exit =
section.
Often the variable .LFB4478 has valid usage outside the exit section
and the fix is to remove the __exit annotation of .LFB4478.
--
>> WARNING: modpost: vmlinux.o(.text+0x15ff5e0): Section mismatch in refere=
nce from the function dm_stats_init() to the variable .init.text:.L0
The function dm_stats_init() references
the variable __init .L0 .
This is often because dm_stats_init lacks a __init
annotation or the annotation of .L0 is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x1bf624c): Section mismatch in refere=
nce from the function sctp_sched_ops_init() to the variable .init.text:.L0
The function sctp_sched_ops_init() references
the variable __init .L0 .
This is often because sctp_sched_ops_init lacks a __init
annotation or the annotation of .L0 is wrong.

Note: the below error/warnings can be found in parent commit:
<< WARNING: modpost: vmlinux.o(.text+0xcb5b08): Section mismatch in referen=
ce from the function pci_sriov_resource_alignment() to the function .init.t=
ext:sm501fb_driver_init()
<< WARNING: modpost: vmlinux.o(.text+0xfdc8e4): Section mismatch in referen=
ce from the function component_compare_dev_name() to the variable .exit.tex=
t:.LFE4478
<< WARNING: modpost: vmlinux.o(.exit.text+0xe120): Section mismatch in refe=
rence from the function hsr_netlink_exit() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(__ex_table+0x1260): Section mismatch in refe=
rence from the variable .L0 to the variable .rodata:_entry.30
<< WARNING: modpost: vmlinux.o(.text+0x1697378): Section mismatch in refere=
nce from the function btintel_send_intel_reset() to the variable .exit.text=
:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1a9f788): Section mismatch in refere=
nce from the function fib_free_table() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1bf6234): Section mismatch in refere=
nce from the function sctp_sched_ops_register() to the variable .init.text:=
.L0
<< WARNING: modpost: vmlinux.o(.text+0x1bf627c): Section mismatch in refere=
nce from the function sctp_sched_set_sched() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1bf640c): Section mismatch in refere=
nce from the function sctp_sched_get_sched() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xcb5b08): Section mismatch in referen=
ce from the function pci_sriov_resource_alignment() to the function .init.t=
ext:sm501fb_driver_init()
<< WARNING: modpost: vmlinux.o(.text+0xfdc8e4): Section mismatch in referen=
ce from the function component_compare_dev_name() to the variable .exit.tex=
t:.LFE4478
<< WARNING: modpost: vmlinux.o(.exit.text+0xe120): Section mismatch in refe=
rence from the function hsr_netlink_exit() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(__ex_table+0x1260): Section mismatch in refe=
rence from the variable .L0 to the variable .rodata:_entry.30
<< WARNING: modpost: vmlinux.o(.text+0x1697378): Section mismatch in refere=
nce from the function btintel_send_intel_reset() to the variable .exit.text=
:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1a9f788): Section mismatch in refere=
nce from the function fib_free_table() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1bf6234): Section mismatch in refere=
nce from the function sctp_sched_ops_register() to the variable .init.text:=
.L0
<< WARNING: modpost: vmlinux.o(.text+0x1bf627c): Section mismatch in refere=
nce from the function sctp_sched_set_sched() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1bf640c): Section mismatch in refere=
nce from the function sctp_sched_get_sched() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xcb5b08): Section mismatch in referen=
ce from the function pci_sriov_resource_alignment() to the function .init.t=
ext:sm501fb_driver_init()
<< WARNING: modpost: vmlinux.o(.text+0xfdc8e4): Section mismatch in referen=
ce from the function component_compare_dev_name() to the variable .exit.tex=
t:.LFE4478
<< WARNING: modpost: vmlinux.o(.exit.text+0xe120): Section mismatch in refe=
rence from the function hsr_netlink_exit() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(__ex_table+0x1260): Section mismatch in refe=
rence from the variable .L0 to the variable .rodata:_entry.30
<< WARNING: modpost: vmlinux.o(.text+0x1697378): Section mismatch in refere=
nce from the function btintel_send_intel_reset() to the variable .exit.text=
:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1a9f788): Section mismatch in refere=
nce from the function fib_free_table() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1bf6234): Section mismatch in refere=
nce from the function sctp_sched_ops_register() to the variable .init.text:=
.L0
<< WARNING: modpost: vmlinux.o(.text+0x1bf627c): Section mismatch in refere=
nce from the function sctp_sched_set_sched() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1bf640c): Section mismatch in refere=
nce from the function sctp_sched_get_sched() to the variable .init.text:.L0

-- =

0-DAY CI Kernel Test Service
https://01.org/lkp
--===============5723699516853278433==--

