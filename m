Content-Type: multipart/mixed; boundary="===============0375788534219813480=="
MIME-Version: 1.0
From: Al Stone <ahs3 at redhat.com>
Subject: Re: [Devel] [PATCH] ACPICA: enable compilation for embedded Linux
 systems
Date: Fri, 31 Mar 2017 10:55:07 -0600
Message-ID: <6eaf7628-6f4d-29bb-6c1d-63b5010b7163@redhat.com>
In-Reply-To: 1AE640813FDE7649BE1B193DEA596E886CE6E55E@SHSMSX101.ccr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0375788534219813480==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 03/30/2017 07:51 PM, Zheng, Lv wrote:
> Hi,
> =

>> From: Al Stone [mailto:ahs3(a)redhat.com]
>> Subject: [PATCH] ACPICA: enable compilation for embedded Linux systems
>>
>> The ACPICA subsystem of the ACPI driver sets up a compilation environment
>> for itself, adding in multiple typedefs unique to ACPICA that depend on
>> where ACPICA will be used.
>>
>> The vast majority of such environments (Linux, QNX, ...) have an environ=
ment
>> defined in the acenv.h header file.  When using a Linaro compiler [1]
>> specifically built to be used in an embedded environment where perhaps a
>> kernel and an init process are the only things running, there is no
>> environment defined for ACPICA so the typedefs it needs are not set up
>> properly, causing compilation to fail unless ACPI is completely disabled.
>> Since ACPI is enabled in the default config for the kernel, the compilat=
ion
>> failure becomes fairly obvious [2].
>>
>> Since building _for_ embedded Linux systems is slightly different than
>> building _in_ a Linux environment, define a new environment header
>> called acembed.h.  Compilers for these systems may not have the normal
>> defines a compiler for a Linux environment might, but they are very
>> close.  Then, we fix acenv.h so that when we are using GCC without GLIBC,
>> we select the embedded environment of acembed.h.
>>
> =

> Is such system compiled by gcc?

Of course.  Has been for years.

The compiler I used is noted in [1].  This is a very common usage for embed=
ded
systems.

> If so, what's the result of: "${CC} -dM -E - < /dev/null" when it is comp=
iled?

