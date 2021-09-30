Content-Type: multipart/mixed; boundary="===============6689132325655058802=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20210930 released
Date: Thu, 30 Sep 2021 17:26:55 +0000
Message-ID: <BYAPR11MB325660DA0DEC14731CC3161287AA9@BYAPR11MB3256.namprd11.prod.outlook.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6689132325655058802==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

30 September 2021. Summary of changes for version 20210930:

This release is available at https://acpica.org/downloads

1) ACPICA kernel-resident subsystem:

Hardware: Avoid evaluating methods too early during system resume. During w=
akeup from system-wide sleep states, AcpiGetSleepTypeData() is called and i=
t tries to get memory from the OS in order to evaluate a control method, bu=
t if KFENCE is enabled in the Linux kernel, the memory allocation attempt c=
auses an IRQ work to be queued and a self-IPI to be sent to the CPU running=
 the code which requires the memory controller to be ready, so if that happ=
ens too early in the wakeup path, it doesn't work.

Prevent that from taking place by calling AcpiGetSleepTypeData() for S0 upf=
ront, when preparing to enter a given sleep state, and saving the data obta=
ined by it for later use during system wakeup.

Added a new _OSI string, "Windows 2020". Posted by superm1.

2) iASL Compiler/Disassembler and ACPICA tools:

iASL compiler: Updated the check for usage of _CRS, _DIS, _PRS, and _SRS ob=
jects:
New/latest rules: Under a Device Object:
         1) If _PRS is present, must have _CRS and _SRS
         2) If _SRS is present, must have _PRS (_PRS requires _CRS and _SRS)
         3) If _DIS is present, must have _SRS (_SRS requires _PRS, _PRS re=
quires _CRS and _SRS)
         4) If _SRS is present, probably should have a _DIS (Remark only)

iASL table disassembler: Added disassembly support for the NHLT ACPI table.=
 Note: support for Vendor-defined microphone arrays and SNR extensions are =
not supported at this time -- mostly due to a lack of example tables. Actua=
l compiler support for NHLT is forthcoming.

Added a new subtable type for ACPI 6.4 SRAT Generic Port Affinity. It uses =
the same subtable structure as the existing Generic Initiator Affinity type.

Added the flag for online capable in the MADT, introduced in ACPI 6.3. Post=
ed by superm1.

3) ACPICA documentation: Updated the legal info (that appears at the start =
of the Documents) to clarify distribution rights that are granted.
--===============6689132325655058802==--

