Content-Type: multipart/mixed; boundary="===============3773625533500329338=="
MIME-Version: 1.0
From: Will Deacon <will.deacon at arm.com>
Subject: Re: [Devel] [PATCH v9 0/3] Cavium ThunderX2 SMMUv3 errata workarounds
Date: Thu, 22 Jun 2017 19:58:22 +0100
Message-ID: <20170622185822.GK15336@arm.com>
In-Reply-To: 20170622182257.GI15336@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3773625533500329338==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 22, 2017 at 07:22:57PM +0100, Will Deacon wrote:
> On Thu, Jun 22, 2017 at 05:35:35PM +0530, Geetha sowjanya wrote:
> > Cavium ThunderX2 SMMUv3 implementation has two Silicon Erratas.
> > 1. Errata ID #74
> >    SMMU register alias Page 1 is not implemented
> > 2. Errata ID #126
> >    SMMU doesnt support unique IRQ lines and also MSI for gerror,
> >    eventq and cmdq-sync
> > =

> > The following patchset does software workaround for these two erratas.
> =

> I've picked up the first two patches, and left comments on the final patc=
h.

... except that it doesn't build:


drivers/acpi/arm64/iort.c: In function =E2=80=98arm_smmu_v3_resource_size=
=E2=80=99:
drivers/acpi/arm64/iort.c:837:21: error: =E2=80=98ACPI_IORT_SMMU_V3_CAVIUM_=
CN99XX=E2=80=99 undeclared (first use in this function)
  if (smmu->model =3D=3D ACPI_IORT_SMMU_V3_CAVIUM_CN99XX)
                     ^
drivers/acpi/arm64/iort.c:837:21: note: each undeclared identifier is repor=
ted only once for each function it appears in
make[4]: *** [drivers/acpi/arm64/iort.o] Error 1


I don't see ACPI_IORT_SMMU_V3_CAVIUM_CN99XX defined, even in linux-next.

What's the plan here?

Will

--===============3773625533500329338==--

