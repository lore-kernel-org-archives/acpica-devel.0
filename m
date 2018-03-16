Content-Type: multipart/mixed; boundary="===============6806935372494078354=="
MIME-Version: 1.0
From: gengdongjiu <gengdongjiu at huawei.com>
Subject: Re: [Devel] [PATCH v10 1/5] arm64: KVM: Prepare set virtual SEI
 syndrome value
Date: Fri, 16 Mar 2018 15:58:14 +0800
Message-ID: <076069fe-0017-7cb4-8316-4d4d58f9f06b@huawei.com>
In-Reply-To: 5AAAD9A1.6090107@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6806935372494078354==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,
   Thank you very much for this mail and your time to review this patch. Ap=
preciate that.
I will check it and reply.


On 2018/3/16 4:37, James Morse wrote:
> Hi Dongjiu Geng,
> =

> On 03/03/18 16:09, Dongjiu Geng wrote:
>> Export one API to specify virtual SEI syndrome value
>> for guest, and add a helper to get the VSESR_EL2 value.
> =

> This patch adds two helpers that nothing calls... its not big, please mer=
ge it
> with the patch that uses these.
> =

> =

>> diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/a=
sm/kvm_emulate.h
>> index 413dc82..3294885 100644
>> --- a/arch/arm64/include/asm/kvm_emulate.h
>> +++ b/arch/arm64/include/asm/kvm_emulate.h
>> @@ -71,6 +71,11 @@ static inline void vcpu_set_hcr(struct kvm_vcpu *vcpu=
, unsigned long hcr)
>>  	vcpu->arch.hcr_el2 =3D hcr;
>>  }
>>  =

>> +static inline unsigned long vcpu_get_vsesr(struct kvm_vcpu *vcpu)
>> +{
>> +	return vcpu->arch.vsesr_el2;
>> +}
>> +
>>  static inline void vcpu_set_vsesr(struct kvm_vcpu *vcpu, u64 vsesr)
>>  {
>>  	vcpu->arch.vsesr_el2 =3D vsesr;
>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/=
kvm_host.h
>> index a73f63a..3dc49b7 100644
>> --- a/arch/arm64/include/asm/kvm_host.h
>> +++ b/arch/arm64/include/asm/kvm_host.h
>> @@ -354,6 +354,8 @@ void handle_exit_early(struct kvm_vcpu *vcpu, struct=
 kvm_run *run,
>>  int kvm_perf_init(void);
>>  int kvm_perf_teardown(void);
>>  =

>> +void kvm_set_sei_esr(struct kvm_vcpu *vcpu, u64 syndrome);
>> +
>>  struct kvm_vcpu *kvm_mpidr_to_vcpu(struct kvm *kvm, unsigned long mpidr=
);
>>  =

>>  static inline void __cpu_init_hyp_mode(phys_addr_t pgd_ptr,
>> diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault=
.c
>> index 60666a0..78ecb28 100644
>> --- a/arch/arm64/kvm/inject_fault.c
>> +++ b/arch/arm64/kvm/inject_fault.c
>> @@ -186,3 +186,8 @@ void kvm_inject_vabt(struct kvm_vcpu *vcpu)
>>  {
>>  	pend_guest_serror(vcpu, ESR_ELx_ISV);
>>  }
>> +
>> +void kvm_set_sei_esr(struct kvm_vcpu *vcpu, u64 syndrome)
>> +{
>> +	pend_guest_serror(vcpu, syndrome & ESR_ELx_ISS_MASK);
> =

> If you move the ISS_MASK into pend_guest_serror(), you wouldn't need this=
 at all.
> =

> It would be better if any validation were in the user-space helpers so we=
 can
> check user-space hasn't put something funny in the top bits.
> =

>> +}
>>
> =

> =

> Thanks,
> =

> James
> =

> .
> =



--===============6806935372494078354==--

