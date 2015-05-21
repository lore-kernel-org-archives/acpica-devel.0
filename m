Content-Type: multipart/mixed; boundary="===============5998661978539758609=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] Correct place to send patches?
Date: Thu, 21 May 2015 01:32:37 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88027209AB@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E37D2EE3B3@ORSMSX112.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5998661978539758609==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Moore, Robert
> Sent: Thursday, May 21, 2015 8:03 AM
> =

> > From: Adam Goode [mailto:agoode(a)google.com]
> > Sent: Wednesday, May 20, 2015 12:53 PM
> >
> > Interesting point about ACPICA throwing an exception when there is no
> > handler. The spec (6.0) says this:
> > "When an operation region handler is unavailable, AML cannot access data
> > fields in that region. (Operation region writes will be ignored and rea=
ds
> > will return indeterminate data.)."
> >
> > If unavailable reads just returned 0, this code would all work. I have =
no
> > idea when this field would ever be set. I don't know if Windows Install=
er
> > has particular bytes it sets in the CMOS.
> >
> > Perhaps Windows is just returning 0 on read. Why does ACPICA throw an
> > exception?
> =

> =

> The original idea is to tell someone that "you forgot to load a CMOS driv=
er" (or EC driver, etc.)
> =

> I don't really subscribe to any philosophy that has an I/O handler or sim=
ilar doing nothing and returning a status of "yeah, I did it, and it
> worked!"

I also didn't see conflicts between the 2 requirements.
From software architect's point of view, things shouldn't be coupled togeth=
er and the owner of the requirements should be identified.

1. Returning exception for unhandled region accesses - this is an interpret=
er behavior
2. Returning undetermined value for region accesses - this is an OSPM behav=
ior

So what if we just let the OSPMs to override the exception values in the ex=
ception handler?
The AML interpreter could just notify the OSPM in this way: here is an exce=
ption.
And OSPM then can just tell the AML interpreter: I'm fine with it, please i=
gnore.
It's that simple.

Also the OSPM can pass down the exception from top to the bottom in a devic=
e stack and all related bus subsystem and drivers can have chance to vote.
Just like what the Windows IRPs do.

Thanks and best regards
-Lv


> =

> Bob
> =

> =

> =

> =

> =

> >
> >
> >
> > Here is the relevant device and _INI disassembly, with most things elid=
ed.
> > OSDW is a method that determines if the OS is Darwin.
> > \_SB.PCI0.LPCB.RTC.ISWI is the field of interest. I have not elided any=
 of
