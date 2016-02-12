Content-Type: multipart/mixed; boundary="===============4548142011708577548=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH v2 6/9] ACPI: add definition of DBG2 subtypes
Date: Fri, 12 Feb 2016 22:47:44 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37DA9BA10@ORSMSX112.amr.corp.intel.com>
In-Reply-To: 1455299022-11641-7-git-send-email-aleksey.makarov@linaro.org
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4548142011708577548==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

OK, we'll take these for the next release of ACPICA.
Thanks,
Bob


> -----Original Message-----
> From: Aleksey Makarov [mailto:aleksey.makarov(a)linaro.org]
> Sent: Friday, February 12, 2016 9:44 AM
> To: linux-acpi(a)vger.kernel.org
> Cc: linux-serial(a)vger.kernel.org; linux-kernel(a)vger.kernel.org; linux=
-arm-
> kernel(a)lists.infradead.org; Aleksey Makarov; Russell King; Greg Kroah-
> Hartman; Rafael J . Wysocki; Leif Lindholm; Graeme Gregory; Al Stone;
> Christopher Covington; Moore, Robert; Zheng, Lv; Wysocki, Rafael J; Len
> Brown; devel(a)acpica.org
> Subject: [PATCH v2 6/9] ACPI: add definition of DBG2 subtypes
> =

> The recent version of Microsoft Debug Port Table 2 (DBG2) [1] specifies
> additional serial debug port subtypes.  These constants are also referred
> by Serial Port Console Redirection Table (SPCR) [2]
> =

> Add these constants.
> =

> [1] https://msdn.microsoft.com/en-
> us/library/windows/hardware/dn639131(v=3Dvs.85).aspx
> [2] https://msdn.microsoft.com/en-
> us/library/windows/hardware/dn639132(v=3Dvs.85).aspx
> =

> Signed-off-by: Aleksey Makarov <aleksey.makarov(a)linaro.org>
> Tested-by: Christopher Covington <cov(a)codeaurora.org>
> ---
>  include/acpi/actbl2.h | 5 +++++
>  1 file changed, 5 insertions(+)
> =

> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h index
> a4ef625..e9930ab 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h
> @@ -371,6 +371,11 @@ struct acpi_dbg2_device {
> =

>  #define ACPI_DBG2_16550_COMPATIBLE  0x0000
>  #define ACPI_DBG2_16550_SUBSET      0x0001
> +#define ACPI_DBG2_ARM_PL011         0x0003
> +#define ACPI_DBG2_ARM_SBSA_32BIT    0x000d
> +#define ACPI_DBG2_ARM_SBSA_GENERIC  0x000e
> +#define ACPI_DBG2_ARM_DCC           0x000f
> +#define ACPI_DBG2_BCM2835           0x0010
> =

>  #define ACPI_DBG2_1394_STANDARD     0x0000
> =

> --
> 2.7.0


--===============4548142011708577548==--

