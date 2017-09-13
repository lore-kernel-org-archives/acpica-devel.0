Content-Type: multipart/mixed; boundary="===============7080739008988866999=="
MIME-Version: 1.0
From: gengdongjiu <gengdongjiu at huawei.com>
Subject: Re: [Devel] [PATCH v6 5/7] arm64: kvm: route synchronous external
 abort exceptions to el2
Date: Wed, 13 Sep 2017 16:12:10 +0800
Message-ID: <761bca49-7257-75a6-f6a9-e8e5e2af9ad0@huawei.com>
In-Reply-To: 59B17449.6010201@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7080739008988866999==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 2017/9/8 0:31, James Morse wrote:
> Hi Dongjiu Geng,
> =

> On 28/08/17 11:38, Dongjiu Geng wrote:
>> ARMv8.2 adds a new bit HCR_EL2.TEA which controls to
>> route synchronous external aborts to EL2, and adds a
>> trap control bit HCR_EL2.TERR which controls to
>> trap all Non-secure EL1&0 error record accesses to EL2.
>>
>> This patch enables the two bits for the guest OS.
>> when an synchronous abort is generated in the guest OS,
> =

>> it will trap to EL3 firmware, EL3 firmware will check the
>> HCR_EL2.TEA value to decide to jump to hypervisor or host
>> OS.
> =

> (This is what you are using this for, the patch has nothing to do with EL=
3.)

No, EL3 will check the HCR_EL2.TEA to decide to jump to hypervisor or host =
kernel.


> =

> =

>> Enabling HCR_EL2.TERR makes error record access
>> from guest trap to EL2.
> =

> =

> KVM already handles external aborts from lower exception levels, no more =
work
> needs doing for TEA.
when SCR_EL3.EA is set, TEA will not workable, El3 only check its value to =
decide to hypervisor or EL1 host kernel.

> =

> What happens when a guest access the RAS-Error-Record registers?
it will trap to EL2 kvm

> =

> Before we can set HCR_EL2.TERR I think we need to add some minimal emulat=
ion for
> the registers it traps. Most of them should be RAZ/WI, so it should be
> straightforward. (I think KVMs default is to emulate an undef for unknown=
 traps).

if KVM default handling is to emulate an undef for unknown traps, how about=
 we use its default way? because no one access
the ERR RAS register in the guest .

> =

> Eventually we will want to back this with a page of memory that lets
> Qemu/kvmtool configure what the guest can see. (i.e. the emulated machine=
's
> errors for kernel-first handling.)
I think emulate it to an undef for unknown traps can be enough, no one acce=
ss the ERR register in the guest.

> =

> =

> Thanks,
> =

> James
> =

> .
> =



--===============7080739008988866999==--

