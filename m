Content-Type: multipart/mixed; boundary="===============5544244610285042054=="
MIME-Version: 1.0
From: Devin Steffler <devinsteffler at gmail.com>
Subject: [Devel] Re: Question about ACPICA, QNX and making beeps
Date: Fri, 01 Oct 2021 15:08:39 -0400
Message-ID: <CAAuRk_g-rQQONwOCVvtzeO8Eq1XhcRDtyZzOnBsdAYGOdkbDpw@mail.gmail.com>
In-Reply-To: d81ebcde-8de7-7b09-911a-ede29e78b80b@assembler.cz
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5544244610285042054==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rudolf,

You're correct. Simply writing 0xa0 to 0xb2 will cause this.

I'm having a hard time figuring out what 0xb2 is. It seems like an I/O port
that causes an SMI and sets APMC_EN=3D1. That's all that I could find so fa=
r.
I have no idea yet what the bits in 0xa0 do.

Is this telling the BIOS that I have an APM aware OS (not ACPI)? If that's
the case, then I have a feeling that my ACPICA should be instead doing
something to say "I'm not APM aware" so that it doesn't try to do this. Or
is being "APM aware" required for ACPI functionality since it's the
successor to APM? On this system reading battery information works fine
without this write to 0xb2. I would have to test on other devices as well
to check if that's always the case or not.

As a side note, in case it's relevant, I am setting the following in my
ACPICA:
#define ACPI_OS_NAME                    "Microsoft Windows NT"

That was done arbitrarily or perhaps out of laziness/lack of testing
support. The comment above ACPI_OS_NAME suggests that it's obsolete anyways.

Unfortunately, I don't see any option in the BIOS relating to clock gating
or C11 power states.

Should I pursue allowing the write but then disable the clock gating
separately? I'm not sure how to do that yet.

I started to learn about clock gating. I wanted to see if I could confirm
that clock gating happens when 0xa0 is written to 0xb2. I stumbled on the
following information from Intel:
Datasheet:
https://www.intel.com/content/dam/www/public/us/en/documents/technical-spec=
ifications/300-series-chipset-on-package-pch-datasheet-vol-2.pdf
-------------------------------------------------
30.2.20 ITSS Power Reduction Control (ITSSPRC)=E2=80=94Offset 3300h
Power controls for the entire interrupt and timer subsystem.
Bit 2:
"8254 Static Clock Gating Enable (CGE8254): When set, the 8254 timer is
disabled statically. This bit shall be set by BIOS if the 8254 feature is
not needed in
the system or before BIOS hands off the system that supports C11. Normal
operation
of 8254 requires this bit to 0."
-------------------------------------------------

Unfortunately, I haven't been able to get access to that bit yet. The P2SB
Bridge is hidden. I've found a way to get the SBREG_BAR from the P2SB
Bridge in the QNX BSP. However, using it to read the ITSSPRC still returns
0xFFFFFFFF. I was hoping that I could clear that bit if it is getting set
to test if that makes the PC speaker work again.

Part of this is a learning exercise for me, but part of it is also to get a
proper fix for this system. If this is just an "APM thing" that shouldn't
be enabled to begin with on my system, then I guess I need to figure out
how to tell BIOS that this OS is "not APM aware". Either that, or just
block 0xa0 writes to 0xb2 (but that feels like the wrong approach).

Thanks,
Devin



On Thu, Sep 30, 2021 at 1:12 PM Rudolf Marek <r.marek(a)assembler.cz> wrote:

