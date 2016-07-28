Content-Type: multipart/mixed; boundary="===============7231357593618928818=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] AcpiOsAllocate with zero argument
Date: Thu, 28 Jul 2016 05:29:29 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BC07BF4@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 5798E721.9010306@assembler.cz
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7231357593618928818==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, Rudolf

> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Rudolf Marek
> Subject: [Devel] AcpiOsAllocate with zero argument
> =

> Hi all,
> =

> I could not find in the "ACPICA Overview and Programmer Reference" any
> clues
> what to do if someone calls AcpiOsAllocate() with size of zero. I checked
> the
> Linux implementation and it just calls kmalloc() which after bit of googl=
ing
> seems to return non-NULL for this case. I also tried to walk through the
> ACPICA
> sources and it seems to me that at least on some places it looks like tha=
t it
> could be called with 0 (num_gpe * sizeof(something))
> I also tried to look to the "osdeps" of what the UEFI or unix stub do, but
> they
> simply pass it on. I could not find what UEFI does with zero, I only know
> that malloc can either return NULL (and success) or return also non-null
> pointer.
> =

> What is the correct way to handle the zero size allocations? Return non-
> NULL ?
[Lv Zheng] =

IMO, there is no strict rule against the returning value of AcpiOsAllocate(=
).
But there is an implied rule against AcpiOsFree() (IMO, should be documente=
d in ACPICA reference manual).
That is:
If NULL is passed to AcpiOsFree(), program crash shouldn't be resulted.
For AcpiOsFree() implemented for UEFI, BS->FreePool() returns EFI_INVALID_P=
ARAMETER.
So it is compliant to this rule.

However, if you can see practical issues around these 2 functions, please l=
et us know.
We should fix all kinds of such issues.

Thanks
Lv

--===============7231357593618928818==--

