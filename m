Content-Type: multipart/mixed; boundary="===============6307860667924629027=="
MIME-Version: 1.0
From: Lin Ming <lin at minggr.cn>
Subject: Re: [Devel] Query about the ACPI
Date: Mon, 18 Jan 2010 10:02:26 +0800
Message-ID: <d3f22a1001171802v2d7a292fm8811ba635678bb1a@mail.gmail.com>
In-Reply-To: F3559959283BB949B69FE4146615117C67A5442381@GVW1161EXB.americas.hpqcorp.net
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6307860667924629027==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 18, 2010 at 9:40 AM, Hsu, Edward (ETD) <ehsu(a)hp.com> wrote:
>
> Hi Bob,
>
> As programing the applications in Windows,=C2=A0 I was wondering if the a=
pplications are able to invoke the ACPI driver/AML Interpreter, ask for the=
 data from ACPI registers/ACPI BIOS/ACPI Tables as below. Thank you.

Windows has its own ACPI driver/AML Interpreter. The interface is
different with ACPICA.
Applications can't access the register directly.
You need to write a driver in Windows to access the register.

Some info at http://msdn.microsoft.com/en-us/library/ms789240.aspx

Lin Ming

>
>
> Best Regards,
>
> Edward Hsu
>
>
>
> -----Original Message-----
> From: Moore, Robert [mailto:robert.moore(a)intel.com]
> Sent: Friday, January 15, 2010 9:45 PM
> To: Hsu, Edward (ETD); devel(a)acpica.org
> Subject: RE: Query about the ACPI
>
>
>
> >-----Original Message-----
> >From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] On =
Behalf
> >Of Hsu, Edward (ETD)
> >Sent: Thursday, January 14, 2010 9:59 PM
> >To: devel(a)acpica.org
> >Subject: [Devel] Query about the ACPI
> >
> >To whom it may concern,
> >
> >Hello, I've gone through the ACPI website, http://www.acpica.org/, and I
> >was wondering if the all Intel-related developmet tools would work for A=
MD
> >platform as well.
> >
>
> Yes. ACPI is not processor specific.
>
>
> >Besides, can it be merged into a Microsoft Windows application program?
>
> Please explain the question further.
>
> Bob
>
>
> >
> >Thank you very much.
> >
> >
> >Best Regards,
> >
> >Edward Hsu
> >_______________________________________________
> >Devel mailing list
> >Devel(a)acpica.org
> >http://lists.acpica.org/listinfo/devel
>
> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> http://lists.acpica.org/listinfo/devel

--===============6307860667924629027==--

