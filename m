Content-Type: multipart/mixed; boundary="===============6746778389048444867=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH v2 1/3] ACPI: Resolve objects on host-directed
 table loads
Date: Fri, 14 Jun 2019 15:35:36 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B95EFB26@ORSMSX110.amr.corp.intel.com>
In-Reply-To: alpine.DEB.2.20.1906141114490.6579@fox.voss.local
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6746778389048444867==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



-----Original Message-----
From: Nikolaus Voss [mailto:nv(a)vosn.de] =

Sent: Friday, June 14, 2019 2:26 AM
To: Rafael J. Wysocki <rafael(a)kernel.org>
Cc: Rafael J. Wysocki <rjw(a)rjwysocki.net>; Len Brown <lenb(a)kernel.org>;=
 Moore, Robert <robert.moore(a)intel.com>; Schmauss, Erik <erik.schmauss(a)=
intel.com>; Jacek Anaszewski <jacek.anaszewski(a)gmail.com>; Pavel Machek <=
pavel(a)ucw.cz>; Dan Murphy <dmurphy(a)ti.com>; Thierry Reding <thierry.red=
ing(a)gmail.com>; ACPI Devel Maling List <linux-acpi(a)vger.kernel.org>; op=
en list:ACPI COMPONENT ARCHITECTURE (ACPICA) <devel(a)acpica.org>; linux-le=
ds(a)vger.kernel.org; Linux PWM List <linux-pwm(a)vger.kernel.org>; Linux K=
ernel Mailing List <linux-kernel(a)vger.kernel.org>
Subject: Re: [PATCH v2 1/3] ACPI: Resolve objects on host-directed table lo=
ads

Hi Rafael,

On Fri, 14 Jun 2019, Rafael J. Wysocki wrote:
> On Wed, Jun 12, 2019 at 10:36 AM Nikolaus Voss =

> <nikolaus.voss(a)loewensteinmedical.de> wrote:
>>
>> If an ACPI SSDT overlay is loaded after built-in tables have been =

>> loaded e.g. via configfs or efivar_ssdt_load() it is necessary to =

>> rewalk the namespace to resolve references. Without this, relative =

>> and absolute paths like ^PCI0.SBUS or \_SB.PCI0.SBUS are not resolved =

>> correctly.
>>
>> Make configfs load use the same method as efivar_ssdt_load().
>>
>> Signed-off-by: Nikolaus Voss <nikolaus.voss(a)loewensteinmedical.de>
>
> This is fine by me, so
>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki(a)intel.com>
>
> Or if you want me to take this patch (without the other two in the =

> series), please let me know.

thanks. I think it would be the best if you take up this patch as it is an =
independent topic. In retrospect it wasn't a good idea to put it into this =
series.

Kind regards,
Niko

I would have to ask, why is additional code needed for package initializati=
on/resolution? It already happens elsewhere in acpica.
Bob

[...]

--===============6746778389048444867==--

