Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792741612;
	b=x9uLdTUweZMirbUynKbwL9JvhhiWk8XIplsrZBjsVvm+H9VrRqYJCDCdtniFY2JhDJ9n
	 LXNTXkpC6JlknN+2oCZf+ZFWm/i2JW1ZcI0FuH2XhhEPIk//+NfGjl60T/RXVGwBgRHN9
	 27Q4Otf95PRM4VMBvIrG2s3qutn4UvpRfMEASRd75FScuohyLLk1EiewDBq65qKkRasid
	 aD/HuHIbxkdohXaJ3Jix2P3+lPQIFRz/eBN9ltqJEJ77tH70Vwjr5sOF6/balbW/92sCy
	 7QX7XCnVqNLr6NuoDUo/g/Z4zXxQh69MYFq3ZmJOE3OMj47cH+T3+NW6yZfJLwvo7eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792741612;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=i1/WuK8dW5/pyvLMu4dA8Lh0jH9UtF3/CqDkw4QhSPY=;
	b=GxnHyglJWeUR1K6GnpTm6FUWKFm1X14zvT5MaJyu6leWTShfAP7ZhEgi9rmsZNmJO4Mz
	 GQ/O0tcACwbaQQQLYTEBUqzSfrsm5S/FpPnByGlLZEvXrlAB+YNtivf6EF/aRGdGUG+Kk
	 Sq2UbCC5RgQAh3H7hnZZ5GByFEffGDPYMzFfxnFzraXSU7KK2qK+D57HYHcQUxASR/3ZL
	 +dV5NcKYuqiRHkRHeirmKW0KilD0jfBHUqrqgdxtH5xug4r3kTnviOOrP0utvoF5mEj/X
	 LHv6ZOq6wJtG+eyjuG5/dlVobRJmXBAdb8LqwDcjmSuHii1t9tNoHMo5pclzz/njNfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C9iww4Yv;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF3D606A323
	for <acpica-devel@lists.linux.dev>; Fri, 23 Oct 2026 07:46:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAF3D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C9iww4Yv
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so992482eec.0
        for <acpica-devel@lists.linux.dev>; Fri, 23 Oct 2026 00:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792741611; x=1793346411; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=i1/WuK8dW5/pyvLMu4dA8Lh0jH9UtF3/CqDkw4QhSPY=;
        b=C9iww4YvgXSxaV5cRsr0DHuYVsKdsqRULAtL2dWWB8Tx6zXPdMU84tmtq0saIE6mJ7
         R5H/RF1xh6hF4KZdL7bQ3v3otpuf/pg1LdPuDhU++CB4mzRjkTWZBmpu0k5rRyKov0w9
         m8ymsZc/GLrJWAe2MT5RohEK7Zjiwq1TJtcrF90jYZH5+VMfgefgJj2W9NqKxoFWaRDr
         +hqWqz4+hBqLR8FHIn1VwDMKwLkji5SFhL11h4RJyFLvF7oIqSALFxt4qbSE7ku1TBkz
         Gp4v/Q3SMpjMckZkHmqMNWd2P4NLV0C1taz9Wz+dlYpUJPYxDUCVyxtofLB6WaWm16mE
         e7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792741611; x=1793346411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i1/WuK8dW5/pyvLMu4dA8Lh0jH9UtF3/CqDkw4QhSPY=;
        b=SuubR7vc1CY9rb52Ef74Cc2DTEuRJjRvkTSwUNGjvvC5H29GWiOGz1jRDixHqk4LpD
         kpI//aOl+E/76uevpdtJEhlqjf6O2F73kIMTypnnGgns2uOY5o3LzWfv9ryHtrPl0M+8
         yr4jR5cAFhKTHQ1wfKQyJDj7lf5fWBMYzTFlnGFH9txaa+Lds/bgPL8l83LvIlggTdRY
         uEyxSBPZHNNQC8IlwLNon50wvQIEsE4qdafJZB03pU6cwxvkT8l8szoRxCvYUyGbgwwA
         gb9y0fMz63b+zbK5fW/1cZw/chW/mKn++d/ynq9AWKuVApwM1rqymLUC7OnA9oC6kFj8
         U4fQ==
