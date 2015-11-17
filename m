Content-Type: multipart/mixed; boundary="===============9031888223773254697=="
MIME-Version: 1.0
From: David Renz <sun.kisses.horizon at gmail.com>
Subject: Re: [Devel] ACPI table code of Lenovo G710 corrupted?
Date: Tue, 17 Nov 2015 23:31:26 +0100
Message-ID: <CAB=Lj3Td7jSpzM2zMizFS0KgtAj9JRLPUC=h-GJS2SgBbuWZ5g@mail.gmail.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E37D997627@ORSMSX112.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============9031888223773254697==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Because I extracted the ACPI code and submitted it to malwr.com, whose
analysis shows what the code causes / does. That's why I think it's related
to ACPI code.
Am 17.11.2015 23:27 schrieb "Moore, Robert" <robert.moore(a)intel.com>:

> I don=E2=80=99t know all of the windows internals, but what exactly makes=
 you
> think that this stuff is related to ACPI?
>
>
>
>
>
> *From:* David Renz [mailto:sun.kisses.horizon(a)gmail.com]
> *Sent:* Tuesday, November 17, 2015 2:18 PM
> *To:* Moore, Robert
> *Cc:* devel(a)acpica.org
> *Subject:* Re: [Devel] ACPI table code of Lenovo G710 corrupted?
>
>
>
> Sorry, but how can't you see that this is related to the code stored in
> the ACPI tables?
>
> I extracted it and submitted the file to malwr.com, whose analysis shows
> what this ACPI code would cause on a Windows system. And why / how can th=
is
> code cause all the stuff being visible under the sections "Files" and
> "Registry"?
>
>
>
> On Tue, Nov 17, 2015 at 10:57 PM, Moore, Robert <robert.moore(a)intel.com>
> wrote:
>
> There are some issues with this machine, but these are more linux-specific
> and I can=E2=80=99t help with those.
>
> [   13.115675] ACPI Warning: SystemIO range
> 0x0000000000005040-0x000000000000505F conflicts with OpRegion
> 0x0000000000005040-0x000000000000504F (\_SB_.PCI0.SBUS.SMBI)
> (20150204/utaddress-254)
> [   13.115683] ACPI: If an ACPI driver is available for this device, you
> should use it instead of the native driver
>
> [   13.426574] [Firmware Bug]: ACPI(PEGP) defines _DOD but not _DOS
> [   13.426902] ACPI: Video Device [PEGP] (multi-head: yes  rom: yes  post:
> no)
> [   13.426908] ACPI Error: [\_SB_.PCI0.GFX0.DD02._BCL] Namespace lookup
> failure, AE_NOT_FOUND (20150204/psargs-359)
> [   13.426913] ACPI Error: Method parse/execution failed
> [\_SB_.PCI0.PEG0.PEGP.DD02._BCL] (Node ffff8802560f8e38), AE_NOT_FOUND
> (20150204/psparse-536)
> [   13.426972] input: Video Bus
>
>
>
>
> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of David Renz
> Sent: Tuesday, November 17, 2015 11:31 AM
> To: devel(a)acpica.org
> Subject: [Devel] ACPI table code of Lenovo G710 corrupted?
>
> Hello everyone,
>
> I own a Lenovo G710 notebook (here one can see the exact model:
> http://postimg.org/image/rm5vjgkb5/), and I find that the code stored in
> its ACPI tables, which I extracted using the Windows tool "Read&Write
> Everything", leads to strange/suspicious results when I submitted it to
> malwr.com:
> https://malwr.com/analysis/MjZkOGU4Y2ZmMGM5NDQ1Njg5OTc4NTVlOTQ5NThiMmY/
>
> Why should the ACPI table code lead to the deployment of files related to
> Microsoft office, which is not even installed right after having installed
> Windows?
>
> And looking at the section "Registry keys":
> Isn't it strange that this code causes all those registry changes,
> especially regarding all those "InProcServer32" entries?
>
>
> Could anyone, who owns the same model, try to extract its ACPI tables and
> submit them to malwr.com in order to check if this leads to the same
> results? And if one should thinks of this code being corrupted, then I
> guess it would be a good idea to perform a comparison in order to find
> differences and to check what those would imply.
> I uploaded the extracted ACPI tables of my notebook on GoogleDrive:
>
> https://drive.google.com/file/d/0B62Y5Qk_rdbWamlXRXZBSkJQYkU/view?usp=3Ds=
haring
> Under Pentoo Linux (and any other Linux distro I tried) the dmesg output
> also shows quite many ACPI related error messages (starting at second 13):
>
> https://drive.google.com/file/d/0B62Y5Qk_rdbWMGJNVnpXcVBIbEE/view?usp=3Ds=
haring
>
> Thanks in advance and best wishes
> David
>
>
>
>
>
> Best wishes and thanks in advance
>
>
>

--===============9031888223773254697==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PHAgZGlyPSJsdHIiPkJlY2F1c2UgSSBleHRyYWN0ZWQgdGhlIEFDUEkgY29kZSBhbmQgc3VibWl0
dGVkIGl0IHRvIDxhIGhyZWY9Imh0dHA6Ly9tYWx3ci5jb20iPm1hbHdyLmNvbTwvYT4sIHdob3Nl
IGFuYWx5c2lzIHNob3dzIHdoYXQgdGhlIGNvZGUgY2F1c2VzIC8gZG9lcy4gVGhhdCYjMzk7cyB3
aHkgSSB0aGluayBpdCYjMzk7cyByZWxhdGVkIHRvIEFDUEkgY29kZS48L3A+CjxkaXYgY2xhc3M9
ImdtYWlsX3F1b3RlIj5BbSAxNy4xMS4yMDE1IDIzOjI3IHNjaHJpZWIgJnF1b3Q7TW9vcmUsIFJv
YmVydCZxdW90OyAmbHQ7PGEgaHJlZj0ibWFpbHRvOnJvYmVydC5tb29yZUBpbnRlbC5jb20iPnJv
YmVydC5tb29yZUBpbnRlbC5jb208L2E+Jmd0Ozo8YnIgdHlwZT0iYXR0cmlidXRpb24iPjxibG9j
a3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRl
ci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPgoKCgoKCjxkaXYgbGFuZz0i
RU4tVVMiIGxpbms9ImJsdWUiIHZsaW5rPSJwdXJwbGUiPgo8ZGl2Pgo8cCBjbGFzcz0iTXNvTm9y
bWFsIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjExLjBwdDtmb250LWZhbWlseTomcXVvdDtDYWxp
YnJpJnF1b3Q7LCZxdW90O3NhbnMtc2VyaWYmcXVvdDs7Y29sb3I6IzFmNDk3ZCI+SSBkb27igJl0
IGtub3cgYWxsIG9mIHRoZSB3aW5kb3dzIGludGVybmFscywgYnV0IHdoYXQgZXhhY3RseSBtYWtl
cyB5b3UgdGhpbmsgdGhhdCB0aGlzIHN0dWZmIGlzIHJlbGF0ZWQgdG8gQUNQST88dT48L3U+PHU+
PC91Pjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJmb250LXNp
emU6MTEuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0NhbGlicmkmcXVvdDssJnF1b3Q7c2Fucy1zZXJp
ZiZxdW90Oztjb2xvcjojMWY0OTdkIj48dT48L3U+wqA8dT48L3U+PC9zcGFuPjwvcD4KPHAgY2xh
c3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMS4wcHQ7Zm9udC1mYW1pbHk6
JnF1b3Q7Q2FsaWJyaSZxdW90OywmcXVvdDtzYW5zLXNlcmlmJnF1b3Q7O2NvbG9yOiMxZjQ5N2Qi
Pjx1PjwvdT7CoDx1PjwvdT48L3NwYW4+PC9wPgo8ZGl2IHN0eWxlPSJib3JkZXI6bm9uZTtib3Jk
ZXItbGVmdDpzb2xpZCBibHVlIDEuNXB0O3BhZGRpbmc6MGluIDBpbiAwaW4gNC4wcHQiPgo8ZGl2
Pgo8ZGl2IHN0eWxlPSJib3JkZXI6bm9uZTtib3JkZXItdG9wOnNvbGlkICNiNWM0ZGYgMS4wcHQ7
cGFkZGluZzozLjBwdCAwaW4gMGluIDBpbiI+CjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxiPjxzcGFu
IHN0eWxlPSJmb250LXNpemU6MTAuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O1RhaG9tYSZxdW90Oywm
cXVvdDtzYW5zLXNlcmlmJnF1b3Q7Ij5Gcm9tOjwvc3Bhbj48L2I+PHNwYW4gc3R5bGU9ImZvbnQt
c2l6ZToxMC4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7VGFob21hJnF1b3Q7LCZxdW90O3NhbnMtc2Vy
aWYmcXVvdDsiPiBEYXZpZCBSZW56IFttYWlsdG86PGEgaHJlZj0ibWFpbHRvOnN1bi5raXNzZXMu
aG9yaXpvbkBnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5zdW4ua2lzc2VzLmhvcml6b25AZ21h
aWwuY29tPC9hPl0KPGJyPgo8Yj5TZW50OjwvYj4gVHVlc2RheSwgTm92ZW1iZXIgMTcsIDIwMTUg
MjoxOCBQTTxicj4KPGI+VG86PC9iPiBNb29yZSwgUm9iZXJ0PGJyPgo8Yj5DYzo8L2I+IDxhIGhy
ZWY9Im1haWx0bzpkZXZlbEBhY3BpY2Eub3JnIiB0YXJnZXQ9Il9ibGFuayI+ZGV2ZWxAYWNwaWNh
Lm9yZzwvYT48YnI+CjxiPlN1YmplY3Q6PC9iPiBSZTogW0RldmVsXSBBQ1BJIHRhYmxlIGNvZGUg
b2YgTGVub3ZvIEc3MTAgY29ycnVwdGVkPzx1PjwvdT48dT48L3U+PC9zcGFuPjwvcD4KPC9kaXY+
CjwvZGl2Pgo8cCBjbGFzcz0iTXNvTm9ybWFsIj48dT48L3U+wqA8dT48L3U+PC9wPgo8ZGl2Pgo8
ZGl2Pgo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0ibWFyZ2luLWJvdHRvbToxMi4wcHQiPlNv
cnJ5LCBidXQgaG93IGNhbiYjMzk7dCB5b3Ugc2VlIHRoYXQgdGhpcyBpcyByZWxhdGVkIHRvIHRo
ZSBjb2RlIHN0b3JlZCBpbiB0aGUgQUNQSSB0YWJsZXM/PHU+PC91Pjx1PjwvdT48L3A+CjwvZGl2
Pgo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0ibWFyZ2luLWJvdHRvbToxMi4wcHQiPkkgZXh0
cmFjdGVkIGl0IGFuZCBzdWJtaXR0ZWQgdGhlIGZpbGUgdG8KPGEgaHJlZj0iaHR0cDovL21hbHdy
LmNvbSIgdGFyZ2V0PSJfYmxhbmsiPm1hbHdyLmNvbTwvYT4sIHdob3NlIGFuYWx5c2lzIHNob3dz
IHdoYXQgdGhpcyBBQ1BJIGNvZGUgd291bGQgY2F1c2Ugb24gYSBXaW5kb3dzIHN5c3RlbS4gQW5k
IHdoeSAvIGhvdyBjYW4gdGhpcyBjb2RlIGNhdXNlIGFsbCB0aGUgc3R1ZmYgYmVpbmcgdmlzaWJs
ZSB1bmRlciB0aGUgc2VjdGlvbnMgJnF1b3Q7RmlsZXMmcXVvdDsgYW5kICZxdW90O1JlZ2lzdHJ5
JnF1b3Q7Pzx1PjwvdT48dT48L3U+PC9wPgo8L2Rpdj4KPGRpdj4KPHAgY2xhc3M9Ik1zb05vcm1h
bCI+PHU+PC91PsKgPHU+PC91PjwvcD4KPGRpdj4KPHAgY2xhc3M9Ik1zb05vcm1hbCI+T24gVHVl
LCBOb3YgMTcsIDIwMTUgYXQgMTA6NTcgUE0sIE1vb3JlLCBSb2JlcnQgJmx0OzxhIGhyZWY9Im1h
aWx0bzpyb2JlcnQubW9vcmVAaW50ZWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+cm9iZXJ0Lm1vb3Jl
QGludGVsLmNvbTwvYT4mZ3Q7IHdyb3RlOjx1PjwvdT48dT48L3U+PC9wPgo8cCBjbGFzcz0iTXNv
Tm9ybWFsIiBzdHlsZT0ibWFyZ2luLWJvdHRvbToxMi4wcHQiPlRoZXJlIGFyZSBzb21lIGlzc3Vl
cyB3aXRoIHRoaXMgbWFjaGluZSwgYnV0IHRoZXNlIGFyZSBtb3JlIGxpbnV4LXNwZWNpZmljIGFu
ZCBJIGNhbuKAmXQgaGVscCB3aXRoIHRob3NlLjxicj4KPGJyPgpbwqAgwqAxMy4xMTU2NzVdIEFD
UEkgV2FybmluZzogU3lzdGVtSU8gcmFuZ2UgMHgwMDAwMDAwMDAwMDA1MDQwLTB4MDAwMDAwMDAw
MDAwNTA1RiBjb25mbGljdHMgd2l0aCBPcFJlZ2lvbiAweDAwMDAwMDAwMDAwMDUwNDAtMHgwMDAw
MDAwMDAwMDA1MDRGIChcX1NCXy5QQ0kwLlNCVVMuU01CSSkgKDIwMTUwMjA0L3V0YWRkcmVzcy0y
NTQpPGJyPgpbwqAgwqAxMy4xMTU2ODNdIEFDUEk6IElmIGFuIEFDUEkgZHJpdmVyIGlzIGF2YWls
YWJsZSBmb3IgdGhpcyBkZXZpY2UsIHlvdSBzaG91bGQgdXNlIGl0IGluc3RlYWQgb2YgdGhlIG5h
dGl2ZSBkcml2ZXI8YnI+Cjxicj4KW8KgIMKgMTMuNDI2NTc0XSBbRmlybXdhcmUgQnVnXTogQUNQ
SShQRUdQKSBkZWZpbmVzIF9ET0QgYnV0IG5vdCBfRE9TPGJyPgpbwqAgwqAxMy40MjY5MDJdIEFD
UEk6IFZpZGVvIERldmljZSBbUEVHUF0gKG11bHRpLWhlYWQ6IHllc8KgIHJvbTogeWVzwqAgcG9z
dDogbm8pPGJyPgpbwqAgwqAxMy40MjY5MDhdIEFDUEkgRXJyb3I6IFtcX1NCXy5QQ0kwLkdGWDAu
REQwMi5fQkNMXSBOYW1lc3BhY2UgbG9va3VwIGZhaWx1cmUsIEFFX05PVF9GT1VORCAoMjAxNTAy
MDQvcHNhcmdzLTM1OSk8YnI+ClvCoCDCoDEzLjQyNjkxM10gQUNQSSBFcnJvcjogTWV0aG9kIHBh
cnNlL2V4ZWN1dGlvbiBmYWlsZWQgW1xfU0JfLlBDSTAuUEVHMC5QRUdQLkREMDIuX0JDTF0gKE5v
ZGUgZmZmZjg4MDI1NjBmOGUzOCksIEFFX05PVF9GT1VORCAoMjAxNTAyMDQvcHNwYXJzZS01MzYp
PGJyPgpbwqAgwqAxMy40MjY5NzJdIGlucHV0OiBWaWRlbyBCdXM8YnI+Cjxicj4KPGJyPgo8YnI+
Cjxicj4KPHNwYW4+RnJvbTogRGV2ZWwgW21haWx0bzo8YSBocmVmPSJtYWlsdG86ZGV2ZWwtYm91
bmNlc0BhY3BpY2Eub3JnIiB0YXJnZXQ9Il9ibGFuayI+ZGV2ZWwtYm91bmNlc0BhY3BpY2Eub3Jn
PC9hPl0gT24gQmVoYWxmIE9mIERhdmlkIFJlbno8L3NwYW4+PGJyPgo8c3Bhbj5TZW50OiBUdWVz
ZGF5LCBOb3ZlbWJlciAxNywgMjAxNSAxMTozMSBBTTwvc3Bhbj48YnI+CjxzcGFuPlRvOiA8YSBo
cmVmPSJtYWlsdG86ZGV2ZWxAYWNwaWNhLm9yZyIgdGFyZ2V0PSJfYmxhbmsiPmRldmVsQGFjcGlj
YS5vcmc8L2E+PC9zcGFuPjxicj4KPHNwYW4+U3ViamVjdDogW0RldmVsXSBBQ1BJIHRhYmxlIGNv
ZGUgb2YgTGVub3ZvIEc3MTAgY29ycnVwdGVkPzwvc3Bhbj48dT48L3U+PHU+PC91PjwvcD4KPGRp
dj4KPGRpdj4KPHAgY2xhc3M9Ik1zb05vcm1hbCI+SGVsbG8gZXZlcnlvbmUsPGJyPgo8YnI+Ckkg
b3duIGEgTGVub3ZvIEc3MTAgbm90ZWJvb2sgKGhlcmUgb25lIGNhbiBzZWUgdGhlIGV4YWN0IG1v
ZGVsOiA8YSBocmVmPSJodHRwOi8vcG9zdGltZy5vcmcvaW1hZ2Uvcm01dmpna2I1LyIgdGFyZ2V0
PSJfYmxhbmsiPgpodHRwOi8vcG9zdGltZy5vcmcvaW1hZ2Uvcm01dmpna2I1LzwvYT4pLCBhbmQg
SSBmaW5kIHRoYXQgdGhlIGNvZGUgc3RvcmVkIGluIGl0cyBBQ1BJIHRhYmxlcywgd2hpY2ggSSBl
eHRyYWN0ZWQgdXNpbmcgdGhlIFdpbmRvd3MgdG9vbCAmcXVvdDtSZWFkJmFtcDtXcml0ZSBFdmVy
eXRoaW5nJnF1b3Q7LCBsZWFkcyB0byBzdHJhbmdlL3N1c3BpY2lvdXMgcmVzdWx0cyB3aGVuIEkg
c3VibWl0dGVkIGl0IHRvCjxhIGhyZWY9Imh0dHA6Ly9tYWx3ci5jb20iIHRhcmdldD0iX2JsYW5r
Ij5tYWx3ci5jb208L2E+Ojxicj4KPGEgaHJlZj0iaHR0cHM6Ly9tYWx3ci5jb20vYW5hbHlzaXMv
TWpaa09HVTRZMlptTUdNNU5EUTFOamc1T1RjNE5UVmxPVFE1TlRoaU1tWS8iIHRhcmdldD0iX2Js
YW5rIj5odHRwczovL21hbHdyLmNvbS9hbmFseXNpcy9NalprT0dVNFkyWm1NR001TkRRMU5qZzVP
VGM0TlRWbE9UUTVOVGhpTW1ZLzwvYT48YnI+Cjxicj4KV2h5IHNob3VsZCB0aGUgQUNQSSB0YWJs
ZSBjb2RlIGxlYWQgdG8gdGhlIGRlcGxveW1lbnQgb2YgZmlsZXMgcmVsYXRlZCB0byBNaWNyb3Nv
ZnQgb2ZmaWNlLCB3aGljaCBpcyBub3QgZXZlbiBpbnN0YWxsZWQgcmlnaHQgYWZ0ZXIgaGF2aW5n
IGluc3RhbGxlZCBXaW5kb3dzPzxicj4KPGJyPgpBbmQgbG9va2luZyBhdCB0aGUgc2VjdGlvbiAm
cXVvdDtSZWdpc3RyeSBrZXlzJnF1b3Q7Ojxicj4KSXNuJiMzOTt0IGl0IHN0cmFuZ2UgdGhhdCB0
aGlzIGNvZGUgY2F1c2VzIGFsbCB0aG9zZSByZWdpc3RyeSBjaGFuZ2VzLCBlc3BlY2lhbGx5IHJl
Z2FyZGluZyBhbGwgdGhvc2UgJnF1b3Q7SW5Qcm9jU2VydmVyMzImcXVvdDsgZW50cmllcz88YnI+
Cjxicj4KPGJyPgpDb3VsZCBhbnlvbmUsIHdobyBvd25zIHRoZSBzYW1lIG1vZGVsLCB0cnkgdG8g
ZXh0cmFjdCBpdHMgQUNQSSB0YWJsZXMgYW5kIHN1Ym1pdCB0aGVtIHRvCjxhIGhyZWY9Imh0dHA6
Ly9tYWx3ci5jb20iIHRhcmdldD0iX2JsYW5rIj5tYWx3ci5jb208L2E+IGluIG9yZGVyIHRvIGNo
ZWNrIGlmIHRoaXMgbGVhZHMgdG8gdGhlIHNhbWUgcmVzdWx0cz8gQW5kIGlmIG9uZSBzaG91bGQg
dGhpbmtzIG9mIHRoaXMgY29kZSBiZWluZyBjb3JydXB0ZWQsIHRoZW4gSSBndWVzcyBpdCB3b3Vs
ZCBiZSBhIGdvb2QgaWRlYSB0byBwZXJmb3JtIGEgY29tcGFyaXNvbiBpbiBvcmRlciB0byBmaW5k
IGRpZmZlcmVuY2VzIGFuZAogdG8gY2hlY2sgd2hhdCB0aG9zZSB3b3VsZCBpbXBseS48YnI+Ckkg
dXBsb2FkZWQgdGhlIGV4dHJhY3RlZCBBQ1BJIHRhYmxlcyBvZiBteSBub3RlYm9vayBvbiBHb29n
bGVEcml2ZTo8YnI+CjxhIGhyZWY9Imh0dHBzOi8vZHJpdmUuZ29vZ2xlLmNvbS9maWxlL2QvMEI2
Mlk1UWtfcmRiV2FtbFhSWFpCU2tKUVlrVS92aWV3P3VzcD1zaGFyaW5nIiB0YXJnZXQ9Il9ibGFu
ayI+aHR0cHM6Ly9kcml2ZS5nb29nbGUuY29tL2ZpbGUvZC8wQjYyWTVRa19yZGJXYW1sWFJYWkJT
a0pRWWtVL3ZpZXc/dXNwPXNoYXJpbmc8L2E+PGJyPgpVbmRlciBQZW50b28gTGludXggKGFuZCBh
bnkgb3RoZXIgTGludXggZGlzdHJvIEkgdHJpZWQpIHRoZSBkbWVzZyBvdXRwdXQgYWxzbyBzaG93
cyBxdWl0ZSBtYW55IEFDUEkgcmVsYXRlZCBlcnJvciBtZXNzYWdlcyAoc3RhcnRpbmcgYXQgc2Vj
b25kIDEzKTo8YnI+CjxhIGhyZWY9Imh0dHBzOi8vZHJpdmUuZ29vZ2xlLmNvbS9maWxlL2QvMEI2
Mlk1UWtfcmRiV01HSk5WbnBYY1ZCSWJFRS92aWV3P3VzcD1zaGFyaW5nIiB0YXJnZXQ9Il9ibGFu
ayI+aHR0cHM6Ly9kcml2ZS5nb29nbGUuY29tL2ZpbGUvZC8wQjYyWTVRa19yZGJXTUdKTlZucFhj
VkJJYkVFL3ZpZXc/dXNwPXNoYXJpbmc8L2E+PGJyPgo8YnI+ClRoYW5rcyBpbiBhZHZhbmNlIGFu
ZCBiZXN0IHdpc2hlczxicj4KRGF2aWQ8YnI+Cjxicj4KwqA8YnI+Cjxicj4KwqA8YnI+Cjxicj4K
QmVzdCB3aXNoZXMgYW5kIHRoYW5rcyBpbiBhZHZhbmNlPHU+PC91Pjx1PjwvdT48L3A+CjwvZGl2
Pgo8L2Rpdj4KPC9kaXY+CjxwIGNsYXNzPSJNc29Ob3JtYWwiPjx1PjwvdT7CoDx1PjwvdT48L3A+
CjwvZGl2Pgo8L2Rpdj4KPC9kaXY+CjwvZGl2PgoKPC9ibG9ja3F1b3RlPjwvZGl2Pgo=

--===============9031888223773254697==--

