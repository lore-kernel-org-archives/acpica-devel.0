Content-Type: multipart/mixed; boundary="===============1458379499300489090=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20211217 released
Date: Fri, 17 Dec 2021 18:17:09 +0000
Message-ID: <BYAPR11MB32561FA78CC3B7E5353BB43387789@BYAPR11MB3256.namprd11.prod.outlook.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1458379499300489090==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

17 December 2021. Summary of changes for version 20211217:

This release is available at https://acpica.org/downloads

1) ACPICA kernel-resident subsystem:

Hardware: Do not flush CPU cache when entering S4 and S5. According to ACPI=
 6.4, Section 16.2, the CPU cache flushing is required on entering to S1, S=
2, and S3, but the ACPICA code flushes the CPU cache regardless of the slee=
p state. Blind cache flush on entering S5 causes problems for TDX.

Avoid subobject buffer overflow when validating RSDP signature. Since the S=
ignature member is accessed through an ACPI_TABLE_HEADER, the pointer to it=
 is only to a 4-char array, and so trying to read past the 4th character, a=
s will be done when it is an RSDP, reads beyond the bounds of the accessed =
member. Contributed by jrtc27.

Add support for PCC Opregion special context data. PCC Opregion added in AC=
PIC 6.3 requires special context data similar to GPIO and Generic Serial Bu=
s as it needs to know the internal PCC buffer and its length as well as the=
 PCC channel index when the opregion handler is being executed by the OSPM.=
 Adds support for the special context data needed by PCC Opregion. Submitte=
d by Sudeep Holla <sudeep.holla(a)arm.com>

2) iASL Compiler/Disassembler and ACPICA tools:

iASL: Completed compiler support for the NHLT ACPI table.

iASL/NHLT table: Fixed a reported problem where a fault would occur during =
disassembly of a "Linux-Specific" section if the "Specific Data" part was n=
ot present.

iASL: Added full support (compiler and disassembler) for the AGDI ACPI tabl=
e. Contributed by: Ilkka Koskinen <ilkka(a)os.amperecomputing.com>.

iASL: Added full support for the TDEL ACPI table.

iASL table compiler: FADT support updates:
1) Allow the 32-bit DSDT address to be zero.
2) Issue error if both the 32-bit and 64-bit DSDT addresses are zero.

iASL: Fix unaligned accesses to local cache allocations. Contributed by jrt=
c27.

iASL: Open binary input files in binary mode, not text mode Affects binary =
input AML files, as well as binary data table files, for disassembly.

--===============1458379499300489090==--

