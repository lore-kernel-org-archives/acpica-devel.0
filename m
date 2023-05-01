Return-Path: <sashal@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5D3C9606C6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 71C5D605B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1682910233;
 bh=hRj1ydpVYptJsvNmiO59+UYPMUE4NUJHzAScAHy8VdI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GJjuFQEvcCxx4kcBMDeEmlgXj0C58nOHCVWuL24XBuF7Zf8eiNSO/HavWGlvXb/51
 BX63p+Biv8U2w5wpBJQ89q9FaUvBBCUo4sh9TM0G/47JlBWQqnCneBiG0Ek5IybnFj
 i7QqF1Ls1AnS8NERn7nECg3C38MXKY5abSgc09QO6TWgXixEZd14W7QuYS/O8wRxL7
 F1vFQ2LfSIJOIqvCK1exsCuAV0/oN93WCUXx0AqIjadNlwcaP2O61Kgoi7v9GLN1aE
 ahHK9M7FLnI2fgPhH+M4HUE8ZhgpLoGu+IdckDBOyAY7XwIeQMhts8Ywn5fzGhAGwk
 amH0oSOBJEccA==
From: Sasha Levin <sashal@kernel.org>
Message-Id: <20230501030227.3254266-24-sashal@kernel.org>
In-Reply-To: <20230501030227.3254266-1-sashal@kernel.org>
References: <20230501030227.3254266-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Acpica-devel] [PATCH AUTOSEL 6.1 24/33] ACPICA: ACPICA: check null
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
Date: Mon, 01 May 2023 03:03:55 -0000
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