> > these RTC references. On unpatched ACPICA/Linux (when Darwin mode is
> > disabled), the first Debug =3D \_SB.PCI0.LPCB.RTC.ISWI fails.
> >
> >
> >
> >
> > .....
> >                 Device (RTC)
> >                 {
> >                     Name (_HID, EisaId ("PNP0B00") /* AT Real-Time Clock
> > */)  // _HID: Hardware ID
> >                     Name (_CRS, ResourceTemplate ()  // _CRS: Current
> > Resource Settings
> >                     {
> >                         IO (Decode16,
> >                             0x0070,             // Range Minimum
> >                             0x0070,             // Range Maximum
> >                             0x01,               // Alignment
> >                             0x08,               // Length
> >                             )
> >                     })
> >                     OperationRegion (CMS0, SystemCMOS, 0x00, 0x40)
> >                     Field (CMS0, ByteAcc, NoLock, Preserve)
> >                     {
> >                         Offset (0x38),
> >                         ISTB,   1,
> >                             ,   2,
> >                         ISWI,   1,
> >                         Offset (0x39)
> >                     }
> >                 }
> >
> > .....
> >
> >     Scope (\_SB.PCI0)
> >     {
> >         Method (_INI, 0, NotSerialized)  // _INI: Initialize
> >         {
> > ..... [elided]
> >             Debug =3D \_SB.PCI0.LPCB.RTC.ISWI
> >             If (!OSDW ())
> >             {
> >                 If ((OSYS >=3D 0x07DC))
> >                 {
> >                     Debug =3D "Save Ridge Config on Boot"
> > ..... [thunderbolt init code elided]
> >                     If ((\_SB.PCI0.LPCB.RTC.ISWI !=3D 0x01))
> >                     {
> >                         Debug =3D "Enable ICM on Boot"
> > ..... [more init code elided]
> >                     }
> >                     Else
> >                     {
> >                         Debug =3D "Windows Installation"
> >                     }
> > ..... [more code elided]
> >                     Debug =3D "Enable ICM on Boot, Complete"
> >                 }
> >             }
> >
> > On Wed, May 20, 2015 at 1:24 PM, Moore, Robert <robert.moore(a)intel.co=
m>
> > wrote:
> > > Another possibility is that Windows just *ignores* a CMOS access from
> > the _INI before it gets a real CMOS driver installed. We've seen similar
> > before.
> > >
> > > Could you please post the disassembled _INI method, or the binary DSDT
> > where it came from?
> > > Thanks.
> > >
> > >> -----Original Message-----
> > >> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Moore,
> > >> Robert
> > >> Sent: Wednesday, May 20, 2015 10:17 AM
> > >> To: Adam Goode
> > >> Cc: Lan, Tianyu; linux-acpi(a)vger.kernel.org; Box, David E;
> > >> devel(a)acpica.org
> > >> Subject: Re: [Devel] Correct place to send patches?
> > >>
> > >> ACPICA does in fact try to bug-for-bug compatible with Windows.
> > >>
> > >> The trick is to figure out just *how* Windows works in these cases.
> > >>
> > >> I might guess that a solution may be that a "default handler" for the
> > >> CMOS operation region should be installed immediately at boot time.
> > >> If and when this handler is first run, it should figure out which
> > >> CMOS device is present on the system and then install the "real"
> > handler for the device.
> > >> Or, if you want to support only one CMOS device, just install the
> > >> region handler at boot time and be done with it.
> > >>
> > >>
> > >>
> > >> > -----Original Message-----
> > >> > From: Adam Goode [mailto:agoode(a)google.com]
> > >> > Sent: Wednesday, May 20, 2015 10:11 AM
> > >> > To: Moore, Robert
> > >> > Cc: Zheng, Lv; Lan, Tianyu; linux-acpi(a)vger.kernel.org;
> > >> > devel(a)acpica.org; Box, David E
> > >> > Subject: Re: [Devel] Correct place to send patches?
> > >> >
> > >> > Yes, it really looks like a bug in the firmware. Still, Windows
> > >> > works correctly without any special support.
> > >> >
> > >> > What is the policy for ACPICA in this case where Windows works in a
> > >> > spec- violating way?
> > >> >
> > >> >
> > >> > Adam
> > >> >
> > >> >
> > >> > On Wed, May 20, 2015 at 1:07 PM, Moore, Robert
> > >> > <robert.moore(a)intel.com>
> > >> > wrote:
> > >> > > Then perhaps this is where the machine is violating the ACPI
> > >> > specification:
> > >> > >
> > >> > >
> > >> > > 6.5.1 _INI (Init)
> > >> > >
> > >> > > The _INI method must only access Operation Regions that have been
> > >> > indicated to be available as defined by the _REG method.
> > >> > >
> > >> > >
> > >> > >
> > >> > >
> > >> > >> -----Original Message-----
> > >> > >> From: Adam Goode [mailto:agoode(a)google.com]
> > >> > >> Sent: Wednesday, May 20, 2015 9:56 AM
> > >> > >> To: Moore, Robert
> > >> > >> Cc: Zheng, Lv; Lan, Tianyu; linux-acpi(a)vger.kernel.org;
> > >> > >> devel(a)acpica.org
> > >> > >> Subject: Re: [Devel] Correct place to send patches?
> > >> > >>
> > >> > >> No, I did not see a _REG method defined in the code.
> > >> > >>
> > >> > >>
> > >> > >> Adam
> > >> > >>
> > >> > >>
> > >> > >> On Wed, May 20, 2015 at 12:46 PM, Moore, Robert
> > >> > >> <robert.moore(a)intel.com>
> > >> > >> wrote:
> > >> > >> > Does the CMOS operation region have a _REG method?
> > >> > >> >
> > >> > >> >
> > >> > >> >
> > >> > >> >
> > >> > >> >
> > >> > >> > From: Zheng, Lv
> > >> > >> > Sent: Tuesday, May 19, 2015 11:03 PM
> > >> > >> > To: Zheng, Lv; Moore, Robert; Adam Goode; Lan, Tianyu
> > >> > >> > Cc: linux-acpi(a)vger.kernel.org; devel(a)acpica.org
> > >> > >> >
> > >> > >> >
> > >> > >> > Subject: RE: [Devel] Correct place to send patches?
> > >> > >> >
> > >> > >> >
> > >> > >> >
> > >> > >> > Since no reply from Tianyu=E2=80=A6
> > >> > >> >
> > >> > >> > What if we move _INI invocation out of ACPICA, and let OSPM to
> > >> > >> > invoke
> > >> > >> it.
> > >> > >> >
> > >> > >> >
> > >> > >> >
> > >> > >> > Thanks
> > >> > >> >
> > >> > >> > -Lv
> > >> > >> >
> > >> > >> >
> > >> > >> >
> > >> > >> > From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of
> > >> > >> > Zheng, Lv
> > >> > >> > Sent: Thursday, May 14, 2015 8:33 AM
> > >> > >> > To: Moore, Robert; Adam Goode; Lan, Tianyu
> > >> > >> > Cc: linux-acpi(a)vger.kernel.org; devel(a)acpica.org
> > >> > >> > Subject: Re: [Devel] Correct place to send patches?
> > >> > >> >
> > >> > >> >
> > >> > >> >
> > >> > >> > You should discuss this in the linux-acpi mailing list where
> > >> > >> > the Linux CMOS opregion driver is implemented, reviewed, and
> > merged.
> > >> > >> >
> > >> > >> > Let me Cc Tianyu who is the original author of the CMOS
> > >> > >> > opregion
> > >> > driver.
> > >> > >> >
> > >> > >> >
> > >> > >> >
> > >> > >> > Thanks
> > >> > >> >
> > >> > >> > -Lv
> > >> > >> >
> > >> > >> >
> > >> > >> >
> > >> > >> > From: Moore, Robert
> > >> > >> > Sent: Wednesday, May 13, 2015 10:25 PM
> > >> > >> > To: Adam Goode; Zheng, Lv
> > >> > >> > Cc: devel(a)acpica.org
> > >> > >> > Subject: RE: [Devel] Correct place to send patches?
> > >> > >> >
> > >> > >> >
> > >> > >> >
> > >> > >> > I=E2=80=99ll have to let Lv answer this question.
> > >> > >> >
> > >> > >> >
> > >> > >> >
> > >> > >> >
> > >> > >> >
> > >> > >> > From: Adam Goode [mailto:agoode(a)google.com]
> > >> > >> > Sent: Wednesday, May 13, 2015 7:23 AM
> > >> > >> > To: Moore, Robert
> > >> > >> > Cc: devel(a)acpica.org
> > >> > >> > Subject: Re: [Devel] Correct place to send patches?
> > >> > >> >
> > >> > >> >
> > >> > >> >
> > >> > >> > The problem is that on new Apple hardware (Macmini7,1 and
> > >> > >> > others), the system reads and writes from CMOS in _INI. With
> > >> > >> > no CMOS handler, the Thunderbolt device doesn't initialize
> > correctly.
> > >> > >> >
> > >> > >> >
> > >> > >> >
> > >> > >> > The current framework in Linux doesn't register the PNP* CMOS
> > >> > >> > devices until after _INI runs. Do you have a suggestion on
> > >> > >> > what to do in this case? Is it possible to register a device
> > >> > >> > driver before
> > >> > _INI runs?
> > >> > >> >
> > >> > >> >
> > >> > >> >
> > >> > >> >
> > >> > >> >
> > >> > >> > Thanks,
> > >> > >> >
> > >> > >> >
> > >> > >> >
> > >> > >> > Adam
> > >> > >> >
> > >> > >> >
> > >> > >> >
> > >> > >> >
> > >> > >> >
> > >> > >> > On Wed, May 13, 2015 at 4:07 PM, Moore, Robert
> > >> > >> > <robert.moore(a)intel.com>
> > >> > >> > wrote:
> > >> > >> >
> > >> > >> > Actually, I had a question about this.
> > >> > >> >
> > >> > >> >
> > >> > >> >
> > >> > >> > Given that the CMOS device has a _HID and requires a device
> > >> > >> > driver (there can be multiple types of CMOS devices), in
> > >> > >> > ACPICA we decided that we could not provide CMOS interfaces.
> > >> > >> >
> > >> > >> >
> > >> > >> >
> > >> > >> > What problem does this patch solve, and how will it work in
> > >> > >> > the face of different CMOS devices?
> > >> > >> >
> > >> > >> >
> > >> > >> >
> > >> > >> > Thanks,
> > >> > >> >
> > >> > >> > Bob
> > >> > >> >
> > >> > >> >
> > >> > >> >
> > >> > >> >
> > >> > >> >
> > >> > >> > From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of
> > >> > >> > Adam Goode
> > >> > >> > Sent: Wednesday, May 13, 2015 4:53 AM
> > >> > >> > To: devel(a)acpica.org
> > >> > >> > Subject: [Devel] Correct place to send patches?
> > >> > >> >
> > >> > >> >
> > >> > >> >
> > >> > >> > Hi,
> > >> > >> >
> > >> > >> >
> > >> > >> >
> > >> > >> > Is this the correct place to send patches for review? I have a
> > >> > >> > patch from a few weeks ago
> > >> > >> > (https://lists.acpica.org/pipermail/devel/2015-May/000698.html
> > >> > >> > ) that I would like feedback on.
> > >> > >> >
> > >> > >> >
> > >> > >> >
> > >> > >> >
> > >> > >> >
> > >> > >> > Thanks,
> > >> > >> >
> > >> > >> >
> > >> > >> >
> > >> > >> > Adam
> > >> > >> >
> > >> > >> >
> > >> > >> >
> > >> > >> >
> > >> _______________________________________________
> > >> Devel mailing list
> > >> Devel(a)acpica.org
> > >> https://lists.acpica.org/mailman/listinfo/devel
> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> https://lists.acpica.org/mailman/listinfo/devel

--===============5998661978539758609==--

