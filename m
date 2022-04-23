Content-Type: multipart/mixed; boundary="===============8877865679706953256=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
Subject: [Devel] [rafael-pm:bleeding-edge 7/20] WARNING: modpost:
 vmlinux.o(.exit.text+0xe120): Section mismatch in reference from the function
 hsr_netlink_exit() to the variable .init.text:.L0
Date: Sun, 24 Apr 2022 02:32:14 +0800
Message-ID: <202204240259.PyW8hsJz-lkp@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8877865679706953256==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git=
 bleeding-edge
head:   f23bedef4354b1e8a69a25d8c9c1201e6d8e8762
commit: 989108f9dfffcaebab87d8b37aa7d4d9d10d2745 [7/20] Merge branch 'devpr=
op' into linux-next
config: riscv-buildonly-randconfig-r002-20220421 (https://download.01.org/0=
day-ci/archive/20220424/202204240259.PyW8hsJz-lkp(a)intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0
reproduce (this is a W=3D1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/=
make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.g=
it/commit/?id=3D989108f9dfffcaebab87d8b37aa7d4d9d10d2745
        git remote add rafael-pm https://git.kernel.org/pub/scm/linux/kerne=
l/git/rafael/linux-pm.git
        git fetch --no-tags rafael-pm bleeding-edge
        git checkout 989108f9dfffcaebab87d8b37aa7d4d9d10d2745
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-11.2.0 make.cross=
 W=3D1 O=3Dbuild_dir ARCH=3Driscv SHELL=3D/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp(a)intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.exit.text+0xe120): Section mismatch in refe=
rence from the function hsr_netlink_exit() to the variable .init.text:.L0
The function __exit hsr_netlink_exit() references
a variable __init .L0 .
This is often seen when error handling in the exit function
uses functionality in the init path.
The fix is often to remove the __init annotation of
.L0 so it may be used outside an init section.
--
>> WARNING: modpost: vmlinux.o(__ex_table+0x1260): Section mismatch in refe=
rence from the variable .L0 to the variable .rodata:_entry.30
FATAL: modpost: extable_entry size hasn't been discovered!
--
>> WARNING: modpost: vmlinux.o(.text+0x1697378): Section mismatch in refere=
nce from the function btintel_send_intel_reset() to the variable .exit.text=
:.L0
The function btintel_send_intel_reset() references a variable in an exit se=
ction.
Often the variable .L0 has valid usage outside the exit section
and the fix is to remove the __exit annotation of .L0 .
--
>> WARNING: modpost: vmlinux.o(.text+0x1bf6234): Section mismatch in refere=
nce from the function sctp_sched_ops_register() to the variable .init.text:=
.L0
The function sctp_sched_ops_register() references
the variable __init .L0 .
This is often because sctp_sched_ops_register lacks a __init
annotation or the annotation of .L0 is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x1bf627c): Section mismatch in refere=
nce from the function sctp_sched_set_sched() to the variable .init.text:.L0
The function sctp_sched_set_sched() references
the variable __init .L0 .
This is often because sctp_sched_set_sched lacks a __init
annotation or the annotation of .L0 is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x1bf640c): Section mismatch in refere=
nce from the function sctp_sched_get_sched() to the variable .init.text:.L0
The function sctp_sched_get_sched() references
the variable __init .L0 .
This is often because sctp_sched_get_sched lacks a __init
annotation or the annotation of .L0 is wrong.

