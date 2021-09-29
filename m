Content-Type: multipart/mixed; boundary="===============1307482434076496296=="
MIME-Version: 1.0
From: Rudolf Marek <r.marek at assembler.cz>
Subject: [Devel] Re: Question about ACPICA, QNX and making beeps
Date: Wed, 29 Sep 2021 21:58:42 +0200
Message-ID: <d21a9612-b189-b565-8c97-cbeb8c2bd0d3@assembler.cz>
In-Reply-To: CAAuRk_jLAfxp7ryhuWPORetZaqMPoNmsHYP6Y=BtkCucAyp45w@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1307482434076496296==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Devin,

Dne 28. 09. 21 v 21:04 Devin Steffler napsal(a):
> Hello, I am using ACPICA to read battery information in QNX. That part is =

> working great so far. However, now some code that is being used to make b=
eeps =

> via the PC speaker stopped working. Strangely, this code stops working on=
 a =

> few devices only after ACPICA runs.

You mean same device with same mainboard / BIOS version?

Maybe SMI and/or ACPI bytecode turns on 8254 clock gating? You can

try to disassemble the ACPI DSDT/SSDT bytecode and look for it.

What you can also do, is to try out to send ACPI enable SMI command without

enabling ACPICA and see if it breaks. You can read the I/O port address

and data enable command from FADT. To disassemble the ACPI tables

use acpidump acpixtract and iasl utillites in linux.

> What could my ACPICA be doing (or failing to do) that could cause the bee=
ps to =

> stop working with the code below? Is the PIT being disabled somehow? I gu=
ess =

> I'll need to learn more about the PIT and how to check its status to see =
if =

> it's being disabled after ACPICA runs. Here's example code for QNX to gen=
erate =

> a beep using the PC speaker: // =

> ----------------------------------------------- #include <sys/neutrino.h> =

> #include <hw/inout.h> #include <unistd.h> int main(void) { ThreadCtl( =

> _NTO_TCTL_IO, 0 ); // get I/O permissions // start a beep int freq =3D 10=
00; int =

> scale =3D 1193046 / freq; out8(0x43, 0xb6); out8(0x42, scale & 0xff); out=
8(0x42, =

> scale >> 8); out8(0x61, in8(0x61) | 3);

you can also try to see if your assembly for out8 is correct and maybe not =

re-ordered

by the compiler or that your asm clobber list is correct (same for in8)

> // let the beep play for a second delay(1000);

delay is an OS service right?

Thanks,

Rudolf


