Content-Type: multipart/mixed; boundary="===============2418870717282913484=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] acpi: set return value to const char for some
 functions
Date: Thu, 15 Oct 2015 19:32:57 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D9806CC@ORSMSX112.amr.corp.intel.com>
In-Reply-To: 1444875266.2718.37.camel@perches.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2418870717282913484==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> Please describe the effects of "const pollution".
> =

> Why isn't it useful to update the functions that don't modify function
> pointer arguments to const?

It's not that const isn't useful, but it can create problems, especially in=
 existing code. It can bubble up to higher functions, causing lots of chang=
es to existing variables and the definition of existing functions. Not to m=
ention lots of casting and recasting.

Example quote:

"if you started to use "const" for some methods you usually forced to use t=
his in most of your code. But the time spent for maintaining (typing, recom=
piling when some const is missing, etc.) of const-correctness in code seems=
 greater than for fixing of possible (very rare) problems caused by not usi=
ng of const-correctness at all."

Also, ACPICA has to be additionally careful because it must compile with ma=
ny different C compilers.



All that being said, I went ahead and made the actual ACPICA changes corres=
ponding to your patches. There were no pollution issues, and it actually si=
mplified the code by eliminating the need for some uses of ACPI_CAST_PTR.

The only issue I found was here, so we won't do this one:

const char
AcpiUtHexToAsciiChar

\acpica\source\include\acutils.h(322) :
    warning C4180: qualifier applied to function type has no meaning; ignor=
ed


Here is the current patch to the actual ACPICA code (which is in a differen=
t format than the Linux version of the code):

diff --git a/source/components/namespace/nsxfname.c b/source/components/nam=
espace/nsxfname.c
index 51cc4f4..c368c1f 100644
--- a/source/components/namespace/nsxfname.c
+++ b/source/components/namespace/nsxfname.c
@@ -249,7 +249,7 @@ AcpiGetName (
 {
     ACPI_STATUS             Status;
     ACPI_NAMESPACE_NODE     *Node;
-    char                    *NodeName;
+    const char              *NodeName;
 =

 =

     /* Parameter validation */
diff --git a/source/components/utilities/utdecode.c b/source/components/uti=
lities/utdecode.c
index 580f891..3d927f5 100644
--- a/source/components/utilities/utdecode.c
+++ b/source/components/utilities/utdecode.c
@@ -191,7 +191,7 @@ const char        *AcpiGbl_RegionTypes[ACPI_NUM_PREDEFI=
NED_REGIONS] =3D
 };
 =

 =

-char *
+const char *
 AcpiUtGetRegionName (
     UINT8                   SpaceId)
 {
@@ -213,7 +213,7 @@ AcpiUtGetRegionName (
         return ("InvalidSpaceId");
     }
 =

-    return (ACPI_CAST_PTR (char, AcpiGbl_RegionTypes[SpaceId]));
+    return (AcpiGbl_RegionTypes[SpaceId]);
 }
 =

 =

@@ -241,7 +241,7 @@ static const char        *AcpiGbl_EventTypes[ACPI_NUM_F=
IXED_EVENTS] =3D
 };
 =

 =

-char *
+const char *
 AcpiUtGetEventName (
     UINT32                  EventId)
 {
@@ -251,7 +251,7 @@ AcpiUtGetEventName (
         return ("InvalidEventID");
     }
 =

-    return (ACPI_CAST_PTR (char, AcpiGbl_EventTypes[EventId]));
+    return (AcpiGbl_EventTypes[EventId]);
 }
 =

 =

@@ -316,21 +316,21 @@ static const char           *AcpiGbl_NsTypeNames[] =
=3D
 };
 =

 =

-char *
+const char *
 AcpiUtGetTypeName (
     ACPI_OBJECT_TYPE        Type)
 {
 =

     if (Type > ACPI_TYPE_INVALID)
     {
-        return (ACPI_CAST_PTR (char, AcpiGbl_BadType));
+        return (AcpiGbl_BadType);
     }
 =

-    return (ACPI_CAST_PTR (char, AcpiGbl_NsTypeNames[Type]));
+    return (AcpiGbl_NsTypeNames[Type]);
 }
 =

 =

