Content-Type: multipart/mixed; boundary="===============5901232917574970753=="
MIME-Version: 1.0
From: Al Stone <ahs3 at redhat.com>
Subject: Re: [Devel] Incorrect NFIT GUID strings in ACPICA 20150515
Date: Fri, 22 May 2015 10:58:13 -0600
Message-ID: <555F6025.8030803@redhat.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E37D2EEE27@ORSMSX112.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5901232917574970753==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 05/22/2015 10:34 AM, Moore, Robert wrote:
> The GUID strings for the ACPI 6.0 NFIT table were incorrect in the recent=
 version of ACPICA (20150515). Here are the corrected strings:
> =

> =

> (From include/acuuid.h):
> =

> /* NVDIMM - NFIT table */
> =

> #define UUID_VOLATILE_MEMORY            "7305944f-fdda-44e3-b16c-3f22d252=
e5d0"
> #define UUID_PERSISTENT_MEMORY          "66f0d379-b4f3-4074-ac43-0d3318b7=
8cdb"
> #define UUID_CONTROL_REGION             "92f701f6-13b4-405d-910b-299367e8=
234c"
> #define UUID_DATA_REGION                "91af0530-5d86-470e-a6b0-0a2db940=
8249"
> #define UUID_VOLATILE_VIRTUAL_DISK      "77ab535a-45fc-624b-5560-f7b281d1=
f96e"
> #define UUID_VOLATILE_VIRTUAL_CD        "3d5abd30-4175-87ce-6d64-d2ade523=
c4bb"
> #define UUID_PERSISTENT_VIRTUAL_DISK    "5cea02c9-4d07-69d3-269f-4496fbe0=
96f9"
> #define UUID_PERSISTENT_VIRTUAL_CD      "08018188-42cd-bb48-100f-5387d53d=
ed3d"
> =

> Sorry for any inconvenience.
> Bob
> =


Will there be a 20150522 (or so) release then?  Or will we just wait until
the next cycle?  Either way, I'll make sure these values get into the distro
packages (i.e., patch 20150515 or use the new version).

Thanks.

-- =

ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3(a)redhat.com
-----------------------------------

--===============5901232917574970753==--

