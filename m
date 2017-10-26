Content-Type: multipart/mixed; boundary="===============4118148012472177039=="
MIME-Version: 1.0
From: kbuild test robot <fengguang.wu at intel.com>
Subject: [Devel] [pm:bleeding-edge 87/88] include/linux/export.h:67:20: error:
 redefinition of '__kstrtab_acpi_subsys_freeze_noirq'
Date: Thu, 26 Oct 2017 20:04:01 +0800
Message-ID: <201710262056.ARceox7e%fengguang.wu@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4118148012472177039==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git=
 bleeding-edge
head:   9b3e83b2d7070805ab1890f18d0b3f2cdf177786
commit: e1a07b46a16732e00be7d1be004858fbbc524740 [87/88] ACPI / PM: Take SM=
ART_SUSPEND driver flag into account
config: i386-randconfig-x074-201743 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout e1a07b46a16732e00be7d1be004858fbbc524740
        # save the attached .config to linux build tree
        make ARCH=3Di386 =


All error/warnings (new ones prefixed by >>):

   In file included from include/linux/linkage.h:6:0,
                    from include/linux/kernel.h:6,
                    from include/linux/list.h:8,
                    from include/linux/resource_ext.h:17,
                    from include/linux/acpi.h:26,
                    from drivers/acpi/device_pm.c:21:
>> include/linux/export.h:67:20: error: redefinition of '__kstrtab_acpi_sub=
sys_freeze_noirq'
     static const char __kstrtab_##sym[]    \
                       ^
   include/linux/export.h:100:25: note: in expansion of macro '___EXPORT_SY=
MBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^~~~~~~~~~~~~~~~
   include/linux/export.h:107:2: note: in expansion of macro '__EXPORT_SYMB=
OL'
     __EXPORT_SYMBOL(sym, "_gpl")
     ^~~~~~~~~~~~~~~
>> drivers/acpi/device_pm.c:1144:1: note: in expansion of macro 'EXPORT_SYM=
BOL_GPL'
    EXPORT_SYMBOL_GPL(acpi_subsys_freeze_noirq);
    ^~~~~~~~~~~~~~~~~
   include/linux/export.h:67:20: note: previous definition of '__kstrtab_ac=
pi_subsys_freeze_noirq' was here
     static const char __kstrtab_##sym[]    \
                       ^
   include/linux/export.h:100:25: note: in expansion of macro '___EXPORT_SY=
MBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^~~~~~~~~~~~~~~~
   include/linux/export.h:107:2: note: in expansion of macro '__EXPORT_SYMB=
OL'
     __EXPORT_SYMBOL(sym, "_gpl")
     ^~~~~~~~~~~~~~~
   drivers/acpi/device_pm.c:1124:1: note: in expansion of macro 'EXPORT_SYM=
BOL_GPL'
    EXPORT_SYMBOL_GPL(acpi_subsys_freeze_noirq);
    ^~~~~~~~~~~~~~~~~
   include/linux/export.h:70:36: error: redefinition of '__ksymtab_acpi_sub=
sys_freeze_noirq'
     static const struct kernel_symbol __ksymtab_##sym  \
                                       ^
   include/linux/export.h:100:25: note: in expansion of macro '___EXPORT_SY=
MBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^~~~~~~~~~~~~~~~
   include/linux/export.h:107:2: note: in expansion of macro '__EXPORT_SYMB=
OL'
     __EXPORT_SYMBOL(sym, "_gpl")
     ^~~~~~~~~~~~~~~
>> drivers/acpi/device_pm.c:1144:1: note: in expansion of macro 'EXPORT_SYM=
BOL_GPL'
    EXPORT_SYMBOL_GPL(acpi_subsys_freeze_noirq);
    ^~~~~~~~~~~~~~~~~
   include/linux/export.h:70:36: note: previous definition of '__ksymtab_ac=
pi_subsys_freeze_noirq' was here
     static const struct kernel_symbol __ksymtab_##sym  \
                                       ^
   include/linux/export.h:100:25: note: in expansion of macro '___EXPORT_SY=
MBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^~~~~~~~~~~~~~~~
   include/linux/export.h:107:2: note: in expansion of macro '__EXPORT_SYMB=
OL'
     __EXPORT_SYMBOL(sym, "_gpl")
     ^~~~~~~~~~~~~~~
   drivers/acpi/device_pm.c:1124:1: note: in expansion of macro 'EXPORT_SYM=
BOL_GPL'
    EXPORT_SYMBOL_GPL(acpi_subsys_freeze_noirq);
    ^~~~~~~~~~~~~~~~~
--
   In file included from include/linux/linkage.h:6:0,
                    from include/linux/kernel.h:6,
                    from include/linux/list.h:8,
                    from include/linux/resource_ext.h:17,
                    from include/linux/acpi.h:26,
                    from drivers//acpi/device_pm.c:21:
>> include/linux/export.h:67:20: error: redefinition of '__kstrtab_acpi_sub=
sys_freeze_noirq'
     static const char __kstrtab_##sym[]    \
                       ^
   include/linux/export.h:100:25: note: in expansion of macro '___EXPORT_SY=
MBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^~~~~~~~~~~~~~~~
   include/linux/export.h:107:2: note: in expansion of macro '__EXPORT_SYMB=
OL'
     __EXPORT_SYMBOL(sym, "_gpl")
     ^~~~~~~~~~~~~~~
   drivers//acpi/device_pm.c:1144:1: note: in expansion of macro 'EXPORT_SY=
MBOL_GPL'
    EXPORT_SYMBOL_GPL(acpi_subsys_freeze_noirq);
    ^~~~~~~~~~~~~~~~~
   include/linux/export.h:67:20: note: previous definition of '__kstrtab_ac=
pi_subsys_freeze_noirq' was here
     static const char __kstrtab_##sym[]    \
                       ^
   include/linux/export.h:100:25: note: in expansion of macro '___EXPORT_SY=
MBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^~~~~~~~~~~~~~~~
   include/linux/export.h:107:2: note: in expansion of macro '__EXPORT_SYMB=
OL'
     __EXPORT_SYMBOL(sym, "_gpl")
     ^~~~~~~~~~~~~~~
   drivers//acpi/device_pm.c:1124:1: note: in expansion of macro 'EXPORT_SY=
MBOL_GPL'
    EXPORT_SYMBOL_GPL(acpi_subsys_freeze_noirq);
    ^~~~~~~~~~~~~~~~~
   include/linux/export.h:70:36: error: redefinition of '__ksymtab_acpi_sub=
sys_freeze_noirq'
     static const struct kernel_symbol __ksymtab_##sym  \
                                       ^
   include/linux/export.h:100:25: note: in expansion of macro '___EXPORT_SY=
MBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^~~~~~~~~~~~~~~~
   include/linux/export.h:107:2: note: in expansion of macro '__EXPORT_SYMB=
OL'
     __EXPORT_SYMBOL(sym, "_gpl")
     ^~~~~~~~~~~~~~~
   drivers//acpi/device_pm.c:1144:1: note: in expansion of macro 'EXPORT_SY=
MBOL_GPL'
    EXPORT_SYMBOL_GPL(acpi_subsys_freeze_noirq);
    ^~~~~~~~~~~~~~~~~
   include/linux/export.h:70:36: note: previous definition of '__ksymtab_ac=
pi_subsys_freeze_noirq' was here
     static const struct kernel_symbol __ksymtab_##sym  \
                                       ^
   include/linux/export.h:100:25: note: in expansion of macro '___EXPORT_SY=
MBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^~~~~~~~~~~~~~~~
   include/linux/export.h:107:2: note: in expansion of macro '__EXPORT_SYMB=
OL'
     __EXPORT_SYMBOL(sym, "_gpl")
     ^~~~~~~~~~~~~~~
   drivers//acpi/device_pm.c:1124:1: note: in expansion of macro 'EXPORT_SY=
MBOL_GPL'
    EXPORT_SYMBOL_GPL(acpi_subsys_freeze_noirq);
    ^~~~~~~~~~~~~~~~~

vim +/__kstrtab_acpi_subsys_freeze_noirq +67 include/linux/export.h

f5016932 Paul Gortmaker  2011-05-23  62  =

f5016932 Paul Gortmaker  2011-05-23  63  /* For every exported symbol, plac=
e a struct in the __ksymtab section */
f2355416 Nicolas Pitre   2016-01-22  64  #define ___EXPORT_SYMBOL(sym, sec)=
					\
f5016932 Paul Gortmaker  2011-05-23  65  	extern typeof(sym) sym;						\
f5016932 Paul Gortmaker  2011-05-23  66  	__CRC_SYMBOL(sym, sec)						\
f5016932 Paul Gortmaker  2011-05-23 @67  	static const char __kstrtab_##sym=
[]				\
f5016932 Paul Gortmaker  2011-05-23  68  	__attribute__((section("__ksymtab=
_strings"), aligned(1)))	\
b92021b0 Rusty Russell   2013-03-15  69  	=3D VMLINUX_SYMBOL_STR(sym);					\
b67067f1 Nicholas Piggin 2016-08-24  70  	static const struct kernel_symbol=
 __ksymtab_##sym		\
f5016932 Paul Gortmaker  2011-05-23  71  	__used								\
b67067f1 Nicholas Piggin 2016-08-24  72  	__attribute__((section("___ksymta=
b" sec "+" #sym), used))	\
f5016932 Paul Gortmaker  2011-05-23  73  	=3D { (unsigned long)&sym, __kstr=
tab_##sym }
f5016932 Paul Gortmaker  2011-05-23  74  =


:::::: The code at line 67 was first introduced by commit
:::::: f50169324df4ad942e544386d136216c8617636a module.h: split out the EXP=
ORT_SYMBOL into export.h

:::::: TO: Paul Gortmaker <paul.gortmaker(a)windriver.com>
:::::: CC: Paul Gortmaker <paul.gortmaker(a)windriver.com>

---
0-DAY kernel test infrastructure                Open Source Technology Cent=
er
https://lists.01.org/pipermail/kbuild-all                   Intel Corporati=
on

--===============4118148012472177039==
Content-Type: application/gzip
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="config.gz"

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
oGXjfefugP8B+4twJoaMAQA=
--===============4118148012472177039==--

