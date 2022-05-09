Content-Type: multipart/mixed; boundary="===============6626050781420108280=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
Subject: [Devel] [rafael-pm:bleeding-edge 4/16] WARNING: modpost:
 vmlinux.o(.text+0xae6ba8): Section mismatch in reference from the function
 img_ir_isr_raw() to the variable .init.text:.LBB2360
Date: Mon, 09 May 2022 19:47:08 +0800
Message-ID: <202205091949.BeE39vLd-lkp@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6626050781420108280==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git=
 bleeding-edge
head:   85595c9b5107be01157871392e1aa1ce065a7ca7
commit: 8dd2434c1ab5239533382fe988c57e8269a0988c [4/16] Merge branch 'devpr=
op' into linux-next
config: riscv-randconfig-r042-20220509 (https://download.01.org/0day-ci/arc=
hive/20220509/202205091949.BeE39vLd-lkp(a)intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.3.0
reproduce (this is a W=3D1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/=
make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.g=
it/commit/?id=3D8dd2434c1ab5239533382fe988c57e8269a0988c
        git remote add rafael-pm https://git.kernel.org/pub/scm/linux/kerne=
l/git/rafael/linux-pm.git
        git fetch --no-tags rafael-pm bleeding-edge
        git checkout 8dd2434c1ab5239533382fe988c57e8269a0988c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-11.3.0 make.cross=
 W=3D1 O=3Dbuild_dir ARCH=3Driscv SHELL=3D/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp(a)intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text+0xae6ba8): Section mismatch in referen=
ce from the function img_ir_isr_raw() to the variable .init.text:.LBB2360
The function img_ir_isr_raw() references
the variable __init .LBB2360.
This is often because img_ir_isr_raw lacks a __init
annotation or the annotation of .LBB2360 is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0xae6bdc): Section mismatch in referen=
ce from the function img_ir_setup_raw() to the variable .init.text:.LBE2360
The function img_ir_setup_raw() references
the variable __init .LBE2360.
This is often because img_ir_setup_raw lacks a __init
annotation or the annotation of .LBE2360 is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0xc031fe): Section mismatch in referen=
ce from the function nvmem_cell_read_u32() to the variable .init.text:.L0
The function nvmem_cell_read_u32() references
the variable __init .L0 .
This is often because nvmem_cell_read_u32 lacks a __init
annotation or the annotation of .L0 is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0xc03208): Section mismatch in referen=
ce from the function nvmem_cell_read_u64() to the variable .init.text:.L0
The function nvmem_cell_read_u64() references
the variable __init .L0 .
This is often because nvmem_cell_read_u64 lacks a __init
annotation or the annotation of .L0 is wrong.
--
>> WARNING: modpost: vmlinux.o(__ex_table+0x1434): Section mismatch in refe=
rence from the variable .L0 to the variable .debug_str:.LASF1599
FATAL: modpost: extable_entry size hasn't been discovered!
--
>> WARNING: modpost: vmlinux.o(.text+0xc02b22): Section mismatch in referen=
ce from the function nvmem_device_find() to the variable .init.text:.L0
The function nvmem_device_find() references
the variable __init .L0 .
This is often because nvmem_device_find lacks a __init
annotation or the annotation of .L0 is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0xc031ea): Section mismatch in referen=
ce from the function nvmem_cell_read_u8() to the variable .init.text:.L0
The function nvmem_cell_read_u8() references
the variable __init .L0 .
This is often because nvmem_cell_read_u8 lacks a __init
annotation or the annotation of .L0 is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0xc031f4): Section mismatch in referen=
ce from the function nvmem_cell_read_u16() to the variable .init.text:.L0
The function nvmem_cell_read_u16() references
the variable __init .L0 .
This is often because nvmem_cell_read_u16 lacks a __init
annotation or the annotation of .L0 is wrong.

