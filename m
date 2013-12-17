Content-Type: multipart/mixed; boundary="===============0343066607811609773=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH 05/11] drivers: acpi: Include appropriate header
 file in utstate.c
Date: Tue, 17 Dec 2013 17:35:46 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37C7B99F5@ORSMSX103.amr.corp.intel.com>
In-Reply-To: c8f6f6fbcd7de593a726d091f5d0f6a245f6e0f7.1387271324.git.rashika.kheria@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0343066607811609773==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I'm not sure what version of ACPICA you are looking at, but in the master g=
it tree for ACPICA, the file accommon.h includes "acutils.h".

> -----Original Message-----
> From: Rashika Kheria [mailto:rashika.kheria(a)gmail.com]
> Sent: Tuesday, December 17, 2013 1:22 AM
> To: linux-kernel(a)vger.kernel.org
> Cc: Moore, Robert; Zheng, Lv; Wysocki, Rafael J; Len Brown; linux-
> acpi(a)vger.kernel.org; josh(a)joshtriplett.org; devel(a)acpica.org
> Subject: [PATCH 05/11] drivers: acpi: Include appropriate header file in
> utstate.c
> =

> Include appropriate header file acutils.h in acpica/utstate.c because
> function acpi_ut_create_pkg_state_and_push() has its prototype declaration
> in acutils.h. Also, encloses the function in acpica/utstate.c in ifdef
> condition of ACPI_FUTURE_USAGE.
> =

> This eliminates the following warning in utstate.c:
> drivers/acpi/acpica/utstate.c:64:1: warning: no previous prototype for
> =E2=80=98acpi_ut_create_pkg_state_and_push=E2=80=99 [-Wmissing-prototypes]
> =

> Signed-off-by: Rashika Kheria <rashika.kheria(a)gmail.com>
> Reviewed-by: Josh Triplett <josh(a)joshtriplett.org>
> ---
>  drivers/acpi/acpica/utstate.c |    3 +++
>  1 file changed, 3 insertions(+)
> =

> diff --git a/drivers/acpi/acpica/utstate.c b/drivers/acpi/acpica/utstate.c
> index 03c4c2f..0920d23 100644
> --- a/drivers/acpi/acpica/utstate.c
> +++ b/drivers/acpi/acpica/utstate.c
> @@ -43,6 +43,7 @@
> =

>  #include <acpi/acpi.h>
>  #include "accommon.h"
> +#include "acutils.h"
> =

>  #define _COMPONENT          ACPI_UTILITIES
>  ACPI_MODULE_NAME("utstate")
> @@ -60,6 +61,7 @@ ACPI_MODULE_NAME("utstate")
>   * DESCRIPTION: Create a new state and push it
>   *
> =

> **************************************************************************
> ****/
> +#ifdef  ACPI_FUTURE_USAGE
>  acpi_status
>  acpi_ut_create_pkg_state_and_push(void *internal_object,
>  				  void *external_object,
> @@ -79,6 +81,7 @@ acpi_ut_create_pkg_state_and_push(void *internal_object,
>  	acpi_ut_push_generic_state(state_list, state);
>  	return (AE_OK);
>  }
> +#endif
> =

> =

> /*************************************************************************
> ******
>   *
> --
> 1.7.9.5


--===============0343066607811609773==--

