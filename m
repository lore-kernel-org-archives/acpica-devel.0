Content-Type: multipart/mixed; boundary="===============7797275770558628352=="
MIME-Version: 1.0
From: George Cherian <george.cherian at cavium.com>
Subject: [Devel] [PATCHv2 0/2] Make cppc acpi driver aware of pcc subspace ids
Date: Fri, 21 Jul 2017 07:43:45 +0000
Message-ID: <1500623027-19712-1-git-send-email-george.cherian@cavium.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7797275770558628352==
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
 =


George Cherian (2):
  mailbox: PCC: Move the MAX_PCC_SUBSPACES definition to header file
  ACPI / CPPC: Make cppc acpi driver aware of pcc subspace ids

 drivers/acpi/cppc_acpi.c | 228 ++++++++++++++++++++++++++++++-------------=
----
 drivers/mailbox/pcc.c    |   1 -
 include/acpi/pcc.h       |   1 +
 3 files changed, 145 insertions(+), 85 deletions(-)

-- =

2.7.4


--===============7797275770558628352==--

