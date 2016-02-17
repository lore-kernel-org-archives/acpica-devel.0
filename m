Content-Type: multipart/mixed; boundary="===============2075618701135123373=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH v2] Introduce AcpiOs(Read|Write)Cmos and
 enable	these in AcpiExCmosSpaceHandler
Date: Wed, 17 Feb 2016 06:03:17 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BB4BE6E@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 1430528466-20537-1-git-send-email-agoode@google.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2075618701135123373==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

As I commented before, the support of Cmos opregion should be done in Linux=
 side.
After Linux applied this commit:
https://patchwork.kernel.org/patch/8241491/
You should be able to install the default operation region handlers near ac=
pi_ec_ecdt_probe().

So IMO you could wait a while for the pending patches to be merged before t=
rying again.

Thanks and best regards
-Lv

> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Adam Goode
> Subject: [Devel] [PATCH v2] Introduce AcpiOs(Read|Write)Cmos and enable
> these in AcpiExCmosSpaceHandler
> =

> This introduces a generic OSL interface for reading and writing
> SystemCMOS spaces. It is needed on Linux for registering a generic
> handler for SystemCMOS because some firmware accesses CMOS in _INI.
> =

> (The first time I sent a somewhat corrupted patch file. This one should
> be better).
> =

> ---
>  source/components/events/evhandler.c         |  1 +
>  source/components/executer/exregion.c        | 23 +++++++++
>  source/include/acconfig.h                    |  2 +-
>  source/include/acpiosxf.h                    | 18 +++++++
>  source/os_specific/service_layers/osunixxf.c | 64 +++++++++++++++++++++++
>  source/os_specific/service_layers/oswinxf.c  | 64 +++++++++++++++++++++++
>  tests/aapits/atosxfctrl.c                    |  2 +
>  tests/aapits/atosxfctrl.h                    |  3 ++
>  tests/aapits/atosxfwrap.c                    | 76 ++++++++++++++++++++++=
++++++
>  tests/aapits/atosxfwrap.h                    | 16 ++++++
>  10 files changed, 268 insertions(+), 1 deletion(-)
> =

> diff --git a/source/components/events/evhandler.c
> b/source/components/events/evhandler.c
> index d02ea53..634c18e 100644
> --- a/source/components/events/evhandler.c
> +++ b/source/components/events/evhandler.c
> @@ -139,6 +139,7 @@ UINT8
> AcpiGbl_DefaultAddressSpaces[ACPI_NUM_DEFAULT_SPACES] =3D
>      ACPI_ADR_SPACE_SYSTEM_MEMORY,
>      ACPI_ADR_SPACE_SYSTEM_IO,
>      ACPI_ADR_SPACE_PCI_CONFIG,
> +    ACPI_ADR_SPACE_CMOS,
>      ACPI_ADR_SPACE_DATA_TABLE
>  };
> =

> diff --git a/source/components/executer/exregion.c
> b/source/components/executer/exregion.c
> index 31bbb60..bd9addd 100644
> --- a/source/components/executer/exregion.c
> +++ b/source/components/executer/exregion.c
> @@ -551,6 +551,29 @@ AcpiExCmosSpaceHandler (
>      ACPI_FUNCTION_TRACE (ExCmosSpaceHandler);
> =

> =

> +    ACPI_DEBUG_PRINT ((ACPI_DB_INFO,
> +        "System-CMOS (width %u) R/W %u Address=3D%8.8X%8.8X\n",
> +        BitWidth, Function, ACPI_FORMAT_UINT64(Address)));
> +
> +    switch (Function)
> +    {
> +    case ACPI_READ:
> +
> +        *Value =3D 0;
> +        Status =3D AcpiOsReadCmos(Address, Value, BitWidth);
> +        break;
> +
> +    case ACPI_WRITE:
> +
> +        Status =3D AcpiOsWriteCmos(Address, *Value, BitWidth);
> +        break;
> +
> +    default:
> +
> +        Status =3D AE_BAD_PARAMETER;
> +        break;
> +    }
> +
>      return_ACPI_STATUS (Status);
>  }
> =

