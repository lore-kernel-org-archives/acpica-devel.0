Content-Type: multipart/mixed; boundary="===============6521659679247877285=="
MIME-Version: 1.0
From: Adam Goode <agoode at google.com>
Subject: Re: [Devel] Correct place to send patches?
Date: Wed, 20 May 2015 12:55:37 -0400
Message-ID: <CAOf41N=Ps3jgrxA7kU-Tu-tca1CsqZ_Wac3GFRGCu5U3ZN9p1g@mail.gmail.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E37D2EE073@ORSMSX112.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6521659679247877285==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

No, I did not see a _REG method defined in the code.


Adam


On Wed, May 20, 2015 at 12:46 PM, Moore, Robert <robert.moore(a)intel.com> =
wrote:
> Does the CMOS operation region have a _REG method?
>
>
>
>
>
> From: Zheng, Lv
> Sent: Tuesday, May 19, 2015 11:03 PM
> To: Zheng, Lv; Moore, Robert; Adam Goode; Lan, Tianyu
> Cc: linux-acpi(a)vger.kernel.org; devel(a)acpica.org
>
>
> Subject: RE: [Devel] Correct place to send patches?
>
>
>
> Since no reply from Tianyu=E2=80=A6
>
> What if we move _INI invocation out of ACPICA, and let OSPM to invoke it.
>
>
>
> Thanks
>
> -Lv
>
>
>
> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Zheng, Lv
> Sent: Thursday, May 14, 2015 8:33 AM
> To: Moore, Robert; Adam Goode; Lan, Tianyu
> Cc: linux-acpi(a)vger.kernel.org; devel(a)acpica.org
> Subject: Re: [Devel] Correct place to send patches?
>
>
>
> You should discuss this in the linux-acpi mailing list where the Linux CM=
OS
> opregion driver is implemented, reviewed, and merged.
>
> Let me Cc Tianyu who is the original author of the CMOS opregion driver.
>
>
>
> Thanks
>
> -Lv
>
>
>
> From: Moore, Robert
> Sent: Wednesday, May 13, 2015 10:25 PM
> To: Adam Goode; Zheng, Lv
> Cc: devel(a)acpica.org
> Subject: RE: [Devel] Correct place to send patches?
>
>
>
> I=E2=80=99ll have to let Lv answer this question.
>
>
>
>
>
> From: Adam Goode [mailto:agoode(a)google.com]
> Sent: Wednesday, May 13, 2015 7:23 AM
> To: Moore, Robert
> Cc: devel(a)acpica.org
> Subject: Re: [Devel] Correct place to send patches?
>
>
>
> The problem is that on new Apple hardware (Macmini7,1 and others), the
> system reads and writes from CMOS in _INI. With no CMOS handler, the
> Thunderbolt device doesn't initialize correctly.
>
>
>
> The current framework in Linux doesn't register the PNP* CMOS devices unt=
il
> after _INI runs. Do you have a suggestion on what to do in this case? Is =
it
> possible to register a device driver before _INI runs?
>
>
>
>
>
> Thanks,
>
>
>
> Adam
>
>
>
>
>
> On Wed, May 13, 2015 at 4:07 PM, Moore, Robert <robert.moore(a)intel.com>
> wrote:
>
> Actually, I had a question about this.
>
>
>
> Given that the CMOS device has a _HID and requires a device driver (there
> can be multiple types of CMOS devices), in ACPICA we decided that we could
> not provide CMOS interfaces.
>
>
>
> What problem does this patch solve, and how will it work in the face of
> different CMOS devices?
>
>
>
> Thanks,
>
> Bob
>
>
>
>
>
> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Adam Goode
> Sent: Wednesday, May 13, 2015 4:53 AM
> To: devel(a)acpica.org
> Subject: [Devel] Correct place to send patches?
>
>
>
> Hi,
>
>
>
> Is this the correct place to send patches for review? I have a patch from=
 a
> few weeks ago
> (https://lists.acpica.org/pipermail/devel/2015-May/000698.html) that I wo=
uld
> like feedback on.
>
>
>
>
>
> Thanks,
>
>
>
> Adam
>
>
>
>

--===============6521659679247877285==--

