Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=52.101.52.26
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793993663;
	b=Spn1a9IVdVuTRI73lG7KRkCVAgMSrQ7Ea/H6pkGseJQC1qmVnD2rFDxTq4mF6LmcxxW9
	 eXnBnToddhvVz8yafDrRgAzj7A64KZHahKH9iES8kl1J+uBbg9Isb3LREyWXvTWQdm3LA
	 Twkv4Spe9rAIEbK+x0OycZeJivDMNvKB6gXYd2D/5a/al1BCBw8QFU1zEAPFmwNhPYtPP
	 epPiu5z4kYNwD9USNv76FHEtSXwZ0mbebcd0SjbSqENOAKYq+8lZyouiewNlT0VDaTady
	 JXyIOW+Vsov2nn/rr1zZVKGoXZvvp7k/ky7ZSfhm2Er67cabuX7to6f5nQGofHTEkWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793993663;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
	 Content-Transfer-Encoding:Content-Type:X-NV-OnPremToCloud:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=4tMY8tcjIDN4eh5740t+dWWAVz4MP/FT0/QswfYgapk=;
	b=ZFwkK7WHDhz92wRLNdR4ksxq8rOFNs4pudfclJTEmA25jNjeq6wxpSwKYREOjokx5PJW
	 swjKbHlorwI96wL3JoIVC5fkDEfqKq6q8c/DPhz6tGS8aspkggkFAtVidKMcmjgC/YMm6
	 AzawpyM5UYaZ5tpZU4k6+mrhMDSEn4BWOyXfeZsgsqHLRYiy8ZnuAbQDgS/RU/lGeQqBU
	 /xjv5+slBak7z4d7TMhEtZXWmnLBfxhsmXTXKTTHHg3WAtio4SPKQAxk6O/ujJcJzJ8oU
	 QBCR3YZMiX2RZJg3Wo5HbCC9ocje5b7g/EOmtThldvkgrPKC7U88/hnRijsK8zwiLgg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hA6F66PT;
	arc=fail smtp.remote-ip=52.101.52.26
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011026.outbound.protection.outlook.com [52.101.52.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B304606A336
	for <acpica-devel@lists.linux.dev>; Fri,  6 Nov 2026 19:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B304606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hA6F66PT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cSJaG/4oGwRi4VO+2MMapjVB7ci5UpWShQbuvrc79dh57Q3xswQImuWyKWn3VNVS2gpqeDkaSqTFbkoW59IsRfIyqp/VCIpM0oZMsX37Ehu0svVY7IO2wIZMbLiBsON38Nz3abJSk2cNoY9iZwY0nGCe8UABvIU9IhIfNR1tadr4XbFmzy8k99T1qfdHzop/O46vxVOZcS9HE6cJnvvei/9dsYl3FXGPJYgZttHnWoo334ySdAV/bK1niTqS9BpTSiYDKDmSrEZ5ua+m2nWQySSV2adprvdHGlr5aNo2crFe39lSEOVLBYFHVV1hw7/+/9T4dUwWQhi/K4FOhNQYvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4tMY8tcjIDN4eh5740t+dWWAVz4MP/FT0/QswfYgapk=;
 b=xYe4WgBaiKfxYcGJXlRZYTTb2R+Caj5kqLxLaP7hLJPdqBWjqKvi+zF3dYBWExmcjHxa91SLqawGhie2dpqNugXqLoB9E40l9udUma+pQymQZmmRdNFnLs9Q3XiCkF8ab4A44RY3mXIz1LqRQGRoky+3DqUnsXLAiEj2a3OKMHPm6eQclwPkF65jnvFR6YGNfFvRAiRsmxgeVyKyXFK1xhQc2y/ywrfe0v6JzcoTdMYT0CrD39ETVQkm6nX3bII2nZz37kkgx7b9Dudt8eyTPHlN+GMfEM1v+Ta6/1X0DoJgG5n1po8SQFeM1ZZIA78T4DJTAphPwPtp1bg7xUjeuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tMY8tcjIDN4eh5740t+dWWAVz4MP/FT0/QswfYgapk=;
 b=hA6F66PTX5y5nko8F0A8QdF7KhIRPUf2Fjhp9g7xZarOymTEFYXocEHRfZGXtnIGFU27VRs3W8se49fy4mQBkJUz8AJahE8dFc2QXumWDrD/Ph57MT+OBroiuUlcBzrsgTakv8avzdEkalNHsQIkAnLvNPQfdp5PzIi78cm348z6jVVG664dMGiC/z4oWSdTqxElqlV94WV8kxOgJn5qKZXU6EfkSnkgH/FRVXMmM4uX7GWk8F8hAZDm1B1NKV/NKGttXHlobKOwKVZUmXN9JNYnpV/M3qkIJfb8RxgYJATl1j/Xz17q0NojxQBe1D2h7yoGZxruYXsakCzoA+DRRg==
Received: from CH5P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::26)
 by MN2PR12MB4272.namprd12.prod.outlook.com (2603:10b6:208:1de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 19:34:17 +0000
Received: from BN5PEPF0004698A.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::af) by CH5P222CA0011.outlook.office365.com
 (2603:10b6:610:1ee::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 19:34:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN5PEPF0004698A.mail.protection.outlook.com (10.167.245.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 19:34:16 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 6 Nov
 2026 11:33:56 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 11:33:55 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Fri, 6 Nov 2026 11:33:49 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<christian.loehle@arm.com>, <ionela.voinescu@arm.com>,
	<zhenglifeng1@huawei.com>, <zhanjie9@hisilicon.com>, <lenb@kernel.org>,
	<ray.huang@amd.com>, <mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<kprateek.nayak@amd.com>, <maciej.wieczor-retman@intel.com>,
	<pawel.chmielewski@intel.com>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <mochs@nvidia.com>,
	<bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v9 3/8] ACPI: CPPC: Make autonomous selection helpers take a u64
Date: Sat, 7 Nov 2026 01:02:59 +0530
Message-ID: <20261106193304.3347374-4-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261106193304.3347374-1-sumitg@nvidia.com>
References: <20261106193304.3347374-1-sumitg@nvidia.com>
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Post: <mailto:acpica-devel@lists.linux.dev>
List-Help: <mailto:acpica-devel+help@lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:acpica-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PEPF0004698A:EE_|MN2PR12MB4272:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ffe3cd8-aed6-463f-85b1-08df3c3cf238
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|7416014|82310400026|36860700016|921020|261009221227099003|11063799006|56012099006|261021121427099003|261021123027099003|261022113327099003|261022105027099003|261009223027099003|261022075727099003|261028144727099003|261102130727099003|261102123227099003|261026121527099003|261026140227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	ifY9a/Qqi3GPqz5AXlyDoANhcR8vlshro2BYkbKYRYuzCPMeFepQ+lGErubtTNFGKX4aBQFpL2k3OaQ5hEqlqAOfp2sxr3LjrNlPlcv011rbxPl2AmkhszpNVSdJJX2vi7u2gXDXCPbgE7nqdOcQVPzxG3HhWt8yfXZJG/K3fAnGTB+po8glA2gcXTLd97ilAp9mrwAj1PkEYbnKZs4zRxip4BsS7QvbBDwSRnp1/70U2WICOCUcLagbQDYj20IxbLWGmy4orZUIUFG8EfrQ0qjHgXlkGj1Swt2gp2cmXCg6kWv/v6dm8P4a2CYURvAEk/rbFXuSjdJ/Fdb9zH9tF4zRAMGSiQHvl3ztBmsjQJ5DTKbLKK5LvHjskxWOafdG2aE4PwhwJytd2bX8ltqWX+leoOuReUGnxf9uujriEPwaMVC9SyDhabmI+YTfh5P6SMFDTO1j1pFqUYDDZuJLTDnp4r2h12dha0YZeQ7e62ijSeDXbhpAM/2VemZhUY9jphM2H3o/5ZKNrBWTPOjL6zJ9CSMIRsjqg2hY1Z5B1/gNY5jDOS3uGfS6JQZz4uxrriJTK7kpnS3i1R4FnX3f42CF2AVDHKovRHWs1tEu5coQZwE0V6Wv9IJqio28Rp6gj2/DK15n2SVWgC4vCtjZxhWIGuRxm1GAPAEKTzvDfEZ+cl75USwJhH2ZhF9bZ8zT0KqJjUeUY8pPCmvjr0sKQJZbzQ/9WP8286Tnoh+NpM41O+Sk4hzqYeRxq8SjE3iK
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(7416014)(82310400026)(36860700016)(921020)(261009221227099003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261022113327099003)(261022105027099003)(261009223027099003)(261022075727099003)(261028144727099003)(261102130727099003)(261102123227099003)(261026121527099003)(261026140227099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Y1JLha2ao2NYQ66gNy1DsH3NCrcCgt6u2/abIk4VJk2xqmmG5dOyIKPO3xtciY7BZN4FFpy56KRslm78bbRcvl/Bbg0OutH9+2R7ruAymEX+Lvtl47CdVBNRByQKrzJBaX+yvHhZHcr9Wt/X8eNn3kO8Np3JyLUQqXlhyFdsPIw5GLirrYUqeWPUCfr8RGEnEdkM9BHb+mK6S+1g6HXQKhgnnidQnw0uP4xGV+4AVeZNk2JvJzYKhk+C0/Y3Yq1hIERepDJaJKGUhSB2+xt8tOWYdnSkk4MDdXr5ufWnUmvru5WGf7m8R4c5EQlOuin+qR6ThPePymmmSwH/lnGyUMJOEol9fdXu0KFuRnQ0shkSBjR3Dp+My7qP9fVOaBtAgch5JAh1a1mmtQ0vRdrUDmqx6av6NuVmEJurirAjd/XNjDtSr9bXWI99jFsTMQBM
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 19:34:16.7597
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ffe3cd8-aed6-463f-85b1-08df3c3cf238
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN5PEPF0004698A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4272

cppc_get_auto_sel()/cppc_set_auto_sel() use a bool, unlike the other
CPPC register get/set helpers which use a u64.

The next patch in this series saves and restores the OSPM-set registers
across CPU hotplug and driver unload through a common table of register
get/set helpers that all take a u64. The bool autonomous selection
helpers cannot be added to that table.

Change cppc_get_auto_sel()/cppc_set_auto_sel() to take a u64 so the
autonomous selection register fits alongside the others, and update
their callers.

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Tested-by: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/acpi/cppc_acpi.c       | 20 ++++----------------
 drivers/cpufreq/amd-pstate.c   |  2 +-
 drivers/cpufreq/cppc_cpufreq.c |  4 ++--
 include/acpi/cppc_acpi.h       |  8 ++++----
 4 files changed, 11 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index f49c6152a013..5a1f84fddb7f 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -3304,23 +3304,11 @@ EXPORT_SYMBOL_GPL(cppc_set_auto_act_window);
 /**
  * cppc_get_auto_sel() - Read autonomous selection register.
  * @cpu: CPU from which to read register.
- * @enable: Return address.
+ * @enable: Return address, set to 0 or 1.
  */
-int cppc_get_auto_sel(int cpu, bool *enable)
+int cppc_get_auto_sel(int cpu, u64 *enable)
 {
-	u64 auto_sel;
-	int ret;
-
-	if (enable == NULL)
-		return -EINVAL;
-
-	ret = cppc_get_reg_val(cpu, AUTO_SEL_ENABLE, &auto_sel);
-	if (ret)
-		return ret;
-
-	*enable = (bool)auto_sel;
-
-	return 0;
+	return cppc_get_reg_val(cpu, AUTO_SEL_ENABLE, enable);
 }
 EXPORT_SYMBOL_GPL(cppc_get_auto_sel);
 
@@ -3351,7 +3339,7 @@ EXPORT_SYMBOL_GPL(cppc_auto_sel_is_immutable);
  * @cpu    : CPU to which to write register.
  * @enable : the desired value of autonomous selection resiter to be updated.
  */
-int cppc_set_auto_sel(int cpu, bool enable)
+int cppc_set_auto_sel(int cpu, u64 enable)
 {
 	return cppc_set_reg_val(cpu, AUTO_SEL_ENABLE, enable);
 }
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 4bedfbfc18b6..bf7d25e89d2a 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -546,7 +546,7 @@ static int shmem_init_perf(struct amd_cpudata *cpudata)
 	struct cppc_perf_caps cppc_perf;
 	union perf_cached perf = READ_ONCE(cpudata->perf);
 	u64 numerator;
-	bool auto_sel;
+	u64 auto_sel;
 
 	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
 	if (ret)
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 2cf250b38633..3f7d740e04af 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -1033,7 +1033,7 @@ static ssize_t show_freqdomain_cpus(struct cpufreq_policy *policy, char *buf)
 
 static ssize_t show_auto_select(struct cpufreq_policy *policy, char *buf)
 {
-	bool val;
+	u64 val;
 	int ret;
 
 	ret = cppc_get_auto_sel(policy->cpu, &val);
@@ -1045,7 +1045,7 @@ static ssize_t show_auto_select(struct cpufreq_policy *policy, char *buf)
 	if (ret)
 		return ret;
 
-	return sysfs_emit(buf, "%d\n", val);
+	return sysfs_emit(buf, "%llu\n", val);
 }
 
 static ssize_t store_auto_select(struct cpufreq_policy *policy,
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 4495ee4ab71e..a5545fd3f8bd 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -197,9 +197,9 @@ extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool e
 extern int cppc_set_epp(int cpu, u64 epp_val);
 extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
 extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
-extern int cppc_get_auto_sel(int cpu, bool *enable);
+extern int cppc_get_auto_sel(int cpu, u64 *enable);
 bool cppc_auto_sel_is_immutable(int cpu);
-extern int cppc_set_auto_sel(int cpu, bool enable);
+extern int cppc_set_auto_sel(int cpu, u64 enable);
 extern int cppc_get_perf_limited(int cpu, u64 *perf_limited);
 extern int cppc_set_perf_limited(int cpu, u64 bits_to_clear);
 extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
@@ -298,7 +298,7 @@ static inline int cppc_set_auto_act_window(int cpu, u64 auto_act_window)
 {
 	return -EOPNOTSUPP;
 }
-static inline int cppc_get_auto_sel(int cpu, bool *enable)
+static inline int cppc_get_auto_sel(int cpu, u64 *enable)
 {
 	return -EOPNOTSUPP;
 }
@@ -308,7 +308,7 @@ static inline bool cppc_auto_sel_is_immutable(int cpu)
 	return false;
 }
 
-static inline int cppc_set_auto_sel(int cpu, bool enable)
+static inline int cppc_set_auto_sel(int cpu, u64 enable)
 {
 	return -EOPNOTSUPP;
 }
-- 
2.34.1

