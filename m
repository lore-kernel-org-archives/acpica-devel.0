Content-Type: multipart/mixed; boundary="===============2252329150434740468=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] Re: Question about ACPICA, QNX and making beeps
Date: Tue, 28 Sep 2021 20:48:26 +0000
Message-ID: <BYAPR11MB32568D74570708E7DCADBD2587A89@BYAPR11MB3256.namprd11.prod.outlook.com>
In-Reply-To: CAAuRk_jLAfxp7ryhuWPORetZaqMPoNmsHYP6Y=BtkCucAyp45w@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2252329150434740468==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Sorry, I have no idea why this would stop working.
Bob


From: Devin Steffler <devinsteffler(a)gmail.com>
Sent: Tuesday, September 28, 2021 12:04 PM
To: devel(a)acpica.org
Subject: [Devel] Question about ACPICA, QNX and making beeps

Hello,

I am using ACPICA to read battery information in QNX. That part is working =
great so far. However, now some code that is being used to make beeps via t=
he PC speaker stopped working.

Strangely, this code stops working on a few devices only after ACPICA runs.=
 It works fine if I don't start ACPICA. The code is using I/O ports 0x43, 0=
x42, and 0x61 to generate beeps. This seems to be an industry standard way =
to make beeps on x86 based PCs using a Programmable Interval Timer (PIT).

What could my ACPICA be doing (or failing to do) that could cause the beeps=
 to stop working with the code below? Is the PIT being disabled somehow? I =
guess I'll need to learn more about the PIT and how to check its status to =
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

