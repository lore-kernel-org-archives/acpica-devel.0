Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ACE33FE0C
	for <acpica-devel@lists.linux.dev>; Sun,  1 Feb 2026 13:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769951035; cv=none; b=DBIT+HxMJXhXuR0Gxrg5AR6ferVSoJ/lsurnwk5gAC+2F88yJf74rfSmszceebYW8XT6dJnngvbVke6DYsJRGODl7b7bebQn23ujG3Rc6gR5dqt7wG19zCbuFsOKWKrJWBV00mHgx/duo7nvIHsNqB0MdX1LeR7LobJuCtyvvSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769951035; c=relaxed/simple;
	bh=jkJFaSw+4QB88At9pISwIN/7R4HhlxcEMlc2qyYUNjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OXv7bVw1DsDN9chx/X/IBlpteu850MFHHnvhdd8FwMKollLbLYbkAVTE8ZwR4SM+S7chNooXqjhYNAjToEB9vvnXhaZ1lIlVQ0L+NjgF4eUS0j0hBvNETnm6EXC27JiR6IUTf3lnvDVVGtiHWd1II9+MAn9NozIG7SCQ79ahdQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZNXmg89b; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNXmg89b"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29f102b013fso37501415ad.2
        for <acpica-devel@lists.linux.dev>; Sun, 01 Feb 2026 05:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769951027; x=1770555827; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpTdJ6kU9128Bplq2Lsam/HvuOJViBWd2y7vXvIt9P8=;
        b=ZNXmg89b8allLSCX4n2AWSy6otbMwyBFhbYjyoXukYy322R3+OLsvx/xwHzS6czKlR
         5bi0kudRQNOgwK0jOuLBJsRjdc+negpkHF7UkYY5/ASYDnW2PAoXnj0WZP0B/5wCfN4O
         cM5AvXQnLesIGbpcKfbKR4DIVJg80c6il8ukYQQfVEeigYzBjbt6+9NVyf9xAhfuXb2G
         b+bTEjHk/6FntqVuOmprMYj6lFy6W7gla02QqRIP8HX11cKH/f51pCBm03IfA6gvDc0P
         48IAa2FEQSkb3rVaX9/C7SBT+29QoGcNYTN7iOQiCbyMXqyxh400UL3aLOqWftXiiFRm
         z+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769951027; x=1770555827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zpTdJ6kU9128Bplq2Lsam/HvuOJViBWd2y7vXvIt9P8=;
        b=Z6LznhSXjbRL098uDUTlMrIIdDmsemcVkWn56WRV+Brpj2Z6Cfb/hP83MKM0WV+vh1
         NnP4dwpNppmgynFD3RSMy2LfnYhWp5Z3bKYcVwdKCX5EPkkL052a7quBxgyZQCICiWzZ
         xE7tC2t+T0Joyk1HLRJ3I0vlodOsT2wXcweTp1HvI1SqosDV86AxB+OAgUgmciw5hI5R
         lO9DhRGGKUzFGwD2A4AesBFwkshjtGWymDiutfzcWLWwhRy45n0+3wtU2HnLr/VDoYGU
         1JsPChD4m9yzf8/fiKCxxNOrgu1Lfpd+S8ODWg2/orsxJ15mapEBvFfmchO1LoA6nYdo
         fFug==
X-Forwarded-Encrypted: i=1; AJvYcCX1n3BwjCURG25Gi+/5vRo7mw+mbAoCBzAcIWzpgg3mz/nque1Yec7VgpopzbmlNZ5tlPorHoBz2fFPCZ0=@lists.linux.dev
X-Gm-Message-State: AOJu0Yyt03cUO45g2QXTxSruh8REQuzO+nAweeH4+KW51PwXyUGIwjDp
	T54jPWPL0Utyv2TpoSRGjmMXdrhv5cUzUHregQXqAF7+t8kbQv3LJL6V
X-Gm-Gg: AZuq6aI+jaOnW8WrQUwjcXJ1+3yWhurllt0LvwVDyyEPFBVwJrFL6iYXak7c1dtdMxv
	qtFWiMfGC4Vs2MHSCZY1VPUi7lkr0FZQXueUoK9hTDURDqUMmow2pXMyjfmNN9QXu5q/bYShZ9+
	+Ukf5Nrr6CkSK4dduryVMyivEJ6YmjkZmRlS4xONRuTGodF/jAxTFjCTAXFZqAARYAte66wxmbv
	J0wCDB5Q5UEkij1eedOxy+lrk0crvpN/9k0rxG1KCIs46qpf38qEfAfezKEr0HvA/zFT9Du7asy
	O0WO7Z+EtCGzNj0/VJI5iqL1rcSOnv41hg/JU7zba1uyhqwhWksw3uHs10J3t48w2pVAp7OOuY0
	jjhDLpGizGGBCwwuobltVzETXA3FQ46b8UawAtQFW7ecq2rC4oiWfF/pUR2W1UfAqoSAWpDcsIO
	vhTAS3yrWaHFuVHaaCdxaVXQnGkieNHt92fzmsedpHeynOIgT/eqqEIpuCkEAecju7JWDDw59W4
	uuaQuWJzg==
X-Received: by 2002:a17:902:cf10:b0:29d:65ed:f481 with SMTP id d9443c01a7336-2a8d8946eabmr94972755ad.0.1769951027197;
        Sun, 01 Feb 2026 05:03:47 -0800 (PST)
