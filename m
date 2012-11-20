Content-Type: multipart/mixed; boundary="===============6466607225279623539=="
MIME-Version: 1.0
From: Andriy Gapon <avg at FreeBSD.org>
Subject: Re: [Devel] ref-counting races?
Date: Wed, 21 Nov 2012 01:08:56 +0200
Message-ID: <50AC0D88.5070709@FreeBSD.org>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E346BC06D0@ORSMSX101.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6466607225279623539==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

on 13/11/2012 18:50 Moore, Robert said the following:
> I still think that it might be interesting to examine the AcpiGbl_MutexIn=
fo
> array during add reference and remove reference to see if there is any ca=
se
> where the reference count functions are called with no lock held.

I still haven't got around to implementing this useful debugging technique.

Meanwhile we've got another FreeBSD report which appears to be related:
http://article.gmane.org/gmane.os.freebsd.devel.acpi/7562

Two new notes.

Could these issues be caused by FreeBSD using multiple threads to handle AC=
PI
Notify-s?   So that some Notify-s may get processed in parallel and thus ca=
use
some parallel access to ACPICA and AML.

AcpiUtUpdateRefCount handling of REF_DECREMENT && Count < 1 looks worrying.
Not sure if that ever happens in practice, but since the code exists...
The case is being treated as a minor event (judging from the debugging prin=
t),
but we are already lucky if we see Count =3D=3D 0 there instead of some gar=
bage or
just plain crashing because the memory is already freed.  Nevertheless we
discard even that luck by happily continuing into potentially a repeated ca=
ll to
AcpiUtDeleteInternalObj.

-- =

Andriy Gapon

--===============6466607225279623539==--

