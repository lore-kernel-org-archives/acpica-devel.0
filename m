Content-Type: multipart/mixed; boundary="===============8604152164579309485=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] AcpiDump.efi tool for uefi shell
Date: Fri, 24 Apr 2015 03:42:13 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D2C1063@ORSMSX112.amr.corp.intel.com>
In-Reply-To: 1AE640813FDE7649BE1B193DEA596E880270D913@SHSMSX101.ccr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8604152164579309485==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

How about generation in the Cygwin environment?


> -----Original Message-----
> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Zheng, Lv
> Sent: Thursday, April 23, 2015 7:37 PM
> To: Anteja Vuk Macek; devel(a)acpica.org; dsd(a)acpica.org
> Subject: Re: [Devel] AcpiDump.efi tool for uefi shell
> =

> Hi,
> =

> You should generate acpidump.efi in the Linux environment.
> =

> And make sure GNU EFI is installed in your environment:
> # apt-get install gnu-efi
> =

> Then type the following command in the command prompt:
> # make OS=3Defi
> =

> You'll find it in the generate/efi/bin.
> =

> Thanks
> -Lv
> =

> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Anteja Vuk
> Macek
> Sent: Thursday, April 23, 2015 3:38 PM
> To: devel(a)acpica.org; dsd(a)acpica.org
> Subject: [Devel] AcpiDump.efi tool for uefi shell
> =

> Hi,
> =

> I have a problem with creating AcpiDump.efi . I only can create
> AcpiDump.exe with Visual Studio 2013, but I can't create efi file. I try
> to do with minnowMax 078 buidable developming tree, but it don't work
> beacause I got error :
> =

> c:\minmax078\acpica-master\source\tools\acpidump\acenv.h(296) : fatal
> error C1189 : #error : Unknown target environment NMAKE : fatal error
> U1077 : ' "C:\Program Files(x86)\Microsoft Visual Studio
> 9.0\Vc\bin\cl.exe" ' : return code 0x2 '
> =

> PROBLEM : What I need to do to create the AcpiDump.efi ?
> =

> =

> Best regards,
> Anteja
> =

> =

> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> https://lists.acpica.org/mailman/listinfo/devel

--===============8604152164579309485==--

