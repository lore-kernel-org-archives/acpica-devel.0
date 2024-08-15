Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD473214
	for <acpica-devel@lists.linux.dev>; Thu, 15 Aug 2024 08:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723710587; cv=none; b=aPqKPzabX73SmKJ52bvHJmdHKNYfx50GnBf9TvOVhO8DT56lU34aY9vw1rGmAw7+VY/gmp6BukUPvhyPz1tPa727zZf1rTZZTXiQsC1Io1SYs+NkQdJgueq/bndWfl2T233Ax0vFmnCs7dXuM56Uss73FsvWucdznLpDi8D4ZlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723710587; c=relaxed/simple;
	bh=usUJ+ZMdAJKFpHqU9vw+q8ZPHOCj/YT/Au10Vbbq66A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dshsgD6/GY2OpvsqTNdli15UF1ashXKWlk+98kTRq4kenFAWsftEoA+A+Qrcmj0OjeBq+ilFpxX3TO7+/E/Ee8jGDRmLTv+Tbm+ahuJkYtMmvbfJA4X7HsJPB7HZTN4UiEAZTTowJyNxaLeE7O0OoA7jilEQFJMZBP6+YSxbVdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97929169E;
	Thu, 15 Aug 2024 01:30:10 -0700 (PDT)
Received: from e126645.nice.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 706C33F6A8;
	Thu, 15 Aug 2024 01:29:39 -0700 (PDT)
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
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Thomas Bertschinger <tahbertschinger@gmail.com>,
	linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	rust-for-linux@vger.kernel.org
Subject: [RFC PATCH 0/6] rust: cpufreq: Add cppc_cpufreq driver implementation
Date: Thu, 15 Aug 2024 10:29:04 +0200
Message-Id: <20240815082916.1210110-1-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,
This patchset is based on Viresh's Rust cpufreq patchset [1] and
implements a basic cppc cpufreq driver in Rust. The following features/
possibilities are not supported yet:
- vendor specific workarounds
- Frequency Invariance Engine (FIE)
- artificial Energy Model (EM)
- (struct cpufreq_driver).attr field
- QoS requests

Testing:
The patchset was tested on a CPPC based Juno-r2 platform. It was
checked that the underlying firmware received the freq. requests
the OS made.
The platform doesn't support Delivered/Reference Performance Counters
which are used to infer the current frequency of a perf. domain. The
.get() function of the driver was thus implemented, but bypassed
during testing.

[1]
Can be found at:
- git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/linux.git rust/cpufreq-dt
- latest commit: 2b6d636d1c7db3b21198105ad3ed5f458f027637
  ("defconfig: Update Rust and initramfs")
- Latest version is available at:
  - https://lore.kernel.org/lkml/cover.1722334569.git.viresh.kumar@linaro.org/

Pierre Gondois (6):
  ACPI: CPPC: Move struct cppc_cpudata to cppc_cpufreq driver
  cpufreq: cppc: Remove perf_fb_ctrs field from struct cppc_cpudata
  rust: module: Allow modules to specify initcall section
  rust: cpufreq: Add methods to struct Cpufreq
  rust: bindings: Add bindings for rcppc_cpufreq driver
  rust: cpufreq: Add rust implementation of cppc_cpufreq driver

 drivers/acpi/cppc_acpi.c         |  26 ++-
 drivers/cpufreq/Kconfig          |  16 ++
 drivers/cpufreq/Makefile         |   1 +
 drivers/cpufreq/cppc_cpufreq.c   |  12 +-
 drivers/cpufreq/rcppc_cpufreq.rs | 333 +++++++++++++++++++++++++++++++
 include/acpi/cppc_acpi.h         |  13 +-
 rust/bindings/bindings_helper.h  |   1 +
 rust/helpers.c                   |   6 +
 rust/kernel/cpufreq.rs           |  53 +++++
 rust/macros/module.rs            |  21 +-
 10 files changed, 457 insertions(+), 25 deletions(-)
 create mode 100644 drivers/cpufreq/rcppc_cpufreq.rs

-- 
2.25.1

