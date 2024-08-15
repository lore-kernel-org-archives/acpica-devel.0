Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D60176ADE
	for <acpica-devel@lists.linux.dev>; Thu, 15 Aug 2024 08:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723710611; cv=none; b=hr5ejJl3H+3EwEZhJp8K2SbXhQp54gxZAqNudQ8J8HYxWJX/nf/SkB4waXLIPPsYcFp30Cn1jV4u5piZ5QiTn87VrH6b8bgFZ/0yNrZAYA11ckMmMQJa+vWxbFZnwuP84g+F9buZMTLSzFQci1VgiWemtXHA3iVadiG1s/JCBtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723710611; c=relaxed/simple;
	bh=IK2m7aY43gBFQ3nrhXyqf1FDZA/bFXXuKuTGjetWlok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ErVOvjZXVTYxUeFLHYL7bgFpWHOu3eSKzDzdNYnd0fKVZ1Bz2YlVm0GLwRKcslm2IqUYFztS8sVm1SIoWi9C3CM97vLLAPl1fBycmWXCvttCzMZt2i/QG2QnEyf660YPk403VT3xei3NgNqJFnky7KwPCYh8L/+CjeRWL+bHwkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3D3C16F2;
	Thu, 15 Aug 2024 01:30:34 -0700 (PDT)
Received: from e126645.nice.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0BDA23F6A8;
	Thu, 15 Aug 2024 01:30:03 -0700 (PDT)
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Pierre Gondois <pierre.gondois@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Robert Moore <robert.moore@intel.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Asahi Lina <lina@asahilina.net>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Danilo Krummrich <dakr@redhat.com>,
	Thomas Bertschinger <tahbertschinger@gmail.com>,
	linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	rust-for-linux@vger.kernel.org
Subject: [RFC PATCH 2/6] cpufreq: cppc: Remove perf_fb_ctrs field from struct cppc_cpudata
Date: Thu, 15 Aug 2024 10:29:06 +0200
Message-Id: <20240815082916.1210110-3-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240815082916.1210110-1-pierre.gondois@arm.com>
References: <20240815082916.1210110-1-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the perf_fb_ctrs field from `struct cppc_cpudata` as it
was never used.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 208d7b176fd0..632f2caebbb5 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -31,7 +31,6 @@ struct cppc_cpudata {
 	struct list_head node;
 	struct cppc_perf_caps perf_caps;
 	struct cppc_perf_ctrls perf_ctrls;
-	struct cppc_perf_fb_ctrs perf_fb_ctrs;
 	unsigned int shared_type;
 	cpumask_var_t shared_cpu_map;
 };
-- 
2.25.1

