Content-Type: multipart/mixed; boundary="===============2001951615990076345=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20180313 released
Date: Tue, 13 Mar 2018 20:29:33 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B7575A29@ORSMSX110.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2001951615990076345==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

13 March 2018. Summary of changes for version 20180313:

This release is available at https://acpica.org/downloads


1) ACPICA kernel-resident subsystem:

Implemented various improvements to the GPE support:

1) Dispatch all active GPEs at initialization time so that no GPEs are lost.
2) Enable runtime GPEs earlier. Some systems expect GPEs to be enabled befo=
re devices are enumerated.
3) Don't unconditionally clear ACPI IRQs during suspend/resume, so that IRQ=
s are not lost.
4) Add parallel GPE handling to eliminate the possibility of dispatching th=
e same GPE twice.
5) Dispatch any pending GPEs after enabling for the first time.

AcpiGetObjectInfo - removed support for the _STA method. This was causing p=
roblems on some platforms.

Added a new _OSI string, "Windows 2017.2".

Cleaned up and simplified the module-level code support. These changes are =
in preparation for the eventual removal of the legacy MLC support (deferred=
 execution), replaced by the new MLC architecture which executes the MLC as=
 a table is loaded (DSDT/SSDTs).

Changed a compile-time option to a runtime option. Changes the option to ig=
nore ACPI table load-time package resolution errors into a runtime option. =
Used only for platforms that generate many AE_NOT_FOUND errors during boot.=
 AcpiGbl_IgnorePackageResolutionErrors.

Fixed the ACPI_ERROR_NAMESPACE macro. This change involves putting some ACP=
I_ERROR_NAMESPACE parameters inside macros. By doing so, we avoid compilati=
on errors from unused variables (seen with some compilers).


2) iASL Compiler/Disassembler and Tools:

ASLTS: parallelized execution in order to achieve an (approximately) 2X per=
formance increase.

ASLTS: Updated to use the iASL __LINE__ and __METHOD__ macros. Improves err=
or reporting.



--===============2001951615990076345==--

