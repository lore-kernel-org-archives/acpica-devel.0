Content-Type: multipart/mixed; boundary="===============6394764905266155175=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rjw at rjwysocki.net>
Subject: Re: [Devel] [PATCH] ACPICA: Fix compilation with bare-metal toolchian
Date: Fri, 05 Jul 2019 11:43:38 +0200
Message-ID: <2847939.QcJ3fIVZhg@kreacher>
In-Reply-To: CAMhj-NcA8J8rD1PC6mH+HAjBdv2H532UB5aB5-0Y6VWtUh=8-g@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6394764905266155175==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Saturday, June 22, 2019 11:03:54 PM CEST Laster K. wrote:
> An ifdef expects to be compiled with full-fledged Linux toolchain,
> but it's common to compile kernel with just bare-metal toolchain
> which doesn't define __linux__. So, also add __KERNEL__ check.
> =

> Signed-off-by: Laster K. (lazerl0rd) <officiallazerl0rd(a)gmail.com>
> ---
> Apologies for the multiple/spammed e-mails, I was having mail client issu=
es.
> =

>  include/acpi/platform/acenv.h   | 2 +-
>  include/acpi/platform/acenvex.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> =

> diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
> index 35ab3f87cc29..b69319198cb8 100644
> --- a/include/acpi/platform/acenv.h
> +++ b/include/acpi/platform/acenv.h
> @@ -148,7 +148,7 @@
> =

>  #endif
> =

> -#if defined(_LINUX) || defined(__linux__)
> +#if defined(_LINUX) || defined(__KERNEL__) || defined(__linux__)
>  #include <acpi/platform/aclinux.h>
> =

>  #elif defined(_APPLE) || defined(__APPLE__)
> diff --git a/include/acpi/platform/acenvex.h b/include/acpi/platform/acen=
vex.h
> index 2e36c8344897..c7697a47e33f 100644
> --- a/include/acpi/platform/acenvex.h
> +++ b/include/acpi/platform/acenvex.h
> @@ -19,7 +19,7 @@
>   *
>   ***********************************************************************=
******/
> =

> -#if defined(_LINUX) || defined(__linux__)
> +#if defined(_LINUX) || defined(__KERNEL__) || defined(__linux__)
>  #include <acpi/platform/aclinuxex.h>
> =

>  #elif defined(__DragonFly__)
> =


Erik, Bob, any input here?




--===============6394764905266155175==--

