Content-Type: multipart/mixed; boundary="===============8244794140226436752=="
MIME-Version: 1.0
From: Sean Shoufu Luo <luoshoufu at gmail.com>
Subject: [Devel] Battery Presence
Date: Tue, 06 Jul 2010 10:29:48 +0800
Message-ID: <AANLkTikgUUV_E8Q5uFkTadZljGD2QWDTQoReSvzMIapl@mail.gmail.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8244794140226436752==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Previously, I have ported ACPICA to our system. These days, I wonna to write
ACPI driver for battery with Netbsd's version as guide, but I found when I
initialized battery driver, it would issue a command to query _STA for
battery presence. But its return value is 0xf, that indicates PRESENCE bit
is not set (0x00000010).  I'm puzzled. I'm using battery ....Why the battery
not present?
Anyone can give any hint?

Thanks,
Sean

--===============8244794140226436752==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

UHJldmlvdXNseSwgSSBoYXZlIHBvcnRlZCBBQ1BJQ0EgdG8gb3VyIHN5c3RlbS4gVGhlc2UgZGF5
cywgSSB3b25uYSB0byB3cml0ZSBBQ1BJIGRyaXZlciBmb3IgYmF0dGVyeSB3aXRoIE5ldGJzZCYj
Mzk7cyB2ZXJzaW9uIGFzIGd1aWRlLCBidXQgSSBmb3VuZCB3aGVuIEkgaW5pdGlhbGl6ZWQgYmF0
dGVyeSBkcml2ZXIsIGl0IHdvdWxkIGlzc3VlIGEgY29tbWFuZCB0byBxdWVyeSBfU1RBIGZvciBi
YXR0ZXJ5IHByZXNlbmNlLiBCdXQgaXRzIHJldHVybiB2YWx1ZSBpcyAweGYsIHRoYXQgaW5kaWNh
dGVzIFBSRVNFTkNFIGJpdCBpcyBub3Qgc2V0ICgweDAwMDAwMDEwKS4goEkmIzM5O20gcHV6emxl
ZC4gSSYjMzk7bSB1c2luZyBiYXR0ZXJ5IC4uLi5XaHkgdGhlIGJhdHRlcnkgbm90IHByZXNlbnQ/
oDxkaXY+CkFueW9uZSBjYW4gZ2l2ZSBhbnkgaGludD88L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2
PlRoYW5rcyw8L2Rpdj48ZGl2PlNlYW48L2Rpdj4K

--===============8244794140226436752==--