> On 30. 09. 21 15:53, Devin Steffler wrote:
> > Hello,
> >
> > Will Miles suggested that I monitor AcpiOsRead* and AcpiOsWrite* calls.
> I observed the following:
> > ./test_sound # it plays fine
> > ./acpica
> > AcpiOsReadPort: read 0x0 from 0x1804 with width 16
> > AcpiOsReadPort: read 0x0 from 0x1804 with width 16
> > AcpiOsWritePort: write 0xa0 to 0xb2 with width 8
>
> This is likely the SMI_CMD and ACPI_ENABLE see my other mail.
>
> > AcpiOsReadPort: read 0x1 from 0x1804 with width 16
> > ./test_sound # it stops working
> >
> > To check if that write to 0xb2 is related, I modified AcpiOsWritePort to
> return AE_OK on all writes to Address 0xb2 without doing the actual write.
> I also modified AcpiOsReadPort to do a "fake read" of 1 when reading from
> port 0x1804 if there was a previous write to 0xb2. When I do this, then t=
he
> beep continues to work and reading battery information via ACPI also
> continues to work (at least on this laptop, I haven't tested other devices
> yet).
>
> Try vice versa, do not enable/use the ACPICA at all and write 0xa0 to 0xb2
> to see if it breaks it.
>
> > Looking at the PCH datasheet for the Intel i5 11357G CPU (what I'm using
> at the moment), it looks like writing to 0xb2 will trigger an SMI and set
> "APMC_EN =3D1" and is reported via APM_STS. Does this mean that it's supp=
osed
> to activate power management and enable SMI interrupts for BIOS controlled
> power management (i.e. to be executed by ACPICA via SMI interrupt
> handlers)?
>
> It tells BIOS, hey I'm ACPI aware OS stop messing around. And basically
> BIOS runs some unknown code in SMM when you just write to 0xb2 the 0xA0
> command.
> This unknown code can possibly enable the 8254 clock gating.
>
> >I'm not sure why that would break the PC speaker. Could it be that my OSL
> interrupt handling is broken and BIOS was relying on it to re-enable the
> devices needed to use the PC speaker?
>
> The PC speaker does not do anything with IRQs. The PIT has no
> architecturally defined way to be disabled. I don't know what Intel smokes
> but lets not inhale, intel invented the clock gating to make programers
> life more miserable (problem for TSC/lapic clock calibration when you have
> no HPET)
>
> > Or could APMC_EN=3D1 also "turn off some devices (that the PC speaker
> requires) to save power as they won't be used by this OS"? Should I inste=
ad
> be looking at the ACPI tables for this laptop to see if something is being
> turned off to save power and figure out how to turn them back on via ACPI
> calls?
>
> This is likely not the problem. The ACPI tables do not instruct the
> hardware, because you commented out above write. Also most hardware for
> chipset is memory mapped, not IOport mapped. Try what I wrote above. If it
> breaks, it confirms that BIOS is doing something behind the scene which is
> not even ACPICA related.
>
> > The same section (22.4.5 SMI#/SCI Generation) in the datasheet also
> states things like the following:
> > "The SCI is a level-mode interrupt that is typically handled by an
> ACPI-aware operating
> > system. In non-APIC systems (which is the default), the SCI IRQ is
> routed to one of
> > the 8259 interrupts (IRQ 9, 10, or 11). The 8259 interrupt controller
> must be
> > programmed to level mode for that interrupt."
>
> I don't think it is problem with SCI. See above.
>
> The 8254 clock gating will slow down the PIT frequency 16x and it will
> stop legacy IRQ 0  (on PIC/IOAPIC) generation as a symptom of clock gatin=
g.
> This is not documented but it behaves like that. Yes again intel did not
> stop the counter completely to detect it but slowed down. Sigh.
>
> Maybe it also affects PC speaker that it generates waveforms too slowly.
> You can also try to search BIOS option in setup menu for clock gating or
> try to disable C11 power state in there.
>
> Yes it is mess.
>
> Thanks,
> Rudolf
>
>

--===============5544244610285042054==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSAKUnVkb2xmLDwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+
WW91JiMzOTtyZSBjb3JyZWN0LiBTaW1wbHkgd3JpdGluZyAweGEwIHRvIDB4YjIgd2lsbCBjYXVz
ZSB0aGlzLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SSYjMzk7bSBoYXZpbmcgYSBoYXJkIHRp
bWUgZmlndXJpbmcgb3V0IHdoYXQgMHhiMiBpcy4gSXQgc2VlbXMgbGlrZSBhbiBJL08gcG9ydCB0
aGF0IGNhdXNlcyBhbiBTTUkgYW5kIHNldHMgQVBNQ19FTj0xLiBUaGF0JiMzOTtzIGFsbCB0aGF0
IEkgY291bGQgZmluZCBzbyBmYXIuIEkgaGF2ZSBubyBpZGVhIHlldCB3aGF0IHRoZSBiaXRzIGlu
IDB4YTAgZG8uPGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SXMgdGhpcyB0ZWxsaW5nIHRo
ZSBCSU9TIHRoYXQgSSBoYXZlIGFuIEFQTSBhd2FyZSBPUyAobm90IEFDUEkpPyBJZiB0aGF0JiMz
OTtzIHRoZSBjYXNlLCB0aGVuIEkgaGF2ZSBhIGZlZWxpbmcgdGhhdCBteSBBQ1BJQ0Egc2hvdWxk
IGJlIGluc3RlYWQgZG9pbmcgc29tZXRoaW5nIHRvIHNheSAmcXVvdDtJJiMzOTttIG5vdCBBUE0g
YXdhcmUmcXVvdDsgc28gdGhhdCBpdCBkb2VzbiYjMzk7dCB0cnkgdG8gZG8gdGhpcy4gT3IgaXMg
YmVpbmcgJnF1b3Q7QVBNIGF3YXJlJnF1b3Q7IHJlcXVpcmVkIGZvciBBQ1BJIGZ1bmN0aW9uYWxp
dHkgc2luY2UgaXQmIzM5O3MgdGhlIHN1Y2Nlc3NvciB0byBBUE0/IE9uIHRoaXMgc3lzdGVtIHJl
YWRpbmcgYmF0dGVyeSBpbmZvcm1hdGlvbiB3b3JrcyBmaW5lIHdpdGhvdXQgdGhpcyB3cml0ZSB0
byAweGIyLiBJIHdvdWxkIGhhdmUgdG8gdGVzdCBvbiBvdGhlciBkZXZpY2VzIGFzIHdlbGwgdG8g
Y2hlY2sgaWYgdGhhdCYjMzk7cyBhbHdheXMgdGhlIGNhc2Ugb3Igbm90Ljxicj48L2Rpdj48ZGl2
Pjxicj48L2Rpdj48ZGl2PkFzIGEgc2lkZSBub3RlLCBpbiBjYXNlIGl0JiMzOTtzIHJlbGV2YW50
LCBJIGFtIHNldHRpbmcgdGhlIGZvbGxvd2luZyBpbiBteSBBQ1BJQ0E6PC9kaXY+PGRpdj4jZGVm
aW5lIEFDUElfT1NfTkFNRSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZxdW90O01pY3Jv
c29mdCBXaW5kb3dzIE5UJnF1b3Q7PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+VGhhdCB3
YXMgZG9uZSBhcmJpdHJhcmlseSBvciBwZXJoYXBzIG91dCBvZiBsYXppbmVzcy9sYWNrIG9mIHRl
c3Rpbmcgc3VwcG9ydC4gVGhlIGNvbW1lbnQgYWJvdmUgQUNQSV9PU19OQU1FIHN1Z2dlc3RzIHRo
YXQgaXQmIzM5O3Mgb2Jzb2xldGUgYW55d2F5cy48YnI+PC9kaXY+PGJyPjxkaXY+VW5mb3J0dW5h
dGVseSwgSSBkb24mIzM5O3Qgc2VlIGFueSBvcHRpb24gaW4gdGhlIEJJT1MgcmVsYXRpbmcgdG8g
Y2xvY2sgZ2F0aW5nIG9yIEMxMSBwb3dlciBzdGF0ZXMuPGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2
PjxkaXY+U2hvdWxkIEkgcHVyc3VlIGFsbG93aW5nIHRoZSB3cml0ZSBidXQgdGhlbiBkaXNhYmxl
IHRoZSBjbG9jayBnYXRpbmcgc2VwYXJhdGVseT8gSSYjMzk7bSBub3Qgc3VyZSBob3cgdG8gZG8g
dGhhdCB5ZXQuPGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SSBzdGFydGVkIHRvIGxlYXJu
IGFib3V0IGNsb2NrIGdhdGluZy4gSSB3YW50ZWQgdG8gc2VlIGlmIEkgY291bGQgY29uZmlybSB0
aGF0IGNsb2NrIGdhdGluZyBoYXBwZW5zIHdoZW4gMHhhMCBpcyB3cml0dGVuIHRvIDB4YjIuIEkg
c3R1bWJsZWQgb24gdGhlIGZvbGxvd2luZyBpbmZvcm1hdGlvbiBmcm9tIEludGVsOjwvZGl2Pjxk
aXY+PC9kaXY+PGRpdj5EYXRhc2hlZXQ6IDxhIGhyZWY9Imh0dHBzOi8vd3d3LmludGVsLmNvbS9j
b250ZW50L2RhbS93d3cvcHVibGljL3VzL2VuL2RvY3VtZW50cy90ZWNobmljYWwtc3BlY2lmaWNh
dGlvbnMvMzAwLXNlcmllcy1jaGlwc2V0LW9uLXBhY2thZ2UtcGNoLWRhdGFzaGVldC12b2wtMi5w
ZGYiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL3d3dy5pbnRlbC5jb20vY29udGVudC9kYW0vd3d3
L3B1YmxpYy91cy9lbi9kb2N1bWVudHMvdGVjaG5pY2FsLXNwZWNpZmljYXRpb25zLzMwMC1zZXJp
ZXMtY2hpcHNldC1vbi1wYWNrYWdlLXBjaC1kYXRhc2hlZXQtdm9sLTIucGRmPC9hPjwvZGl2Pjxk
aXY+Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KCjwv
ZGl2PjxkaXY+MzAuMi4yMCBJVFNTIFBvd2VyIFJlZHVjdGlvbiBDb250cm9sIChJVFNTUFJDKeKA
lE9mZnNldCAzMzAwaDxicj5Qb3dlciBjb250cm9scyBmb3IgdGhlIGVudGlyZSBpbnRlcnJ1cHQg
YW5kIHRpbWVyIHN1YnN5c3RlbS48YnI+Qml0IDI6PGJyPiZxdW90OzgyNTQgU3RhdGljIENsb2Nr
IEdhdGluZyBFbmFibGUgKENHRTgyNTQpOiBXaGVuIHNldCwgdGhlIDgyNTQgdGltZXIgaXMgPGJy
PmRpc2FibGVkIHN0YXRpY2FsbHkuIFRoaXMgYml0IHNoYWxsIGJlIHNldCBieSBCSU9TIGlmIHRo
ZSA4MjU0IGZlYXR1cmUgaXMgbm90IG5lZWRlZCBpbiA8YnI+dGhlIHN5c3RlbSBvciBiZWZvcmUg
QklPUyBoYW5kcyBvZmYgdGhlIHN5c3RlbSB0aGF0IHN1cHBvcnRzIEMxMS4gTm9ybWFsIG9wZXJh
dGlvbiA8YnI+b2YgODI1NCByZXF1aXJlcyB0aGlzIGJpdCB0byAwLiZxdW90Ozxicj4tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPC9kaXY+PGRpdj48YnI+
PC9kaXY+PGRpdj5VbmZvcnR1bmF0ZWx5LCBJIGhhdmVuJiMzOTt0IGJlZW4gYWJsZSB0byBnZXQg
YWNjZXNzIHRvIHRoYXQgYml0IHlldC4gVGhlIFAyU0IgQnJpZGdlIGlzIGhpZGRlbi4gSSYjMzk7
dmUgZm91bmQgYSB3YXkgdG8gZ2V0IHRoZSBTQlJFR19CQVIgZnJvbSB0aGUgUDJTQiBCcmlkZ2Ug
aW4gdGhlIFFOWCBCU1AuIEhvd2V2ZXIsIHVzaW5nIGl0IHRvIHJlYWQgdGhlIElUU1NQUkMgc3Rp
bGwgcmV0dXJucyAweEZGRkZGRkZGLiBJIHdhcyBob3BpbmcgdGhhdCBJIGNvdWxkIGNsZWFyIHRo
YXQgYml0IGlmIGl0IGlzIGdldHRpbmcgc2V0IHRvIHRlc3QgaWYgdGhhdCBtYWtlcyB0aGUgUEMg
c3BlYWtlciB3b3JrIGFnYWluLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+UGFydCBvZiB0aGlz
IGlzIGEgbGVhcm5pbmcgZXhlcmNpc2UgZm9yIG1lLCBidXQgcGFydCBvZiBpdCBpcyBhbHNvIHRv
IGdldCBhIHByb3BlciBmaXggZm9yIHRoaXMgc3lzdGVtLiBJZiB0aGlzIGlzIGp1c3QgYW4gJnF1
b3Q7QVBNIHRoaW5nJnF1b3Q7IHRoYXQgc2hvdWxkbiYjMzk7dCBiZSBlbmFibGVkIHRvIGJlZ2lu
IHdpdGggb24gbXkgc3lzdGVtLCB0aGVuIEkgZ3Vlc3MgSSBuZWVkIHRvIGZpZ3VyZSBvdXQgaG93
IHRvIHRlbGwgQklPUyB0aGF0IHRoaXMgT1MgaXMgJnF1b3Q7bm90IEFQTSBhd2FyZSZxdW90Oy4g
RWl0aGVyIHRoYXQsIG9yIGp1c3QgYmxvY2sgMHhhMCB3cml0ZXMgdG8gMHhiMiAoYnV0IHRoYXQg
ZmVlbHMgbGlrZSB0aGUgd3JvbmcgYXBwcm9hY2gpLjxicj48L2Rpdj48YnI+PGRpdj5UaGFua3Ms
PC9kaXY+PGRpdj5EZXZpbjxicj48L2Rpdj48ZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJyPjwv
ZGl2PjwvZGl2PjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0
ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9uIFRodSwgU2VwIDMwLCAyMDIxIGF0IDE6MTIgUE0gUnVk
b2xmIE1hcmVrICZsdDs8YSBocmVmPSJtYWlsdG86ci5tYXJla0Bhc3NlbWJsZXIuY3oiIHRhcmdl
dD0iX2JsYW5rIj5yLm1hcmVrQGFzc2VtYmxlci5jejwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48
YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHgg
MC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0
OjFleCI+T24gMzAuIDA5LiAyMSAxNTo1MywgRGV2aW4gU3RlZmZsZXIgd3JvdGU6PGJyPgomZ3Q7
IEhlbGxvLDxicj4KJmd0OyA8YnI+CiZndDsgV2lsbCBNaWxlcyBzdWdnZXN0ZWQgdGhhdCBJIG1v
bml0b3IgQWNwaU9zUmVhZCogYW5kIEFjcGlPc1dyaXRlKiBjYWxscy4gSSBvYnNlcnZlZCB0aGUg
Zm9sbG93aW5nOjxicj4KJmd0OyAuL3Rlc3Rfc291bmQgIyBpdCBwbGF5cyBmaW5lPGJyPgomZ3Q7
IC4vYWNwaWNhPGJyPgomZ3Q7IEFjcGlPc1JlYWRQb3J0OiByZWFkIDB4MCBmcm9tIDB4MTgwNCB3
aXRoIHdpZHRoIDE2PGJyPgomZ3Q7IEFjcGlPc1JlYWRQb3J0OiByZWFkIDB4MCBmcm9tIDB4MTgw
NCB3aXRoIHdpZHRoIDE2PGJyPgomZ3Q7IEFjcGlPc1dyaXRlUG9ydDogd3JpdGUgMHhhMCB0byAw
eGIyIHdpdGggd2lkdGggODxicj4KPGJyPgpUaGlzIGlzIGxpa2VseSB0aGUgU01JX0NNRCBhbmQg
QUNQSV9FTkFCTEUgc2VlIG15IG90aGVyIG1haWwuPGJyPgo8YnI+CiZndDsgQWNwaU9zUmVhZFBv
cnQ6IHJlYWQgMHgxIGZyb20gMHgxODA0IHdpdGggd2lkdGggMTY8YnI+CiZndDsgLi90ZXN0X3Nv
dW5kICMgaXQgc3RvcHMgd29ya2luZzxicj4KJmd0OyA8YnI+CiZndDsgVG8gY2hlY2sgaWYgdGhh
dCB3cml0ZSB0byAweGIyIGlzIHJlbGF0ZWQsIEkgbW9kaWZpZWQgQWNwaU9zV3JpdGVQb3J0IHRv
IHJldHVybiBBRV9PSyBvbiBhbGwgd3JpdGVzIHRvIEFkZHJlc3MgMHhiMiB3aXRob3V0IGRvaW5n
IHRoZSBhY3R1YWwgd3JpdGUuIEkgYWxzbyBtb2RpZmllZCBBY3BpT3NSZWFkUG9ydCB0byBkbyBh
ICZxdW90O2Zha2UgcmVhZCZxdW90OyBvZiAxIHdoZW4gcmVhZGluZyBmcm9tIHBvcnQgMHgxODA0
IGlmIHRoZXJlIHdhcyBhIHByZXZpb3VzIHdyaXRlIHRvIDB4YjIuIFdoZW4gSSBkbyB0aGlzLCB0
aGVuIHRoZSBiZWVwIGNvbnRpbnVlcyB0byB3b3JrIGFuZCByZWFkaW5nIGJhdHRlcnkgaW5mb3Jt
YXRpb24gdmlhIEFDUEkgYWxzbyBjb250aW51ZXMgdG8gd29yayAoYXQgbGVhc3Qgb24gdGhpcyBs
YXB0b3AsIEkgaGF2ZW4mIzM5O3QgdGVzdGVkIG90aGVyIGRldmljZXMgeWV0KS48YnI+Cjxicj4K
VHJ5IHZpY2UgdmVyc2EsIGRvIG5vdCBlbmFibGUvdXNlIHRoZSBBQ1BJQ0EgYXQgYWxsIGFuZCB3
cml0ZSAweGEwIHRvIDB4YjIgdG8gc2VlIGlmIGl0IGJyZWFrcyBpdC48YnI+Cjxicj4KJmd0OyBM
b29raW5nIGF0IHRoZSBQQ0ggZGF0YXNoZWV0IGZvciB0aGUgSW50ZWwgaTUgMTEzNTdHIENQVSAo
d2hhdCBJJiMzOTttIHVzaW5nIGF0IHRoZSBtb21lbnQpLCBpdCBsb29rcyBsaWtlIHdyaXRpbmcg
dG8gMHhiMiB3aWxsIHRyaWdnZXIgYW4gU01JIGFuZCBzZXQgJnF1b3Q7QVBNQ19FTiA9MSZxdW90
OyBhbmQgaXMgcmVwb3J0ZWQgdmlhIEFQTV9TVFMuIERvZXMgdGhpcyBtZWFuIHRoYXQgaXQmIzM5
O3Mgc3VwcG9zZWQgdG8gYWN0aXZhdGUgcG93ZXIgbWFuYWdlbWVudCBhbmQgZW5hYmxlIFNNSSBp
bnRlcnJ1cHRzIGZvciBCSU9TIGNvbnRyb2xsZWQgcG93ZXIgbWFuYWdlbWVudCAoaS5lLiB0byBi
ZSBleGVjdXRlZCBieSBBQ1BJQ0EgdmlhIFNNSSBpbnRlcnJ1cHQgaGFuZGxlcnMpPyA8YnI+Cjxi
cj4KSXQgdGVsbHMgQklPUywgaGV5IEkmIzM5O20gQUNQSSBhd2FyZSBPUyBzdG9wIG1lc3Npbmcg
YXJvdW5kLiBBbmQgYmFzaWNhbGx5IEJJT1MgcnVucyBzb21lIHVua25vd24gY29kZSBpbiBTTU0g
d2hlbiB5b3UganVzdCB3cml0ZSB0byAweGIyIHRoZSAweEEwIGNvbW1hbmQuPGJyPgpUaGlzIHVu
a25vd24gY29kZSBjYW4gcG9zc2libHkgZW5hYmxlIHRoZSA4MjU0IGNsb2NrIGdhdGluZy48YnI+
Cjxicj4KJmd0O0kmIzM5O20gbm90IHN1cmUgd2h5IHRoYXQgd291bGQgYnJlYWsgdGhlIFBDIHNw
ZWFrZXIuIENvdWxkIGl0IGJlIHRoYXQgbXkgT1NMIGludGVycnVwdCBoYW5kbGluZyBpcyBicm9r
ZW4gYW5kIEJJT1Mgd2FzIHJlbHlpbmcgb24gaXQgdG8gcmUtZW5hYmxlIHRoZSBkZXZpY2VzIG5l
ZWRlZCB0byB1c2UgdGhlIFBDIHNwZWFrZXI/PGJyPgo8YnI+ClRoZSBQQyBzcGVha2VyIGRvZXMg
bm90IGRvIGFueXRoaW5nIHdpdGggSVJRcy4gVGhlIFBJVCBoYXMgbm8gYXJjaGl0ZWN0dXJhbGx5
IGRlZmluZWQgd2F5IHRvIGJlIGRpc2FibGVkLiBJIGRvbiYjMzk7dCBrbm93IHdoYXQgSW50ZWwg
c21va2VzIGJ1dCBsZXRzIG5vdCBpbmhhbGUsIGludGVsIGludmVudGVkIHRoZSBjbG9jayBnYXRp
bmcgdG8gbWFrZSBwcm9ncmFtZXJzIGxpZmUgbW9yZSBtaXNlcmFibGUgKHByb2JsZW0gZm9yIFRT
Qy9sYXBpYyBjbG9jayBjYWxpYnJhdGlvbiB3aGVuIHlvdSBoYXZlIG5vIEhQRVQpPGJyPgo8YnI+
CiZndDsgT3IgY291bGQgQVBNQ19FTj0xIGFsc28gJnF1b3Q7dHVybiBvZmYgc29tZSBkZXZpY2Vz
ICh0aGF0IHRoZSBQQyBzcGVha2VyIHJlcXVpcmVzKSB0byBzYXZlIHBvd2VyIGFzIHRoZXkgd29u
JiMzOTt0IGJlIHVzZWQgYnkgdGhpcyBPUyZxdW90Oz8gU2hvdWxkIEkgaW5zdGVhZCBiZSBsb29r
aW5nIGF0IHRoZSBBQ1BJIHRhYmxlcyBmb3IgdGhpcyBsYXB0b3AgdG8gc2VlIGlmIHNvbWV0aGlu
ZyBpcyBiZWluZyB0dXJuZWQgb2ZmIHRvIHNhdmUgcG93ZXIgYW5kIGZpZ3VyZSBvdXQgaG93IHRv
IHR1cm4gdGhlbSBiYWNrIG9uIHZpYSBBQ1BJIGNhbGxzPzxicj4KPGJyPgpUaGlzIGlzIGxpa2Vs
eSBub3QgdGhlIHByb2JsZW0uIFRoZSBBQ1BJIHRhYmxlcyBkbyBub3QgaW5zdHJ1Y3QgdGhlIGhh
cmR3YXJlLCBiZWNhdXNlIHlvdSBjb21tZW50ZWQgb3V0IGFib3ZlIHdyaXRlLiBBbHNvIG1vc3Qg
aGFyZHdhcmUgZm9yIGNoaXBzZXQgaXMgbWVtb3J5IG1hcHBlZCwgbm90IElPcG9ydCBtYXBwZWQu
IFRyeSB3aGF0IEkgd3JvdGUgYWJvdmUuIElmIGl0IGJyZWFrcywgaXQgY29uZmlybXMgdGhhdCBC
SU9TIGlzIGRvaW5nIHNvbWV0aGluZyBiZWhpbmQgdGhlIHNjZW5lIHdoaWNoIGlzIG5vdCBldmVu
IEFDUElDQSByZWxhdGVkLjxicj4KPGJyPgomZ3Q7IFRoZSBzYW1lIHNlY3Rpb24gKDIyLjQuNSBT
TUkjL1NDSSBHZW5lcmF0aW9uKSBpbiB0aGUgZGF0YXNoZWV0IGFsc28gc3RhdGVzIHRoaW5ncyBs
aWtlIHRoZSBmb2xsb3dpbmc6PGJyPgomZ3Q7ICZxdW90O1RoZSBTQ0kgaXMgYSBsZXZlbC1tb2Rl
IGludGVycnVwdCB0aGF0IGlzIHR5cGljYWxseSBoYW5kbGVkIGJ5IGFuIEFDUEktYXdhcmUgb3Bl
cmF0aW5nPGJyPgomZ3Q7IHN5c3RlbS4gSW4gbm9uLUFQSUMgc3lzdGVtcyAod2hpY2ggaXMgdGhl
IGRlZmF1bHQpLCB0aGUgU0NJIElSUSBpcyByb3V0ZWQgdG8gb25lIG9mPGJyPgomZ3Q7IHRoZSA4
MjU5IGludGVycnVwdHMgKElSUSA5LCAxMCwgb3IgMTEpLiBUaGUgODI1OSBpbnRlcnJ1cHQgY29u
dHJvbGxlciBtdXN0IGJlPGJyPgomZ3Q7IHByb2dyYW1tZWQgdG8gbGV2ZWwgbW9kZSBmb3IgdGhh
dCBpbnRlcnJ1cHQuJnF1b3Q7PGJyPgo8YnI+CkkgZG9uJiMzOTt0IHRoaW5rIGl0IGlzIHByb2Js
ZW0gd2l0aCBTQ0kuIFNlZSBhYm92ZS48YnI+Cjxicj4KVGhlIDgyNTQgY2xvY2sgZ2F0aW5nIHdp
bGwgc2xvdyBkb3duIHRoZSBQSVQgZnJlcXVlbmN5IDE2eCBhbmQgaXQgd2lsbCBzdG9wIGxlZ2Fj
eSBJUlEgMMKgIChvbiBQSUMvSU9BUElDKSBnZW5lcmF0aW9uIGFzIGEgc3ltcHRvbSBvZiBjbG9j
ayBnYXRpbmcuIFRoaXMgaXMgbm90IGRvY3VtZW50ZWQgYnV0IGl0IGJlaGF2ZXMgbGlrZSB0aGF0
LiBZZXMgYWdhaW4gaW50ZWwgZGlkIG5vdCBzdG9wIHRoZSBjb3VudGVyIGNvbXBsZXRlbHkgdG8g
ZGV0ZWN0IGl0IGJ1dCBzbG93ZWQgZG93bi4gU2lnaC48YnI+Cjxicj4KTWF5YmUgaXQgYWxzbyBh
ZmZlY3RzIFBDIHNwZWFrZXIgdGhhdCBpdCBnZW5lcmF0ZXMgd2F2ZWZvcm1zIHRvbyBzbG93bHku
IFlvdSBjYW4gYWxzbyB0cnkgdG8gc2VhcmNoIEJJT1Mgb3B0aW9uIGluIHNldHVwIG1lbnUgZm9y
IGNsb2NrIGdhdGluZyBvciB0cnkgdG8gZGlzYWJsZSBDMTEgcG93ZXIgc3RhdGUgaW4gdGhlcmUu
PGJyPgo8YnI+ClllcyBpdCBpcyBtZXNzLjxicj4KPGJyPgpUaGFua3MsPGJyPgpSdWRvbGY8YnI+
Cjxicj4KPC9ibG9ja3F1b3RlPjwvZGl2Pgo=

--===============5544244610285042054==--

