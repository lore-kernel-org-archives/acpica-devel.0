Content-Type: multipart/mixed; boundary="===============4388311676153975781=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [RFC PATCH v3 3/3] acpi: apei: Warn when GHES marks
 correctable errors as "fatal"
Date: Fri, 27 Apr 2018 16:25:50 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B75CE9B1@ORSMSX110.amr.corp.intel.com>
In-Reply-To: e58482cf-37f6-808b-4382-fcf24c6f8db8@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4388311676153975781==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Alex G. [mailto:mr.nuke.me(a)gmail.com]
> Sent: Thursday, April 26, 2018 10:48 AM
> To: Borislav Petkov <bp(a)alien8.de>
> Cc: linux-acpi(a)vger.kernel.org; linux-edac(a)vger.kernel.org; Rafael J.
> Wysocki <rjw(a)rjwysocki.net>; Len Brown <lenb(a)kernel.org>; Luck, Tony
> <tony.luck(a)intel.com>; Mauro Carvalho Chehab <mchehab(a)kernel.org>;
> Moore, Robert <robert.moore(a)intel.com>; Schmauss, Erik
> <erik.schmauss(a)intel.com>; Tyler Baicar <tbaicar(a)codeaurora.org>; Will
> Deacon <will.deacon(a)arm.com>; James Morse <james.morse(a)arm.com>; Shiju
> Jose <shiju.jose(a)huawei.com>; Jonathan (Zhixiong) Zhang
> <zjzhang(a)codeaurora.org>; Dongjiu Geng <gengdongjiu(a)huawei.com>; linu=
x-
> kernel(a)vger.kernel.org; devel(a)acpica.org
> Subject: Re: [RFC PATCH v3 3/3] acpi: apei: Warn when GHES marks
> correctable errors as "fatal"
> =

> On 04/26/2018 06:20 AM, Borislav Petkov wrote:
> > Pasting the same comment from last time since you missed it:
> >
> > "No, I don't want any of that crap issuing stuff in dmesg and then
> > people opening bugs and running around and trying to replace hardware.
> >
> > We either can handle the error and log a normal record somewhere


Usually nobody looks at these, it seems to me. On windows, ACPI errors just=
 go into the bit bucket.

 or we
> > cannot and explode.


This of course would be more windows behavior.


> > The complaining about the FW doesn't bring shit."


We seem to get down to more of a philosophical problem. Basically, just ign=
ore errors or report them somewhere where they will be actually seen. Or, j=
ust crash.



> =

> " Borislav, if you don't like the third patch in the series, feel free
> to leave it out. THings will work beautifully with or without it."
> =

> :)

--===============4388311676153975781==--