--===============2252329150434740468==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGh0bWwgeG1sbnM6dj0idXJuOnNjaGVtYXMtbWljcm9zb2Z0LWNvbTp2bWwiIHhtbG5zOm89InVy
bjpzY2hlbWFzLW1pY3Jvc29mdC1jb206b2ZmaWNlOm9mZmljZSIgeG1sbnM6dz0idXJuOnNjaGVt
YXMtbWljcm9zb2Z0LWNvbTpvZmZpY2U6d29yZCIgeG1sbnM6bT0iaHR0cDovL3NjaGVtYXMubWlj
cm9zb2Z0LmNvbS9vZmZpY2UvMjAwNC8xMi9vbW1sIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcv
VFIvUkVDLWh0bWw0MCI+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIg
Y29udGVudD0idGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjxtZXRhIG5hbWU9IkdlbmVyYXRv
ciIgY29udGVudD0iTWljcm9zb2Z0IFdvcmQgMTUgKGZpbHRlcmVkIG1lZGl1bSkiPg0KPHN0eWxl
PjwhLS0NCi8qIEZvbnQgRGVmaW5pdGlvbnMgKi8NCkBmb250LWZhY2UNCgl7Zm9udC1mYW1pbHk6
IkNhbWJyaWEgTWF0aCI7DQoJcGFub3NlLTE6MiA0IDUgMyA1IDQgNiAzIDIgNDt9DQpAZm9udC1m
YWNlDQoJe2ZvbnQtZmFtaWx5OkNhbGlicmk7DQoJcGFub3NlLTE6MiAxNSA1IDIgMiAyIDQgMyAy
IDQ7fQ0KLyogU3R5bGUgRGVmaW5pdGlvbnMgKi8NCnAuTXNvTm9ybWFsLCBsaS5Nc29Ob3JtYWws
IGRpdi5Nc29Ob3JtYWwNCgl7bWFyZ2luOjBpbjsNCglmb250LXNpemU6MTEuMHB0Ow0KCWZvbnQt
ZmFtaWx5OiJDYWxpYnJpIixzYW5zLXNlcmlmO30NCnNwYW4uRW1haWxTdHlsZTE4DQoJe21zby1z
dHlsZS10eXBlOnBlcnNvbmFsLXJlcGx5Ow0KCWZvbnQtZmFtaWx5OiJDYWxpYnJpIixzYW5zLXNl
cmlmOw0KCWNvbG9yOndpbmRvd3RleHQ7fQ0KLk1zb0NocERlZmF1bHQNCgl7bXNvLXN0eWxlLXR5
cGU6ZXhwb3J0LW9ubHk7DQoJZm9udC1mYW1pbHk6IkNhbGlicmkiLHNhbnMtc2VyaWY7fQ0KQHBh
Z2UgV29yZFNlY3Rpb24xDQoJe3NpemU6OC41aW4gMTEuMGluOw0KCW1hcmdpbjoxLjBpbiAxLjBp
biAxLjBpbiAxLjBpbjt9DQpkaXYuV29yZFNlY3Rpb24xDQoJe3BhZ2U6V29yZFNlY3Rpb24xO30N
Ci0tPjwvc3R5bGU+PCEtLVtpZiBndGUgbXNvIDldPjx4bWw+DQo8bzpzaGFwZWRlZmF1bHRzIHY6
ZXh0PSJlZGl0IiBzcGlkbWF4PSIxMDI2IiAvPg0KPC94bWw+PCFbZW5kaWZdLS0+PCEtLVtpZiBn
dGUgbXNvIDldPjx4bWw+DQo8bzpzaGFwZWxheW91dCB2OmV4dD0iZWRpdCI+DQo8bzppZG1hcCB2
OmV4dD0iZWRpdCIgZGF0YT0iMSIgLz4NCjwvbzpzaGFwZWxheW91dD48L3htbD48IVtlbmRpZl0t
LT4NCjwvaGVhZD4NCjxib2R5IGxhbmc9IkVOLVVTIiBsaW5rPSIjMDU2M0MxIiB2bGluaz0iIzk1
NEY3MiIgc3R5bGU9IndvcmQtd3JhcDpicmVhay13b3JkIj4NCjxkaXYgY2xhc3M9IldvcmRTZWN0
aW9uMSI+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5Tb3JyeSwgSSBoYXZlIG5vIGlkZWEgd2h5IHRo
aXMgd291bGQgc3RvcCB3b3JraW5nLjxvOnA+PC9vOnA+PC9wPg0KPHAgY2xhc3M9Ik1zb05vcm1h
bCI+Qm9iPG86cD48L286cD48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48bzpwPiZuYnNwOzwv
bzpwPjwvcD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxvOnA+Jm5ic3A7PC9vOnA+PC9wPg0KPGRp
diBzdHlsZT0iYm9yZGVyOm5vbmU7Ym9yZGVyLXRvcDpzb2xpZCAjRTFFMUUxIDEuMHB0O3BhZGRp
bmc6My4wcHQgMGluIDBpbiAwaW4iPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PGI+RnJvbTo8L2I+
IERldmluIFN0ZWZmbGVyICZsdDtkZXZpbnN0ZWZmbGVyQGdtYWlsLmNvbSZndDsgPGJyPg0KPGI+
U2VudDo8L2I+IFR1ZXNkYXksIFNlcHRlbWJlciAyOCwgMjAyMSAxMjowNCBQTTxicj4NCjxiPlRv
OjwvYj4gZGV2ZWxAYWNwaWNhLm9yZzxicj4NCjxiPlN1YmplY3Q6PC9iPiBbRGV2ZWxdIFF1ZXN0
aW9uIGFib3V0IEFDUElDQSwgUU5YIGFuZCBtYWtpbmcgYmVlcHM8bzpwPjwvbzpwPjwvcD4NCjwv
ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PG86cD4mbmJzcDs8L286cD48L3A+DQo8ZGl2Pg0K
PGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkhlbGxvLDxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+
DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PG86cD4mbmJzcDs8L286cD48L3A+DQo8L2Rp
dj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkkgYW0gdXNpbmcgQUNQSUNBIHRvIHJlYWQgYmF0dGVy
eSBpbmZvcm1hdGlvbiBpbiBRTlguIFRoYXQgcGFydCBpcyB3b3JraW5nIGdyZWF0IHNvIGZhci4g
SG93ZXZlciwgbm93IHNvbWUgY29kZSB0aGF0IGlzIGJlaW5nIHVzZWQgdG8gbWFrZSBiZWVwcyB2
aWEgdGhlIFBDIHNwZWFrZXIgc3RvcHBlZCB3b3JraW5nLjxvOnA+PC9vOnA+PC9wPg0KPGRpdj4N
CjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxvOnA+Jm5ic3A7PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2
Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+U3RyYW5nZWx5LCB0aGlzIGNvZGUgc3RvcHMgd29ya2lu
ZyBvbiBhIGZldyBkZXZpY2VzIG9ubHkgYWZ0ZXIgQUNQSUNBIHJ1bnMuIEl0IHdvcmtzIGZpbmUg
aWYgSSBkb24ndCBzdGFydCBBQ1BJQ0EuIFRoZSBjb2RlIGlzIHVzaW5nIEkvTyBwb3J0cyAweDQz
LCAweDQyLCBhbmQgMHg2MSB0byBnZW5lcmF0ZSBiZWVwcy4gVGhpcyBzZWVtcyB0byBiZSBhbiBp
bmR1c3RyeSBzdGFuZGFyZCB3YXkgdG8gbWFrZSBiZWVwcw0KIG9uIHg4NiBiYXNlZCBQQ3MgdXNp
bmcgYSBQcm9ncmFtbWFibGUgSW50ZXJ2YWwgVGltZXIgKFBJVCkuPG86cD48L286cD48L3A+DQo8
L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48bzpwPiZuYnNwOzwvbzpwPjwvcD4N
CjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPldoYXQgY291bGQgbXkgQUNQSUNB
IGJlIGRvaW5nIChvciBmYWlsaW5nIHRvIGRvKSB0aGF0IGNvdWxkIGNhdXNlIHRoZSBiZWVwcyB0
byBzdG9wIHdvcmtpbmcgd2l0aCB0aGUgY29kZSBiZWxvdz8gSXMgdGhlIFBJVCBiZWluZyBkaXNh
YmxlZCBzb21laG93PyBJIGd1ZXNzIEknbGwgbmVlZCB0byBsZWFybiBtb3JlIGFib3V0IHRoZSBQ
SVQgYW5kIGhvdyB0byBjaGVjayBpdHMgc3RhdHVzIHRvIHNlZSBpZiBpdCdzDQogYmVpbmcgZGlz
YWJsZWQgYWZ0ZXIgQUNQSUNBIHJ1bnMuPG86cD48L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8
cCBjbGFzcz0iTXNvTm9ybWFsIj48bzpwPiZuYnNwOzwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4N
CjxwIGNsYXNzPSJNc29Ob3JtYWwiPkhlcmUncyBleGFtcGxlIGNvZGUgZm9yIFFOWCB0byBnZW5l
cmF0ZSBhIGJlZXAgdXNpbmcgdGhlIFBDIHNwZWFrZXI6PG86cD48L286cD48L3A+DQo8L2Rpdj4N
CjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj4vLyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLTxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAg
Y2xhc3M9Ik1zb05vcm1hbCI+I2luY2x1ZGUgJmx0O3N5cy9uZXV0cmluby5oJmd0Ozxicj4NCiNp
bmNsdWRlICZsdDtody9pbm91dC5oJmd0Ozxicj4NCiNpbmNsdWRlICZsdDt1bmlzdGQuaCZndDs8
YnI+DQo8YnI+DQppbnQgbWFpbih2b2lkKSB7PGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7IFRocmVh
ZEN0bCggX05UT19UQ1RMX0lPLCAwICk7IC8vIGdldCBJL08gcGVybWlzc2lvbnM8bzpwPjwvbzpw
PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxvOnA+Jm5ic3A7PC9v
OnA+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+Jm5ic3A7Jm5ic3A7
Jm5ic3A7IC8vIHN0YXJ0IGEgYmVlcDxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAg
Y2xhc3M9Ik1zb05vcm1hbCI+Jm5ic3A7ICZuYnNwOyBpbnQgZnJlcSA9IDEwMDA7PGJyPg0KJm5i
c3A7ICZuYnNwOyBpbnQgc2NhbGUgPSAxMTkzMDQ2IC8gZnJlcTs8YnI+DQombmJzcDsgJm5ic3A7
IG91dDgoMHg0MywgMHhiNik7PGJyPg0KJm5ic3A7ICZuYnNwOyBvdXQ4KDB4NDIsIHNjYWxlICZh
bXA7IDB4ZmYpOzxicj4NCiZuYnNwOyAmbmJzcDsgb3V0OCgweDQyLCBzY2FsZSAmZ3Q7Jmd0OyA4
KTs8YnI+DQombmJzcDsgJm5ic3A7IG91dDgoMHg2MSwgaW44KDB4NjEpIHwgMyk7PG86cD48L286
cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj4mbmJzcDsmbmJzcDsm
bmJzcDsgPG86cD48L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFs
Ij4mbmJzcDsmbmJzcDsmbmJzcDsgLy8gbGV0IHRoZSBiZWVwIHBsYXkgZm9yIGEgc2Vjb25kPG86
cD48L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj4mbmJzcDsm
bmJzcDsmbmJzcDsgZGVsYXkoMTAwMCk7PG86cD48L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8
cCBjbGFzcz0iTXNvTm9ybWFsIj48bzpwPiZuYnNwOzwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4N
CjxwIGNsYXNzPSJNc29Ob3JtYWwiPiZuYnNwOyZuYnNwOyZuYnNwOyAvLyBzdG9wIHRoZSBiZWVw
PG86cD48L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj4mbmJz
cDsgJm5ic3A7IG91dDgoMHg2MSwgaW44KDB4NjEpICZhbXA7IH4zKTs8YnI+DQo8YnI+DQombmJz
cDsmbmJzcDsmbmJzcDsgcmV0dXJuIDA7PGJyPg0KfTxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8
ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+Ly8gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0gPG86cD48L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBj
bGFzcz0iTXNvTm9ybWFsIj48bzpwPiZuYnNwOzwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxw
IGNsYXNzPSJNc29Ob3JtYWwiPlRoYW5rcyw8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4N
CjxwIGNsYXNzPSJNc29Ob3JtYWwiPkRldmluPG86cD48L286cD48L3A+DQo8L2Rpdj4NCjwvZGl2
Pg0KPC9kaXY+DQo8L2JvZHk+DQo8L2h0bWw+DQo=

--===============2252329150434740468==--