Note: the below error/warnings can be found in parent commit:
<< WARNING: modpost: vmlinux.o(.text+0x66d448): Section mismatch in referen=
ce from the function nilfs_segbuf_free() to the variable .exit.text:.LVL12
<< WARNING: modpost: vmlinux.o(.text+0x15a8b7c): Section mismatch in refere=
nce from the function bch_keybuf_init() to the variable .init.text:.LVL52
<< WARNING: modpost: vmlinux.o(.text+0x1aa0df0): Section mismatch in refere=
nce from the function ping_seq_stop() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1aa2298): Section mismatch in refere=
nce from the function ping_common_sendmsg() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1aa2e08): Section mismatch in refere=
nce from the function ping_proc_exit() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1aeca5c): Section mismatch in refere=
nce from the function x25_limit_facilities() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(__ex_table+0x1260): Section mismatch in refe=
rence from the variable .L0 to the variable .debug_loc:.LLST136
<< WARNING: modpost: vmlinux.o(.text+0x66d448): Section mismatch in referen=
ce from the function nilfs_segbuf_free() to the variable .exit.text:.LVL12
<< WARNING: modpost: vmlinux.o(.text+0x15a8b7c): Section mismatch in refere=
nce from the function bch_keybuf_init() to the variable .init.text:.LVL52
<< WARNING: modpost: vmlinux.o(.text+0x1aa0df0): Section mismatch in refere=
nce from the function ping_seq_stop() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1aa2298): Section mismatch in refere=
nce from the function ping_common_sendmsg() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1aa2e08): Section mismatch in refere=
nce from the function ping_proc_exit() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1aeca5c): Section mismatch in refere=
nce from the function x25_limit_facilities() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(__ex_table+0x1260): Section mismatch in refe=
rence from the variable .L0 to the variable .debug_loc:.LLST136
<< WARNING: modpost: vmlinux.o(.text+0x66d448): Section mismatch in referen=
ce from the function nilfs_segbuf_free() to the variable .exit.text:.LVL12
<< WARNING: modpost: vmlinux.o(.text+0x15a8b7c): Section mismatch in refere=
nce from the function bch_keybuf_init() to the variable .init.text:.LVL52
<< WARNING: modpost: vmlinux.o(.text+0x1aa0df0): Section mismatch in refere=
nce from the function ping_seq_stop() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1aa2298): Section mismatch in refere=
nce from the function ping_common_sendmsg() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1aa2e08): Section mismatch in refere=
nce from the function ping_proc_exit() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1aeca5c): Section mismatch in refere=
nce from the function x25_limit_facilities() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(__ex_table+0x1260): Section mismatch in refe=
rence from the variable .L0 to the variable .debug_loc:.LLST136
<< WARNING: modpost: vmlinux.o(.text+0x66d448): Section mismatch in referen=
ce from the function nilfs_segbuf_free() to the variable .exit.text:.LVL12
<< WARNING: modpost: vmlinux.o(.text+0x15a8b7c): Section mismatch in refere=
nce from the function bch_keybuf_init() to the variable .init.text:.LVL52
<< WARNING: modpost: vmlinux.o(.text+0x1aa0df0): Section mismatch in refere=
nce from the function ping_seq_stop() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1aa2298): Section mismatch in refere=
nce from the function ping_common_sendmsg() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1aa2e08): Section mismatch in refere=
nce from the function ping_proc_exit() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1aeca5c): Section mismatch in refere=
nce from the function x25_limit_facilities() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(__ex_table+0x1260): Section mismatch in refe=
rence from the variable .L0 to the variable .debug_loc:.LLST136
<< WARNING: modpost: vmlinux.o(.text+0x66d448): Section mismatch in referen=
ce from the function nilfs_segbuf_free() to the variable .exit.text:.LVL12
<< WARNING: modpost: vmlinux.o(.text+0x15a8b7c): Section mismatch in refere=
nce from the function bch_keybuf_init() to the variable .init.text:.LVL52
<< WARNING: modpost: vmlinux.o(.text+0x1aa0df0): Section mismatch in refere=
nce from the function ping_seq_stop() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1aa2298): Section mismatch in refere=
nce from the function ping_common_sendmsg() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1aa2e08): Section mismatch in refere=
nce from the function ping_proc_exit() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1aeca5c): Section mismatch in refere=
nce from the function x25_limit_facilities() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(__ex_table+0x1260): Section mismatch in refe=
rence from the variable .L0 to the variable .debug_loc:.LLST136
<< WARNING: modpost: vmlinux.o(.text+0x66d448): Section mismatch in referen=
ce from the function nilfs_segbuf_free() to the variable .exit.text:.LVL12
<< WARNING: modpost: vmlinux.o(.text+0x15a8b7c): Section mismatch in refere=
nce from the function bch_keybuf_init() to the variable .init.text:.LVL52
<< WARNING: modpost: vmlinux.o(.text+0x1aa0df0): Section mismatch in refere=
nce from the function ping_seq_stop() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1aa2298): Section mismatch in refere=
nce from the function ping_common_sendmsg() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1aa2e08): Section mismatch in refere=
nce from the function ping_proc_exit() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1aeca5c): Section mismatch in refere=
nce from the function x25_limit_facilities() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(__ex_table+0x1260): Section mismatch in refe=
rence from the variable .L0 to the variable .debug_loc:.LLST136

-- =

0-DAY CI Kernel Test Service
https://01.org/lkp
--===============8877865679706953256==--

