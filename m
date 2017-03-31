Content-Type: multipart/mixed; boundary="===============9092980509120460081=="
MIME-Version: 1.0
From: Al Stone <ahs3 at redhat.com>
Subject: Re: [Devel] [PATCH] ACPICA: enable compilation for embedded Linux
 systems
Date: Fri, 31 Mar 2017 11:29:47 -0600
Message-ID: <ca7c7b0a-9a93-7a87-19d3-fcd7dfc93af5@redhat.com>
In-Reply-To: 1AE640813FDE7649BE1B193DEA596E886CE6E5D2@SHSMSX101.ccr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============9092980509120460081==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 03/30/2017 08:56 PM, Zheng, Lv wrote:
> Hi,
> =

>> From: Zheng, Lv
>> Subject: RE: [PATCH] ACPICA: enable compilation for embedded Linux syste=
ms
>>
>> Hi,
>>
>>> From: Al Stone [mailto:ahs3(a)redhat.com]
>>> Subject: [PATCH] ACPICA: enable compilation for embedded Linux systems
>>>
>>> The ACPICA subsystem of the ACPI driver sets up a compilation environme=
nt
>>> for itself, adding in multiple typedefs unique to ACPICA that depend on
>>> where ACPICA will be used.
>>>
>>> The vast majority of such environments (Linux, QNX, ...) have an enviro=
nment
>>> defined in the acenv.h header file.  When using a Linaro compiler [1]
>>> specifically built to be used in an embedded environment where perhaps a
>>> kernel and an init process are the only things running, there is no
>>> environment defined for ACPICA so the typedefs it needs are not set up
>>> properly, causing compilation to fail unless ACPI is completely disable=
d.
>>> Since ACPI is enabled in the default config for the kernel, the compila=
tion
>>> failure becomes fairly obvious [2].
>>>
>>> Since building _for_ embedded Linux systems is slightly different than
>>> building _in_ a Linux environment, define a new environment header
>>> called acembed.h.  Compilers for these systems may not have the normal
>>> defines a compiler for a Linux environment might, but they are very
>>> close.  Then, we fix acenv.h so that when we are using GCC without GLIB=
C,
>>> we select the embedded environment of acembed.h.
>>>
>>
>> Is such system compiled by gcc?
>> If so, what's the result of: "${CC} -dM -E - < /dev/null" when it is com=
piled?
> =

> I checked the code.
> In acenv.h, the inclusion:
> #if defined(_LINUX) || defined(__linux__)
> #include <aclinux.h>
> #endif
> =

> Means:
> 1. __linux__: host detection, useful for building ACPICA on linux hosts, =
so this supports to build linux kernel/applications on LINUX hosts.
> 1. _LINUX: target detection,
> It's defined in <linux/acpi.h>, however, we don't support to build linux =
kernel on NON_LINUX hosts.
> In order to support it, we may still need to add -D_LINUX into drivers/ac=
pi/acpica/Makefile.
> The above is the current use cases for aclinux.h.

Yes, I understand all that.  I _am_ building on a Linux host, but the targe=
t is
not really Linux -- it may only be a kernel running on the target, with _ma=
ybe_
an init process, so it is essentially the same but it has a different run-t=
ime.

> =

> If you want to build another target, you may need to do the followings in=
 the Makefile:
> 1. define a target type and put it into acenv.h;
> 2. add -U__linux__ if you want to build it on linux box.

I am building on a Linux box; if I don't use -D__linux__, ACPICA will not
compile.

> The above is the current use cases for another target, you can download A=
CPICA upstream code and find EFI makefiles to confirm this.

It's not really a different target; the target is still a Linux kernel.
It's just not a distro and is probably *only* a kernel -- an embedded
system.

> For your case (I actually not clear enough for what your case is),
> if you want to build a linux like system, you may need to do the followin=
gs in Makefile:
> 1. define _LINUX if you want to utilize ACPICA definitions for linux kern=
el;
> 2. define __linux__ if you want to utilize ACPICA definition for linux ap=
plications and build it on NON_LINUX hosts.
> So I'm not sure if this patch is useful, you probably could solve your pr=
oblems in your own makefiles if you just want to enable aclinux.h inclusion=
s.

I'm confused.  I am running:

   ARCH=3Darm64 CROSS_COMPILE=3Daarch64-elf- make Image

on a Linux system, to build a Linux kernel for an arm64 system.  That can't
really change, or at least does not make sense to change -- these aren't re=
ally
my own Makefiles, but the ones used by everyone.

The patch is needed so that this can go into Linux upstream eventually to e=
nable
this sort of kernel build in general.  Without this patch, the kernel will =
not
build because ACPICA will not build.  Specifically, arm64 includes CONFIG_A=
CPI
by default and it is being contemplated for use on some of these small embe=
dded
systems.  With the compile path mentioned, __linux__ and _LINUX are not def=
ined
at all so ACPICA has *no* standard typedefs so it cannot compile.  Since th=
is is
a different environment than a normal Linux run-time, I separated it out in
acenv.h and put the needed #includes and such in a file specific to that
environment.  It's really only the compiler that's changing and this patch
allows ACPICA to build with that compiler.

