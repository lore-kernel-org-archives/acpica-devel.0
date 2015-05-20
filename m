Content-Type: multipart/mixed; boundary="===============5926732403396855150=="
MIME-Version: 1.0
From: Adam Goode <agoode at google.com>
Subject: Re: [Devel] Correct place to send patches?
Date: Wed, 20 May 2015 13:11:02 -0400
Message-ID: <CAOf41Nm50Y6dz5KA=KJaoQHqMxGHxzH2KCER91GA-AaAg=fAPQ@mail.gmail.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E37D2EE0C7@ORSMSX112.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5926732403396855150==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Yes, it really looks like a bug in the firmware. Still, Windows works
correctly without any special support.

What is the policy for ACPICA in this case where Windows works in a
spec-violating way?


Adam


On Wed, May 20, 2015 at 1:07 PM, Moore, Robert <robert.moore(a)intel.com> w=
rote:
> Then perhaps this is where the machine is violating the ACPI specificatio=
n:
>
>
> 6.5.1 _INI (Init)
>
> The _INI method must only access Operation Regions that have been indicat=
ed to be available as defined by the _REG method.
>
>
>
>
>> -----Original Message-----
>> From: Adam Goode [mailto:agoode(a)google.com]
>> Sent: Wednesday, May 20, 2015 9:56 AM
>> To: Moore, Robert
>> Cc: Zheng, Lv; Lan, Tianyu; linux-acpi(a)vger.kernel.org; devel(a)acpica=
.org
>> Subject: Re: [Devel] Correct place to send patches?
>>
>> No, I did not see a _REG method defined in the code.
>>
>>
>> Adam
>>
>>
>> On Wed, May 20, 2015 at 12:46 PM, Moore, Robert <robert.moore(a)intel.co=
m>
>> wrote:
>> > Does the CMOS operation region have a _REG method?
>> >
>> >
>> >
>> >
>> >
>> > From: Zheng, Lv
>> > Sent: Tuesday, May 19, 2015 11:03 PM
>> > To: Zheng, Lv; Moore, Robert; Adam Goode; Lan, Tianyu
>> > Cc: linux-acpi(a)vger.kernel.org; devel(a)acpica.org
>> >
>> >
>> > Subject: RE: [Devel] Correct place to send patches?
>> >
>> >
>> >
>> > Since no reply from Tianyu=E2=80=A6
>> >
>> > What if we move _INI invocation out of ACPICA, and let OSPM to invoke
>> it.
>> >
>> >
>> >
>> > Thanks
>> >
>> > -Lv
>> >
>> >
>> >
>> > From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Zheng, Lv
>> > Sent: Thursday, May 14, 2015 8:33 AM
>> > To: Moore, Robert; Adam Goode; Lan, Tianyu
>> > Cc: linux-acpi(a)vger.kernel.org; devel(a)acpica.org
>> > Subject: Re: [Devel] Correct place to send patches?
>> >
>> >
>> >
>> > You should discuss this in the linux-acpi mailing list where the Linux
>> > CMOS opregion driver is implemented, reviewed, and merged.
>> >
>> > Let me Cc Tianyu who is the original author of the CMOS opregion drive=
r.
>> >
>> >
>> >
>> > Thanks
>> >
>> > -Lv
>> >
>> >
>> >
>> > From: Moore, Robert
>> > Sent: Wednesday, May 13, 2015 10:25 PM
>> > To: Adam Goode; Zheng, Lv
>> > Cc: devel(a)acpica.org
>> > Subject: RE: [Devel] Correct place to send patches?
>> >
>> >
>> >
>> > I=E2=80=99ll have to let Lv answer this question.
>> >
>> >
>> >
>> >
>> >
>> > From: Adam Goode [mailto:agoode(a)google.com]
>> > Sent: Wednesday, May 13, 2015 7:23 AM
>> > To: Moore, Robert
>> > Cc: devel(a)acpica.org
>> > Subject: Re: [Devel] Correct place to send patches?
>> >
>> >
>> >
>> > The problem is that on new Apple hardware (Macmini7,1 and others), the
>> > system reads and writes from CMOS in _INI. With no CMOS handler, the
>> > Thunderbolt device doesn't initialize correctly.
>> >
>> >
>> >
>> > The current framework in Linux doesn't register the PNP* CMOS devices
>> > until after _INI runs. Do you have a suggestion on what to do in this
>> > case? Is it possible to register a device driver before _INI runs?
>> >
>> >
>> >
>> >
>> >
>> > Thanks,
>> >
>> >
>> >
>> > Adam
>> >
>> >
>> >
>> >
>> >
>> > On Wed, May 13, 2015 at 4:07 PM, Moore, Robert
>> > <robert.moore(a)intel.com>
>> > wrote:
>> >
>> > Actually, I had a question about this.
>> >
>> >
>> >
>> > Given that the CMOS device has a _HID and requires a device driver
>> > (there can be multiple types of CMOS devices), in ACPICA we decided
>> > that we could not provide CMOS interfaces.
>> >
>> >
>> >
>> > What problem does this patch solve, and how will it work in the face
>> > of different CMOS devices?
>> >
>> >
>> >
>> > Thanks,
>> >
>> > Bob
>> >
>> >
>> >
>> >
>> >
>> > From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Adam Goode
>> > Sent: Wednesday, May 13, 2015 4:53 AM
>> > To: devel(a)acpica.org
>> > Subject: [Devel] Correct place to send patches?
>> >
>> >
>> >
>> > Hi,
>> >
>> >
>> >
>> > Is this the correct place to send patches for review? I have a patch
>> > from a few weeks ago
>> > (https://lists.acpica.org/pipermail/devel/2015-May/000698.html) that I
>> > would like feedback on.
>> >
>> >
>> >
>> >
>> >
>> > Thanks,
>> >
>> >
>> >
>> > Adam
>> >
>> >
>> >
>> >

--===============5926732403396855150==--

