Content-Type: multipart/mixed; boundary="===============8883891914042320660=="
MIME-Version: 1.0
From: George Cherian <george.cherian at cavium.com>
Subject: [Devel] [PATCH v5 0/2] Make cppc acpi driver aware of pcc subspace ids
Date: Wed, 11 Oct 2017 08:54:56 +0000
Message-ID: <1507712098-13035-1-git-send-email-george.cherian@cavium.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8883891914042320660==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The current cppc acpi driver works with only one pcc subspace id.
It maintains and registers only one pcc channel even if the acpi table has =

different pcc subspace ids. =


As per ACPI 6.2 spec  all PCC registers, for all processors in the same =

performance domain (as defined by _PSD), must be defined to be in the same
subspace. The series tries to address the same by making cppc acpi driver =

aware of multiple possible pcc subspace ids.

Patch 1 : In preparation to share the MAX_PCC_SUBSPACE definition with cppc=
 acpi
          driver
Patch 2 : Make the cppc acpi driver aware of multiple pcc subspace ids.

Changes from v4:
  - Addressed Prashath's comments on
   * Remove pcc_subspace_idx member from struct cppc_pcc_data
   * Eliminate the loop and directly increment the refcoun in pcc_data_allo=
c()
   * pcc_data_alloc to be called once per CPU.
   * Retain the earlier check PCC registers within same _CPC is under same
     subspace.

Changes from v3:
  - Address Issue reported by kbuild-robot.

Changes from v2:
  - Addressed Prashanth's comments on
    * Not to use local variables to update mpar_count, last_mpar_reset and =

      last_cmd_cmpl_time
    * Add check for kzalloc failure in pcc_data_alloc()
    * Initialize pcc_subspace_id to -1 in acpi_cppc_processor_probe()
    * Check for pcc_subspace_id validity before registering pcc_channel

Changes from v1:
  - Add last_cmd_cmpl_time, last_mpar_reset, mpar_count to the cppc_pcc_dat=
a to
make it per subspace.
  - PCC per subspace dynamic allocation support added instead of static
allocation
  - Added a new function pcc_data_alloc, In instances where CPU's with SMT
support same PCC subspace would be used for all CPU's belonging to same =

physical core. This function adds the pcc_subspace refcounting and allocates
the cppc_pcc_data per unique subspace idx.
  - Added cleanup in acpi_cppc_processor_exit. Free the mbox channel and fr=
ee
the cppc_pcc_data in case refcount is zero.

George Cherian (2):
  mailbox: PCC: Move the MAX_PCC_SUBSPACES definition to header file
  ACPI / CPPC: Make cppc acpi driver aware of pcc subspace ids

 drivers/acpi/cppc_acpi.c | 240 +++++++++++++++++++++++++++++--------------=
----
 drivers/mailbox/pcc.c    |   1 -
 include/acpi/pcc.h       |   1 +
 3 files changed, 152 insertions(+), 90 deletions(-)

-- =

2.1.4


--===============8883891914042320660==--

