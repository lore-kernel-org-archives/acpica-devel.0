Content-Type: multipart/mixed; boundary="===============8199302872411859518=="
MIME-Version: 1.0
From: Thomas Faber <thomas.faber at reactos.org>
Subject: [Devel] AcpiHwRead/AcpiHwWrite regression in 20160318
Date: Thu, 14 Apr 2016 16:49:45 +0200
Message-ID: <570FAE09.7010107@reactos.org>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8199302872411859518==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

the new AcpiHwRead/AcpiHwWrite implementations have caused a regression
on VirtualBox here. On ReactOS I'm getting an interrupt storm because
interaction with the event status register is no longer working.

The obvious issue that I observe is that the XPm1aStatus register is
now read from/written to in individual 8-bit operations instead of
using the full 16 bit length as before.

VirtualBox does not seem to allow this:
https://github.com/mdaniel/virtualbox-org-svn-vbox-trunk/blob/master/src/VB=
ox/Devices/PC/DevACPI.cpp#L1466

The register description looks like this (which seems as expected):
kd> ?? AcpiGbl_FADT.XPm1aEventBlock
struct acpi_generic_address
+0x000 SpaceId : 0x1 ''
+0x001 BitWidth : 0x20 ' '
+0x002 BitOffset : 0 ''
+0x003 AccessWidth : 0x2 ''
+0x004 Address : 0x4000
kd> ?? AcpiGbl_XPm1aStatus
struct acpi_generic_address
+0x000 SpaceId : 0x1 ''
+0x001 BitWidth : 0x10 ''
+0x002 BitOffset : 0 ''
+0x003 AccessWidth : 0 ''
+0x004 Address : 0x4000

It looks like the AccessWidth needs to be explicitly set to 2 here now
rather than defaulting to 0? Alternatively, zero AccessWidth would have
to lead to a smarter default than just assuming 8-bit reads.

For reference, backtraces for reading this register with versions
20160318 and 20160108 showing the arguments passed to the OSL functions
can be found below.

Assuming my analysis is correct, it's probably faster & more correct for
someone else to fix the issue in the code, but I can provide a patch if
you prefer.

Thanks!
-Thomas



Read New (20160318) -- returns 0xff (and so does the follow-up read on port=
 0x4001):
kd> kp
ChildEBP RetAddr
f392a228 f8b3eb5a acpi!AcpiOsReadPort(unsigned int64 Address =3D 0x4000, un=
signed int * Value =3D 0xf392a288, unsigned int Width =3D 8) [reactos\drive=
rs\bus\acpi\osl.c @ 707]
f392a24c f8b3e26d acpi!AcpiHwReadPort(unsigned int64 Address =3D 0x4000, un=
signed int * Value =3D 0xf392a288, unsigned int Width =3D 8)+0x5a [reactos\=
drivers\bus\acpi\acpica\hardware\hwvalid.c @ 258]
f392a29c f8b3ea43 acpi!AcpiHwRead(unsigned int * Value =3D 0xf392a2b4, stru=
ct acpi_generic_address * Reg =3D 0xf8b68860)+0x11d [reactos\drivers\bus\ac=
pi\acpica\hardware\hwregs.c @ 231]
f392a2bc f8b3e795 acpi!AcpiHwReadMultiple(unsigned int * Value =3D 0xf392a2=
d8, struct acpi_generic_address * RegisterA =3D 0xf8b68860, struct acpi_gen=
eric_address * RegisterB =3D 0xf8b68690)+0x23 [reactos\drivers\bus\acpi\acp=
ica\hardware\hwregs.c @ 780]
f392a2dc f8b3d17a acpi!AcpiHwRegisterRead(unsigned int RegisterId =3D 1, un=
signed int * ReturnValue =3D 0xf392a2f0)+0x45 [reactos\drivers\bus\acpi\acp=
ica\hardware\hwregs.c @ 565]
f392a2fc f8b4683a acpi!AcpiEvFixedEventDetect(void)+0x1a [reactos\drivers\b=
us\acpi\acpica\events\evevent.c @ 248]
f392a30c f8b2f1d2 acpi!AcpiEvSciXruptHandler(void * Context =3D 0xf50dbff0)=
+0x1a [reactos\drivers\bus\acpi\acpica\events\evsci.c @ 146]
f392a31c 804f160c acpi!OslIsrStub(struct _KINTERRUPT * Interrupt =3D 0xf50d=
dd98, void * ServiceContext =3D 0x00000000)+0x12 [reactos\drivers\bus\acpi\=
osl.c @ 541]
f392a350 804f1738 nt!KiChainedDispatch(struct _KTRAP_FRAME * TrapFrame =3D =
0xf392a364, struct _KINTERRUPT * Interrupt =3D 0xf50ddd98)+0xbc [reactos\nt=
oskrnl\ke\i386\irqobj.c @ 284]

Read Old (20160108) -- returns 0x0000:
kd> kp
ChildEBP RetAddr
f392a350 f8b3f57a acpi!AcpiOsReadPort(unsigned int64 Address =3D 0x4000, un=
signed int * Value =3D 0xf392a3bc, unsigned int Width =3D 0x10) [reactos\dr=
ivers\bus\acpi\osl.c @ 707]
f392a374 f8b3efbd acpi!AcpiHwReadPort(unsigned int64 Address =3D 0x4000, un=
signed int * Value =3D 0xf392a3bc, unsigned int Width =3D 0x10)+0x5a [react=
os\drivers\bus\acpi\acpica\hardware\hwvalid.c @ 258]
f392a3a4 f8b3f463 acpi!AcpiHwRead(unsigned int * Value =3D 0xf392a3bc, stru=
ct acpi_generic_address * Reg =3D 0xf8b68800)+0x7d [reactos\drivers\bus\acp=
i\acpica\hardware\hwregs.c @ 207]
f392a3c4 f8b3f1b5 acpi!AcpiHwReadMultiple(unsigned int * Value =3D 0xf392a3=
e0, struct acpi_generic_address * RegisterA =3D 0xf8b68800, struct acpi_gen=
eric_address * RegisterB =3D 0xf8b68630)+0x23 [reactos\drivers\bus\acpi\acp=
ica\hardware\hwregs.c @ 646]
f392a3e4 f8b3d72a acpi!AcpiHwRegisterRead(unsigned int RegisterId =3D 1, un=
signed int * ReturnValue =3D 0xf392a3f8)+0x45 [reactos\drivers\bus\acpi\acp=
ica\hardware\hwregs.c @ 431]
f392a404 f8b46d6a acpi!AcpiEvFixedEventDetect(void)+0x1a [reactos\drivers\b=
us\acpi\acpica\events\evevent.c @ 248]
f392a414 f8b2f1c2 acpi!AcpiEvSciXruptHandler(void * Context =3D 0xf4717ff0)=
+0x1a [reactos\drivers\bus\acpi\acpica\events\evsci.c @ 146]
f392a424 804f160c acpi!OslIsrStub(struct _KINTERRUPT * Interrupt =3D 0xf471=
9d98, void * ServiceContext =3D 0x00000000)+0x12 [reactos\drivers\bus\acpi\=
osl.c @ 541]
f392a458 804f1738 nt!KiChainedDispatch(struct _KTRAP_FRAME * TrapFrame =3D =
0xf392a46c, struct _KINTERRUPT * Interrupt =3D 0xf4719d98)+0xbc [reactos\nt=
oskrnl\ke\i386\irqobj.c @ 284]

--===============8199302872411859518==--

