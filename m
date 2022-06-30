Content-Type: multipart/mixed; boundary="===============1537176873006268996=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
Subject: [Devel] [rafael-pm:bleeding-edge 37/63]
 include/linux/compiler_types.h:293:27: error: expression in static assertion
 is not an integer
Date: Thu, 30 Jun 2022 15:11:37 +0800
Message-ID: <202206301543.JpCxX65V-lkp@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1537176873006268996==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git=
 bleeding-edge
head:   7451d4b13852834afd17b629fb7d4410cefba74c
commit: 022b762e0e96a96bbc1ec271f59c2f6adf1d594b [37/63] ACPI: bus: Drop un=
used list heads from struct acpi_device
config: ia64-allmodconfig (https://download.01.org/0day-ci/archive/20220630=
/202206301543.JpCxX65V-lkp(a)intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=3D1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/=
make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.g=
it/commit/?id=3D022b762e0e96a96bbc1ec271f59c2f6adf1d594b
        git remote add rafael-pm https://git.kernel.org/pub/scm/linux/kerne=
l/git/rafael/linux-pm.git
        git fetch --no-tags rafael-pm bleeding-edge
        git checkout 022b762e0e96a96bbc1ec271f59c2f6adf1d594b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-11.3.0 make.cross=
 W=3D1 O=3Dbuild_dir ARCH=3Dia64 SHELL=3D/bin/bash drivers/bus/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp(a)intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/list.h:5,
                    from include/linux/kobject.h:19,
                    from include/linux/of.h:17,
                    from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from drivers/bus/hisi_lpc.c:9:
   drivers/bus/hisi_lpc.c: In function 'hisi_lpc_acpi_probe':
   drivers/bus/hisi_lpc.c:511:41: error: 'struct acpi_device' has no member=
 named 'children'
     511 |         list_for_each_entry(child, &adev->children, node) {
         |                                         ^~
   include/linux/container_of.h:18:33: note: in definition of macro 'contai=
ner_of'
      18 |         void *__mptr =3D (void *)(ptr);                         =
          \
         |                                 ^~~
   include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
     531 |         list_entry((ptr)->next, type, member)
         |         ^~~~~~~~~~
   include/linux/list.h:674:20: note: in expansion of macro 'list_first_ent=
ry'
     674 |         for (pos =3D list_first_entry(head, typeof(*pos), member=
);        \
         |                    ^~~~~~~~~~~~~~~~
   drivers/bus/hisi_lpc.c:511:9: note: in expansion of macro 'list_for_each=
_entry'
     511 |         list_for_each_entry(child, &adev->children, node) {
         |         ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/bits.h:22,
                    from include/linux/ioport.h:13,
                    from include/linux/acpi.h:12,
                    from drivers/bus/hisi_lpc.c:9:
   drivers/bus/hisi_lpc.c:511:41: error: 'struct acpi_device' has no member=
 named 'children'
     511 |         list_for_each_entry(child, &adev->children, node) {
         |                                         ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_=
assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:19:9: note: in expansion of macro 'static_a=
ssert'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) |=
|       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:19:23: note: in expansion of macro '__same_=
type'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) |=
|       \
         |                       ^~~~~~~~~~~
   include/linux/list.h:520:9: note: in expansion of macro 'container_of'
     520 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
     531 |         list_entry((ptr)->next, type, member)
         |         ^~~~~~~~~~
   include/linux/list.h:674:20: note: in expansion of macro 'list_first_ent=
ry'
     674 |         for (pos =3D list_first_entry(head, typeof(*pos), member=
);        \
         |                    ^~~~~~~~~~~~~~~~
   drivers/bus/hisi_lpc.c:511:9: note: in expansion of macro 'list_for_each=
_entry'
     511 |         list_for_each_entry(child, &adev->children, node) {
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/bus/hisi_lpc.c:511:53: error: 'struct acpi_device' has no member=
 named 'node'; did you mean 'fwnode'?
     511 |         list_for_each_entry(child, &adev->children, node) {
         |                                                     ^~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_=
assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:19:9: note: in expansion of macro 'static_a=
ssert'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) |=
|       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:19:23: note: in expansion of macro '__same_=
type'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) |=
|       \
         |                       ^~~~~~~~~~~
   include/linux/list.h:520:9: note: in expansion of macro 'container_of'
     520 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
     531 |         list_entry((ptr)->next, type, member)
         |         ^~~~~~~~~~
   include/linux/list.h:674:20: note: in expansion of macro 'list_first_ent=
ry'
     674 |         for (pos =3D list_first_entry(head, typeof(*pos), member=
);        \
         |                    ^~~~~~~~~~~~~~~~
   drivers/bus/hisi_lpc.c:511:9: note: in expansion of macro 'list_for_each=
_entry'
     511 |         list_for_each_entry(child, &adev->children, node) {
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/bus/hisi_lpc.c:511:41: error: 'struct acpi_device' has no member=
 named 'children'
     511 |         list_for_each_entry(child, &adev->children, node) {
         |                                         ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_=
assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:19:9: note: in expansion of macro 'static_a=
ssert'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) |=
|       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_=
type'
      20 |                       __same_type(*(ptr), void),                =
        \
         |                       ^~~~~~~~~~~
   include/linux/list.h:520:9: note: in expansion of macro 'container_of'
     520 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
     531 |         list_entry((ptr)->next, type, member)
         |         ^~~~~~~~~~
   include/linux/list.h:674:20: note: in expansion of macro 'list_first_ent=
ry'
     674 |         for (pos =3D list_first_entry(head, typeof(*pos), member=
);        \
         |                    ^~~~~~~~~~~~~~~~
   drivers/bus/hisi_lpc.c:511:9: note: in expansion of macro 'list_for_each=
_entry'
     511 |         list_for_each_entry(child, &adev->children, node) {
         |         ^~~~~~~~~~~~~~~~~~~
>> include/linux/compiler_types.h:293:27: error: expression in static asser=
tion is not an integer
     293 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a)=
, typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_=
assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:19:9: note: in expansion of macro 'static_a=
ssert'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) |=
|       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:19:23: note: in expansion of macro '__same_=
type'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) |=
|       \
         |                       ^~~~~~~~~~~
   include/linux/list.h:520:9: note: in expansion of macro 'container_of'
     520 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
     531 |         list_entry((ptr)->next, type, member)
         |         ^~~~~~~~~~
   include/linux/list.h:674:20: note: in expansion of macro 'list_first_ent=
ry'
     674 |         for (pos =3D list_first_entry(head, typeof(*pos), member=
);        \
         |                    ^~~~~~~~~~~~~~~~
   drivers/bus/hisi_lpc.c:511:9: note: in expansion of macro 'list_for_each=
_entry'
     511 |         list_for_each_entry(child, &adev->children, node) {
         |         ^~~~~~~~~~~~~~~~~~~
   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/kasan-checks.h:5,
                    from include/asm-generic/rwonce.h:26,
                    from ./arch/ia64/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:248,
                    from include/linux/build_bug.h:5,
                    from include/linux/bits.h:22,
                    from include/linux/ioport.h:13,
                    from include/linux/acpi.h:12,
                    from drivers/bus/hisi_lpc.c:9:
   drivers/bus/hisi_lpc.c:511:53: error: 'struct acpi_device' has no member=
 named 'node'; did you mean 'fwnode'?
     511 |         list_for_each_entry(child, &adev->children, node) {
         |                                                     ^~~~
   include/linux/stddef.h:16:58: note: in definition of macro 'offsetof'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                                          ^~~~~~
   include/linux/list.h:520:9: note: in expansion of macro 'container_of'
     520 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
     531 |         list_entry((ptr)->next, type, member)
         |         ^~~~~~~~~~
   include/linux/list.h:674:20: note: in expansion of macro 'list_first_ent=
ry'
     674 |         for (pos =3D list_first_entry(head, typeof(*pos), member=
);        \
         |                    ^~~~~~~~~~~~~~~~
   drivers/bus/hisi_lpc.c:511:9: note: in expansion of macro 'list_for_each=
_entry'
     511 |         list_for_each_entry(child, &adev->children, node) {
         |         ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/kobject.h:19,
                    from include/linux/of.h:17,
                    from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from drivers/bus/hisi_lpc.c:9:
   drivers/bus/hisi_lpc.c:511:53: error: 'struct acpi_device' has no member=
 named 'node'; did you mean 'fwnode'?
     511 |         list_for_each_entry(child, &adev->children, node) {
         |                                                     ^~~~
   include/linux/list.h:665:16: note: in definition of macro 'list_entry_is=
_head'
     665 |         (&pos->member =3D=3D (head))
         |                ^~~~~~
   drivers/bus/hisi_lpc.c:511:9: note: in expansion of macro 'list_for_each=
_entry'
     511 |         list_for_each_entry(child, &adev->children, node) {
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/bus/hisi_lpc.c:511:41: error: 'struct acpi_device' has no member=
 named 'children'
     511 |         list_for_each_entry(child, &adev->children, node) {
         |                                         ^~
   include/linux/list.h:665:27: note: in definition of macro 'list_entry_is=
_head'
     665 |         (&pos->member =3D=3D (head))
         |                           ^~~~
   drivers/bus/hisi_lpc.c:511:9: note: in expansion of macro 'list_for_each=
_entry'
     511 |         list_for_each_entry(child, &adev->children, node) {
         |         ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/list.h:5,
                    from include/linux/kobject.h:19,
                    from include/linux/of.h:17,
                    from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from drivers/bus/hisi_lpc.c:9:
   drivers/bus/hisi_lpc.c:511:53: error: 'struct acpi_device' has no member=
 named 'node'; did you mean 'fwnode'?
     511 |         list_for_each_entry(child, &adev->children, node) {
         |                                                     ^~~~
   include/linux/container_of.h:18:33: note: in definition of macro 'contai=
ner_of'
      18 |         void *__mptr =3D (void *)(ptr);                         =
          \
         |                                 ^~~
   include/linux/list.h:564:9: note: in expansion of macro 'list_entry'
     564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ^~~~~~~~~~
   include/linux/list.h:676:20: note: in expansion of macro 'list_next_entr=
y'
     676 |              pos =3D list_next_entry(pos, member))
         |                    ^~~~~~~~~~~~~~~
   drivers/bus/hisi_lpc.c:511:9: note: in expansion of macro 'list_for_each=
_entry'
     511 |         list_for_each_entry(child, &adev->children, node) {
         |         ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/bits.h:22,
                    from include/linux/ioport.h:13,
                    from include/linux/acpi.h:12,
                    from drivers/bus/hisi_lpc.c:9:
   drivers/bus/hisi_lpc.c:511:53: error: 'struct acpi_device' has no member=
 named 'node'; did you mean 'fwnode'?
     511 |         list_for_each_entry(child, &adev->children, node) {
         |                                                     ^~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_=
assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:19:9: note: in expansion of macro 'static_a=
ssert'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) |=
|       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:19:23: note: in expansion of macro '__same_=
type'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) |=
|       \
         |                       ^~~~~~~~~~~
   include/linux/list.h:520:9: note: in expansion of macro 'container_of'
     520 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:564:9: note: in expansion of macro 'list_entry'
     564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ^~~~~~~~~~
   include/linux/list.h:676:20: note: in expansion of macro 'list_next_entr=
y'
     676 |              pos =3D list_next_entry(pos, member))
         |                    ^~~~~~~~~~~~~~~
   drivers/bus/hisi_lpc.c:511:9: note: in expansion of macro 'list_for_each=
_entry'
     511 |         list_for_each_entry(child, &adev->children, node) {
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/bus/hisi_lpc.c:511:53: error: 'struct acpi_device' has no member=
 named 'node'; did you mean 'fwnode'?
     511 |         list_for_each_entry(child, &adev->children, node) {
         |                                                     ^~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_=
assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:19:9: note: in expansion of macro 'static_a=
ssert'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) |=
|       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:19:23: note: in expansion of macro '__same_=
type'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) |=
|       \
         |                       ^~~~~~~~~~~
   include/linux/list.h:520:9: note: in expansion of macro 'container_of'
     520 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:564:9: note: in expansion of macro 'list_entry'
     564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ^~~~~~~~~~
   include/linux/list.h:676:20: note: in expansion of macro 'list_next_entr=
y'
     676 |              pos =3D list_next_entry(pos, member))
         |                    ^~~~~~~~~~~~~~~
   drivers/bus/hisi_lpc.c:511:9: note: in expansion of macro 'list_for_each=
_entry'
     511 |         list_for_each_entry(child, &adev->children, node) {
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/bus/hisi_lpc.c:511:53: error: 'struct acpi_device' has no member=
 named 'node'; did you mean 'fwnode'?
     511 |         list_for_each_entry(child, &adev->children, node) {
         |                                                     ^~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_=
assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:19:9: note: in expansion of macro 'static_a=
ssert'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) |=
|       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_=
type'
      20 |                       __same_type(*(ptr), void),                =
        \
         |                       ^~~~~~~~~~~
   include/linux/list.h:520:9: note: in expansion of macro 'container_of'
     520 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:564:9: note: in expansion of macro 'list_entry'
     564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ^~~~~~~~~~
   include/linux/list.h:676:20: note: in expansion of macro 'list_next_entr=
y'
     676 |              pos =3D list_next_entry(pos, member))
         |                    ^~~~~~~~~~~~~~~
   drivers/bus/hisi_lpc.c:511:9: note: in expansion of macro 'list_for_each=
_entry'
     511 |         list_for_each_entry(child, &adev->children, node) {
         |         ^~~~~~~~~~~~~~~~~~~
>> include/linux/compiler_types.h:293:27: error: expression in static asser=
tion is not an integer
     293 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a)=
, typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_=
assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:19:9: note: in expansion of macro 'static_a=
ssert'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) |=
|       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:19:23: note: in expansion of macro '__same_=
type'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) |=
|       \
         |                       ^~~~~~~~~~~
   include/linux/list.h:520:9: note: in expansion of macro 'container_of'
     520 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:564:9: note: in expansion of macro 'list_entry'
     564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ^~~~~~~~~~
   include/linux/list.h:676:20: note: in expansion of macro 'list_next_entr=
y'
     676 |              pos =3D list_next_entry(pos, member))
         |                    ^~~~~~~~~~~~~~~
   drivers/bus/hisi_lpc.c:511:9: note: in expansion of macro 'list_for_each=
_entry'
     511 |         list_for_each_entry(child, &adev->children, node) {
         |         ^~~~~~~~~~~~~~~~~~~
   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/kasan-checks.h:5,
                    from include/asm-generic/rwonce.h:26,
                    from ./arch/ia64/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:248,
                    from include/linux/build_bug.h:5,
                    from include/linux/bits.h:22,
                    from include/linux/ioport.h:13,
                    from include/linux/acpi.h:12,
                    from drivers/bus/hisi_lpc.c:9:
   drivers/bus/hisi_lpc.c:511:53: error: 'struct acpi_device' has no member=
 named 'node'; did you mean 'fwnode'?
     511 |         list_for_each_entry(child, &adev->children, node) {
         |                                                     ^~~~
   include/linux/stddef.h:16:58: note: in definition of macro 'offsetof'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                                          ^~~~~~
   include/linux/list.h:520:9: note: in expansion of macro 'container_of'
     520 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:564:9: note: in expansion of macro 'list_entry'
     564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ^~~~~~~~~~
   include/linux/list.h:676:20: note: in expansion of macro 'list_next_entr=
y'
     676 |              pos =3D list_next_entry(pos, member))
         |                    ^~~~~~~~~~~~~~~
   drivers/bus/hisi_lpc.c:511:9: note: in expansion of macro 'list_for_each=
_entry'
     511 |         list_for_each_entry(child, &adev->children, node) {
         |         ^~~~~~~~~~~~~~~~~~~


vim +293 include/linux/compiler_types.h

eb111869301e15 Rasmus Villemoes 2019-09-13  291  =

d15155824c5014 Will Deacon      2017-10-24  292  /* Are two types/vars the =
same type (ignoring qualifiers)? */
d15155824c5014 Will Deacon      2017-10-24 @293  #define __same_type(a, b) =
__builtin_types_compatible_p(typeof(a), typeof(b))
d15155824c5014 Will Deacon      2017-10-24  294  =


:::::: The code at line 293 was first introduced by commit
:::::: d15155824c5014803d91b829736d249c500bdda6 linux/compiler.h: Split int=
o compiler.h and compiler_types.h

:::::: TO: Will Deacon <will.deacon(a)arm.com>
:::::: CC: Ingo Molnar <mingo(a)kernel.org>

-- =

0-DAY CI Kernel Test Service
https://01.org/lkp
--===============1537176873006268996==--

