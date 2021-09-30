Content-Type: multipart/mixed; boundary="===============0942323268242054908=="
MIME-Version: 1.0
From: Devin Steffler <devinsteffler at gmail.com>
Subject: [Devel] Re: Question about ACPICA, QNX and making beeps
Date: Thu, 30 Sep 2021 08:56:34 -0400
Message-ID: <CAAuRk_hhW+E0GhZY7TTKd8Q24u4j12thwW17G2gdxz1xCPYiyA@mail.gmail.com>
In-Reply-To: d21a9612-b189-b565-8c97-cbeb8c2bd0d3@assembler.cz
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0942323268242054908==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rudolf,

I have the ACPI utilities working in QNX as well (i.e. acpidump,
acpixtract, iasl, etc). The problem is I don't know what to look for in the
FADT.

So far I have only seen this happen on Lenovo based x86 PCs. For example,
the one that I have on hand is a Lenovo ThinkBook 14 Gen 2 laptop. If I
boot the ThinkBook into QNX, then I can play a beep over the PC speaker
just fine. However, after running ACPICA, then I can no longer play a beep
over the PC speaker anymore on this device.

How can I check for 8254 clock gating?

delay is a QNX call to sleep for the specified time in ms.

Thanks,
Devin

On Wed, Sep 29, 2021 at 3:58 PM Rudolf Marek <r.marek(a)assembler.cz> wrote:

> Hi Devin,
>
> Dne 28. 09. 21 v 21:04 Devin Steffler napsal(a):
>
> Hello,
>
> I am using ACPICA to read battery information in QNX. That part is working
> great so far. However, now some code that is being used to make beeps via
> the PC speaker stopped working.
>
> Strangely, this code stops working on a few devices only after ACPICA run=
s.
>
> You mean same device with same mainboard / BIOS version?
>
> Maybe SMI and/or ACPI bytecode turns on 8254 clock gating? You can
>
> try to disassemble the ACPI DSDT/SSDT bytecode and look for it.
>
> What you can also do, is to try out to send ACPI enable SMI command witho=
ut
>
> enabling ACPICA and see if it breaks. You can read the I/O port address
>
> and data enable command from FADT. To disassemble the ACPI tables
>
> use acpidump acpixtract and iasl utillites in linux.
>
> What could my ACPICA be doing (or failing to do) that could cause the bee=
ps
> to stop working with the code below? Is the PIT being disabled somehow? I
> guess I'll need to learn more about the PIT and how to check its status to
> see if it's being disabled after ACPICA runs.
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
> you can also try to see if your assembly for out8 is correct and maybe not
> re-ordered
>
> by the compiler or that your asm clobber list is correct (same for in8)
>
>
>     // let the beep play for a second
>     delay(1000);
>
> delay is an OS service right?
>
> Thanks,
>
> Rudolf
>

