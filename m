Content-Type: multipart/mixed; boundary="===============3218460830175647829=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH v2] acpi: Use kstrtoul() instead of
 strtoul()/simple_strtoul()
Date: Wed, 29 Jul 2015 19:33:37 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D3294E8@ORSMSX112.amr.corp.intel.com>
In-Reply-To: 55B91DAF.3060605@roeck-us.net
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3218460830175647829==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Guenter Roeck [mailto:linux(a)roeck-us.net]
> Sent: Wednesday, July 29, 2015 11:39 AM
> To: Moore, Robert; rjw(a)rjwysocki.net
> Cc: lenb(a)kernel.org; Zheng, Lv; linux-acpi(a)vger.kernel.org; linux-
> kernel(a)vger.kernel.org; devel(a)acpica.org
> Subject: Re: [PATCH v2] acpi: Use kstrtoul() instead of
> strtoul()/simple_strtoul()
> =

> On 07/29/2015 10:51 AM, Moore, Robert wrote:
> >
> >
> >> -----Original Message-----
> >> From: Guenter Roeck [mailto:linux(a)roeck-us.net]
> >> Sent: Monday, July 27, 2015 5:32 PM
> >> To: rjw(a)rjwysocki.net
> >> Cc: lenb(a)kernel.org; Moore, Robert; Zheng, Lv;
> >> linux-acpi(a)vger.kernel.org; linux-kernel(a)vger.kernel.org;
> >> devel(a)acpica.org; Guenter Roeck
> >> Subject: [PATCH v2] acpi: Use kstrtoul() instead of
> >> strtoul()/simple_strtoul()
> >>
> >> simple_strtoul() is deprecated; replace with kstrtoul() and
> kstrtouint().
> >
> > The ACPICA code is os-independent and cannot use these functions (at
> least not directly).
> >
> >
> Odd argument, given that kstrtoul() is used already in the acpi code.

They are not in the os-independent ACPICA code. The ACPI-related drivers ar=
e another story, since they are OS-dendent.




> =

> Guenter


--===============3218460830175647829==--

