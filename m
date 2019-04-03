Content-Type: multipart/mixed; boundary="===============4880174268886426694=="
MIME-Version: 1.0
From: Patrick Georgi <pgeorgi at google.com>
Subject: [Devel] Field Offset constraints
Date: Wed, 03 Apr 2019 09:14:17 +0200
Message-ID: <CAE-gjdWGiG2s31qRr4yZv2ZUs1BNdE5af1eBVmCiuvRSZPhbqA@mail.gmail.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4880174268886426694==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi everybody,

at coreboot[1] we use iasl to compile static ASL for various hardware.
Recent versions of iasl emit a notice for redundant Offset statements in
Fields, apparently with the expectation that they shouldn't exist.

This poses a problem for us since we're sometimes using Offset as a guard,
making sure that we didn't inadvertedly shifted fields around (too much),
with the expectation that these were redundant in the "good" case.

Since that operator wasn't really suited for that purpose anyway, and now
throws warnings (which we try to avoid in our builds), are there plans to
add some keyword for compile time constraints checks, or any objections to
having such a feature (should one of us decide to implement it)?

Maybe something like

Field (NAME, ByteAcc, Lock, Preserve)
{
    Item(FIE1, 0, 0, 8)
    Item(FIE2, 1, 0, 8)
    Offset(0x10)
    Item(FIE3, 0x10, 0, 8)
}

in which Item(Name, Byte, Bit, Length) would compile to "Name, Length,"
inside a field after ensuring that the byte and bit offsets match the
current location.

Thoughts?

Thanks,
Patrick Georgi

[1] https://www.coreboot.org/
-- =

Google Germany GmbH, ABC-Str. 19, 20354 Hamburg
Registergericht und -nummer: Hamburg, HRB 86891, Sitz der Gesellschaft:
Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado

