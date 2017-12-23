Content-Type: multipart/mixed; boundary="===============6261468855257556596=="
MIME-Version: 1.0
From: kbuild test robot <lkp at intel.com>
Subject: Re: [Devel] [PATCH 1/3 v7] battery: Add the battery hooking API
Date: Sat, 23 Dec 2017 15:36:47 +0800
Message-ID: <201712231549.Qs1NnfLn%fengguang.wu@intel.com>
In-Reply-To: 20171220151536.GA12278@thinkpad
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6261468855257556596==
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
config: i386-randconfig-x007-201751 (attached as .config)
compiler: gcc-7 (Debian 7.2.0-12) 7.2.1 20171025
reproduce:
        # save the attached .config to linux build tree
        make ARCH=3Di386 =


All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:10:0,
                    from drivers//acpi/battery.c:24:
   drivers//acpi/battery.c: In function 'acpi_battery_exit':
   include/linux/compiler.h:58:2: warning: this 'if' clause does not guard.=
.. [-Wmisleading-indentation]
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
     ^
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
>> drivers//acpi/battery.c:1532:2: note: in expansion of macro 'if'
     if (battery_driver_registered)
     ^~
   drivers//acpi/battery.c:1534:3: note: ...this statement, but the latter =
is misleadingly indented as if it were guarded by the 'if'
      battery_hook_exit();
      ^~~~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:10:0,
                    from drivers//acpi/battery.c:24:
   drivers//acpi/battery.c: At top level:
   include/linux/compiler.h:64:4: warning: '______f' is static but declared=
 in inline function 'strcpy' which is not static
       ______f =3D {     \
       ^
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:422:2: note: in expansion of macro 'if'
     if (p_size =3D=3D (size_t)-1 && q_size =3D=3D (size_t)-1)
     ^~
   include/linux/compiler.h:64:4: warning: '______f' is static but declared=
 in inline function 'kmemdup' which is not static
       ______f =3D {     \
       ^
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:412:2: note: in expansion of macro 'if'
     if (p_size < size)
     ^~
   include/linux/compiler.h:64:4: warning: '______f' is static but declared=
 in inline function 'kmemdup' which is not static
       ______f =3D {     \
       ^
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:410:2: note: in expansion of macro 'if'
     if (__builtin_constant_p(size) && p_size < size)
     ^~
   include/linux/compiler.h:64:4: warning: '______f' is static but declared=
 in inline function 'memchr_inv' which is not static
       ______f =3D {     \
       ^
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:401:2: note: in expansion of macro 'if'
     if (p_size < size)
     ^~
   include/linux/compiler.h:64:4: warning: '______f' is static but declared=
 in inline function 'memchr_inv' which is not static
       ______f =3D {     \
       ^
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:399:2: note: in expansion of macro 'if'
     if (__builtin_constant_p(size) && p_size < size)
     ^~
   include/linux/compiler.h:64:4: warning: '______f' is static but declared=
 in inline function 'memchr' which is not static
       ______f =3D {     \
       ^
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:390:2: note: in expansion of macro 'if'
     if (p_size < size)
     ^~
   include/linux/compiler.h:64:4: warning: '______f' is static but declared=
 in inline function 'memchr' which is not static
       ______f =3D {     \
       ^
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:388:2: note: in expansion of macro 'if'
     if (__builtin_constant_p(size) && p_size < size)
     ^~
   include/linux/compiler.h:64:4: warning: '______f' is static but declared=
 in inline function 'memcmp' which is not static
       ______f =3D {     \
       ^
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:380:2: note: in expansion of macro 'if'
     if (p_size < size || q_size < size)
     ^~
   include/linux/compiler.h:64:4: warning: '______f' is static but declared=
 in inline function 'memcmp' which is not static
       ______f =3D {     \
       ^
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:377:3: note: in expansion of macro 'if'
      if (q_size < size)
      ^~
   include/linux/compiler.h:64:4: warning: '______f' is static but declared=
 in inline function 'memcmp' which is not static
       ______f =3D {     \
       ^
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:375:3: note: in expansion of macro 'if'
      if (p_size < size)
      ^~
   include/linux/compiler.h:64:4: warning: '______f' is static but declared=
 in inline function 'memcmp' which is not static
       ______f =3D {     \

vim +/if +1532 drivers//acpi/battery.c

^1da177e Linus Torvalds 2005-04-16  1528  =

4be44fcd Len Brown      2005-08-05  1529  static void __exit acpi_battery_e=
xit(void)
^1da177e Linus Torvalds 2005-04-16  1530  {
5dfa0c73 Chris Wilson   2016-05-19  1531  	async_synchronize_cookie(async_c=
ookie + 1);
bc39fbcf Hans de Goede  2017-04-19 @1532  	if (battery_driver_registered)
^1da177e Linus Torvalds 2005-04-16  1533  		acpi_bus_unregister_driver(&acp=
i_battery_driver);
19380b8e Ognjen Galic   2017-12-20  1534  		battery_hook_exit();
3a670cc7 Lan Tianyu     2014-05-04  1535  #ifdef CONFIG_ACPI_PROCFS_POWER
bc39fbcf Hans de Goede  2017-04-19  1536  	if (acpi_battery_dir)
3a670cc7 Lan Tianyu     2014-05-04  1537  		acpi_unlock_battery_dir(acpi_ba=
ttery_dir);
3a670cc7 Lan Tianyu     2014-05-04  1538  #endif
^1da177e Linus Torvalds 2005-04-16  1539  }
^1da177e Linus Torvalds 2005-04-16  1540  =


:::::: The code at line 1532 was first introduced by commit
:::::: bc39fbcf9c782970263bdc5b428e4a755db16efb ACPI / battery: Fix acpi_ba=
ttery_exit on acpi_battery_init_async errors

:::::: TO: Hans de Goede <hdegoede(a)redhat.com>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki(a)intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Cent=
er
https://lists.01.org/pipermail/kbuild-all                   Intel Corporati=
on

--===============6261468855257556596==
Content-Type: application/gzip
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="config.gz"

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
--===============6261468855257556596==--

