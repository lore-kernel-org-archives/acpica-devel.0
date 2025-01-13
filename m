Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F330222A4DA
	for <acpica-devel@lists.linux.dev>; Mon, 13 Jan 2025 12:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736770873; cv=none; b=h4xMtKpPV+vPWs0bBkSnC9hW4U+IrcBo6SdBBgF6xixh6U6dXR4TsyAuFWv8SOfnjhu3oWd6Ac//w/6aX7KvCv7Xw2tg4xwa1FHDtnrIn9I4k0eq6sM2e0s7zK9oG8UQJqL5Y4eNME5xn0yp7Yi1GpKhgQYcwUgT8DlVGxb2KLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736770873; c=relaxed/simple;
	bh=riDYKMDT3rQAOS0FqVcuDrii6rQKYOQ4q6cN+kTpRL0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YcI0MLFoRKvMasJg+qfPxLrkxYZoe/nk0zS5CwDmAXTXrtUNHRr/gfLSAjmKZlm2w5y8qhf9P9DT591hS5nPUie/VAlqNqG4c3f4yvx1/xOZaQDgBFkggGy/5l6qyxRMQJSO8+NqCxRENoUda2/cBXIuQr4fJ1/tnqDsrq6KC2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4YWrr81cZhz1V4jx;
	Mon, 13 Jan 2025 20:18:00 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 941DC1401F4;
	Mon, 13 Jan 2025 20:21:08 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 13 Jan 2025 20:21:07 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <robert.moore@intel.com>,
	<viresh.kumar@linaro.org>, <mario.limonciello@amd.com>,
	<gautham.shenoy@amd.com>, <ray.huang@amd.com>, <pierre.gondois@arm.com>
CC: <acpica-devel@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <zhenglifeng1@huawei.com>,
	<hepeng68@huawei.com>, <fanghao11@huawei.com>
Subject: [PATCH v4 3/6] ACPI: CPPC: Add macros to generally implement registers getting and setting functions
Date: Mon, 13 Jan 2025 20:21:01 +0800
Message-ID: <20250113122104.3870673-4-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250113122104.3870673-1-zhenglifeng1@huawei.com>
References: <20250113122104.3870673-1-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh100008.china.huawei.com (7.202.181.93)

Add CPPC_REG_VAL_READ() to implement registers getting functions.

Add CPPC_REG_VAL_WRITE() to implement registers setting functions.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/acpi/cppc_acpi.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 571f94855dce..6326a1536cda 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1279,6 +1279,20 @@ static int cppc_set_reg_val(int cpu, enum cppc_regs reg_idx, u64 val)
 	return cpc_write(cpu, reg, val);
 }
 
+#define CPPC_REG_VAL_READ(reg_name, reg_idx)		\
+int cppc_get_##reg_name(int cpu, u64 *val)		\
+{							\
+	return cppc_get_reg_val(cpu, reg_idx, val);	\
+}							\
+EXPORT_SYMBOL_GPL(cppc_get_##reg_name)
+
+#define CPPC_REG_VAL_WRITE(reg_name, reg_idx)		\
+int cppc_set_##reg_name(int cpu, u64 val)		\
+{							\
+	return cppc_set_reg_val(cpu, reg_idx, val);	\
+}							\
+EXPORT_SYMBOL_GPL(cppc_set_##reg_name)
+
 /**
  * cppc_get_desired_perf - Get the desired performance register value.
  * @cpunum: CPU from which to get desired performance.
-- 
2.33.0

