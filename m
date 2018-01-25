Content-Type: multipart/mixed; boundary="===============6912458234672311648=="
MIME-Version: 1.0
From: gengdongjiu <gengdongjiu at huawei.com>
Subject: Re: [Devel] [PATCH v9 6/7] arm64: kvm: Set Virtual SError Exception
 Syndrome for guest
Date: Thu, 25 Jan 2018 16:21:47 +0800
Message-ID: <3f699ce3-a552-0c6c-3425-d45d0d788406@huawei.com>
In-Reply-To: 5A678806.8030108@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6912458234672311648==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,
  thanks for the review.

On 2018/1/24 3:07, James Morse wrote:
> Hi Dongjiu Geng,
> =

> On 06/01/18 16:02, Dongjiu Geng wrote:
>> RAS Extension add a VSESR_EL2 register which can provide
>> the syndrome value reported to software on taking a virtual
>> SError interrupt exception. This patch supports to specify
>> this Syndrome.
>>
>> In the RAS Extensions we can not set all-zero syndrome value
>> for SError, which means 'RAS error: Uncategorized' instead of
>> 'no valid ISS'. So set it to IMPLEMENTATION DEFINED syndrome
>> by default.
>>
>> We also need to support userspace to specify a valid syndrome
>> value, Because in some case, the recovery is driven by userspace.
>> This patch can support that userspace specify it.
>>
>> In the guest/host world switch, restore this value to VSESR_EL2
>> only when HCR_EL2.VSE is set. This value no need to be saved
>> because it is stale vale when guest exit.
> =

> A version of this patch has been queued by Catalin.
yeah, I have seen that.

> =

> Now that the cpufeature bits are queued, I think this can be split up int=
o two
> separate series for v4.16-rc1, one to tackle NOTIFY_SEI and the associated
> plumbing. The second for the KVM 'make SError pending' API.
> =

> =

>> Signed-off-by: Dongjiu Geng <gengdongjiu(a)huawei.com>
>> [Set an impdef ESR for Virtual-SError]
>> Signed-off-by: James Morse <james.morse(a)arm.com>
> =

> I didn't sign-off this patch. If you pick some bits from another version =
and
> want to credit someone else you can 'CC:' them or just mention it in the
> commit-message.

I pick your modification of setting an impdef ESR for Virtual-SError, so ad=
d your name,
I change it to 'CC'

> =

> =

>> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sy=
sreg.h
>> index 47b967d..3b035cc 100644
>> --- a/arch/arm64/include/asm/sysreg.h
>> +++ b/arch/arm64/include/asm/sysreg.h
>> @@ -86,6 +86,9 @@
>>  #define REG_PSTATE_PAN_IMM		sys_reg(0, 0, 4, 0, 4)
>>  #define REG_PSTATE_UAO_IMM		sys_reg(0, 0, 4, 0, 3)
>>  =

>> +/* virtual SError exception syndrome register */
>> +#define REG_VSESR_EL2                  sys_reg(3, 4, 5, 2, 3)
> =

> Irrelevant-Nit: sys-regs usually have a 'SYS_' prefix, and are in instruc=
tion
> encoding order lower down the file.
will follow that.

> =

> (These PSTATE PAN things are a bit odd as they were used to generate and
> instruction before the fancy {read,write}_sysreg() helpers were added).>
> =

>>  #define SET_PSTATE_PAN(x) __emit_inst(0xd5000000 | REG_PSTATE_PAN_IMM |=
	\
>>  				      (!!x)<<8 | 0x1f)
>>  #define SET_PSTATE_UAO(x) __emit_inst(0xd5000000 | REG_PSTATE_UAO_IMM |=
	\
>> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
>> index 738ae90..ffad42b 100644
>> --- a/arch/arm64/kvm/guest.c
>> +++ b/arch/arm64/kvm/guest.c
>> @@ -279,7 +279,16 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *=
vcpu,
>>  =

>>  int kvm_arm_set_sei_esr(struct kvm_vcpu *vcpu, u32 *syndrome)
> =

> Bits of this are spread between patches 5 and 6. If you put them in the o=
ther
> order this wouldn't happen.

Ok, I will adjust that.

> =

> (but after a rebase most of this patch should disappear)
> =

>>  {
>> -	return -EINVAL;
>> +	u64 reg =3D *syndrome;
>> +
>> +	/* inject virtual system Error or asynchronous abort */
>> +	kvm_inject_vabt(vcpu);
> =

> So this writes an impdef ESR, because its the existing code-path in KVM.
> =

> =

>> +	if (reg)
>> +		/* set vsesr_el2[24:0] with value that user space specified */
>> +		kvm_vcpu_set_vsesr(vcpu, reg & ESR_ELx_ISS_MASK);
> =

> And then you overwrite it. Which is a bit odd as there is a helper to do =
both in
> one go:
thanks, I will directly call pend_guest_serror() in this function.

> =

> =

>> +
>> +	return 0;
>>  }
> =

>>  int __attribute_const__ kvm_target_cpu(void)
> =

>> diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault=
.c
>> index 3556715..fb94b5e 100644
>> --- a/arch/arm64/kvm/inject_fault.c
>> +++ b/arch/arm64/kvm/inject_fault.c
>> @@ -246,14 +246,25 @@ void kvm_inject_undefined(struct kvm_vcpu *vcpu)
>>  		inject_undef64(vcpu);
>>  }
>>  =

>> +static void pend_guest_serror(struct kvm_vcpu *vcpu, u64 esr)
>> +{
>> +	kvm_vcpu_set_vsesr(vcpu, esr);
>> +	vcpu_set_hcr(vcpu, vcpu_get_hcr(vcpu) | HCR_VSE);
>> +}
> =

> How come you don't use this in kvm_arm_set_sei_esr()?
thanks, I will call pend_guest_serror() in the kvm_arm_set_sei_esr().

> =

> =

> =

> Thanks,
> =

> James
> =

> .
> =



--===============6912458234672311648==--