#define __DBL_MIN_EXP__ (-1021)
#define __UINT_LEAST16_MAX__ 0xffff
#define __ARM_SIZEOF_WCHAR_T 4
#define __ATOMIC_ACQUIRE 2
#define __FLT_MIN__ 1.17549435082228750796873653722224568e-38F
#define __GCC_IEC_559_COMPLEX 2
#define __UINT_LEAST8_TYPE__ unsigned char
#define __INTMAX_C(c) c ## L
#define __CHAR_BIT__ 8
#define __UINT8_MAX__ 0xff
#define __WINT_MAX__ 0xffffffffU
#define __ORDER_LITTLE_ENDIAN__ 1234
#define __SIZE_MAX__ 0xffffffffffffffffUL
#define __WCHAR_MAX__ 0xffffffffU
#define __GCC_HAVE_SYNC_COMPARE_AND_SWAP_1 1
#define __GCC_HAVE_SYNC_COMPARE_AND_SWAP_2 1
#define __GCC_HAVE_SYNC_COMPARE_AND_SWAP_4 1
#define __DBL_DENORM_MIN__ ((double)4.94065645841246544176568792868221372e-=
324L)
#define __GCC_HAVE_SYNC_COMPARE_AND_SWAP_8 1
#define __GCC_ATOMIC_CHAR_LOCK_FREE 2
#define __GCC_IEC_559 2
#define __FLT_EVAL_METHOD__ 0
#define __GCC_ATOMIC_CHAR32_T_LOCK_FREE 2
#define __UINT_FAST64_MAX__ 0xffffffffffffffffUL
#define __SIG_ATOMIC_TYPE__ int
#define __DBL_MIN_10_EXP__ (-307)
#define __FINITE_MATH_ONLY__ 0
#define __ARM_FEATURE_UNALIGNED 1
#define __GNUC_PATCHLEVEL__ 1
#define __UINT_FAST8_MAX__ 0xffffffffU
#define __has_include(STR) __has_include__(STR)
#define __DEC64_MAX_EXP__ 385
#define __INT8_C(c) c
#define __UINT_LEAST64_MAX__ 0xffffffffffffffffUL
#define __SHRT_MAX__ 0x7fff
#define __LDBL_MAX__ 1.18973149535723176508575932662800702e+4932L
#define __ARM_FEATURE_IDIV 1
#define __ARM_FP 14
#define __UINT_LEAST8_MAX__ 0xff
#define __GCC_ATOMIC_BOOL_LOCK_FREE 2
#define __UINTMAX_TYPE__ long unsigned int
#define __DEC32_EPSILON__ 1E-6DF
#define __CHAR_UNSIGNED__ 1
#define __UINT32_MAX__ 0xffffffffU
#define __AARCH64_CMODEL_SMALL__ 1
#define __LDBL_MAX_EXP__ 16384
#define __WINT_MIN__ 0U
#define __SCHAR_MAX__ 0x7f
#define __WCHAR_MIN__ 0U
#define __INT64_C(c) c ## L
#define __DBL_DIG__ 15
#define __GCC_ATOMIC_POINTER_LOCK_FREE 2
#define __SIZEOF_INT__ 4
#define __SIZEOF_POINTER__ 8
#define __USER_LABEL_PREFIX__
#define __STDC_HOSTED__ 1
#define __LDBL_HAS_INFINITY__ 1
#define __ARM_ALIGN_MAX_STACK_PWR 16
#define __FLT_EPSILON__ 1.19209289550781250000000000000000000e-7F
#define __LDBL_MIN__ 3.36210314311209350626267781732175260e-4932L
#define __STDC_UTF_16__ 1
#define __DEC32_MAX__ 9.999999E96DF
#define __ARM_SIZEOF_MINIMAL_ENUM 4
#define __INT32_MAX__ 0x7fffffff
#define __SIZEOF_LONG__ 8
#define __UINT16_C(c) c
#define __DECIMAL_DIG__ 36
#define __has_include_next(STR) __has_include_next__(STR)
#define __LDBL_HAS_QUIET_NAN__ 1
#define __GNUC__ 6
#define __FLT_HAS_DENORM__ 1
#define __SIZEOF_LONG_DOUBLE__ 16
#define __BIGGEST_ALIGNMENT__ 16
#define __DBL_MAX__ ((double)1.79769313486231570814527423731704357e+308L)
#define __INT_FAST32_MAX__ 0x7fffffff
#define __DBL_HAS_INFINITY__ 1
#define __DEC32_MIN_EXP__ (-94)
#define __INT_FAST16_TYPE__ int
#define __LDBL_HAS_DENORM__ 1
#define __DEC128_MAX__ 9.999999999999999999999999999999999E6144DL
#define __INT_LEAST32_MAX__ 0x7fffffff
#define __DEC32_MIN__ 1E-95DF
#define __DBL_MAX_EXP__ 1024
#define __DEC128_EPSILON__ 1E-33DL
#define __PTRDIFF_MAX__ 0x7fffffffffffffffL
#define __LONG_LONG_MAX__ 0x7fffffffffffffffLL
#define __SIZEOF_SIZE_T__ 8
#define __ARM_ALIGN_MAX_PWR 28
#define __SIZEOF_WINT_T__ 4
#define __ARM_FP16_FORMAT_IEEE 1
#define __GXX_ABI_VERSION 1010
#define __FLT_MIN_EXP__ (-125)
#define __INT_FAST64_TYPE__ long int
#define __FP_FAST_FMAF 1
#define __DBL_MIN__ ((double)2.22507385850720138309023271733240406e-308L)
#define __LP64__ 1
#define __aarch64__ 1
#define __ARM_FP16_ARGS 1
#define __DEC128_MIN__ 1E-6143DL
#define __REGISTER_PREFIX__
#define __UINT16_MAX__ 0xffff
#define __DBL_HAS_DENORM__ 1
#define __UINT8_TYPE__ unsigned char
#define __NO_INLINE__ 1
#define __FLT_MANT_DIG__ 24
#define __VERSION__ "6.1.1 20160711"
#define __UINT64_C(c) c ## UL
#define __ARM_FEATURE_FMA 1
#define __GCC_ATOMIC_INT_LOCK_FREE 2
#define __FLOAT_WORD_ORDER__ __ORDER_LITTLE_ENDIAN__
#define __INT32_C(c) c
#define __DEC64_EPSILON__ 1E-15DD
#define __ORDER_PDP_ENDIAN__ 3412
#define __DEC128_MIN_EXP__ (-6142)
#define __ARM_64BIT_STATE 1
#define __LINARO_SPIN__ 0
#define __INT_FAST32_TYPE__ int
#define __UINT_LEAST16_TYPE__ short unsigned int
#define __INT16_MAX__ 0x7fff
#define __SIZE_TYPE__ long unsigned int
#define __UINT64_MAX__ 0xffffffffffffffffUL
#define __INT8_TYPE__ signed char
#define __ELF__ 1
#define __FLT_RADIX__ 2
#define __INT_LEAST16_TYPE__ short int
#define __ARM_ARCH_PROFILE 65
#define __LDBL_EPSILON__ 1.92592994438723585305597794258492732e-34L
#define __UINTMAX_C(c) c ## UL
#define __ARM_PCS_AAPCS64 1
#define __SIG_ATOMIC_MAX__ 0x7fffffff
#define __LINARO_RELEASE__ 201608
#define __GCC_ATOMIC_WCHAR_T_LOCK_FREE 2
#define __SIZEOF_PTRDIFF_T__ 8
#define __AARCH64EL__ 1
#define __DEC32_SUBNORMAL_MIN__ 0.000001E-95DF
#define __INT_FAST16_MAX__ 0x7fffffff
#define __UINT_FAST32_MAX__ 0xffffffffU
#define __UINT_LEAST64_TYPE__ long unsigned int
#define __FLT_HAS_QUIET_NAN__ 1
#define __FLT_MAX_10_EXP__ 38
#define __LONG_MAX__ 0x7fffffffffffffffL
#define __DEC128_SUBNORMAL_MIN__ 0.000000000000000000000000000000001E-6143DL
#define __FLT_HAS_INFINITY__ 1
#define __UINT_FAST16_TYPE__ unsigned int
#define __DEC64_MAX__ 9.999999999999999E384DD
#define __CHAR16_TYPE__ short unsigned int
#define __PRAGMA_REDEFINE_EXTNAME 1
#define __INT_LEAST16_MAX__ 0x7fff
#define __DEC64_MANT_DIG__ 16
#define __INT64_MAX__ 0x7fffffffffffffffL
#define __UINT_LEAST32_MAX__ 0xffffffffU
#define __GCC_ATOMIC_LONG_LOCK_FREE 2
#define __INT_LEAST64_TYPE__ long int
#define __ARM_FEATURE_CLZ 1
#define __INT16_TYPE__ short int
#define __INT_LEAST8_TYPE__ signed char
#define __STDC_VERSION__ 201112L
#define __DEC32_MAX_EXP__ 97
#define __INT_FAST8_MAX__ 0x7fffffff
#define __ARM_ARCH 8
#define __INTPTR_MAX__ 0x7fffffffffffffffL
#define __LDBL_MANT_DIG__ 113
#define __DBL_HAS_QUIET_NAN__ 1
#define __SIG_ATOMIC_MIN__ (-__SIG_ATOMIC_MAX__ - 1)
#define __INTPTR_TYPE__ long int
#define __UINT16_TYPE__ short unsigned int
#define __WCHAR_TYPE__ unsigned int
#define __SIZEOF_FLOAT__ 4
#define __UINTPTR_MAX__ 0xffffffffffffffffUL
#define __ARM_ARCH_8A 1
#define __DEC64_MIN_EXP__ (-382)
#define __INT_FAST64_MAX__ 0x7fffffffffffffffL
#define __GCC_ATOMIC_TEST_AND_SET_TRUEVAL 1
#define __FLT_DIG__ 6
#define __UINT_FAST64_TYPE__ long unsigned int
#define __INT_MAX__ 0x7fffffff
#define __INT64_TYPE__ long int
#define __FLT_MAX_EXP__ 128
#define __ORDER_BIG_ENDIAN__ 4321
#define __DBL_MANT_DIG__ 53
#define __INT_LEAST64_MAX__ 0x7fffffffffffffffL
#define __GCC_ATOMIC_CHAR16_T_LOCK_FREE 2
#define __DEC64_MIN__ 1E-383DD
#define __WINT_TYPE__ unsigned int
#define __UINT_LEAST32_TYPE__ unsigned int
#define __SIZEOF_SHORT__ 2
#define __LDBL_MIN_EXP__ (-16381)
#define __INT_LEAST8_MAX__ 0x7f
#define __SIZEOF_INT128__ 16
#define __LDBL_MAX_10_EXP__ 4932
#define __ATOMIC_RELAXED 0
#define __DBL_EPSILON__ ((double)2.22044604925031308084726333618164062e-16L)
#define _LP64 1
#define __UINT8_C(c) c
#define __INT_LEAST32_TYPE__ int
#define __SIZEOF_WCHAR_T__ 4
#define __UINT64_TYPE__ long unsigned int
#define __ARM_NEON 1
#define __INT_FAST8_TYPE__ int
#define __GNUC_STDC_INLINE__ 1
#define __DBL_DECIMAL_DIG__ 17
#define __STDC_UTF_32__ 1
#define __DEC_EVAL_METHOD__ 2
#define __UINT32_C(c) c ## U
#define __INTMAX_MAX__ 0x7fffffffffffffffL
#define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__
#define __FLT_DENORM_MIN__ 1.40129846432481707092372958328991613e-45F
#define __INT8_MAX__ 0x7f
#define __UINT_FAST32_TYPE__ unsigned int
#define __CHAR32_TYPE__ unsigned int
#define __FLT_MAX__ 3.40282346638528859811704183484516925e+38F
#define __FP_FAST_FMA 1
#define __ARM_FEATURE_NUMERIC_MAXMIN 1
#define __INT32_TYPE__ int
#define __SIZEOF_DOUBLE__ 8
#define __FLT_MIN_10_EXP__ (-37)
#define __INTMAX_TYPE__ long int
#define __DEC128_MAX_EXP__ 6145
#define __ATOMIC_CONSUME 1
#define __GNUC_MINOR__ 1
#define __UINTMAX_MAX__ 0xffffffffffffffffUL
#define __DEC32_MANT_DIG__ 7
#define __DBL_MAX_10_EXP__ 308
#define __LDBL_DENORM_MIN__ 6.47517511943802511092443895822764655e-4966L
#define __INT16_C(c) c
#define __ARM_ARCH_ISA_A64 1
#define __STDC__ 1
#define __PTRDIFF_TYPE__ long int
#define __ATOMIC_SEQ_CST 5
#define __UINT32_TYPE__ unsigned int
#define __UINTPTR_TYPE__ long unsigned int
#define __DEC64_SUBNORMAL_MIN__ 0.000000000000001E-383DD
#define __DEC128_MANT_DIG__ 34
#define __LDBL_MIN_10_EXP__ (-4931)
#define __SIZEOF_LONG_LONG__ 8
#define __GCC_ATOMIC_LLONG_LOCK_FREE 2
#define __LDBL_DIG__ 33
#define __FLT_DECIMAL_DIG__ 9
#define __UINT_FAST16_MAX__ 0xffffffffU
#define __GCC_ATOMIC_SHORT_LOCK_FREE 2
#define __UINT_FAST8_TYPE__ unsigned int
#define __ATOMIC_ACQ_REL 4
#define __ATOMIC_RELEASE 3

