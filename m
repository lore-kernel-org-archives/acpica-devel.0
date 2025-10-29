Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E70E336EEA
	for <acpica-devel@lists.linux.dev>; Wed, 29 Oct 2025 11:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737256; cv=none; b=glkVu4+oP4c5mOWmvc/p39NiSo2dNAOcYFcZY7Iu/llFXjHSau51fyfaqhO2pPZLBZISCcfF3mMKshZBh5ZWTUfa+5WEBcwvdNtPI5HOzG5dCMqJ0EEDglcBZaABr3qnESQGSWlxpAiQ/PtBlKUUn7Ri6NmfZAYBhtbOvQg6js0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737256; c=relaxed/simple;
	bh=NtqJe6hBkLHRTCl6BTB7x/7lULJenUS592JeZPPvj04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yihibc75fHcwP+/KuAd73MzwawyKH9VgR7nK2Ol0/+K8svgqbDDawlb0G+B46A6bnOJ5JhsA7wENhehswBm2u9sN0AMd4bCkQ3yM2yA6IIor8NPYGr4qkhy/sk+sPlyXHs+TnuTr30tMlmjUIBriehHWJ/IuOzVk01DQvkhrZ/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=nLvOCpz5; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="nLvOCpz5"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-33be037cf73so7461391a91.2
        for <acpica-devel@lists.linux.dev>; Wed, 29 Oct 2025 04:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1761737254; x=1762342054; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6cSTruKqOLsH1I5PXwtSeYHag9AZi6yAFctm+4E+iHg=;
        b=nLvOCpz5l8i6XHtHtiuRLKeIh6M4YyttglKkVNnocAc3EO+6fXaUZdJtgmcUB0ACt3
         HzW4ari53cj7sW2zVMRCZ1DO65kk3C5dmpaf64nxwh/gGrt3eiMaBKo29AIxegVCzSbp
         CI6Q3IxAuIikvK7JWP/8exsxPvrv9ovIb6BGkP4AILMV+u2OyLFjJ1kgcJgXyog65pUU
         0vrrkbnRJPsWyw/stzph5mtltmTlD6fUfGG2osFhRBuPYp9qA1T3bLbLM5u4YUhR+QHe
         3fNUn+gLKFfQKm1bJ9JoRq5KgSVOzzdwicKo+OngHSjkB54p4e+1lu5jfCL+RaGQDM4U
         oKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761737254; x=1762342054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6cSTruKqOLsH1I5PXwtSeYHag9AZi6yAFctm+4E+iHg=;
        b=JDLejcFS7fZwOqzowha4IHWCTTEIyq/B2N++4WWjMFnLGu+1xpQANi0UZqhZQLrtAa
         Rf1WwY89EmUgu8XkhcrLhd1sXsgTnj8zDMXvloaLVB2+3V953IMvDMz5BE5gTN1o7s4G
         3z6wUfl3J5694IBPpllHT2a5ao1tCkbh2abSdKD6b7RuIZevItlCZquwfJrY3qY8hWx2
         +EyPy5mDL4JPk7tl3OsMLk9n8ExZNL6YT5f4TcFYrMi+cfJTt04JJIf0X5eIczuqPYqi
         Azs0cmrWiVbN9Rc4ygrXC0978mZLk0zzxylyNFgVK5eq+u5BkSDP81xG7oq8fByTdOP7
         iMMw==
X-Forwarded-Encrypted: i=1; AJvYcCU2sr+p0oYOazIvWPe34zJJ/tmp/RDbpwBTBjF3Y+4oQz0qxESwFu27r6X9KnP8hBCR/TsuHF6ZKiQAJSY=@lists.linux.dev
X-Gm-Message-State: AOJu0YyfV92vew2X+E+KwUQiK1Z7HiCcxu8jnnEy3q/V1/oEj2ySZLWQ
	Es4nZ8FZGAfG27m3nyoBn6zbordwVrMXZg6/+GxGlKAhQl9nWb7zsNSGvBcerHrd1tM=
X-Gm-Gg: ASbGnctqwMlYHvyi8bNMCuneoJsb+4EqnjT5GxRRKw5+GU/y/Z42PAQlMjUjQtK1Xwi
	y80d1/HQ2IW8jU2IGGZCxPY5XPc03veIrCBkSBrITrsoylT14YNyuWL7ER5KfZ9XGIOXnnZUBFq
	+To/jyMh7v5Rvv5vTOMQrqGTI5egBftQ48d5zTD9xnjUsIQcsgUDmXtPatpAIX1Kk4L+weMPrnv
	HtCxRWztDCTFgKqQwzJDBODqF69gzu7x6zLPedCJeWeRknEmXOkc6kILIEow6oeeHLj+ZU+++Oj
	a3zNdWVRNi/7DKS3FFgBSdBPc6mzrM130TduRqJeN8wmE9KhHriE8JAa3xDir2tl0Up/8Gkq8j7
	nIvoCHoFDqT/whRI7c6Oxqh5/TfHGBt6HY10EtPYLoMoNpW7Q7nG2MTRwK5/ZmWYgTz+U2WvYKy
	eXzyxdrgSA7PJZmf7VAHvEDm3xuZHtep1XZ3XYpHo=
