Content-Type: multipart/mixed; boundary="===============4425147043382597964=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: arm64: fix compile apci tools fail for
 arm64
Date: Tue, 18 Oct 2016 22:07:23 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886A253FBF@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 696226b1-7024-a4d6-8bea-ddbf6d08a564@huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4425147043382597964==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> From: Yisheng Xie [mailto:xieyisheng1(a)huawei.com]
> Sent: Tuesday, October 18, 2016 4:47 AM
> To: Zheng, Lv <lv.zheng(a)intel.com>; Moore, Robert <robert.moore(a)intel=
.com>; Wysocki, Rafael J
> <rafael.j.wysocki(a)intel.com>; lenb(a)kernel.org; wmiles(a)sgl.com
> Cc: linux-acpi(a)vger.kernel.org; devel(a)acpica.org; linux-kernel(a)vger=
.kernel.org; guohanjun(a)huawei.com;
> wangxiongfeng2(a)huawei.com
> Subject: Re: [PATCH] ACPICA: arm64: fix compile apci tools fail for arm64
> =

> Hi, Lv
> =

> On 2016/10/18 6:26, Zheng, Lv wrote:
> > Hi, Yisheng
> >
> >> From: Yisheng Xie [mailto:xieyisheng1(a)huawei.com]
> >> Subject: [PATCH] ACPICA: arm64: fix compile apci tools fail for arm64
> >>
> >> when try to cross compile acpi tool in dir kernel/tools
> >> for arm64 use command:
> >>     make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- acpi
> >> it failed with the following log:
> >> In file included
> >>     from ../../../../../include/acpi/acpi.h:58:0,
> >>     from ../../../../../drivers/acpi/acpica/utstring.c:44:
> >>     ../../../../../include/acpi/actypes.h:130:34: error: conflicting t=
ypes for 's64'
> >>  typedef signed long long s64;
> >>                            ^
> >> In file included
> >>     from /opt/aarch64-linux-gnu/libc/usr/include/asm-generic/types.h:6=
:0
> >>     from /opt/aarch64-linux-gnu/libc/usr/include/asm/types.h:1,
> >>     from ../../../../../include/uapi/linux/types.h:4,
> >>     from ../../../../../include/linux/types.h:5,
> >>     from /opt/aarch64-linux-gnu/libc/usr/include/asm/sigcontext.h:19,
> >>     from /opt/aarch64-linux-gnu/libc/usr/include/bits/sigcontext.h:27,
> >>     from /opt/aarch64-linux-gnu/libc/usr/include/signal.h:308,
> >>     from ../../../../../include/acpi/platform/acenv.h:365,
> >>     from ../../../../../include/acpi/acpi.h:56,
> >>     from ./acpidump.h:55,
> >>     from ../../os_specific/service_layers/oslinuxtbl.c:44:
> >> ../../../../../include/asm-generic/int-ll64.h:24:26: note: previous de=
claration of 's64' was here
> >>  typedef signed long long s64;
> >>                            ^
> >> Fix this compile problem.
> >
> > This looks like a conflict between asm-generic/int-ll64.h and actypes.h.
> >
> > When a build environment actually has s64 definition.
> > ACPICA shouldn't define it.
> > ACPICA should define ACPI_USE_SYSTEM_INTTYPES instead.
> >
> > However it is not clear if a Linux userspace should be aware of s64.
> > We couldn't see this issue in other arch builds.
> > So I wonder if this is just a missing "#ifdef __KERNEL__" in asm-generi=
c/int-ll64.h.
> >
> > If Linux should be aware of s64.
> > Then ACPICA definition of s64 should be disabled by defining ACPI_USE_S=
YSTEM_INTTYPES.
> > Since this is a post-ACPICA-release issue.
> > You should only fix it in tools/power/acpi/Makefile*.
> >
> > So I think this patch is not a right fix, but a wrong workaround.
> > It can easily cause regressions in other ACPICA builds.
> >
> Thank you for your reply.
> You are right that the  ACPI_USE_SYSTEM_INTTYPES in Makefile can fixed co=
mpile error,

I'm not sure what you mean.
I mean you need ACPI_USE_SYSTEM_INTTYPES in case s64 has already been defin=
ed in that environment.
Are you sure s64 should be defined for your environment?