X-Forwarded-Encrypted: i=1; AKwUvByIJIAuVvFrZJdblvi0LqbSwHYENcyUq9Oc7RSssGpkfFGx9NuGxSqKwwGFGjbxKECtMHVEqw+ZTPe49Bk=@lists.linux.dev
X-Gm-Message-State: AFq9FYIFtfRqaMnXB03O1NbYvoZFcc7h5rAIBqRv/QoMV0tAqveapmHp
	4BZ2zZZ2K0skuM2lJ+x/L7bJzEDvksTK6uSNgPeHw9Rxci+CamoEZg9j
X-Gm-Gg: AYBFou12it3QsH/P6yuZ/dhsPeMGlcee2Yzpco+h9m/xBwA1pA4ZZxX03DsVpYyPV2Y
	YAoEX7t7vrWSLvlyRxvZTLlLmJVI0OX49ZvedveMMkFLBKggs6YeeUNRW25nVfeMA6zcaWg4fyb
	RQ5IB13baQ8GI2GPpCACahPE/2rZtsWZK2sSyzfgOjYG9qbzGoNB4eEoQXgKXfDPWyFuISFbc67
	/DjNjiWKt/QE+ffWWEUYI7FN027LhPZ+6ER2lZQRJtxQeY8X4waSA3ueBYyh2a970WjrEyGT5ik
	xZSp97IYRHyIONZg969qd4rb9xRh0Mx2u/L5tERKRws/TJJTEYqGJpCu7hX2GlKtyiCMXrtkbH7
	2Ey+NMp9CoTaip0e0SPXaGpRo8qoFG0pU6GgVxi/n5M2yzE96ondRBwXqpD+ugQCBGLGgc/Z38x
	xpE4wdI2hVIK5jCdeVJyX6qZdqDHussE96E3OlBt0Eou0/wB9NfZskRFfey/h3uqvOdqf1O9Hzl
	FlLsHdSnY7qSVfUNLbt/jQad5AT824QJ0I0Rm6MrZsUkN2OYqS7eu747HhH2ExFzZQ=
X-Received: by 2002:a05:7301:619b:10b0:35d:7565:8577 with SMTP id 5a478bee46e88-369d980cabamr1885558eec.15.1792741610605;
        Fri, 23 Oct 2026 00:46:50 -0700 (PDT)
Received: from Hruday.lan ([2409:4091:903b:c404:6995:b26d:3edb:5202])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369d9a72ff2sm4479935eec.0.2026.10.23.00.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 00:46:50 -0700 (PDT)
From: Rahul Rao <shreeramrahul94@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Cc: Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot+e1268acad3c273b12120@syzkaller.appspotmail.com,
	Rahul Rao <shreeramrahul94@gmail.com>
Subject: [PATCH] ACPI: ACPICA: Fall back to inline recursion if update state allocation fails
Date: Fri, 23 Oct 2026 13:15:02 +0530
Message-ID: <20261023074502.103681-1-shreeramrahul94@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Post: <mailto:acpica-devel@lists.linux.dev>
List-Help: <mailto:acpica-devel+help@lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:acpica-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When acpi_ut_update_object_reference() traverses nested package elements
or field elements to increment/decrement reference counts, it allocates a
temporary union acpi_generic_state via
acpi_ut_create_update_state_and_push()
to avoid deep C stack recursion.

If memory allocation fails (for instance, under slab fault injection),
the function aborts mid-traversal. This leaves sub-object reference counts
out of sync with parent containers. Callers cannot readily roll back the
partial updates, leading to reference count underflows and slab
use-after-free bugs (such as in acpi_ns_check_package()).

Fix this by introducing acpi_ut_push_or_update_object(). When allocating
a deferred update state fails, fall back to inline recursive traversal up
to a safe bounded recursion limit (ACPI_UT_MAX_UPDATE_DEPTH = 16). This
ensures reference counts remain consistent even during severe memory
pressure.

Reported-by: syzbot+e1268acad3c273b12120@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e1268acad3c273b12120
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Rahul Rao <shreeramrahul94@gmail.com>
---
 drivers/acpi/acpica/utdelete.c | 78 +++++++++++++++++++++++-----------
 1 file changed, 54 insertions(+), 24 deletions(-)

