Content-Type: multipart/mixed; boundary="===============8021557645595497062=="
MIME-Version: 1.0
From: Al Stone <ahs3 at redhat.com>
Subject: [Devel] [RFC] proposed patch for some segfaults encountered
Date: Mon, 01 Jun 2015 14:59:22 -0600
Message-ID: <556CC7AA.4010000@redhat.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8021557645595497062==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It's not clear to me that this is the correct way to handle a segfault that
was reported to me via Fedora.

Using the ssdt9.dat file attached, a simple "iasl -d ssdt9.dat" will segfau=
lt
around calls to AcpiDmPromoteTarget -- and it turns out that the Target poi=
nter
being passed into that function was sometimes null but not being checked in=
 the
calling function, AcpiDmCheckForSymbolicOpcode.  So, this patch adds in some
checks for null pointers and can now get through this particular problem.

However, I did not study AcpiDmCheckForSymbolicOpcode long enough to determ=
ine
if the Target pointer in that function should or should not ever be null.  =
So,
this patch fixes this issue, but it may not be the proper long term solutio=
n.

-- =

ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3(a)redhat.com
-----------------------------------

--===============8021557645595497062==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="segfault.patch"

ZGlmZiAtTmF1ciBhY3BpY2EtdW5peDItMjAxNTA1MTUub3JpZy9zb3VyY2UvY29tcG9uZW50cy9k
aXNhc3NlbWJsZXIvZG1jc3R5bGUuYyBhY3BpY2EtdW5peDItMjAxNTA1MTUvc291cmNlL2NvbXBv
bmVudHMvZGlzYXNzZW1ibGVyL2RtY3N0eWxlLmMKLS0tIGFjcGljYS11bml4Mi0yMDE1MDUxNS5v
cmlnL3NvdXJjZS9jb21wb25lbnRzL2Rpc2Fzc2VtYmxlci9kbWNzdHlsZS5jCTIwMTUtMDYtMDEg
MTQ6MzI6NTEuNzY5MjE4ODg3IC0wNjAwCisrKyBhY3BpY2EtdW5peDItMjAxNTA1MTUvc291cmNl
L2NvbXBvbmVudHMvZGlzYXNzZW1ibGVyL2RtY3N0eWxlLmMJMjAxNS0wNi0wMSAxNDozNzozOC45
NzM4OTg4MzkgLTA2MDAKQEAgLTQwNyw3ICs0MDcsNyBAQAogICAgICAgICB7CiAgICAgICAgICAg
ICBBY3BpRG1Qcm9tb3RlVGFyZ2V0IChPcCwgVGFyZ2V0KTsKIAotICAgICAgICAgICAgaWYgKCFU
YXJnZXQtPkNvbW1vbi5PcGVyYXRvclN5bWJvbCkKKyAgICAgICAgICAgIGlmIChUYXJnZXQgJiYg
IVRhcmdldC0+Q29tbW9uLk9wZXJhdG9yU3ltYm9sKQogICAgICAgICAgICAgewogICAgICAgICAg
ICAgICAgIFRhcmdldC0+Q29tbW9uLk9wZXJhdG9yU3ltYm9sID0gIiA9ICI7CiAgICAgICAgICAg
ICB9CkBAIC00MjUsNyArNDI1LDcgQEAKICAgICAgICAgVGFyZ2V0ID0gQ2hpbGQxLT5Db21tb24u
TmV4dDsKICAgICAgICAgQWNwaURtUHJvbW90ZVRhcmdldCAoT3AsIFRhcmdldCk7CiAKLSAgICAg
ICAgaWYgKCFUYXJnZXQtPkNvbW1vbi5PcGVyYXRvclN5bWJvbCkKKyAgICAgICAgaWYgKFRhcmdl
dCAmJiAhVGFyZ2V0LT5Db21tb24uT3BlcmF0b3JTeW1ib2wpCiAgICAgICAgIHsKICAgICAgICAg
ICAgIFRhcmdldC0+Q29tbW9uLk9wZXJhdG9yU3ltYm9sID0gIiA9ICI7CiAgICAgICAgIH0KQEAg
LTQ0Niw3ICs0NDYsMTAgQEAKICAgICAgICAgICAgIC8qIFZhbGlkIHRhcmdldCwgbm90IGEgcGxh
Y2Vob2xkZXIgKi8KIAogICAgICAgICAgICAgQWNwaURtUHJvbW90ZVRhcmdldCAoT3AsIFRhcmdl
dCk7Ci0gICAgICAgICAgICBUYXJnZXQtPkNvbW1vbi5PcGVyYXRvclN5bWJvbCA9ICIgPSB+IjsK
KwkgICAgaWYgKFRhcmdldCkKKwkgICAgeworICAgICAgICAgICAgCVRhcmdldC0+Q29tbW9uLk9w
ZXJhdG9yU3ltYm9sID0gIiA9IH4iOworCSAgICB9CiAgICAgICAgIH0KICAgICAgICAgZWxzZQog
ICAgICAgICB7Cg==

--===============8021557645595497062==--

