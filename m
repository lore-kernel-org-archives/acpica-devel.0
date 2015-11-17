Content-Type: multipart/mixed; boundary="===============6378882839236472331=="
MIME-Version: 1.0
From: David Renz <sun.kisses.horizon at gmail.com>
Subject: Re: [Devel] ACPI table code of Lenovo G710 corrupted?
Date: Tue, 17 Nov 2015 23:18:16 +0100
Message-ID: <CAB=Lj3QwQYnOcwCxuZAmXsLLRvyKiagmzKJ9VzdhUU8CKzoOdA@mail.gmail.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E37D9975F4@ORSMSX112.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6378882839236472331==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Sorry, but how can't you see that this is related to the code stored in the
ACPI tables?

I extracted it and submitted the file to malwr.com, whose analysis shows
what this ACPI code would cause on a Windows system. And why / how can this
code cause all the stuff being visible under the sections "Files" and
"Registry"?


On Tue, Nov 17, 2015 at 10:57 PM, Moore, Robert <robert.moore(a)intel.com>
wrote:

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

--===============6378882839236472331==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj5Tb3JyeSwgYnV0IGhvdyBjYW4mIzM5O3QgeW91IHNlZSB0aGF0
IHRoaXMgaXMgcmVsYXRlZCB0byB0aGUgY29kZSBzdG9yZWQgaW4gdGhlIEFDUEkgdGFibGVzPzxi
cj48YnI+PC9kaXY+SSBleHRyYWN0ZWQgaXQgYW5kIHN1Ym1pdHRlZCB0aGUgZmlsZSB0byA8YSBo
cmVmPSJodHRwOi8vbWFsd3IuY29tIj5tYWx3ci5jb208L2E+LCB3aG9zZSBhbmFseXNpcyBzaG93
cyB3aGF0IHRoaXMgQUNQSSBjb2RlIHdvdWxkIGNhdXNlIG9uIGEgV2luZG93cyBzeXN0ZW0uIEFu
ZCB3aHkgLyBob3cgY2FuIHRoaXMgY29kZSBjYXVzZSBhbGwgdGhlIHN0dWZmIGJlaW5nIHZpc2li
bGUgdW5kZXIgdGhlIHNlY3Rpb25zICZxdW90O0ZpbGVzJnF1b3Q7IGFuZCAmcXVvdDtSZWdpc3Ry
eSZxdW90Oz88YnI+PGJyPjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj48YnI+PGRpdiBj
bGFzcz0iZ21haWxfcXVvdGUiPk9uIFR1ZSwgTm92IDE3LCAyMDE1IGF0IDEwOjU3IFBNLCBNb29y
ZSwgUm9iZXJ0IDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJlZj0ibWFpbHRvOnJvYmVydC5tb29y
ZUBpbnRlbC5jb20iIHRhcmdldD0iX2JsYW5rIj5yb2JlcnQubW9vcmVAaW50ZWwuY29tPC9hPiZn
dDs8L3NwYW4+IHdyb3RlOjxicj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxl
PSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxl
ZnQ6MWV4Ij5UaGVyZSBhcmUgc29tZSBpc3N1ZXMgd2l0aCB0aGlzIG1hY2hpbmUsIGJ1dCB0aGVz
ZSBhcmUgbW9yZSBsaW51eC1zcGVjaWZpYyBhbmQgSSBjYW7igJl0IGhlbHAgd2l0aCB0aG9zZS48
YnI+Cjxicj4KW8KgIMKgMTMuMTE1Njc1XSBBQ1BJIFdhcm5pbmc6IFN5c3RlbUlPIHJhbmdlIDB4
MDAwMDAwMDAwMDAwNTA0MC0weDAwMDAwMDAwMDAwMDUwNUYgY29uZmxpY3RzIHdpdGggT3BSZWdp
b24gMHgwMDAwMDAwMDAwMDA1MDQwLTB4MDAwMDAwMDAwMDAwNTA0RiAoXF9TQl8uUENJMC5TQlVT
LlNNQkkpICgyMDE1MDIwNC91dGFkZHJlc3MtMjU0KTxicj4KW8KgIMKgMTMuMTE1NjgzXSBBQ1BJ
OiBJZiBhbiBBQ1BJIGRyaXZlciBpcyBhdmFpbGFibGUgZm9yIHRoaXMgZGV2aWNlLCB5b3Ugc2hv
dWxkIHVzZSBpdCBpbnN0ZWFkIG9mIHRoZSBuYXRpdmUgZHJpdmVyPGJyPgo8YnI+ClvCoCDCoDEz
LjQyNjU3NF0gW0Zpcm13YXJlIEJ1Z106IEFDUEkoUEVHUCkgZGVmaW5lcyBfRE9EIGJ1dCBub3Qg
X0RPUzxicj4KW8KgIMKgMTMuNDI2OTAyXSBBQ1BJOiBWaWRlbyBEZXZpY2UgW1BFR1BdIChtdWx0
aS1oZWFkOiB5ZXPCoCByb206IHllc8KgIHBvc3Q6IG5vKTxicj4KW8KgIMKgMTMuNDI2OTA4XSBB
Q1BJIEVycm9yOiBbXF9TQl8uUENJMC5HRlgwLkREMDIuX0JDTF0gTmFtZXNwYWNlIGxvb2t1cCBm
YWlsdXJlLCBBRV9OT1RfRk9VTkQgKDIwMTUwMjA0L3BzYXJncy0zNTkpPGJyPgpbwqAgwqAxMy40
MjY5MTNdIEFDUEkgRXJyb3I6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5Q
Q0kwLlBFRzAuUEVHUC5ERDAyLl9CQ0xdIChOb2RlIGZmZmY4ODAyNTYwZjhlMzgpLCBBRV9OT1Rf
Rk9VTkQgKDIwMTUwMjA0L3BzcGFyc2UtNTM2KTxicj4KW8KgIMKgMTMuNDI2OTcyXSBpbnB1dDog
VmlkZW8gQnVzPGJyPgo8c3BhbiBjbGFzcz0iaW0gSE9FblpiIj48YnI+Cjxicj4KPGJyPgo8YnI+
CkZyb206IERldmVsIFttYWlsdG86PGEgaHJlZj0ibWFpbHRvOmRldmVsLWJvdW5jZXNAYWNwaWNh
Lm9yZyI+ZGV2ZWwtYm91bmNlc0BhY3BpY2Eub3JnPC9hPl0gT24gQmVoYWxmIE9mIERhdmlkIFJl
bno8YnI+ClNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDE3LCAyMDE1IDExOjMxIEFNPGJyPgpUbzog
PGEgaHJlZj0ibWFpbHRvOmRldmVsQGFjcGljYS5vcmciPmRldmVsQGFjcGljYS5vcmc8L2E+PGJy
PgpTdWJqZWN0OiBbRGV2ZWxdIEFDUEkgdGFibGUgY29kZSBvZiBMZW5vdm8gRzcxMCBjb3JydXB0
ZWQ/PGJyPgo8YnI+Cjwvc3Bhbj48ZGl2IGNsYXNzPSJIT0VuWmIiPjxkaXYgY2xhc3M9Img1Ij5I
ZWxsbyBldmVyeW9uZSw8YnI+Cjxicj4KSSBvd24gYSBMZW5vdm8gRzcxMCBub3RlYm9vayAoaGVy
ZSBvbmUgY2FuIHNlZSB0aGUgZXhhY3QgbW9kZWw6IDxhIGhyZWY9Imh0dHA6Ly9wb3N0aW1nLm9y
Zy9pbWFnZS9ybTV2amdrYjUvIiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRw
Oi8vcG9zdGltZy5vcmcvaW1hZ2Uvcm01dmpna2I1LzwvYT4pLCBhbmQgSSBmaW5kIHRoYXQgdGhl
IGNvZGUgc3RvcmVkIGluIGl0cyBBQ1BJIHRhYmxlcywgd2hpY2ggSSBleHRyYWN0ZWQgdXNpbmcg
dGhlIFdpbmRvd3MgdG9vbCAmcXVvdDtSZWFkJmFtcDtXcml0ZSBFdmVyeXRoaW5nJnF1b3Q7LCBs
ZWFkcyB0byBzdHJhbmdlL3N1c3BpY2lvdXMgcmVzdWx0cyB3aGVuIEkgc3VibWl0dGVkIGl0IHRv
IDxhIGhyZWY9Imh0dHA6Ly9tYWx3ci5jb20iIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxh
bmsiPm1hbHdyLmNvbTwvYT46PGJyPgo8YSBocmVmPSJodHRwczovL21hbHdyLmNvbS9hbmFseXNp
cy9NalprT0dVNFkyWm1NR001TkRRMU5qZzVPVGM0TlRWbE9UUTVOVGhpTW1ZLyIgcmVsPSJub3Jl
ZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9tYWx3ci5jb20vYW5hbHlzaXMvTWpaa09H
VTRZMlptTUdNNU5EUTFOamc1T1RjNE5UVmxPVFE1TlRoaU1tWS88L2E+PGJyPgo8YnI+CldoeSBz
aG91bGQgdGhlIEFDUEkgdGFibGUgY29kZSBsZWFkIHRvIHRoZSBkZXBsb3ltZW50IG9mIGZpbGVz
IHJlbGF0ZWQgdG8gTWljcm9zb2Z0IG9mZmljZSwgd2hpY2ggaXMgbm90IGV2ZW4gaW5zdGFsbGVk
IHJpZ2h0IGFmdGVyIGhhdmluZyBpbnN0YWxsZWQgV2luZG93cz88YnI+Cjxicj4KQW5kIGxvb2tp
bmcgYXQgdGhlIHNlY3Rpb24gJnF1b3Q7UmVnaXN0cnkga2V5cyZxdW90Ozo8YnI+CklzbiYjMzk7
dCBpdCBzdHJhbmdlIHRoYXQgdGhpcyBjb2RlIGNhdXNlcyBhbGwgdGhvc2UgcmVnaXN0cnkgY2hh
bmdlcywgZXNwZWNpYWxseSByZWdhcmRpbmcgYWxsIHRob3NlICZxdW90O0luUHJvY1NlcnZlcjMy
JnF1b3Q7IGVudHJpZXM/PGJyPgo8YnI+Cjxicj4KQ291bGQgYW55b25lLCB3aG8gb3ducyB0aGUg
c2FtZSBtb2RlbCwgdHJ5IHRvIGV4dHJhY3QgaXRzIEFDUEkgdGFibGVzIGFuZCBzdWJtaXQgdGhl
bSB0byA8YSBocmVmPSJodHRwOi8vbWFsd3IuY29tIiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0i
X2JsYW5rIj5tYWx3ci5jb208L2E+IGluIG9yZGVyIHRvIGNoZWNrIGlmIHRoaXMgbGVhZHMgdG8g
dGhlIHNhbWUgcmVzdWx0cz8gQW5kIGlmIG9uZSBzaG91bGQgdGhpbmtzIG9mIHRoaXMgY29kZSBi
ZWluZyBjb3JydXB0ZWQsIHRoZW4gSSBndWVzcyBpdCB3b3VsZCBiZSBhIGdvb2QgaWRlYSB0byBw
ZXJmb3JtIGEgY29tcGFyaXNvbiBpbiBvcmRlciB0byBmaW5kIGRpZmZlcmVuY2VzIGFuZCB0byBj
aGVjayB3aGF0IHRob3NlIHdvdWxkIGltcGx5Ljxicj4KSSB1cGxvYWRlZCB0aGUgZXh0cmFjdGVk
IEFDUEkgdGFibGVzIG9mIG15IG5vdGVib29rIG9uIEdvb2dsZURyaXZlOjxicj4KPGEgaHJlZj0i
aHR0cHM6Ly9kcml2ZS5nb29nbGUuY29tL2ZpbGUvZC8wQjYyWTVRa19yZGJXYW1sWFJYWkJTa0pR
WWtVL3ZpZXc/dXNwPXNoYXJpbmciIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPmh0
dHBzOi8vZHJpdmUuZ29vZ2xlLmNvbS9maWxlL2QvMEI2Mlk1UWtfcmRiV2FtbFhSWFpCU2tKUVlr
VS92aWV3P3VzcD1zaGFyaW5nPC9hPjxicj4KVW5kZXIgUGVudG9vIExpbnV4IChhbmQgYW55IG90
aGVyIExpbnV4IGRpc3RybyBJIHRyaWVkKSB0aGUgZG1lc2cgb3V0cHV0IGFsc28gc2hvd3MgcXVp
dGUgbWFueSBBQ1BJIHJlbGF0ZWQgZXJyb3IgbWVzc2FnZXMgKHN0YXJ0aW5nIGF0IHNlY29uZCAx
Myk6PGJyPgo8YSBocmVmPSJodHRwczovL2RyaXZlLmdvb2dsZS5jb20vZmlsZS9kLzBCNjJZNVFr
X3JkYldNR0pOVm5wWGNWQkliRUUvdmlldz91c3A9c2hhcmluZyIgcmVsPSJub3JlZmVycmVyIiB0
YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9kcml2ZS5nb29nbGUuY29tL2ZpbGUvZC8wQjYyWTVRa19y
ZGJXTUdKTlZucFhjVkJJYkVFL3ZpZXc/dXNwPXNoYXJpbmc8L2E+PGJyPgo8YnI+ClRoYW5rcyBp
biBhZHZhbmNlIGFuZCBiZXN0IHdpc2hlczxicj4KRGF2aWQ8YnI+Cjxicj4KwqA8YnI+Cjxicj4K
wqA8YnI+Cjxicj4KQmVzdCB3aXNoZXMgYW5kIHRoYW5rcyBpbiBhZHZhbmNlPGJyPgo8L2Rpdj48
L2Rpdj48L2Jsb2NrcXVvdGU+PC9kaXY+PGJyPjwvZGl2Pgo=

--===============6378882839236472331==--

