Content-Type: multipart/mixed; boundary="===============6649790498513654400=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA:enable 64bit build for aarch64 architecture
Date: Wed, 14 Aug 2013 16:17:40 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E36FEBAF9C@ORSMSX103.amr.corp.intel.com>
In-Reply-To: 1376466309-14710-1-git-send-email-naresh.bhat@linaro.org
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6649790498513654400==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

OK, we'll add this for the next acpica release.
Thanks,
Bob

> -#if defined(__ia64__) || defined(__x86_64__)
> +#if defined(__ia64__) || defined(__x86_64__) || (__aarch64__)


Shouldn't this be:

> -#if defined(__ia64__) || defined(__x86_64__)
> +#if defined(__ia64__) || defined(__x86_64__) || defined(__aarch64__)


> -----Original Message-----
> From: naresh.bhat(a)linaro.org [mailto:naresh.bhat(a)linaro.org]
> Sent: Wednesday, August 14, 2013 12:45 AM
> To: devel(a)acpica.org
> Cc: Moore, Robert; patches(a)linaro.org; linaro-acpi(a)lists.linaro.org;
> Naresh Bhat
> Subject: [PATCH] ACPICA:enable 64bit build for aarch64 architecture
> =

> From: Naresh Bhat <naresh.bhat(a)linaro.org>
> =

> Signed-off-by: Naresh Bhat <naresh.bhat(a)linaro.org>
> =

> Enable 64 bit build for aarch64 architecture in ACPICA Linux platform
> specific defines.
> ---
>  source/include/platform/aclinux.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/source/include/platform/aclinux.h
> b/source/include/platform/aclinux.h
> index e561292..6b8b1ab 100644
> --- a/source/include/platform/aclinux.h
> +++ b/source/include/platform/aclinux.h
> @@ -159,7 +159,7 @@
>  #define ACPI_FLUSH_CPU_CACHE()
>  #define ACPI_CAST_PTHREAD_T(pthread) ((ACPI_THREAD_ID) (pthread))
> =

> -#if defined(__ia64__) || defined(__x86_64__)
> +#if defined(__ia64__) || defined(__x86_64__) || (__aarch64__)
>  #define ACPI_MACHINE_WIDTH          64
>  #define COMPILER_DEPENDENT_INT64    long
>  #define COMPILER_DEPENDENT_UINT64   unsigned long
> --
> 1.7.9.5


--===============6649790498513654400==--

