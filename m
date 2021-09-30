Content-Type: multipart/mixed; boundary="===============3332966708136061878=="
MIME-Version: 1.0
From: Rudolf Marek <r.marek at assembler.cz>
Subject: [Devel] Re: Question about ACPICA, QNX and making beeps
Date: Thu, 30 Sep 2021 18:58:16 +0200
Message-ID: <4e7c48bf-b39d-bf69-9f6e-1581f9b5d0f9@assembler.cz>
In-Reply-To: CAAuRk_hhW+E0GhZY7TTKd8Q24u4j12thwW17G2gdxz1xCPYiyA@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3332966708136061878==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Devin,

On 30. 09. 21 14:56, Devin Steffler wrote:
> Hi Rudolf,
> =

> I have the ACPI utilities working in QNX as well (i.e. acpidump, acpixtra=
ct, iasl, etc). The problem is I don't know what to look for in the FADT.

You need to look for SMI_CMD (likely ioport 0xb2) and ACPI_ENABLE fields.

> So far I have only seen this happen on Lenovo based x86 PCs. For example,=
 the one that I have on hand is a Lenovo ThinkBook 14 Gen 2 laptop. If I bo=
ot the ThinkBook into QNX, then I can play a beep over the PC speaker just =
fine. However, after running ACPICA, then I can no longer play a beep over =
the PC speaker anymore on this device.

So Intels?

> How can I check for 8254 clock gating?

In the datasheet of Intel, search the southbridge for "8254" + look for som=
e "gating" around. It is quite badly documented and sometimes under NDA onl=
y.

Thanks,
Rudolf


> delay is a QNX call to sleep for the specified time in ms.
> =

> Thanks,
> Devin
> =

> On Wed, Sep 29, 2021 at 3:58 PM Rudolf Marek <r.marek(a)assembler.cz <mai=
lto:r.marek(a)assembler.cz>> wrote:
> =

>     Hi Devin,
> =

>     Dne 28. 09. 21 v 21:04 Devin Steffler napsal(a):
>>     Hello, I am using ACPICA to read battery information in QNX. That pa=
rt is working great so far. However, now some code that is being used to ma=
ke beeps via the PC speaker stopped working. Strangely, this code stops wor=
king on a few devices only after ACPICA runs.
> =

>     You mean same device with same mainboard / BIOS version?
> =

>     Maybe SMI and/or ACPI bytecode turns on 8254 clock gating? You can
> =

>     try to disassemble the ACPI DSDT/SSDT bytecode and look for it.
> =

>     What you can also do, is to try out to send ACPI enable SMI command w=
ithout
> =

>     enabling ACPICA and see if it breaks. You can read the I/O port addre=
ss
> =

>     and data enable command from FADT. To disassemble the ACPI tables
> =

>     use acpidump acpixtract and iasl utillites in linux.
> =

>>     What could my ACPICA be doing (or failing to do) that could cause th=
e beeps to stop working with the code below? Is the PIT being disabled some=
how? I guess I'll need to learn more about the PIT and how to check its sta=
tus to see if it's being disabled after ACPICA runs. Here's example code fo=
r QNX to generate a beep using the PC speaker: // -------------------------=
---------------------- #include <sys/neutrino.h> #include <hw/inout.h> #inc=
lude <unistd.h> int main(void) { ThreadCtl( _NTO_TCTL_IO, 0 ); // get I/O p=
ermissions // start a beep int freq =3D 1000; int scale =3D 1193046 / freq;=
 out8(0x43, 0xb6); out8(0x42, scale & 0xff); out8(0x42, scale >> 8); out8(0=
x61, in8(0x61) | 3);
> =

>     you can also try to see if your assembly for out8 is correct and mayb=
e not re-ordered
> =

>     by the compiler or that your asm clobber list is correct (same for in=
8)
> =

>>     // let the beep play for a second delay(1000);
> =

>     delay is an OS service right?
> =

>     Thanks,
> =

>     Rudolf
>=20
--===============3332966708136061878==--

