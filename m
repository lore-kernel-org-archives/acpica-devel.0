Content-Type: multipart/mixed; boundary="===============6767955928051225196=="
MIME-Version: 1.0
From: David Renz <sun.kisses.horizon at gmail.com>
Subject: Re: [Devel] ACPI table code of Lenovo G710 corrupted?
Date: Tue, 17 Nov 2015 23:49:25 +0100
Message-ID: <CAB=Lj3S129+Dst6m3uAf=iESaiUAbM5ZCZr-G4mKfdGTH5RueQ@mail.gmail.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E37D997650@ORSMSX112.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6767955928051225196==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

They just let the code run in a sandbox, it's an automatic process.
Am 17.11.2015 23:38 schrieb "Moore, Robert" <robert.moore(a)intel.com>:

> I don=E2=80=99t think they know what they are talking about.
>
>
>
>
>
> *From:* David Renz [mailto:sun.kisses.horizon(a)gmail.com]
> *Sent:* Tuesday, November 17, 2015 2:31 PM
> *To:* Moore, Robert; devel(a)acpica.org
> *Subject:* RE: [Devel] ACPI table code of Lenovo G710 corrupted?
>
>
>
> Because I extracted the ACPI code and submitted it to malwr.com, whose
> analysis shows what the code causes / does. That's why I think it's relat=
ed
> to ACPI code.
>
> Am 17.11.2015 23:27 schrieb "Moore, Robert" <robert.moore(a)intel.com>:
>
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