> diff --git a/source/include/acconfig.h b/source/include/acconfig.h
> index 41fa33d..dcecfa7 100644
> --- a/source/include/acconfig.h
> +++ b/source/include/acconfig.h
> @@ -270,7 +270,7 @@
>  /* Maximum SpaceIds for Operation Regions */
> =

>  #define ACPI_MAX_ADDRESS_SPACE          255
> -#define ACPI_NUM_DEFAULT_SPACES         4
> +#define ACPI_NUM_DEFAULT_SPACES         5
> =

>  /* Array sizes. Used for range checking also */
> =

> diff --git a/source/include/acpiosxf.h b/source/include/acpiosxf.h
> index 68d79c7..31523ea 100644
> --- a/source/include/acpiosxf.h
> +++ b/source/include/acpiosxf.h
> @@ -452,6 +452,24 @@ AcpiOsWritePort (
>      UINT32                  Width);
>  #endif
> =

> +/*
> + * Platform and hardware-independent CMOS memory interfaces
> + */
> +#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_AcpiOsReadCmos
> +ACPI_STATUS
> +AcpiOsReadCmos (
> +    ACPI_PHYSICAL_ADDRESS   Address,
> +    UINT64                  *Value,
> +    UINT32                  Width);
> +#endif
> +
> +#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_AcpiOsWriteCmos
> +ACPI_STATUS
> +AcpiOsWriteCmos (
> +    ACPI_PHYSICAL_ADDRESS   Address,
> +    UINT64                  Value,
> +    UINT32                  Width);
> +#endif
> =

>  /*
>   * Platform and hardware-independent physical memory interfaces
> diff --git a/source/os_specific/service_layers/osunixxf.c
> b/source/os_specific/service_layers/osunixxf.c
> index c48f581..b763ddc 100644
> --- a/source/os_specific/service_layers/osunixxf.c
> +++ b/source/os_specific/service_layers/osunixxf.c
> @@ -1361,6 +1361,70 @@ AcpiOsWritePort (
>  }
> =

> =

> +/**************************************************************
> ***************
> + *
> + * FUNCTION:    AcpiOsReadCmos
> + *
> + * PARAMETERS:  Address             - Address of CMOS memory to read
> + *              Value               - Where value is placed
> + *              Width               - Number of bits
> + *
> + * RETURN:      Value read from CMOS memory
> + *
> + * DESCRIPTION: Read data from CMOS memory
> + *
> +
> ****************************************************************
> *************/
> +
> +ACPI_STATUS
> +AcpiOsReadCmos (
> +    ACPI_PHYSICAL_ADDRESS   Address,
> +    UINT64                  *Value,
> +    UINT32                  Width)
> +{
> +
> +    switch (Width)
> +    {
> +    case 8:
> +    case 16:
> +    case 32:
> +    case 64:
> +
> +        *Value =3D 0;
> +        break;
> +
> +    default:
> +
> +        return (AE_BAD_PARAMETER);
> +    }
> +    return (AE_OK);
> +}
> +
> +
> +/**************************************************************
> ****************
> + *
> + * FUNCTION:    AcpiOsWriteCmos
> + *
> + * PARAMETERS:  Address             - Address of CMOS memory to write
> + *              Value               - Value to write
> + *              Width               - Number of bits
> + *
> + * RETURN:      None
> + *
> + * DESCRIPTION: Write data to CMOS memory
> + *
> +
> ****************************************************************
> *************/
> +
> +ACPI_STATUS
> +AcpiOsWriteCmos (
> +    ACPI_PHYSICAL_ADDRESS   Address,
> +    UINT64                  Value,
> +    UINT32                  Width)
> +{
> +
> +    return (AE_OK);
> +}
> +
> +
> =

