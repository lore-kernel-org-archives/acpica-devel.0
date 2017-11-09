Content-Type: multipart/mixed; boundary="===============4168967123677312819=="
MIME-Version: 1.0
From: Jeremy Linton <jeremy.linton at arm.com>
Subject: [Devel] [PATCH v4 7/9] arm64: Topology, rename cluster_id
Date: Thu, 09 Nov 2017 15:03:09 -0600
Message-ID: <20171109210311.25655-8-jeremy.linton@arm.com>
In-Reply-To: 20171109210311.25655-1-jeremy.linton@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4168967123677312819==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Lets match the name of the arm64 topology field
to the kernel macro that uses it.

Signed-off-by: Jeremy Linton <jeremy.linton(a)arm.com>
---
 arch/arm64/include/asm/topology.h |  4 ++--
 arch/arm64/kernel/topology.c      | 27 ++++++++++++++-------------
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/top=
ology.h
index 8b57339823e9..53c3b2c7c35c 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -6,14 +6,14 @@
 struct cpu_topology {
 	int thread_id;
 	int core_id;
-	int cluster_id;
+	int physical_id;
 	cpumask_t thread_sibling;
 	cpumask_t core_sibling;
 };
 =

 extern struct cpu_topology cpu_topology[NR_CPUS];
 =

-#define topology_physical_package_id(cpu)	(cpu_topology[cpu].cluster_id)
+#define topology_physical_package_id(cpu)	(cpu_topology[cpu].physical_id)
 #define topology_core_id(cpu)		(cpu_topology[cpu].core_id)
 #define topology_core_cpumask(cpu)	(&cpu_topology[cpu].core_sibling)
 #define topology_sibling_cpumask(cpu)	(&cpu_topology[cpu].thread_sibling)
diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 8d48b233e6ce..74a8a5173a35 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -51,7 +51,7 @@ static int __init get_cpu_for_node(struct device_node *no=
de)
 	return -1;
 }
 =

