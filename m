Content-Type: multipart/mixed; boundary="===============5784363982100800954=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: Avoid return Access Size error with PCC
 Register
Date: Wed, 05 Oct 2016 14:10:51 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E50515D@ORSMSX110.amr.corp.intel.com>
In-Reply-To: CAFHUOYzpdBuEFY32psHyncWAd1=Sn1XL+Yx808RNECZZLrHuFw@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5784363982100800954==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This looks OK. We'll integrate it for the next release of ACPICA later this=
 month. I'll commit it today.
Thanks,
Bob


> -----Original Message-----
> From: Hoan Tran [mailto:hotran(a)apm.com]
> Sent: Monday, October 3, 2016 1:39 PM
> To: Moore, Robert <robert.moore(a)intel.com>; devel(a)acpica.org
> Cc: Loc Ho <lho(a)apm.com>; Hoan Tran <hotran(a)apm.com>
> Subject: Re: [PATCH] ACPICA: Avoid return Access Size error with PCC
> Register
> =

> Correct devel acpica email (devel(a)acpica.org)
> =

> Thanks
> Hoan
> =

> On Mon, Oct 3, 2016 at 10:59 AM, Hoan Tran <hotran(a)apm.com> wrote:
> > Based on section "14.5 Referencing the PCC address space" of ACPI
> > 6.1 specification, an individual register may be referenced in a
> > Generic Register Descriptor by using the Address Space ID PCC (0xA).
> > When using the PCC address space, the Access Size field is redefined
> > to PCC Subspace ID.
> >
> > This patch avoids iasl return Access Size error with PCC register when
> > its value is over 4.
> >
> > Signed-off-by: Hoan Tran <hotran(a)apm.com>
> > ---
> >  source/compiler/aslrestype2.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/source/compiler/aslrestype2.c
> > b/source/compiler/aslrestype2.c index 9fc77b0..cbec1b3 100644
> > --- a/source/compiler/aslrestype2.c
> > +++ b/source/compiler/aslrestype2.c
> > @@ -199,6 +199,11 @@ RsDoGeneralRegisterDescriptor (
> >              RsCreateByteField (InitializerOp, ACPI_RESTAG_ACCESSSIZE,
> >                  CurrentByteOffset + ASL_RESDESC_OFFSET
> > (GenericReg.AccessSize));
> >
> > +            if (Descriptor->GenericReg.AddressSpaceId =3D=3D
> ACPI_ADR_SPACE_PLATFORM_COMM)
> > +            {
> > +                break;
> > +            }
> > +
> >              if (Descriptor->GenericReg.AccessSize >
> AML_FIELD_ACCESS_QWORD)
> >              {
> >                  AslError (ASL_ERROR, ASL_MSG_INVALID_ACCESS_SIZE,
> > --
> > 1.9.1
> >

--===============5784363982100800954==--

