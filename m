Content-Type: multipart/mixed; boundary="===============6383117753066343398=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH v2] ACPICA: Utility: Add system sleep transition
 notification support.
Date: Mon, 07 Jan 2013 20:57:26 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E346BF786C@ORSMSX101.amr.corp.intel.com>
In-Reply-To: 3b5964fe8f66bddbc4bb37a563e55f50c20b4d57.1357272874.git.lv.zheng@intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6383117753066343398==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I believe that _GTS and _BFS may be removed from the ACPI specification.

Nobody implements them, nobody calls them.


> -----Original Message-----
> From: Zheng, Lv
> Sent: Thursday, January 03, 2013 8:42 PM
> To: Moore, Robert
> Cc: devel(a)acpica.org; Zheng, Lv
> Subject: [PATCH v2] ACPICA: Utility: Add system sleep transition
> notification support.
> =

> An OEM-supplied definition block provides some number of controls
> appropriate for system level management.
> There are 5 methods defined in the ACPI 5.0 specification:
>   Mandatory: _TTS, _PTS, _WAK
>   Optional: _BFS, _GTS
> This patch introduces a new function - AcpiNotifySleepTransition - which
> can be invoked by OSPM to evaluate such methods to notify the platform
> firmware of the system sleep state transitions.
> =

> Signed-off-by: Lv Zheng <lv.zheng(a)intel.com>
> ---
> History:
>  v1:
>    1. Add sleep transition notification method names -
> METHOD_PATHNAME_xxx.
>    2. Add sleep transition step macros - ACPI_SLEEP_xxx.
>    3. Add sleep transition notification API - AcpiNotifySleepTransition.
>  v2:
>    1. Fix errors in the patch description.
>    2. Enhance source code commentary.
>    3. Fix coding style issues.
> ---
>  source/components/utilities/utxface.c |   97
> +++++++++++++++++++++++++++++++++
>  source/include/acnames.h              |    5 +-
>  source/include/acpixf.h               |    5 ++
>  source/include/actypes.h              |    8 +++
>  4 files changed, 114 insertions(+), 1 deletion(-)
> =

> Index: acpica/source/components/utilities/utxface.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- acpica.orig/source/components/utilities/utxface.c	2013-01-04
> 12:34:00.000000000 +0800
> +++ acpica/source/components/utilities/utxface.c	2013-01-04
> 12:37:39.000000000 +0800
> @@ -599,6 +599,102 @@
> =

>  ACPI_EXPORT_SYMBOL (AcpiCheckAddressRange)
> =

> +
> +/**********************************************************************
> +*********
> + *
> + * FUNCTION:    AcpiNotifySleepTransition
> + *
> + * PARAMETERS:  State               - Sleep state to be passed to the
> firmware
> + *              Step                - Sleep transition step
> + *
> + * RETURN:      Status
> + *
> + * DESCRIPTION: OEM-supplied system level control methods are required to
> be
> + *              evaluated to notify the platform firmware of the sleep
> state
> + *              transitions. This helper function can be called by OSPM
> in
> + *              the proper point during the system sleep transitions:
> + *              _TTS - ACPI_SLEEP_SUSPEND_BEGIN/ACPI_SLEEP_RESUME_END:
> + *                    beginning of suspending / end of resuming.
> + *              _PTS - ACPI_SLEEP_SUSPEND_DEVICES:
> + *                    after the readiness of the devices' suspending.
> + *              _WAK - ACPI_SLEEP_RESUME_DEVICES:
> + *                    before the readiness of the devices' resuming.
> + *              _GTS (optional) - ACPI_SLEEP_SUSPEND_SYSTEM:
> + *                    after the readiness of the system's suspending.
> + *              _BFS (optional) - ACPI_SLEEP_RESUME_SYSTEM:
> + *                    before the readiness of the system's resuming.
> + *
> +
> +***********************************************************************
> +*******/
> +
> +ACPI_STATUS
> +AcpiNotifySleepTransition (
> +    UINT32                  State,
> +    UINT32                  Step)
> +{
> +    char                    *Method;
> +    ACPI_STATUS             Status;
> +    ACPI_OBJECT             Arg[1];
> +    ACPI_OBJECT_LIST        ArgList;
> +
> +
> +    /* Sanity check for the sleep state */
> +
> +    if (State > ACPI_STATE_S5)
> +    {
> +        return (AE_BAD_PARAMETER);
> +    }
> +
> +    /* Sanity check for the sleep step */
> +
> +    switch (Step)
> +    {
> +    case ACPI_SLEEP_SUSPEND_BEGIN:
> +    case ACPI_SLEEP_RESUME_END:
> +        Method =3D METHOD_PATHNAME__TTS;
> +        break;
> +
> +    case ACPI_SLEEP_SUSPEND_DEVICES:
> +        Method =3D METHOD_PATHNAME__PTS;
> +        break;
> +
> +    case ACPI_SLEEP_RESUME_DEVICES:
> +        Method =3D METHOD_PATHNAME__WAK;
> +        break;
> +
> +    case ACPI_SLEEP_SUSPEND_SYSTEM:
> +        Method =3D METHOD_PATHNAME__GTS;
> +        break;
> +
> +    case ACPI_SLEEP_RESUME_SYSTEM:
> +        Method =3D METHOD_PATHNAME__BFS;
> +        break;
> +
> +    default:
> +        return (AE_BAD_PARAMETER);
> +        break;
> +    }
> +
> +    /* Setup input argument */
> +
> +    ArgList.Count =3D 1;
> +    ArgList.Pointer =3D Arg;
> +
> +    Arg[0].Type =3D ACPI_TYPE_INTEGER;
> +    Arg[0].Integer.Value =3D State;
> +
> +    Status =3D AcpiEvaluateObject (NULL, Method, &ArgList, NULL);
> +    if (ACPI_SUCCESS (Status) || Status =3D=3D AE_NOT_FOUND)
> +    {
> +        /* Return AE_OK even when the method does not exist */
> +
> +        return (AE_OK);
> +    }
> +
> +    return (Status);
> +}
> +
> +ACPI_EXPORT_SYMBOL (AcpiNotifySleepTransition)
> +
>  #endif /* !ACPI_ASL_COMPILER */
> =

