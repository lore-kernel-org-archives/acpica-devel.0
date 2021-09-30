Content-Type: multipart/mixed; boundary="===============4049134394345310491=="
MIME-Version: 1.0
From: Devin Steffler <devinsteffler at gmail.com>
Subject: [Devel] Re: Question about ACPICA, QNX and making beeps
Date: Thu, 30 Sep 2021 09:53:55 -0400
Message-ID: <CAAuRk_iKBx7Zmo60BDqFzmzqjz3q1vHPtNxje-KUcpixO_n+pg@mail.gmail.com>
In-Reply-To: CAAuRk_jLAfxp7ryhuWPORetZaqMPoNmsHYP6Y=BtkCucAyp45w@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4049134394345310491==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Will Miles suggested that I monitor AcpiOsRead* and AcpiOsWrite* calls. I
observed the following:
./test_sound # it plays fine
./acpica
AcpiOsReadPort: read 0x0 from 0x1804 with width 16
AcpiOsReadPort: read 0x0 from 0x1804 with width 16
AcpiOsWritePort: write 0xa0 to 0xb2 with width 8
AcpiOsReadPort: read 0x1 from 0x1804 with width 16
./test_sound # it stops working

To check if that write to 0xb2 is related, I modified AcpiOsWritePort to
return AE_OK on all writes to Address 0xb2 without doing the actual write.
I also modified AcpiOsReadPort to do a "fake read" of 1 when reading from
port 0x1804 if there was a previous write to 0xb2. When I do this, then the
beep continues to work and reading battery information via ACPI also
continues to work (at least on this laptop, I haven't tested other devices
yet).

I'm not really sure where to go from here. For this laptop, this might be a
suitable workaround for me as I'm only using ACPICA at the moment to read
battery information and for system shutdown. However, this might not be an
acceptable workaround for other devices (or if I end up needing other ACPI
functionality in the future that depends on this). I also suspect that my
OSL might be missing something that is causing this.

Looking at the PCH datasheet for the Intel i5 11357G CPU (what I'm using at
the moment), it looks like writing to 0xb2 will trigger an SMI and set
"APMC_EN =3D1" and is reported via APM_STS. Does this mean that it's suppos=
ed
to activate power management and enable SMI interrupts for BIOS controlled
power management (i.e. to be executed by ACPICA via SMI interrupt
handlers)? I'm not sure why that would break the PC speaker. Could it be
that my OSL interrupt handling is broken and BIOS was relying on it to
re-enable the devices needed to use the PC speaker?

Or could APMC_EN=3D1 also "turn off some devices (that the PC speaker
requires) to save power as they won't be used by this OS"? Should I instead
be looking at the ACPI tables for this laptop to see if something is being
turned off to save power and figure out how to turn them back on via ACPI
calls?