diff --git a/drivers/acpi/acpica/utdelete.c b/drivers/acpi/acpica/utdelete.c
index e8180099d01f..87ae66c7eee8 100644
--- a/drivers/acpi/acpica/utdelete.c
+++ b/drivers/acpi/acpica/utdelete.c
@@ -20,6 +20,14 @@ static void acpi_ut_delete_internal_obj(union acpi_operand_object *object);
 static void
 acpi_ut_update_ref_count(union acpi_operand_object *object, u32 action);
 
+static acpi_status
+acpi_ut_update_object_reference_depth(union acpi_operand_object *object,
+				      u16 action, u32 depth);
+
+/* Max inline nesting used when a deferred update state cannot be allocated */
+
+#define ACPI_UT_MAX_UPDATE_DEPTH	16
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ut_delete_internal_obj
@@ -457,6 +465,28 @@ acpi_ut_update_ref_count(union acpi_operand_object *object, u32 action)
 	}
 }
 
+/*
+ * Queue an object for a later reference count update. If the update state
+ * cannot be allocated, update the object right away instead of failing: an
+ * update abandoned half way leaves the counts of the sub-objects out of
+ * step with the count of their parent, and callers (most of which cannot
+ * handle an error) would later drop references that were never added.
+ */
+static acpi_status
+acpi_ut_push_or_update_object(union acpi_operand_object *object, u16 action,
+			      union acpi_generic_state **state_list, u32 depth)
+{
+	acpi_status status;
+
+	status = acpi_ut_create_update_state_and_push(object, action,
+						      state_list);
+	if (ACPI_SUCCESS(status) || depth >= ACPI_UT_MAX_UPDATE_DEPTH)
+		return status;
+
+	return acpi_ut_update_object_reference_depth(object, action,
+						      depth + 1);
+}
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ut_update_object_reference
@@ -480,6 +510,13 @@ acpi_ut_update_ref_count(union acpi_operand_object *object, u32 action)
 
 acpi_status
 acpi_ut_update_object_reference(union acpi_operand_object *object, u16 action)
+{
+	return acpi_ut_update_object_reference_depth(object, action, 0);
+}
+
+static acpi_status
+acpi_ut_update_object_reference_depth(union acpi_operand_object *object,
+				      u16 action, u32 depth)
 {
 	acpi_status status = AE_OK;
 	union acpi_generic_state *state_list = NULL;
@@ -560,8 +597,9 @@ acpi_ut_update_object_reference(union acpi_operand_object *object, u16 action)
 					 * for later processing (this eliminates recursion.)
 					 */
 					status =
-					    acpi_ut_create_update_state_and_push
-					    (next_object, action, &state_list);
+					    acpi_ut_push_or_update_object
+					    (next_object, action, &state_list,
+					     depth);
 					if (ACPI_FAILURE(status)) {
 						goto error_exit;
 					}
@@ -579,31 +617,23 @@ acpi_ut_update_object_reference(union acpi_operand_object *object, u16 action)
 
 		case ACPI_TYPE_LOCAL_BANK_FIELD:
 
-			next_object = object->bank_field.bank_obj;
-			status =
-			    acpi_ut_create_update_state_and_push(object->
-								 bank_field.
-								 region_obj,
-								 action,
-								 &state_list);
-			if (ACPI_FAILURE(status)) {
-				goto error_exit;
-			}
-			break;
+		next_object = object->bank_field.bank_obj;
+		status = acpi_ut_push_or_update_object(
+				object->bank_field.region_obj, action,
+				&state_list, depth);
+		if (ACPI_FAILURE(status))
+			goto error_exit;
+		break;
 
 		case ACPI_TYPE_LOCAL_INDEX_FIELD:
 
-			next_object = object->index_field.index_obj;
-			status =
-			    acpi_ut_create_update_state_and_push(object->
-								 index_field.
-								 data_obj,
-								 action,
-								 &state_list);
-			if (ACPI_FAILURE(status)) {
-				goto error_exit;
-			}
-			break;
+		next_object = object->index_field.index_obj;
+		status = acpi_ut_push_or_update_object(
+				object->index_field.data_obj, action,
+				&state_list, depth);
+		if (ACPI_FAILURE(status))
+			goto error_exit;
+		break;
 
 		case ACPI_TYPE_LOCAL_REFERENCE:
 			/*
-- 
2.43.0

