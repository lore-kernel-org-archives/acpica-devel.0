Content-Type: multipart/mixed; boundary="===============7088167674217625352=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20170629 released
Date: Thu, 29 Jun 2017 15:33:09 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E5C4382@ORSMSX110.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7088167674217625352==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

29 June 2017. Summary of changes for version 20170629:

This release is available at https://acpica.org/downloads


1) ACPICA kernel-resident subsystem:

Tables: Implemented a deferred ACPI table verification. This is useful for =
operating systems where the tables cannot be verified in the early initiali=
zation stage due to early memory mapping limitations on some architectures.=
 Lv Zheng.

Tables: Removed the signature validation for dynamically loaded tables. Pro=
vides compatibility with other ACPI implementations. Previously, only SSDT =
tables were allowed, as per the ACPI specification. Now, any table signatur=
e can be used via the Load() operator. Lv Zheng.

Tables: Fixed several mutex issues that could cause errors during table acq=
uisition. Lv Zheng.

Tables: Fixed a problem where an ACPI warning could be generated if a null =
pointer was passed to the AcpiPutTable interface. Lv Zheng.

Tables: Added a mechanism to handle imbalances for the AcpiGetTable and Acp=
iPutTable interfaces. This applies to the "late stage" table loading when t=
he use of AcpiPutTable is no longer required (since the system memory manag=
er is fully running and available). Lv Zheng.

Fixed/Reverted a regression during processing of resource descriptors that =
contain only a single EndTag. Fixes an AE_AML_NO_RESOURCE_END_TAG exception=
 in this case.

Headers: IORT/SMMU support: Updated the SMMU models for Revision C of the I=
/O Remapping specification. Robin Murphy <robin.murphy(a)arm.com>

Interpreter: Fixed a possible fault if an Alias operator with an invalid or=
 duplicate target is encountered during Alias creation in AcpiExCreateAlias=
. Alex James <theracermaster(a)gmail.com>

Added an option to use designated initializers for function pointers. Kees =
Cook <keescook(a)google.com>


2) iASL Compiler/Disassembler and Tools:

iASL: Allow compilation of External declarations with target pathnames that=
 refer to existing named objects within the table. Erik Schmauss.

iASL: Fixed a regression when compiling FieldUnits. Fixes an error if a Fie=
ldUnit name also is declared via External in the same table. Erik Schmauss.

iASL: Allow existing scope names within pathnames used in External statemen=
ts. For example:
    External (ABCD.EFGH) // ABCD exists, but EFGH is truly external
    Device (ABCD)

iASL: IORT ACPI table: Implemented changes required to decode the new Proxi=
mity Domain for the SMMUv3 IORT. Disassembler and Data Table compiler. Gana=
patrao Kulkarni <ganapatrao.kulkarni(a)cavium.com>

Disassembler: Don't abort disassembly on errors from External() statements.=
 Erik Schmauss.

Disassembler: fixed a possible fault when one of the Create*Field operators=
 references a Resource Template. ACPICA Bugzilla 1396.

iASL: In the source code, resolved some naming inconsistences across the pa=
rsing support. Fixes confusion between "Parse Op" and "Parse Node". Adds a =
new file, aslparseop.c


--===============7088167674217625352==--

