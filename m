Content-Type: multipart/mixed; boundary="===============4725438385674489647=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] ACPI table code of Lenovo G710 corrupted?
Date: Tue, 17 Nov 2015 21:57:20 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D9975F4@ORSMSX112.amr.corp.intel.com>
In-Reply-To: CAB=Lj3Qjsi3jmrsgk9GDPynSedLZuhkJtsM=Dt-qFZ+_+AtfLA@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4725438385674489647==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There are some issues with this machine, but these are more linux-specific =
and I can=E2=80=99t help with those.

[   13.115675] ACPI Warning: SystemIO range 0x0000000000005040-0x0000000000=
00505F conflicts with OpRegion 0x0000000000005040-0x000000000000504F (\_SB_=
.PCI0.SBUS.SMBI) (20150204/utaddress-254)
[   13.115683] ACPI: If an ACPI driver is available for this device, you sh=
ould use it instead of the native driver

[   13.426574] [Firmware Bug]: ACPI(PEGP) defines _DOD but not _DOS
[   13.426902] ACPI: Video Device [PEGP] (multi-head: yes  rom: yes  post: =
no)
[   13.426908] ACPI Error: [\_SB_.PCI0.GFX0.DD02._BCL] Namespace lookup fai=
lure, AE_NOT_FOUND (20150204/psargs-359)
[   13.426913] ACPI Error: Method parse/execution failed [\_SB_.PCI0.PEG0.P=
EGP.DD02._BCL] (Node ffff8802560f8e38), AE_NOT_FOUND (20150204/psparse-536)
[   13.426972] input: Video Bus




From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of David Renz
Sent: Tuesday, November 17, 2015 11:31 AM
To: devel(a)acpica.org
Subject: [Devel] ACPI table code of Lenovo G710 corrupted?

Hello everyone,

I own a Lenovo G710 notebook (here one can see the exact model: http://post=
img.org/image/rm5vjgkb5/), and I find that the code stored in its ACPI tabl=
es, which I extracted using the Windows tool "Read&Write Everything", leads=
 to strange/suspicious results when I submitted it to malwr.com:
https://malwr.com/analysis/MjZkOGU4Y2ZmMGM5NDQ1Njg5OTc4NTVlOTQ5NThiMmY/

Why should the ACPI table code lead to the deployment of files related to M=
icrosoft office, which is not even installed right after having installed W=
indows?

And looking at the section "Registry keys":
Isn't it strange that this code causes all those registry changes, especial=
ly regarding all those "InProcServer32" entries?


Could anyone, who owns the same model, try to extract its ACPI tables and s=
ubmit them to malwr.com in order to check if this leads to the same results=
? And if one should thinks of this code being corrupted, then I guess it wo=
uld be a good idea to perform a comparison in order to find differences and=
 to check what those would imply.
I uploaded the extracted ACPI tables of my notebook on GoogleDrive:
https://drive.google.com/file/d/0B62Y5Qk_rdbWamlXRXZBSkJQYkU/view?usp=3Dsha=
ring
Under Pentoo Linux (and any other Linux distro I tried) the dmesg output al=
so shows quite many ACPI related error messages (starting at second 13):
https://drive.google.com/file/d/0B62Y5Qk_rdbWMGJNVnpXcVBIbEE/view?usp=3Dsha=
ring

Thanks in advance and best wishes
David

=C2=A0

=C2=A0

Best wishes and thanks in advance

--===============4725438385674489647==--

