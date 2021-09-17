Content-Type: multipart/mixed; boundary="===============4097534992101820119=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] Re: [PATCH AUTOSEL 4.4 24/35] ACPICA: iASL: Fix for WPBT
 table with no command-line arguments
Date: Fri, 17 Sep 2021 19:21:57 +0000
Message-ID: <BYAPR11MB3256A989B8F75EE3A9C885F387DD9@BYAPR11MB3256.namprd11.prod.outlook.com>
In-Reply-To: 20210910074535.GA454@amd
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4097534992101820119==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This structure is used by the iASL data table disassembler.
Bob


-----Original Message-----
From: Pavel Machek <pavel(a)denx.de> =

Sent: Friday, September 10, 2021 12:46 AM
To: Sasha Levin <sashal(a)kernel.org>
Cc: linux-kernel(a)vger.kernel.org; stable(a)vger.kernel.org; Moore, Robert=
 <robert.moore(a)intel.com>; Wysocki, Rafael J <rafael.j.wysocki(a)intel.co=
m>; linux-acpi(a)vger.kernel.org; devel(a)acpica.org
Subject: Re: [PATCH AUTOSEL 4.4 24/35] ACPICA: iASL: Fix for WPBT table wit=
h no command-line arguments

Hi!

> Handle the case where the Command-line Arguments table field does not =

> exist.
> =

> ACPICA commit d6487164497fda170a1b1453c5d58f2be7c873d6

I'm not sure what is going on here, but adding unused definition will not m=
ake any difference for 4.4 users, so we don't need this in -stable...?

Best regards,
								Pavel

> +++ b/include/acpi/actbl3.h
> @@ -738,6 +738,10 @@ struct acpi_table_wpbt {
>  	u16 arguments_length;
>  };
>  =

> +struct acpi_wpbt_unicode {
> +	u16 *unicode_string;
> +};
> +
>  /***********************************************************************=
********
>   *
>   * XENV - Xen Environment Table (ACPI 6.0)

-- =

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
--===============4097534992101820119==--

