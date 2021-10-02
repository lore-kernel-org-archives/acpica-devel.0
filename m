Content-Type: multipart/mixed; boundary="===============8538340454985557392=="
MIME-Version: 1.0
From: Rudolf Marek <r.marek at assembler.cz>
Subject: [Devel] Re: Question about ACPICA, QNX and making beeps
Date: Sat, 02 Oct 2021 10:51:44 +0200
Message-ID: <c5fe2f8c-2b8c-2878-1e5d-bb9ffafb33ae@assembler.cz>
In-Reply-To: CAAuRk_g-rQQONwOCVvtzeO8Eq1XhcRDtyZzOnBsdAYGOdkbDpw@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8538340454985557392==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Devin,

On 01. 10. 21 21:08, Devin Steffler wrote:
> Hi Rudolf,
> =

> You're correct. Simply writing 0xa0 to 0xb2 will cause this.

Great. (or not so).

> I'm having a hard time figuring out what 0xb2 is. It seems like an I/O po=
rt that causes an SMI and sets APMC_EN=3D1. That's all that I could find so=
 far. I have no idea yet what the bits in 0xa0 do.

This is a software API to perform various functions not by ACPICA bytecode =
but by the machine code. It is kind of "backdoor" for BIOS programmers often
misused. It was heavily used during APM era, but remained there. The whole =
system managemement mode is another mess. The SMI is more privileged than o=
s,
so it is ring -1 (OS is ring 0). Basically this allows BIOS to do "behind t=
he scene" operation. 0xA0 is just API, it is invoke command "A0" in BIOS.
And by a convention this command is to instruct BIOS that ACPICA aware OS i=
s being used. To figure out what is really done, you would need to

1) get support for Mr. Lenovo - but not the ordinary support
2) unpack and disassemble/reverse engineer the BIOS to see what 0xA0 is rea=
lly doing

> Is this telling the BIOS that I have an APM aware OS (not ACPI)? If that'=
s the case, then I have a feeling that my ACPICA should be instead doing so=
mething to say "I'm not APM aware" so that it doesn't try to do this. Or is=
 being "APM aware" required for ACPI functionality since it's the successor=
 to APM? On this system reading battery information works fine without this=
 write to 0xb2. I would have to test on other devices as well to check if t=
hat's always the case or not.

The A0 command tels the contrary it says to OS, I'm ACPI aware OS. And some=
one at Mr. Lenovo probably was clever to realize that they can maybe switch=
 off something
because legacy OS is not in use...

> As a side note, in case it's relevant, I am setting the following in my A=
CPICA:
> #define ACPI_OS_NAME =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0"Microsoft Windows NT"
> =

> That was done arbitrarily or perhaps out of laziness/lack of testing supp=
ort. The comment above ACPI_OS_NAME suggests that it's obsolete anyways.

Yes there are another horror stories for this. Basically BIOS programmers w=
ere testing on what ACPICA/OS they run with and do different things.Dependi=
ng
what OS was told.

> Unfortunately, I don't see any option in the BIOS relating to clock gatin=
g or C11 power states.

Thats bad. Try some more general power saving options. Does the behavior ch=
ange if laptop is plugged to AC?

> Should I pursue allowing the write but then disable the clock gating sepa=
rately? I'm not sure how to do that yet.

Yes you can try it out. But it is tricky.

> =

> I started to learn about clock gating. I wanted to see if I could confirm=
 that clock gating happens when 0xa0 is written to 0xb2. I stumbled on the =
following information from Intel:
> Datasheet: https://www.intel.com/content/dam/www/public/us/en/documents/t=
echnical-specifications/300-series-chipset-on-package-pch-datasheet-vol-2.p=
df <https://www.intel.com/content/dam/www/public/us/en/documents/technical-=
specifications/300-series-chipset-on-package-pch-datasheet-vol-2.pdf>
> -------------------------------------------------
> 30.2.20 ITSS Power Reduction Control (ITSSPRC)=E2=80=94Offset 3300h
> Power controls for the entire interrupt and timer subsystem.
> Bit 2:
> "8254 Static Clock Gating Enable (CGE8254): When set, the 8254 timer is
> disabled statically. This bit shall be set by BIOS if the 8254 feature is=
 not needed in
> the system or before BIOS hands off the system that supports C11. Normal =
operation
> of 8254 requires this bit to 0."
> -------------------------------------------------

Yes this is it. Unfortunately the register placement is not stable/same acr=
oss systems. Intel tends to put it to various places. So like Apollo lake h=
as it elsewhere etc. You need to look to a documentation which matches 100%=
 your system. You can try to check this by comparing the PCI ids of various=
 devices and checking
them against datasheets. You can try to look to coreboot sources or some ot=
her opensource uefi implementation if they have support for your systems to=
 see how the p2sb is done.

> Unfortunately, I haven't been able to get access to that bit yet. The P2S=
B Bridge is hidden. I've found a way to get the SBREG_BAR from the P2SB Bri=
dge in the QNX BSP. =


Yes. But maybe it is for another chipset. See above.

>However, using it to read the ITSSPRC still returns 0xFFFFFFFF. I was hopi=
ng that I could clear that bit if it is getting set to test if that makes t=
he PC speaker work >again.

Hm 0xffffffff sounds way suspicious. I don't know what other bits do but it=
 looks like you are looking to wrong place. Possible errors:

1) you did not map correct memory region
2) you did not map it uncached
3) you did not enable decoding of the region (maybe the P2SB has also comma=
nd register where you might need to enable BAR decoding)
4) you did not use proper compiler things like "volatile" or compiler barri=
ers and/or your access has been optimized out by the compiler
5) you did not read the register using correct register length
> Part of this is a learning exercise for me, but part of it is also to get=
 a proper fix for this system. If this is just an "APM thing" that shouldn'=
t be enabled to begin with on my system, then I guess I need to figure out =
how to tell BIOS that this OS is "not APM aware". =


The ACPICA does correct thing. See above.

>Either that, or just block 0xa0 writes to 0xb2 (but that feels like the wr=
ong approach).

Yes this is wrong approach, because BIOS will often generate SMIs and SCIs =
for many events. I'm afraid you need to do the write to 0xb2.

Giving it more thoughts the clock gating might not be the only or correct p=
roblem to solve. If it is a laptop, I suspect that the legacy speaker
goes to sound codec somehow and then to laptop speakers, and maybe BIOS swi=
tches off the sound codec (like puts it to D3 sleep).
I don't know how the sound codec routing is usually done. You need to check=
 it yourself.

Do you have schematics of that system to check what the beeping output from=
 the chipset really does?

Thanks,
Rudolf





--===============8538340454985557392==--

