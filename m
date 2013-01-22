Content-Type: multipart/mixed; boundary="===============9150249229301826417=="
MIME-Version: 1.0
From: Lv Zheng <lv.zheng at intel.com>
Subject: [Devel] [PATCH v5 0/3] ACPICA: iASL: Add tables support.
Date: Tue, 22 Jan 2013 14:48:13 +0800
Message-ID: <cover.1358836949.git.lv.zheng@intel.com>
In-Reply-To: cover.1357281212.git.lv.zheng@intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============9150249229301826417==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

MID tables can be found in the recent ACPI BIOS enabled Intel MID
platforms. These tables include: VRTC and MTMR.
This patch set introduces MID tables support into ACPICA.
This patch set also updates RASF table definition according to the
ACPI 5.0 specification.

History:
 v1:
   1. Add dump/compile support for VRTC in iASL.
 v2:
   1. Fix mistake in dmtable.c.
 v3:
   1. Fix coding style issue in actbl2.h.
   2. Add dump/compile support for MTMR in iASL.
 v4:
   1. Update RASF table definition.
   2. Remove iASL support for RASF as it is not needed.
   3. Update VRTC/MTMR table templates.
   4. Remove SFI from table namings.
 v5:
   1. Fix content of MTMR table template.
   2. Fix spellings in patch descriptions.

Lv Zheng (3):
  ACPICA: Tables: Update RASF table definitions
  ACPICA: iASL: Add MTMR table support
  ACPICA: iASL: Add VRTC table support

 source/common/dmtable.c      |    2 +
 source/common/dmtbdump.c     |  104 ++++++++++++++++++++++++++++++++++++++=
++++
 source/common/dmtbinfo.c     |   45 ++++++++++++++++++
 source/compiler/dtcompiler.h |   10 ++++
 source/compiler/dttable.c    |   50 ++++++++++++++++++++
 source/compiler/dttemplate.h |   27 +++++++++++
 source/include/acdisasm.h    |   12 +++++
 source/include/actbl2.h      |   57 +++++++++++++++++++++++
 source/include/actbl3.h      |   59 ++++++++++++++++++++----
 9 files changed, 356 insertions(+), 10 deletions(-)

-- =

1.7.10


--===============9150249229301826417==--