X-Google-Smtp-Source: AGHT+IEEUQbjEhb35jM58E8VRwx1ELP2wmCevbIBmE4Rmb/2cMhIG6S77jc+DoMY/nX9v+1TYNMJig==
X-Received: by 2002:a17:90a:fc46:b0:33b:938c:570a with SMTP id 98e67ed59e1d1-3403a301f0cmr3025943a91.33.1761737254196;
        Wed, 29 Oct 2025 04:27:34 -0700 (PDT)
Received: from ventana-desktop.localhost ([2405:201:d019:c0ce:f7f5:7789:48e5:c03f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7f6040sm15316918a91.16.2025.10.29.04.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:27:33 -0700 (PDT)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-efi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	ardb@kernel.org,
	conor@kernel.org,
	cleger@rivosinc.com,
	robert.moore@intel.com,
	sunilvl@ventanamicro.com,
	apatel@ventanamicro.com,
	Himanshu Chauhan <hchauhan@ventanamicro.com>
Subject: [RFC PATCH v2 06/10] riscv: Add functions to register ghes having SSE notification
Date: Wed, 29 Oct 2025 16:56:44 +0530
Message-ID: <20251029112649.3811657-7-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029112649.3811657-1-hchauhan@ventanamicro.com>
References: <20251029112649.3811657-1-hchauhan@ventanamicro.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add functions to register the ghes entries which have SSE as
notification type. The vector inside the ghes is the SSE event
ID that should be registered.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 drivers/firmware/riscv/riscv_sbi_sse.c | 147 +++++++++++++++++++++++++
 include/linux/riscv_sbi_sse.h          |  16 +++
 2 files changed, 163 insertions(+)

diff --git a/drivers/firmware/riscv/riscv_sbi_sse.c b/drivers/firmware/riscv/riscv_sbi_sse.c
index 6561c7acdaaa..46ebc9e9651c 100644
--- a/drivers/firmware/riscv/riscv_sbi_sse.c
+++ b/drivers/firmware/riscv/riscv_sbi_sse.c
@@ -5,6 +5,8 @@
 
 #define pr_fmt(fmt) "sse: " fmt
 
+#include <acpi/ghes.h>
+#include <linux/acpi.h>
 #include <linux/cpu.h>
 #include <linux/cpuhotplug.h>
 #include <linux/cpu_pm.h>
@@ -700,3 +702,148 @@ static int __init sse_init(void)
 	return ret;
 }
 arch_initcall(sse_init);
+
+struct sse_ghes_callback {
+	struct list_head head;
+	struct ghes *ghes;
+	sse_event_handler_fn *callback;
+};
+
+struct sse_ghes_event_data {
+	struct list_head head;
+	u32 event_num;
+	struct list_head callback_list;
+	struct sse_event *event;
+};
+
+static DEFINE_SPINLOCK(sse_ghes_event_list_lock);
+static LIST_HEAD(sse_ghes_event_list);
+
+static int sse_ghes_handler(u32 event_num, void *arg, struct pt_regs *regs)
+{
+	struct sse_ghes_event_data *ev_data = arg;
+	struct sse_ghes_callback *cb = NULL;
+
+	list_for_each_entry(cb, &ev_data->callback_list, head) {
+		if (cb && cb->ghes && cb->callback) {
+			cb->callback(ev_data->event_num, cb->ghes, regs);
+		}
+	}
+
+	return 0;
+}
+
+int sse_register_ghes(struct ghes *ghes, sse_event_handler_fn *lo_cb,
+		      sse_event_handler_fn *hi_cb)
+{
+	struct sse_ghes_event_data *ev_data, *evd;
+	struct sse_ghes_callback *cb;
+	u32 ev_num;
+	int err;
+
+	if (!sse_available)
+		return -EOPNOTSUPP;
+	if (!ghes || !lo_cb || !hi_cb)
+		return -EINVAL;
+
+	ev_num = ghes->generic->notify.vector;
+
+	ev_data = NULL;
+	spin_lock(&sse_ghes_event_list_lock);
+	list_for_each_entry(evd, &sse_ghes_event_list, head) {
+		if (evd->event_num == ev_num) {
+			ev_data = evd;
+			break;
+		}
+	}
+	spin_unlock(&sse_ghes_event_list_lock);
+
+	if (!ev_data) {
+		ev_data = kzalloc(sizeof(*ev_data), GFP_KERNEL);
+		if (!ev_data)
+			return -ENOMEM;
+
+		INIT_LIST_HEAD(&ev_data->head);
+		ev_data->event_num = ev_num;
+
+		INIT_LIST_HEAD(&ev_data->callback_list);
+
+		ev_data->event = sse_event_register(ev_num, ev_num,
+						    sse_ghes_handler, ev_data);
+		if (IS_ERR(ev_data->event)) {
+			pr_err("%s: Couldn't register event 0x%x\n", __func__, ev_num);
+			kfree(ev_data);
+			return -ENOMEM;
+		}
+
+		err = sse_event_enable(ev_data->event);
+		if (err) {
+			pr_err("%s: Couldn't enable event 0x%x\n", __func__, ev_num);
+			sse_event_unregister(ev_data->event);
+			kfree(ev_data);
+			return err;
+		}
+
+		spin_lock(&sse_ghes_event_list_lock);
+		list_add_tail(&ev_data->head, &sse_ghes_event_list);
+		spin_unlock(&sse_ghes_event_list_lock);
+	}
+
+	list_for_each_entry(cb, &ev_data->callback_list, head) {
+		if (cb->ghes == ghes)
+			return -EALREADY;
+	}
+
+	cb = kzalloc(sizeof(*cb), GFP_KERNEL);
+	if (!cb)
+		return -ENOMEM;
+	INIT_LIST_HEAD(&cb->head);
+	cb->ghes = ghes;
+	cb->callback = lo_cb;
+	list_add_tail(&cb->head, &ev_data->callback_list);
+
+	return 0;
+}
+
+int sse_unregister_ghes(struct ghes *ghes)
+{
+	struct sse_ghes_event_data *ev_data, *tmp;
+	struct sse_ghes_callback *cb;
+	int free_ev_data = 0;
+
+	if (!ghes)
+		return -EINVAL;
+
+	spin_lock(&sse_ghes_event_list_lock);
+
+	list_for_each_entry_safe(ev_data, tmp, &sse_ghes_event_list, head) {
+		list_for_each_entry(cb, &ev_data->callback_list, head) {
+			if (cb->ghes != ghes)
+				continue;
+
+			list_del(&cb->head);
+			kfree(cb);
+			break;
+		}
+
+		if (list_empty(&ev_data->callback_list))
+			free_ev_data = 1;
+
+		if (free_ev_data) {
+			spin_unlock(&sse_ghes_event_list_lock);
+
+			sse_event_disable(ev_data->event);
+			sse_event_unregister(ev_data->event);
+			ev_data->event = NULL;
+
+			spin_lock(&sse_ghes_event_list_lock);
+
+			list_del(&ev_data->head);
+			kfree(ev_data);
+		}
+	}
+
+	spin_unlock(&sse_ghes_event_list_lock);
+
+	return 0;
+}
diff --git a/include/linux/riscv_sbi_sse.h b/include/linux/riscv_sbi_sse.h
index a1b58e89dd19..cd615b479f82 100644
--- a/include/linux/riscv_sbi_sse.h
+++ b/include/linux/riscv_sbi_sse.h
@@ -11,6 +11,7 @@
 
 struct sse_event;
 struct pt_regs;
+struct ghes;
 
 typedef int (sse_event_handler_fn)(u32 event_num, void *arg,
 				   struct pt_regs *regs);
@@ -24,6 +25,10 @@ void sse_event_unregister(struct sse_event *evt);
 
 int sse_event_set_target_cpu(struct sse_event *sse_evt, unsigned int cpu);
 
+int sse_register_ghes(struct ghes *ghes, sse_event_handler_fn *lo_cb,
+		      sse_event_handler_fn *hi_cb);
+int sse_unregister_ghes(struct ghes *ghes);
+
 int sse_event_enable(struct sse_event *sse_evt);
 
 void sse_event_disable(struct sse_event *sse_evt);
@@ -47,6 +52,17 @@ static inline int sse_event_set_target_cpu(struct sse_event *sse_evt,
 	return -EOPNOTSUPP;
 }
 
+static inline int sse_register_ghes(struct ghes *ghes, sse_event_handler_fn *lo_cb,
+				    sse_event_handler_fn *hi_cb)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int sse_unregister_ghes(struct ghes *ghes)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int sse_event_enable(struct sse_event *sse_evt)
 {
 	return -EOPNOTSUPP;
-- 
2.43.0

