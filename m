Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D482EF66D
	for <acpica-devel@lists.linux.dev>; Wed, 16 Jul 2025 09:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752658935; cv=none; b=h22g0n6F6QIW5bhKS75yD5sAbXSyDgHVWq5THhbmMz0K2WP/MoP/NDoMeH4zqXX7rwmePd3gHBi8WrymwL0EqTdoguoXyYdI0U1U6zkJtn/5xtgeQWiAhbyz5vBScIQ0kI5OaqmxatT5m12BIQydMe5yEB2+vgBz2D1xhHqnej0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752658935; c=relaxed/simple;
	bh=VpVP5wDdJUADopR44kBGcroZazLAbCqHn1yQXetBaB0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=vDESS/lpsY4zQ7enG1+s67caiRzewH1U+b3y7Q20tbQOQ68Svjz8D5p0fV0G81sZvrUnonuEG3OSUaGz3kQaN4RI9hIcKKBP8wyp+q7sgyACYkPGHP+VyE2IrWxNM9KCV9+c+pk8pxSwRoOEtFVuxrTjtbU6W4uqtcj9yc+lZwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-60700a745e5so13113711a12.3
        for <acpica-devel@lists.linux.dev>; Wed, 16 Jul 2025 02:42:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752658932; x=1753263732;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MFSywZB5jlv0hgu5XQpZ5VJL9BXcLP8sDIeWcu7IkK8=;
        b=WTYsh9tQ/zrPfCxxa78E4DStfHfNH5/3A5o05xXM3sNMQ3570XYJ7P29z1eM2wliJL
         RNj7nYjkm5+NysQlrtDCpEab4pUVo2b8qqQKyI3RHogcVdxv2EpVq01SJ2TkUBaTrCB6
         dkfOEjn2IxaQSWDSIBGbWMFP8OsnUX42gOz8gLMTMY5dxUJysZbBH56pRAJDePWjF04T
         K1S++iMhZ6vgWe69gDcKhcdchi8K0DnxFQn/aSOUZvRFIVqE/jBkk3D4potGpvexWhvS
         jkZ6FjuxGSk6Kv38RTK+15a36NBPbt2jpYMyYNNrwLOeGFgWJ5Tv2kwpQQb2S1a3Isqj
         Rn8Q==
X-Forwarded-Encrypted: i=1; AJvYcCX10P3qQ0Ww7Hy/vS7/ud6wgPtIaKbakCFS6tksY2aD05An0Qbx7MglEbCE3D9H2G9ieRDh7PNpgwXFfyQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YzVthbkbcZuIS3ccTUa4RyA+3S4T1o5WGYgqBVEzmZCmOI7hklA
	4hFvTyT9uaAvRXZ82Sl7VryBClYtepfDFUMz/PEL+RTIzL9dJeugKWEm
X-Gm-Gg: ASbGncs8YVmqROhXdQ3/GUGMnSV3Hbrz/3a2W2Hu0Unwmc5I30nodr0gRPlpyxuSCjK
	kdfggF5lGpH+xRjW1IsuC1/dP/8izgKOQQ+HqKlsMnIi3LpCfUlrYmjiGmrB0Xn4X7nffHA643i
	dhxsHHkhV1ky19vejcGqAe6m0D3ZEG5PmV0oLCnRqU22bZKfMHtgDHjx357XMRo7c8iRp2SRD2y
	LrLw3rqITfSARnO/xG5Qh1uA+Zh4pde9ySPHdcTAfkBiNju4XgGzu9Pow7qCKzHf6fk3WUg8Gnb
	w5lHKM5MYEgtXPprrqaafogDMUTh/si5mgYmEEMon1ZIlXGGBFhDTHmi4/IZZeVQHdpKZXg3EAg
	fA+EnJsRDFQpk
X-Google-Smtp-Source: AGHT+IGQu+odODYAB1D2AI4zb6eNSRou+CjyiarGYyccEHFqscLgIPqzpZaUfTHzVSOC5ARYzOSqYQ==
X-Received: by 2002:a17:907:894b:b0:ae3:90cc:37b3 with SMTP id a640c23a62f3a-ae9cddddbd9mr201034766b.17.1752658932108;
        Wed, 16 Jul 2025 02:42:12 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e829629dsm1164430966b.138.2025.07.16.02.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 02:42:11 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 16 Jul 2025 02:42:01 -0700
