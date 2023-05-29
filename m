Return-Path: <christophe.jaillet@wanadoo.fr>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2D626402F5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B5AC2400FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
 s=t20230301; t=1685341326;
 bh=heLRroh3CNUr9htV1zv4nneIJNvGBNjdwo/3UP94dsE=;
 h=From:To:Cc:Subject:Date;
 b=btPa7tEYR3wji3B48+qtsDvNhW+06Wj/DppAKuqLoJKXBAOt16OnpHCx92Kpwe3z5
 J2UuVDEpW1l+c2zCqsm3vLRGXBf78dY2HCOelqcLAV3yG9FgFexkDr2kirFpGuV/xk
 jCIKPGp313eOanwqlzwb/ENKyu1BZE+6ocLDuLx+bkUj6yF+BWgWEQCfR+gu6r/5Hd
 k3my2hmg3LFEAR4zDlxTl5dXwKJHWD3z+TWxsYDtJWOU0/1vB8SmH2N8/gR631u9p7
 oFRTGBYrlE8gzBEGyH2hTjU32hr8232P8LXMrQFbRzdMWpLSrSrudpR3m5Zzu/z45s
 GfX2z8KLQGm5A==
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Mon, 29 May 2023 08:22:02 +0200
Message-Id: <4464371bc72147e10a392a1873466c8df033039c.1685341309.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Acpica-devel] [PATCH] ACPICA: Slightly simplify an error message
	in acpi_ds_result_push()
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
To: Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, acpica-devel@lists.linuxfoundation.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

'object' is known to be NULL at this point. There is little value to log
it twice in the error message.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/acpi/acpica/dswstate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/dswstate.c b/drivers/acpi/acpica/dswstate.c
index d3841ded3a81..75338a13c802 100644
--- a/drivers/acpi/acpica/dswstate.c
+++ b/drivers/acpi/acpica/dswstate.c
@@ -146,8 +146,8 @@ acpi_ds_result_push(union acpi_operand_object *object,
 
 	if (!object) {
 		ACPI_ERROR((AE_INFO,
-			    "Null Object! Obj=%p State=%p Num=%u",
-			    object, walk_state, walk_state->result_count));
+			    "Null Object! State=%p Num=%u",
+			    walk_state, walk_state->result_count));
 		return (AE_BAD_PARAMETER);
 	}
 
-- 
2.34.1

