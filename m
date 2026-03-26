Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD183976B3
	for <acpica-devel@lists.linux.dev>; Thu, 26 Mar 2026 20:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774556315; cv=none; b=fiBazFmW3vVpAeZsk/rZnS3SZYgIuL9nai7QNiZBlPNU2vRBZa1SFfTKMhJ22reg3QAnxkcv0pC9WcYfRiNA5tddLvG7TBIxnXYjYWmoPAFnSdwNWfB0UKGJN6vQbcZ9R1bXXq96//0X6SjrDKyE2415oxC+cEMgQcrLOy2G7hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774556315; c=relaxed/simple;
	bh=TeSvF09MPdWxY8fc80HEEU4F3Q/QiMcfV6ECA2cUZPM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=biXdK0AsSSNWWJum7JtfIINH9ns6vCZAYquyTS0AdJNIYlxRDyzDeW/IXmcXhk0D2GaNb4pLTg+cgUBteeR2eOBgyNcA0KZQvtC0oohhU1T35r9ZIqEPIfJrya/i7Me0hlUvat8eGZ63G+D967Laaptnkj1F+Rh5wmNpO+GpqGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LdNSr87P; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdNSr87P"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43b949bf4easo824682f8f.0
        for <acpica-devel@lists.linux.dev>; Thu, 26 Mar 2026 13:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774556312; x=1775161112; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gXs8EltyB8S7jgNI/iWhaXliZDlbstWdNH2DPvSDzNE=;
        b=LdNSr87PnpKow9/kQuBgZOtHEh+IalwSwauQcniXn1XMzfrFYGHhtc/ey/diW7Y840
         MrWuA0eaNG4w6UmWpu2xu0tLmjQub+qtcNAp0SivdTjFKHBor3gDloAwUTlMVsK/CXlJ
         ev9Al9i3hNTt6JnhD6Isk4gsEqjCDIc65pEaYESBiH/VQXERpsBTK9Kq9imyGW97XeQq
         EvWfbjeVYXNieMOx6S8ODnLglRzX54Ag++1Gj1fkKfSZTB/JuPh0H68+jv9EijmDjR3i
         GhVtf9x8EIoNU+7dySfiImimOIkdYb6kqrH1R33J10W5tyPcwfCOrZkCXWMbL1+I8zSG
         TcHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774556312; x=1775161112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXs8EltyB8S7jgNI/iWhaXliZDlbstWdNH2DPvSDzNE=;
        b=EGFKzQrBDBfV2eyn9a8OwkoAvIyJI1HylWiPR9V81oK7ABCV32UepcwaKKQYHPuXBu
         A/F8b1xjS9tzZt2KM9Q1VhVoCjD1civ6EbDP+goKhB5pyfeLxeO53VNZobNXSuRKpMrf
         MH92DlsFteXHfe0vdlkg/mzz6/9Td6ZtZO5CWlbujgeRlGCJUlORMeA2K4P1+3b/kozW
         ZdnMhHsdKZkPGzP22SrDcHr3g3p4jal/6gEuoQXTH9iJVpBcxq2LSA7hMLqoaoRjiomm
         vxh922gQJKIRYEywHPc22SvkOdrYVfQ6+Uh42x4qhmKtH4Fb5A74vkpWertnTUzUXdWi
         XXrw==
X-Forwarded-Encrypted: i=1; AJvYcCWAsQOXk7LnWVI540qxPZEcMVGVVjPaZySViDFYrphjVppNqVJUDTx6Pqxu02KVX8nv5y/ULqQgmvFmGYg=@lists.linux.dev
X-Gm-Message-State: AOJu0YwdYEOqKMnuTOKoDrqqZFl3Eq71w6yqm/f8pKk+CsxL1gxJiOV1
	bfMyJHRsXOZiPtdVodA1FkXv72X6JF2AAK3TDnqUnG4hjQCLpuDNHVHL
X-Gm-Gg: ATEYQzxrdHYaAjvMc9n208DDLZ0iQNxGSEOmFd9cqAoVgEEhL+uKf1nb9i9wwIGLXjc
	c33TUEJdu/JA4MsP7YCPuW4UWSFHEPEQQFgHJgyKxVk5PpJrs7tN3JmoifvWgCFZLgPqdDRyaVu
	P9EQLUJ5X8lUjRt9V+SH+AnLVTWOCJujDYQODBUoB/WZR/0seGKQHtRN8GP4cRDiynpGIz3lpxI
	OO0sY8hqsXogf9LanJxbLTffsGOVFtylPct5nxG9EhcWJ0QtJEd53vZ+57qoGNBnm79wCL8DWRS
	m+XaNcPUhGZ3s6d5ZPYfSedro9AlkwqHP7NvEd8IZATv4PNFGAajBkcbil641LdiO7wxGInau/t
	Ga0R0tqs0C7kpMzPd4Y/SCyxQQcumJk51fq/lA51bswWyNkdMpwJlJf6as+vU+qz+MVAXDbCshd
	BpHqnB2YTiFH9HhqiSJyls7kMGO1oYPgUZJeuemoYYWxgOKWIdyfBp3BCwljc2+gYLkFMAWuQuu
	NfPt4FtH7O9
X-Received: by 2002:a5d:5887:0:b0:43b:8e96:d3d2 with SMTP id ffacd0b85a97d-43b97a253f2mr5352021f8f.13.1774556312267;
        Thu, 26 Mar 2026 13:18:32 -0700 (PDT)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b9192e528sm9782359f8f.1.2026.03.26.13.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 13:18:32 -0700 (PDT)
From: david.laight.linux@gmail.com
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: David Laight <david.laight.linux@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH next] ACPICA: AML Parser: Remove spurious precision from format used to dump parse trees
Date: Thu, 26 Mar 2026 20:18:30 +0000
Message-Id: <20260326201830.3938-1-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

The debug code in acpi_ps_delete_parse_tree() uses ("%*.s", level * 4, " ")
to indent traces.
POSIX requires the empty precision be treated as zero, but the kernel treats
is as 'no precision specified'.
Change to ("%*s", level * 4, "") since there is additional whitespace and no
reason to indent by one space when level is zero.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 drivers/acpi/acpica/pswalk.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/pswalk.c b/drivers/acpi/acpica/pswalk.c
index 2f3ebcd8aebe..b1ec75e277ab 100644
--- a/drivers/acpi/acpica/pswalk.c
+++ b/drivers/acpi/acpica/pswalk.c
@@ -49,8 +49,7 @@ void acpi_ps_delete_parse_tree(union acpi_parse_object *subtree_root)
 
 				/* This debug option will print the entire parse tree */
 
-				acpi_os_printf("      %*.s%s %p", (level * 4),
-					       " ",
+				acpi_os_printf("      %*s%s %p", (level * 4), "",
 					       acpi_ps_get_opcode_name(op->
 								       common.
 								       aml_opcode),
-- 
2.39.5

