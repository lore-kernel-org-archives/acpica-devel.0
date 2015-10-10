Content-Type: multipart/mixed; boundary="===============9000586200931125719=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: AcpiGetSleepTypeData: Failure to find
 \_Sx should not result in a loud warning [v2]
Date: Sat, 10 Oct 2015 01:22:20 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BAC6BF4@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 5617A525.2070806@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============9000586200931125719==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> From: Prarit Bhargava [mailto:prarit(a)redhat.com]
> Sent: Friday, October 09, 2015 7:30 PM
> =

> On 10/09/2015 01:26 AM, Zheng, Lv wrote:
> > Please ignore this.
> > The fix is against the caller.

As I said, the previous email is sent due to lack of confirmation.
So you needn't reply the previous message.

Thanks
-Lv

> >
> > Thanks and best regards
> > -Lv
> >
> >> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Zheng, Lv
> >> Sent: Friday, October 09, 2015 10:02 AM
> >>
> >> Why don't you fix this in the invoker side?
> >> For example:
> >> If (acpi_get_handle())
> >> 	acpi_evaluate_object()
> =

> That seems like a sloppy workaround an actual bug in ACPICA.
> =

> >> So that the AE_NOT_FOUND warning can still be kept for the real troubl=
es?
> =

> The code is warning 100% of the time on something that is optional.
> =

> >> There are really scenarios that such warning is useful for catching bu=
gs.
> >>
> =

> What scenario is possible where this causes a problem?  Issuing an error =
on
> something that is optional is not a good idea.
> =

> P.

--===============9000586200931125719==--

