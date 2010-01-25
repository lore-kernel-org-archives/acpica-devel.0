Content-Type: multipart/mixed; boundary="===============0690599373240578339=="
MIME-Version: 1.0
From: Sean Shoufu Luo <luoshoufu at gmail.com>
Subject: [Devel] Help!!!! Help on wake up from S3.
Date: Mon, 25 Jan 2010 14:53:46 +0800
Message-ID: <316f56811001242253h3e7c0972o778ef0847b7c433f@mail.gmail.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0690599373240578339==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Maybe anyone here can give suggestion for me to wake up my client from S3.

I'm a newbieeeee on ACPI. But now I need support the feature STR
(suspend-to-RAM) on our unix-like OS. I transplanted ACPICA and implemented
OS service layer, then initialize core system, and I success to enumerate
all devices, success to put it into S1 and wake up from it. Also, I can soft
off by putting it into S5.

However, when I'm trying to put it into S3, once AcpiEnterSleepStatePrep()
called, I found, the light of power button  begin to flash, and when
AcpiEnterSleepState() called, the light still flash and the power consuming
goes down around 1.1w. Till now, everything looks well, and it looks like
Linux's. But the problem comes, when I pressed the power button at the
second time, I found the the light of power button become yellow but still
flash, lasting about 3/4 seconds, it turned to be green again, and monitor
is lighted, system goes up. But, it does't jump to the WakingVector that I
install with AcpiSetFirmwareWakingVecotr() before I put it into S3, instead,
it booted from IDE ...

I debug it by dump all values set to be registers  (including SLP_TYP &
SLP_EN) and compared with Linux's to found no difference. Also, I'm sure my
hardware is ACPI-compatible, and I use Xubuntu to verify it woks (STR).


Does anybody have same experience or any suggestion on it? Or how can I
found why it not jump to  waking vector ... any tool to spy what happened in
BIOS??

My ACPICA version is 20091214.


Any Suggestion will be greatly appreciate.


Sean
--

Happy is everything!

