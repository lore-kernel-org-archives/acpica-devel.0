Content-Type: multipart/mixed; boundary="===============5014991961738736009=="
MIME-Version: 1.0
From: Alexey Starikovskiy <astarikovskiy at suse.de>
Subject: [Devel] [PATCH 2/4] ACPICA: Disable use of caches
Date: Fri, 28 May 2010 17:56:56 +0400
Message-ID: <20100528135655.26498.41300.stgit@thinkpad>
In-Reply-To: 20100528135648.26498.61828.stgit@thinkpad
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5014991961738736009==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Disable cache functionality without touching callers in order to
have cache removal controlled.

Signed-off-by: Alexey Starikovskiy <astarikovskiy(a)suse.de>
---

 0 files changed, 0 insertions(+), 0 deletions(-)


diff --git a/source/components/utilities/utcache.c b/source/components/util=
ities/utcache.c
index 2cee9a1..bdc3ac9 100644
--- a/source/components/utilities/utcache.c
+++ b/source/components/utilities/utcache.c
@@ -287,49 +287,15 @@ AcpiOsReleaseObject (
     ACPI_MEMORY_LIST        *Cache,
     void                    *Object)
 {
-    ACPI_STATUS             Status;
-
-
     ACPI_FUNCTION_ENTRY ();
 =

-
     if (!Cache || !Object)
     {
         return (AE_BAD_PARAMETER);
     }
 =

-    /* If cache is full, just free this object */
-
-    if (Cache->CurrentDepth >=3D Cache->MaxDepth)
-    {
-        ACPI_FREE (Object);
-        ACPI_MEM_TRACKING (Cache->TotalFreed++);
-    }
-
-    /* Otherwise put this object back into the cache */
-
-    else
-    {
-        Status =3D AcpiUtAcquireMutex (ACPI_MTX_CACHES);
-        if (ACPI_FAILURE (Status))
-        {
-            return (Status);
-        }
-
-        /* Mark the object as cached */
-
-        ACPI_MEMSET (Object, 0xCA, Cache->ObjectSize);
-        ACPI_SET_DESCRIPTOR_TYPE (Object, ACPI_DESC_TYPE_CACHED);
-
-        /* Put the object at the head of the cache list */
-
-        * (ACPI_CAST_INDIRECT_PTR (char,
-            &(((char *) Object)[Cache->LinkOffset]))) =3D Cache->ListHead;
-        Cache->ListHead =3D Object;
-        Cache->CurrentDepth++;
-
-        (void) AcpiUtReleaseMutex (ACPI_MTX_CACHES);
-    }
+    ACPI_FREE (Object);
+    ACPI_MEM_TRACKING (Cache->TotalFreed++);
 =

     return (AE_OK);
 }
@@ -353,8 +319,6 @@ AcpiOsAcquireObject (
     ACPI_MEMORY_LIST        *Cache)
 {
     ACPI_STATUS             Status;
-    void                    *Object;
-
 =

     ACPI_FUNCTION_NAME (OsAcquireObject);
 =

@@ -372,61 +336,26 @@ AcpiOsAcquireObject (
 =

     ACPI_MEM_TRACKING (Cache->Requests++);
 =

-    /* Check the cache first */
+    /* The cache is empty, create a new object */
 =

-    if (Cache->ListHead)
-    {
-        /* There is an object available, use it */
-
-        Object =3D Cache->ListHead;
-        Cache->ListHead =3D *(ACPI_CAST_INDIRECT_PTR (char,
-                                &(((char *) Object)[Cache->LinkOffset])));
-
-        Cache->CurrentDepth--;
-
-        ACPI_MEM_TRACKING (Cache->Hits++);
-        ACPI_DEBUG_PRINT ((ACPI_DB_EXEC,
-            "Object %p from %s cache\n", Object, Cache->ListName));
-
-        Status =3D AcpiUtReleaseMutex (ACPI_MTX_CACHES);
-        if (ACPI_FAILURE (Status))
-        {
-            return (NULL);
-        }
-
-        /* Clear (zero) the previously used Object */
-
-        ACPI_MEMSET (Object, 0, Cache->ObjectSize);
-    }
-    else
-    {
-        /* The cache is empty, create a new object */
-
-        ACPI_MEM_TRACKING (Cache->TotalAllocated++);
+    ACPI_MEM_TRACKING (Cache->TotalAllocated++);
 =

 #ifdef ACPI_DBG_TRACK_ALLOCATIONS
-        if ((Cache->TotalAllocated - Cache->TotalFreed) > Cache->MaxOccupi=
ed)
-        {
-            Cache->MaxOccupied =3D Cache->TotalAllocated - Cache->TotalFre=
ed;
-        }
+    if ((Cache->TotalAllocated - Cache->TotalFreed) > Cache->MaxOccupied)
+    {
+        Cache->MaxOccupied =3D Cache->TotalAllocated - Cache->TotalFreed;
+    }
 #endif
 =

-        /* Avoid deadlock with ACPI_ALLOCATE_ZEROED */
+    /* Avoid deadlock with ACPI_ALLOCATE_ZEROED */
 =

-        Status =3D AcpiUtReleaseMutex (ACPI_MTX_CACHES);
-        if (ACPI_FAILURE (Status))
-        {
-            return (NULL);
-        }
-
-        Object =3D ACPI_ALLOCATE_ZEROED (Cache->ObjectSize);
-        if (!Object)
-        {
-            return (NULL);
-        }
+    Status =3D AcpiUtReleaseMutex (ACPI_MTX_CACHES);
+    if (ACPI_FAILURE (Status))
+    {
+        return (NULL);
     }
 =

-    return (Object);
+    return ACPI_ALLOCATE_ZEROED (Cache->ObjectSize);
 }
 #endif /* ACPI_USE_LOCAL_CACHE */
 =



--===============5014991961738736009==--

