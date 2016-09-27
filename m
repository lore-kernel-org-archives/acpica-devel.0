Content-Type: multipart/mixed; boundary="===============1196518242244288725=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] Turning iasl's "-oe" option into a documented,
 regular option?
Date: Tue, 27 Sep 2016 01:56:34 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E5037B3@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 42608e7f-e6ba-310e-373e-f9e4711bc355@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1196518242244288725==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Laszlo Ersek [mailto:lersek(a)redhat.com]
> Sent: Monday, September 26, 2016 3:11 PM
> To: Moore, Robert
> Cc: devel(a)acpica.org; Michael Tsirkin; Box, David E
> Subject: Re: Turning iasl's "-oe" option into a documented, regular
> option?
> =

> On 09/26/16 23:34, Moore, Robert wrote:
> >
> >
> >> -----Original Message-----
> >> From: Laszlo Ersek [mailto:lersek(a)redhat.com]
> >> Sent: Monday, September 26, 2016 2:23 PM
> >> To: Moore, Robert <robert.moore(a)intel.com>
> >> Cc: devel(a)acpica.org; Michael Tsirkin <mtsirkin(a)redhat.com>
> >> Subject: Turning iasl's "-oe" option into a documented, regular option?
> >>
> >> Hi,
> >>
> >> the addition of the External() opcode (i.e., 0x15), from ACPI v6.0,
> >> causes iASL to generate AML that breaks old versions of ACPICA's AML
> >> interpreter that are shipped with old (but still variably supported)
> >> Linux distributions, for example, RHEL-5.11. The breakage happens
> >> despite the If(0) conditional that surrounds the opcode and is
> >> supposed to hide it.


Please explain further. The design of the External opcode was specifically =
chosen as to not break existing interpreters.




> >>
> >> I found ACPICA commit
> >>
> >> commit 69620304a02d5a14d1fd0040aeb2e32bd1d7023e
> >> Author: Robert Moore <Robert.Moore(a)intel.com>
> >> Date:   Fri Feb 26 08:55:38 2016 -0800
> >>
> >>     iASL: Add debug option for External opcode
> >>
> >>     option to temporarily disable the opcode for debug purposes
> >>     only.
> >>
> >> which adds the "-oe" option, but -- on purpose -- does not document it.
> >>
> >> Is there any intention to turn this option into a regular, long-term,
> >> documented option?
> >>
> > [Moore, Robert]
> >
> > No, this is a temporary flag for debugging any issues. But the external
> opcode support is stable, and we plan to remove the option.
> =

> Thank you for the quick response!
> Laszlo
> =

> >> For reference, please see
> >> <https://bugzilla.redhat.com/show_bug.cgi?id=3D1377087>.
> >>
> >> Thanks
> >> Laszlo


--===============1196518242244288725==--

