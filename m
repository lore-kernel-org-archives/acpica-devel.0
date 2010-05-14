Content-Type: multipart/mixed; boundary="===============4561958869846536689=="
MIME-Version: 1.0
From: Stefan Reinauer <stefan.reinauer at coresystems.de>
Subject: [Devel] [PATCH] Fix iasl on Mac OS X
Date: Fri, 14 May 2010 18:53:16 +0200
Message-ID: <4BED7FFC.6050202@coresystems.de>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4561958869846536689==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Mac OS X does not support unnamed semaphores, which breaks iasl. The
attached patch tries a named semaphore in case sema_init claims that it
is not implemented.

Best regards,

Stefan Reinauer

-- =

coresystems GmbH =E2=80=A2 Brahmsstr. 16 =E2=80=A2 D-79104 Freiburg i. Br.
      Tel.: +49 761 7668825 =E2=80=A2 Fax: +49 761 7664613
Email: info(a)coresystems.de  =E2=80=A2 http://www.coresystems.de/
Registergericht: Amtsgericht Freiburg =E2=80=A2 HRB 7656
Gesch=C3=A4ftsf=C3=BChrer: Stefan Reinauer =E2=80=A2 Ust-IdNr.: DE245674866


--===============4561958869846536689==
Content-Type: text/plain
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="acpica-unix-20100428-sema.diff"

TWFjIE9TIFggZG9lcyBub3QgaW1wbGVtZW50IHVubmFtZWQgc2VtYXBob3Jlcy4gIFNvIHVzZSBh
IG5hbWVkIG9uZSBpbnN0ZWFkLgoKU2lnbmVkLW9mZi1ieTogU3RlZmFuIFJlaW5hdWVyIDxzdGVw
YW5AY29yZXN5c3RlbXMuZGU+CgotLS0gb3N1bml4eGYuYwkyMDEwLTA1LTE0IDE3OjE4OjU3LjAw
MDAwMDAwMCArMDIwMAorKysgb3N1bml4eGYuYwkyMDEwLTA1LTE0IDE4OjE1OjU3LjAwMDAwMDAw
MCArMDIwMApAQCAtMTI2LDYgKzEyNiw3IEBACiAjaW5jbHVkZSA8c3lzL3RpbWUuaD4KICNpbmNs
dWRlIDxzZW1hcGhvcmUuaD4KICNpbmNsdWRlIDxwdGhyZWFkLmg+CisjaW5jbHVkZSA8ZXJybm8u
aD4KIAogI2luY2x1ZGUgImFjcGkuaCIKICNpbmNsdWRlICJhY2NvbW1vbi5oIgpAQCAtNTM3LDgg
KzUzOCwxNCBAQAogCiAgICAgaWYgKHNlbV9pbml0IChTZW0sIDAsIEluaXRpYWxVbml0cykgPT0g
LTEpCiAgICAgewotICAgICAgICBBY3BpT3NGcmVlIChTZW0pOwotICAgICAgICByZXR1cm4gKEFF
X0JBRF9QQVJBTUVURVIpOworICAgICAgICBpZiAoZXJybm8gPT0gRU5PU1lTKSB7CisgICAgICAg
ICAgICBBY3BpT3NGcmVlIChTZW0pOworCSAgICAgU2VtID0gc2VtX29wZW4odG1wbmFtKE5VTEwp
LCBPX0VYQ0x8T19DUkVBVCwgMDc1NSwgSW5pdGlhbFVuaXRzKTsKKyAJIH0gZWxzZSB7CisgICAg
ICAgICAgICBwZXJyb3IgKCJBY3BpT3NDcmVhdGVTZW1hcGhvcmUiKTsKKyAgICAgICAgICAgIEFj
cGlPc0ZyZWUgKFNlbSk7CisgICAgICAgICAgICByZXR1cm4gKEFFX0JBRF9QQVJBTUVURVIpOwor
CSB9CiAgICAgfQogCiAgICAgKk91dEhhbmRsZSA9IChBQ1BJX0hBTkRMRSkgU2VtOwo=

--===============4561958869846536689==--