--===============0942323268242054908==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSAKUnVkb2xmLDwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+
SSBoYXZlIHRoZSBBQ1BJIHV0aWxpdGllcyB3b3JraW5nIGluIFFOWCBhcyB3ZWxsIChpLmUuIGFj
cGlkdW1wLCBhY3BpeHRyYWN0LCBpYXNsLCBldGMpLiBUaGUgcHJvYmxlbSBpcyBJIGRvbiYjMzk7
dCBrbm93IHdoYXQgdG8gbG9vayBmb3IgaW4gdGhlIEZBRFQuPC9kaXY+PGRpdj48YnI+PC9kaXY+
PGRpdj5TbyBmYXIgSSBoYXZlIG9ubHkgc2VlbiB0aGlzIGhhcHBlbiBvbiBMZW5vdm8gYmFzZWQg
eDg2IFBDcy4gRm9yIGV4YW1wbGUsIHRoZSBvbmUgdGhhdCBJIGhhdmUgb24gaGFuZCBpcyBhIExl
bm92byBUaGlua0Jvb2sgMTQgR2VuIDIgbGFwdG9wLiBJZiBJIGJvb3QgdGhlIFRoaW5rQm9vayBp
bnRvIFFOWCwgdGhlbiBJIGNhbiBwbGF5IGEgYmVlcCBvdmVyIHRoZSBQQyBzcGVha2VyIGp1c3Qg
ZmluZS4gSG93ZXZlciwgYWZ0ZXIgcnVubmluZyBBQ1BJQ0EsIHRoZW4gSSBjYW4gbm8gbG9uZ2Vy
IHBsYXkgYSBiZWVwIG92ZXIgdGhlIFBDIHNwZWFrZXIgYW55bW9yZSBvbiB0aGlzIGRldmljZS48
L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkhvdyBjYW4gSSBjaGVjayBmb3IgODI1NCBjbG9jayBn
YXRpbmc/PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5kZWxheSBpcyBhIFFOWCBjYWxsIHRvIHNs
ZWVwIGZvciB0aGUgc3BlY2lmaWVkIHRpbWUgaW4gbXMuPC9kaXY+PGRpdj48L2Rpdj48ZGl2Pjxi
cj48L2Rpdj48ZGl2PlRoYW5rcyw8L2Rpdj48ZGl2PkRldmluPGJyPjwvZGl2PjwvZGl2Pjxicj48
ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIi
Pk9uIFdlZCwgU2VwIDI5LCAyMDIxIGF0IDM6NTggUE0gUnVkb2xmIE1hcmVrICZsdDs8YSBocmVm
PSJtYWlsdG86ci5tYXJla0Bhc3NlbWJsZXIuY3oiPnIubWFyZWtAYXNzZW1ibGVyLmN6PC9hPiZn
dDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9
Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwy
MDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij4KICAKICAgIAogIAogIDxkaXY+CiAgICA8Zm9udCBm
YWNlPSJIZWx2ZXRpY2EsIEFyaWFsLCBzYW5zLXNlcmlmIj5IaSBEZXZpbiw8YnI+CiAgICA8L2Zv
bnQ+CiAgICA8ZGl2Pjxmb250IGZhY2U9IkhlbHZldGljYSwgQXJpYWwsCiAgICAgICAgc2Fucy1z
ZXJpZiI+PGJyPgogICAgICA8L2ZvbnQ+PC9kaXY+CiAgICA8ZGl2Pjxmb250IGZhY2U9IkhlbHZl
dGljYSwgQXJpYWwsCiAgICAgICAgc2Fucy1zZXJpZiI+RG5lIDI4LiAwOS4gMjEgdiAyMTowNCBE
ZXZpbiBTdGVmZmxlciBuYXBzYWwoYSk6PGJyPgogICAgICA8L2ZvbnQ+PC9kaXY+CiAgICA8Ymxv
Y2txdW90ZSB0eXBlPSJjaXRlIj4KICAgICAgPHByZT48Zm9udCBmYWNlPSJIZWx2ZXRpY2EsIEFy
aWFsLCBzYW5zLXNlcmlmIj5IZWxsbywKCkkgYW0gdXNpbmcgQUNQSUNBIHRvIHJlYWQgYmF0dGVy
eSBpbmZvcm1hdGlvbiBpbiBRTlguIFRoYXQgcGFydCBpcyB3b3JraW5nCmdyZWF0IHNvIGZhci4g
SG93ZXZlciwgbm93IHNvbWUgY29kZSB0aGF0IGlzIGJlaW5nIHVzZWQgdG8gbWFrZSBiZWVwcyB2
aWEKdGhlIFBDIHNwZWFrZXIgc3RvcHBlZCB3b3JraW5nLgoKU3RyYW5nZWx5LCB0aGlzIGNvZGUg
c3RvcHMgd29ya2luZyBvbiBhIGZldyBkZXZpY2VzIG9ubHkgYWZ0ZXIgQUNQSUNBIHJ1bnMuPC9m
b250PjwvcHJlPgogICAgPC9ibG9ja3F1b3RlPgogICAgPHA+WW91IG1lYW4gc2FtZSBkZXZpY2Ug
d2l0aCBzYW1lIG1haW5ib2FyZCAvIEJJT1MgdmVyc2lvbj88YnI+CiAgICA8L3A+CiAgICA8cD5N
YXliZSBTTUkgYW5kL29yIEFDUEkgYnl0ZWNvZGUgdHVybnMgb24gODI1NCBjbG9jayBnYXRpbmc/
IFlvdQogICAgICBjYW4gPGJyPgogICAgPC9wPgogICAgPHA+dHJ5IHRvIGRpc2Fzc2VtYmxlIHRo
ZSBBQ1BJIERTRFQvU1NEVCBieXRlY29kZSBhbmQgbG9vayBmb3IgaXQuPC9wPgogICAgPHA+V2hh
dCB5b3UgY2FuIGFsc28gZG8sIGlzIHRvIHRyeSBvdXQgdG8gc2VuZCBBQ1BJIGVuYWJsZSBTTUkK
ICAgICAgY29tbWFuZCB3aXRob3V0PC9wPgogICAgPHA+ZW5hYmxpbmcgQUNQSUNBIGFuZCBzZWUg
aWYgaXQgYnJlYWtzLiBZb3UgY2FuIHJlYWQgdGhlIEkvTyBwb3J0CiAgICAgIGFkZHJlc3M8L3A+
CiAgICA8cD5hbmQgZGF0YSBlbmFibGUgY29tbWFuZCBmcm9tIEZBRFQuIFRvIGRpc2Fzc2VtYmxl
IHRoZSBBQ1BJIHRhYmxlczwvcD4KICAgIDxwPnVzZSBhY3BpZHVtcCBhY3BpeHRyYWN0IGFuZCBp
YXNsIHV0aWxsaXRlcyBpbiBsaW51eC48YnI+CiAgICA8L3A+CiAgICA8YmxvY2txdW90ZSB0eXBl
PSJjaXRlIj4KICAgICAgPHByZT48Zm9udCBmYWNlPSJIZWx2ZXRpY2EsIEFyaWFsLCBzYW5zLXNl
cmlmIj5XaGF0IGNvdWxkIG15IEFDUElDQSBiZSBkb2luZyAob3IgZmFpbGluZyB0byBkbykgdGhh
dCBjb3VsZCBjYXVzZSB0aGUgYmVlcHMKdG8gc3RvcCB3b3JraW5nIHdpdGggdGhlIGNvZGUgYmVs
b3c/IElzIHRoZSBQSVQgYmVpbmcgZGlzYWJsZWQgc29tZWhvdz8gSQpndWVzcyBJJiMzOTtsbCBu
ZWVkIHRvIGxlYXJuIG1vcmUgYWJvdXQgdGhlIFBJVCBhbmQgaG93IHRvIGNoZWNrIGl0cyBzdGF0
dXMgdG8Kc2VlIGlmIGl0JiMzOTtzIGJlaW5nIGRpc2FibGVkIGFmdGVyIEFDUElDQSBydW5zLgoK
SGVyZSYjMzk7cyBleGFtcGxlIGNvZGUgZm9yIFFOWCB0byBnZW5lcmF0ZSBhIGJlZXAgdXNpbmcg
dGhlIFBDIHNwZWFrZXI6Ci8vIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tCiNpbmNsdWRlICZsdDtzeXMvbmV1dHJpbm8uaCZndDsKI2luY2x1ZGUgJmx0O2h3
L2lub3V0LmgmZ3Q7CiNpbmNsdWRlICZsdDt1bmlzdGQuaCZndDsKCmludCBtYWluKHZvaWQpIHsK
ICAgIFRocmVhZEN0bCggX05UT19UQ1RMX0lPLCAwICk7IC8vIGdldCBJL08gcGVybWlzc2lvbnMK
CiAgICAvLyBzdGFydCBhIGJlZXAKICAgIGludCBmcmVxID0gMTAwMDsKICAgIGludCBzY2FsZSA9
IDExOTMwNDYgLyBmcmVxOwogICAgb3V0OCgweDQzLCAweGI2KTsKICAgIG91dDgoMHg0Miwgc2Nh
bGUgJmFtcDsgMHhmZik7CiAgICBvdXQ4KDB4NDIsIHNjYWxlICZndDsmZ3Q7IDgpOwogICAgb3V0
OCgweDYxLCBpbjgoMHg2MSkgfCAzKTs8L2ZvbnQ+PC9wcmU+CiAgICA8L2Jsb2NrcXVvdGU+CiAg
ICA8cD55b3UgY2FuIGFsc28gdHJ5IHRvIHNlZSBpZiB5b3VyIGFzc2VtYmx5IGZvciBvdXQ4IGlz
IGNvcnJlY3QgYW5kCiAgICAgIG1heWJlIG5vdCByZS1vcmRlcmVkPC9wPgogICAgPHA+YnkgdGhl
IGNvbXBpbGVyIG9yIHRoYXQgeW91ciBhc20gY2xvYmJlciBsaXN0IGlzIGNvcnJlY3QgKHNhbWUK
ICAgICAgZm9yIGluOCk8YnI+CiAgICA8L3A+CiAgICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIj4K
ICAgICAgPHByZT48Zm9udCBmYWNlPSJIZWx2ZXRpY2EsIEFyaWFsLCBzYW5zLXNlcmlmIj4KICAg
IC8vIGxldCB0aGUgYmVlcCBwbGF5IGZvciBhIHNlY29uZAogICAgZGVsYXkoMTAwMCk7PC9mb250
PjwvcHJlPgogICAgPC9ibG9ja3F1b3RlPgogICAgPHA+PGZvbnQgZmFjZT0iSGVsdmV0aWNhLCBB
cmlhbCwgc2Fucy1zZXJpZiI+ZGVsYXkgaXMgYW4gT1Mgc2VydmljZQogICAgICAgIHJpZ2h0Pzwv
Zm9udD48L3A+CiAgICA8cD5UaGFua3MsPC9wPgogICAgPHA+UnVkb2xmPGJyPgogICAgPC9wPgog
IDwvZGl2PgoKPC9ibG9ja3F1b3RlPjwvZGl2Pgo=

--===============0942323268242054908==--

