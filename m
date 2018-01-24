Content-Type: multipart/mixed; boundary="===============5289530129714951197=="
MIME-Version: 1.0
From: gengdongjiu <gengdongjiu at huawei.com>
Subject: Re: [Devel] [PATCH v9 5/7] arm64: kvm: Introduce
 KVM_ARM_SET_SERROR_ESR ioctl
Date: Wed, 24 Jan 2018 20:06:15 +0000
Message-ID: <0184EA26B2509940AA629AE1405DD7F201A9E8EA@DGGEMA503-MBS.china.huawei.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5289530129714951197==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,
   Thanks a lot for your review and comments.

> =

> Hi Dongjiu Geng,
> =

> On 06/01/18 16:02, Dongjiu Geng wrote:
> > The ARM64 RAS SError Interrupt(SEI) syndrome value is specific to the
> > guest and user space needs a way to tell KVM this value. So we add a
> > new ioctl. Before user space specifies the Exception Syndrome Register
> > ESR(ESR), it firstly checks that whether KVM has the capability to set
> > the guest ESR, If has, will set it. Otherwise, nothing to do.
> >
> > For this ESR specifying, Only support for AArch64, not support AArch32.
> =

> After this patch user-space can trigger an SError in the guest. If it wan=
ts to migrate the guest, how does the pending SError get migrated?
> =

> I think we need to fix migration first. Andrew Jones suggested using
> KVM_GET/SET_VCPU_EVENTS:
> https://www.spinics.net/lists/arm-kernel/msg616846.html
> =

> Given KVM uses kvm_inject_vabt() on v8.0 hardware too, we should cover sy=
stems without the v8.2 RAS Extensions with the same API. I
> think this means a bit to read/write whether SError is pending, and anoth=
er to indicate the ESR should be set/read.
> CPUs without the v8.2 RAS Extensions can reject pending-SError that had a=
n ESR.

For the CPUs without the v8.2 RAS Extensions, its ESR is always 0, we only =
can inject a SError with ESR 0 to guest, cannot set its ESR.
About how about to use the KVM_GET/SET_VCPU_EVENTS, I will check the code, =
and consider your suggestion at the same time. =

The IOCTL KVM_GET/SET_VCPU_EVENTS has been used by X86.

> =

> user-space can then use the 'for migration' calls to make a 'new' SError =
pending.
> =

> Now that the cpufeature bits are queued, I think this can be split up int=
o two separate series for v4.16-rc1, one to tackle NOTIFY_SEI and
> the associated plumbing. The second for the KVM 'make SError pending' API.

Ok, thanks for your suggestion, will split it.

> =

> =

> > diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c index
> > 5c7f657..738ae90 100644
> > --- a/arch/arm64/kvm/guest.c
> > +++ b/arch/arm64/kvm/guest.c
> > @@ -277,6 +277,11 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu =
*vcpu,
> >  	return -EINVAL;
> >  }
> >
> > +int kvm_arm_set_sei_esr(struct kvm_vcpu *vcpu, u32 *syndrome) {
> > +	return -EINVAL;
> > +}
> =

> Does nothing in the patch that adds the support? This is a bit odd.
> (oh, its hiding in patch 6...)

To make this patch simple and small, I add it in patch 6.

> =

> =

> Thanks,
> =

> James


--===============5289530129714951197==--

