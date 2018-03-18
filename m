Content-Type: multipart/mixed; boundary="===============2859756309848473239=="
MIME-Version: 1.0
From: gengdongjiu <gengdongjiu at huawei.com>
Subject: Re: [Devel] [PATCH v10 2/5] arm64: KVM: export the capability to set
 guest SError syndrome
Date: Sun, 18 Mar 2018 07:33:59 +0000
Message-ID: <0184EA26B2509940AA629AE1405DD7F201B6C27D@DGGEMA503-MBS.china.huawei.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2859756309848473239==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,
   Thanks for your time to review and give comments.

[...]
> > +
> > +8.14 KVM_CAP_ARM_SET_SERROR_ESR
> > +
> > +Architectures: arm, arm64
> > +
> > +This capability indicates that userspace can specify syndrome value
> > +reported to guest OS when guest takes a virtual SError interrupt excep=
tion.
> =

> "when userspace triggers a virtual SError"... how?

In the user space(QEMU), it will call kvm_arch_put_registers() or kvm_arch_=
get_registers() to set or get KVM registers through KVM_SET_ONE_REG/ KVM_GE=
T_ONE_REG IOCTL, at the same time the two functions will separately call kv=
m_arm_vcpu_get_events() and kvm_arm_vcpu_set_events() to get/set vcpu event=
s. If user space want to trigger a virtual SError with specified ESR, it on=
ly need to setup the kvm_vcpu_events struct(exception.serror_pending =3D 1;=
 exception.serror_has_esr=3D1; serror_esr=3Dxxxxx), then KVM will trigger t=
his virtual SError.

userspace can trigger it at any time, for example, for debug purpose.  Or s=
imulate a SError after recording a CPER for guest. But before triggering a =
virtual SError, it needs to know whether KVM has such capability, so KVM ne=
eds to export this capability to user space. If has this capability, User s=
pace will call kvm_arm_vcpu_set_events() to trigger a virtual SError.

> =

> =

> > +If KVM has this capability, userspace can only specify the ISS field
> > +for the ESR syndrome, can not specify the EC field which is not under =
control by KVM.
> =

> Where do I put the ESR?
> If you re-order this after the patch that adds the API, you can describe =
how this can be used.

Ok, thank a lot for your suggestion.

> =

> =

> Thanks,
> =

> James
> =

> =

> =

> > +If this virtual SError is taken to EL1 using AArch64, this value will
> > +be reported into ISS filed of ESR_EL1.
> > diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c index
> > 3256b92..38c8a64 100644
> > --- a/arch/arm64/kvm/reset.c
> > +++ b/arch/arm64/kvm/reset.c
> > @@ -77,6 +77,9 @@ int kvm_arch_dev_ioctl_check_extension(struct kvm *kv=
m, long ext)
> >  	case KVM_CAP_ARM_PMU_V3:
> >  		r =3D kvm_arm_support_pmu_v3();
> >  		break;
> > +	case KVM_CAP_ARM_INJECT_SERROR_ESR:
> > +		r =3D cpus_have_const_cap(ARM64_HAS_RAS_EXTN);
> > +		break;
> >  	case KVM_CAP_SET_GUEST_DEBUG:
> >  	case KVM_CAP_VCPU_ATTRIBUTES:
> >  		r =3D 1;
> > diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h index
> > 8fb90a0..3587b33 100644
> > --- a/include/uapi/linux/kvm.h
> > +++ b/include/uapi/linux/kvm.h
> > @@ -934,6 +934,7 @@ struct kvm_ppc_resize_hpt {  #define
> > KVM_CAP_S390_AIS_MIGRATION 150  #define KVM_CAP_PPC_GET_CPU_CHAR 151
> > #define KVM_CAP_S390_BPB 152
> > +#define KVM_CAP_ARM_INJECT_SERROR_ESR 153
> >
> >  #ifdef KVM_CAP_IRQ_ROUTING
> >
> >


--===============2859756309848473239==--

