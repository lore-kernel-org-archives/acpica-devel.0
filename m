Content-Type: multipart/mixed; boundary="===============8618365100389382237=="
MIME-Version: 1.0
From: devinsteffler at gmail.com
Subject: [Devel] The PC speaker beep stops working on Lenovo M90n after
 enabling ACPI (in QNX)
Date: Wed, 04 Nov 2020 18:24:11 +0000
Message-ID: <20201104182411.2796.58819@ml01.vlan13.01.org>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8618365100389382237==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

I've run into a strange situation and I'm wondering if anyone can provide s=
ome insight into what might be happening. I'm using code that's basically t=
he same as the following example to create a beep using the internal PC spe=
aker: https://wiki.osdev.org/PC_Speaker#Sample_Code.

I'm running QNX on a Lenovo M90n (Intel i5-8365U CPU). I'm using my own ACP=
ICA based driver to manage things like reading battery level.

Strangely though, on this machine, after ACPI is enabled then the PC speake=
r stops working as expected. I've narrowed it down to the following initial=
ization code within ACPICA:
Status =3D AcpiHwWritePort (AcpiGbl_FADT.SmiCommand, // 0xB2 on this x86_64=
 platform (Lenovo M90n)
            (UINT32) AcpiGbl_FADT.AcpiEnable,   // 0xA0 on this x86_64 plat=
form (Lenovo M90n)
	    8);

Before that line executes, I can generate a beep just fine. However, as soo=
n as that line returns, then I cannot generate beeps anymore.

The speaker itself is still functional. If I toggle the in/out value of the=
 speaker via port 0x61 then I hear an audible click. So it's almost as if t=
he PIT itself is not generating a square wave on channel 2 when put into mo=
de 3.

For example, for a 2 second beep:
- Before ACPI is enabled, I hear a 2 second beep at my desired frequency.
- After ACPI is enabled via the line specified above, then I hear a click, =
then two seconds later I hear another click. There is no beep in between th=
e clicks.

Any ideas are appreciated. Is the SMI handler implemented in the PC's UEFI =
firmware? If so, does this behavior suggest that there's a bug in it (and I=
 should be contacting Lenovo for support)? From what I found online, it loo=
ks like writing to 0xB2 should generate an SMI interrupt (handled by the SM=
I handler, which should process the value 0xA0 that ACPICA is sending to it=
).

I haven't tried to replicate the issue on any other OS yet, but maybe I sho=
uld try that as well.

Thanks,
Devin
--===============8618365100389382237==--

