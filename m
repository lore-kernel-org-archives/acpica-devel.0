Content-Type: multipart/mixed; boundary="===============7872770821311427909=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20190405 released
Date: Fri, 05 Apr 2019 15:30:35 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B957746B@ORSMSX110.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7872770821311427909==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

05 April 2019. Summary of changes for version 20190405:

This release is available at https://acpica.org/downloads


1) ACPICA kernel-resident subsystem:

Event Manager: History: Commit 18996f2db918 ("ACPICA: Events: Stop uncondit=
ionally clearing ACPI IRQs during suspend/resume") was added earlier to sto=
p clearing of event status bits unconditionally on suspend and resume paths=
. Though this change fixed an issue on suspend path, it introduced regressi=
ons on several resume paths. In the case of S0ix, events are enabled as par=
t of device suspend path. If status bits for the events are set when they a=
re enabled, it could result in premature wake from S0ix. If status is clear=
ed for any event that is being enabled so that any stale events are cleared=
 out. In case of S0ix, events are enabled as part of device suspend path. I=
f status bits for the events are set when they are enabled, it could result=
 in premature wake from S0ix.

This change ensures that status is cleared for any event that is being enab=
led so that any stale events are cleared out.


2) iASL Compiler/Disassembler and ACPICA tools:

iASL: Implemented an enhanced multiple file compilation that combines named=
 objects from all input files to a single namespace. With this feature, any=
 unresolved external declarations as well as duplicate named object declara=
tions can be detected during compilation rather than generating errors much=
 later at runtime. The following commands are examples that utilize this fe=
ature:
    iasl dsdt.asl ssdt.asl
    iasl dsdt.asl ssdt1.asl ssdt2.asl
    iasl dsdt.asl ssdt*.asl


--===============7872770821311427909==--