> /***************************************************************
> ***************
>   *
>   * FUNCTION:    AcpiOsReadMemory
> diff --git a/source/os_specific/service_layers/oswinxf.c
> b/source/os_specific/service_layers/oswinxf.c
> index 66ce8c8..80086fd 100644
> --- a/source/os_specific/service_layers/oswinxf.c
> +++ b/source/os_specific/service_layers/oswinxf.c
> @@ -1356,6 +1356,70 @@ AcpiOsWritePort (
>  }
> =

> =

> +/**************************************************************
> ***************
> + *
> + * FUNCTION:    AcpiOsReadCmos
> + *
> + * PARAMETERS:  Address             - Address of CMOS memory to read
> + *              Value               - Where value is placed
> + *              Width               - Number of bits
> + *
> + * RETURN:      Value read from CMOS memory
> + *
> + * DESCRIPTION: Read data from CMOS memory
> + *
> +
> ****************************************************************
> *************/
> +
> +ACPI_STATUS
> +AcpiOsReadCmos (
> +    ACPI_PHYSICAL_ADDRESS   Address,
> +    UINT64                  *Value,
> +    UINT32                  Width)
> +{
> +
> +    switch (Width)
> +    {
> +    case 8:
> +    case 16:
> +    case 32:
> +    case 64:
> +
> +        *Value =3D 0;
> +        break;
> +
> +    default:
> +
> +        return (AE_BAD_PARAMETER);
> +    }
> +    return (AE_OK);
> +}
> +
> +
> +/**************************************************************
> ****************
> + *
> + * FUNCTION:    AcpiOsWriteCmos
> + *
> + * PARAMETERS:  Address             - Address of CMOS memory to write
> + *              Value               - Value to write
> + *              Width               - Number of bits
> + *
> + * RETURN:      None
> + *
> + * DESCRIPTION: Write data to CMOS memory
> + *
> +
> ****************************************************************
> *************/
> +
> +ACPI_STATUS
> +AcpiOsWriteCmos (
> +    ACPI_PHYSICAL_ADDRESS   Address,
> +    UINT64                  Value,
> +    UINT32                  Width)
> +{
> +
> +    return (AE_OK);
> +}
> +
> +
> =

> /***************************************************************
> ***************
>   *
>   * FUNCTION:    AcpiOsReadMemory
> diff --git a/tests/aapits/atosxfctrl.c b/tests/aapits/atosxfctrl.c
> index fe8b562..9a6b41c 100644
> --- a/tests/aapits/atosxfctrl.c
> +++ b/tests/aapits/atosxfctrl.c
> @@ -160,6 +160,8 @@ const char              *OsxfNames[] =3D {
>      "AcpiOsDerivePciId",
>      "AcpiOsReadPort",
>      "AcpiOsWritePort",
> +    "AcpiOsReadCmos",
> +    "AcpiOsWriteCmos",
>      "AcpiOsReadMemory",
>      "AcpiOsWriteMemory",
>      "AcpiOsSignal"};
> diff --git a/tests/aapits/atosxfctrl.h b/tests/aapits/atosxfctrl.h
> index 66a361d..2c8b9e5 100644
> --- a/tests/aapits/atosxfctrl.h
> +++ b/tests/aapits/atosxfctrl.h
> @@ -162,6 +162,8 @@ typedef enum
>      AcpiOsDerivePciIdC,
>      AcpiOsReadPortC,
>      AcpiOsWritePortC,
> +    AcpiOsReadCmosC,
> +    AcpiOsWriteCmosC,
>      AcpiOsReadMemoryC,
>      AcpiOsWriteMemoryC,
>      AcpiOsSignalC,
> @@ -229,6 +231,7 @@ typedef struct acpi_os_emul_reg
>   */
>  #define EMUL_REG_SYS           0x01
>  #define EMUL_REG_IO            0x02
> +#define EMUL_REG_CMOS          0x03
> =

