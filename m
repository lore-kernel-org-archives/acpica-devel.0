Return-Path: <andriy.shevchenko@linux.intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D9BC340565
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2C4BB40550
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688386457; x=1719922457;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6dRCLDNqHkkgOUVmba5HT205hg+Hl4f7VC7TUVOvuDs=;
 b=In5Upfr6C5gXiONAMV1wQ16x/2QH4eupis0ImI9fmQs/oIit5CGE3Vfu
 Yuf8spOZYtPt3pwy1PHuRLCsRnwy51aG16KSzHQvEEDJ614Ouj8EKsIcL
 zoL9c3KEFd5vT2dXtE9xjDRnGxic8/5fcYJUBDqy2+tETF03FA3MjL42c
 45GXZCsbQQlU+yg21obn/mpfJqc6WiqaFNBPEv+NCBs2comcvyaB5V7Qn
 EAZWLJSSLlbJDYYm4EKCyNUvNc0IliaJvHF1gB0svq9HIBh4HSF4v8TyF
 x0La9plWQBrmJEVJExkH1mCqcNWu5HJ7547N8/SlKlGinEljTQgodHKtR Q==;
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Message-Id: <20230703121411.69606-6-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230703121411.69606-1-andriy.shevchenko@linux.intel.com>
References: <20230703121411.69606-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Acpica-devel] [PATCH v4 5/5] ACPI: scan: Provide symbol
	declarations
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Mon, 03 Jul 2023 12:14:18 -0000
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Wolfram Sang <wsa@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, acpica-devel@lists.linuxfoundation.org
Cc: Michael Walle <michael@walle.cc>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>

Compiler is not happy about a couple of symbols that, it thinks,
are not declared:

  warning: symbol 'acpi_device_lock' was not declared. Should it be static?
  warning: symbol 'acpi_wakeup_device_list' was not declared. Should it be static?

Include "sleep.h" to have them explicitly declared and make
the compiler happy.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/scan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index ec1c9bec8bae..5b145f1aaa1b 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -23,6 +23,7 @@
 #include <linux/dma-direct.h>
 
 #include "internal.h"
+#include "sleep.h"
 
 #define ACPI_BUS_CLASS			"system_bus"
 #define ACPI_BUS_HID			"LNXSYBUS"
-- 
2.40.0.1.gaa8946217a0b

