Content-Type: multipart/mixed; boundary="===============6610177130532263378=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] Re: [PATCH][next] ACPICA: Use fallthrough pseudo-keyword
Date: Wed, 14 Oct 2020 20:48:20 +0000
Message-ID: <BYAPR11MB325695B550880788DBED54DB87050@BYAPR11MB3256.namprd11.prod.outlook.com>
In-Reply-To: ae54364041b99b89f818812d957d4a4bb4efdc25.camel@perches.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6610177130532263378==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I'm afraid that the macro does not compile under MSVC:

warning C4067: unexpected tokens following preprocessor directive - expecte=
d a newline (compiling source file ..\..\source\tools\acpiexec\aetests.c)

 It looks like "__has_attribute" is not supported.

-----Original Message-----
From: Joe Perches <joe(a)perches.com> =

Sent: Monday, July 27, 2020 7:22 PM
To: Gustavo A. R. Silva <gustavo(a)embeddedor.com>; Moore, Robert <robert.m=
oore(a)intel.com>; Rafael J. Wysocki <rafael(a)kernel.org>; Gustavo A. R. S=
ilva <gustavoars(a)kernel.org>
Cc: Kaneda, Erik <erik.kaneda(a)intel.com>; Wysocki, Rafael J <rafael.j.wys=
ocki(a)intel.com>; Len Brown <lenb(a)kernel.org>; ACPI Devel Maling List <l=
inux-acpi(a)vger.kernel.org>; open list:ACPI COMPONENT ARCHITECTURE (ACPICA=
) <devel(a)acpica.org>; Linux Kernel Mailing List <linux-kernel(a)vger.kern=
el.org>
Subject: Re: [PATCH][next] ACPICA: Use fallthrough pseudo-keyword

On Mon, 2020-07-27 at 17:23 -0500, Gustavo A. R. Silva wrote:
> Hi,
> =

> =

> This is a macro pseudo-keyword, which expands to /* fallthrough */ for =

> compilers that don't support the attribute __fallthrough__. See:

Not really.

It expands to
	do {} while (0)
for compilers that do not support the __fallthrough__ attribute.

The /* fallthrough */ after that is for the human reader and is stripped be=
fore compilation.

> include/linux/compiler_attributes.h:213:
> 213 #if __has_attribute(__fallthrough__)
> 214 # define fallthrough                    __attribute__((__fallthrough_=
_))
> 215 #else
> 216 # define fallthrough                    do {} while (0)  /* fallthrou=
gh */
> 217 #endif
> =

> So, any compiler (older or new) will be fine with it.

But old compilers should not emit warnings for these uses.


--===============6610177130532263378==--

