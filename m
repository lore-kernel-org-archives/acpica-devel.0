Content-Type: multipart/mixed; boundary="===============3686916515112825866=="
MIME-Version: 1.0
From: Zhang Rui <rui.zhang at intel.com>
Subject: [Devel] [PATCH] Execute "orphan" _REG method for specified EC device
Date: Thu, 13 Dec 2012 15:12:56 +0800
Message-ID: <1355382776.2276.8.camel@rzhang1-mobl4>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3686916515112825866==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From 7b7c81250eb6511d9f237bdd96f4f2f61231c1ec Mon Sep 17 00:00:00 2001
From: Zhang Rui <rui.zhang(a)intel.com>
Date: Thu, 13 Dec 2012 11:44:19 +0800
Subject: [PATCH] Execute "orphan" _REG method for specified EC device

As it is always the EC device driver that installs the
EC address space handler, we can make the assumption that
the ACPI_NAMESPACE_NODE parameter of AcpiEvInstallHandler
always points to the EC device node.
Thus we do not need to look for EC device in ECDT.

https://bugzilla.kernel.org/show_bug.cgi?id=3D15707

Signed-off-by: Zhang Rui <rui.zhang(a)intel.com>
---
 source/components/events/evregion.c |   39 +++++++------------------------=
----
 1 file changed, 8 insertions(+), 31 deletions(-)

