Content-Type: multipart/mixed; boundary="===============0245481168354494979=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] AcpiDump.efi tool for uefi shell
Date: Fri, 24 Apr 2015 19:09:38 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D2CE9F3@ORSMSX112.amr.corp.intel.com>
In-Reply-To: 1AE640813FDE7649BE1B193DEA596E880270EA55@SHSMSX101.ccr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0245481168354494979==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Then send us the new acefi.h so we can integrate it into ACPICA.
Thanks,
Bob


> -----Original Message-----
> From: Zheng, Lv
> Sent: Thursday, April 23, 2015 11:21 PM
> To: Moore, Robert; Anteja Vuk Macek; devel(a)acpica.org; dsd(a)acpica.org
> Subject: RE: [Devel] AcpiDump.efi tool for uefi shell
> =

> It should be possible to build it under Cygwin environment.
> =

> IMO, if you really want to compile EFI ACPICA tools using MSVC, then you
> should 1. Copy necessary definitions from efi.h/efistdarg.h/efilib.h to
> acefi.h so that acefi.h no long depends on GNU-EFI 2. Define useful #ifdef
> in acenv.h to include acefi.h for MSVC builds 3. Change DivU64x32 to
> ACPI_OS_DIV64 and implement it for both GNU-EFI and MSVC builds.
> Then everything should be OK and you can even use MSVC to build
> acpidump.efi.
> =

> Thanks and best regards
> -Lv
> =

> > From: Moore, Robert
> > Sent: Friday, April 24, 2015 11:42 AM
> > To: Zheng, Lv; Anteja Vuk Macek; devel(a)acpica.org; dsd(a)acpica.org
> > Subject: RE: [Devel] AcpiDump.efi tool for uefi shell
> >
> > How about generation in the Cygwin environment?
> >
> >
> > > -----Original Message-----
> > > From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Zheng, Lv
> > > Sent: Thursday, April 23, 2015 7:37 PM
> > > To: Anteja Vuk Macek; devel(a)acpica.org; dsd(a)acpica.org
> > > Subject: Re: [Devel] AcpiDump.efi tool for uefi shell
> > >
> > > Hi,
> > >
> > > You should generate acpidump.efi in the Linux environment.
> > >
> > > And make sure GNU EFI is installed in your environment:
> > > # apt-get install gnu-efi
> > >
> > > Then type the following command in the command prompt:
> > > # make OS=3Defi
> > >
> > > You'll find it in the generate/efi/bin.
> > >
> > > Thanks
> > > -Lv
> > >
> > > From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Anteja
> > > Vuk Macek
> > > Sent: Thursday, April 23, 2015 3:38 PM
> > > To: devel(a)acpica.org; dsd(a)acpica.org
> > > Subject: [Devel] AcpiDump.efi tool for uefi shell
> > >
> > > Hi,
> > >
> > > I have a problem with creating AcpiDump.efi . I only can create
> > > AcpiDump.exe with Visual Studio 2013, but I can't create efi file. I
> > > try to do with minnowMax 078 buidable developming tree, but it don't
> > > work beacause I got error :
> > >
> > > c:\minmax078\acpica-master\source\tools\acpidump\acenv.h(296) :
> > > fatal error C1189 : #error : Unknown target environment NMAKE :
> > > fatal error
> > > U1077 : ' "C:\Program Files(x86)\Microsoft Visual Studio
> > > 9.0\Vc\bin\cl.exe" ' : return code 0x2 '
> > >
> > > PROBLEM : What I need to do to create the AcpiDump.efi ?
> > >
> > >
> > > Best regards,
> > > Anteja
> > >
> > >
> > > _______________________________________________
> > > Devel mailing list
> > > Devel(a)acpica.org
> > > https://lists.acpica.org/mailman/listinfo/devel

--===============0245481168354494979==--

