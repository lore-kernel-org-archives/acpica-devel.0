Content-Type: multipart/mixed; boundary="===============3593026203662615312=="
MIME-Version: 1.0
From: Sascha Wildner <swildner at gmail.com>
Subject: [Devel] Clarification request about AcpiDbgLevel and
 AcpiGbl_EnableAmlDebugObject
Date: Wed, 14 May 2014 22:53:30 +0200
Message-ID: <CABC13nEwZqrCUwfKCH_X08R34OhMA-H+dLMehPfYvFp5syTs8A@mail.gmail.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3593026203662615312==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

here is an issue I don't understand.

* In acpixf.h, if ACPI_DEBUG_OUTPUT is not set, AcpiDbgLevel is defined to
ACPI_NORMAL_DEFAULT, and ACPI_LV_DEBUG_OBJECT is part of that.

* In exdebug.c, function AcpiExDoDebugObject(), it returns early without
printing when neither AcpiGbl_EnableAmlDebugObject is set nor
ACPI_LV_DEBUG_OBJECT is in AcpiDbgLevel, else it proceeds with printing.
But by default, ACPI_LV_DEBUG_OBJECT is in AcpiDbgLevel (see above).
AcpiExDoDebugObject() is the only place where AcpiGbl_EnableAmlDebugObject
is referenced.

The reference manual says (at least that's how I read it) that when
AcpiGbl_EnableAmlDebugObject is FALSE, output from the AML "Debug Object"
is disabled, but given the definition of ACPI_NORMAL_DEFAULT together with
the check in AcpiExDoDebugObject(), that doesn't seem to be the case.

So my question is: How should the host OS properly handle this? I saw that
FreeBSD for example initializes AcpiDbgLevel to 0 (when their ACPI_DEBUG
switch isn't set) but the reference manual doesn't mention that anything
other than AcpiGbl_EnableAmlDebugObject being FALSE is necessary.

Or am I missing something?

Sascha

--===============3593026203662615312==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGVsbG8sPGRpdj48YnI+PC9kaXY+PGRpdj5oZXJlIGlzIGFuIGlzc3Vl
IEkgZG9uJiMzOTt0IHVuZGVyc3RhbmQuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj4qIEluIGFj
cGl4Zi5oLCBpZiBBQ1BJX0RFQlVHX09VVFBVVCBpcyBub3Qgc2V0LCBBY3BpRGJnTGV2ZWwgaXMg
ZGVmaW5lZCB0byBBQ1BJX05PUk1BTF9ERUZBVUxULCBhbmQgQUNQSV9MVl9ERUJVR19PQkpFQ1Qg
aXMgcGFydCBvZiB0aGF0LjwvZGl2Pgo8ZGl2Pjxicj48L2Rpdj48ZGl2PiogSW4gZXhkZWJ1Zy5j
LCBmdW5jdGlvbiBBY3BpRXhEb0RlYnVnT2JqZWN0KCksIGl0IHJldHVybnMgZWFybHkgd2l0aG91
dCBwcmludGluZyB3aGVuIG5laXRoZXIgQWNwaUdibF9FbmFibGVBbWxEZWJ1Z09iamVjdCBpcyBz
ZXQgbm9yIEFDUElfTFZfREVCVUdfT0JKRUNUIGlzIGluIEFjcGlEYmdMZXZlbCwgZWxzZSBpdCBw
cm9jZWVkcyB3aXRoIHByaW50aW5nLiBCdXQgYnkgZGVmYXVsdCwgQUNQSV9MVl9ERUJVR19PQkpF
Q1QgaXMgaW4gQWNwaURiZ0xldmVsIChzZWUgYWJvdmUpLiBBY3BpRXhEb0RlYnVnT2JqZWN0KCkg
aXMgdGhlIG9ubHkgcGxhY2Ugd2hlcmUgQWNwaUdibF9FbmFibGVBbWxEZWJ1Z09iamVjdCBpcyBy
ZWZlcmVuY2VkLjwvZGl2Pgo8ZGl2Pjxicj48L2Rpdj48ZGl2PlRoZSByZWZlcmVuY2UgbWFudWFs
IHNheXMgKGF0IGxlYXN0IHRoYXQmIzM5O3MgaG93IEkgcmVhZCBpdCkgdGhhdCB3aGVuIEFjcGlH
YmxfRW5hYmxlQW1sRGVidWdPYmplY3QgaXMgRkFMU0UsIG91dHB1dCBmcm9tIHRoZSBBTUwgJnF1
b3Q7RGVidWcgT2JqZWN0JnF1b3Q7IGlzIGRpc2FibGVkLCBidXQgZ2l2ZW4gdGhlIGRlZmluaXRp
b24gb2YgQUNQSV9OT1JNQUxfREVGQVVMVCB0b2dldGhlciB3aXRoIHRoZSBjaGVjayBpbiBBY3Bp
RXhEb0RlYnVnT2JqZWN0KCksIHRoYXQgZG9lc24mIzM5O3Qgc2VlbSB0byBiZSB0aGUgY2FzZS48
L2Rpdj4KPGRpdj48YnI+PC9kaXY+PGRpdj5TbyBteSBxdWVzdGlvbiBpczogSG93IHNob3VsZCB0
aGUgaG9zdCBPUyBwcm9wZXJseSBoYW5kbGUgdGhpcz8gSSBzYXcgdGhhdCBGcmVlQlNEIGZvciBl
eGFtcGxlIGluaXRpYWxpemVzIEFjcGlEYmdMZXZlbCB0byAwICh3aGVuIHRoZWlyIEFDUElfREVC
VUcgc3dpdGNoIGlzbiYjMzk7dCBzZXQpIGJ1dCB0aGUgcmVmZXJlbmNlIG1hbnVhbCBkb2VzbiYj
Mzk7dCBtZW50aW9uIHRoYXQgYW55dGhpbmcgb3RoZXIgdGhhbiBBY3BpR2JsX0VuYWJsZUFtbERl
YnVnT2JqZWN0IGJlaW5nIEZBTFNFIGlzIG5lY2Vzc2FyeS48L2Rpdj4KPGRpdj48YnI+PC9kaXY+
PGRpdj5PciBhbSBJIG1pc3Npbmcgc29tZXRoaW5nPzwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+
U2FzY2hhPC9kaXY+PGRpdj48YnI+PC9kaXY+PC9kaXY+Cg==

--===============3593026203662615312==--

