Content-Type: multipart/mixed; boundary="===============3476166630535362305=="
MIME-Version: 1.0
From: Dongjiu Geng <gengdongjiu at huawei.com>
Subject: [Devel] [PATCH v9 2/7] KVM: arm64: Save ESR_EL2 on guest SError
Date: Sun, 07 Jan 2018 00:02:52 +0800
Message-ID: <1515254577-6460-3-git-send-email-gengdongjiu@huawei.com>
In-Reply-To: 1515254577-6460-1-git-send-email-gengdongjiu@huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3476166630535362305==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: James Morse <james.morse(a)arm.com>

When we exit a guest due to an SError the vcpu fault info isn't updated
with the ESR. Today this is only done for traps.

The v8.2 RAS Extensions define ISS values for SError. Update the vcpu's
fault_info with the ESR on SError so that handle_exit() can determine
if this was a RAS SError and decode its severity.

Signed-off-by: James Morse <james.morse(a)arm.com>
---
 arch/arm64/kvm/hyp/switch.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index 945e79c..fb5a538 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -228,11 +228,12 @@ static bool __hyp_text __translate_far_to_hpfar(u64 f=
ar, u64 *hpfar)
 =

 static bool __hyp_text __populate_fault_info(struct kvm_vcpu *vcpu)
 {
-	u64 esr =3D read_sysreg_el2(esr);
-	u8 ec =3D ESR_ELx_EC(esr);
+	u8 ec;
+	u64 esr;
 	u64 hpfar, far;
 =

-	vcpu->arch.fault.esr_el2 =3D esr;
+	esr =3D vcpu->arch.fault.esr_el2;
+	ec =3D ESR_ELx_EC(esr);
 =

 	if (ec !=3D ESR_ELx_EC_DABT_LOW && ec !=3D ESR_ELx_EC_IABT_LOW)
 		return true;
@@ -313,6 +314,8 @@ int __hyp_text __kvm_vcpu_run(struct kvm_vcpu *vcpu)
 	exit_code =3D __guest_enter(vcpu, host_ctxt);
 	/* And we're baaack! */
 =

+	if (ARM_EXCEPTION_CODE(exit_code) !=3D ARM_EXCEPTION_IRQ)
+		vcpu->arch.fault.esr_el2 =3D read_sysreg_el2(esr);
 	/*
 	 * We're using the raw exception code in order to only process
 	 * the trap if no SError is pending. We will come back to the
-- =

1.9.1


--===============3476166630535362305==--