The same section (22.4.5 SMI#/SCI Generation) in the datasheet also states
things like the following:
"The SCI is a level-mode interrupt that is typically handled by an
ACPI-aware operating
system. In non-APIC systems (which is the default), the SCI IRQ is routed
to one of
the 8259 interrupts (IRQ 9, 10, or 11). The 8259 interrupt controller must
be
programmed to level mode for that interrupt."

Thanks,
Devin

On Tue, Sep 28, 2021 at 3:04 PM Devin Steffler <devinsteffler(a)gmail.com>
wrote:

> Hello,
>
> I am using ACPICA to read battery information in QNX. That part is working
> great so far. However, now some code that is being used to make beeps via
> the PC speaker stopped working.
>
> Strangely, this code stops working on a few devices only after ACPICA
> runs. It works fine if I don't start ACPICA. The code is using I/O ports
> 0x43, 0x42, and 0x61 to generate beeps. This seems to be an industry
> standard way to make beeps on x86 based PCs using a Programmable Interval
> Timer (PIT).
>
> What could my ACPICA be doing (or failing to do) that could cause the
> beeps to stop working with the code below? Is the PIT being disabled
> somehow? I guess I'll need to learn more about the PIT and how to check i=
ts
> status to see if it's being disabled after ACPICA runs.
>
> Here's example code for QNX to generate a beep using the PC speaker:
> // -----------------------------------------------
> #include <sys/neutrino.h>
> #include <hw/inout.h>
> #include <unistd.h>
>
> int main(void) {
>     ThreadCtl( _NTO_TCTL_IO, 0 ); // get I/O permissions
>
>     // start a beep
>     int freq =3D 1000;
>     int scale =3D 1193046 / freq;
>     out8(0x43, 0xb6);
>     out8(0x42, scale & 0xff);
>     out8(0x42, scale >> 8);
>     out8(0x61, in8(0x61) | 3);
>
>     // let the beep play for a second
>     delay(1000);
>
>     // stop the beep
>     out8(0x61, in8(0x61) & ~3);
>
>     return 0;
> }
> // -----------------------------------------------
>
> Thanks,
> Devin
>

--===============4049134394345310491==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdj5IZWxsbyw8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PldpbGwg
TWlsZXMgc3VnZ2VzdGVkIHRoYXQgSSBtb25pdG9yIApBY3BpT3NSZWFkKiBhbmQgQWNwaU9zV3Jp
dGUqIGNhbGxzLiBJIG9ic2VydmVkIHRoZSBmb2xsb3dpbmc6PC9kaXY+PGRpdj4uL3Rlc3Rfc291
bmQgIyBpdCBwbGF5cyBmaW5lPC9kaXY+PGRpdj4uL2FjcGljYTwvZGl2PjxkaXY+QWNwaU9zUmVh
ZFBvcnQ6IHJlYWQgMHgwIGZyb20gMHgxODA0IHdpdGggd2lkdGggMTY8YnI+QWNwaU9zUmVhZFBv
cnQ6IHJlYWQgMHgwIGZyb20gMHgxODA0IHdpdGggd2lkdGggMTY8YnI+QWNwaU9zV3JpdGVQb3J0
OiB3cml0ZSAweGEwIHRvIDB4YjIgd2l0aCB3aWR0aCA4PGJyPkFjcGlPc1JlYWRQb3J0OiByZWFk
IDB4MSBmcm9tIDB4MTgwNCB3aXRoIHdpZHRoIDE2PC9kaXY+PGRpdj4uL3Rlc3Rfc291bmQgIyBp
dCBzdG9wcyB3b3JraW5nPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48L2Rpdj48ZGl2PlRvIGNo
ZWNrIGlmIHRoYXQgd3JpdGUgdG8gMHhiMiBpcyByZWxhdGVkLCBJIG1vZGlmaWVkIApBY3BpT3NX
cml0ZVBvcnQgdG8gcmV0dXJuIEFFX09LIG9uIGFsbCB3cml0ZXMgdG8gQWRkcmVzcyAweGIyIHdp
dGhvdXQgZG9pbmcgdGhlIGFjdHVhbCB3cml0ZS4gSSBhbHNvIG1vZGlmaWVkIApBY3BpT3NSZWFk
UG9ydCB0byBkbyBhICZxdW90O2Zha2UgcmVhZCZxdW90OyBvZiAxIHdoZW4gcmVhZGluZyBmcm9t
IHBvcnQgMHgxODA0IGlmIHRoZXJlIHdhcyBhIHByZXZpb3VzIHdyaXRlIHRvIDB4YjIuIFdoZW4g
SSBkbyB0aGlzLCB0aGVuIHRoZSBiZWVwIGNvbnRpbnVlcyB0byB3b3JrIGFuZCByZWFkaW5nIGJh
dHRlcnkgaW5mb3JtYXRpb24gdmlhIEFDUEkgYWxzbyBjb250aW51ZXMgdG8gd29yayAoYXQgbGVh
c3Qgb24gdGhpcyBsYXB0b3AsIEkgaGF2ZW4mIzM5O3QgdGVzdGVkIG90aGVyIGRldmljZXMgeWV0
KS48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkkmIzM5O20gbm90IHJlYWxseSBzdXJlIHdoZXJl
IHRvIGdvIGZyb20gaGVyZS4gRm9yIHRoaXMgbGFwdG9wLCB0aGlzIG1pZ2h0IGJlIGEgc3VpdGFi
bGUgd29ya2Fyb3VuZCBmb3IgbWUgYXMgSSYjMzk7bSBvbmx5IHVzaW5nIEFDUElDQSBhdCB0aGUg
bW9tZW50IHRvIHJlYWQgYmF0dGVyeSBpbmZvcm1hdGlvbiBhbmQgZm9yIHN5c3RlbSBzaHV0ZG93
bi4gSG93ZXZlciwgdGhpcyBtaWdodCBub3QgYmUgYW4gYWNjZXB0YWJsZSB3b3JrYXJvdW5kIGZv
ciBvdGhlciBkZXZpY2VzIChvciBpZiBJIGVuZCB1cCBuZWVkaW5nIG90aGVyIEFDUEkgZnVuY3Rp
b25hbGl0eSBpbiB0aGUgZnV0dXJlIHRoYXQgZGVwZW5kcyBvbiB0aGlzKS4gSSBhbHNvIHN1c3Bl
Y3QgdGhhdCBteSBPU0wgbWlnaHQgYmUgbWlzc2luZyBzb21ldGhpbmcgdGhhdCBpcyBjYXVzaW5n
IHRoaXMuPGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+TG9va2luZyBhdCB0aGUgUENIIGRh
dGFzaGVldCBmb3IgdGhlIEludGVsIGk1IDExMzU3RyBDUFUgKHdoYXQgSSYjMzk7bSB1c2luZyBh
dCB0aGUgbW9tZW50KSwgaXQgbG9va3MgbGlrZSB3cml0aW5nIHRvIDB4YjIgd2lsbCB0cmlnZ2Vy
IGFuIFNNSSBhbmQgc2V0ICZxdW90O0FQTUNfRU4gPTEmcXVvdDsgYW5kIGlzIHJlcG9ydGVkIHZp
YSBBUE1fU1RTLiBEb2VzIHRoaXMgbWVhbiB0aGF0IGl0JiMzOTtzIHN1cHBvc2VkIHRvIGFjdGl2
YXRlIHBvd2VyIG1hbmFnZW1lbnQgYW5kIGVuYWJsZSBTTUkgaW50ZXJydXB0cyBmb3IgQklPUyBj
b250cm9sbGVkIHBvd2VyIG1hbmFnZW1lbnQgKGkuZS4gdG8gYmUgZXhlY3V0ZWQgYnkgQUNQSUNB
IHZpYSBTTUkgaW50ZXJydXB0IGhhbmRsZXJzKT8gSSYjMzk7bSBub3Qgc3VyZSB3aHkgdGhhdCB3
b3VsZCBicmVhayB0aGUgUEMgc3BlYWtlci4gQ291bGQgaXQgYmUgdGhhdCBteSBPU0wgaW50ZXJy
dXB0IGhhbmRsaW5nIGlzIGJyb2tlbiBhbmQgQklPUyB3YXMgcmVseWluZyBvbiBpdCB0byByZS1l
bmFibGUgdGhlIGRldmljZXMgbmVlZGVkIHRvIHVzZSB0aGUgUEMgc3BlYWtlcj88L2Rpdj48ZGl2
Pjxicj48L2Rpdj48ZGl2Pk9yIGNvdWxkIEFQTUNfRU49MSBhbHNvICZxdW90O3R1cm4gb2ZmIHNv
bWUgZGV2aWNlcyAodGhhdCB0aGUgUEMgc3BlYWtlciByZXF1aXJlcykgdG8gc2F2ZSBwb3dlciBh
cyB0aGV5IHdvbiYjMzk7dCBiZSB1c2VkIGJ5IHRoaXMgT1MmcXVvdDs/IFNob3VsZCBJIGluc3Rl
YWQgYmUgbG9va2luZyBhdCB0aGUgQUNQSSB0YWJsZXMgZm9yIHRoaXMgbGFwdG9wIHRvIHNlZSBp
ZiBzb21ldGhpbmcgaXMgYmVpbmcgdHVybmVkIG9mZiB0byBzYXZlIHBvd2VyIGFuZCBmaWd1cmUg
b3V0IGhvdyB0byB0dXJuIHRoZW0gYmFjayBvbiB2aWEgQUNQSSBjYWxscz88YnI+PC9kaXY+PGRp
dj48YnI+PC9kaXY+PGRpdj5UaGUgc2FtZSBzZWN0aW9uICgyMi40LjUgU01JIy9TQ0kgR2VuZXJh
dGlvbikgaW4gdGhlIGRhdGFzaGVldCBhbHNvIHN0YXRlcyB0aGluZ3MgbGlrZSB0aGUgZm9sbG93
aW5nOjwvZGl2PjxkaXY+JnF1b3Q7VGhlIFNDSSBpcyBhIGxldmVsLW1vZGUgaW50ZXJydXB0IHRo
YXQgaXMgdHlwaWNhbGx5IGhhbmRsZWQgYnkgYW4gQUNQSS1hd2FyZSBvcGVyYXRpbmc8YnI+c3lz
dGVtLiBJbiBub24tQVBJQyBzeXN0ZW1zICh3aGljaCBpcyB0aGUgZGVmYXVsdCksIHRoZSBTQ0kg
SVJRIGlzIHJvdXRlZCB0byBvbmUgb2Y8YnI+dGhlIDgyNTkgaW50ZXJydXB0cyAoSVJRIDksIDEw
LCBvciAxMSkuIFRoZSA4MjU5IGludGVycnVwdCBjb250cm9sbGVyIG11c3QgYmU8YnI+cHJvZ3Jh
bW1lZCB0byBsZXZlbCBtb2RlIGZvciB0aGF0IGludGVycnVwdC4mcXVvdDs8L2Rpdj48YnI+PGRp
dj5UaGFua3MsPC9kaXY+PGRpdj5EZXZpbjxicj48L2Rpdj48L2Rpdj48YnI+PGRpdiBjbGFzcz0i
Z21haWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9hdHRyIj5PbiBUdWUsIFNl
cCAyOCwgMjAyMSBhdCAzOjA0IFBNIERldmluIFN0ZWZmbGVyICZsdDs8YSBocmVmPSJtYWlsdG86
ZGV2aW5zdGVmZmxlckBnbWFpbC5jb20iPmRldmluc3RlZmZsZXJAZ21haWwuY29tPC9hPiZndDsg
d3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1h
cmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQs
MjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij48ZGl2IGRpcj0ibHRyIj48ZGl2PkhlbGxvLDwvZGl2Pjxk
aXY+PGJyPjwvZGl2PkkgYW0gdXNpbmcgQUNQSUNBIHRvIHJlYWQgYmF0dGVyeSBpbmZvcm1hdGlv
biBpbiBRTlguIFRoYXQgcGFydCBpcyB3b3JraW5nIGdyZWF0IHNvIGZhci4gSG93ZXZlciwgbm93
IHNvbWUgY29kZSB0aGF0IGlzIGJlaW5nIHVzZWQgdG8gbWFrZSBiZWVwcyB2aWEgdGhlIFBDIHNw
ZWFrZXIgc3RvcHBlZCB3b3JraW5nLjxkaXY+PGJyPjwvZGl2PjxkaXY+U3RyYW5nZWx5LCB0aGlz
IGNvZGUgc3RvcHMgd29ya2luZyBvbiBhIGZldyBkZXZpY2VzIG9ubHkgYWZ0ZXIgQUNQSUNBIHJ1
bnMuIEl0IHdvcmtzIGZpbmUgaWYgSSBkb24mIzM5O3Qgc3RhcnQgQUNQSUNBLiBUaGUgY29kZSBp
cyB1c2luZyBJL08gcG9ydHMgMHg0MywgMHg0MiwgYW5kIDB4NjEgdG8gZ2VuZXJhdGUgYmVlcHMu
IFRoaXMgc2VlbXMgdG8gYmUgYW4gaW5kdXN0cnkgc3RhbmRhcmQgd2F5IHRvIG1ha2UgYmVlcHMg
b24geDg2IGJhc2VkIFBDcyB1c2luZyBhIFByb2dyYW1tYWJsZSBJbnRlcnZhbCBUaW1lciAoUElU
KS48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PldoYXQgY291bGQgbXkgQUNQSUNBIGJlIGRvaW5n
IChvciBmYWlsaW5nIHRvIGRvKSB0aGF0IGNvdWxkIGNhdXNlIHRoZSBiZWVwcyB0byBzdG9wIHdv
cmtpbmcgd2l0aCB0aGUgY29kZSBiZWxvdz8gSXMgdGhlIFBJVCBiZWluZyBkaXNhYmxlZCBzb21l
aG93PyBJIGd1ZXNzIEkmIzM5O2xsIG5lZWQgdG8gbGVhcm4gbW9yZSBhYm91dCB0aGUgUElUIGFu
ZCBob3cgdG8gY2hlY2sgaXRzIHN0YXR1cyB0byBzZWUgaWYgaXQmIzM5O3MgYmVpbmcgZGlzYWJs
ZWQgYWZ0ZXIgQUNQSUNBIHJ1bnMuPGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SGVyZSYj
Mzk7cyBleGFtcGxlIGNvZGUgZm9yIFFOWCB0byBnZW5lcmF0ZSBhIGJlZXAgdXNpbmcgdGhlIFBD
IHNwZWFrZXI6PC9kaXY+PGRpdj4vLyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLTxicj48L2Rpdj48ZGl2PiNpbmNsdWRlICZsdDtzeXMvbmV1dHJpbm8uaCZn
dDs8YnI+I2luY2x1ZGUgJmx0O2h3L2lub3V0LmgmZ3Q7PGJyPiNpbmNsdWRlICZsdDt1bmlzdGQu
aCZndDs8YnI+PGJyPmludCBtYWluKHZvaWQpIHs8YnI+wqDCoMKgIFRocmVhZEN0bCggX05UT19U
Q1RMX0lPLCAwICk7IC8vIGdldCBJL08gcGVybWlzc2lvbnM8YnI+PC9kaXY+PGRpdj48YnI+PC9k
aXY+PGRpdj7CoMKgwqAgLy8gc3RhcnQgYSBiZWVwPGJyPjwvZGl2PjxkaXY+wqAgwqAgaW50IGZy
ZXEgPSAxMDAwOzxicj7CoCDCoCBpbnQgc2NhbGUgPSAxMTkzMDQ2IC8gZnJlcTs8YnI+wqAgwqAg
b3V0OCgweDQzLCAweGI2KTs8YnI+wqAgwqAgb3V0OCgweDQyLCBzY2FsZSAmYW1wOyAweGZmKTs8
YnI+wqAgwqAgb3V0OCgweDQyLCBzY2FsZSAmZ3Q7Jmd0OyA4KTs8YnI+wqAgwqAgb3V0OCgweDYx
LCBpbjgoMHg2MSkgfCAzKTs8YnI+PC9kaXY+PGRpdj7CoMKgwqAgPGJyPjwvZGl2PjxkaXY+wqDC
oMKgIC8vIGxldCB0aGUgYmVlcCBwbGF5IGZvciBhIHNlY29uZDxicj48L2Rpdj48ZGl2PsKgwqDC
oCBkZWxheSgxMDAwKTs8YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj7CoMKgwqAgLy8gc3Rv
cCB0aGUgYmVlcDxicj48L2Rpdj48ZGl2PsKgIMKgIG91dDgoMHg2MSwgaW44KDB4NjEpICZhbXA7
IH4zKTs8YnI+PGJyPsKgwqDCoCByZXR1cm4gMDs8YnI+fTwvZGl2PjxkaXY+Ci8vIC0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tIDxicj48L2Rpdj48ZGl2Pjxi
cj48L2Rpdj48ZGl2PlRoYW5rcyw8L2Rpdj48ZGl2PkRldmluPGJyPjwvZGl2PjwvZGl2Pgo8L2Js
b2NrcXVvdGU+PC9kaXY+Cg==

--===============4049134394345310491==--

