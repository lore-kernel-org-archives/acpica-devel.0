Return-Path: <LeoLiu-oc@zhaoxin.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2A73B40580
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0D1EB40017
From: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
Message-ID: <20230704120453.1322069-1-LeoLiu-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Acpica-devel] [PATCH v3 0/5] Parse the PCIe AER and set to
	relevant registers
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Tue, 04 Jul 2023 12:20:42 -0000
To: lenb@kernel.org, james.morse@arm.com, tony.luck@intel.com, bp@alien8.de, bhelgaas@google.com, robert.moore@intel.com, leoliu-oc@zhaoxin.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, acpica-devel@lists.linuxfoundation.org

From: leoliu-oc <leoliu-oc@zhaoxin.com>

According to the sec 18.3.2.4, 18.3.2.5 and 18.3.2.6 in ACPI r6.5, the
register values form HEST PCI Express AER Structure should be written to
relevant PCIe Device's AER Capabilities. So the purpose of the patch set
is to extract register values from HEST PCI Express AER structures and
program them into AER Capabilities.
Refer to the ACPI Spec r6.5 for a more detailed description.
Considering that HEST AER patch is an effective supplement to _HPP/_HPX
method when the Firmware does not support the _HPP/_HPX method and can be
specially configured for the AER register of a specific device.
The question about whether OS has control of AER to write the information
in the HEST AER structure to the AER register of the corresponding device
is similar to the question about _HPX/_HPP method to write the AER
information to the AER register of the corresponding device.I looked in
ACPI Spec for a description of the relationship between writing to the AER
register through the _HPP/_HPX method and whether the OS requires AER
control:
1.OSPM uses the information returned by _HPX to determine how to
configure PCI Functions that are hot- plugged into the system, to
configure Functions not configured by the platform firmware during initial
system boot, and to configure Functions any time they lose configuration
space settings (e.g. OSPM issues a Secondary Bus Reset/Function Level
Reset or Downstream Port Containment is triggered).

2._HPX may return multiple types or Record Settings (each setting in a
single sub-package.) OSPM is responsible for detecting the type of
Function and for applying the appropriate settings. OSPM is also
responsible for detecting the device / port type of the PCI Express
Function and applying the appropriate settings provided.
For example, the Secondary Uncorrectable Error Severity and Secondary
Uncorrectable Error Mask settings of Type 2 record are only applicable to
PCI Express to PCI-X/PCI Bridge whose device / port type is 1000b.
Similarly, AER settings are only applicable to hot plug PCI Express
devices that support the optional AER capability.

3.Note: OSPM may override the settings provided by the _HPX object's Type2
record (PCI Express Settings) or Type3 record (PCI Express Descriptor
Settings) when OSPM has assumed native control of the corresponding
feature. For example, if OSPM has assumed ownership of AER (via _OSC),
OSPM may override AER related settings returned by _HPX. This means that
writing the AER register value by _HPX does not require the OS to gain
control of the AER. Also from the usage description of _HPX, I think
ownership of AER means who decides the configuration value of the AER
register rather than who can write the configuration value. Even though
the OS does not have control or ownership of the AER, it should still
write the configuration values determined by the firmware to the AER
register at the request of the firmware. 
Therefore, the ownership of AER is not considered in this patch.

v1->v2:
Correct some terminology.

v2->v3:
Refined code comments, add commit information.

leoliu-oc (5):
  ACPI/APEI: Add apei_hest_parse_aer()
  ACPI/APEI: Remove static from apei_hest_parse()
  PCI: Add PCIe to PCI/PCI-X Bridge AER fields
  ACPI/PCI: Add pci_acpi_program_hest_aer_params()
  PCI: Config PCIe devices's AER register

 drivers/acpi/apei/hest.c      | 116 +++++++++++++++++++++++++++++++++-
 drivers/pci/pci-acpi.c        |  92 +++++++++++++++++++++++++++
 drivers/pci/pci.h             |   5 ++
 drivers/pci/probe.c           |   1 +
 include/acpi/actbl1.h         |  69 ++++++++++++++++++++
 include/acpi/apei.h           |  12 ++++
 include/uapi/linux/pci_regs.h |   3 +
 7 files changed, 296 insertions(+), 2 deletions(-)

-- 
2.34.1

