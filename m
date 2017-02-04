Content-Type: multipart/mixed; boundary="===============8199334982644517287=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] acpica: Fix double-free in acpi_ns_repair_CID()
Date: Sat, 04 Feb 2017 04:19:33 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E563AEA@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 20170203205654.28269-1-jprvita@endlessm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8199334982644517287==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Here's the sequence of events as I see it:

Repair_HID is a standalone function that removes one reference on the incom=
ing object. For simple _HID objects, this in fact deletes the object.

For _CID, all elements of the package are examined. If a repair was made on=
 a _HID within the _CID function, one reference on the original object was =
removed by Repair_HID. However, since the object is part of a package, it h=
as an extra reference to reflect this fact. Thus, in the case in question, =
the elements of the package all have at least two references. Repair_HID re=
moves one reference, thus the extra RemoveReference is needed in Repair_CID=
 to bring the reference count down to zero actually delete the object (in t=
he typical case where the object had two references).

Bob


> -----Original Message-----
> From: Jo=C3=A3o Paulo Rechi Vita [mailto:jprvita(a)gmail.com]
> Sent: Friday, February 03, 2017 12:57 PM
> To: Moore, Robert; Zheng, Lv; Wysocki, Rafael J; Len Brown; Lin Ming
> Cc: linux-acpi(a)vger.kernel.org; devel(a)acpica.org; linux-
> kernel(a)vger.kernel.org; Daniel Drake; linux(a)endlessm.com; Jo=C3=A3o P=
aulo Rechi
> Vita
> Subject: [PATCH] acpica: Fix double-free in acpi_ns_repair_CID()
> =

> When acpi_ns_repair_CID() is called for a _CID which returns a package of
> strings, it calls acpi_ns_repair_HID() for each of the package elements.
> acpi_ns_repair_HID() calls acpi_ut_remove_reference() on the original
> object, but acpi_ns_repair_CID() calls it again on return, leading to a
> double free.
> =

> This problem was seen on a Acer TravelMate P449-G2-MG.
> =

> Thanks to Daniel Drake for helping investigating this problem.
> =

> Signed-off-by: Jo=C3=A3o Paulo Rechi Vita <jprvita(a)endlessm.com>
> ---
>  drivers/acpi/acpica/nsrepair2.c | 2 --
>  1 file changed, 2 deletions(-)
> =

> diff --git a/drivers/acpi/acpica/nsrepair2.c
> b/drivers/acpi/acpica/nsrepair2.c index d5336122486b..c429c8eca476 100644
> --- a/drivers/acpi/acpica/nsrepair2.c
> +++ b/drivers/acpi/acpica/nsrepair2.c
> @@ -411,8 +411,6 @@ acpi_ns_repair_CID(struct acpi_evaluate_info *info,
> =

>  			(*element_ptr)->common.reference_count =3D
>  			    original_ref_count;
> -
> -			acpi_ut_remove_reference(original_element);
>  		}
> =

>  		element_ptr++;
> --
> 2.11.0


--===============8199334982644517287==--

