Content-Type: multipart/mixed; boundary="===============3440280704643787352=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] AcpiDump.efi tool for uefi shell
Date: Fri, 24 Apr 2015 02:36:43 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E880270D913@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: CAOPTR2CCAsaiUOu6MvFXVnbCQP_0xaZPCfZ-FWC_=BcYONwPHA@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3440280704643787352==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

You should generate acpidump.efi in the Linux environment.

And make sure GNU EFI is installed in your environment:
# apt-get install gnu-efi

Then type the following command in the command prompt:
# make OS=3Defi

You'll find it in the generate/efi/bin.

Thanks
-Lv

From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Anteja Vuk Mac=
ek
Sent: Thursday, April 23, 2015 3:38 PM
To: devel(a)acpica.org; dsd(a)acpica.org
Subject: [Devel] AcpiDump.efi tool for uefi shell

Hi,=C2=A0

I have a problem with creating AcpiDump.efi . I only can create AcpiDump.ex=
e with Visual Studio 2013, but I can't create efi file.=C2=A0
I try to do with minnowMax 078 buidable developming tree, but it don't work=
 beacause I got error :=C2=A0

c:\minmax078\acpica-master\source\tools\acpidump\acenv.h(296) : fatal error=
 C1189 : #error : Unknown target environment=C2=A0
NMAKE : fatal error U1077 : ' "C:\Program Files(x86)\Microsoft Visual Studi=
o 9.0\Vc\bin\cl.exe" ' : return code 0x2 '=C2=A0

PROBLEM : What I need to do to create the AcpiDump.efi ? =C2=A0


Best regards,=C2=A0
Anteja=C2=A0



--===============3440280704643787352==--

