Content-Type: multipart/mixed; boundary="===============6795785034505776890=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] ref-counting races?
Date: Tue, 13 Nov 2012 16:50:17 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E346BC06D0@ORSMSX101.amr.corp.intel.com>
In-Reply-To: 509E6CE1.8050706@FreeBSD.org
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6795785034505776890==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Here's what I see in AcpiEvaluateObject:

The incoming method arguments are converted from external format to interna=
l format. During this conversion, new objects are created and the reference=
 counts are set. However, at this time AcpiEvaluateObject has exclusive acc=
ess to these objects, at least until they are handed off to the interpreter=
 (which is locked just before the call to AcpiNsEvaluate.)

I still think that it might be interesting to examine the AcpiGbl_MutexInfo=
 array during add reference and remove reference to see if there is any cas=
e where the reference count functions are called with no lock held.

Bob


> -----Original Message-----
> From: Andriy Gapon [mailto:avg(a)FreeBSD.org]
> Sent: Saturday, November 10, 2012 7:04 AM
> To: Moore, Robert
> Cc: devel(a)acpica.org
> Subject: Re: [Devel] ref-counting races?
> =

> on 09/11/2012 17:59 Andriy Gapon said the following:
> > on 09/11/2012 17:42 Moore, Robert said the following:
> >>> To make sure that we speak about the same thing - is e.g.
> >>> AcpiUtEvaluateObject always called under that lock?
> >>
> >> Yes.
> >>
> >>
> >> AcpiUtEvaluateObject
> >>     AcpiNsEvaluate
> >>         AcpiExEnterInterpreter ();
> >>             AcpiUtAcquireMutex (ACPI_MTX_INTERPRETER);
> >>         AcpiPsExecuteMethod (Info);
> >>
> >
> > This is not exactly what I meant.  ACPI_MTX_INTERPRETER does not cover
> > the calls to AcpiUtRemoveReference that can be made in
> > AcpiUtEvaluateObject or in AcpiUtExecute_HID or in
> AcpiUtEvaluateNumericObject, etc.
> > There could be other places in the code where AcpiUtRemoveReference or
> > AcpiUtAddReference are called without any lock serializing the access
> > to a reference counter.
> >
> =

> Just in case, AcpiEvaluateObject->AcpiNsResolveReferences seems to be an
> example of a place where AcpiUtAddReference is called without
> ACPI_MTX_INTERPRETER serialization.
> --
> Andriy Gapon

--===============6795785034505776890==--

