Content-Type: multipart/mixed; boundary="===============3900198647007183000=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: Export mutex functions
Date: Mon, 17 Apr 2017 19:35:39 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E593480@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E37E59332C@ORSMSX110.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3900198647007183000==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Moore, Robert
> Sent: Monday, April 17, 2017 12:28 PM
> To: 'Guenter Roeck' <linux(a)roeck-us.net>; Zheng, Lv <lv.zheng(a)intel.c=
om>
> Cc: Wysocki, Rafael J <rafael.j.wysocki(a)intel.com>; 'Len Brown'
> <lenb(a)kernel.org>; 'linux-acpi(a)vger.kernel.org' <linux-
> acpi(a)vger.kernel.org>; 'devel(a)acpica.org' <devel(a)acpica.org>; 'linu=
x-
> kernel(a)vger.kernel.org' <linux-kernel(a)vger.kernel.org>; Box, David E
> (david.e.box(a)intel.com) <david.e.box(a)intel.com>
> Subject: RE: [PATCH] ACPICA: Export mutex functions
> =

> =

> > -----Original Message-----
> > From: Moore, Robert
> > Sent: Monday, April 17, 2017 10:13 AM
> > To: Guenter Roeck <linux(a)roeck-us.net>; Zheng, Lv <lv.zheng(a)intel.c=
om>
> > Cc: Wysocki, Rafael J <rafael.j.wysocki(a)intel.com>; Len Brown
> > <lenb(a)kernel.org>; linux-acpi(a)vger.kernel.org; devel(a)acpica.org;
> > linux- kernel(a)vger.kernel.org
> > Subject: RE: [PATCH] ACPICA: Export mutex functions
> >
> > There is a model for the drivers to directly acquire an AML mutex
> > object. That is why the acquire/release public interfaces were added
> > to ACPICA.
> >
> > I forget all of the details, but the model was developed with MS and
> > others during the ACPI 6.0 timeframe.
> >
> >
> [Moore, Robert]
> =

> =

> Here is the case where the OS may need to directly acquire an AML mutex:
> =

> From the ACPI spec:
> =

> 19.6.2 Acquire (Acquire a Mutex)
> =

> Note: For Mutex objects referenced by a _DLM object, the host OS may
> also contend for ownership.
> =

> Other than this case, the OS/drivers should never need to directly
> acquire an AML mutex.
> Bob

[Moore, Robert] =

Here is more information, from the ACPICA reference:

8.3.15 AcpiAcquireMutex

This function is intended to be used in conjunction with the _DLM (Device L=
ock Method) predefined name to directly acquire a mutex object that is defi=
ned in the ACPI namespace. The purpose of this is to provide a mutual exclu=
sion mechanism between the AML interpreter and an ACPI-related device drive=
r, in order to support multiple-operation transactions.

From the ACPI Specification: "The _DLM object appears in a device scope wh=
en AML access to the device must be synchronized with the OS environment. I=
t is used in conjunction with a standard Mutex object. With _DLM, the stand=
ard Mutex provides synchronization within the AML environment as usual, but=
 also synchronizes with the OS environment."

The AML mutex node is pointed to by Parent:Pathname. Either the Parent or t=
he Pathname can be NULL, but not both.

If the operation fails an appropriate status will be returned.



--===============3900198647007183000==--

