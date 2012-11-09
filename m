Content-Type: multipart/mixed; boundary="===============8626734839829393736=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] ref-counting races?
Date: Fri, 09 Nov 2012 15:42:41 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E346BBFD23@ORSMSX101.amr.corp.intel.com>
In-Reply-To: 509D1628.6060707@FreeBSD.org
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8626734839829393736==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> To make sure that we speak about the same thing - is e.g.
> AcpiUtEvaluateObject always called under that lock?

Yes.


AcpiUtEvaluateObject
    AcpiNsEvaluate
        AcpiExEnterInterpreter ();
            AcpiUtAcquireMutex (ACPI_MTX_INTERPRETER);
        AcpiPsExecuteMethod (Info);


> -----Original Message-----
> From: Andriy Gapon [mailto:avg(a)FreeBSD.org]
> Sent: Friday, November 09, 2012 6:42 AM
> To: Moore, Robert
> Cc: devel(a)acpica.org
> Subject: Re: [Devel] ref-counting races?
> =

> on 09/11/2012 16:28 Moore, Robert said the following:
> > There is a lock around the entire AML interpreter. We do support the
> limited threading model defined by the ACPI spec, but at any given time,
> only one thread is executing the interpreter.
> =

> Bob,
> =

> thank you for the reply.
> To make sure that we speak about the same thing - is e.g.
> AcpiUtEvaluateObject always called under that lock?
> That function and its users have calls to AcpiUtRemoveReference.
> =

> =

> >> -----Original Message-----
> >> From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] On
> >> Behalf Of Andriy Gapon
> >> Sent: Thursday, November 08, 2012 11:34 PM
> >> To: devel(a)acpica.org
> >> Subject: [Devel] ref-counting races?
> >>
> >>
> >> It looks like the reference count manipulations performed in
> >> AcpiUtUpdateRefCount/AcpiUtUpdateObjectReference are not protected by
> >> any lock.
> >>  Although, it is possible that I am missing some implied locking in
> >> the higher levels.
> >>
> >> In particular, I am concerned about access to the ASL elements like
> >> Name(_HID,
> >> 2) via AcpiNsEvaluate -> AcpiExResolveNodeToValue.  In this case
> >> multiple threads can concurrently get or drop references to the value
> object.
> >>
> >> The reason to inquire about this is that over the time several
> >> FreeBSD users has reported some seldom occurring, non-reproducible,
> >> ACPI-related heisen-panics.
> >> Their common element is a trap upon memory access in
> >> AcpiOsAcquireObject(AcpiGbl_OperandCache).  Which, in my opinion,
> >> strongly hints at corruption of AcpiGbl_OperandCache via
> >> double-deallocation of an object.
> >> Which I then connect to the reference counting.
> >>
> >> Some links:
> >> http://lists.freebsd.org/pipermail/freebsd-current/2012-March/032637.
> >> html
> >> http://lists.freebsd.org/pipermail/freebsd-acpi/2012-January/007406.h
> >> tml
> >> http://thread.gmane.org/gmane.os.freebsd.stable/83262/focus=3D83445
> >> https://bugs.dragonflybsd.org/issues/568
> >>
> >>
> >> --
> >> Andriy Gapon
> =

> =

> --
> Andriy Gapon

--===============8626734839829393736==--