--===============0690599373240578339==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdj5NYXliZSBhbnlvbmUgaGVyZSBjYW4gZ2l2ZSBzdWdnZXN0aW9uIGZvciBtZSB0byB3YWtl
IHVwIG15IGNsaWVudCBmcm9tIFMzLqA8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkkmIzM5O20g
YSBuZXdiaWVlZWVlIG9uIEFDUEkuIEJ1dCBub3cgSSBuZWVkIHN1cHBvcnQgdGhlIGZlYXR1cmUg
U1RSIChzdXNwZW5kLXRvLVJBTSkgb24gb3VyIHVuaXgtbGlrZSBPUy6gSSB0cmFuc3BsYW50ZWQg
QUNQSUNBIGFuZCBpbXBsZW1lbnRlZCBPUyBzZXJ2aWNlIGxheWVyLCB0aGVuIGluaXRpYWxpemUg
Y29yZSBzeXN0ZW0sIGFuZCBJIHN1Y2Nlc3MgdG8gZW51bWVyYXRlIGFsbCBkZXZpY2VzLCBzdWNj
ZXNzIHRvIHB1dCBpdCBpbnRvIFMxIGFuZCB3YWtlIHVwIGZyb20gaXQuIEFsc28sIEkgY2FuIHNv
ZnQgb2ZmIGJ5IHB1dHRpbmcgaXQgaW50byBTNS48L2Rpdj4KPGRpdj48YnI+PC9kaXY+PGRpdj5I
b3dldmVyLCB3aGVuIEkmIzM5O22gdHJ5aW5nIHRvIHB1dCBpdCBpbnRvIFMzLCBvbmNlIEFjcGlF
bnRlclNsZWVwU3RhdGVQcmVwKCkgY2FsbGVkLCBJIGZvdW5kLCB0aGUgbGlnaHQgb2YgcG93ZXIg
YnV0dG9uIKBiZWdpbiB0byBmbGFzaCwgYW5kIHdoZW4gQWNwaUVudGVyU2xlZXBTdGF0ZSgpIGNh
bGxlZCwgdGhlIGxpZ2h0IHN0aWxsIGZsYXNoIGFuZCB0aGUgcG93ZXIgY29uc3VtaW5nIGdvZXMg
ZG93biBhcm91bmQgMS4xdy4gVGlsbCBub3csIGV2ZXJ5dGhpbmcgbG9va3Mgd2VsbCwgYW5kIGl0
IGxvb2tzIGxpa2UgTGludXgmIzM5O3MuIEJ1dCB0aGUgcHJvYmxlbSBjb21lcywgd2hlbiBJIHBy
ZXNzZWQgdGhlIHBvd2VyIGJ1dHRvbiBhdCB0aGUgc2Vjb25kIHRpbWUsIEkgZm91bmQgdGhlIHRo
ZSBsaWdodCBvZiBwb3dlciBidXR0b24gYmVjb21lIHllbGxvdyBidXQgc3RpbGwgZmxhc2gsIGxh
c3RpbmcgYWJvdXQgMy80IHNlY29uZHMsIGl0IHR1cm5lZCB0byBiZSBncmVlbiBhZ2FpbiwgYW5k
IG1vbml0b3IgaXMgbGlnaHRlZCwgc3lzdGVtIGdvZXMgdXAuIEJ1dCwgaXQgZG9lcyYjMzk7dCBq
dW1wIHRvIHRoZSBXYWtpbmdWZWN0b3IgdGhhdCBJIGluc3RhbGwgd2l0aCBBY3BpU2V0RmlybXdh
cmVXYWtpbmdWZWNvdHIoKSBiZWZvcmUgSSBwdXQgaXQgaW50byBTMywgaW5zdGVhZCwgaXQgYm9v
dGVkIGZyb20gSURFIC4uLjwvZGl2Pgo8ZGl2Pjxicj48L2Rpdj48ZGl2PkkgZGVidWcgaXQgYnkg
ZHVtcCBhbGwgdmFsdWVzIHNldCB0byBiZSByZWdpc3RlcnMgoChpbmNsdWRpbmcgU0xQX1RZUCAm
YW1wOyBTTFBfRU4pIGFuZCBjb21wYXJlZCB3aXRoIExpbnV4JiMzOTtzIHRvIGZvdW5kIG5vIGRp
ZmZlcmVuY2UuIEFsc28sIEkmIzM5O20gc3VyZSBteSBoYXJkd2FyZSBpcyBBQ1BJLWNvbXBhdGli
bGUsIGFuZCBJIHVzZSBYdWJ1bnR1IHRvIHZlcmlmeSBpdCB3b2tzIChTVFIpLjwvZGl2Pgo8ZGl2
Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkRvZXMgYW55Ym9keSBoYXZlIHNhbWUgZXhw
ZXJpZW5jZSBvciBhbnkgc3VnZ2VzdGlvbiBvbiBpdD8gT3IgaG93IGNhbiBJIGZvdW5kIHdoeSBp
dCBub3QganVtcCB0byCgd2FraW5nIHZlY3RvciAuLi4gYW55IHRvb2wgdG8gc3B5IHdoYXQgaGFw
cGVuZWQgaW4gQklPUz8/PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5NeSBBQ1BJQ0EgdmVyc2lv
biBpcyAyMDA5MTIxNC6gPC9kaXY+CjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+
QW55IFN1Z2dlc3Rpb24gd2lsbCBiZSBncmVhdGx5oGFwcHJlY2lhdGUuPC9kaXY+PGRpdj48YnI+
PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5TZWFuPC9kaXY+PGRpdj4tLTwvZGl2PjxkaXY+PGJy
PjwvZGl2PjxkaXY+SGFwcHkgaXMgZXZlcnl0aGluZyE8L2Rpdj4K

--===============0690599373240578339==--

