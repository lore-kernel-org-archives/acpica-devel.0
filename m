Content-Type: multipart/mixed; boundary="===============1070804263007323537=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: AcpiGetSleepTypeData: Failure to find
 \_Sx should not result in a loud warning
Date: Wed, 07 Oct 2015 15:52:44 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D362FF7@ORSMSX112.amr.corp.intel.com>
In-Reply-To: 56153A35.4090705@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1070804263007323537==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It would be easy to remove (or partially remove) the warning. Hopefully the=
 calling code will handle AE_NOT_FOUND correctly. =


> -----Original Message-----
> From: Prarit Bhargava [mailto:prarit(a)redhat.com]
> Sent: Wednesday, October 07, 2015 8:29 AM
> To: Wysocki, Rafael J; Moore, Robert; devel(a)acpica.org
> Cc: Zheng, Lv; Len Brown; linux-acpi(a)vger.kernel.org; Box, David E
> Subject: Re: [PATCH] ACPICA: AcpiGetSleepTypeData: Failure to find \_Sx
> should not result in a loud warning
> =

> =

> =

> On 10/01/2015 06:28 PM, Rafael J. Wysocki wrote:
> > On 10/1/2015 7:57 PM, Moore, Robert wrote:
> >> I seem to remember that this came up a long time ago.
> >>
> >> Perhaps someone else will remember.
> >>
> >
> > I can't recall, sorry.
> =

> FWIW, a google search on these warnings yields tonnes of comments about
> them, but with no resolution AFAICT.
> =

> P.

--===============1070804263007323537==--