IMO, s64 is kernel space specific, while you are compiling user space tools.
It looks to me like there is something wrong with ARM kernel's asm/types.h.

> I listed in change log. And I also have tried that way.
> However, it still have many other errors.(I am sorry to not have listed a=
ll of them.)
> =

> From the following log, you can see, all of the conflict type is from sig=
nal.h.
> And maybe this patch is a better way to fix these compile error, without =
too much
> change of code.
> =

> Are you sure that it will cause order problem when build ACPICA on other =
build
> environment, for it only effect aarch64.
> =

> Thanks
> Yisheng.
> =

> ----------detail compile error log---------
> In file included from /opt/aarch64-linux-gnu/libc/usr/include/asm/sigcont=
ext.h:19:0,
>                  from /opt/aarch64-linux-gnu/libc/usr/include/bits/sigcon=
text.h:27,
>                  from /opt/aarch64-linux-gnu/libc/usr/include/signal.h:30=
8,
>                  from ../../../../../include/acpi/platform/acenv.h:365,
>                  from ../../../../../include/acpi/acpi.h:56,
>                  from ../../../../../drivers/acpi/acpica/tbprint.c:44:
> ../../../../../include/linux/types.h:14:26: error: conflicting types for =
'fd_set'
>  typedef __kernel_fd_set  fd_set;
>                           ^
> In file included from /opt/aarch64-linux-gnu/libc/usr/include/sys/types.h=
:219:0,
>                  from /opt/aarch64-linux-gnu/libc/usr/include/stdlib.h:31=
4,
>                  from ../../../../../include/acpi/platform/acenv.h:357,
>                  from ../../../../../include/acpi/acpi.h:56,
>                  from ../../../../../drivers/acpi/acpica/tbprint.c:44:
> /opt/aarch64-linux-gnu/libc/usr/include/sys/select.h:75:5: note: previous=
 declaration of 'fd_set' was
> here
>    } fd_set;
>      ^
> In file included from /opt/aarch64-linux-gnu/libc/usr/include/asm/sigcont=
ext.h:19:0,
>                  from /opt/aarch64-linux-gnu/libc/usr/include/bits/sigcon=
text.h:27,
>                  from /opt/aarch64-linux-gnu/libc/usr/include/signal.h:30=
8,
>                  from ../../../../../include/acpi/platform/acenv.h:365,
>                  from ../../../../../include/acpi/acpi.h:56,
>                  from ../../../../../drivers/acpi/acpica/tbprint.c:44:
> ../../../../../include/linux/types.h:15:25: error: conflicting types for =
'dev_t'
>  typedef __kernel_dev_t  dev_t;
>                          ^
> In file included from /opt/aarch64-linux-gnu/libc/usr/include/stdlib.h:31=
4:0,
>                  from ../../../../../include/acpi/platform/acenv.h:357,
>                  from ../../../../../include/acpi/acpi.h:56,
>                  from ../../../../../drivers/acpi/acpica/tbprint.c:44:
> /opt/aarch64-linux-gnu/libc/usr/include/sys/types.h:60:17: note: previous=
 declaration of 'dev_t' was
