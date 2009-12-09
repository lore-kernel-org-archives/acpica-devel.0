Content-Type: multipart/mixed; boundary="===============2729689798569044677=="
MIME-Version: 1.0
From: Len Brown <lenb at kernel.org>
Subject: [Devel] [patch] prevent possible NULL dereference. (fwd)
Date: Wed, 09 Dec 2009 14:34:56 -0500
Message-ID: <alpine.LFD.2.00.0912091433040.24891@localhost.localdomain>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2729689798569044677==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

forwarded to devel(a)acpica.org

thanks,
Len Brown, Intel Open Source Technology Center

---------- Forwarded message ----------
Date: Tue, 10 Nov 2009 11:02:49 +0200 (SAST)
From: Dan Carpenter <error27(a)gmail.com>
To: linux-acpi(a)vger.kernel.org
Cc: lenb(a)kernel.org
Subject: [patch] prevent possible NULL dereference.

Move the check for walk_state->thread before the dereference.

Found by smatch static checker.  Compile tested.

regards,
dan carpenter

Signed-off-by: Dan Carpenter <error27(a)gmail.com>

--- orig/drivers/acpi/acpica/exmutex.c	2009-11-07 09:46:53.000000000 +0200
+++ devel/drivers/acpi/acpica/exmutex.c	2009-11-07 09:48:16.000000000 +0200
@@ -375,6 +375,15 @@
 		return_ACPI_STATUS(AE_AML_MUTEX_NOT_ACQUIRED);
 	}
 =

+	/* Must have a valid thread ID */
+
+	if (!walk_state->thread) {
+		ACPI_ERROR((AE_INFO,
+			    "Cannot release Mutex [%4.4s], null thread info",
+			    acpi_ut_get_node_name(obj_desc->mutex.node)));
+		return_ACPI_STATUS(AE_AML_INTERNAL);
+	}
+
 	/*
 	 * The Mutex is owned, but this thread must be the owner.
 	 * Special case for Global Lock, any thread can release
@@ -392,15 +401,6 @@
 		return_ACPI_STATUS(AE_AML_NOT_OWNER);
 	}
 =

-	/* Must have a valid thread ID */
-
-	if (!walk_state->thread) {
-		ACPI_ERROR((AE_INFO,
-			    "Cannot release Mutex [%4.4s], null thread info",
-			    acpi_ut_get_node_name(obj_desc->mutex.node)));
-		return_ACPI_STATUS(AE_AML_INTERNAL);
-	}
-
 	/*
 	 * The sync level of the mutex must be equal to the current sync level. In
 	 * other words, the current level means that at least one mutex at that
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo(a)vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

--===============2729689798569044677==--