> =

> Index: acpica/source/include/acnames.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- acpica.orig/source/include/acnames.h	2013-01-04 12:34:00.000000000
> +0800
> +++ acpica/source/include/acnames.h	2013-01-04 12:36:17.000000000 +0800
> @@ -139,9 +139,12 @@
> =

>  /* Method names - these methods must appear at the namespace root */
> =

> -#define METHOD_PATHNAME__PTS    "\\_PTS"
>  #define METHOD_PATHNAME__SST    "\\_SI._SST"
> +#define METHOD_PATHNAME__TTS    "\\_TTS"
> +#define METHOD_PATHNAME__PTS    "\\_PTS"
>  #define METHOD_PATHNAME__WAK    "\\_WAK"
> +#define METHOD_PATHNAME__GTS    "\\_GTS"
> +#define METHOD_PATHNAME__BFS    "\\_BFS"
> =

>  /* Definitions of the predefined namespace names  */
> =

> Index: acpica/source/include/acpixf.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- acpica.orig/source/include/acpixf.h	2013-01-04 12:34:00.000000000
> +0800
> +++ acpica/source/include/acpixf.h	2013-01-04 12:36:17.000000000 +0800
> @@ -261,6 +261,11 @@
>      ACPI_SIZE               Length,
>      ACPI_PLD_INFO           **ReturnBuffer);
> =

> +ACPI_STATUS
> +AcpiNotifySleepTransition (
> +    UINT32                  State,
> +    UINT32                  Step);
> +
>  /*
>   * ACPI Memory management
>   */
> Index: acpica/source/include/actypes.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- acpica.orig/source/include/actypes.h	2013-01-04 12:34:00.000000000
> +0800
> +++ acpica/source/include/actypes.h	2013-01-04 12:36:17.000000000 +0800
> @@ -1265,6 +1265,14 @@
>  #define ACPI_STA_DEVICE_OK              0x08 /* Synonym */
>  #define ACPI_STA_BATTERY_PRESENT        0x10
> =

> +/* Steps for system sleep transition */
> +
> +#define ACPI_SLEEP_SUSPEND_BEGIN	0x00
> +#define ACPI_SLEEP_SUSPEND_DEVICES	0x01
> +#define ACPI_SLEEP_SUSPEND_SYSTEM	0x02 /* Optional */
> +#define ACPI_SLEEP_RESUME_SYSTEM	0x03 /* Optional */
> +#define ACPI_SLEEP_RESUME_DEVICES	0x04
> +#define ACPI_SLEEP_RESUME_END		0x05
> =

>  /* Context structs for address space handlers */
>=20

--===============6383117753066343398==--

