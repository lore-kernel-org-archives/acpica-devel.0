Return-Path: <sashal@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B0AC74060E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0B7D240134
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1682910090;
 bh=hRj1ydpVYptJsvNmiO59+UYPMUE4NUJHzAScAHy8VdI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qYybISOufyUSaw3u2pnmC84TwSrezCz46GGZkMfrtlVTPB9Huv/W0cq3/DbdwoIIr
 cUcU3LsRRDAYeGaimvPoggzsA1GocWmFWKIbWEc800x3VPMn3DbqK+hsuTz9sbU5hl
 vLh0jZLgCb0gIxpdLWG4pbBMupFRwPAc8hbfVnI/ZwdiptU4HGAAHeUhjFOIER7dN5
 WtskKm79srwOBYNuH1zFxeFacvjj/PN0vbAeT9HSX+wYw4sav8+se+QaYXwumr5kPf
 kxR4WkO4CZE9nAbID7AOw2EBFn5q+fIwammME8SmiIBp+asquXxzleVw4CCGxCR2nO
 rZF/hPo23YClQ==
From: Sasha Levin <sashal@kernel.org>
Message-Id: <20230501025945.3253774-27-sashal@kernel.org>
In-Reply-To: <20230501025945.3253774-1-sashal@kernel.org>
References: <20230501025945.3253774-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Acpica-devel] [PATCH AUTOSEL 6.2 27/37] ACPICA: ACPICA: check null
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
Date: Mon, 01 May 2023 03:01:33 -0000
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

