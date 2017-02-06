Content-Type: multipart/mixed; boundary="===============7404091444420049203=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH] acpica: Fix double-free in acpi_ns_repair_CID()
Date: Mon, 06 Feb 2017 01:44:15 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CE36E22@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E37E563AEA@ORSMSX110.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7404091444420049203==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

So if a real problem related to package reference counting is triggered, th=
e problem should be fixed elsewhere IMO.
See this bug for reference:
https://bugs.acpica.org/show_bug.cgi?id=3D1336

Thanks and best regards
Lv

> From: Moore, Robert
> Subject: RE: [PATCH] acpica: Fix double-free in acpi_ns_repair_CID()
> =

> Here's the sequence of events as I see it:
> =

> Repair_HID is a standalone function that removes one reference on the inc=
oming object. For simple _HID
> objects, this in fact deletes the object.
> =

> For _CID, all elements of the package are examined. If a repair was made =
on a _HID within the _CID
> function, one reference on the original object was removed by Repair_HID.=
 However, since the object is
> part of a package, it has an extra reference to reflect this fact. Thus, =
in the case in question, the
> elements of the package all have at least two references. Repair_HID remo=
ves one reference, thus the
> extra RemoveReference is needed in Repair_CID to bring the reference coun=
t down to zero actually
> delete the object (in the typical case where the object had two reference=
s).
> =

> Bob
> =

> =

> > From: Jo=C3=A3o Paulo Rechi Vita [mailto:jprvita(a)gmail.com]
> > Subject: [PATCH] acpica: Fix double-free in acpi_ns_repair_CID()
> >
> > When acpi_ns_repair_CID() is called for a _CID which returns a package =
of
> > strings, it calls acpi_ns_repair_HID() for each of the package elements.
> > acpi_ns_repair_HID() calls acpi_ut_remove_reference() on the original
> > object, but acpi_ns_repair_CID() calls it again on return, leading to a
> > double free.
> >
> > This problem was seen on a Acer TravelMate P449-G2-MG.
> >
> > Thanks to Daniel Drake for helping investigating this problem.
> >
> > Signed-off-by: Jo=C3=A3o Paulo Rechi Vita <jprvita(a)endlessm.com>
> > ---
> >  drivers/acpi/acpica/nsrepair2.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/acpi/acpica/nsrepair2.c
> > b/drivers/acpi/acpica/nsrepair2.c index d5336122486b..c429c8eca476 1006=
44
> > --- a/drivers/acpi/acpica/nsrepair2.c
> > +++ b/drivers/acpi/acpica/nsrepair2.c
> > @@ -411,8 +411,6 @@ acpi_ns_repair_CID(struct acpi_evaluate_info *info,
> >
> >  			(*element_ptr)->common.reference_count =3D
> >  			    original_ref_count;
> > -
> > -			acpi_ut_remove_reference(original_element);
> >  		}
> >
> >  		element_ptr++;
> > --
> > 2.11.0


--===============7404091444420049203==--

