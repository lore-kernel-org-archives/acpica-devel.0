Content-Type: multipart/mixed; boundary="===============4791404056101521770=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] Re: [PATCH] ACPICA: Fix a typo
Date: Fri, 26 Mar 2021 14:56:46 +0000
Message-ID: <BYAPR11MB325648858A1C06D2E80DF7AE87619@BYAPR11MB3256.namprd11.prod.outlook.com>
In-Reply-To: 20210326001922.4767-1-unixbhaskar@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4791404056101521770==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Please make a pull request for this on our github.
Thanks,
Bob


-----Original Message-----
From: Bhaskar Chowdhury <unixbhaskar(a)gmail.com> =

Sent: Thursday, March 25, 2021 5:19 PM
To: Moore, Robert <robert.moore(a)intel.com>; Kaneda, Erik <erik.kaneda(a)i=
ntel.com>; Wysocki, Rafael J <rafael.j.wysocki(a)intel.com>; lenb(a)kernel.=
org; linux-acpi(a)vger.kernel.org; devel(a)acpica.org; linux-kernel(a)vger.=
kernel.org
Cc: rdunlap(a)infradead.org; Bhaskar Chowdhury <unixbhaskar(a)gmail.com>
Subject: [PATCH] ACPICA: Fix a typo


s/optimzation/optimization/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar(a)gmail.com>
---
 include/acpi/acoutput.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h index 1538a6=
853822..1b4c45815695 100644
--- a/include/acpi/acoutput.h
+++ b/include/acpi/acoutput.h
@@ -362,7 +362,7 @@
  *
  * A less-safe version of the macros is provided for optional use if the
  * compiler uses excessive CPU stack (for example, this may happen in the
- * debug case if code optimzation is disabled.)
+ * debug case if code optimization is disabled.)
  */

 /* Exit trace helper macro */
--
2.26.2

--===============4791404056101521770==--

