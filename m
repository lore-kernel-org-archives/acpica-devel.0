Content-Type: multipart/mixed; boundary="===============5544866761896301067=="
MIME-Version: 1.0
From: Lv Zheng <lv.zheng at intel.com>
Subject: [Devel] [RFC PATCH v2 0/5] ACPICA: Tables: Add deferred verification
 support
Date: Tue, 16 May 2017 15:13:08 +0800
Message-ID: <cover.1494916766.git.lv.zheng@intel.com>
In-Reply-To: 20170227093432.3308-1-hdegoede@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5544866761896301067==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On linux, we can not verify ACPI tables before installing them into the
global table list in early stage due to the number of slot limitations for
early ioremap. This leaves a problem that we cannot detect duplicated
tables in early stage, causing unwanted error messages seen when the
duplicated tables are failed to be loaded [link #1].

This patchset as ACPICA PR [link #2] adds support to verify tables in
acpi_reallocate_root_tables() which is invoked after installing tables in
early stage, being ready for late ioremap and beofre loading table in late
stage. If duplicated tables are detected, acpi_reallocate_root_tables()
stops installing them to the final reallocated global table list.

In v1 patchset [link #3], problems can be seen for dynamic loading tables
which are allocated as virtuall allocated tables. Such tables are
incremented in the global table list as the sanity check done in install
step only compares the table addresses while the virtual allocated
addresses are not stable.
In v2 patchset, we follow original design discussion made in ACPICA devel
mailing list, implements deferred table verification so that duplicate
tables are still can be detected in install step rather than in load step.
Also we removed table signature check according to verified windows
behavior [link #4] and reported issues [link #5].

Link: http://www.spinics.net/lists/linux-acpi/msg72215.html [#1]
Link: https://github.com//acpica/acpica/pull/265            [#2]
Link: http://www.spinics.net/lists/linux-acpi/msg72589.html [#3]
Link: https://github.com//acpica/acpica/pull/121            [#4]
      https://bugzilla.kernel.org/show_bug.cgi?id=3D118601    [#5]

Lv Zheng (5):
  ACPICA: Tables: Cleanup table handler invokers
  ACPICA: Tables: Do not validate signature for dynamic table load
  ACPICA: Tables: Change table duplication check to be related to
    acpi_gbl_verify_table_checksum
  ACPICA: Tables: Combine checksum/duplication verification together
  ACPICA: Tables: Add deferred table verification support

 drivers/acpi/acpica/actables.h |   5 +-
 drivers/acpi/acpica/tbdata.c   | 222 ++++++++++++++++++++++++++++++++++++-=
----
 drivers/acpi/acpica/tbinstal.c | 161 ++++--------------------------
 drivers/acpi/acpica/tbxface.c  |  36 ++++++-
 drivers/acpi/acpica/tbxfload.c |   2 +-
 drivers/acpi/bus.c             |   3 -
 drivers/acpi/tables.c          |   4 +-
 include/acpi/acpixf.h          |  15 +--
 include/acpi/actbl.h           |   1 +
 9 files changed, 266 insertions(+), 183 deletions(-)

-- =

2.7.4


--===============5544866761896301067==--

