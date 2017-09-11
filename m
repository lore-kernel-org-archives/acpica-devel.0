Content-Type: multipart/mixed; boundary="===============5367973646962638471=="
MIME-Version: 1.0
From: gengdongjiu <gengdongjiu at huawei.com>
Subject: Re: [Devel] [PATCH v11 6/6] target-arm: kvm64: Handle SError
 interrupt for the guest OS
Date: Mon, 11 Sep 2017 15:17:56 +0000
Message-ID: <0184EA26B2509940AA629AE1405DD7F2015FE17F@DGGEMA503-MBX.china.huawei.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5367973646962638471==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi peter,

> =

> On 18 August 2017 at 15:23, Dongjiu Geng <gengdongjiu(a)huawei.com> wrote:
> > When guest OS happens SError interrupt(SEI), it will trap to host.
> > Host firstly calls memory failure to deal with this error and decide
> > whether it needs to deliver SIGBUS signal to userspace. The advantage
> > that using signal to notify is that it can make the notification
> > method is general, non-KVM user can also use it. when userspace gets
> > this signal and knows this is SError interrupt, it will translate the
> > delivered host VA to PA and record this PA to GHES.
> >
> > Because ARMv8.2 adds an extension to RAS to allow system software
> > insert implicit Error Synchronization Barrier operations to isolate
> > the error and allow passes specified syndrome to guest OS, so after
> > record the CPER, user space calls IOCTL to pass a specified syndrome
> > to KVM, then switch to guest OS, guest OS can use the recorded CPER
> > record and syndrome information to do the recovery.
> >
> > The steps are shown below:
> > 1. translate the host VA to guest OS PA and record this error PA to HES=
T table.
> > 2. set specified virtual SError syndrome and pass the value to KVM.
> >
> > Signed-off-by: Dongjiu Geng <gengdongjiu(a)huawei.com>
> > Signed-off-by: Quanming Wu <wuquanming(a)huawei.com>
> > ---
> >  linux-headers/linux/kvm.h |  1 +
> >  target/arm/internals.h    |  1 +
> >  target/arm/kvm64.c        | 28 ++++++++++++++++++++++++++++
> >  3 files changed, 30 insertions(+)
> >
> > diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> > index 2aa176e..10dfcab 100644
> > --- a/linux-headers/linux/kvm.h
> > +++ b/linux-headers/linux/kvm.h
> > @@ -1356,6 +1356,7 @@ struct kvm_s390_ucas_mapping {
> >  /* Available with KVM_CAP_S390_CMMA_MIGRATION */
> >  #define KVM_S390_GET_CMMA_BITS      _IOWR(KVMIO, 0xb8, struct kvm_s390=
_cmma_log)
> >  #define KVM_S390_SET_CMMA_BITS      _IOW(KVMIO, 0xb9, struct kvm_s390_=
cmma_log)
> > +#define KVM_ARM_SEI                 _IO(KVMIO,   0xb10)
> >
> >  #define KVM_DEV_ASSIGN_ENABLE_IOMMU    (1 << 0)
> >  #define KVM_DEV_ASSIGN_PCI_2_3         (1 << 1)
> > diff --git a/target/arm/internals.h b/target/arm/internals.h index
> > fc0ad6d..18b1cbc 100644
> > --- a/target/arm/internals.h
> > +++ b/target/arm/internals.h
> > @@ -237,6 +237,7 @@ enum arm_exception_class {  #define ARM_EL_ISV (1
> > << ARM_EL_ISV_SHIFT)  #define ARM_EL_EC_MASK  ((0x3F) <<
> > ARM_EL_EC_SHIFT)  #define ARM_EL_FSC_TYPE (0x3C)
> > +#define ARM_EL_ISS_MASK ((1 << ARM_EL_IL_SHIFT) - 1)
> >
> >  #define FSC_SEA         (0x10)
> >  #define FSC_SEA_TTW0    (0x14)
> > diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c index
> > d3bdab2..b84cb49 100644
> > --- a/target/arm/kvm64.c
> > +++ b/target/arm/kvm64.c
> > @@ -616,6 +616,22 @@ static int kvm_arm_cpreg_value(ARMCPU *cpu, ptrdif=
f_t fieldoffset)
> >      return -EINVAL;
> >  }
> >
> > +static int kvm_inject_arm_sei(CPUState *cs) {
> > +    ARMCPU *cpu =3D ARM_CPU(cs);
> > +    CPUARMState *env =3D &cpu->env;
> > +
> > +    unsigned long syndrome =3D env->exception.vaddress;
> > +    /* set virtual SError syndrome */
> > +    if (arm_feature(env, ARM_FEATURE_RAS_EXTENSION)) {
> > +        syndrome =3D syndrome & ARM_EL_ISS_MASK;
> > +    } else {
> > +        syndrome =3D 0;
> > +    }
> > +
> > +    return  kvm_vcpu_ioctl(CPU(cpu), KVM_ARM_SEI, &syndrome);
> =

> This looks odd. If we don't have the RAS extension why do we need to do a=
nything at all here ?

This is because Qemu may need to support non-RAS extension as discussed wit=
h ARM James before.
That is to say host hardware CPU does not support RAS, but guest supports.
That is under discussion.
When host hardware supports RAS, specify the syndrome to a valid value, oth=
erwise, set it to 0.

> =

> > +}
> > +
> >  /* Inject synchronous external abort */  static int
> > kvm_inject_arm_sea(CPUState *c)  { @@ -1007,6 +1023,15 @@ static bool
> > is_abort_sea(unsigned long syndrome)
> >      }
> >  }
> >
> > +static bool is_abort_sei(unsigned long syndrome) {
> > +    uint8_t ec =3D ((syndrome & ARM_EL_EC_MASK) >> ARM_EL_EC_SHIFT);
> =

> You don't need to bother masking here -- in other places in QEMU we assum=
e that the EC field is at the top of the word, so just "syndrome >>
> ARM_EL_EC_SHIFT" is sufficient.

OK, thanks for the suggestion.

> =

> > +    if ((ec !=3D EC_SERROR))
> > +        return false;
> > +    else
> > +        return true;
> =

> scripts/checkpatch.pl should tell you that this if needs braces (it's goo=
d to get in the habit of running it on all patches; it is not always
> correct, so judgement is required, but it will flag up some common mistak=
es).
> =

> In this particular case, you should just
>    return ec =3D=3D EC_SERROR;
> though.

Good suggestion.

> =

> > +}
> > +
> >  void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)  {
> >      ram_addr_t ram_addr;
> > @@ -1024,6 +1049,9 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int cod=
e, void *addr)
> >              if (is_abort_sea(env->exception.syndrome)) {
> >                  ghes_update_guest(ACPI_HEST_NOTIFY_SEA, paddr);
> >                  kvm_inject_arm_sea(c);
> > +            } else if (is_abort_sei(env->exception.syndrome)) {
> > +                ghes_update_guest(ACPI_HEST_NOTIFY_SEI, paddr);
> > +                kvm_inject_arm_sei(c);
> >              }
> >              return;
> >          }
> > --
> > 1.8.3.1
> =

> thanks
> -- PMM

--===============5367973646962638471==--

