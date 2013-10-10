Content-Type: multipart/mixed; boundary="===============2547884360596035103=="
MIME-Version: 1.0
From: Uwe Andersen <uandersen at MAYAH.com>
Subject: [Devel] ACPI Error: Namespace lookup failure, AE_NOT_FOUND
Date: Thu, 10 Oct 2013 14:51:37 +0200
Message-ID: <031C6AD0F5FEAB449C77DF4E9D047A5C4729C0@mayah-sbs.mayah.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2547884360596035103==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

I integrated ACPICA into a real time operatinng system called "RTOS32".
The "InitializeFullAcpi(void)" function runs without a problem.
If I call function AcpiEnterSleepStatePrep(5) to prepare a system switch of=
f I get the error messages:
ACPI Error: [\_SB_.PCIO.LPCB.TPM_.PTS_] Namespace lookup failure, AE_NOT_FO=
UND(20130823/psargs-465)
ACPI Error: Method parse/execution failed [\PTS] (Node 7F01B470), AE_NOT_FO=
UND(20130823/psargs-625)

Is this a BIOS problem or did I something wrong with the ACPICA?

BTW, AcpiEnterSleepStatePrep(5) returns with "AE_OK" which it shouldn't, IM=
HO.
If I execute AcpiEnterSleepState(5) thereafter (because AcpiEnterSleepState=
Prep did not returns an error) the ACPICA code crashes with a "privileged I=
nstruction" exception. Which is probably not a surprise because AcpiEnterSl=
eepStatePrep() already encountered a problem.

Regards,
Uwe

P.S.: I'm a ACPI newbie so please excuse if I contacted the wrong forum.=20

--===============2547884360596035103==--

