Content-Type: multipart/mixed; boundary="===============2394475407099097021=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: AcpiGetSleepTypeData: Failure to find
 \_Sx should not result in a loud warning
Date: Wed, 07 Oct 2015 16:27:44 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D36303A@ORSMSX112.amr.corp.intel.com>
In-Reply-To: 561540E7.30809@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2394475407099097021==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I'm thinking that AE_NOT_FOUND should not generate a warning, but any other=
 exception should.


> -----Original Message-----
> From: Prarit Bhargava [mailto:prarit(a)redhat.com]
> Sent: Wednesday, October 07, 2015 8:57 AM
> To: Moore, Robert; Wysocki, Rafael J; devel(a)acpica.org
> Cc: Zheng, Lv; Len Brown; linux-acpi(a)vger.kernel.org; Box, David E
> Subject: Re: [PATCH] ACPICA: AcpiGetSleepTypeData: Failure to find \_Sx
> should not result in a loud warning
> =

> =

> =

> On 10/07/2015 11:52 AM, Moore, Robert wrote:
> > It would be easy to remove (or partially remove) the warning. Hopefully
> the calling code will handle AE_NOT_FOUND correctly.
> >
> =

> In the specific case of the \_Sx sleep states the code does handle the
> AE_NOT_FOUND correctly.  The issue is solely the warning being displayed
> when there should be no warning.
> =

> P.

--===============2394475407099097021==--

