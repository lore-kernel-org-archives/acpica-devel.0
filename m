Content-Type: multipart/mixed; boundary="===============7652795391731832858=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [RFC PATCH] acpi: Use a more normal logging style for
 ACPI_<LEVEL> calls
Date: Tue, 29 Mar 2016 17:50:00 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E4554A9@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 1459270591.25110.83.camel@perches.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7652795391731832858==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Joe Perches [mailto:joe(a)perches.com]
> Sent: Tuesday, March 29, 2016 9:57 AM
> To: Moore, Robert; Zheng, Lv; Wysocki, Rafael J; Len Brown
> Cc: linux-acpi(a)vger.kernel.org; linux-kernel; devel(a)acpica.org
> Subject: Re: [RFC PATCH] acpi: Use a more normal logging style for
> ACPI_<LEVEL> calls
> =

> On Tue, 2016-03-29 at 15:34 +0000, Moore, Robert wrote:
> > On the other hand, we removed AE_INFO from ACPI_INFO a while back, and
> > this may remove the necessity for the double parens.
> =

> Hmm, maybe not. =C2=A0It may be that MSVC's support for __VA_ARGS__ is a =
bit
> unusual. =C2=A0What's the minimum ACPICA msvc version required?

6 I think.

The AE_INFO automatically injects the module name, line number, etc.

Compatibility across compilers is a major requirement for us.





--===============7652795391731832858==--

