Received: from mta1.migadu.com (out-169.mta1.migadu.com [95.215.58.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2684AA02B
	for <acpica-devel@lists.linux.dev>; Mon,  5 Oct 2026 15:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791214654; cv=none; b=vGdc0G48cNsdXAGjOZPYXx26QZNTaw6UOMVLl2IZZyuGpEuRMHd6AX3MaFj+mOjK+VmmFnfOFyH7NR340AKuiUeBUr98mdZDVaFRJzfHN6NUIPTtYPorWrtkUsLvBsrabeio6GQosMdo0C6ed+B+lp4/8PbGue+Wt49VqYMDQEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791214654; c=relaxed/simple;
	bh=XB7k5IpF/f3jTyUabM2/XihTVg2rq2ysH+wSG7w0HHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nYg3yZG13tHGOynqwHAOSfKQBDfoCmYhFc6rNBVkfRNK6N1uZ8jQrKxUhcbPYJi7CFhcTLmyHQU0OwnPEF9oru084tnRmuVUcgsLefDtKyvl7QrC1rQ1tQNDP/BhARRPtvztPjEDdKIgfDmqcDWXzFMlSAacdtc7YjnstG54YsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ULGWEgFa; arc=none smtp.client-ip=95.215.58.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ULGWEgFa"
X-Envelope-To: acpica-devel@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=XB7k5IpF/f3jTyUabM2/XihTVg2rq2ysH+wSG7w0HHI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791214648; v=1; x=1791819448;
 b=ULGWEgFafyCuLMXz80WQ0sScB1CJIOiXxgZjrmgLDC/KFjs22mcjiDlNOJzIeE3JGf59HhR/
 d/kFQVEpKo6u29ilEy5xT3JLBaRMSgK5XMGG+c2Fg36ccBXf3e3GpJ0kGOwX285YDRdQtv5uo1S
 XzlKm21GCA8S7FRyp2qQh3kI=
X-Envelope-To: acpica-devel@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 8fb8ff2d339af07d;
	Mon, 05 Oct 2026 15:37:28 +0000
X-Mizu-Trace-ID: 8fb8ff2d339af07d
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Fuad Tabba <tabba@google.com>
Subject: [PATCH 1/2] ACPI: tools: Link include/acpi instead of copying it
Date: Mon,  5 Oct 2026 16:37:22 +0100
Message-Id: <20261005153723.2644331-2-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261005153723.2644331-1-fuad.tabba@linux.dev>
References: <20261005153723.2644331-1-fuad.tabba@linux.dev>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An incremental build of the ACPI tools uses an old copy of the
include/acpi headers after they change. The copy under $(OUTPUT)include
is made by a rule for the directory with no prerequisites, so once it
exists it's never refreshed.

Link $(OUTPUT)include/acpi to include/acpi instead, which keeps the rest
of include/ out of the tools' include path as the copy did. The link is
recreated on every build, so it also replaces a copy left by an earlier
one, and the objects take it as an order-only prerequisite so that
recreating it rebuilds nothing. Rebuilding them when a header changes
is the next patch.

Fixes: d5a4b1a540b8 ("tools/power/acpi: Remove direct kernel source include reference")
Assisted-by: LLM
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 tools/power/acpi/Makefile.rules | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/power/acpi/Makefile.rules b/tools/power/acpi/Makefile.rules
index b71aada776889..48d9280a63f72 100644
--- a/tools/power/acpi/Makefile.rules
+++ b/tools/power/acpi/Makefile.rules
@@ -13,13 +13,12 @@ $(OUTPUT)$(TOOL): $(toolobjs) FORCE
 	$(ECHO) "  STRIP   " $(subst $(OUTPUT),,$@)
 	$(QUIET) $(STRIPCMD) $@
 
-$(KERNEL_INCLUDE):
-	$(ECHO) "  MKDIR   " $(subst $(OUTPUT),,$@)
+$(KERNEL_INCLUDE)/acpi: FORCE
 	$(QUIET) mkdir -p $(KERNEL_INCLUDE)
-	$(ECHO) "  CP      " $(subst $(OUTPUT),,$@)
-	$(QUIET) cp -rf $(srctree)/../../../include/acpi $(KERNEL_INCLUDE)/
+	$(QUIET) rm -rf $@
+	$(QUIET) ln -s $(abspath $(srctree)/../../../include/acpi) $@
 
-$(objdir)%.o: %.c $(KERNEL_INCLUDE)
+$(objdir)%.o: %.c | $(KERNEL_INCLUDE)/acpi
 	$(ECHO) "  CC      " $(subst $(OUTPUT),,$@)
 	$(QUIET) $(MKDIR) -p $(objdir) 2>/dev/null
 	$(QUIET) $(CC) -c $(CFLAGS) -o $@ $<
-- 
2.39.5

