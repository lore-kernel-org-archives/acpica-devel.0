Content-Type: multipart/mixed; boundary="===============6626449686399881697=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] acpi: set return value to const char for some
 functions
Date: Fri, 16 Oct 2015 03:37:55 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D980841@ORSMSX112.amr.corp.intel.com>
In-Reply-To: 1444953586.22921.0.camel@perches.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6626449686399881697==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If you don't like the quote, just stick with my first assessment.


> -----Original Message-----
> From: Joe Perches [mailto:joe(a)perches.com]
> Sent: Thursday, October 15, 2015 5:00 PM
> To: Moore, Robert
> Cc: LABBE Corentin; Zheng, Lv; Wysocki, Rafael J; lenb(a)kernel.org; linu=
x-
> acpi(a)vger.kernel.org; devel(a)acpica.org; linux-kernel(a)vger.kernel.or=
g; Box,
> David E
> Subject: Re: [PATCH] acpi: set return value to const char for some
> functions
> =

> On Thu, 2015-10-15 at 19:32 +0000, Moore, Robert wrote:
> > if you started to use "const" for some methods you usually forced to
> > use this in most of your code. But the time spent for maintaining
> > (typing, recompiling when some const is missing, etc.) of
> > const-correctness in code seems greater than for fixing of possible
> > (very rare) problems caused by not using of const-correctness at all
> =

> c is not c++.
> =

> "seems" is a dubious statement.


--===============6626449686399881697==--

