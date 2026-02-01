Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C463333D6ED
	for <acpica-devel@lists.linux.dev>; Sun,  1 Feb 2026 13:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769951031; cv=none; b=prKaoz3CWZ2EB4zsa50VmgYeXTff79ZjEpOKMayM8oWVksm9tivN0CBE49Iyt+r4+O1xpCl5zmtWkBrXtmdKsCRGaNJOIYdydIy5fdFIyvC4sdKbGFtCsuxjUFJ2klaTWdjuYMRYWRqzjO0NrHARyLHUyYGwY4Y5zPyavpP1cvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769951031; c=relaxed/simple;
	bh=sVm24CuiuqVqC6ovc76VvEq4lqBdnsh8y2PXm4fmeuI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Mmzsy55w8EsGcOXZYvj9JIo3dYwhI7bQvbhLzQ36IJmicHVNCfQA6Yux2RKcydi9/EDw31AYzL+LEeKiUTUKinsxxyomJtIKsmw3ddYlr8mn9pnBqfh3Js6ELPcJQ59CyDikAvQLqgV0sVe/b5jNokENp5ILWkN+Yprx7dJkLhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKrY58Bm; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKrY58Bm"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-bc274b8b15bso2404956a12.1
        for <acpica-devel@lists.linux.dev>; Sun, 01 Feb 2026 05:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769951022; x=1770555822; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bNiuy8DgVoYWmI0eU5urHtLokDol+0VX8KfBQgmnbrA=;
        b=SKrY58BmRpXYRGgO8okCkf96ZnumwkAYsQr67mdJL9Y5tOxQkpWojCN8YXVoQ35Sbf
         Fa1ygEU053NCLdbab/VQ1Hc9vWq2WUPd+yOH6WelIBDhPrzrdZIv9gwwQbijsHgzIj9E
         f7Tr7FpKJl9amEwfUWEfIFvqYneMwAjP6HvmnQ21G+WBVkzfRhNkRdZUgT9R04UAMMHL
         1rSno3inAVBG2SUDqzfDL5dMbw7ub0XN6tfqQ5FisyIxSbvStihBWqP3FsHyBPm17/SJ
         dIOLbJUcVhg+YoVoChdKftQh4Ap+OmZ2q1bg9UnUmccejcKw1htUDgqFI+tWwHqdKnSS
         Ywsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769951022; x=1770555822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNiuy8DgVoYWmI0eU5urHtLokDol+0VX8KfBQgmnbrA=;
        b=LKTrkU2NGFQdu3hgr+xLz5iPDl62hhBYihkrb+FUapJy2oB+82DArutWPkqImQCdEm
         YnSpt3RIqghjpFarrKTL0Xbvm2vKMSFhCviAv3y+BFiyUW6898WZlOq8HCKRQ21hBVjw
         BGXNMoXzWkKpKqOEp7W85TP0YwF1p0jhHGb/lDA61dh7Rc2+sDGI6VKp8kVO/RofNwzi
         he1WMcgFu/+TG2xk08oPCutNwFYB3tb8jJOBV5f62xOKV5miUYosaqG5UwrmoPUqc7Hl
         v0L2+5X/QlGZ1IyRystFryk7MA4bH0BPaNSML+e0m0TM90Pn1V/hu1Rxh4QUIYhblB2r
         ZT1g==
X-Forwarded-Encrypted: i=1; AJvYcCVUQtrrHVVNglJoFbYKK8VkdNLi/+eWWC7mz1EGuT1fzp7o3x4nDEpSc72g6XWhMdvqfHFBseIyt+x+2M0=@lists.linux.dev
X-Gm-Message-State: AOJu0YytdppJJ6u9z+0rIe/pQPu2K69mkVKp4R68VMNQEYf9n7xTmHna
	nQHdHkXbQLXH5wqhK368NQH9M4H0MaL0tKtUCBgLEfVjVin8egRXhHLJ
