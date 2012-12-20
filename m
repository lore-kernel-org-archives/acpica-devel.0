Content-Type: multipart/mixed; boundary="===============8288540841464153344=="
MIME-Version: 1.0
From: Laszlo Ersek <lersek at redhat.com>
Subject: [Devel] sleep state parsing in acpica
Date: Thu, 20 Dec 2012 14:25:22 +0100
Message-ID: <50D311C2.4080604@redhat.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8288540841464153344==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Robert, Jordan,

the S3 and S4 packages prepared by OVMF / edk2 commit [1] (svn rev
14003) look like

      Name (\_S3, Package (0x01)
      {
          0x00000001
      })
      Name (\_S4, Package (0x01)
      {
          0x00000002
      })

They are refused by the following ACPICA code section (please excuse the
wide listing):

repo: git://github.com/otcshare/acpica.git
file: source/components/hardware/hwxface.c

4fa895bc (Robert Moore 2008-11-19 13:15:10 -0800 635)     /*
4fa895bc (Robert Moore 2008-11-19 13:15:10 -0800 636)      * The package mu=
st have at least two elements. NOTE (March 2005): This
4fa895bc (Robert Moore 2008-11-19 13:15:10 -0800 637)      * goes against t=
he current ACPI spec which defines this object as a
4fa895bc (Robert Moore 2008-11-19 13:15:10 -0800 638)      * package with o=
ne encoded DWORD element. However, existing practice
4fa895bc (Robert Moore 2008-11-19 13:15:10 -0800 639)      * by BIOS vendor=
s seems to be to have 2 or more elements, at least
4fa895bc (Robert Moore 2008-11-19 13:15:10 -0800 640)      * one per sleep =
type (A/B).
4fa895bc (Robert Moore 2008-11-19 13:15:10 -0800 641)      */
4fa895bc (Robert Moore 2008-11-19 13:15:10 -0800 642)     else if (Info->Re=
turnObject->Package.Count < 2)
4fa895bc (Robert Moore 2008-11-19 13:15:10 -0800 643)     {
4fa895bc (Robert Moore 2008-11-19 13:15:10 -0800 644)         ACPI_ERROR ((=
AE_INFO,
4fa895bc (Robert Moore 2008-11-19 13:15:10 -0800 645)             "Sleep St=
ate return package does not have at least two elements"));
4fa895bc (Robert Moore 2008-11-19 13:15:10 -0800 646)         Status =3D AE=
_AML_NO_OPERAND;
4fa895bc (Robert Moore 2008-11-19 13:15:10 -0800 647)     }

I ran into the problem with the 20121217.16 Fedora 18 nightly build:

[    0.000000] Linux version 3.6.10-4.fc18.x86_64 (mockbuild@) (gcc version=
 4.7.2 20121109 (Red Hat 4.7.2-8) (GCC) ) #1 SMP Tue Dec 11 18:01:27 UTC 20=
12

[    0.064483] ACPI: Interpreter enabled
[    0.064483] ACPI: (supports S0ACPI Error: Sleep State return package doe=
s not have at least two elements (20120711/hwxface-511)
[    0.064483] ACPI Exception: AE_AML_NO_OPERAND, While evaluating SleepSta=
te [\_S3_], bad Sleep object ffff880119a33c18 type Package (20120711/hwxfac=
e-543)
[    0.064483] ACPI Error: Sleep State return package does not have at leas=
t two elements (20120711/hwxface-511)
[    0.064483] ACPI Exception: AE_AML_NO_OPERAND, While evaluating SleepSta=
te [\_S4_], bad Sleep object ffff880119a33cf0 type Package (20120711/hwxfac=
e-543)
[    0.064483]  S5)


Should I attempt a patch for ACPICA (see the attachment), or is it not
worth the hassle and I should just fixup the AML generation in OVMF
(split the DWord into Bytes)?

(Please keep me CC'd, I'm not subscribed to <devel(a)acpica.org>.)

Thanks
Laszlo

[1] http://tianocore.git.sourceforge.net/git/gitweb.cgi?p=3Dtianocore/edk2;=
a=3Dcommitdiff;h=3D14430c55c8d0e9a8487c2c74155e63299632ef5e

--===============8288540841464153344==
Content-Type: text/plain
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-AcpiGetSleepTypeData-accept-package-with-one-element.patch"

PkZyb20gOWQyOGNkYTRlNzk1MmI0ODE4YTcyYWZkY2ZlY2M1NmVkNjg3YzY4MCBNb24gU2VwIDE3
IDAwOjAwOjAwIDIwMDEKRnJvbTogTGFzemxvIEVyc2VrIDxsZXJzZWtAcmVkaGF0LmNvbT4KRGF0
ZTogVGh1LCAyMCBEZWMgMjAxMiAxNDowODo1MSArMDEwMApTdWJqZWN0OiBbUEFUQ0hdIEFjcGlH
ZXRTbGVlcFR5cGVEYXRhOiBhY2NlcHQgcGFja2FnZSB3aXRoIG9uZSBlbGVtZW50CgoKU2lnbmVk
LW9mZi1ieTogTGFzemxvIEVyc2VrIDxsZXJzZWtAcmVkaGF0LmNvbT4KLS0tCiBzb3VyY2UvY29t
cG9uZW50cy9oYXJkd2FyZS9od3hmYWNlLmMgfCAgIDY0ICsrKysrKysrKysrKysrKysrKystLS0t
LS0tLS0tLS0tLQogMSBmaWxlcyBjaGFuZ2VkLCAzNyBpbnNlcnRpb25zKCspLCAyNyBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9zb3VyY2UvY29tcG9uZW50cy9oYXJkd2FyZS9od3hmYWNlLmMg
Yi9zb3VyY2UvY29tcG9uZW50cy9oYXJkd2FyZS9od3hmYWNlLmMKaW5kZXggYWNlODI1MS4uYmNk
YzJjYSAxMDA2NDQKLS0tIGEvc291cmNlL2NvbXBvbmVudHMvaGFyZHdhcmUvaHd4ZmFjZS5jCisr
KyBiL3NvdXJjZS9jb21wb25lbnRzL2hhcmR3YXJlL2h3eGZhY2UuYwpAQCAtNjMzLDQxICs2MzMs
NTEgQEAgQWNwaUdldFNsZWVwVHlwZURhdGEgKAogICAgIH0KIAogICAgIC8qCi0gICAgICogVGhl
IHBhY2thZ2UgbXVzdCBoYXZlIGF0IGxlYXN0IHR3byBlbGVtZW50cy4gTk9URSAoTWFyY2ggMjAw
NSk6IFRoaXMKLSAgICAgKiBnb2VzIGFnYWluc3QgdGhlIGN1cnJlbnQgQUNQSSBzcGVjIHdoaWNo
IGRlZmluZXMgdGhpcyBvYmplY3QgYXMgYQotICAgICAqIHBhY2thZ2Ugd2l0aCBvbmUgZW5jb2Rl
ZCBEV09SRCBlbGVtZW50LiBIb3dldmVyLCBleGlzdGluZyBwcmFjdGljZQotICAgICAqIGJ5IEJJ
T1MgdmVuZG9ycyBzZWVtcyB0byBiZSB0byBoYXZlIDIgb3IgbW9yZSBlbGVtZW50cywgYXQgbGVh
c3QKLSAgICAgKiBvbmUgcGVyIHNsZWVwIHR5cGUgKEEvQikuCisgICAgICogVGhlIGN1cnJlbnQg
QUNQSSBzcGVjICh2IDUuMCkgZGVmaW5lcyB0aGlzIG9iamVjdCBhcyBhIHBhY2thZ2Ugd2l0aCBv
bmUKKyAgICAgKiBlbmNvZGVkIERXT1JEIGVsZW1lbnQuCisgICAgICoKKyAgICAgKiBFeGlzdGlu
ZyBwcmFjdGljZSBieSBCSU9TIHZlbmRvcnMgc2VlbXMgdG8gYmUgdG8gaGF2ZSAyIG9yIG1vcmUK
KyAgICAgKiBlbGVtZW50cywgYXQgbGVhc3Qgb25lIHBlciBzbGVlcCB0eXBlIChBL0IpLgogICAg
ICAqLwotICAgIGVsc2UgaWYgKEluZm8tPlJldHVybk9iamVjdC0+UGFja2FnZS5Db3VudCA8IDIp
Ci0gICAgewotICAgICAgICBBQ1BJX0VSUk9SICgoQUVfSU5GTywKLSAgICAgICAgICAgICJTbGVl
cCBTdGF0ZSByZXR1cm4gcGFja2FnZSBkb2VzIG5vdCBoYXZlIGF0IGxlYXN0IHR3byBlbGVtZW50
cyIpKTsKLSAgICAgICAgU3RhdHVzID0gQUVfQU1MX05PX09QRVJBTkQ7Ci0gICAgfQogCi0gICAg
LyogVGhlIGZpcnN0IHR3byBlbGVtZW50cyBtdXN0IGJvdGggYmUgb2YgdHlwZSBJbnRlZ2VyICov
Ci0KLSAgICBlbHNlIGlmICgoKEluZm8tPlJldHVybk9iamVjdC0+UGFja2FnZS5FbGVtZW50c1sw
XSktPkNvbW1vbi5UeXBlCi0gICAgICAgICAgICAgICAgIT0gQUNQSV9UWVBFX0lOVEVHRVIpIHx8
Ci0gICAgICAgICAgICAgKChJbmZvLT5SZXR1cm5PYmplY3QtPlBhY2thZ2UuRWxlbWVudHNbMV0p
LT5Db21tb24uVHlwZQotICAgICAgICAgICAgICAgICE9IEFDUElfVFlQRV9JTlRFR0VSKSkKKyAg
ICBlbHNlIGlmIChJbmZvLT5SZXR1cm5PYmplY3QtPlBhY2thZ2UuQ291bnQgPT0gMCkKICAgICB7
CiAgICAgICAgIEFDUElfRVJST1IgKChBRV9JTkZPLAotICAgICAgICAgICAgIlNsZWVwIFN0YXRl
IHJldHVybiBwYWNrYWdlIGVsZW1lbnRzIGFyZSBub3QgYm90aCBJbnRlZ2VycyAiCi0gICAgICAg
ICAgICAiKCVzLCAlcykiLAotICAgICAgICAgICAgQWNwaVV0R2V0T2JqZWN0VHlwZU5hbWUgKElu
Zm8tPlJldHVybk9iamVjdC0+UGFja2FnZS5FbGVtZW50c1swXSksCi0gICAgICAgICAgICBBY3Bp
VXRHZXRPYmplY3RUeXBlTmFtZSAoSW5mby0+UmV0dXJuT2JqZWN0LT5QYWNrYWdlLkVsZW1lbnRz
WzFdKSkpOwotICAgICAgICBTdGF0dXMgPSBBRV9BTUxfT1BFUkFORF9UWVBFOworICAgICAgICAg
ICAgIlNsZWVwIFN0YXRlIHJldHVybiBwYWNrYWdlIGRvZXMgbm90IGhhdmUgZWxlbWVudHMiKSk7
CisgICAgICAgIFN0YXR1cyA9IEFFX0FNTF9OT19PUEVSQU5EOwogICAgIH0KICAgICBlbHNlCiAg
ICAgewotICAgICAgICAvKiBWYWxpZCBfU3hfIHBhY2thZ2Ugc2l6ZSwgdHlwZSwgYW5kIHZhbHVl
ICovCisgICAgICAgIHVuaW9uIGFjcGlfb3BlcmFuZF9vYmplY3QgKipFbGVtZW50czsKKworICAg
ICAgICBFbGVtZW50cyA9IEluZm8tPlJldHVybk9iamVjdC0+UGFja2FnZS5FbGVtZW50czsKIAot
ICAgICAgICAqU2xlZXBUeXBlQSA9IChVSU5UOCkKLSAgICAgICAgICAgIChJbmZvLT5SZXR1cm5P
YmplY3QtPlBhY2thZ2UuRWxlbWVudHNbMF0pLT5JbnRlZ2VyLlZhbHVlOwotICAgICAgICAqU2xl
ZXBUeXBlQiA9IChVSU5UOCkKLSAgICAgICAgICAgIChJbmZvLT5SZXR1cm5PYmplY3QtPlBhY2th
Z2UuRWxlbWVudHNbMV0pLT5JbnRlZ2VyLlZhbHVlOworICAgICAgICBpZiAoRWxlbWVudHNbMF0t
PkNvbW1vbi5UeXBlICE9IEFDUElfVFlQRV9JTlRFR0VSKQorICAgICAgICB7CisgICAgICAgICAg
ICBBQ1BJX0VSUk9SICgoQUVfSU5GTywKKyAgICAgICAgICAgICAgICAiMXN0IGVsZW1lbnQgaW4g
U2xlZXAgU3RhdGUgcmV0dXJuIHBhY2thZ2UgaXMgbm90IEludGVnZXIgIgorICAgICAgICAgICAg
ICAgICIoJXMpIiwKKyAgICAgICAgICAgICAgICBBY3BpVXRHZXRPYmplY3RUeXBlTmFtZSAoRWxl
bWVudHNbMF0pKSk7CisgICAgICAgICAgICBTdGF0dXMgPSBBRV9BTUxfT1BFUkFORF9UWVBFOwor
ICAgICAgICB9CisgICAgICAgIGVsc2UgaWYgKEluZm8tPlJldHVybk9iamVjdC0+UGFja2FnZS5D
b3VudCA9PSAxKQorICAgICAgICB7CisgICAgICAgICAgICAqU2xlZXBUeXBlQSA9IChVSU5UOCkg
IEVsZW1lbnRzWzBdLT5JbnRlZ2VyLlZhbHVlOworICAgICAgICAgICAgKlNsZWVwVHlwZUIgPSAo
VUlOVDgpIChFbGVtZW50c1swXS0+SW50ZWdlci5WYWx1ZSA+PiA4KTsKKyAgICAgICAgfQorICAg
ICAgICBlbHNlIGlmIChFbGVtZW50c1sxXS0+Q29tbW9uLlR5cGUgIT0gQUNQSV9UWVBFX0lOVEVH
RVIpCisgICAgICAgIHsKKyAgICAgICAgICAgIEFDUElfRVJST1IgKChBRV9JTkZPLAorICAgICAg
ICAgICAgICAgICIybmQgZWxlbWVudCBpbiBTbGVlcCBTdGF0ZSByZXR1cm4gcGFja2FnZSBpcyBu
b3QgSW50ZWdlciAiCisgICAgICAgICAgICAgICAgIiglcykiLAorICAgICAgICAgICAgICAgIEFj
cGlVdEdldE9iamVjdFR5cGVOYW1lIChFbGVtZW50c1sxXSkpKTsKKyAgICAgICAgICAgIFN0YXR1
cyA9IEFFX0FNTF9PUEVSQU5EX1RZUEU7CisgICAgICAgIH0KKyAgICAgICAgZWxzZQorICAgICAg
ICB7CisgICAgICAgICAgICAqU2xlZXBUeXBlQSA9IChVSU5UOCkgRWxlbWVudHNbMF0tPkludGVn
ZXIuVmFsdWU7CisgICAgICAgICAgICAqU2xlZXBUeXBlQiA9IChVSU5UOCkgRWxlbWVudHNbMV0t
PkludGVnZXIuVmFsdWU7CisgICAgICAgIH0KICAgICB9CiAKICAgICBpZiAoQUNQSV9GQUlMVVJF
IChTdGF0dXMpKQotLSAKMS43LjEKCg==

--===============8288540841464153344==--

