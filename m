Content-Type: multipart/mixed; boundary="===============3074076516005859746=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] Incorrect NFIT GUID strings in ACPICA 20150515
Date: Fri, 22 May 2015 16:34:10 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D2EEE27@ORSMSX112.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3074076516005859746==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The GUID strings for the ACPI 6.0 NFIT table were incorrect in the recent v=
ersion of ACPICA (20150515). Here are the corrected strings:


(From include/acuuid.h):

/* NVDIMM - NFIT table */

#define UUID_VOLATILE_MEMORY            "7305944f-fdda-44e3-b16c-3f22d252e5=
d0"
#define UUID_PERSISTENT_MEMORY          "66f0d379-b4f3-4074-ac43-0d3318b78c=
db"
#define UUID_CONTROL_REGION             "92f701f6-13b4-405d-910b-299367e823=
4c"
#define UUID_DATA_REGION                "91af0530-5d86-470e-a6b0-0a2db94082=
49"
#define UUID_VOLATILE_VIRTUAL_DISK      "77ab535a-45fc-624b-5560-f7b281d1f9=
6e"
#define UUID_VOLATILE_VIRTUAL_CD        "3d5abd30-4175-87ce-6d64-d2ade523c4=
bb"
#define UUID_PERSISTENT_VIRTUAL_DISK    "5cea02c9-4d07-69d3-269f-4496fbe096=
f9"
#define UUID_PERSISTENT_VIRTUAL_CD      "08018188-42cd-bb48-100f-5387d53ded=
3d"

Sorry for any inconvenience.
Bob


--===============3074076516005859746==--

