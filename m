Content-Type: multipart/mixed; boundary="===============5422540107620182851=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: Export mutex functions
Date: Wed, 12 Apr 2017 15:29:55 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E5924DB@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 1492009990-3539-1-git-send-email-linux@roeck-us.net
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5422540107620182851==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The ACPICA mutex functions are based on the host OS functions, so they don'=
t really buy you anything. You should just use the native Linux functions.


> -----Original Message-----
> From: Guenter Roeck [mailto:linux(a)roeck-us.net]
> Sent: Wednesday, April 12, 2017 8:13 AM
> To: Moore, Robert <robert.moore(a)intel.com>; Zheng, Lv
> <lv.zheng(a)intel.com>; Wysocki, Rafael J <rafael.j.wysocki(a)intel.com>;
> Len Brown <lenb(a)kernel.org>
> Cc: linux-acpi(a)vger.kernel.org; devel(a)acpica.org; linux-
> kernel(a)vger.kernel.org; Guenter Roeck <linux(a)roeck-us.net>
> Subject: [PATCH] ACPICA: Export mutex functions
> =

> Mutex functions may be needed by drivers. Examples are accesses to
> Super-IO SIO registers (0x2e/0x2f or 0x4e/0x4f) or Super-IO
> environmental monitor registers, both which may also be accessed through
> DSDT.
> =

> Signed-off-by: Guenter Roeck <linux(a)roeck-us.net>
> ---
>  drivers/acpi/acpica/utxfmutex.c | 2 ++
>  1 file changed, 2 insertions(+)
> =

> diff --git a/drivers/acpi/acpica/utxfmutex.c
> b/drivers/acpi/acpica/utxfmutex.c index c016211c35ae..5d20581f4b2f
> 100644
> --- a/drivers/acpi/acpica/utxfmutex.c
> +++ b/drivers/acpi/acpica/utxfmutex.c
> @@ -150,6 +150,7 @@ acpi_acquire_mutex(acpi_handle handle, acpi_string
> pathname, u16 timeout)
>  	status =3D acpi_os_acquire_mutex(mutex_obj->mutex.os_mutex, timeout);
>  	return (status);
>  }
> +ACPI_EXPORT_SYMBOL(acpi_acquire_mutex)
> =

> =

> /***********************************************************************
> ********
>   *
> @@ -185,3 +186,4 @@ acpi_status acpi_release_mutex(acpi_handle handle,
> acpi_string pathname)
>  	acpi_os_release_mutex(mutex_obj->mutex.os_mutex);
>  	return (AE_OK);
>  }
> +ACPI_EXPORT_SYMBOL(acpi_release_mutex)
> --
> 2.7.4


--===============5422540107620182851==--

