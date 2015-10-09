Content-Type: multipart/mixed; boundary="===============8004397350073146845=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: AcpiGetSleepTypeData: Failure to find
 \_Sx should not result in a loud warning [v2]
Date: Fri, 09 Oct 2015 14:04:22 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D9784D0@ORSMSX112.amr.corp.intel.com>
In-Reply-To: 5617A525.2070806@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8004397350073146845==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I have no issues with the original solution. We don't warn on other ACPI_NO=
T_FOUND exceptions.


> -----Original Message-----
> From: Prarit Bhargava [mailto:prarit(a)redhat.com]
> Sent: Friday, October 09, 2015 4:30 AM
> To: Zheng, Lv; Moore, Robert; devel(a)acpica.org
> Cc: linux-acpi(a)vger.kernel.org; Wysocki, Rafael J
> Subject: Re: [PATCH] ACPICA: AcpiGetSleepTypeData: Failure to find \_Sx
> should not result in a loud warning [v2]
> =

> =

> =

> On 10/09/2015 01:26 AM, Zheng, Lv wrote:
> > Please ignore this.
> > The fix is against the caller.
> >
> > Thanks and best regards
> > -Lv
> >
> >> -----Original Message-----
> >> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Zheng, Lv
> >> Sent: Friday, October 09, 2015 10:02 AM
> >> To: Prarit Bhargava; Moore, Robert; devel(a)acpica.org
> >> Cc: linux-acpi(a)vger.kernel.org; Wysocki, Rafael J
> >> Subject: Re: [Devel] [PATCH] ACPICA: AcpiGetSleepTypeData: Failure to
> >> find \_Sx should not result in a loud warning [v2]
> >>
> >> Why don't you fix this in the invoker side?
> >> For example:
> >> If (acpi_get_handle())
> >> 	acpi_evaluate_object()
> =

> That seems like a sloppy workaround an actual bug in ACPICA.
> =

> >> So that the AE_NOT_FOUND warning can still be kept for the real
> troubles?
> =

> The code is warning 100% of the time on something that is optional.
> =

> >> There are really scenarios that such warning is useful for catching
> bugs.
> >>
> =

> What scenario is possible where this causes a problem?  Issuing an error
> on something that is optional is not a good idea.
> =

> P.

--===============8004397350073146845==--

