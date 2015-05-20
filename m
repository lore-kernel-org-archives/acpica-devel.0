Content-Type: multipart/mixed; boundary="===============8842336363632643431=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] Correct place to send patches?
Date: Wed, 20 May 2015 17:17:18 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D2EE0FF@ORSMSX112.amr.corp.intel.com>
In-Reply-To: CAOf41Nm50Y6dz5KA=KJaoQHqMxGHxzH2KCER91GA-AaAg=fAPQ@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8842336363632643431==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

ACPICA does in fact try to bug-for-bug compatible with Windows.

The trick is to figure out just *how* Windows works in these cases.

I might guess that a solution may be that a "default handler" for the CMOS =
operation region should be installed immediately at boot time. If and when =
this handler is first run, it should figure out which CMOS device is presen=
t on the system and then install the "real" handler for the device. Or, if =
you want to support only one CMOS device, just install the region handler a=
t boot time and be done with it.



> -----Original Message-----
> From: Adam Goode [mailto:agoode(a)google.com]
> Sent: Wednesday, May 20, 2015 10:11 AM
> To: Moore, Robert
> Cc: Zheng, Lv; Lan, Tianyu; linux-acpi(a)vger.kernel.org; devel(a)acpica.=
org;
> Box, David E
> Subject: Re: [Devel] Correct place to send patches?
> =

> Yes, it really looks like a bug in the firmware. Still, Windows works
> correctly without any special support.
> =

> What is the policy for ACPICA in this case where Windows works in a spec-
> violating way?
> =

> =

> Adam
> =

> =

> On Wed, May 20, 2015 at 1:07 PM, Moore, Robert <robert.moore(a)intel.com>
> wrote:
> > Then perhaps this is where the machine is violating the ACPI
> specification:
> >
> >
> > 6.5.1 _INI (Init)
> >
> > The _INI method must only access Operation Regions that have been
> indicated to be available as defined by the _REG method.
> >
> >
> >
> >
> >> -----Original Message-----
> >> From: Adam Goode [mailto:agoode(a)google.com]
> >> Sent: Wednesday, May 20, 2015 9:56 AM
> >> To: Moore, Robert
> >> Cc: Zheng, Lv; Lan, Tianyu; linux-acpi(a)vger.kernel.org;
> >> devel(a)acpica.org
> >> Subject: Re: [Devel] Correct place to send patches?
> >>
> >> No, I did not see a _REG method defined in the code.
> >>
> >>
> >> Adam
> >>
> >>
> >> On Wed, May 20, 2015 at 12:46 PM, Moore, Robert
> >> <robert.moore(a)intel.com>
> >> wrote:
> >> > Does the CMOS operation region have a _REG method?
> >> >
> >> >
> >> >
> >> >
> >> >
> >> > From: Zheng, Lv
> >> > Sent: Tuesday, May 19, 2015 11:03 PM
> >> > To: Zheng, Lv; Moore, Robert; Adam Goode; Lan, Tianyu
> >> > Cc: linux-acpi(a)vger.kernel.org; devel(a)acpica.org
> >> >
> >> >
> >> > Subject: RE: [Devel] Correct place to send patches?
> >> >
> >> >
> >> >
> >> > Since no reply from Tianyu=E2=80=A6
> >> >
> >> > What if we move _INI invocation out of ACPICA, and let OSPM to
> >> > invoke
> >> it.
> >> >
> >> >
> >> >
> >> > Thanks
> >> >
> >> > -Lv
> >> >
> >> >
> >> >
> >> > From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Zheng,
> >> > Lv
> >> > Sent: Thursday, May 14, 2015 8:33 AM
> >> > To: Moore, Robert; Adam Goode; Lan, Tianyu
> >> > Cc: linux-acpi(a)vger.kernel.org; devel(a)acpica.org
> >> > Subject: Re: [Devel] Correct place to send patches?
> >> >
> >> >
> >> >
> >> > You should discuss this in the linux-acpi mailing list where the
> >> > Linux CMOS opregion driver is implemented, reviewed, and merged.
> >> >
> >> > Let me Cc Tianyu who is the original author of the CMOS opregion
> driver.
> >> >
> >> >
> >> >
> >> > Thanks
> >> >
> >> > -Lv
> >> >
> >> >
> >> >
> >> > From: Moore, Robert
> >> > Sent: Wednesday, May 13, 2015 10:25 PM
> >> > To: Adam Goode; Zheng, Lv
> >> > Cc: devel(a)acpica.org
> >> > Subject: RE: [Devel] Correct place to send patches?
> >> >
> >> >
> >> >
> >> > I=E2=80=99ll have to let Lv answer this question.
> >> >
> >> >
> >> >
> >> >
> >> >
> >> > From: Adam Goode [mailto:agoode(a)google.com]
> >> > Sent: Wednesday, May 13, 2015 7:23 AM
> >> > To: Moore, Robert
> >> > Cc: devel(a)acpica.org
> >> > Subject: Re: [Devel] Correct place to send patches?
> >> >
> >> >
> >> >
> >> > The problem is that on new Apple hardware (Macmini7,1 and others),
> >> > the system reads and writes from CMOS in _INI. With no CMOS
> >> > handler, the Thunderbolt device doesn't initialize correctly.
> >> >
> >> >
> >> >
> >> > The current framework in Linux doesn't register the PNP* CMOS
> >> > devices until after _INI runs. Do you have a suggestion on what to
> >> > do in this case? Is it possible to register a device driver before
> _INI runs?
> >> >
> >> >
> >> >
> >> >
> >> >
> >> > Thanks,
> >> >
> >> >
> >> >
> >> > Adam
> >> >
> >> >
> >> >
> >> >
> >> >
> >> > On Wed, May 13, 2015 at 4:07 PM, Moore, Robert
> >> > <robert.moore(a)intel.com>
> >> > wrote:
> >> >
> >> > Actually, I had a question about this.
> >> >
> >> >
> >> >
> >> > Given that the CMOS device has a _HID and requires a device driver
> >> > (there can be multiple types of CMOS devices), in ACPICA we decided
> >> > that we could not provide CMOS interfaces.
> >> >
> >> >
> >> >
> >> > What problem does this patch solve, and how will it work in the
> >> > face of different CMOS devices?
> >> >
> >> >
> >> >
> >> > Thanks,
> >> >
> >> > Bob
> >> >
> >> >
> >> >
> >> >
> >> >
> >> > From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Adam
> >> > Goode
> >> > Sent: Wednesday, May 13, 2015 4:53 AM
> >> > To: devel(a)acpica.org
> >> > Subject: [Devel] Correct place to send patches?
> >> >
> >> >
> >> >
> >> > Hi,
> >> >
> >> >
> >> >
> >> > Is this the correct place to send patches for review? I have a
> >> > patch from a few weeks ago
> >> > (https://lists.acpica.org/pipermail/devel/2015-May/000698.html)
> >> > that I would like feedback on.
> >> >
> >> >
> >> >
> >> >
> >> >
> >> > Thanks,
> >> >
> >> >
> >> >
> >> > Adam
> >> >
> >> >
> >> >
> >> >

--===============8842336363632643431==--