diff --git a/source/components/events/evregion.c b/source/components/events=
/evregion.c
index 2ab7922..7a619be 100644
--- a/source/components/events/evregion.c
+++ b/source/components/events/evregion.c
@@ -135,7 +135,7 @@ AcpiEvHasDefaultHandler (
 =

 static void
 AcpiEvOrphanEcRegMethod (
-    void);
+    ACPI_NAMESPACE_NODE     *Node);
 =

 static ACPI_STATUS
 AcpiEvRegRun (
@@ -1248,7 +1248,7 @@ AcpiEvExecuteRegMethods (
 =

     if (SpaceId =3D=3D ACPI_ADR_SPACE_EC)
     {
-        AcpiEvOrphanEcRegMethod ();
+        AcpiEvOrphanEcRegMethod (Node);
     }
 =

     return_ACPI_STATUS (Status);
@@ -1326,7 +1326,7 @@ AcpiEvRegRun (
  *
  * FUNCTION:    AcpiEvOrphanEcRegMethod
  *
- * PARAMETERS:  None
+ * PARAMETERS:  Node:		- Namespace node for the EC device
  *
  * RETURN:      None
  *
@@ -1347,32 +1347,19 @@ AcpiEvRegRun (
 =

 static void
 AcpiEvOrphanEcRegMethod (
-    void)
+    ACPI_NAMESPACE_NODE	    *Node)
 {
     ACPI_TABLE_ECDT         *Table;
     ACPI_STATUS             Status;
     ACPI_OBJECT_LIST        Args;
     ACPI_OBJECT             Objects[2];
-    ACPI_NAMESPACE_NODE     *EcDeviceNode;
     ACPI_NAMESPACE_NODE     *RegMethod;
     ACPI_NAMESPACE_NODE     *NextNode;
 =

 =

     ACPI_FUNCTION_TRACE (EvOrphanEcRegMethod);
 =

-
-    /* Get the ECDT (if present in system) */
-
-    Status =3D AcpiGetTable (ACPI_SIG_ECDT, 0,
-        ACPI_CAST_INDIRECT_PTR (ACPI_TABLE_HEADER, &Table));
-    if (ACPI_FAILURE (Status))
-    {
-        return_VOID;
-    }
-
-    /* We need a valid EC_ID string */
-
-    if (!(*Table->Id))
+    if (!Node)
     {
         return_VOID;
     }
@@ -1381,19 +1368,9 @@ AcpiEvOrphanEcRegMethod (
 =

     (void) AcpiUtReleaseMutex (ACPI_MTX_NAMESPACE);
 =

-    /* Get a handle to the EC device referenced in the ECDT */
-
-    Status =3D AcpiGetHandle (NULL,
-        ACPI_CAST_PTR (char, Table->Id),
-        ACPI_CAST_PTR (ACPI_HANDLE, &EcDeviceNode));
-    if (ACPI_FAILURE (Status))
-    {
-        goto Exit;
-    }
-
     /* Get a handle to a _REG method immediately under the EC device */
 =

-    Status =3D AcpiGetHandle (EcDeviceNode,
+    Status =3D AcpiGetHandle (Node,
         METHOD_NAME__REG, ACPI_CAST_PTR (ACPI_HANDLE, &RegMethod));
     if (ACPI_FAILURE (Status))
     {
@@ -1407,7 +1384,7 @@ AcpiEvOrphanEcRegMethod (
      * with other space IDs to be present; but the code below will then
      * execute the _REG method with the EC space ID argument.
      */
-    NextNode =3D AcpiNsGetNextNode (EcDeviceNode, NULL);
+    NextNode =3D AcpiNsGetNextNode (Node, NULL);
     while (NextNode)
     {
         if ((NextNode->Type =3D=3D ACPI_TYPE_REGION) &&
@@ -1416,7 +1393,7 @@ AcpiEvOrphanEcRegMethod (
         {
             goto Exit; /* Do not execute _REG */
         }
-        NextNode =3D AcpiNsGetNextNode (EcDeviceNode, NextNode);
+        NextNode =3D AcpiNsGetNextNode (Node, NextNode);
     }
 =

     /* Evaluate the _REG(EC,Connect) method */
-- =

1.7.9.5



--===============3686916515112825866==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-Execute-orphan-_REG-method-for-specified-EC-device.patch"

PkZyb20gN2I3YzgxMjUwZWI2NTExZDlmMjM3YmRkOTZmNGYyZjYxMjMxYzFlYyBNb24gU2VwIDE3
IDAwOjAwOjAwIDIwMDEKRnJvbTogWmhhbmcgUnVpIDxydWkuemhhbmdAaW50ZWwuY29tPgpEYXRl
OiBUaHUsIDEzIERlYyAyMDEyIDExOjQ0OjE5ICswODAwClN1YmplY3Q6IFtQQVRDSF0gRXhlY3V0
ZSAib3JwaGFuIiBfUkVHIG1ldGhvZCBmb3Igc3BlY2lmaWVkIEVDIGRldmljZQoKQXMgaXQgaXMg
YWx3YXlzIHRoZSBFQyBkZXZpY2UgZHJpdmVyIHRoYXQgaW5zdGFsbHMgdGhlCkVDIGFkZHJlc3Mg
c3BhY2UgaGFuZGxlciwgd2UgY2FuIG1ha2UgdGhlIGFzc3VtcHRpb24gdGhhdAp0aGUgQUNQSV9O
QU1FU1BBQ0VfTk9ERSBwYXJhbWV0ZXIgb2YgQWNwaUV2SW5zdGFsbEhhbmRsZXIKYWx3YXlzIHBv
aW50cyB0byB0aGUgRUMgZGV2aWNlIG5vZGUuClRodXMgd2UgZG8gbm90IG5lZWQgdG8gbG9vayBm
b3IgRUMgZGV2aWNlIGluIEVDRFQuCgpodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19i
dWcuY2dpP2lkPTE1NzA3CgpTaWduZWQtb2ZmLWJ5OiBaaGFuZyBSdWkgPHJ1aS56aGFuZ0BpbnRl
bC5jb20+Ci0tLQogc291cmNlL2NvbXBvbmVudHMvZXZlbnRzL2V2cmVnaW9uLmMgfCAgIDM5ICsr
KysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNl
cnRpb25zKCspLCAzMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zb3VyY2UvY29tcG9uZW50
cy9ldmVudHMvZXZyZWdpb24uYyBiL3NvdXJjZS9jb21wb25lbnRzL2V2ZW50cy9ldnJlZ2lvbi5j
CmluZGV4IDJhYjc5MjIuLjdhNjE5YmUgMTAwNjQ0Ci0tLSBhL3NvdXJjZS9jb21wb25lbnRzL2V2
ZW50cy9ldnJlZ2lvbi5jCisrKyBiL3NvdXJjZS9jb21wb25lbnRzL2V2ZW50cy9ldnJlZ2lvbi5j
CkBAIC0xMzUsNyArMTM1LDcgQEAgQWNwaUV2SGFzRGVmYXVsdEhhbmRsZXIgKAogCiBzdGF0aWMg
dm9pZAogQWNwaUV2T3JwaGFuRWNSZWdNZXRob2QgKAotICAgIHZvaWQpOworICAgIEFDUElfTkFN
RVNQQUNFX05PREUgICAgICpOb2RlKTsKIAogc3RhdGljIEFDUElfU1RBVFVTCiBBY3BpRXZSZWdS
dW4gKApAQCAtMTI0OCw3ICsxMjQ4LDcgQEAgQWNwaUV2RXhlY3V0ZVJlZ01ldGhvZHMgKAogCiAg
ICAgaWYgKFNwYWNlSWQgPT0gQUNQSV9BRFJfU1BBQ0VfRUMpCiAgICAgewotICAgICAgICBBY3Bp
RXZPcnBoYW5FY1JlZ01ldGhvZCAoKTsKKyAgICAgICAgQWNwaUV2T3JwaGFuRWNSZWdNZXRob2Qg
KE5vZGUpOwogICAgIH0KIAogICAgIHJldHVybl9BQ1BJX1NUQVRVUyAoU3RhdHVzKTsKQEAgLTEz
MjYsNyArMTMyNiw3IEBAIEFjcGlFdlJlZ1J1biAoCiAgKgogICogRlVOQ1RJT046ICAgIEFjcGlF
dk9ycGhhbkVjUmVnTWV0aG9kCiAgKgotICogUEFSQU1FVEVSUzogIE5vbmUKKyAqIFBBUkFNRVRF
UlM6ICBOb2RlOgkJLSBOYW1lc3BhY2Ugbm9kZSBmb3IgdGhlIEVDIGRldmljZQogICoKICAqIFJF
VFVSTjogICAgICBOb25lCiAgKgpAQCAtMTM0NywzMiArMTM0NywxOSBAQCBBY3BpRXZSZWdSdW4g
KAogCiBzdGF0aWMgdm9pZAogQWNwaUV2T3JwaGFuRWNSZWdNZXRob2QgKAotICAgIHZvaWQpCisg
ICAgQUNQSV9OQU1FU1BBQ0VfTk9ERQkgICAgKk5vZGUpCiB7CiAgICAgQUNQSV9UQUJMRV9FQ0RU
ICAgICAgICAgKlRhYmxlOwogICAgIEFDUElfU1RBVFVTICAgICAgICAgICAgIFN0YXR1czsKICAg
ICBBQ1BJX09CSkVDVF9MSVNUICAgICAgICBBcmdzOwogICAgIEFDUElfT0JKRUNUICAgICAgICAg
ICAgIE9iamVjdHNbMl07Ci0gICAgQUNQSV9OQU1FU1BBQ0VfTk9ERSAgICAgKkVjRGV2aWNlTm9k
ZTsKICAgICBBQ1BJX05BTUVTUEFDRV9OT0RFICAgICAqUmVnTWV0aG9kOwogICAgIEFDUElfTkFN
RVNQQUNFX05PREUgICAgICpOZXh0Tm9kZTsKIAogCiAgICAgQUNQSV9GVU5DVElPTl9UUkFDRSAo
RXZPcnBoYW5FY1JlZ01ldGhvZCk7CiAKLQotICAgIC8qIEdldCB0aGUgRUNEVCAoaWYgcHJlc2Vu
dCBpbiBzeXN0ZW0pICovCi0KLSAgICBTdGF0dXMgPSBBY3BpR2V0VGFibGUgKEFDUElfU0lHX0VD
RFQsIDAsCi0gICAgICAgIEFDUElfQ0FTVF9JTkRJUkVDVF9QVFIgKEFDUElfVEFCTEVfSEVBREVS
LCAmVGFibGUpKTsKLSAgICBpZiAoQUNQSV9GQUlMVVJFIChTdGF0dXMpKQotICAgIHsKLSAgICAg
ICAgcmV0dXJuX1ZPSUQ7Ci0gICAgfQotCi0gICAgLyogV2UgbmVlZCBhIHZhbGlkIEVDX0lEIHN0
cmluZyAqLwotCi0gICAgaWYgKCEoKlRhYmxlLT5JZCkpCisgICAgaWYgKCFOb2RlKQogICAgIHsK
ICAgICAgICAgcmV0dXJuX1ZPSUQ7CiAgICAgfQpAQCAtMTM4MSwxOSArMTM2OCw5IEBAIEFjcGlF
dk9ycGhhbkVjUmVnTWV0aG9kICgKIAogICAgICh2b2lkKSBBY3BpVXRSZWxlYXNlTXV0ZXggKEFD
UElfTVRYX05BTUVTUEFDRSk7CiAKLSAgICAvKiBHZXQgYSBoYW5kbGUgdG8gdGhlIEVDIGRldmlj
ZSByZWZlcmVuY2VkIGluIHRoZSBFQ0RUICovCi0KLSAgICBTdGF0dXMgPSBBY3BpR2V0SGFuZGxl
IChOVUxMLAotICAgICAgICBBQ1BJX0NBU1RfUFRSIChjaGFyLCBUYWJsZS0+SWQpLAotICAgICAg
ICBBQ1BJX0NBU1RfUFRSIChBQ1BJX0hBTkRMRSwgJkVjRGV2aWNlTm9kZSkpOwotICAgIGlmIChB
Q1BJX0ZBSUxVUkUgKFN0YXR1cykpCi0gICAgewotICAgICAgICBnb3RvIEV4aXQ7Ci0gICAgfQot
CiAgICAgLyogR2V0IGEgaGFuZGxlIHRvIGEgX1JFRyBtZXRob2QgaW1tZWRpYXRlbHkgdW5kZXIg
dGhlIEVDIGRldmljZSAqLwogCi0gICAgU3RhdHVzID0gQWNwaUdldEhhbmRsZSAoRWNEZXZpY2VO
b2RlLAorICAgIFN0YXR1cyA9IEFjcGlHZXRIYW5kbGUgKE5vZGUsCiAgICAgICAgIE1FVEhPRF9O
QU1FX19SRUcsIEFDUElfQ0FTVF9QVFIgKEFDUElfSEFORExFLCAmUmVnTWV0aG9kKSk7CiAgICAg
aWYgKEFDUElfRkFJTFVSRSAoU3RhdHVzKSkKICAgICB7CkBAIC0xNDA3LDcgKzEzODQsNyBAQCBB
Y3BpRXZPcnBoYW5FY1JlZ01ldGhvZCAoCiAgICAgICogd2l0aCBvdGhlciBzcGFjZSBJRHMgdG8g
YmUgcHJlc2VudDsgYnV0IHRoZSBjb2RlIGJlbG93IHdpbGwgdGhlbgogICAgICAqIGV4ZWN1dGUg
dGhlIF9SRUcgbWV0aG9kIHdpdGggdGhlIEVDIHNwYWNlIElEIGFyZ3VtZW50LgogICAgICAqLwot
ICAgIE5leHROb2RlID0gQWNwaU5zR2V0TmV4dE5vZGUgKEVjRGV2aWNlTm9kZSwgTlVMTCk7Cisg
ICAgTmV4dE5vZGUgPSBBY3BpTnNHZXROZXh0Tm9kZSAoTm9kZSwgTlVMTCk7CiAgICAgd2hpbGUg
KE5leHROb2RlKQogICAgIHsKICAgICAgICAgaWYgKChOZXh0Tm9kZS0+VHlwZSA9PSBBQ1BJX1RZ
UEVfUkVHSU9OKSAmJgpAQCAtMTQxNiw3ICsxMzkzLDcgQEAgQWNwaUV2T3JwaGFuRWNSZWdNZXRo
b2QgKAogICAgICAgICB7CiAgICAgICAgICAgICBnb3RvIEV4aXQ7IC8qIERvIG5vdCBleGVjdXRl
IF9SRUcgKi8KICAgICAgICAgfQotICAgICAgICBOZXh0Tm9kZSA9IEFjcGlOc0dldE5leHROb2Rl
IChFY0RldmljZU5vZGUsIE5leHROb2RlKTsKKyAgICAgICAgTmV4dE5vZGUgPSBBY3BpTnNHZXRO
ZXh0Tm9kZSAoTm9kZSwgTmV4dE5vZGUpOwogICAgIH0KIAogICAgIC8qIEV2YWx1YXRlIHRoZSBf
UkVHKEVDLENvbm5lY3QpIG1ldGhvZCAqLwotLSAKMS43LjkuNQoK

--===============3686916515112825866==--