--===============1307482434076496296==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGh0bWw+CiAgPGhlYWQ+CiAgICA8bWV0YSBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiIGNvbnRl
bnQ9InRleHQvaHRtbDsgY2hhcnNldD1VVEYtOCI+CiAgPC9oZWFkPgogIDxib2R5PgogICAgPGZv
bnQgZmFjZT0iSGVsdmV0aWNhLCBBcmlhbCwgc2Fucy1zZXJpZiI+SGkgRGV2aW4sPGJyPgogICAg
PC9mb250PgogICAgPGRpdiBjbGFzcz0ibW96LWNpdGUtcHJlZml4Ij48Zm9udCBmYWNlPSJIZWx2
ZXRpY2EsIEFyaWFsLAogICAgICAgIHNhbnMtc2VyaWYiPjxicj4KICAgICAgPC9mb250PjwvZGl2
PgogICAgPGRpdiBjbGFzcz0ibW96LWNpdGUtcHJlZml4Ij48Zm9udCBmYWNlPSJIZWx2ZXRpY2Es
IEFyaWFsLAogICAgICAgIHNhbnMtc2VyaWYiPkRuZSAyOC4gMDkuIDIxIHYgMjE6MDQgRGV2aW4g
U3RlZmZsZXIgbmFwc2FsKGEpOjxicj4KICAgICAgPC9mb250PjwvZGl2PgogICAgPGJsb2NrcXVv
dGUgdHlwZT0iY2l0ZSIKY2l0ZT0ibWlkOkNBQXVSa19qTEFmeHA3cnlodVdQT1JldFphcU1Qb05t
c0hZUDZZPUJ0a0N1Y0F5cDQ1d0BtYWlsLmdtYWlsLmNvbSI+CiAgICAgIDxwcmUgY2xhc3M9Im1v
ei1xdW90ZS1wcmUiIHdyYXA9IiI+PGZvbnQgZmFjZT0iSGVsdmV0aWNhLCBBcmlhbCwgc2Fucy1z
ZXJpZiI+SGVsbG8sCgpJIGFtIHVzaW5nIEFDUElDQSB0byByZWFkIGJhdHRlcnkgaW5mb3JtYXRp
b24gaW4gUU5YLiBUaGF0IHBhcnQgaXMgd29ya2luZwpncmVhdCBzbyBmYXIuIEhvd2V2ZXIsIG5v
dyBzb21lIGNvZGUgdGhhdCBpcyBiZWluZyB1c2VkIHRvIG1ha2UgYmVlcHMgdmlhCnRoZSBQQyBz
cGVha2VyIHN0b3BwZWQgd29ya2luZy4KClN0cmFuZ2VseSwgdGhpcyBjb2RlIHN0b3BzIHdvcmtp
bmcgb24gYSBmZXcgZGV2aWNlcyBvbmx5IGFmdGVyIEFDUElDQSBydW5zLjwvZm9udD48L3ByZT4K
ICAgIDwvYmxvY2txdW90ZT4KICAgIDxwPllvdSBtZWFuIHNhbWUgZGV2aWNlIHdpdGggc2FtZSBt
YWluYm9hcmQgLyBCSU9TIHZlcnNpb24/PGJyPgogICAgPC9wPgogICAgPHA+TWF5YmUgU01JIGFu
ZC9vciBBQ1BJIGJ5dGVjb2RlIHR1cm5zIG9uIDgyNTQgY2xvY2sgZ2F0aW5nPyBZb3UKICAgICAg
Y2FuIDxicj4KICAgIDwvcD4KICAgIDxwPnRyeSB0byBkaXNhc3NlbWJsZSB0aGUgQUNQSSBEU0RU
L1NTRFQgYnl0ZWNvZGUgYW5kIGxvb2sgZm9yIGl0LjwvcD4KICAgIDxwPldoYXQgeW91IGNhbiBh
bHNvIGRvLCBpcyB0byB0cnkgb3V0IHRvIHNlbmQgQUNQSSBlbmFibGUgU01JCiAgICAgIGNvbW1h
bmQgd2l0aG91dDwvcD4KICAgIDxwPmVuYWJsaW5nIEFDUElDQSBhbmQgc2VlIGlmIGl0IGJyZWFr
cy4gWW91IGNhbiByZWFkIHRoZSBJL08gcG9ydAogICAgICBhZGRyZXNzPC9wPgogICAgPHA+YW5k
IGRhdGEgZW5hYmxlIGNvbW1hbmQgZnJvbSBGQURULiBUbyBkaXNhc3NlbWJsZSB0aGUgQUNQSSB0
YWJsZXM8L3A+CiAgICA8cD51c2UgYWNwaWR1bXAgYWNwaXh0cmFjdCBhbmQgaWFzbCB1dGlsbGl0
ZXMgaW4gbGludXguPGJyPgogICAgPC9wPgogICAgPGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSIKY2l0
ZT0ibWlkOkNBQXVSa19qTEFmeHA3cnlodVdQT1JldFphcU1Qb05tc0hZUDZZPUJ0a0N1Y0F5cDQ1
d0BtYWlsLmdtYWlsLmNvbSI+CiAgICAgIDxwcmUgY2xhc3M9Im1vei1xdW90ZS1wcmUiIHdyYXA9
IiI+PGZvbnQgZmFjZT0iSGVsdmV0aWNhLCBBcmlhbCwgc2Fucy1zZXJpZiI+V2hhdCBjb3VsZCBt
eSBBQ1BJQ0EgYmUgZG9pbmcgKG9yIGZhaWxpbmcgdG8gZG8pIHRoYXQgY291bGQgY2F1c2UgdGhl
IGJlZXBzCnRvIHN0b3Agd29ya2luZyB3aXRoIHRoZSBjb2RlIGJlbG93PyBJcyB0aGUgUElUIGJl
aW5nIGRpc2FibGVkIHNvbWVob3c/IEkKZ3Vlc3MgSSdsbCBuZWVkIHRvIGxlYXJuIG1vcmUgYWJv
dXQgdGhlIFBJVCBhbmQgaG93IHRvIGNoZWNrIGl0cyBzdGF0dXMgdG8Kc2VlIGlmIGl0J3MgYmVp
bmcgZGlzYWJsZWQgYWZ0ZXIgQUNQSUNBIHJ1bnMuCgpIZXJlJ3MgZXhhbXBsZSBjb2RlIGZvciBR
TlggdG8gZ2VuZXJhdGUgYSBiZWVwIHVzaW5nIHRoZSBQQyBzcGVha2VyOgovLyAtLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQojaW5jbHVkZSAmbHQ7c3lzL25l
dXRyaW5vLmgmZ3Q7CiNpbmNsdWRlICZsdDtody9pbm91dC5oJmd0OwojaW5jbHVkZSAmbHQ7dW5p
c3RkLmgmZ3Q7CgppbnQgbWFpbih2b2lkKSB7CiAgICBUaHJlYWRDdGwoIF9OVE9fVENUTF9JTywg
MCApOyAvLyBnZXQgSS9PIHBlcm1pc3Npb25zCgogICAgLy8gc3RhcnQgYSBiZWVwCiAgICBpbnQg
ZnJlcSA9IDEwMDA7CiAgICBpbnQgc2NhbGUgPSAxMTkzMDQ2IC8gZnJlcTsKICAgIG91dDgoMHg0
MywgMHhiNik7CiAgICBvdXQ4KDB4NDIsIHNjYWxlICZhbXA7IDB4ZmYpOwogICAgb3V0OCgweDQy
LCBzY2FsZSAmZ3Q7Jmd0OyA4KTsKICAgIG91dDgoMHg2MSwgaW44KDB4NjEpIHwgMyk7PC9mb250
PjwvcHJlPgogICAgPC9ibG9ja3F1b3RlPgogICAgPHA+eW91IGNhbiBhbHNvIHRyeSB0byBzZWUg
aWYgeW91ciBhc3NlbWJseSBmb3Igb3V0OCBpcyBjb3JyZWN0IGFuZAogICAgICBtYXliZSBub3Qg
cmUtb3JkZXJlZDwvcD4KICAgIDxwPmJ5IHRoZSBjb21waWxlciBvciB0aGF0IHlvdXIgYXNtIGNs
b2JiZXIgbGlzdCBpcyBjb3JyZWN0IChzYW1lCiAgICAgIGZvciBpbjgpPGJyPgogICAgPC9wPgog
ICAgPGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSIKY2l0ZT0ibWlkOkNBQXVSa19qTEFmeHA3cnlodVdQ
T1JldFphcU1Qb05tc0hZUDZZPUJ0a0N1Y0F5cDQ1d0BtYWlsLmdtYWlsLmNvbSI+CiAgICAgIDxw
cmUgY2xhc3M9Im1vei1xdW90ZS1wcmUiIHdyYXA9IiI+PGZvbnQgZmFjZT0iSGVsdmV0aWNhLCBB
cmlhbCwgc2Fucy1zZXJpZiI+CiAgICAvLyBsZXQgdGhlIGJlZXAgcGxheSBmb3IgYSBzZWNvbmQK
ICAgIGRlbGF5KDEwMDApOzwvZm9udD48L3ByZT4KICAgIDwvYmxvY2txdW90ZT4KICAgIDxwPjxm
b250IGZhY2U9IkhlbHZldGljYSwgQXJpYWwsIHNhbnMtc2VyaWYiPmRlbGF5IGlzIGFuIE9TIHNl
cnZpY2UKICAgICAgICByaWdodD88L2ZvbnQ+PC9wPgogICAgPHA+VGhhbmtzLDwvcD4KICAgIDxw
PlJ1ZG9sZjxicj4KICAgIDwvcD4KICA8L2JvZHk+CjwvaHRtbD4K

--===============1307482434076496296==--

