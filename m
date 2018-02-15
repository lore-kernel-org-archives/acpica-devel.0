Content-Type: multipart/mixed; boundary="===============7333250683336162067=="
MIME-Version: 1.0
From: James Morse <james.morse at arm.com>
Subject: Re: [Devel] [PATCH v9 5/7] arm64: kvm: Introduce
 KVM_ARM_SET_SERROR_ESR ioctl
Date: Thu, 15 Feb 2018 17:55:00 +0000
Message-ID: <5A85C974.70500@arm.com>
In-Reply-To: 93d07d3e-8388-7814-d674-538071d84e2a@huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7333250683336162067==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi gengdongjiu,

On 12/02/18 10:19, gengdongjiu wrote:
> On 2018/2/10 1:44, James Morse wrote:
>> The point? We can't know what a CPU without the RAS extensions puts in t=
here.
>>
>> Why Does this matter? When migrating a pending SError we have to know the
>> difference between 'use this 64bit value', and 'the CPU will generate it=
'.
>> If I make an SError pending with ESR=3D0 on a CPU with VSESR, I can't mi=
grated to
>> a system that generates an impdef SError-ESR, because I can't know it wi=
ll be 0.

> For the target system, before taking the SError, no one can know whether =
its syndrome value
> is IMPLEMENTATION DEFINED or architecturally defined.

For a virtual-SError, the hypervisor knows what it generated. (do I have
VSESR_EL2? What did I put in there?).


> when the virtual SError is taken, the ESR_ELx.IDS will be updated, then w=
e can know
> whether the ESR value is impdef or architecturally defined.

True, the guest can't know anything about a pending virtual SError until it
takes it. Why is this a problem?


> It seems migration is only allowed only when target system and source sys=
tem all support
> RAS extension, because we do not know whether its syndrome is IMPLEMENTAT=
ION DEFINED or
> architecturally defined.

I don't think Qemu allows migration between hosts with differing guest-ID
registers. But we shouldn't depend on this, and we may want to hide the v8.=
2 RAS
features from the guest's ID register, but still use them from the host.

The way I imagined it working was we would pack the following information i=
nto
that events struct:
{
	bool serror_pending;
	bool serror_has_esr;
	u64  serror_esr;
}

The problem I was trying to describe is because there is no value of serror=
_esr
we can use to mean 'Ignore this, I'm a v8.0 CPU'. VSESR_EL2 is a 64bit regi=
ster,
any bits we abuse may get a meaning we want to use in the future.

When it comes to migration, v8.{0,1} systems can only GET/SET events where
serror_has_esr =3D=3D false, they can't use the serror_esr. On v8.2 systems=
 we
should require serror_has_esr to be true.

If we need to support migration from v8.{0,1} to v8.2, we can make up an im=
pdef
serror_esr.

We will need to decide what KVM does when SET is called but an SError was
already pending. 2.5.3 "Multiple SError interrupts" of [0] has something to=
 say.


Happy new year,

James


[0]
https://static.docs.arm.com/ddi0587/a/RAS%20Extension-release%20candidate_m=
arch_29.pdf

--===============7333250683336162067==--