Note: the below error/warnings can be found in parent commit:
<< WARNING: modpost: vmlinux.o(.text+0xa740cc): Section mismatch in referen=
ce from the function rtc_month_days() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xb34f2e): Section mismatch in referen=
ce from the function btintel_enter_mfg() to the variable .init.text:.LBB186=
32
<< WARNING: modpost: vmlinux.o(.text+0xc2a6ce): Section mismatch in referen=
ce from the function __sys_recvmsg_sock() to the variable .exit.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xd02eec): Section mismatch in referen=
ce from the function dn_fib_lookup() to the variable .init.text:.LBB1596
<< WARNING: modpost: vmlinux.o(__ex_table+0x141c): Section mismatch in refe=
rence from the variable .L0 to the variable .debug_str:.LASF864
<< WARNING: modpost: vmlinux.o(.text+0xa740cc): Section mismatch in referen=
ce from the function rtc_month_days() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xb34f2e): Section mismatch in referen=
ce from the function btintel_enter_mfg() to the variable .init.text:.LBB186=
32
<< WARNING: modpost: vmlinux.o(.text+0xc2a6ce): Section mismatch in referen=
ce from the function __sys_recvmsg_sock() to the variable .exit.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xd02eec): Section mismatch in referen=
ce from the function dn_fib_lookup() to the variable .init.text:.LBB1596
<< WARNING: modpost: vmlinux.o(__ex_table+0x141c): Section mismatch in refe=
rence from the variable .L0 to the variable .debug_str:.LASF864
<< WARNING: modpost: vmlinux.o(.text+0xa740cc): Section mismatch in referen=
ce from the function rtc_month_days() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xb34f2e): Section mismatch in referen=
ce from the function btintel_enter_mfg() to the variable .init.text:.LBB186=
32
<< WARNING: modpost: vmlinux.o(.text+0xc2a6ce): Section mismatch in referen=
ce from the function __sys_recvmsg_sock() to the variable .exit.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xd02eec): Section mismatch in referen=
ce from the function dn_fib_lookup() to the variable .init.text:.LBB1596
<< WARNING: modpost: vmlinux.o(__ex_table+0x141c): Section mismatch in refe=
rence from the variable .L0 to the variable .debug_str:.LASF864
<< WARNING: modpost: vmlinux.o(.text+0xa740cc): Section mismatch in referen=
ce from the function rtc_month_days() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xb34f2e): Section mismatch in referen=
ce from the function btintel_enter_mfg() to the variable .init.text:.LBB186=
32
<< WARNING: modpost: vmlinux.o(.text+0xc2a6ce): Section mismatch in referen=
ce from the function __sys_recvmsg_sock() to the variable .exit.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xd02eec): Section mismatch in referen=
ce from the function dn_fib_lookup() to the variable .init.text:.LBB1596
<< WARNING: modpost: vmlinux.o(__ex_table+0x141c): Section mismatch in refe=
rence from the variable .L0 to the variable .debug_str:.LASF864
<< WARNING: modpost: vmlinux.o(.text+0xa740cc): Section mismatch in referen=
ce from the function rtc_month_days() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xb34f2e): Section mismatch in referen=
ce from the function btintel_enter_mfg() to the variable .init.text:.LBB186=
32
<< WARNING: modpost: vmlinux.o(.text+0xc2a6ce): Section mismatch in referen=
ce from the function __sys_recvmsg_sock() to the variable .exit.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xd02eec): Section mismatch in referen=
ce from the function dn_fib_lookup() to the variable .init.text:.LBB1596
<< WARNING: modpost: vmlinux.o(__ex_table+0x141c): Section mismatch in refe=
rence from the variable .L0 to the variable .debug_str:.LASF864
<< WARNING: modpost: vmlinux.o(.text+0xa740cc): Section mismatch in referen=
ce from the function rtc_month_days() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xb34f2e): Section mismatch in referen=
ce from the function btintel_enter_mfg() to the variable .init.text:.LBB186=
32
<< WARNING: modpost: vmlinux.o(.text+0xc2a6ce): Section mismatch in referen=
ce from the function __sys_recvmsg_sock() to the variable .exit.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xd02eec): Section mismatch in referen=
ce from the function dn_fib_lookup() to the variable .init.text:.LBB1596
<< WARNING: modpost: vmlinux.o(__ex_table+0x141c): Section mismatch in refe=
rence from the variable .L0 to the variable .debug_str:.LASF864
<< WARNING: modpost: vmlinux.o(.text+0xa740cc): Section mismatch in referen=
ce from the function rtc_month_days() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xb34f2e): Section mismatch in referen=
ce from the function btintel_enter_mfg() to the variable .init.text:.LBB186=
32
<< WARNING: modpost: vmlinux.o(.text+0xc2a6ce): Section mismatch in referen=
ce from the function __sys_recvmsg_sock() to the variable .exit.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xd02eec): Section mismatch in referen=
ce from the function dn_fib_lookup() to the variable .init.text:.LBB1596
<< WARNING: modpost: vmlinux.o(__ex_table+0x141c): Section mismatch in refe=
rence from the variable .L0 to the variable .debug_str:.LASF864
<< WARNING: modpost: vmlinux.o(.text+0xa740cc): Section mismatch in referen=
ce from the function rtc_month_days() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xb34f2e): Section mismatch in referen=
ce from the function btintel_enter_mfg() to the variable .init.text:.LBB186=
32
<< WARNING: modpost: vmlinux.o(.text+0xc2a6ce): Section mismatch in referen=
ce from the function __sys_recvmsg_sock() to the variable .exit.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xd02eec): Section mismatch in referen=
ce from the function dn_fib_lookup() to the variable .init.text:.LBB1596
<< WARNING: modpost: vmlinux.o(__ex_table+0x141c): Section mismatch in refe=
rence from the variable .L0 to the variable .debug_str:.LASF864

-- =

0-DAY CI Kernel Test Service
https://01.org/lkp
--===============6626050781420108280==--

