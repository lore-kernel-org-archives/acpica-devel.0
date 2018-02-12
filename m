Content-Type: multipart/mixed; boundary="===============7643781159648012961=="
MIME-Version: 1.0
From: gengdongjiu <gengdongjiu at huawei.com>
Subject: Re: [Devel] [PATCH v9 5/7] arm64: kvm: Introduce
 KVM_ARM_SET_SERROR_ESR ioctl
Date: Mon, 12 Feb 2018 18:19:24 +0800
Message-ID: <93d07d3e-8388-7814-d674-538071d84e2a@huawei.com>
In-Reply-To: 5A7DDDEE.9050306@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7643781159648012961==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,
 Thanks for the mail.

On 2018/2/10 1:44, James Morse wrote:
[...]
> =

>> its ESR is 0, can not control the virtual SError's syndrom value, it doe=
s not have
>> such registers to control that.
> =

> My point was its more nuanced than this: the ARM-ARM's
> TakeVirtualSErrorException() pseudo-code lets virtual-SError have an
> implementation defined syndrome. I've never seen Juno generate anything o=
ther
> than '0', but it might do something different on a thursday.

I checked the "aarch64/exceptions/asynch/AArch64.TakeVirtualSErrorException=
",
you are right, the virtual SError's syndrome value can be 0 or implementati=
on defined value, not always 0,
which is decided by the "exception.syndrome<24>".
thanks for the clarification.

> =

> The point? We can't know what a CPU without the RAS extensions puts in th=
ere.
> =

> Why Does this matter? When migrating a pending SError we have to know the
> difference between 'use this 64bit value', and 'the CPU will generate it'.
> If I make an SError pending with ESR=3D0 on a CPU with VSESR, I can't mig=
rated to
> a system that generates an impdef SError-ESR, because I can't know it wil=
l be 0.
Yes,
But it will have a issue,
For the target system, before taking the SError, no one can know whether it=
s syndrome value
is IMPLEMENTATION DEFINED or architecturally defined.

when the virtual SError is taken, the ESR_ELx.IDS will be updated, then we =
can know
whether the ESR value is impdef or architecturally defined.

It seems migration is only allowed only when target system and source syste=
m all support RAS extension, because we do not know
whether its syndrome is IMPLEMENTATION DEFINED or architecturally defined.

> =

> =

>> Does Juno not have RAS Extension? =

> =

> It's two types of v8.0 CPU, no RAS extensions.
> =

> =

>> if yes, I think we can only inject an SError, but can not change its ESR=
 value,
>> because it does not have vsesr_el2.
> =

> I agree, this means we need to be able to tell the difference between 'pe=
nding'
> and 'pending with this ESR'.
> =

> =

>>> Just because we can't control the ESR doesn't mean injecting an SError =
isn't
>>> something user-space may want to do.
> =

>> yes, we may need to support user-space injects an SError even through CP=
U does not have RAS Extension.
>>
>>> If we tackle migration of pending-SError first, I think that will give =
us the
>>> API to create a new pending SError with/without an ESR as appropriate.
>>
>> sure, we should. Last week, I checked the KVM_GET/SET_VCPU_EVENTS IOCTL,=
 it should meet our
>> migration requirements
> =

> Great!
> =

> =

> Thanks,
> =

> James
> =

> =



--===============7643781159648012961==--

