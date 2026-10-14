Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B02519929
	for <acpica-devel@lists.linux.dev>; Wed, 14 Oct 2026 13:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791984443; cv=none; b=jR4uMFTNSk8wgF0s40P0lx+hMn4VgIUpsumThxvzY/DOwH/JhCQQ7rNskvRH+MrvokaLP2W1hqPCTNzhR+Q1LKJ1JMLrt9BFg7V+goHFWBkuxQmD0bNxze1vTMzOvidb7XfhvbtIdVtfhiZri9/4RnEiJWM8KR2VLmCn6o+XobQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791984443; c=relaxed/simple;
	bh=kLBILYQiFvPtL2kDoHfHry5uv/u57Z4w9gzfs3e/Ems=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M9RjwgGe5hUiCeLitE+z/nRK+4YvugnNaJ+8LTJtI6+u0NRYUDViS2c3OCUgDvZgFu/naS854GY3L537rmzdROm8ohDWLAJBO0OrM7Q0YH2OUX/UXoxvQ3BFpI3QOMvoM7hHq01y/wLbDHgyjne0m0LOLXUBkSAaCCPmxP8FXNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=ClWNef+X; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="ClWNef+X"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 4E44681114;
	Wed, 14 Oct 2026 15:27:14 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HH3WXvket3_T; Wed, 14 Oct 2026 15:27:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1791984433; bh=kLBILYQiFvPtL2kDoHfHry5uv/u57Z4w9gzfs3e/Ems=;
	h=From:To:Cc:Subject:Date;
	b=ClWNef+XA08Pn4ra1cY7Sktg7XiKTukWd7L0B/81UH/LPxSi5BFDOL8j0kwGhd8Rg
	 3yuq+SzDJQNeem7E8h1a6Ml/2kzGF9HSjyoG0BRMA/LD4cVaxlJcsrOQmvNU1ylcuu
	 vZ8LdKG5nogOK47SOoo+an50ImPuHUsPEUEiSzPAhuiorVEIiRnlcnQvHFgWyvvZ0N
	 0nydOEtR+hLJlAyPMZX4nD0QDwVcdPJm2OTiIeoK7YumwhtEKcIiTzEdG1uVjfuRYx
	 PVusNF6UEpXE7oLyL2gFzMXzD4dZfsH13cq3Q5ml/tx9m4rMN+bKqnFDK7nXJLQf3h
	 NpjxfX7FnM0Og==
From: =?UTF-8?q?Ali=20Ahmet=20Memi=C5=9F?= <aliamemis@disroot.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Armin Wolf <W_Armin@gmx.de>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Rong Zhang <i@rong.moe>,
	Charis Stratakis <c.stratakis@proton.me>,
	linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] ACPI: Serialize battery methods and INT3403 _TMP
Date: Wed, 14 Oct 2026 16:26:56 +0300
Message-ID: <20261014132703.93355-1-aliamemis@disroot.org>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As discussed in [1], add exclusive variants of acpi_evaluate_object()
and acpi_evaluate_integer() and use them for the battery methods and
INT3403 _TMP, which interleave badly on ThinkPad P1 Gen2 and P53.

UCSI (bko221065) is not converted.  There the contention is on a
firmware AML mutex that _Qxx EC queries also take, which a wrapper
around acpi_evaluate_object() cannot cover, and Rong's notification
merging in 7.3 already reduces it on the battery side.

[1] https://lore.kernel.org/all/CAJZ5v0gS4agVUkCO6M=VW4Wi2y1-s+k23bpzmX9aAZ0Rsv4z9Q@mail.gmail.com/

Ali Ahmet Memiş (3):
  ACPI: utils: Add exclusive AML evaluation helpers
  ACPI: battery: Evaluate battery methods exclusively
  thermal: intel: int340x: Evaluate _TMP exclusively

 drivers/acpi/battery.c                        | 17 +++---
 drivers/acpi/utils.c                          | 56 +++++++++++++++++--
 .../int340x_thermal/int340x_thermal_zone.c    |  3 +-
 include/acpi/acpi_bus.h                       |  8 +++
 4 files changed, 71 insertions(+), 13 deletions(-)


base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.55.0

