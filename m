Content-Type: multipart/mixed; boundary="===============8325101468962406116=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] GPE blocks in reduced hardware mode
Date: Wed, 04 Dec 2013 00:18:58 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37C7A5FD1@ORSMSX103.amr.corp.intel.com>
In-Reply-To: 529E5D5F.0@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8325101468962406116==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The first thing is that there are no GPE block devices in the field, never =
have been. I don't think ACPICA actually supports them fully. It is a bit o=
f an "orphan" feature of ACPI.

I'll have to take a look closer at the spec for an exact reference, but bas=
ically one of the things that ACPI_REDUCED_HARDWARE means is no GPEs, IIRC.

> -----Original Message-----
> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Al Stone
> Sent: Tuesday, December 03, 2013 2:38 PM
> To: devel(a)acpica.org
> Subject: [Devel] GPE blocks in reduced hardware mode
> =

> Howdy.
> =

> I've been trying to do some clean-up on the Linux ACPI driver with regard
> to the reduced hardware profile introduced in ACPI 5.0.
> =

> In thinking about GPE block devices, I was looking through the functions
> in source/components/events/evxfgpe.c and noticed that they are all
> #ifdef'd out for ACPI_REDUCED_HARDWARE.  When I look back through the
> specification, however, I cannot find any place where they are prohibited.
> =

> Clearly, the gpe0/1 blocks in the FADT are not to be used; this is
> explicitly stated in section 5.2.9 of the spec.  Could someone please
> point me to a similar statement for a GPE block device?  I just cannot
> seem to find it.
> =

> The closest thing I can find is section 9.10 implying that a GPE block
> device is an extension of the gpe0/1 blocks from the FADT, but there is no
> explicit statement there so it is ambiguous to me.
> =

> Thanks in advance for any pointers; I'm just puzzled at this point and
> trying to understand how the conclusion came to be.
> =

> --
> ciao,
> al
> -----------------------------------
> Al Stone
> Software Engineer
> Red Hat, Inc.
> ahs3(a)redhat.com
> -----------------------------------
> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> https://lists.acpica.org/mailman/listinfo/devel

--===============8325101468962406116==--

