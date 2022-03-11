Content-Type: multipart/mixed; boundary="===============3772024166031812918=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] Re: [PATCH V2 0/2] ACPI: Add LoongArch-related definitions
Date: Fri, 11 Mar 2022 15:16:27 +0000
Message-ID: <BYAPR11MB3256DACFEA49CBB8DBBC353C870C9@BYAPR11MB3256.namprd11.prod.outlook.com>
In-Reply-To: CAAhV-H7oB9KMSEv-ea-qazSFw+zBowqufO=8mWsPPP7L9Gx9vQ@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3772024166031812918==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



-----Original Message-----
From: Huacai Chen <chenhuacai(a)gmail.com> =

Sent: Tuesday, March 08, 2022 9:30 PM
To: Rafael J. Wysocki <rafael(a)kernel.org>
Cc: Huacai Chen <chenhuacai(a)loongson.cn>; Rafael J . Wysocki <rjw(a)rjwys=
ocki.net>; Len Brown <lenb(a)kernel.org>; Moore, Robert <robert.moore(a)int=
el.com>; Erik Kaneda <erik.kaneda(a)intel.com>; ACPI Devel Maling List <lin=
ux-acpi(a)vger.kernel.org>; open list:ACPI COMPONENT ARCHITECTURE (ACPICA) =
<devel(a)acpica.org>; Xuefeng Li <lixuefeng(a)loongson.cn>; Jiaxun Yang <ji=
axun.yang(a)flygoat.com>; Jianmin Lv <lvjianmin(a)loongson.cn>
Subject: Re: [PATCH V2 0/2] ACPI: Add LoongArch-related definitions

Hi, Rafael,

On Wed, Mar 9, 2022 at 2:49 AM Rafael J. Wysocki <rafael(a)kernel.org> wrot=
e:
>
> On Sun, Mar 6, 2022 at 12:17 PM Huacai Chen <chenhuacai(a)loongson.cn> wr=
ote:
> >
> > LoongArch is a new RISC ISA, which is a bit like MIPS or RISC-V.
> > LoongArch includes a reduced 32-bit version (LA32R), a standard =

> > 32-bit version (LA32S) and a 64-bit version (LA64). LoongArch use =

> > ACPI as its boot protocol LoongArch-specific interrupt controllers =

> > (similar to APIC) are already added in the next revision of ACPI =

> > Specification (current revision is 6.4).
> >
> > This patchset are preparing to add LoongArch support in mainline =

> > kernel, we can see a snapshot here:
> > https://github.com/loongson/linux/tree/loongarch-next
> >
> > Cross-compile tool chain to build kernel:
> > https://github.com/loongson/build-tools/releases
> >
> > Loongson and LoongArch documentations:
> > https://github.com/loongson/LoongArch-Documentation
> >
> > ECR for LoongArch-specific interrupt controllers:
> > https://mantis.uefi.org/mantis/view.php?id=3D2203
> > https://mantis.uefi.org/mantis/view.php?id=3D2313
> >
> > ACPI changes of LoongArch have been approved in the last year, but =

> > the new version of ACPI SPEC hasn't been made public yet.
> >
> > V2: Remove merged patches and update commit messages.
> >
> > Huacai Chen and Jianmin Lv(2):
> >  ACPICA: MADT: Add LoongArch APICs support.
> >  ACPICA: Events: Support fixed pcie wake event.
>
> Both patches in this series are mostly ACPICA material which needs to =

> be submitted to the upstream ACPICA project via =

> https://github.com/acpica/acpica
>
> It will be pulled by the Linux kernel from there.
I found that you are also a maintainer of the ACPICA project, do you mean I=
 should submit by github PR, not by maillist?

Yes.
>
> >
> > Signed-off-by: Huacai Chen <chenhuacai(a)loongson.cn>
> > Signed-off-by: Jianmin Lv <lvjianmin(a)loongson.cn>
> > ---
> >  drivers/acpi/acpica/evevent.c  |  17 ++++--  =

> > drivers/acpi/acpica/hwsleep.c  |  12 ++++
> >  drivers/acpi/acpica/utglobal.c |   4 ++
> >  drivers/acpi/tables.c          |  10 ++++
>
> This tables.c change can be submitted as a separate patch when the =

> ACPICA changes get integrated.
Do you mean split the first patch into .h parts and .c parts, then submit t=
he .h parts and the second patch by github PR, then submit the .c parts of =
the first patch by maillist?

No, that is not necessary.

Huacai
>
> >  include/acpi/actbl2.h          | 125 +++++++++++++++++++++++++++++++++=
+++++++-
> >  include/acpi/actypes.h         |   3 +-
> >  6 files changed, 163 insertions(+), 8 deletions(-)
> > --
> > 2.27.0
> >

--===============3772024166031812918==--

