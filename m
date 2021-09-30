Content-Type: multipart/mixed; boundary="===============4912623059172074808=="
MIME-Version: 1.0
From: Rudolf Marek <r.marek at assembler.cz>
Subject: [Devel] Re: Question about ACPICA, QNX and making beeps
Date: Thu, 30 Sep 2021 19:12:20 +0200
Message-ID: <d81ebcde-8de7-7b09-911a-ede29e78b80b@assembler.cz>
In-Reply-To: CAAuRk_iKBx7Zmo60BDqFzmzqjz3q1vHPtNxje-KUcpixO_n+pg@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4912623059172074808==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 30. 09. 21 15:53, Devin Steffler wrote:
> Hello,
> =

> Will Miles suggested that I monitor AcpiOsRead* and AcpiOsWrite* calls. I=
 observed the following:
> ./test_sound # it plays fine
> ./acpica
> AcpiOsReadPort: read 0x0 from 0x1804 with width 16
> AcpiOsReadPort: read 0x0 from 0x1804 with width 16
> AcpiOsWritePort: write 0xa0 to 0xb2 with width 8

This is likely the SMI_CMD and ACPI_ENABLE see my other mail.

> AcpiOsReadPort: read 0x1 from 0x1804 with width 16
> ./test_sound # it stops working
> =

> To check if that write to 0xb2 is related, I modified AcpiOsWritePort to =
return AE_OK on all writes to Address 0xb2 without doing the actual write. =
I also modified AcpiOsReadPort to do a "fake read" of 1 when reading from p=
ort 0x1804 if there was a previous write to 0xb2. When I do this, then the =
beep continues to work and reading battery information via ACPI also contin=
ues to work (at least on this laptop, I haven't tested other devices yet).

Try vice versa, do not enable/use the ACPICA at all and write 0xa0 to 0xb2 =
to see if it breaks it.

> Looking at the PCH datasheet for the Intel i5 11357G CPU (what I'm using =
at the moment), it looks like writing to 0xb2 will trigger an SMI and set "=
APMC_EN =3D1" and is reported via APM_STS. Does this mean that it's suppose=
d to activate power management and enable SMI interrupts for BIOS controlle=
d power management (i.e. to be executed by ACPICA via SMI interrupt handler=
s)? =


It tells BIOS, hey I'm ACPI aware OS stop messing around. And basically BIO=
S runs some unknown code in SMM when you just write to 0xb2 the 0xA0 comman=
d.
This unknown code can possibly enable the 8254 clock gating.

>I'm not sure why that would break the PC speaker. Could it be that my OSL =
interrupt handling is broken and BIOS was relying on it to re-enable the de=
vices needed to use the PC speaker?

The PC speaker does not do anything with IRQs. The PIT has no architectural=
ly defined way to be disabled. I don't know what Intel smokes but lets not =
inhale, intel invented the clock gating to make programers life more misera=
ble (problem for TSC/lapic clock calibration when you have no HPET)

> Or could APMC_EN=3D1 also "turn off some devices (that the PC speaker req=
uires) to save power as they won't be used by this OS"? Should I instead be=
 looking at the ACPI tables for this laptop to see if something is being tu=
rned off to save power and figure out how to turn them back on via ACPI cal=
ls?

This is likely not the problem. The ACPI tables do not instruct the hardwar=
e, because you commented out above write. Also most hardware for chipset is=
 memory mapped, not IOport mapped. Try what I wrote above. If it breaks, it=
 confirms that BIOS is doing something behind the scene which is not even A=
CPICA related.

> The same section (22.4.5 SMI#/SCI Generation) in the datasheet also state=
s things like the following:
> "The SCI is a level-mode interrupt that is typically handled by an ACPI-a=
ware operating
> system. In non-APIC systems (which is the default), the SCI IRQ is routed=
 to one of
> the 8259 interrupts (IRQ 9, 10, or 11). The 8259 interrupt controller mus=
t be
> programmed to level mode for that interrupt."

I don't think it is problem with SCI. See above.

The 8254 clock gating will slow down the PIT frequency 16x and it will stop=
 legacy IRQ 0  (on PIC/IOAPIC) generation as a symptom of clock gating. Thi=
s is not documented but it behaves like that. Yes again intel did not stop =
the counter completely to detect it but slowed down. Sigh.

Maybe it also affects PC speaker that it generates waveforms too slowly. Yo=
u can also try to search BIOS option in setup menu for clock gating or try =
to disable C11 power state in there.

Yes it is mess.

Thanks,
Rudolf

--===============4912623059172074808==--