> Thanks and best regards
> Lv
> =

> =

>>
>> Thanks
>> Lv
>>
>>> [1]
>>> https://releases.linaro.org/components/toolchain/binaries/latest/aarch6=
4-elff/gcc-linaro-6.1.1-2016-
>>> 08-x86_64_aarch64-elf.tar.xz
>>> [2] This error was originally discovered by Will Deacon
>>>
>>> Signed-off-by: Al Stone <ahs3(a)redhat.com>
>>> Cc: Will Deacon <will.deacon(a)arm.com>
>>> Cc: Rafael J. Wysocki <rjw(a)rjwysocki.net>
>>> Cc: Len Brown <lenb(a)kernel.org>
>>> Cc: Robert Moore <robert.moore(a)intel.com>
>>> Cc: Lv Zheng <lv.zheng(a)intel.com>
>>> ---
>>>  source/include/platform/acembed.h | 57 +++++++++++++++++++++++++++++++=
++++++++
>>>  source/include/platform/acenv.h   | 11 ++++++++
>>>  2 files changed, 68 insertions(+)
>>>  create mode 100644 source/include/platform/acembed.h
>>>
>>> diff --git a/source/include/platform/acembed.h b/source/include/platfor=
m/acembed.h
>>> new file mode 100644
>>> index 0000000..e741f8d
>>> --- /dev/null
>>> +++ b/source/include/platform/acembed.h
>>> @@ -0,0 +1,57 @@
>>> +/*********************************************************************=
*********
>>> + *
>>> + * Name: acembed.h - OS specific defines, etc. for embedded Linux syst=
ems
>>> + *
>>> + *********************************************************************=
********/
>>> +
>>> +/*
>>> + * Copyright (C) 2017, Red Hat, Inc.
>>> + * All rights reserved.
>>> + *
>>> + * Redistribution and use in source and binary forms, with or without
>>> + * modification, are permitted provided that the following conditions
>>> + * are met:
>>> + * 1. Redistributions of source code must retain the above copyright
>>> + *    notice, this list of conditions, and the following disclaimer,
>>> + *    without modification.
>>> + * 2. Redistributions in binary form must reproduce at minimum a discl=
aimer
>>> + *    substantially similar to the "NO WARRANTY" disclaimer below
>>> + *    ("Disclaimer") and any redistribution must be conditioned upon
>>> + *    including a substantially similar Disclaimer requirement for fur=
ther
>>> + *    binary redistribution.
>>> + * 3. Neither the names of the above-listed copyright holders nor the =
names
>>> + *    of any contributors may be used to endorse or promote products d=
erived
>>> + *    from this software without specific prior written permission.
>>> + *
>>> + * Alternatively, this software may be distributed under the terms of =
the
>>> + * GNU General Public License ("GPL") version 2 as published by the Fr=
ee
>>> + * Software Foundation.
>>> + *
>>> + * NO WARRANTY
>>> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
>>> + * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>>> + * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS F=
OR
>>> + * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
>>> + * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQ=
UENTIAL
>>> + * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE G=
OODS
>>> + * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTIO=
N)
>>> + * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
>>> + * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISI=
NG
>>> + * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
>>> + * POSSIBILITY OF SUCH DAMAGES.
>>> + */
>>> +
>>> +#ifndef __ACEMBED_H__
>>> +#define __ACEMBED_H__
>>> +
>>> +#if !defined(_LINUX)
>>> +#define _LINUX
>>> +#endif
>>> +
>>> +#if !defined(__linux__)
>>> +#define __linux__
>>> +#endif
>>> +
>>> +#include <acpi/platform/aclinux.h>
>>> +
>>> +#endif				/* __ACEMBED_H__ */
>>> diff --git a/source/include/platform/acenv.h b/source/include/platform/=
acenv.h
>>> index 5bec576..b300afa 100644
>>> --- a/source/include/platform/acenv.h
>>> +++ b/source/include/platform/acenv.h
>>> @@ -343,6 +343,17 @@
>>>  #elif defined(_AED_EFI) || defined(_GNU_EFI) || defined(_EDK2_EFI)
>>>  #include "acefi.h"
>>>
>>> +/*
>>> + * There are systems that run just a minimal Linux kernel; they have
>>> + * no user space and often extremely pared down configurations -- e.g.,
>>> + * a small embedded Linux system in a light bulb or other IoT device.
>>> + * In those cases, we're mostly a Linux system, but the compilers used
>>> + * may not be aware of that, so create an evironment specific to their
>>> + * needs.
>>> + */
>>> +#elif defined(__GNUC__) && !defined(__INTEL_COMPILER) && !defined(__GL=
IBC__)
>>> +#include <acpi/platform/acembed.h>
>>> +
>>>  #else
>>>
>>>  /* Unknown environment */
>>> --
>>> 2.9.3
>>>
>>>
>>> --
>>> ciao,
>>> al
>>> -----------------------------------
>>> Al Stone
>>> Software Engineer
>>> Red Hat, Inc.
>>> ahs3(a)redhat.com
>>> -----------------------------------


-- =

ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3(a)redhat.com
-----------------------------------

--===============9092980509120460081==--

