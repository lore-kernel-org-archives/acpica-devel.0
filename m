Content-Type: multipart/mixed; boundary="===============5935315609846010417=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] Turning iasl's "-oe" option into a documented,
 regular option?
Date: Mon, 26 Sep 2016 21:34:22 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E503478@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 2217ad77-18d3-710b-7a6c-be1bee15feb7@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5935315609846010417==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Laszlo Ersek [mailto:lersek(a)redhat.com]
> Sent: Monday, September 26, 2016 2:23 PM
> To: Moore, Robert <robert.moore(a)intel.com>
> Cc: devel(a)acpica.org; Michael Tsirkin <mtsirkin(a)redhat.com>
> Subject: Turning iasl's "-oe" option into a documented, regular option?
> =

> Hi,
> =

> the addition of the External() opcode (i.e., 0x15), from ACPI v6.0,
> causes iASL to generate AML that breaks old versions of ACPICA's AML
> interpreter that are shipped with old (but still variably supported)
> Linux distributions, for example, RHEL-5.11. The breakage happens
> despite the If(0) conditional that surrounds the opcode and is supposed
> to hide it.
> =

> I found ACPICA commit
> =

> commit 69620304a02d5a14d1fd0040aeb2e32bd1d7023e
> Author: Robert Moore <Robert.Moore(a)intel.com>
> Date:   Fri Feb 26 08:55:38 2016 -0800
> =

>     iASL: Add debug option for External opcode
> =

>     option to temporarily disable the opcode for debug purposes
>     only.
> =

> which adds the "-oe" option, but -- on purpose -- does not document it.
> =

> Is there any intention to turn this option into a regular, long-term,
> documented option?
> =

[Moore, Robert] =


No, this is a temporary flag for debugging any issues. But the external opc=
ode support is stable, and we plan to remove the option.



> For reference, please see
> <https://bugzilla.redhat.com/show_bug.cgi?id=3D1377087>.
> =

> Thanks
> Laszlo

--===============5935315609846010417==--