--===============4880174268886426694==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGkgZXZlcnlib2R5LDxkaXY+PGJyPjwvZGl2PjxkaXY+YXQgY29yZWJv
b3RbMV0gd2UgdXNlIGlhc2wgdG8gY29tcGlsZSBzdGF0aWMgQVNMIGZvciB2YXJpb3VzIGhhcmR3
YXJlLiBSZWNlbnQgdmVyc2lvbnMgb2YgaWFzbCBlbWl0IGEgbm90aWNlIGZvciByZWR1bmRhbnQg
T2Zmc2V0IHN0YXRlbWVudHMgaW4gRmllbGRzLCBhcHBhcmVudGx5IHdpdGggdGhlIGV4cGVjdGF0
aW9uIHRoYXQgdGhleSBzaG91bGRuJiMzOTt0IGV4aXN0LjwvZGl2PjxkaXY+PGJyPjwvZGl2Pjxk
aXY+VGhpcyBwb3NlcyBhIHByb2JsZW0gZm9yIHVzIHNpbmNlIHdlJiMzOTtyZSBzb21ldGltZXMg
dXNpbmcgT2Zmc2V0IGFzIGEgZ3VhcmQsIG1ha2luZyBzdXJlIHRoYXQgd2UgZGlkbiYjMzk7dCBp
bmFkdmVydGVkbHkgc2hpZnRlZCBmaWVsZHMgYXJvdW5kICh0b28gbXVjaCksIHdpdGggdGhlIGV4
cGVjdGF0aW9uIHRoYXQgdGhlc2Ugd2VyZSByZWR1bmRhbnQgaW4gdGhlICZxdW90O2dvb2QmcXVv
dDsgY2FzZS48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlNpbmNlIHRoYXQgb3BlcmF0b3Igd2Fz
biYjMzk7dCByZWFsbHkgc3VpdGVkIGZvciB0aGF0IHB1cnBvc2UgYW55d2F5LCBhbmQgbm93IHRo
cm93cyB3YXJuaW5ncyAod2hpY2ggd2UgdHJ5IHRvIGF2b2lkIGluIG91ciBidWlsZHMpLCBhcmUg
dGhlcmUgcGxhbnMgdG8gYWRkIHNvbWUga2V5d29yZCBmb3IgY29tcGlsZSB0aW1lIGNvbnN0cmFp
bnRzIGNoZWNrcywgb3IgYW55IG9iamVjdGlvbnMgdG8gaGF2aW5nIHN1Y2ggYSBmZWF0dXJlIChz
aG91bGQgb25lIG9mIHVzIGRlY2lkZSB0byBpbXBsZW1lbnQgaXQpPzxiciBjbGVhcj0iYWxsIj48
ZGl2Pjxicj48L2Rpdj48ZGl2Pk1heWJlIHNvbWV0aGluZyBsaWtlPC9kaXY+PGRpdj48YnI+PC9k
aXY+PGRpdj5GaWVsZCAoTkFNRSwgQnl0ZUFjYywgTG9jaywgUHJlc2VydmUpPC9kaXY+PGRpdj57
PC9kaXY+PGRpdj7CoCDCoCBJdGVtKEZJRTEsIDAsIDAsIDgpPC9kaXY+PGRpdj7CoCDCoCBJdGVt
KEZJRTIsIDEsIDAsIDgpPC9kaXY+PGRpdj7CoCDCoCBPZmZzZXQoMHgxMCk8L2Rpdj48ZGl2PsKg
IMKgIEl0ZW0oRklFMywgMHgxMCwgMCwgOCk8L2Rpdj48ZGl2Pn08L2Rpdj48ZGl2Pjxicj48L2Rp
dj48ZGl2PmluIHdoaWNoIEl0ZW0oTmFtZSwgQnl0ZSwgQml0LCBMZW5ndGgpIHdvdWxkIGNvbXBp
bGUgdG8gJnF1b3Q7TmFtZSwgTGVuZ3RoLCZxdW90OyBpbnNpZGUgYSBmaWVsZCBhZnRlciBlbnN1
cmluZyB0aGF0IHRoZSBieXRlIGFuZCBiaXQgb2Zmc2V0cyBtYXRjaCB0aGUgY3VycmVudCBsb2Nh
dGlvbi48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlRob3VnaHRzPzwvZGl2PjxkaXY+PGJyPjwv
ZGl2PjxkaXY+VGhhbmtzLDwvZGl2PjxkaXY+UGF0cmljayBHZW9yZ2k8L2Rpdj48ZGl2Pjxicj48
L2Rpdj48ZGl2PlsxXSA8YSBocmVmPSJodHRwczovL3d3dy5jb3JlYm9vdC5vcmcvIiB0YXJnZXQ9
Il9ibGFuayI+aHR0cHM6Ly93d3cuY29yZWJvb3Qub3JnLzwvYT48L2Rpdj4tLSA8YnI+PGRpdiBk
aXI9Imx0ciIgY2xhc3M9Im1fNDk0MTIyODgzMjQ2MzgwNDY2N2dtYWlsX3NpZ25hdHVyZSIgZGF0
YS1zbWFydG1haWw9ImdtYWlsX3NpZ25hdHVyZSI+R29vZ2xlIEdlcm1hbnkgR21iSCwgQUJDLVN0
ci4gMTksIDIwMzU0IEhhbWJ1cmc8YnI+UmVnaXN0ZXJnZXJpY2h0IHVuZCAtbnVtbWVyOiBIYW1i
dXJnLCBIUkIgODY4OTEsIFNpdHogZGVyIEdlc2VsbHNjaGFmdDogSGFtYnVyZzxicj5HZXNjaMOk
ZnRzZsO8aHJlcjogUGF1bCBNYW5pY2xlLCBIYWxpbWFoIERlTGFpbmUgUHJhZG88L2Rpdj48L2Rp
dj48L2Rpdj4K

--===============4880174268886426694==--

