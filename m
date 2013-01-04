Content-Type: multipart/mixed; boundary="===============1779215377544986627=="
MIME-Version: 1.0
From: Lv Zheng <lv.zheng at intel.com>
Subject: [Devel] [PATCH v3 0/2] ACPICA: iASL: Add MID table support.
Date: Fri, 04 Jan 2013 14:37:05 +0800
Message-ID: <cover.1357281212.git.lv.zheng@intel.com>
In-Reply-To: 9dce16ee5a6821f10e419c5b286fb0c287200758.1357277898.git.lv.zheng@intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1779215377544986627==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

MID tables can be found in the recent ACPI BIOS enabled Intel MID
platforms. These table includes: VRTC and MTMR.
This patch set introduces MID tables support into ACPICA.

History:
 v1:
   1. Add dump/compile support for VRTC in iASL.
 v2:
   1. Fix mistake in dmtable.c.
 v3:
   1. Fix coding style issue in actbl2.h.
   2. Add dump/compile support for MTMR in iASL.

Lv Zheng (2):
  ACPICA: iASL: Add MTMR table support.
  ACPICA: iASL: Add VRTC table support.

 source/common/dmtable.c      |    2 +
 source/common/dmtbdump.c     |  104 ++++++++++++++++++++++++++++++++++++++=
++++
 source/common/dmtbinfo.c     |   45 ++++++++++++++++++
 source/compiler/dtcompiler.h |   10 ++++
 source/compiler/dttable.c    |   50 ++++++++++++++++++++
 source/compiler/dttemplate.h |   25 ++++++++++
 source/include/acdisasm.h    |   12 +++++
 source/include/actbl2.h      |   57 +++++++++++++++++++++++
 8 files changed, 305 insertions(+)

-- =

1.7.10


--===============1779215377544986627==--