-char *
+const char *
 AcpiUtGetObjectTypeName (
     ACPI_OPERAND_OBJECT     *ObjDesc)
 {
@@ -372,7 +372,7 @@ AcpiUtGetObjectTypeName (
  *
  *************************************************************************=
*****/
 =

-char *
+const char *
 AcpiUtGetNodeName (
     void                    *Object)
 {
@@ -448,7 +448,7 @@ static const char           *AcpiGbl_DescTypeNames[] =
=3D
 };
 =

 =

-char *
+const char *
 AcpiUtGetDescriptorName (
     void                    *Object)
 {
@@ -463,9 +463,7 @@ AcpiUtGetDescriptorName (
         return ("Not a Descriptor");
     }
 =

-    return (ACPI_CAST_PTR (char,
-        AcpiGbl_DescTypeNames[ACPI_GET_DESCRIPTOR_TYPE (Object)]));
-
+    return (AcpiGbl_DescTypeNames[ACPI_GET_DESCRIPTOR_TYPE (Object)]);
 }
 =

 =

@@ -542,7 +540,7 @@ AcpiUtGetReferenceName (
 =

 /* Names for internal mutex objects, used for debug output */
 =

-static char                 *AcpiGbl_MutexNames[ACPI_NUM_MUTEX] =3D
+static const char           *AcpiGbl_MutexNames[ACPI_NUM_MUTEX] =3D
 {
     "ACPI_MTX_Interpreter",
     "ACPI_MTX_Namespace",
@@ -552,7 +550,7 @@ static char                 *AcpiGbl_MutexNames[ACPI_NU=
M_MUTEX] =3D
     "ACPI_MTX_Memory",
 };
 =

-char *
+const char *
 AcpiUtGetMutexName (
     UINT32                  MutexId)
 {
diff --git a/source/components/utilities/uthex.c b/source/components/utilit=
ies/uthex.c
index c652f6a..3a32003 100644
--- a/source/components/utilities/uthex.c
+++ b/source/components/utilities/uthex.c
@@ -122,7 +122,7 @@
 =

 /* Hex to ASCII conversion table */
 =

-static char                 AcpiGbl_HexToAscii[] =3D
+static const char           AcpiGbl_HexToAscii[] =3D
 {
     '0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'
 };
diff --git a/source/include/acutils.h b/source/include/acutils.h
index 4fc44ff..f9372a2 100644
--- a/source/include/acutils.h
+++ b/source/include/acutils.h
@@ -278,7 +278,7 @@ AcpiUtInitGlobals (
 =

 #if defined(ACPI_DEBUG_OUTPUT) || defined(ACPI_DEBUGGER)
 =

-char *
+const char *
 AcpiUtGetMutexName (
     UINT32                  MutexId);
 =

@@ -288,15 +288,15 @@ AcpiUtGetNotifyName (
     ACPI_OBJECT_TYPE        Type);
 #endif
 =

-char *
+const char *
 AcpiUtGetTypeName (
     ACPI_OBJECT_TYPE        Type);
 =

-char *
+const char *
 AcpiUtGetNodeName (
     void                    *Object);
 =

-char *
+const char *
 AcpiUtGetDescriptorName (
     void                    *Object);
 =

@@ -304,15 +304,15 @@ const char *
 AcpiUtGetReferenceName (
     ACPI_OPERAND_OBJECT     *Object);
 =

-char *
+const char *
 AcpiUtGetObjectTypeName (
     ACPI_OPERAND_OBJECT     *ObjDesc);
 =

-char *
+const char *
 AcpiUtGetRegionName (
     UINT8                   SpaceId);
 =

-char *
+const char *
 AcpiUtGetEventName (
     UINT32                  EventId);


--===============2418870717282913484==--

