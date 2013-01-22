Content-Type: multipart/mixed; boundary="===============5120069164366838350=="
MIME-Version: 1.0
From: Lv Zheng <lv.zheng at intel.com>
Subject: [Devel] [PATCH v4 0/3] ACPICA: iASL: Add tables support.
Date: Tue, 22 Jan 2013 10:46:23 +0800
Message-ID: <cover.1358822364.git.lv.zheng@intel.com>
In-Reply-To: cover.1357281212.git.lv.zheng@intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5120069164366838350==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

MID tables can be found in the recent ACPI BIOS enabled Intel MID
platforms. These table includes: VRTC and MTMR.
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
   2. Update VRTC/MTMR table templates.
   3. Remove SFI from table namings.

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
 source/compiler/dttemplate.h |   26 +++++++++++
 source/include/acdisasm.h    |   12 +++++
 source/include/actbl2.h      |   57 +++++++++++++++++++++++
 source/include/actbl3.h      |   59 ++++++++++++++++++++----
 9 files changed, 355 insertions(+), 10 deletions(-)

-- =

1.7.10


--===============5120069164366838350==--

