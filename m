Content-Type: multipart/mixed; boundary="===============8997858217556362348=="
MIME-Version: 1.0
From: Jeremy Linton <jeremy.linton at arm.com>
Subject: [Devel] [PATCH v2 1/1] ACPI: CPPC: Disable FIE if registers in PCC
 regions
Date: Thu, 28 Jul 2022 17:10:43 -0500
Message-ID: <20220728221043.4161903-2-jeremy.linton@arm.com>
In-Reply-To: 20220728221043.4161903-1-jeremy.linton@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8997858217556362348==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

PCC regions utilize a mailbox to set/retrieve register values used by
the CPPC code. This is fine as long as the operations are
infrequent. With the FIE code enabled though the overhead can range
from 2-11% of system CPU overhead (ex: as measured by top) on Arm
based machines.

So, before enabling FIE assure none of the registers used by
cppc_get_perf_ctrs() are in the PCC region. Furthermore lets also
enable a module parameter which can also disable it at boot or module
reload.

Signed-off-by: Jeremy Linton <jeremy.linton(a)arm.com>
---
 drivers/acpi/cppc_acpi.c       | 41 ++++++++++++++++++++++++++++++++++
 drivers/cpufreq/cppc_cpufreq.c | 19 ++++++++++++----
 include/acpi/cppc_acpi.h       |  5 +++++
 3 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 3c6d4ef87be0..38b881db14c7 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1246,6 +1246,47 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_=
caps *perf_caps)
 }
 EXPORT_SYMBOL_GPL(cppc_get_perf_caps);
 =

+/**
+ * cppc_perf_ctrs_in_pcc - Check if any perf counters are in a PCC region.
+ *
+ * CPPC has flexibility about how counters describing CPU perf are deliver=
ed.
+ * One of the choices is PCC regions, which can have a high access latency=
. This
+ * routine allows callers of cppc_get_perf_ctrs() to know this ahead of ti=
me.
+ *
+ * Return: true if any of the counters are in PCC regions, false otherwise
+ */
+bool cppc_perf_ctrs_in_pcc(void)
+{
+	int cpu;
+
+	for_each_present_cpu(cpu) {
+		struct cpc_register_resource *ref_perf_reg;
+		struct cpc_desc *cpc_desc;
+
+		cpc_desc =3D per_cpu(cpc_desc_ptr, cpu);
+
+		if (CPC_IN_PCC(&cpc_desc->cpc_regs[DELIVERED_CTR]) ||
+		    CPC_IN_PCC(&cpc_desc->cpc_regs[REFERENCE_CTR]) ||
+		    CPC_IN_PCC(&cpc_desc->cpc_regs[CTR_WRAP_TIME]))
+			return true;
+
+
+		ref_perf_reg =3D &cpc_desc->cpc_regs[REFERENCE_PERF];
+
+		/*
+		 * If reference perf register is not supported then we should
+		 * use the nominal perf value
+		 */
+		if (!CPC_SUPPORTED(ref_perf_reg))
+			ref_perf_reg =3D &cpc_desc->cpc_regs[NOMINAL_PERF];
+
+		if (CPC_IN_PCC(ref_perf_reg))
+			return true;
+	}
+	return false;
+}
+EXPORT_SYMBOL_GPL(cppc_perf_ctrs_in_pcc);
+
 /**
  * cppc_get_perf_ctrs - Read a CPU's performance feedback counters.
  * @cpunum: CPU from which to read counters.
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 24eaf0ec344d..ed607e27d6bb 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -63,7 +63,11 @@ static struct cppc_workaround_oem_info wa_info[] =3D {
 =

 static struct cpufreq_driver cppc_cpufreq_driver;
 =

+static bool fie_disabled;
+
 #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
+module_param(fie_disabled, bool, 0444);
+MODULE_PARM_DESC(fie_disabled, "Disable Frequency Invariance Engine (FIE)"=
);
 =

 /* Frequency invariance support */
 struct cppc_freq_invariance {
@@ -158,7 +162,7 @@ static void cppc_cpufreq_cpu_fie_init(struct cpufreq_po=
licy *policy)
 	struct cppc_freq_invariance *cppc_fi;
 	int cpu, ret;
 =

-	if (cppc_cpufreq_driver.get =3D=3D hisi_cppc_cpufreq_get_rate)
+	if (fie_disabled)
 		return;
 =

 	for_each_cpu(cpu, policy->cpus) {
@@ -199,7 +203,7 @@ static void cppc_cpufreq_cpu_fie_exit(struct cpufreq_po=
licy *policy)
 	struct cppc_freq_invariance *cppc_fi;
 	int cpu;
 =

-	if (cppc_cpufreq_driver.get =3D=3D hisi_cppc_cpufreq_get_rate)
+	if (fie_disabled)
 		return;
 =

 	/* policy->cpus will be empty here, use related_cpus instead */
@@ -229,7 +233,12 @@ static void __init cppc_freq_invariance_init(void)
 	};
 	int ret;
 =

-	if (cppc_cpufreq_driver.get =3D=3D hisi_cppc_cpufreq_get_rate)
+	if (cppc_perf_ctrs_in_pcc()) {
+		pr_debug("FIE not enabled on systems with registers in PCC\n");
+		fie_disabled =3D true;
+	}
+
+	if (fie_disabled)
 		return;
 =

 	kworker_fie =3D kthread_create_worker(0, "cppc_fie");
@@ -247,7 +256,7 @@ static void __init cppc_freq_invariance_init(void)
 =

 static void cppc_freq_invariance_exit(void)
 {
-	if (cppc_cpufreq_driver.get =3D=3D hisi_cppc_cpufreq_get_rate)
+	if (fie_disabled)
 		return;
 =

 	kthread_destroy_worker(kworker_fie);
@@ -940,6 +949,8 @@ static void cppc_check_hisi_workaround(void)
 		}
 	}
 =

+	fie_disabled =3D true;
+
 	acpi_put_table(tbl);
 }
 =

diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index d389bab54241..fe6dc3e5a454 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -140,6 +140,7 @@ extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf=
_fb_ctrs *perf_fb_ctrs);
 extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
 extern int cppc_set_enable(int cpu, bool enable);
 extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
+extern bool cppc_perf_ctrs_in_pcc(void);
 extern bool acpi_cpc_valid(void);
 extern bool cppc_allow_fast_switch(void);
 extern int acpi_get_psd_map(unsigned int cpu, struct cppc_cpudata *cpu_dat=
a);
@@ -173,6 +174,10 @@ static inline int cppc_get_perf_caps(int cpu, struct c=
ppc_perf_caps *caps)
 {
 	return -ENOTSUPP;
 }
+static inline bool cppc_perf_ctrs_in_pcc(void)
+{
+	return false;
+}
 static inline bool acpi_cpc_valid(void)
 {
 	return false;
-- =

2.35.3

--===============8997858217556362348==--

