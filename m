Content-Type: multipart/mixed; boundary="===============7744925021624060988=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: acpidump -- provide initial
 implementation for Linux
Date: Wed, 05 Jun 2013 00:56:08 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E36FE7A3FD@ORSMSX103.amr.corp.intel.com>
In-Reply-To: 51ABA542.3020907@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7744925021624060988==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] On B=
ehalf
> Of Al Stone
> Sent: Sunday, June 02, 2013 1:04 PM
> To: devel(a)acpica.org
> Subject: Re: [Devel] [PATCH] ACPICA: acpidump -- provide initial
> implementation for Linux
> =

> On 05/31/2013 10:22 PM, Al Stone wrote:
> > On 05/31/2013 06:46 PM, Moore, Robert wrote:
> >> Al,
> >>
> >> We've just completed and checked in a full implementation for Linux.
> >>
> >> You might want to inspect the code and see if there is anything that
> >> can be or should be merged. The code is at (or near) the head of our
> >> git tree.
> >>
> >> Thanks,
> >> Bob
> >
> > Ah, interesting; I did a pull this afternoon and had not seen any such
> > changes.  I'll take a look and see what can be merged.
> =

> After looking at the two patches, there's not much that they share in
> common; I don't think there's anything that would make sense to merge --
> the approaches are very different.
> =

> I do have a couple of concerns with the implementation,
> though:
> =

> 1) While mmap() of /dev/mem makes sense, I suspect there
>     are cases where one can attempt to mmap() the wrong
>     address and lock up the system.  I have not seen a good
>     way to avoid this just yet without a priori being able
>     to establish the proper physical addresses for the tables
>     but that may require a kernel patch to provide the addresses
>     via /sys.  At a minimum, we should warn folks that this
>     could happen.  This was the only reason I did not include
>     an implementation of AcpiOsGetTableByAddress().
> =

> 2) I've seen at least a few systems with more than one UEFI
>     table instance.  Whether allowed or not, it looks like
>     the acpidump code will only allow this for SSDTs.
> =


If you find such a system, we would like to see the acpidump.
Thanks,
Bob





> Thanks for checking the code in.  Now that I know an acpidump will be
> there, I can fix up the distro packages to handle this new version of the
> command properly, too.
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

--===============7744925021624060988==--

