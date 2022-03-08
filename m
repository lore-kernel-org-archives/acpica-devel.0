Content-Type: multipart/mixed; boundary="===============2886755419162708113=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH V2 0/2] ACPI: Add LoongArch-related definitions
Date: Tue, 08 Mar 2022 19:49:14 +0100
Message-ID: <CAJZ5v0hsHMcqd==+cJZUcd3T11NUU6bSphFbBRjvv1ktCuH08w@mail.gmail.com>
In-Reply-To: 20220306111838.810959-1-chenhuacai@loongson.cn
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2886755419162708113==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 6, 2022 at 12:17 PM Huacai Chen <chenhuacai(a)loongson.cn> wrot=
e:
>
> LoongArch is a new RISC ISA, which is a bit like MIPS or RISC-V.
> LoongArch includes a reduced 32-bit version (LA32R), a standard 32-bit
> version (LA32S) and a 64-bit version (LA64). LoongArch use ACPI as its
> boot protocol LoongArch-specific interrupt controllers (similar to APIC)
> are already added in the next revision of ACPI Specification (current
> revision is 6.4).
>
> This patchset are preparing to add LoongArch support in mainline kernel,
> we can see a snapshot here:
> https://github.com/loongson/linux/tree/loongarch-next
>
> Cross-compile tool chain to build kernel:
> https://github.com/loongson/build-tools/releases
>
> Loongson and LoongArch documentations:
> https://github.com/loongson/LoongArch-Documentation
>
> ECR for LoongArch-specific interrupt controllers:
> https://mantis.uefi.org/mantis/view.php?id=3D2203
> https://mantis.uefi.org/mantis/view.php?id=3D2313
>
> ACPI changes of LoongArch have been approved in the last year, but the
> new version of ACPI SPEC hasn't been made public yet.
>
> V2: Remove merged patches and update commit messages.
>
> Huacai Chen and Jianmin Lv(2):
>  ACPICA: MADT: Add LoongArch APICs support.
>  ACPICA: Events: Support fixed pcie wake event.

Both patches in this series are mostly ACPICA material which needs to
be submitted to the upstream ACPICA project via
https://github.com/acpica/acpica

It will be pulled by the Linux kernel from there.

>
> Signed-off-by: Huacai Chen <chenhuacai(a)loongson.cn>
> Signed-off-by: Jianmin Lv <lvjianmin(a)loongson.cn>
> ---
>  drivers/acpi/acpica/evevent.c  |  17 ++++--
>  drivers/acpi/acpica/hwsleep.c  |  12 ++++
>  drivers/acpi/acpica/utglobal.c |   4 ++
>  drivers/acpi/tables.c          |  10 ++++

This tables.c change can be submitted as a separate patch when the
ACPICA changes get integrated.

>  include/acpi/actbl2.h          | 125 +++++++++++++++++++++++++++++++++++=
+++++-
>  include/acpi/actypes.h         |   3 +-
>  6 files changed, 163 insertions(+), 8 deletions(-)
> --
> 2.27.0
>
--===============2886755419162708113==--