>  /*
>   * Fixed ACPI h/w emulated registers numbers
> diff --git a/tests/aapits/atosxfwrap.c b/tests/aapits/atosxfwrap.c
> index 7c5de39..0088212 100644
> --- a/tests/aapits/atosxfwrap.c
> +++ b/tests/aapits/atosxfwrap.c
> @@ -1272,6 +1272,82 @@ AcpiOsWritePort (
>  }
> =

> =

> +/**************************************************************
> ***************
> + *
> + * FUNCTION:    AcpiOsReadCmos
> + *
> + * PARAMETERS:  Address             - Address of CMOS memory to read
> + *              Value               - Where value is placed
> + *              Width               - Number of bits
> + *
> + * RETURN:      Value read from CMOS memory
> + *
> + * DESCRIPTION: Read data from CMOS memory
> + *
> +
> ****************************************************************
> *************/
> +
> +ACPI_STATUS
> +AcpiOsReadCmos (
> +    ACPI_PHYSICAL_ADDRESS   Address,
> +    UINT64                  *Value,
> +    UINT32                  Width)
> +{
> +    AT_CTRL_DECL(AcpiOsReadCmos);
> +
> +    AT_CHCK_RET_STATUS(AcpiOsReadCmos);
> +
> +    if (!EMUL_REG_MODE) {
> +        Status =3D AcpiOsActualReadCmos(Address, Value, Width);
> +    }
> +    else
> +    {
> +        Status =3D OsxfCtrlReadReg(EMUL_REG_CMOS, Address, Value, Width);
> +    }
> +
> +    AT_CTRL_SUCCESS(AcpiOsReadCmos);
> +
> +    return (Status);
> +}
> +
> +
> +/**************************************************************
> ****************
> + *
> + * FUNCTION:    AcpiOsWriteCmos
> + *
> + * PARAMETERS:  Address             - Address of CMOS memory to write
> + *              Value               - Value to write
> + *              Width               - Number of bits
> + *
> + * RETURN:      None
> + *
> + * DESCRIPTION: Write data to CMOS memory
> + *
> +
> ****************************************************************
> *************/
> +
> +ACPI_STATUS
> +AcpiOsWriteCmos (
> +    ACPI_PHYSICAL_ADDRESS   Address,
> +    UINT64                  Value,
> +    UINT32                  Width)
> +{
> +    AT_CTRL_DECL(AcpiOsWriteCmos);
> +
> +    AT_CHCK_RET_STATUS(AcpiOsWriteCmos);
> +
> +    if (!EMUL_REG_MODE) {
> +        Status =3D AcpiOsActualWriteCmos(Address, Value, Width);
> +    }
> +    else
> +    {
> +        Status =3D OsxfCtrlWriteReg(EMUL_REG_CMOS, Address, Value, Width=
);
> +    }
> +
> +    AT_CTRL_SUCCESS(AcpiOsWriteCmos);
> +
> +    return (Status);
> +}
> +
> +
> =

> /***************************************************************
> ***************
>   *
>   * FUNCTION:    AcpiOsReadMemory
> diff --git a/tests/aapits/atosxfwrap.h b/tests/aapits/atosxfwrap.h
> index 27224d0..48e2100 100644
> --- a/tests/aapits/atosxfwrap.h
> +++ b/tests/aapits/atosxfwrap.h
> @@ -324,6 +324,22 @@ AcpiOsActualWritePort (
> =

> =

>  /*
> + * Platform and hardware-independent CMOS memory interfaces
> + */
> +ACPI_STATUS
> +AcpiOsActualReadCmos (
> +    ACPI_PHYSICAL_ADDRESS   Address,
> +    UINT64                  *Value,
> +    UINT32                  Width);
> +
> +ACPI_STATUS
> +AcpiOsActualWriteCmos (
> +    ACPI_PHYSICAL_ADDRESS   Address,
> +    UINT64                  Value,
> +    UINT32                  Width);
> +
> +
> +/*
>   * Platform and hardware-independent physical memory interfaces
>   */
>  ACPI_STATUS
> --
> 2.3.7
> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> https://lists.acpica.org/mailman/listinfo/devel

--===============2075618701135123373==--

