Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794387066;
	b=U3g+iCYMV0Fc4BzqGixUc9EFQIm0ZrBRElPotsWMb4s6FvBprzzeDmfhcn9KK+uZm0Ja
	 KzGtM9wfV7mvPeWH5kL/2u2NQFuRbOfNpJYK/4bYyy4RDWRr8ecTQWVED9IPb0uhOnb0y
	 P+n75dvXI7cHTphSrQ06YmmGj5/k59znCowUls3XDMNKb982gYw8FIq2ghjwkbs4KIv2I
	 xl3MjeJzbls6qBQ4lGUIPHNhc0ASJJ5xIOxGKPPSo7wqbF5HyL6oHjTu5DiQ73WIkpFHS
	 Ry0CgLVfq9wLilHWUuXX3KAHuTwfwpJwwIwHiU+OM5TvwDR6EBPv92u3Dh0v/y7hR6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794387066;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=v3JRXipHaQsA2dpbPLLRBQxHUpuSS4w/ATARj/qhSxk=;
	b=BKkSx4DEnJrbuH5xPK4VxYxgDrY/9xV1VjMUr+wUZL73HuBGHVSx3l5QJ52gChpZkySg
	 j43MrhlfhLQGTR978wULJDcrhoL4TzG4SCfccvBdvGJvcVw32voVqfYzFzNlu0sOXbEur
	 SdBzRqKwew/+qaRIIrL2F77nmYOCpp0EF2gphrcO4rVHPPVM0aEiyjo3TTizP6cAuOTNJ
	 ZYjX6VL7zFvXTaXLAJEMG6kU8CFdtdOR2+e36jFsa4M9kVVyjUbhoadqWTZuMra+oAqIM
	 vm4iTWZfbFMem/00aOozjG6tHZQBmmlAWh5PQNyRBP/39PAfRk/5U3EW/8tzBV+v3eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=74.125.227.131
Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9B6606A321
	for <acpica-devel@lists.linux.dev>; Wed, 11 Nov 2026 08:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F9B6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj2-f3.google.com with SMTP id 98e67ed59e1d1-3adc0ac3564so859294a91.1
        for <acpica-devel@lists.linux.dev>; Wed, 11 Nov 2026 00:51:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794387065; x=1794991865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v3JRXipHaQsA2dpbPLLRBQxHUpuSS4w/ATARj/qhSxk=;
        b=hRwdqBkp5ugaxyocS6k8WCaMJ6LoQ3oXfb5bZVYqrfDJre71/gRnC1BkKH8osa0Vho
         It72dnHdwmI8wQHn4spErZxU2pnGocOT/mR6ti9TsxIo4vldn7P4kYXcTeoxZUjuVon3
         RTUyy9fc/RnfQxAY+waUpt72QaTi9P5a5vQODP/ovMjWm5l/Wkpvvrf9sQvvY7SPnISH
         jNJLNGdLBl5wmUCZAopK0ZfkOpJbq9Pm6NLiK/8XTb9nkt/4H4teL+dcROovVP4MofvT
         YhWm6dIbPnytaR6txky14aOxgG6GApuNQoUE07CV4FJMSZ/BlqAqaDtj1jhMoat2YN3Q
         SGxQ==
X-Forwarded-Encrypted: i=1; AL+hErGeRsWwAN6ovqeIOTXw7x7fXxND+by8WqPiYEQr5z2OqdEXbICj91JN4bE7xXG2qB0VtcHlXkSc/ijWYg4=@lists.linux.dev
X-Gm-Message-State: APuU4Z9u1EqKL6I7IMohcWIlkzf/UJGdDYLvtuo+IFqEt7rPgsx8ncoe
	2bH3lTzd4jkKFHlR8xbWjiqC8LyAPkh0YYi/19KvnhzH36XR/Ferz3et
X-Gm-Gg: AYBFou1wFILX0z6xjkj+pYVOQJ9o/J1131qa1kHq40sZZ4e3Gr3jz0BVDGxt+4rHCJx
	tgafNfv0IEEqxCsTXXU4iwuvq0xdeKOeEoDqiGKwgPIqyVuJSFIHKw1CROUJHs/Md53LtYZvIe6
	ENRXUmaU/5vh9lcpxi5n3iChsdR9ZwVWnsHNxgTWiyGJV2vLFpbkYtnBOBCmCdPSflWqC7qNp0b
	p/3JWUd3E7gBY+BSmbXsgkAoNxl3B/a5wLxyoMaEUyCKjc8fwiGykZoIX6pH9GG5F3EQ1xhzDt6
	uYcO7qkgT2jRIFmcXmHQRgKH484OZhD/cgO9cCP8MT4+2f3sqWHTQPZ03LoEMzyfHoDT/cMwoZh
	6uJVcOVr32eggSUY6KB1NGbuX91W9V/fnZQzO7Ux3kP4SPUnIyNjEoexR4u6qxBSJp4Kb+wQ7Ta
	2+kSf/6HEy8QnBZECahPbGVPXrnkdJemNCsn4rzNuvDeV3zHyUaTWEHQcBTTbVfSnWNprx8Ufk1
	l77qqyol5TQF1adxYyDWxWaaXe1tpwmk7MJEkpZlQK6YDF5KT1pxxPRmsgQQ8Fkz+4CgLXW5rJP
	eZkRla74IPt97O+LhLsovI35cOEHAcSXr9WInZXuOqyCT3hWs2o=
