Content-Type: multipart/mixed; boundary="===============4476342481998641159=="
MIME-Version: 1.0
From: Will Deacon <will.deacon at arm.com>
Subject: Re: [Devel] [RFC PATCH 6/6] iommu/arm-smmu-v3: Avoid ILLEGAL setting
 of STE.S1STALLD and CD.S
Date: Wed, 13 Sep 2017 18:11:59 +0100
Message-ID: <20170913171159.GB14955@arm.com>
In-Reply-To: 2f952821-afc3-46dd-17eb-40e8626bd6e5@huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4476342481998641159==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2017 at 06:11:13PM +0800, Yisheng Xie wrote:
> On 2017/9/13 11:06, Will Deacon wrote:
> > On Tue, Sep 05, 2017 at 01:54:19PM +0100, Jean-Philippe Brucker wrote:
> >> On 31/08/17 09:20, Yisheng Xie wrote:
> >>> It is ILLEGAL to set STE.S1STALLD if STALL_MODEL is not 0b00, which
> >>> means we should not disable stall mode if stall/terminate mode is not
> >>> configuable.
> >>>
> >>> Meanwhile, it is also ILLEGAL when STALL_MODEL=3D=3D0b10 && CD.S=3D=
=3D0 which
> >>> means if stall mode is force we should always set CD.S.
> >>>
> >>> This patch add ARM_SMMU_FEAT_TERMINATE feature bit for smmu, and use
> >>> TERMINATE feature checking to ensue above ILLEGAL cases from happenin=
g.
> >>>
> >>> Signed-off-by: Yisheng Xie <xieyisheng1(a)huawei.com>
> >>> ---
> >>>  drivers/iommu/arm-smmu-v3.c | 22 ++++++++++++++++------
> >>>  1 file changed, 16 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> >>> index dbda2eb..0745522 100644
> >>> --- a/drivers/iommu/arm-smmu-v3.c
> >>> +++ b/drivers/iommu/arm-smmu-v3.c
> >>> @@ -55,6 +55,7 @@
> >>>  #define IDR0_STALL_MODEL_SHIFT		24
> >>>  #define IDR0_STALL_MODEL_MASK		0x3
> >>>  #define IDR0_STALL_MODEL_STALL		(0 << IDR0_STALL_MODEL_SHIFT)
> >>> +#define IDR0_STALL_MODEL_NS		(1 << IDR0_STALL_MODEL_SHIFT)
> >>>  #define IDR0_STALL_MODEL_FORCE		(2 << IDR0_STALL_MODEL_SHIFT)
> >>>  #define IDR0_TTENDIAN_SHIFT		21
> >>>  #define IDR0_TTENDIAN_MASK		0x3
> >>> @@ -766,6 +767,7 @@ struct arm_smmu_device {
> >>>  #define ARM_SMMU_FEAT_SVM		(1 << 15)
> >>>  #define ARM_SMMU_FEAT_HA		(1 << 16)
> >>>  #define ARM_SMMU_FEAT_HD		(1 << 17)
> >>> +#define ARM_SMMU_FEAT_TERMINATE		(1 << 18)
> >>
> >> I'd rather introduce something like "ARM_SMMU_FEAT_STALL_FORCE" instea=
d.
> >> Terminate model has another meaning, and is defined by a different bit=
 in
> >> IDR0.
> > =

> > Yes. What we need to do is:
> > =

> > - If STALL_MODEL is 0b00, then set S1STALLD
> =

> Yes, and within this case, we can only set the S1STALLD for masters which=
 can
> not stall in the future?

Yeah, something like that. I'd probably predicate it on having afault
handler registered too.

Will

--===============4476342481998641159==--