-static int __init parse_core(struct device_node *core, int cluster_id,
+static int __init parse_core(struct device_node *core, int physical_id,
 			     int core_id)
 {
 	char name[10];
@@ -67,7 +67,7 @@ static int __init parse_core(struct device_node *core, in=
t cluster_id,
 			leaf =3D false;
 			cpu =3D get_cpu_for_node(t);
 			if (cpu >=3D 0) {
-				cpu_topology[cpu].cluster_id =3D cluster_id;
+				cpu_topology[cpu].physical_id =3D physical_id;
 				cpu_topology[cpu].core_id =3D core_id;
 				cpu_topology[cpu].thread_id =3D i;
 			} else {
@@ -89,7 +89,7 @@ static int __init parse_core(struct device_node *core, in=
t cluster_id,
 			return -EINVAL;
 		}
 =

-		cpu_topology[cpu].cluster_id =3D cluster_id;
+		cpu_topology[cpu].physical_id =3D physical_id;
 		cpu_topology[cpu].core_id =3D core_id;
 	} else if (leaf) {
 		pr_err("%pOF: Can't get CPU for leaf core\n", core);
@@ -105,7 +105,7 @@ static int __init parse_cluster(struct device_node *clu=
ster, int depth)
 	bool leaf =3D true;
 	bool has_cores =3D false;
 	struct device_node *c;
-	static int cluster_id __initdata;
+	static int physical_id __initdata;
 	int core_id =3D 0;
 	int i, ret;
 =

@@ -144,7 +144,7 @@ static int __init parse_cluster(struct device_node *clu=
ster, int depth)
 			}
 =

 			if (leaf) {
-				ret =3D parse_core(c, cluster_id, core_id++);
+				ret =3D parse_core(c, physical_id, core_id++);
 			} else {
 				pr_err("%pOF: Non-leaf cluster with core %s\n",
 				       cluster, name);
@@ -162,7 +162,7 @@ static int __init parse_cluster(struct device_node *clu=
ster, int depth)
 		pr_warn("%pOF: empty cluster\n", cluster);
 =

 	if (leaf)
-		cluster_id++;
+		physical_id++;
 =

 	return 0;
 }
@@ -198,7 +198,7 @@ static int __init parse_dt_topology(void)
 	 * only mark cores described in the DT as possible.
 	 */
 	for_each_possible_cpu(cpu)
-		if (cpu_topology[cpu].cluster_id =3D=3D -1)
+		if (cpu_topology[cpu].physical_id =3D=3D -1)
 			ret =3D -EINVAL;
 =

 out_map:
@@ -228,7 +228,7 @@ static void update_siblings_masks(unsigned int cpuid)
 	for_each_possible_cpu(cpu) {
 		cpu_topo =3D &cpu_topology[cpu];
 =

-		if (cpuid_topo->cluster_id !=3D cpu_topo->cluster_id)
+		if (cpuid_topo->physical_id !=3D cpu_topo->physical_id)
 			continue;
 =

 		cpumask_set_cpu(cpuid, &cpu_topo->core_sibling);
@@ -249,7 +249,7 @@ void store_cpu_topology(unsigned int cpuid)
 	struct cpu_topology *cpuid_topo =3D &cpu_topology[cpuid];
 	u64 mpidr;
 =

-	if (cpuid_topo->cluster_id !=3D -1)
+	if (cpuid_topo->physical_id !=3D -1)
 		goto topology_populated;
 =

 	mpidr =3D read_cpuid_mpidr();
@@ -263,19 +263,19 @@ void store_cpu_topology(unsigned int cpuid)
 		/* Multiprocessor system : Multi-threads per core */
 		cpuid_topo->thread_id  =3D MPIDR_AFFINITY_LEVEL(mpidr, 0);
 		cpuid_topo->core_id    =3D MPIDR_AFFINITY_LEVEL(mpidr, 1);
-		cpuid_topo->cluster_id =3D MPIDR_AFFINITY_LEVEL(mpidr, 2) |
+		cpuid_topo->physical_id =3D MPIDR_AFFINITY_LEVEL(mpidr, 2) |
 					 MPIDR_AFFINITY_LEVEL(mpidr, 3) << 8;
 	} else {
 		/* Multiprocessor system : Single-thread per core */
 		cpuid_topo->thread_id  =3D -1;
 		cpuid_topo->core_id    =3D MPIDR_AFFINITY_LEVEL(mpidr, 0);
-		cpuid_topo->cluster_id =3D MPIDR_AFFINITY_LEVEL(mpidr, 1) |
+		cpuid_topo->physical_id =3D MPIDR_AFFINITY_LEVEL(mpidr, 1) |
 					 MPIDR_AFFINITY_LEVEL(mpidr, 2) << 8 |
 					 MPIDR_AFFINITY_LEVEL(mpidr, 3) << 16;
 	}
 =

 	pr_debug("CPU%u: cluster %d core %d thread %d mpidr %#016llx\n",
-		 cpuid, cpuid_topo->cluster_id, cpuid_topo->core_id,
+		 cpuid, cpuid_topo->physical_id, cpuid_topo->core_id,
 		 cpuid_topo->thread_id, mpidr);
 =

 topology_populated:
@@ -291,7 +291,7 @@ static void __init reset_cpu_topology(void)
 =

 		cpu_topo->thread_id =3D -1;
 		cpu_topo->core_id =3D 0;
-		cpu_topo->cluster_id =3D -1;
+		cpu_topo->physical_id =3D -1;
 =

 		cpumask_clear(&cpu_topo->core_sibling);
 		cpumask_set_cpu(cpu, &cpu_topo->core_sibling);
@@ -300,6 +300,7 @@ static void __init reset_cpu_topology(void)
 	}
 }
 =

+
 void __init init_cpu_topology(void)
 {
 	reset_cpu_topology();
-- =

2.13.5


--===============4168967123677312819==--