X-Received: by 2002:a17:90b:4c4c:b0:3ab:be66:ddb6 with SMTP id 98e67ed59e1d1-3b182eec040mr1437917a91.20.1794387065472;
        Wed, 11 Nov 2026 00:51:05 -0800 (PST)
Received: from kylin-XiaoXinPro-16-AHP9.. ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1838e616dsm2396406a91.4.2026.11.11.00.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 00:51:05 -0800 (PST)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	viresh.kumar@linaro.org,
	sudeep.holla@kernel.org
Cc: zhanjie9@hisilicon.com,
	christian.loehle@arm.com,
	zhenglifeng1@huawei.com,
	sumitg@nvidia.com,
	lenb@kernel.org,
	maciej.wieczor-retman@intel.com,
	pawel.chmielewski@intel.com,
	gregkh@linuxfoundation.org,
	dakr@kernel.org,
	johan@kernel.org,
	ionela.voinescu@arm.com,
	pierre.gondois@arm.com,
	linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	driver-core@lists.linux.dev,
	Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH v6 2/3] cpufreq: cppc: Refactor autonomous perf bounds into helper
Date: Wed, 11 Nov 2026 16:50:21 +0800
Message-ID: <20261111085022.1229866-3-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111085022.1229866-1-luoxueqin@kylinos.cn>
References: <20261111085022.1229866-1-luoxueqin@kylinos.cn>
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Post: <mailto:acpica-devel@lists.linux.dev>
List-Help: <mailto:acpica-devel+help@lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:acpica-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extract the autonomous selection performance bounds programming from
store_auto_select() into a reusable cppc_cpufreq_set_autonomous_perf()
helper. The helper saves and restores MIN/MAX performance on failure,
keeping the rollback logic co-located with the programming sequence.

Reuse the helper in cppc_cpufreq_update_limits() so that when
Highest Performance changes at runtime, the autonomous MIN/MAX
envelope is re-programmed against the updated capability. Add a
pr_debug message on failure for diagnostics.

Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
---
 drivers/cpufreq/cppc_cpufreq.c | 49 +++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 3bca30f5c0d5..7dab6e046b9f 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -868,6 +868,29 @@ static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
 	return 0;
 }
 
+/*
+ * Program the autonomous MIN/MAX_PERF bounds from the current policy
+ * limits, restoring the previous bounds if the write fails.
+ */
+static int cppc_cpufreq_set_autonomous_perf(struct cpufreq_policy *policy)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	u32 old_min_perf = cpu_data->perf_ctrls.min_perf;
+	u32 old_max_perf = cpu_data->perf_ctrls.max_perf;
+	int ret;
+
+	cppc_cpufreq_update_perf_limits(cpu_data, policy);
+
+	ret = cppc_set_perf(policy->cpu, &cpu_data->perf_ctrls);
+	if (ret) {
+		cpu_data->perf_ctrls.min_perf = old_min_perf;
+		cpu_data->perf_ctrls.max_perf = old_max_perf;
+		return ret;
+	}
+
+	return 0;
+}
+
 /*
  * Boost being off is enforced through the boost_freq_req QoS request
  * (capping policy->max) rather than by hiding the hardware maximum in
@@ -961,6 +984,18 @@ static void cppc_cpufreq_update_limits(struct cpufreq_policy *policy)
 
 	refresh_frequency_limits(policy);
 
+	/*
+	 * Autonomous selection mode uses MIN/MAX performance as runtime
+	 * hardware control bounds. Re-program them when highest_perf
+	 * changes so that the platform uses the updated bounds.
+	 */
+	if (cpu_data->perf_ctrls.auto_sel) {
+		ret = cppc_cpufreq_set_autonomous_perf(policy);
+		if (ret)
+			pr_debug("CPU%d: failed to update autonomous perf: %d\n",
+				 policy->cpu, ret);
+	}
+
 	pr_debug("CPU%d: highest_perf updated %llu -> %llu\n",
 		 policy->cpu, prev_highest_perf, highest_perf);
 }
@@ -1008,20 +1043,8 @@ static ssize_t store_auto_select(struct cpufreq_policy *policy,
 	cpu_data->perf_ctrls.auto_sel = val;
 
 	if (val) {
-		u32 old_min_perf = cpu_data->perf_ctrls.min_perf;
-		u32 old_max_perf = cpu_data->perf_ctrls.max_perf;
-
-		/*
-		 * When enabling autonomous selection, program MIN_PERF and
-		 * MAX_PERF from current policy limits so that the platform
-		 * uses the correct performance bounds immediately.
-		 */
-		cppc_cpufreq_update_perf_limits(cpu_data, policy);
-
-		ret = cppc_set_perf(policy->cpu, &cpu_data->perf_ctrls);
+		ret = cppc_cpufreq_set_autonomous_perf(policy);
 		if (ret) {
-			cpu_data->perf_ctrls.min_perf = old_min_perf;
-			cpu_data->perf_ctrls.max_perf = old_max_perf;
 			cppc_set_auto_sel(policy->cpu, old_auto_sel);
 			cpu_data->perf_ctrls.auto_sel = old_auto_sel;
 			return ret;
-- 
2.43.0

