Return-Path: <sashal@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D866F81FCF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 26AE781F99
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1682910360;
 bh=hRj1ydpVYptJsvNmiO59+UYPMUE4NUJHzAScAHy8VdI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Cx9qAJSoQhYmAbyv8EcMAwuLdPLpuSH8OiUshZ6WABU/c1V1Y/BlmmmZ0ogXuEFtG
 90Q8wQ+Ez/pOymLGPAfZl6LiJCkrCVCwWFYHz4XD6l2lfH1VltG4AAuhPSMJfCTZOD
 5cax4pUYHsL4a5kE+lg472p8mEef+9ulwZ5G76aV9DfPJ1GMyK3TKMiMK8CBcvI66G
 LFNN5Jv3cblzWg7/Qbbgy6YBaCZqn4U+DFU7MND9/GTSaZpkKnSBti+1hMFPZGmpMD
 wS1G4KAhRZI4WCFAjTdT79mo82KKkbm1xIu6cznjh6iQGF0o7eMa/+5LaUsKNP+OB/
 kqFzsKbt15mlA==
From: Sasha Levin <sashal@kernel.org>
Message-Id: <20230501030540.3254928-10-sashal@kernel.org>
In-Reply-To: <20230501030540.3254928-1-sashal@kernel.org>
References: <20230501030540.3254928-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Acpica-devel] [PATCH AUTOSEL 5.10 10/12] ACPICA: ACPICA: check
	null return of ACPI_ALLOCATE_ZEROED in acpi_db_display_objects
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Mon, 01 May 2023 03:06:03 -0000
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, void0red <30990023+void0red@users.noreply.github.com>, Bob Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org

From: void0red <30990023+void0red@users.noreply.github.com>

[ Upstream commit ae5a0eccc85fc960834dd66e3befc2728284b86c ]

ACPICA commit 0d5f467d6a0ba852ea3aad68663cbcbd43300fd4

ACPI_ALLOCATE_ZEROED may fails, object_info might be null and will cause
null pointer dereference later.

Link: https://github.com/acpica/acpica/commit/0d5f467d
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpica/dbnames.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/acpica/dbnames.c b/drivers/acpi/acpica/dbnames.c
index 3615e1a6efd8a..b91155ea9c343 100644
--- a/drivers/acpi/acpica/dbnames.c
+++ b/drivers/acpi/acpica/dbnames.c
@@ -652,6 +652,9 @@ acpi_status acpi_db_display_objects(char *obj_type_arg, char *display_count_arg)
 		object_info =
 		    ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_object_info));
 
+		if (!object_info)
+			return (AE_NO_MEMORY);
+
 		/* Walk the namespace from the root */
 
 		(void)acpi_walk_namespace(ACPI_TYPE_ANY, ACPI_ROOT_OBJECT,
-- 
2.39.2

