Content-Type: multipart/mixed; boundary="===============1968515378911927183=="
MIME-Version: 1.0
From: Alexey Starikovskiy <astarikovskiy at suse.de>
Subject: [Devel] [PATCH 1/4] ACPICA: Fix leak in DeleteSemaphore
Date: Fri, 28 May 2010 17:56:49 +0400
Message-ID: <20100528135648.26498.61828.stgit@thinkpad>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1968515378911927183==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Really delete semaphore, so it does not show up as leak in memory debuggers.

Signed-off-by: Alexey Starikovskiy <astarikovskiy(a)suse.de>
---

 0 files changed, 0 insertions(+), 0 deletions(-)


diff --git a/source/os_specific/service_layers/osunixxf.c b/source/os_speci=
fic/service_layers/osunixxf.c
index b457745..e90e22a 100644
--- a/source/os_specific/service_layers/osunixxf.c
+++ b/source/os_specific/service_layers/osunixxf.c
@@ -575,6 +575,8 @@ AcpiOsDeleteSemaphore (
         return (AE_BAD_PARAMETER);
     }
 =

+    AcpiOsFree (Sem);
+
     return (AE_OK);
 }
 =



--===============1968515378911927183==--