> here
>  typedef __dev_t dev_t;
>                  ^
> ...
> In file included from /opt/aarch64-linux-gnu/libc/usr/include/asm/sigcont=
ext.h:19:0,
>                  from /opt/aarch64-linux-gnu/libc/usr/include/bits/sigcon=
text.h:27,
>                  from /opt/aarch64-linux-gnu/libc/usr/include/signal.h:30=
8,
>                  from ../../../../../include/acpi/platform/acenv.h:365,
>                  from ../../../../../include/acpi/acpi.h:56,
>                  from ../../../../../drivers/acpi/acpica/tbprint.c:44:
> ../../../../../include/linux/types.h:25:26: error: conflicting types for =
'timer_t'
>  typedef __kernel_timer_t timer_t;
>                           ^
> In file included from /opt/aarch64-linux-gnu/libc/usr/include/sys/types.h=
:132:0,
>                  from /opt/aarch64-linux-gnu/libc/usr/include/stdlib.h:31=
4,
>                  from ../../../../../include/acpi/platform/acenv.h:357,
>                  from ../../../../../include/acpi/acpi.h:56,
>                  from ../../../../../drivers/acpi/acpica/tbprint.c:44:
> /opt/aarch64-linux-gnu/libc/usr/include/time.h:103:19: note: previous dec=
laration of 'timer_t' was
> here
>  typedef __timer_t timer_t;
>                    ^
> ...
> In file included from /opt/aarch64-linux-gnu/libc/usr/include/asm/sigcont=
ext.h:19:0,
>                  from /opt/aarch64-linux-gnu/libc/usr/include/bits/sigcon=
text.h:27,
>                  from /opt/aarch64-linux-gnu/libc/usr/include/signal.h:30=
8,
>                  from ../../../../../include/acpi/platform/acenv.h:365,
>                  from ../../../../../include/acpi/acpi.h:56,
>                  from ../../../../../drivers/acpi/acpica/tbprint.c:44:
> ../../../../../include/linux/types.h:45:26: error: conflicting types for =
'loff_t'
>  typedef __kernel_loff_t  loff_t;
>                           ^
> In file included from /opt/aarch64-linux-gnu/libc/usr/include/stdlib.h:31=
4:0,
>                  from ../../../../../include/acpi/platform/acenv.h:357,
>                  from ../../../../../include/acpi/acpi.h:56,
>                  from ../../../../../drivers/acpi/acpica/tbprint.c:44:
> /opt/aarch64-linux-gnu/libc/usr/include/sys/types.h:44:18: note: previous=
 declaration of 'loff_t' was
> here
>  typedef __loff_t loff_t;
>                   ^
> ...
> In file included from /opt/aarch64-linux-gnu/libc/usr/include/asm/sigcont=
ext.h:19:0,
>                  from /opt/aarch64-linux-gnu/libc/usr/include/bits/sigcon=
text.h:27,
>                  from /opt/aarch64-linux-gnu/libc/usr/include/signal.h:30=
8,
>                  from ../../../../../include/acpi/platform/acenv.h:365,
>                  from ../../../../../include/acpi/acpi.h:56,
>                  from ../../../../../drivers/acpi/acpica/tbprint.c:44:
> ../../../../../include/linux/types.h:112:17: error: conflicting types for=
 'u_int64_t'
>  typedef  __u64  u_int64_t;
>                  ^
> In file included from /opt/aarch64-linux-gnu/libc/usr/include/stdlib.h:31=
4:0,
>                  from ../../../../../include/acpi/platform/acenv.h:357,
>                  from ../../../../../include/acpi/acpi.h:56,
>                  from ../../../../../drivers/acpi/acpica/tbprint.c:44:
> /opt/aarch64-linux-gnu/libc/usr/include/sys/types.h:203:1: note: previous=
 declaration of 'u_int64_t'
> was here
>  __u_intN_t (64, __DI__);
>  ^
> ...
> In file included from /opt/aarch64-linux-gnu/libc/usr/include/asm/sigcont=
ext.h:19:0,
>                  from /opt/aarch64-linux-gnu/libc/usr/include/bits/sigcon=
text.h:27,
>                  from /opt/aarch64-linux-gnu/libc/usr/include/signal.h:30=
8,
>                  from ../../../../../include/acpi/platform/acenv.h:365,
>                  from ../../../../../include/acpi/acpi.h:56,
>                  from ../../../../../drivers/acpi/acpica/tbprint.c:44:
> ../../../../../include/linux/types.h:113:17: error: conflicting types for=
 'int64_t'
>  typedef  __s64  int64_t;
>                  ^
> In file included from /opt/aarch64-linux-gnu/libc/usr/include/stdlib.h:31=
4:0,
>                  from ../../../../../include/acpi/platform/acenv.h:357,
>                  from ../../../../../include/acpi/acpi.h:56,
>                  from ../../../../../drivers/acpi/acpica/tbprint.c:44:
> /opt/aarch64-linux-gnu/libc/usr/include/sys/types.h:197:1: note: previous=
 declaration of 'int64_t' was
> here
>  __intN_t (64, __DI__);
>  ^
> ...
> In file included from /opt/aarch64-linux-gnu/libc/usr/include/asm/sigcont=
ext.h:19:0,
>                  from /opt/aarch64-linux-gnu/libc/usr/include/bits/sigcon=
text.h:27,
>                  from /opt/aarch64-linux-gnu/libc/usr/include/signal.h:30=
8,
>                  from ../../../../../include/acpi/platform/acenv.h:365,
>                  from ../../../../../include/acpi/acpi.h:56,
>                  from ../../../../../drivers/acpi/acpica/tbprint.c:44:
> ../../../../../include/linux/types.h:134:23: error: conflicting types for=
 'blkcnt_t'