Note that normal defines like version number or Linaro release are not
at all useful -- it's the target that is changing.

> Thanks
> Lv
> =

>> [1]
>> https://releases.linaro.org/components/toolchain/binaries/latest/aarch64=
-elff/gcc-linaro-6.1.1-2016-
>> 08-x86_64_aarch64-elf.tar.xz
>> [2] This error was originally discovered by Will Deacon
>>
>> Signed-off-by: Al Stone <ahs3(a)redhat.com>
>> Cc: Will Deacon <will.deacon(a)arm.com>
>> Cc: Rafael J. Wysocki <rjw(a)rjwysocki.net>
>> Cc: Len Brown <lenb(a)kernel.org>
>> Cc: Robert Moore <robert.moore(a)intel.com>
>> Cc: Lv Zheng <lv.zheng(a)intel.com>
>> ---
>>  source/include/platform/acembed.h | 57 ++++++++++++++++++++++++++++++++=
+++++++
>>  source/include/platform/acenv.h   | 11 ++++++++
>>  2 files changed, 68 insertions(+)
>>  create mode 100644 source/include/platform/acembed.h
>>
>> diff --git a/source/include/platform/acembed.h b/source/include/platform=
/acembed.h
>> new file mode 100644
>> index 0000000..e741f8d
>> --- /dev/null
>> +++ b/source/include/platform/acembed.h
>> @@ -0,0 +1,57 @@
>> +/**********************************************************************=
********
>> + *
>> + * Name: acembed.h - OS specific defines, etc. for embedded Linux syste=
ms
>> + *
>> + **********************************************************************=
*******/
>> +
>> +/*
>> + * Copyright (C) 2017, Red Hat, Inc.
>> + * All rights reserved.
>> + *
>> + * Redistribution and use in source and binary forms, with or without
>> + * modification, are permitted provided that the following conditions
>> + * are met:
>> + * 1. Redistributions of source code must retain the above copyright
>> + *    notice, this list of conditions, and the following disclaimer,
>> + *    without modification.
>> + * 2. Redistributions in binary form must reproduce at minimum a discla=
imer
>> + *    substantially similar to the "NO WARRANTY" disclaimer below
>> + *    ("Disclaimer") and any redistribution must be conditioned upon
>> + *    including a substantially similar Disclaimer requirement for furt=
her
>> + *    binary redistribution.
>> + * 3. Neither the names of the above-listed copyright holders nor the n=
ames
>> + *    of any contributors may be used to endorse or promote products de=
rived
>> + *    from this software without specific prior written permission.
>> + *
>> + * Alternatively, this software may be distributed under the terms of t=
he
>> + * GNU General Public License ("GPL") version 2 as published by the Free
>> + * Software Foundation.
>> + *
>> + * NO WARRANTY
>> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
>> + * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>> + * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR
>> + * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
>> + * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQU=
ENTIAL
>> + * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GO=
ODS
>> + * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
>> + * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
>> + * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
>> + * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
>> + * POSSIBILITY OF SUCH DAMAGES.
>> + */
>> +
>> +#ifndef __ACEMBED_H__
>> +#define __ACEMBED_H__
>> +
>> +#if !defined(_LINUX)
>> +#define _LINUX
>> +#endif
>> +
>> +#if !defined(__linux__)
>> +#define __linux__
>> +#endif
>> +
>> +#include <acpi/platform/aclinux.h>
>> +
>> +#endif				/* __ACEMBED_H__ */
>> diff --git a/source/include/platform/acenv.h b/source/include/platform/a=
cenv.h
>> index 5bec576..b300afa 100644
>> --- a/source/include/platform/acenv.h
>> +++ b/source/include/platform/acenv.h
>> @@ -343,6 +343,17 @@
>>  #elif defined(_AED_EFI) || defined(_GNU_EFI) || defined(_EDK2_EFI)
>>  #include "acefi.h"
>>
>> +/*
>> + * There are systems that run just a minimal Linux kernel; they have
>> + * no user space and often extremely pared down configurations -- e.g.,
>> + * a small embedded Linux system in a light bulb or other IoT device.
>> + * In those cases, we're mostly a Linux system, but the compilers used
>> + * may not be aware of that, so create an evironment specific to their
>> + * needs.
>> + */
>> +#elif defined(__GNUC__) && !defined(__INTEL_COMPILER) && !defined(__GLI=
BC__)
>> +#include <acpi/platform/acembed.h>
>> +
>>  #else
>>
>>  /* Unknown environment */
>> --
>> 2.9.3
>>
>>
>> --
>> ciao,
>> al
>> -----------------------------------
>> Al Stone
>> Software Engineer
>> Red Hat, Inc.
>> ahs3(a)redhat.com
>> -----------------------------------


-- =

ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3(a)redhat.com
-----------------------------------

--===============0375788534219813480==--

