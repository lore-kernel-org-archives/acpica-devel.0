Content-Type: multipart/mixed; boundary="===============1412543896912571329=="
MIME-Version: 1.0
From: Dongjiu Geng <gengdongjiu at huawei.com>
Subject: [Devel] [PATCH v8 2/7] KVM: arm64: Save ESR_EL2 on guest SError
Date: Sat, 11 Nov 2017 03:54:05 +0800
Message-ID: <1510343650-23659-3-git-send-email-gengdongjiu@huawei.com>
In-Reply-To: 1510343650-23659-1-git-send-email-gengdongjiu@huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1412543896912571329==
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
Signed-off-by: Dongjiu Geng <gengdongjiu(a)huawei.com>
---
 arch/arm64/kvm/hyp/switch.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index 945e79c..c6f17c7 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -226,13 +226,20 @@ static bool __hyp_text __translate_far_to_hpfar(u64 f=
ar, u64 *hpfar)
 	return true;
 }
 =

+static void __hyp_text __populate_fault_info_esr(struct kvm_vcpu *vcpu)
+{
+	vcpu->arch.fault.esr_el2 =3D read_sysreg_el2(esr);
+}
+
 static bool __hyp_text __populate_fault_info(struct kvm_vcpu *vcpu)
 {
-	u64 esr =3D read_sysreg_el2(esr);
-	u8 ec =3D ESR_ELx_EC(esr);
+	u8 ec;
+	u64 esr;
 	u64 hpfar, far;
 =

-	vcpu->arch.fault.esr_el2 =3D esr;
+	__populate_fault_info_esr(vcpu);
+	esr =3D vcpu->arch.fault.esr_el2;
+	ec =3D ESR_ELx_EC(esr);
 =

 	if (ec !=3D ESR_ELx_EC_DABT_LOW && ec !=3D ESR_ELx_EC_IABT_LOW)
 		return true;
@@ -321,6 +328,8 @@ int __hyp_text __kvm_vcpu_run(struct kvm_vcpu *vcpu)
 	 */
 	if (exit_code =3D=3D ARM_EXCEPTION_TRAP && !__populate_fault_info(vcpu))
 		goto again;
+	else if (ARM_EXCEPTION_CODE(exit_code) =3D=3D ARM_EXCEPTION_EL1_SERROR)
+		__populate_fault_info_esr(vcpu);
 =

 	if (static_branch_unlikely(&vgic_v2_cpuif_trap) &&
 	    exit_code =3D=3D ARM_EXCEPTION_TRAP) {
-- =

1.9.1


--===============1412543896912571329==--