Received: from nickhuang.. (2001-b400-e28b-f958-90c5-2a29-7d9f-5524.emome-ip6.hinet.net. [2001:b400:e28b:f958:90c5:2a29:7d9f:5524])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a8bd74e9bbsm96831045ad.95.2026.02.01.05.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 05:03:46 -0800 (PST)
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
Subject: [PATCH 1/2] =?UTF-8?q?ACPI:=20nsrepair2:=20Replace=20O(n=C2=B2)?= =?UTF-8?q?=20bubble=20sort=20with=20O(n=20log=20n)=20sort=5Fr()?=
Date: Sun,  1 Feb 2026 13:03:33 +0000
Message-ID: <20260201130334.3107-2-sef1548@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260201130334.3107-1-sef1548@gmail.com>
References: <20260201130334.3107-1-sef1548@gmail.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

   Replace the O(n²) bubble sort implementation in acpi_ns_sort_list()
   with the kernel's sort_r() function which uses heapsort, providing
   O(n log n) time complexity.

   This improves performance for large ACPI package lists while also
   reducing code complexity by leveraging the existing kernel sort API.

Signed-off-by: Nick Huang <sef1548@gmail.com>
---
 drivers/acpi/acpica/nsrepair2.c | 87 +++++++++++++++++++++++----------
 1 file changed, 62 insertions(+), 25 deletions(-)

diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index 8dbb870f4..a39ef59fe 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -9,6 +9,7 @@
  *****************************************************************************/
 
 #include <acpi/acpi.h>
+#include <linux/sort.h>
 #include "accommon.h"
 #include "acnamesp.h"
 
@@ -84,6 +85,14 @@ acpi_ns_check_sorted_list(struct acpi_evaluate_info *info,
 static void
 acpi_ns_remove_element(union acpi_operand_object *obj_desc, u32 index);
 
+/* Context structure for sort comparison function */
+struct acpi_sort_context {
+	u32 sort_index;
+	u8 sort_direction;
+};
+
+static int acpi_ns_sort_cmp(const void *a, const void *b, const void *priv);
+
 static void
 acpi_ns_sort_list(union acpi_operand_object **elements,
 		  u32 count, u32 index, u8 sort_direction);
@@ -851,6 +860,52 @@ acpi_ns_check_sorted_list(struct acpi_evaluate_info *info,
 	return (AE_OK);
 }
 
+/******************************************************************************
+ *
+ * FUNCTION:    acpi_ns_sort_cmp
+ *
+ * PARAMETERS:  a               - First element to compare
+ *              b               - Second element to compare
+ *              priv            - Pointer to sort context (acpi_sort_context)
+ *
+ * RETURN:      -1, 0, or 1 depending on sort order
+ *
+ * DESCRIPTION: Comparison function for sort_r() API. Compares the integer
+ *              values at the specified index within package elements.
+ *
+ *****************************************************************************/
+
+static int acpi_ns_sort_cmp(const void *a, const void *b, const void *priv)
+{
+	union acpi_operand_object *obj_a = *(union acpi_operand_object **)a;
+	union acpi_operand_object *obj_b = *(union acpi_operand_object **)b;
+	const struct acpi_sort_context *ctx = priv;
+	union acpi_operand_object *value_a;
+	union acpi_operand_object *value_b;
+	u64 a_val;
+	u64 b_val;
+
+	value_a = obj_a->package.elements[ctx->sort_index];
+	value_b = obj_b->package.elements[ctx->sort_index];
+
+	a_val = value_a->integer.value;
+	b_val = value_b->integer.value;
+
+	if (ctx->sort_direction == ACPI_SORT_ASCENDING) {
+		if (a_val < b_val)
+			return -1;
+		if (a_val > b_val)
+			return 1;
+	} else {
+		if (a_val > b_val)
+			return -1;
+		if (a_val < b_val)
+			return 1;
+	}
+
+	return 0;
+}
+
 /******************************************************************************
  *
  * FUNCTION:    acpi_ns_sort_list
@@ -873,31 +928,13 @@ static void
 acpi_ns_sort_list(union acpi_operand_object **elements,
 		  u32 count, u32 index, u8 sort_direction)
 {
-	union acpi_operand_object *obj_desc1;
-	union acpi_operand_object *obj_desc2;
-	union acpi_operand_object *temp_obj;
-	u32 i;
-	u32 j;
-
-	/* Simple bubble sort */
-
-	for (i = 1; i < count; i++) {
-		for (j = (count - 1); j >= i; j--) {
-			obj_desc1 = elements[j - 1]->package.elements[index];
-			obj_desc2 = elements[j]->package.elements[index];
-
-			if (((sort_direction == ACPI_SORT_ASCENDING) &&
-			     (obj_desc1->integer.value >
-			      obj_desc2->integer.value))
-			    || ((sort_direction == ACPI_SORT_DESCENDING)
-				&& (obj_desc1->integer.value <
-				    obj_desc2->integer.value))) {
-				temp_obj = elements[j - 1];
-				elements[j - 1] = elements[j];
-				elements[j] = temp_obj;
-			}
-		}
-	}
+	struct acpi_sort_context ctx;
+
+	ctx.sort_index = index;
+	ctx.sort_direction = sort_direction;
+
+	sort_r(elements, count, sizeof(union acpi_operand_object *),
+	       acpi_ns_sort_cmp, NULL, &ctx);
 }
 
 /******************************************************************************
-- 
2.43.0

