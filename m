Content-Type: multipart/mixed; boundary="===============6047937160194076599=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] Emergency ACPICA bug fix (bugzilla 1016)
Date: Tue, 07 May 2013 21:35:27 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E36FE54194@ORSMSX103.amr.corp.intel.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E36FE4F56E@FMSMSX153.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6047937160194076599==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Attached (and below), please find a high-priority fix for ACPICA version 20=
130328 and later.
Sorry for any inconvenience,
Bob



Fix for _INI regression.

This change fixes a problem introduced in 20130328 where _INI methods are n=
o longer executed properly because of a memory block that is not initialize=
d properly.
ACPICA BZ 1016. Tomasz Nowicki <tomasz.nowicki(a)linaro.org>.

diff --git a/source/components/namespace/nsinit.c b/source/components/names=
pace/nsinit.c
index c1544cd..8619d68 100644
--- a/source/components/namespace/nsinit.c
+++ b/source/components/namespace/nsinit.c
@@ -690,6 +690,7 @@ AcpiNsInitOneDevice (
     ACPI_DEBUG_EXEC (AcpiUtDisplayInitPathname (
         ACPI_TYPE_METHOD, DeviceNode, METHOD_NAME__INI));
 =

+    ACPI_MEMSET (Info, 0, sizeof (ACPI_EVALUATE_INFO));
     Info->PrefixNode =3D DeviceNode;
     Info->RelativePathname =3D METHOD_NAME__INI;
     Info->Parameters =3D NULL;

--===============6047937160194076599==
Content-Type: application/octet-stream
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="nsinit.patch"

ZGlmZiAtLWdpdCBhL3NvdXJjZS9jb21wb25lbnRzL25hbWVzcGFjZS9uc2luaXQuYyBiL3NvdXJj
ZS9jb21wb25lbnRzL25hbWVzcGFjZS9uc2luaXQuYwppbmRleCBjMTU0NGNkLi44NjE5ZDY4IDEw
MDY0NAotLS0gYS9zb3VyY2UvY29tcG9uZW50cy9uYW1lc3BhY2UvbnNpbml0LmMKKysrIGIvc291
cmNlL2NvbXBvbmVudHMvbmFtZXNwYWNlL25zaW5pdC5jCkBAIC02OTAsNiArNjkwLDcgQEAgQWNw
aU5zSW5pdE9uZURldmljZSAoCiAgICAgQUNQSV9ERUJVR19FWEVDIChBY3BpVXREaXNwbGF5SW5p
dFBhdGhuYW1lICgKICAgICAgICAgQUNQSV9UWVBFX01FVEhPRCwgRGV2aWNlTm9kZSwgTUVUSE9E
X05BTUVfX0lOSSkpOwogCisgICAgQUNQSV9NRU1TRVQgKEluZm8sIDAsIHNpemVvZiAoQUNQSV9F
VkFMVUFURV9JTkZPKSk7CiAgICAgSW5mby0+UHJlZml4Tm9kZSA9IERldmljZU5vZGU7CiAgICAg
SW5mby0+UmVsYXRpdmVQYXRobmFtZSA9IE1FVEhPRF9OQU1FX19JTkk7CiAgICAgSW5mby0+UGFy
YW1ldGVycyA9IE5VTEw7Cg==

--===============6047937160194076599==--

