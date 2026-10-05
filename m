Received: from mta0.migadu.com (out-197.mta0.migadu.com [91.218.175.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1CF4A4EE6
	for <acpica-devel@lists.linux.dev>; Mon,  5 Oct 2026 15:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791214653; cv=none; b=ZC3jr2siroqqxM/A9I8GKaIGuilzdVr0I7h5brczmA+Nl+Fv3wwhYLJ9rjefPPnRGXuLrdLegByGEiowhctjc4Umi2p7b4iv6w+XSam8TYVC/KWy1q1/ZRozYt42EKlJJk649VRb/Hbhtdw2GGhKfbzVleydPtawsZ2U8DIRsB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791214653; c=relaxed/simple;
	bh=FKotCGMw7JFlVthC3POWKatbcuPz2i306Y5Jwy9RYaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N19tpyBcSKkKPmZj6NT9Hd9G/+2Se3wxg8FT3lYUsJ7/t9YNmypq7veuIITP9NMBVt2EOTmAgFfeBy8txQ5qJFRYrblK1kYn3MfcBMwCx2/uwTuPAEuRPF8ywVnvbV0os73joAR0ZwUrKuwQN/dV+a0u/d6vbRpIBy1ZaL/hRN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q8ZNpPO4; arc=none smtp.client-ip=91.218.175.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q8ZNpPO4"
X-Envelope-To: acpica-devel@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=FKotCGMw7JFlVthC3POWKatbcuPz2i306Y5Jwy9RYaQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791214648; v=1; x=1791819448;
 b=q8ZNpPO4YYU8mX7DKuYFT184Fkoja+BeaAy38r/8IAqfNBK8eMoXCqj503qDYwZoGRTgFNtq
 ZKI2kK8zvrOoD/GLPfkOxCRnqP1o/6VVbSRh5n3VHgLexnaY2O5jzMPBUm9Ry/4Hw4WowJwS78C
 P2FnD+APJj+28F7SjZ6a/qC4=
X-Envelope-To: acpica-devel@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id f99529c0cd29c776;
	Mon, 05 Oct 2026 15:37:28 +0000
X-Mizu-Trace-ID: f99529c0cd29c776
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
Subject: [PATCH 2/2] ACPI: tools: Rebuild objects when a header they include changes
Date: Mon,  5 Oct 2026 16:37:23 +0100
Message-Id: <20261005153723.2644331-3-fuad.tabba@linux.dev>
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

An incremental build of the ACPI tools recompiles an object only when
its .c file changes. The objects have no dependencies on the headers
they include, from include/acpi, drivers/acpi/acpica or the tools
themselves, so a header change leaves them built against the old one.

Generate a dependency file beside each object with -MMD, adding -MP so
that a removed header doesn't break the build, include those files, and
remove them on clean.

Assisted-by: LLM
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 tools/power/acpi/Makefile.rules | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/power/acpi/Makefile.rules b/tools/power/acpi/Makefile.rules
index 48d9280a63f72..b520a966c1c1b 100644
--- a/tools/power/acpi/Makefile.rules
+++ b/tools/power/acpi/Makefile.rules
@@ -21,13 +21,15 @@ $(KERNEL_INCLUDE)/acpi: FORCE
 $(objdir)%.o: %.c | $(KERNEL_INCLUDE)/acpi
 	$(ECHO) "  CC      " $(subst $(OUTPUT),,$@)
 	$(QUIET) $(MKDIR) -p $(objdir) 2>/dev/null
-	$(QUIET) $(CC) -c $(CFLAGS) -o $@ $<
+	$(QUIET) $(CC) -c $(CFLAGS) -MMD -MP -o $@ $<
+
+-include $(toolobjs:.o=.d)
 
 all: $(OUTPUT)$(TOOL)
 clean:
 	$(ECHO) "  RMOBJ   " $(subst $(OUTPUT),,$(objdir))
 	$(QUIET) find $(objdir) \( -not -type d \)\
-		 -and \( -name '*~' -o -name '*.[oas]' \)\
+		 -and \( -name '*~' -o -name '*.[oasd]' \)\
 		 -type f -print | xargs rm -f
 	$(ECHO) "  RM      " $(TOOL)
 	$(QUIET) rm -f $(OUTPUT)$(TOOL)
-- 
2.39.5

