Content-Type: multipart/mixed; boundary="===============2687084783480941093=="
MIME-Version: 1.0
From: Devin Steffler <devinsteffler at gmail.com>
Subject: [Devel] Question about ACPICA, QNX and making beeps
Date: Tue, 28 Sep 2021 15:04:29 -0400
Message-ID: <CAAuRk_jLAfxp7ryhuWPORetZaqMPoNmsHYP6Y=BtkCucAyp45w@mail.gmail.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2687084783480941093==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

I am using ACPICA to read battery information in QNX. That part is working
great so far. However, now some code that is being used to make beeps via
the PC speaker stopped working.

Strangely, this code stops working on a few devices only after ACPICA runs.
It works fine if I don't start ACPICA. The code is using I/O ports 0x43,
0x42, and 0x61 to generate beeps. This seems to be an industry standard way
to make beeps on x86 based PCs using a Programmable Interval Timer (PIT).

What could my ACPICA be doing (or failing to do) that could cause the beeps
to stop working with the code below? Is the PIT being disabled somehow? I
guess I'll need to learn more about the PIT and how to check its status to
see if it's being disabled after ACPICA runs.

Here's example code for QNX to generate a beep using the PC speaker:
// -----------------------------------------------
#include <sys/neutrino.h>
#include <hw/inout.h>
#include <unistd.h>

int main(void) {
    ThreadCtl( _NTO_TCTL_IO, 0 ); // get I/O permissions

    // start a beep
    int freq =3D 1000;
    int scale =3D 1193046 / freq;
    out8(0x43, 0xb6);
    out8(0x42, scale & 0xff);
    out8(0x42, scale >> 8);
    out8(0x61, in8(0x61) | 3);

    // let the beep play for a second
    delay(1000);

    // stop the beep
    out8(0x61, in8(0x61) & ~3);

    return 0;
}
// -----------------------------------------------

Thanks,
Devin

--===============2687084783480941093==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdj5IZWxsbyw8L2Rpdj48ZGl2Pjxicj48L2Rpdj5JIGFtIHVzaW5n
IEFDUElDQSB0byByZWFkIGJhdHRlcnkgaW5mb3JtYXRpb24gaW4gUU5YLiBUaGF0IHBhcnQgaXMg
d29ya2luZyBncmVhdCBzbyBmYXIuIEhvd2V2ZXIsIG5vdyBzb21lIGNvZGUgdGhhdCBpcyBiZWlu
ZyB1c2VkIHRvIG1ha2UgYmVlcHMgdmlhIHRoZSBQQyBzcGVha2VyIHN0b3BwZWQgd29ya2luZy48
ZGl2Pjxicj48L2Rpdj48ZGl2PlN0cmFuZ2VseSwgdGhpcyBjb2RlIHN0b3BzIHdvcmtpbmcgb24g
YSBmZXcgZGV2aWNlcyBvbmx5IGFmdGVyIEFDUElDQSBydW5zLiBJdCB3b3JrcyBmaW5lIGlmIEkg
ZG9uJiMzOTt0IHN0YXJ0IEFDUElDQS4gVGhlIGNvZGUgaXMgdXNpbmcgSS9PIHBvcnRzIDB4NDMs
IDB4NDIsIGFuZCAweDYxIHRvIGdlbmVyYXRlIGJlZXBzLiBUaGlzIHNlZW1zIHRvIGJlIGFuIGlu
ZHVzdHJ5IHN0YW5kYXJkIHdheSB0byBtYWtlIGJlZXBzIG9uIHg4NiBiYXNlZCBQQ3MgdXNpbmcg
YSBQcm9ncmFtbWFibGUgSW50ZXJ2YWwgVGltZXIgKFBJVCkuPC9kaXY+PGRpdj48YnI+PC9kaXY+
PGRpdj5XaGF0IGNvdWxkIG15IEFDUElDQSBiZSBkb2luZyAob3IgZmFpbGluZyB0byBkbykgdGhh
dCBjb3VsZCBjYXVzZSB0aGUgYmVlcHMgdG8gc3RvcCB3b3JraW5nIHdpdGggdGhlIGNvZGUgYmVs
b3c/IElzIHRoZSBQSVQgYmVpbmcgZGlzYWJsZWQgc29tZWhvdz8gSSBndWVzcyBJJiMzOTtsbCBu
ZWVkIHRvIGxlYXJuIG1vcmUgYWJvdXQgdGhlIFBJVCBhbmQgaG93IHRvIGNoZWNrIGl0cyBzdGF0
dXMgdG8gc2VlIGlmIGl0JiMzOTtzIGJlaW5nIGRpc2FibGVkIGFmdGVyIEFDUElDQSBydW5zLjxi
cj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkhlcmUmIzM5O3MgZXhhbXBsZSBjb2RlIGZvciBR
TlggdG8gZ2VuZXJhdGUgYSBiZWVwIHVzaW5nIHRoZSBQQyBzcGVha2VyOjwvZGl2PjxkaXY+Ly8g
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08YnI+PC9kaXY+
PGRpdj4jaW5jbHVkZSAmbHQ7c3lzL25ldXRyaW5vLmgmZ3Q7PGJyPiNpbmNsdWRlICZsdDtody9p
bm91dC5oJmd0Ozxicj4jaW5jbHVkZSAmbHQ7dW5pc3RkLmgmZ3Q7PGJyPjxicj5pbnQgbWFpbih2
b2lkKSB7PGJyPsKgwqDCoCBUaHJlYWRDdGwoIF9OVE9fVENUTF9JTywgMCApOyAvLyBnZXQgSS9P
IHBlcm1pc3Npb25zPGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+wqDCoMKgIC8vIHN0YXJ0
IGEgYmVlcDxicj48L2Rpdj48ZGl2PsKgIMKgIGludCBmcmVxID0gMTAwMDs8YnI+wqAgwqAgaW50
IHNjYWxlID0gMTE5MzA0NiAvIGZyZXE7PGJyPsKgIMKgIG91dDgoMHg0MywgMHhiNik7PGJyPsKg
IMKgIG91dDgoMHg0Miwgc2NhbGUgJmFtcDsgMHhmZik7PGJyPsKgIMKgIG91dDgoMHg0Miwgc2Nh
bGUgJmd0OyZndDsgOCk7PGJyPsKgIMKgIG91dDgoMHg2MSwgaW44KDB4NjEpIHwgMyk7PGJyPjwv
ZGl2PjxkaXY+wqDCoMKgIDxicj48L2Rpdj48ZGl2PsKgwqDCoCAvLyBsZXQgdGhlIGJlZXAgcGxh
eSBmb3IgYSBzZWNvbmQ8YnI+PC9kaXY+PGRpdj7CoMKgwqAgZGVsYXkoMTAwMCk7PGJyPjwvZGl2
PjxkaXY+PGJyPjwvZGl2PjxkaXY+wqDCoMKgIC8vIHN0b3AgdGhlIGJlZXA8YnI+PC9kaXY+PGRp
dj7CoCDCoCBvdXQ4KDB4NjEsIGluOCgweDYxKSAmYW1wOyB+Myk7PGJyPjxicj7CoMKgwqAgcmV0
dXJuIDA7PGJyPn08L2Rpdj48ZGl2PgovLyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLSA8YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5UaGFua3MsPC9k
aXY+PGRpdj5EZXZpbjxicj48L2Rpdj48L2Rpdj4K

--===============2687084783480941093==--