X-Gm-Gg: AZuq6aJlh4fnyjNrJYq1MrvVLWgQs7kX5VgefQ/D04FlteE6c3zvnyDkiE2+dO3XRzt
	2ycH/48jrML/ywBmKfpp/uvgbJnyj2k3pkd68Fy/TD0LAFDRFdGdjhEiVJZWCS2qZWsW6p78ZMi
	GEolHpS3USCPL/rIkgO4htrn7I86Xyw9sOB/JhKRhgjyYUmGpuBRhj35Y7OUa5Ln3yyCdJQK04d
	D/P1xSd1IXrzqRYf8xwm5eMrHFyCmGHYg6zsKZvW/FnW22XV4sRqh/q8Ux2Y/+1gZLDjH+1vJ+s
	CRHPG2su7xH0zYirLxOht1AJpXSAsSY1TXqGoy5wOBoFRx5sGbSwRsjBAVfD5+QolCCMlXovndh
	8pW2AdT/CS7IQlgzId832dCJFGUyimEb/6z0UM93u9DQZU2+Q9kyDwU9oGKsWDdRRErK26zRuSk
	KGtdHIz2VKJaQ+dhaQEpmEXqMhMgCfLHN990ATlY6v4SNlDGJ0ne4M4Y0X1LK9angB6gNnW+9oL
	Ach7gaxCA==
X-Received: by 2002:a17:902:ebd2:b0:29f:f91:35ee with SMTP id d9443c01a7336-2a8d9a5f1bcmr89170245ad.43.1769951021796;
        Sun, 01 Feb 2026 05:03:41 -0800 (PST)
Received: from nickhuang.. (2001-b400-e28b-f958-90c5-2a29-7d9f-5524.emome-ip6.hinet.net. [2001:b400:e28b:f958:90c5:2a29:7d9f:5524])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a8bd74e9bbsm96831045ad.95.2026.02.01.05.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 05:03:41 -0800 (PST)
From: Nick Huang <sef1548@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Robert Moore <robert.moore@intel.com>
Cc: Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	paladin@ntub.edu.tw,
	kusogame68@gmail.com,
	ceyanglab@gmail.com,
	n1136402@ntub.edu.tw,
	Nick Huang <sef1548@gmail.com>
Subject: [PATCH 0/2] nsrepair2: Improve sorting performance and add tests 
Date: Sun,  1 Feb 2026 13:03:32 +0000
Message-ID: <20260201130334.3107-1-sef1548@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

   This patch series improves the ACPI nsrepair2 sorting implementation
   and adds comprehensive KUnit tests.

   Patch 1 replaces the O(n²) bubble sort algorithm in acpi_ns_sort_list()
   with the kernel's sort_r() function, which uses heapsort to achieve
   O(n log n) time complexity. This improves performance when sorting
   large ACPI package lists (e.g., _PSS, _TSS) while reducing code
   complexity by leveraging the existing kernel sort API.

   Patch 2 adds KUnit tests to verify the repair functions in nsrepair2.c,
   covering:
     - ACPI operand object creation (integer, string, buffer, package)
     - Namespace node creation and NAMESEG comparison
     - Package structures for _PSS, _CST, _ALR, _PRT methods
     - _HID string format verification
     - _FDE buffer expansion
     - Sorting logic with ascending/descending order



Nick Huang (2):
  ACPI: nsrepair2: Replace O(n²) bubble sort with O(n log n) sort_r()
  ACPI: acpica: Add KUnit tests for nsrepair2 repair functions

 drivers/acpi/acpica/nsrepair2.c      |  87 ++-
 drivers/acpi/acpica/nsrepair2_test.c | 854 +++++++++++++++++++++++++++
 2 files changed, 916 insertions(+), 25 deletions(-)
 create mode 100644 drivers/acpi/acpica/nsrepair2_test.c

-- 
2.43.0

