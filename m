Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8F020B28
	for <acpica-devel@lists.linux.dev>; Mon, 13 Nov 2023 23:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rPqoGPcn"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-507a3b8b113so7013991e87.0
        for <acpica-devel@lists.linux.dev>; Mon, 13 Nov 2023 15:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699916934; x=1700521734; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ACmx3TNz3KrSPf31LlnpB3IxofbprNijom9dYNvkSxs=;
        b=rPqoGPcnUKkyVN/tYKZ46ACYLF1pcJ1PRx8OtSA4JUS9ENVGqp6J4LcUfmIIT0Iwtr
         g/muzDSevL1Y4l2RVWYKlKp2PiYH9v20ZpGT98ffzfFjOOCiYzFH5vio1xpgfITADX3N
         75qIXC006jjzFznJsmR6cFeHzeZCMnXhPjDzUZx84y7JLUj3W7jFRprUqzDGRRlycEIg
         bVLFkphkUQ8w/cn4qQxNC5lzJOZFSmAEUn/ZuhWtvwCmcCzv93NXpgkTA4OafuejfxWj
         muJ2ZZPuyk7/YcvK5b7ADey03Km6TO9JMePajqjUxnz02feZeMxrLMh0SNgpWMWWINpE
         JdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699916934; x=1700521734;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ACmx3TNz3KrSPf31LlnpB3IxofbprNijom9dYNvkSxs=;
        b=ELQ4Ds2TrVvGOi7R3JsmRGZe+sB5Z8xXWkYx2KDLZMnoJ5AR1WfM3TOdfJeSLfCgfM
         kWgaEwOa6cW9+vZk/jWTTJP4gfI2JLOAjV8YZ6uD36OGWUEVpDnxrnFJEcJJZ2nvMQYk
         DQJ/kkRUTZPwPxgKLi6+RweUlHukQXEuqFHmFJeiHtb9oRknnBcWbl/BAMBJ5PRhjrMt
         rRtKdcsdWpqz3aN+4Ry7ywgR7hcKxbsV6RdOIisnCiDv++kioqACcGdOmV2zx+W0iTtf
         U+UWAEo99bpHEn5iTIKffU1ZOzs2pzoK458JhUBU1Ae9FCN1VdEZEjZexJfYhoXgXXrG
         mGhQ==
X-Gm-Message-State: AOJu0YwDBpqR+K6TD4J5Z+PyEJ5Ji1Dlqz5ee68DZyCKdlgzcysb6eGW
	cAnMzlXcpMmIMzLrOY5PmJFhtA==
X-Google-Smtp-Source: AGHT+IHTUId+0HJ4T45+iwtwHrEWqjSbHl2ub84wm4qF/7cvEBUNB/FCXGvBhq2OudQkog7DHYvxzQ==
X-Received: by 2002:ac2:43a6:0:b0:509:38de:9917 with SMTP id t6-20020ac243a6000000b0050938de9917mr5282007lfl.21.1699916933673;
        Mon, 13 Nov 2023 15:08:53 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id m9-20020ac24ac9000000b0050307bf2bcdsm1114292lfp.247.2023.11.13.15.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 15:08:53 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 14 Nov 2023 00:08:47 +0100
Subject: [PATCH] ACPI: acenv: Permit compilation from within the kernel
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-arm-build-bug-v1-1-458745fe32a4@linaro.org>
X-B4-Tracking: v=1; b=H4sIAH6sUmUC/x2MQQqAIBAAvxJ7Tmi1DvaV6GC52kJZKEUg/j3pM
 jCHmQyJIlOCsckQ6eHEZ6iCbQPrZoInwbY6yE4qRFTCxEMsN++20gtDQ6+clYhaQ22uSI7f/zf
 NpXyuNDVMXwAAAA==
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Dan Williams <dan.j.williams@intel.com>, Hanjun Guo <guohanjun@huawei.com>, 
 Arnd Bergmann <arnd@arndb.de>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

After commit a103f46633fd the kernel stopped compiling for
several ARM32 platforms that I am building with a bare metal
compiler. Bare metal compilers (arm-none-eabi-) don't
define __linux__.

This is because the header <acpi/platform/acenv.h> is now
in the include path for <linux/irq.h>:

  CC      arch/arm/kernel/irq.o
  CC      kernel/sysctl.o
  CC      crypto/api.o
In file included from ../include/acpi/acpi.h:22,
                 from ../include/linux/fw_table.h:29,
                 from ../include/linux/acpi.h:18,
                 from ../include/linux/irqchip.h:14,
                 from ../arch/arm/kernel/irq.c:25:
../include/acpi/platform/acenv.h:218:2: error: #error Unknown target environment
  218 | #error Unknown target environment
      |  ^~~~~

One solution to make compilation with a bare metal compiler
work again is to say the file is used with Linux from within
the kernel if __KERNEL__ is defined so I did that.

Fixes: a103f46633fd ("acpi: Move common tables helper functions to common lib")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 include/acpi/platform/acenv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index 337ffa931ee8..76444ffdc549 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -156,7 +156,7 @@
 
 #endif
 
-#if defined(_LINUX) || defined(__linux__)
+#if defined(_LINUX) || defined(__linux__) || defined(__KERNEL__)
 #include <acpi/platform/aclinux.h>
 
 #elif defined(_APPLE) || defined(__APPLE__)

---
base-commit: 9bacdd8996c77c42ca004440be610692275ff9d0
change-id: 20231113-arm-build-bug-ae543fd21199

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

