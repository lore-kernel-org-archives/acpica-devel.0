Content-Type: multipart/mixed; boundary="===============6610527113400919626=="
MIME-Version: 1.0
From: David Renz <sun.kisses.horizon at gmail.com>
Subject: [Devel] ACPI table code of Lenovo G710 corrupted?
Date: Tue, 17 Nov 2015 20:30:59 +0100
Message-ID: <CAB=Lj3Qjsi3jmrsgk9GDPynSedLZuhkJtsM=Dt-qFZ+_+AtfLA@mail.gmail.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6610527113400919626==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello everyone,

I own a Lenovo G710 notebook (here one can see the exact model:
http://postimg.org/image/rm5vjgkb5/), and I find that the code stored in
its ACPI tables, which I extracted using the Windows tool "Read&Write
Everything", leads to strange/suspicious results when I submitted it to
malwr.com:
https://malwr.com/analysis/MjZkOGU4Y2ZmMGM5NDQ1Njg5OTc4NTVlOTQ5NThiMmY/

Why should the ACPI table code lead to the deployment of files related to
Microsoft office, which is not even installed right after having installed
Windows?

And looking at the section "Registry keys":
Isn't it strange that this code causes all those registry changes,
especially regarding all those "InProcServer32" entries?


Could anyone, who owns the same model, try to extract its ACPI tables and
submit them to malwr.com in order to check if this leads to the same
results? And if one should thinks of this code being corrupted, then I
guess it would be a good idea to perform a comparison in order to find
differences and to check what those would imply.
I uploaded the extracted ACPI tables of my notebook on GoogleDrive:
https://drive.google.com/file/d/0B62Y5Qk_rdbWamlXRXZBSkJQYkU/view?usp=3Dsha=
ring

Under Pentoo Linux (and any other Linux distro I tried) the dmesg output
also shows quite many ACPI related error messages (starting at second 13):
https://drive.google.com/file/d/0B62Y5Qk_rdbWMGJNVnpXcVBIbEE/view?usp=3Dsha=
ring


Thanks in advance and best wishes

David






Best wishes and thanks in advance

--===============6610527113400919626==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2PjxkaXY+PGRpdj5IZWxsbyBldmVyeW9uZSw8YnI+PGJy
Pkkgb3duIGEgTGVub3ZvIEc3MTAgbm90ZWJvb2sgKGhlcmUgb25lIGNhbiBzZWUgdGhlIGV4YWN0
IG1vZGVsOiA8YSBocmVmPSJodHRwOi8vcG9zdGltZy5vcmcvaW1hZ2Uvcm01dmpna2I1LyI+aHR0
cDovL3Bvc3RpbWcub3JnL2ltYWdlL3JtNXZqZ2tiNS88L2E+KSwgYW5kIEkgZmluZCB0aGF0IHRo
ZSBjb2RlIHN0b3JlZCBpbiBpdHMgQUNQSSB0YWJsZXMsIHdoaWNoIEkgZXh0cmFjdGVkIHVzaW5n
IHRoZSBXaW5kb3dzIHRvb2wgJnF1b3Q7UmVhZCZhbXA7V3JpdGUgRXZlcnl0aGluZyZxdW90Oywg
bGVhZHMgdG8gc3RyYW5nZS9zdXNwaWNpb3VzIHJlc3VsdHMgd2hlbiBJIHN1Ym1pdHRlZCBpdCB0
byA8YSBocmVmPSJodHRwOi8vbWFsd3IuY29tIj5tYWx3ci5jb208L2E+Ojxicj48YSBocmVmPSJo
dHRwczovL21hbHdyLmNvbS9hbmFseXNpcy9NalprT0dVNFkyWm1NR001TkRRMU5qZzVPVGM0TlRW
bE9UUTVOVGhpTW1ZLyI+aHR0cHM6Ly9tYWx3ci5jb20vYW5hbHlzaXMvTWpaa09HVTRZMlptTUdN
NU5EUTFOamc1T1RjNE5UVmxPVFE1TlRoaU1tWS88L2E+PGJyPjxicj5XaHkgc2hvdWxkIHRoZSBB
Q1BJIHRhYmxlIGNvZGUgbGVhZCB0byB0aGUgZGVwbG95bWVudCBvZiBmaWxlcyByZWxhdGVkIHRv
IE1pY3Jvc29mdCBvZmZpY2UsIHdoaWNoIGlzIG5vdCBldmVuIGluc3RhbGxlZCByaWdodCBhZnRl
ciBoYXZpbmcgaW5zdGFsbGVkIFdpbmRvd3M/PGJyPjxicj5BbmQgbG9va2luZyBhdCB0aGUgc2Vj
dGlvbiAmcXVvdDtSZWdpc3RyeSBrZXlzJnF1b3Q7Ojxicj5Jc24mIzM5O3QgaXQgc3RyYW5nZSB0
aGF0IHRoaXMgY29kZSBjYXVzZXMgYWxsIHRob3NlIHJlZ2lzdHJ5IGNoYW5nZXMsIGVzcGVjaWFs
bHkgcmVnYXJkaW5nIGFsbCB0aG9zZSAmcXVvdDtJblByb2NTZXJ2ZXIzMiZxdW90OyBlbnRyaWVz
Pzxicj48YnI+PGJyPkNvdWxkIGFueW9uZSwgd2hvIG93bnMgdGhlIHNhbWUgbW9kZWwsIHRyeSB0
byBleHRyYWN0IGl0cyBBQ1BJIHRhYmxlcyBhbmQgc3VibWl0IHRoZW0gdG8gPGEgaHJlZj0iaHR0
cDovL21hbHdyLmNvbSI+bWFsd3IuY29tPC9hPiBpbiBvcmRlciB0byBjaGVjayBpZiB0aGlzIGxl
YWRzIHRvIHRoZSBzYW1lIHJlc3VsdHM/IEFuZCBpZiBvbmUgc2hvdWxkIHRoaW5rcyBvZiB0aGlz
IGNvZGUgYmVpbmcgY29ycnVwdGVkLCB0aGVuIEkgZ3Vlc3MgaXQgd291bGQgYmUgYSBnb29kIGlk
ZWEgdG8gcGVyZm9ybSBhIGNvbXBhcmlzb24gaW4gb3JkZXIgdG8gZmluZCBkaWZmZXJlbmNlcyBh
bmQgdG8gY2hlY2sgd2hhdCB0aG9zZSB3b3VsZCBpbXBseS48YnI+PC9kaXY+SSB1cGxvYWRlZCB0
aGUgZXh0cmFjdGVkIEFDUEkgdGFibGVzIG9mIG15IG5vdGVib29rIG9uIEdvb2dsZURyaXZlOjxi
cj48YSBocmVmPSJodHRwczovL2RyaXZlLmdvb2dsZS5jb20vZmlsZS9kLzBCNjJZNVFrX3JkYldh
bWxYUlhaQlNrSlFZa1Uvdmlldz91c3A9c2hhcmluZyI+aHR0cHM6Ly9kcml2ZS5nb29nbGUuY29t
L2ZpbGUvZC8wQjYyWTVRa19yZGJXYW1sWFJYWkJTa0pRWWtVL3ZpZXc/dXNwPXNoYXJpbmc8L2E+
PGJyPjxicj48L2Rpdj5VbmRlciBQZW50b28gTGludXggKGFuZCBhbnkgb3RoZXIgTGludXggZGlz
dHJvIEkgdHJpZWQpIHRoZSBkbWVzZyBvdXRwdXQgYWxzbyBzaG93cyBxdWl0ZSBtYW55IEFDUEkg
cmVsYXRlZCBlcnJvciBtZXNzYWdlcyAoc3RhcnRpbmcgYXQgc2Vjb25kIDEzKTo8YnI+PGEgaHJl
Zj0iaHR0cHM6Ly9kcml2ZS5nb29nbGUuY29tL2ZpbGUvZC8wQjYyWTVRa19yZGJXTUdKTlZucFhj
VkJJYkVFL3ZpZXc/dXNwPXNoYXJpbmciPmh0dHBzOi8vZHJpdmUuZ29vZ2xlLmNvbS9maWxlL2Qv
MEI2Mlk1UWtfcmRiV01HSk5WbnBYY1ZCSWJFRS92aWV3P3VzcD1zaGFyaW5nPC9hPjxicj48YnI+
PGJyPjwvZGl2PlRoYW5rcyBpbiBhZHZhbmNlIGFuZCBiZXN0IHdpc2hlczxicj48YnI+PC9kaXY+
RGF2aWQ8YnI+PGJyPjxkaXY+PGRpdj48ZGl2PjxkaXY+PGRpdj48YnI+wqA8YnI+PGJyPsKgPGJy
Pjxicj5CZXN0IHdpc2hlcyBhbmQgdGhhbmtzIGluIGFkdmFuY2U8YnI+PGJyPjwvZGl2PjwvZGl2
PjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2Pgo=

--===============6610527113400919626==--

