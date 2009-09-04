Content-Type: multipart/mixed; boundary="===============2234200864772671894=="
MIME-Version: 1.0
From: Joerg Sonnenberger <joerg at britannica.bec.de>
Subject: [Devel] Correct ACPI setup sequence
Date: Fri, 04 Sep 2009 21:52:17 +0200
Message-ID: <20090904195217.GA9222@britannica.bec.de>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2234200864772671894==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,
after some puzzling issues with different DSDT on various system I would
like to know the correct/best way to setup ACPICA.

The core of the init sequence is:
	AcpiEnableSubsystem(ACPI_FULL_INITIALIZATION);
	AcpiInitializeObjects(ACPI_FULL_INITIALIZATION);

As part of the former call, the event subsystem is initialised,
including setting up the SCI. To process that request, the overrides in
the MADT have to be parsed and that in turn requires switching to APIC
mode.

This now leaves two primary options:
- Switch to APIC mode and parse the MADT from the
AcpiOsInstallInterruptHandler
- Defer the SCI setup until after the call.

The second is messy and can't be the intention of the code. The former
makes me wonder about the error resilience though. We have seen some
DSDTs in NetBSD that do not setup the _PRT correctly before the object
initialisations are done. I don't know yet, if the _INI change in the
last release fixed that. I am wondering though, if the MADT processing
can be affecting by the same issue. Are there any known cases of such
DSDTs?

The second issue is the question of reentrancy. Is ACPICA supposed to be
reentrant enough to allow this?

Joerg

--===============2234200864772671894==--