Subject: [PATCH v2] arm64: Mark kernel as tainted on SAE and SError panic
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-vmcore_hw_error-v2-1-f187f7d62aba@debian.org>
X-B4-Tracking: v=1; b=H4sIAOhzd2gC/2XNTQ6CMBBA4as0s6aG/lCUlfcwhEA7wCykZGqqh
 nB3I3Hn9i2+t0FCJkzQiA0YMyWKCzRCFwL83C8TSgrQCNClrsq6rGW++8jYzc8OmSNLo7XVF3T
 eKAeFgJVxpNch3tpCwEzpEfl9DLL61p+l7J+VlVTy7EdbYRicMfYacKB+OUWeoN33/QMX3ZF1r
 wAAAA==
X-Change-ID: 20250707-vmcore_hw_error-322429e6c316
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, 
 Borislav Petkov <bp@alien8.de>, Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 acpica-devel@lists.linux.dev, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1948; i=leitao@debian.org;
 h=from:subject:message-id; bh=VpVP5wDdJUADopR44kBGcroZazLAbCqHn1yQXetBaB0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBod3Py9RV5rOmNyM93i9ucAzXR0Rg4SeTvLEoCf
 LrVQ5xHwJ+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaHdz8gAKCRA1o5Of/Hh3
 ba6YD/497AWz3l/e5LLZNjAOgecknbGypw5z5LO5ryICEBddhQfKzvBikVlIv3QlaZomDG9vQ5h
 zCr1hgF+GLrWHiup+QvuN4vM7wa/1BStxBaderz0wnbVptevHKnrhAt0E0ntwGeHECe/rRmqhY3
 e+zINnrBKUO8MFhjHiHpDj3RtOWLLfEePGEdcyF3VbBdhgWzqAK0grxkKjNasftQr0kOea0GRdH
 meK3Fn2QRFDom0u0kyuPP9fR84d7eV/BILcgaxS4czDYQUk6qxUbJUdDzPGiovckW/Lliwwvr3A
 UjSfzG24mI9X0a2zC7sDVVkcCQfikwCiv5uNkg/GqLpSDpinmNIgTIiZjTfoGASZ0KV67e4TcFs
 g1ILLfJq1Iq7ggRgQyt7QYzDpmtMbYs8s8VK/Y68wCe1/fLaJdsmYCc0DdYEb5uRNdzykUgseP4
 v9lPxwaHGtWl0j0Q5ksencE6mWwBJtJdk7Z278dUij57eTImN8YdpFIt0ieL6FP62hbLaRgFFjp
 aX5o9ABtUTjT28Y8ynhhpu0iajjnn8cgQdKOg6YWR8mP/SBUBHseEsFZX3ix8nWAhaTHjB+7mt2
 LAulzyE9/3H75BdCM9gpeHDN3nqXuZ2fh/wHGnxKPHqNoFSrIAFECv0dqPIKmTDWqMm8P1Ka7RY
 NU0FOdMRYuGFJBA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Set TAINT_MACHINE_CHECK when SError or Synchronous External Abort (SEA)
interrupts trigger a panic to flag potential hardware faults. This
tainting mechanism aids in debugging and enables correlation of
hardware-related crashes in large-scale deployments.

This change aligns with similar patches[1] that mark machine check
events when the system crashes due to hardware errors.

Link: https://lore.kernel.org/all/20250702-add_tain-v1-1-9187b10914b9@debian.org/ [1]
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Also taint the kernel on Synchronous External Abort panics (Will Deacon)
- Link to v1: https://lore.kernel.org/r/20250714-vmcore_hw_error-v1-1-8cf45edb6334@debian.org
---
 arch/arm64/kernel/traps.c | 1 +
 arch/arm64/mm/fault.c     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 9bfa5c944379d..7468b22585cef 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -931,6 +931,7 @@ void __noreturn panic_bad_stack(struct pt_regs *regs, unsigned long esr, unsigne
 
 void __noreturn arm64_serror_panic(struct pt_regs *regs, unsigned long esr)
 {
+	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_STILL_OK);
 	console_verbose();
 
 	pr_crit("SError Interrupt on CPU%d, code 0x%016lx -- %s\n",
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index ec0a337891ddf..004106ff4bd03 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -826,6 +826,7 @@ static int do_sea(unsigned long far, unsigned long esr, struct pt_regs *regs)
 		 */
 		siaddr  = untagged_addr(far);
 	}
+	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_STILL_OK);
 	arm64_notify_die(inf->name, regs, inf->sig, inf->code, siaddr, esr);
 
 	return 0;

---
base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
change-id: 20250707-vmcore_hw_error-322429e6c316

Best regards,
--  
Breno Leitao <leitao@debian.org>

