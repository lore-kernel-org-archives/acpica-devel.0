Content-Type: multipart/mixed; boundary="===============0424366384847342555=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] ref-counting races?
Date: Wed, 21 Nov 2012 15:18:36 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E346BDDCF3@ORSMSX101.amr.corp.intel.com>
In-Reply-To: 50AC0D88.5070709@FreeBSD.org
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0424366384847342555==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Andriy Gapon [mailto:avg(a)FreeBSD.org]
> Sent: Tuesday, November 20, 2012 3:09 PM
> To: Moore, Robert
> Cc: devel(a)acpica.org; Zheng, Lv
> Subject: Re: [Devel] ref-counting races?
> =

> on 13/11/2012 18:50 Moore, Robert said the following:
> > I still think that it might be interesting to examine the
> > AcpiGbl_MutexInfo array during add reference and remove reference to
> > see if there is any case where the reference count functions are called
> with no lock held.
> =

> I still haven't got around to implementing this useful debugging
> technique.
> =

> Meanwhile we've got another FreeBSD report which appears to be related:
> http://article.gmane.org/gmane.os.freebsd.devel.acpi/7562
> =

> Two new notes.
> =

> Could these issues be caused by FreeBSD using multiple threads to handle
> ACPI
> Notify-s?   So that some Notify-s may get processed in parallel and thus
> cause
> some parallel access to ACPICA and AML.
> =



I don't know of any issues concerning multiple threads with multiple notifi=
es.



> AcpiUtUpdateRefCount handling of REF_DECREMENT && Count < 1 looks
> worrying.
> Not sure if that ever happens in practice, but since the code exists...
> The case is being treated as a minor event (judging from the debugging
> print), but we are already lucky if we see Count =3D=3D 0 there instead of
> some garbage or just plain crashing because the memory is already freed.
> Nevertheless we discard even that luck by happily continuing into
> potentially a repeated call to AcpiUtDeleteInternalObj.
> =

> --
> Andriy Gapon

This code appears in order to essentially catch a case where an attempt is =
made to delete an object twice. Admittedly, it doesn't serve much purpose t=
hese days and should probably be removed. In practice, we never, ever hit t=
he (Count < 1) case that I know of. In other words, I don't know of any cas=
es where the acpica code ever attempts to delete an object twice.




--===============0424366384847342555==--

