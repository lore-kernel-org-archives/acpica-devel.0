Content-Type: multipart/mixed; boundary="===============1182464781573746296=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20190703 released
Date: Tue, 09 Jul 2019 14:55:48 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B960BDFB@ORSMSX110.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1182464781573746296==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

03 July 2019. Summary of changes for version 20190703:

This release is available at https://acpica.org/downloads


1) ACPICA kernel-resident subsystem:

Remove legacy module-level support code. There were still some remnants of =
the legacy module-level code executions. Since we no longer support this op=
tion, this is essentially dead code and has been removed from the ACPICA so=
urce.

iASL: ensure that _WAK, _PTS, _TTS, and _Sx are declared only at the root s=
cope. If these named objects are declared outside the root scope, they will=
 not be invoked by any host Operating System.

Clear status of GPEs on first direct enable. ACPI GPEs (other than the EC o=
ne) can be enabled in two situations. First, the GPEs with existing _Lxx an=
d _Exx methods are enabled implicitly by ACPICA during system initializatio=
n.  Second, the GPEs without these methods (like GPEs listed by _PRW object=
s for wakeup devices) need to be enabled directly by the code that is going=
 to use them (e.g. ACPI power management or device drivers).

In the former case, if the status of a given GPE is set to start with, its =
handler method (either _Lxx or _Exx) needs to be invoked to take care of th=
e events (possibly) signaled before the GPE was enabled. In the latter case=
, however, the first caller of AcpiEnableGpe() for a given GPE should not b=
e expected to care about any events that might be signaled through it earli=
er.  In that case, it is better to clear the status of the GPE before enabl=
ing it, to prevent stale events from triggering unwanted actions (like spur=
ious system resume, for example).

For this reason, modify AcpiEvAddGpeReference() to take an additional boole=
an argument indicating whether or not the GPE status needs to be cleared wh=
en its reference counter changes from zero to one and make AcpiEnableGpe() =
pass TRUE to it through that new argument.


2) iASL Compiler/Disassembler and ACPICA tools:

The tool generation process has been migrated to MSVC 2017, and all project=
 files have been upgraded. The new project files appear in the directory \a=
cpica\generate\msvc2017. This change effectively deprecates the older proje=
ct files in \acpica\generate\msvc9.

iASL: ensure that _WAK, _PTS, _TTS, and _Sx are declared only at the root s=
cope. If these named objects are declared outside the root scope, they will=
 not be invoked by any host Operating System.




--===============1182464781573746296==--