--===============6767955928051225196==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PHAgZGlyPSJsdHIiPlRoZXkganVzdCBsZXQgdGhlIGNvZGUgcnVuIGluIGEgc2FuZGJveCwgaXQm
IzM5O3MgYW4gYXV0b21hdGljIHByb2Nlc3MuPC9wPgo8ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+
QW0gMTcuMTEuMjAxNSAyMzozOCBzY2hyaWViICZxdW90O01vb3JlLCBSb2JlcnQmcXVvdDsgJmx0
OzxhIGhyZWY9Im1haWx0bzpyb2JlcnQubW9vcmVAaW50ZWwuY29tIj5yb2JlcnQubW9vcmVAaW50
ZWwuY29tPC9hPiZndDs6PGJyIHR5cGU9ImF0dHJpYnV0aW9uIj48YmxvY2txdW90ZSBjbGFzcz0i
Z21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2Nj
YyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4KCgoKCgo8ZGl2IGxhbmc9IkVOLVVTIiBsaW5rPSJi
bHVlIiB2bGluaz0icHVycGxlIj4KPGRpdj4KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5
bGU9ImZvbnQtc2l6ZToxMS4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7Q2FsaWJyaSZxdW90OywmcXVv
dDtzYW5zLXNlcmlmJnF1b3Q7O2NvbG9yOiMxZjQ5N2QiPkkgZG9u4oCZdCB0aGluayB0aGV5IGtu
b3cgd2hhdCB0aGV5IGFyZSB0YWxraW5nIGFib3V0Ljx1PjwvdT48dT48L3U+PC9zcGFuPjwvcD4K
PHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMS4wcHQ7Zm9udC1m
YW1pbHk6JnF1b3Q7Q2FsaWJyaSZxdW90OywmcXVvdDtzYW5zLXNlcmlmJnF1b3Q7O2NvbG9yOiMx
ZjQ5N2QiPjx1PjwvdT7CoDx1PjwvdT48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvTm9ybWFsIj48
c3BhbiBzdHlsZT0iZm9udC1zaXplOjExLjBwdDtmb250LWZhbWlseTomcXVvdDtDYWxpYnJpJnF1
b3Q7LCZxdW90O3NhbnMtc2VyaWYmcXVvdDs7Y29sb3I6IzFmNDk3ZCI+PHU+PC91PsKgPHU+PC91
Pjwvc3Bhbj48L3A+CjxkaXYgc3R5bGU9ImJvcmRlcjpub25lO2JvcmRlci1sZWZ0OnNvbGlkIGJs
dWUgMS41cHQ7cGFkZGluZzowaW4gMGluIDBpbiA0LjBwdCI+CjxkaXY+CjxkaXYgc3R5bGU9ImJv
cmRlcjpub25lO2JvcmRlci10b3A6c29saWQgI2I1YzRkZiAxLjBwdDtwYWRkaW5nOjMuMHB0IDBp
biAwaW4gMGluIj4KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PGI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6
ZToxMC4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7VGFob21hJnF1b3Q7LCZxdW90O3NhbnMtc2VyaWYm
cXVvdDsiPkZyb206PC9zcGFuPjwvYj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEwLjBwdDtmb250
LWZhbWlseTomcXVvdDtUYWhvbWEmcXVvdDssJnF1b3Q7c2Fucy1zZXJpZiZxdW90OyI+IERhdmlk
IFJlbnogW21haWx0bzo8YSBocmVmPSJtYWlsdG86c3VuLmtpc3Nlcy5ob3Jpem9uQGdtYWlsLmNv
bSIgdGFyZ2V0PSJfYmxhbmsiPnN1bi5raXNzZXMuaG9yaXpvbkBnbWFpbC5jb208L2E+XQo8YnI+
CjxiPlNlbnQ6PC9iPiBUdWVzZGF5LCBOb3ZlbWJlciAxNywgMjAxNSAyOjMxIFBNPGJyPgo8Yj5U
bzo8L2I+IE1vb3JlLCBSb2JlcnQ7IDxhIGhyZWY9Im1haWx0bzpkZXZlbEBhY3BpY2Eub3JnIiB0
YXJnZXQ9Il9ibGFuayI+ZGV2ZWxAYWNwaWNhLm9yZzwvYT48YnI+CjxiPlN1YmplY3Q6PC9iPiBS
RTogW0RldmVsXSBBQ1BJIHRhYmxlIGNvZGUgb2YgTGVub3ZvIEc3MTAgY29ycnVwdGVkPzx1Pjwv
dT48dT48L3U+PC9zcGFuPjwvcD4KPC9kaXY+CjwvZGl2Pgo8cCBjbGFzcz0iTXNvTm9ybWFsIj48
dT48L3U+wqA8dT48L3U+PC9wPgo8cD5CZWNhdXNlIEkgZXh0cmFjdGVkIHRoZSBBQ1BJIGNvZGUg
YW5kIHN1Ym1pdHRlZCBpdCB0byA8YSBocmVmPSJodHRwOi8vbWFsd3IuY29tIiB0YXJnZXQ9Il9i
bGFuayI+Cm1hbHdyLmNvbTwvYT4sIHdob3NlIGFuYWx5c2lzIHNob3dzIHdoYXQgdGhlIGNvZGUg
Y2F1c2VzIC8gZG9lcy4gVGhhdCYjMzk7cyB3aHkgSSB0aGluayBpdCYjMzk7cyByZWxhdGVkIHRv
IEFDUEkgY29kZS48dT48L3U+PHU+PC91PjwvcD4KPGRpdj4KPHAgY2xhc3M9Ik1zb05vcm1hbCI+
QW0gMTcuMTEuMjAxNSAyMzoyNyBzY2hyaWViICZxdW90O01vb3JlLCBSb2JlcnQmcXVvdDsgJmx0
OzxhIGhyZWY9Im1haWx0bzpyb2JlcnQubW9vcmVAaW50ZWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+
cm9iZXJ0Lm1vb3JlQGludGVsLmNvbTwvYT4mZ3Q7Ojx1PjwvdT48dT48L3U+PC9wPgo8ZGl2Pgo8
ZGl2Pgo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjExLjBwdDtm
b250LWZhbWlseTomcXVvdDtDYWxpYnJpJnF1b3Q7LCZxdW90O3NhbnMtc2VyaWYmcXVvdDs7Y29s
b3I6IzFmNDk3ZCI+SSBkb27igJl0IGtub3cgYWxsIG9mIHRoZSB3aW5kb3dzIGludGVybmFscywg
YnV0IHdoYXQgZXhhY3RseSBtYWtlcyB5b3UgdGhpbmsgdGhhdCB0aGlzIHN0dWZmIGlzIHJlbGF0
ZWQKIHRvIEFDUEk/PC9zcGFuPjx1PjwvdT48dT48L3U+PC9wPgo8cCBjbGFzcz0iTXNvTm9ybWFs
Ij48c3BhbiBzdHlsZT0iZm9udC1zaXplOjExLjBwdDtmb250LWZhbWlseTomcXVvdDtDYWxpYnJp
JnF1b3Q7LCZxdW90O3NhbnMtc2VyaWYmcXVvdDs7Y29sb3I6IzFmNDk3ZCI+wqA8L3NwYW4+PHU+
PC91Pjx1PjwvdT48L3A+CjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJmb250LXNp
emU6MTEuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0NhbGlicmkmcXVvdDssJnF1b3Q7c2Fucy1zZXJp
ZiZxdW90Oztjb2xvcjojMWY0OTdkIj7CoDwvc3Bhbj48dT48L3U+PHU+PC91PjwvcD4KPGRpdiBz
dHlsZT0iYm9yZGVyOm5vbmU7Ym9yZGVyLWxlZnQ6c29saWQgYmx1ZSAxLjVwdDtwYWRkaW5nOjBp
biAwaW4gMGluIDQuMHB0Ij4KPGRpdj4KPGRpdiBzdHlsZT0iYm9yZGVyOm5vbmU7Ym9yZGVyLXRv
cDpzb2xpZCAjYjVjNGRmIDEuMHB0O3BhZGRpbmc6My4wcHQgMGluIDBpbiAwaW4iPgo8cCBjbGFz
cz0iTXNvTm9ybWFsIj48Yj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEwLjBwdDtmb250LWZhbWls
eTomcXVvdDtUYWhvbWEmcXVvdDssJnF1b3Q7c2Fucy1zZXJpZiZxdW90OyI+RnJvbTo8L3NwYW4+
PC9iPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTAuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O1RhaG9t
YSZxdW90OywmcXVvdDtzYW5zLXNlcmlmJnF1b3Q7Ij4gRGF2aWQgUmVueiBbbWFpbHRvOjxhIGhy
ZWY9Im1haWx0bzpzdW4ua2lzc2VzLmhvcml6b25AZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+
c3VuLmtpc3Nlcy5ob3Jpem9uQGdtYWlsLmNvbTwvYT5dCjxicj4KPGI+U2VudDo8L2I+IFR1ZXNk
YXksIE5vdmVtYmVyIDE3LCAyMDE1IDI6MTggUE08YnI+CjxiPlRvOjwvYj4gTW9vcmUsIFJvYmVy
dDxicj4KPGI+Q2M6PC9iPiA8YSBocmVmPSJtYWlsdG86ZGV2ZWxAYWNwaWNhLm9yZyIgdGFyZ2V0
PSJfYmxhbmsiPmRldmVsQGFjcGljYS5vcmc8L2E+PGJyPgo8Yj5TdWJqZWN0OjwvYj4gUmU6IFtE
ZXZlbF0gQUNQSSB0YWJsZSBjb2RlIG9mIExlbm92byBHNzEwIGNvcnJ1cHRlZD88L3NwYW4+PHU+
PC91Pjx1PjwvdT48L3A+CjwvZGl2Pgo8L2Rpdj4KPHAgY2xhc3M9Ik1zb05vcm1hbCI+wqA8dT48
L3U+PHU+PC91PjwvcD4KPGRpdj4KPGRpdj4KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1h
cmdpbi1ib3R0b206MTIuMHB0Ij5Tb3JyeSwgYnV0IGhvdyBjYW4mIzM5O3QgeW91IHNlZSB0aGF0
IHRoaXMgaXMgcmVsYXRlZCB0byB0aGUgY29kZSBzdG9yZWQgaW4gdGhlIEFDUEkgdGFibGVzPzx1
PjwvdT48dT48L3U+PC9wPgo8L2Rpdj4KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1hcmdp
bi1ib3R0b206MTIuMHB0Ij5JIGV4dHJhY3RlZCBpdCBhbmQgc3VibWl0dGVkIHRoZSBmaWxlIHRv
CjxhIGhyZWY9Imh0dHA6Ly9tYWx3ci5jb20iIHRhcmdldD0iX2JsYW5rIj5tYWx3ci5jb208L2E+
LCB3aG9zZSBhbmFseXNpcyBzaG93cyB3aGF0IHRoaXMgQUNQSSBjb2RlIHdvdWxkIGNhdXNlIG9u
IGEgV2luZG93cyBzeXN0ZW0uIEFuZCB3aHkgLyBob3cgY2FuIHRoaXMgY29kZSBjYXVzZSBhbGwg
dGhlIHN0dWZmIGJlaW5nIHZpc2libGUgdW5kZXIgdGhlIHNlY3Rpb25zICZxdW90O0ZpbGVzJnF1
b3Q7IGFuZCAmcXVvdDtSZWdpc3RyeSZxdW90Oz88dT48L3U+PHU+PC91PjwvcD4KPC9kaXY+Cjxk
aXY+CjxwIGNsYXNzPSJNc29Ob3JtYWwiPsKgPHU+PC91Pjx1PjwvdT48L3A+CjxkaXY+CjxwIGNs
YXNzPSJNc29Ob3JtYWwiPk9uIFR1ZSwgTm92IDE3LCAyMDE1IGF0IDEwOjU3IFBNLCBNb29yZSwg
Um9iZXJ0ICZsdDs8YSBocmVmPSJtYWlsdG86cm9iZXJ0Lm1vb3JlQGludGVsLmNvbSIgdGFyZ2V0
PSJfYmxhbmsiPnJvYmVydC5tb29yZUBpbnRlbC5jb208L2E+Jmd0OyB3cm90ZTo8dT48L3U+PHU+
PC91PjwvcD4KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1hcmdpbi1ib3R0b206MTIuMHB0
Ij5UaGVyZSBhcmUgc29tZSBpc3N1ZXMgd2l0aCB0aGlzIG1hY2hpbmUsIGJ1dCB0aGVzZSBhcmUg
bW9yZSBsaW51eC1zcGVjaWZpYyBhbmQgSSBjYW7igJl0IGhlbHAgd2l0aCB0aG9zZS48YnI+Cjxi
cj4KW8KgIMKgMTMuMTE1Njc1XSBBQ1BJIFdhcm5pbmc6IFN5c3RlbUlPIHJhbmdlIDB4MDAwMDAw
MDAwMDAwNTA0MC0weDAwMDAwMDAwMDAwMDUwNUYgY29uZmxpY3RzIHdpdGggT3BSZWdpb24gMHgw
MDAwMDAwMDAwMDA1MDQwLTB4MDAwMDAwMDAwMDAwNTA0RiAoXF9TQl8uUENJMC5TQlVTLlNNQkkp
ICgyMDE1MDIwNC91dGFkZHJlc3MtMjU0KTxicj4KW8KgIMKgMTMuMTE1NjgzXSBBQ1BJOiBJZiBh
biBBQ1BJIGRyaXZlciBpcyBhdmFpbGFibGUgZm9yIHRoaXMgZGV2aWNlLCB5b3Ugc2hvdWxkIHVz
ZSBpdCBpbnN0ZWFkIG9mIHRoZSBuYXRpdmUgZHJpdmVyPGJyPgo8YnI+ClvCoCDCoDEzLjQyNjU3
NF0gW0Zpcm13YXJlIEJ1Z106IEFDUEkoUEVHUCkgZGVmaW5lcyBfRE9EIGJ1dCBub3QgX0RPUzxi
cj4KW8KgIMKgMTMuNDI2OTAyXSBBQ1BJOiBWaWRlbyBEZXZpY2UgW1BFR1BdIChtdWx0aS1oZWFk
OiB5ZXPCoCByb206IHllc8KgIHBvc3Q6IG5vKTxicj4KW8KgIMKgMTMuNDI2OTA4XSBBQ1BJIEVy
cm9yOiBbXF9TQl8uUENJMC5HRlgwLkREMDIuX0JDTF0gTmFtZXNwYWNlIGxvb2t1cCBmYWlsdXJl
LCBBRV9OT1RfRk9VTkQgKDIwMTUwMjA0L3BzYXJncy0zNTkpPGJyPgpbwqAgwqAxMy40MjY5MTNd
IEFDUEkgRXJyb3I6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBF
RzAuUEVHUC5ERDAyLl9CQ0xdIChOb2RlIGZmZmY4ODAyNTYwZjhlMzgpLCBBRV9OT1RfRk9VTkQg
KDIwMTUwMjA0L3BzcGFyc2UtNTM2KTxicj4KW8KgIMKgMTMuNDI2OTcyXSBpbnB1dDogVmlkZW8g
QnVzPGJyPgo8YnI+Cjxicj4KPGJyPgo8YnI+CkZyb206IERldmVsIFttYWlsdG86PGEgaHJlZj0i
bWFpbHRvOmRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZyIgdGFyZ2V0PSJfYmxhbmsiPmRldmVsLWJv
dW5jZXNAYWNwaWNhLm9yZzwvYT5dIE9uIEJlaGFsZiBPZiBEYXZpZCBSZW56PGJyPgpTZW50OiBU
dWVzZGF5LCBOb3ZlbWJlciAxNywgMjAxNSAxMTozMSBBTTxicj4KVG86IDxhIGhyZWY9Im1haWx0
bzpkZXZlbEBhY3BpY2Eub3JnIiB0YXJnZXQ9Il9ibGFuayI+ZGV2ZWxAYWNwaWNhLm9yZzwvYT48
YnI+ClN1YmplY3Q6IFtEZXZlbF0gQUNQSSB0YWJsZSBjb2RlIG9mIExlbm92byBHNzEwIGNvcnJ1
cHRlZD88dT48L3U+PHU+PC91PjwvcD4KPGRpdj4KPGRpdj4KPHAgY2xhc3M9Ik1zb05vcm1hbCI+
SGVsbG8gZXZlcnlvbmUsPGJyPgo8YnI+Ckkgb3duIGEgTGVub3ZvIEc3MTAgbm90ZWJvb2sgKGhl
cmUgb25lIGNhbiBzZWUgdGhlIGV4YWN0IG1vZGVsOiA8YSBocmVmPSJodHRwOi8vcG9zdGltZy5v
cmcvaW1hZ2Uvcm01dmpna2I1LyIgdGFyZ2V0PSJfYmxhbmsiPgpodHRwOi8vcG9zdGltZy5vcmcv
aW1hZ2Uvcm01dmpna2I1LzwvYT4pLCBhbmQgSSBmaW5kIHRoYXQgdGhlIGNvZGUgc3RvcmVkIGlu
IGl0cyBBQ1BJIHRhYmxlcywgd2hpY2ggSSBleHRyYWN0ZWQgdXNpbmcgdGhlIFdpbmRvd3MgdG9v
bCAmcXVvdDtSZWFkJmFtcDtXcml0ZSBFdmVyeXRoaW5nJnF1b3Q7LCBsZWFkcyB0byBzdHJhbmdl
L3N1c3BpY2lvdXMgcmVzdWx0cyB3aGVuIEkgc3VibWl0dGVkIGl0IHRvCjxhIGhyZWY9Imh0dHA6
Ly9tYWx3ci5jb20iIHRhcmdldD0iX2JsYW5rIj5tYWx3ci5jb208L2E+Ojxicj4KPGEgaHJlZj0i
aHR0cHM6Ly9tYWx3ci5jb20vYW5hbHlzaXMvTWpaa09HVTRZMlptTUdNNU5EUTFOamc1T1RjNE5U
VmxPVFE1TlRoaU1tWS8iIHRhcmdldD0iX2JsYW5rIj5odHRwczovL21hbHdyLmNvbS9hbmFseXNp
cy9NalprT0dVNFkyWm1NR001TkRRMU5qZzVPVGM0TlRWbE9UUTVOVGhpTW1ZLzwvYT48YnI+Cjxi
cj4KV2h5IHNob3VsZCB0aGUgQUNQSSB0YWJsZSBjb2RlIGxlYWQgdG8gdGhlIGRlcGxveW1lbnQg
b2YgZmlsZXMgcmVsYXRlZCB0byBNaWNyb3NvZnQgb2ZmaWNlLCB3aGljaCBpcyBub3QgZXZlbiBp
bnN0YWxsZWQgcmlnaHQgYWZ0ZXIgaGF2aW5nIGluc3RhbGxlZCBXaW5kb3dzPzxicj4KPGJyPgpB
bmQgbG9va2luZyBhdCB0aGUgc2VjdGlvbiAmcXVvdDtSZWdpc3RyeSBrZXlzJnF1b3Q7Ojxicj4K
SXNuJiMzOTt0IGl0IHN0cmFuZ2UgdGhhdCB0aGlzIGNvZGUgY2F1c2VzIGFsbCB0aG9zZSByZWdp
c3RyeSBjaGFuZ2VzLCBlc3BlY2lhbGx5IHJlZ2FyZGluZyBhbGwgdGhvc2UgJnF1b3Q7SW5Qcm9j
U2VydmVyMzImcXVvdDsgZW50cmllcz88YnI+Cjxicj4KPGJyPgpDb3VsZCBhbnlvbmUsIHdobyBv
d25zIHRoZSBzYW1lIG1vZGVsLCB0cnkgdG8gZXh0cmFjdCBpdHMgQUNQSSB0YWJsZXMgYW5kIHN1
Ym1pdCB0aGVtIHRvCjxhIGhyZWY9Imh0dHA6Ly9tYWx3ci5jb20iIHRhcmdldD0iX2JsYW5rIj5t
YWx3ci5jb208L2E+IGluIG9yZGVyIHRvIGNoZWNrIGlmIHRoaXMgbGVhZHMgdG8gdGhlIHNhbWUg
cmVzdWx0cz8gQW5kIGlmIG9uZSBzaG91bGQgdGhpbmtzIG9mIHRoaXMgY29kZSBiZWluZyBjb3Jy
dXB0ZWQsIHRoZW4gSSBndWVzcyBpdCB3b3VsZCBiZSBhIGdvb2QgaWRlYSB0byBwZXJmb3JtIGEg
Y29tcGFyaXNvbiBpbiBvcmRlciB0byBmaW5kIGRpZmZlcmVuY2VzIGFuZAogdG8gY2hlY2sgd2hh
dCB0aG9zZSB3b3VsZCBpbXBseS48YnI+CkkgdXBsb2FkZWQgdGhlIGV4dHJhY3RlZCBBQ1BJIHRh
YmxlcyBvZiBteSBub3RlYm9vayBvbiBHb29nbGVEcml2ZTo8YnI+CjxhIGhyZWY9Imh0dHBzOi8v
ZHJpdmUuZ29vZ2xlLmNvbS9maWxlL2QvMEI2Mlk1UWtfcmRiV2FtbFhSWFpCU2tKUVlrVS92aWV3
P3VzcD1zaGFyaW5nIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9kcml2ZS5nb29nbGUuY29tL2Zp
bGUvZC8wQjYyWTVRa19yZGJXYW1sWFJYWkJTa0pRWWtVL3ZpZXc/dXNwPXNoYXJpbmc8L2E+PGJy
PgpVbmRlciBQZW50b28gTGludXggKGFuZCBhbnkgb3RoZXIgTGludXggZGlzdHJvIEkgdHJpZWQp
IHRoZSBkbWVzZyBvdXRwdXQgYWxzbyBzaG93cyBxdWl0ZSBtYW55IEFDUEkgcmVsYXRlZCBlcnJv
ciBtZXNzYWdlcyAoc3RhcnRpbmcgYXQgc2Vjb25kIDEzKTo8YnI+CjxhIGhyZWY9Imh0dHBzOi8v
ZHJpdmUuZ29vZ2xlLmNvbS9maWxlL2QvMEI2Mlk1UWtfcmRiV01HSk5WbnBYY1ZCSWJFRS92aWV3
P3VzcD1zaGFyaW5nIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9kcml2ZS5nb29nbGUuY29tL2Zp
bGUvZC8wQjYyWTVRa19yZGJXTUdKTlZucFhjVkJJYkVFL3ZpZXc/dXNwPXNoYXJpbmc8L2E+PGJy
Pgo8YnI+ClRoYW5rcyBpbiBhZHZhbmNlIGFuZCBiZXN0IHdpc2hlczxicj4KRGF2aWQ8YnI+Cjxi
cj4KwqA8YnI+Cjxicj4KwqA8YnI+Cjxicj4KQmVzdCB3aXNoZXMgYW5kIHRoYW5rcyBpbiBhZHZh
bmNlPHU+PC91Pjx1PjwvdT48L3A+CjwvZGl2Pgo8L2Rpdj4KPC9kaXY+CjxwIGNsYXNzPSJNc29O
b3JtYWwiPsKgPHU+PC91Pjx1PjwvdT48L3A+CjwvZGl2Pgo8L2Rpdj4KPC9kaXY+CjwvZGl2Pgo8
L2Rpdj4KPC9kaXY+CjwvZGl2Pgo8L2Rpdj4KCjwvYmxvY2txdW90ZT48L2Rpdj4K

--===============6767955928051225196==--

