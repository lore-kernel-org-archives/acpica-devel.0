Return-Path: <sashal@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3C920408A5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 47E604089B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1682910422;
 bh=342p/LqQZxMeFHrcgAvtHLZungpIv0bcCYZMTUCByCA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BUyS2tovNLkZsM5z16dnFJRuJ/ifuV+NRM+Bnvha4DisAud3QhAvhJGTLBKj8IW08
 dVYSljPxgbbHHDxdBvzEdU1uzydj86wHrsRygpfcm79J6j6KC37L1ch/l9R+nUU6aM
 FCywIBpV0amCPVnoUAyH+qvrmG5Xp/AvxzS3e3esBaRFabvqcLHq3T6jh2H8ojk71Z
 73HUetknduH85klXN/862sSZ3KzUAFcaQLs0yrg1pYLg0ZYkOYtNIRM7dDuSqv0gm9
 XSBqp2XSU/htL734XcXhew8ieLaknA2WpyeS35e9PlVK9TEXgtLseeU7aXB8NvE4mg
 eCN2p0ADS11AA==
From: Sasha Levin <sashal@kernel.org>
Message-Id: <20230501030653.3255321-6-sashal@kernel.org>
In-Reply-To: <20230501030653.3255321-1-sashal@kernel.org>
References: <20230501030653.3255321-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Acpica-devel] [PATCH AUTOSEL 4.14 6/6] ACPICA: ACPICA: check null
	return of ACPI_ALLOCATE_ZEROED in acpi_db_display_objects
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Mon, 01 May 2023 03:07:04 -0000
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
index 8c207c7725179..658fd7cfbd6cd 100644
--- a/drivers/acpi/acpica/dbnames.c
+++ b/drivers/acpi/acpica/dbnames.c
@@ -600,6 +600,9 @@ acpi_status acpi_db_display_objects(char *obj_type_arg, char *display_count_arg)
 		object_info =
 		    ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_object_info));
 
+		if (!object_info)
+			return (AE_NO_MEMORY);
+
 		/* Walk the namespace from the root */
 
 		(void)acpi_walk_namespace(ACPI_TYPE_ANY, ACPI_ROOT_OBJECT,
-- 
2.39.2

