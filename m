Content-Type: multipart/mixed; boundary="===============1089834279880379648=="
MIME-Version: 1.0
From: Len Brown <lenb at kernel.org>
Subject: Re: [Devel] [patch] prevent possible NULL dereference. (fwd)
Date: Wed, 09 Dec 2009 15:36:28 -0500
Message-ID: <alpine.LFD.2.00.0912091536000.24891@localhost.localdomain>
In-Reply-To: 4911F71203A09E4D9981D27F9D83085840DA9C4E@orsmsx503.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1089834279880379648==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> Was this in response to a specific problem seen in the field?

I don't think so, the submitter refers to a static code checker --
simply identifying a use before test.

-Len

> =

> >-----Original Message-----
> >From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] On =
Behalf
> >Of Len Brown
> >Sent: Wednesday, December 09, 2009 11:35 AM
> >To: devel(a)acpica.org
> >Cc: linux-acpi(a)vger.kernel.org; Dan Carpenter
> >Subject: [Devel] [patch] prevent possible NULL dereference. (fwd)
> >
> >forwarded to devel(a)acpica.org
> >
> >thanks,
> >Len Brown, Intel Open Source Technology Center
> >
> >---------- Forwarded message ----------
> >Date: Tue, 10 Nov 2009 11:02:49 +0200 (SAST)
> >From: Dan Carpenter <error27(a)gmail.com>
> >To: linux-acpi(a)vger.kernel.org
> >Cc: lenb(a)kernel.org
> >Subject: [patch] prevent possible NULL dereference.
> >
> >Move the check for walk_state->thread before the dereference.
> >
> >Found by smatch static checker.  Compile tested.
> >
> >regards,
> >dan carpenter
> >
> >Signed-off-by: Dan Carpenter <error27(a)gmail.com>
> >
> >--- orig/drivers/acpi/acpica/exmutex.c	2009-11-07 09:46:53.000000000
> >+0200
> >+++ devel/drivers/acpi/acpica/exmutex.c	2009-11-07 09:48:16.000000000
> >+0200
> >@@ -375,6 +375,15 @@
> > 		return_ACPI_STATUS(AE_AML_MUTEX_NOT_ACQUIRED);
> > 	}
> >
> >+	/* Must have a valid thread ID */
> >+
> >+	if (!walk_state->thread) {
> >+		ACPI_ERROR((AE_INFO,
> >+			    "Cannot release Mutex [%4.4s], null thread info",
> >+			    acpi_ut_get_node_name(obj_desc->mutex.node)));
> >+		return_ACPI_STATUS(AE_AML_INTERNAL);
> >+	}
> >+
> > 	/*
> > 	 * The Mutex is owned, but this thread must be the owner.
> > 	 * Special case for Global Lock, any thread can release
> >@@ -392,15 +401,6 @@
> > 		return_ACPI_STATUS(AE_AML_NOT_OWNER);
> > 	}
> >
> >-	/* Must have a valid thread ID */
> >-
> >-	if (!walk_state->thread) {
> >-		ACPI_ERROR((AE_INFO,
> >-			    "Cannot release Mutex [%4.4s], null thread info",
> >-			    acpi_ut_get_node_name(obj_desc->mutex.node)));
> >-		return_ACPI_STATUS(AE_AML_INTERNAL);
> >-	}
> >-
> > 	/*
> > 	 * The sync level of the mutex must be equal to the current sync
> >level. In
> > 	 * other words, the current level means that at least one mutex at
> >that
> >--
> >To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> >the body of a message to majordomo(a)vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >_______________________________________________
> >Devel mailing list
> >Devel(a)acpica.org
> >http://lists.acpica.org/listinfo/devel
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo(a)vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--===============1089834279880379648==--