>  typedef unsigned long blkcnt_t;
>                        ^
> In file included from /opt/aarch64-linux-gnu/libc/usr/include/stdlib.h:31=
4:0,
>                  from ../../../../../include/acpi/platform/acenv.h:357,
>                  from ../../../../../include/acpi/acpi.h:56,
>                  from ../../../../../drivers/acpi/acpica/tbprint.c:44:
> /opt/aarch64-linux-gnu/libc/usr/include/sys/types.h:235:20: note: previou=
s declaration of 'blkcnt_t'
> was here
>  typedef __blkcnt_t blkcnt_t;  /* Type to count number of disk blocks.  */
>                     ^
> =

> =

> =

> =

> In file included from /opt/aarch64-linux-gnu/libc/usr/include/sys/types.h=
:219:0,
>                  from /opt/aarch64-linux-gnu/libc/usr/include/stdlib.h:31=
4,
>                  from ../../../../../include/acpi/platform/acenv.h:357,
>                  from ../../../../../include/acpi/acpi.h:56,
>                  from acpidbg.c:12:
> acpidbg.c: In function 'acpi_aml_set_fd':
> ../../../../../drivers/acpi/acpica/utprint.c:352:5: error: conflicting ty=
pes for 'vsnprintf'
>  int vsnprintf(char *string, acpi_size size, const char *format, va_list =
args)
>      ^
> ...
> In file included from ../../../../../include/acpi/platform/acenv.h:361:0,
>                  from ../../../../../include/acpi/acpi.h:56,
>                  from ../../../../../drivers/acpi/acpica/utprint.c:44:
> /opt/aarch64-linux-gnu/libc/usr/include/stdio.h:390:12: note: previous de=
claration of 'vsnprintf' was
> here
>  extern int vsnprintf (char *__restrict __s, size_t __maxlen,
>             ^
> ....
> ../../../../../drivers/acpi/acpica/utprint.c:599:5: error: conflicting ty=
pes for 'snprintf'
>  int snprintf(char *string, acpi_size size, const char *format, ...)
>      ^
> =

> In file included from ../../../../../include/acpi/platform/acenv.h:361:0,
>                  from ../../../../../include/acpi/acpi.h:56,
>                  from ../../../../../drivers/acpi/acpica/utprint.c:44:
> /opt/aarch64-linux-gnu/libc/usr/include/stdio.h:386:12: note: previous de=
claration of 'snprintf' was
> here
>  extern int snprintf (char *__restrict __s, size_t __maxlen,
>             ^
> ...
> acpidbg.c:303:25: warning: passing argument 2 of 'select' from incompatib=
le pointer type [-
> Wincompatible-pointer-types]
>    ret =3D select(maxfd+1, &rfds, &wfds, NULL, &tv);
>                          ^
> ....
> acpidbg.c:309:8: error: 'fd_set {aka struct <anonymous>}' has no member n=
amed '__fds_bits'
>     if (FD_ISSET(STDIN_FILENO, &rfds))
>         ^
> make[2]: *** [utprint.o] Error 1
> acpidbg.c:311:8: error: 'fd_set {aka struct <anonymous>}' has no member n=
amed '__fds_bits'
>     if (FD_ISSET(fd, &wfds)) {
>         ^
> acpidbg.c:317:8: error: 'fd_set {aka struct <anonymous>}' has no member n=
amed '__fds_bits'
>     if (FD_ISSET(fd, &rfds)) {
>         ^
> acpidbg.c:323:8: error: 'fd_set {aka struct <anonymous>}' has no member n=
amed '__fds_bits'
>     if (FD_ISSET(STDOUT_FILENO, &wfds)) {
>         ^


I'm not sure what this is.
How did you get this?
Were you compiling kernel acpi tools or compiling the kernel itself?

For tool compilation, are you sure you have correctly configured your cross=
-compilation environment?
Will you see problems in compiling ACPICA applications from:
https://github.com/acpica/acpica

Thanks
Lv

--===============4425147043382597964==--

