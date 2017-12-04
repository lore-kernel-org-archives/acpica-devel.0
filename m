Content-Type: multipart/mixed; boundary="===============0375027839132398798=="
MIME-Version: 1.0
From: Mike Gerdts <mike.gerdts at joyent.com>
Subject: [Devel] fix for 1831 broke AcpiEvaluateObjectTyped, maybe
Date: Mon, 04 Dec 2017 10:56:15 -0600
Message-ID: <CAAxFYUHpjtPzGHyYh50Ng5oKc0VJ=KmLi1FMzASKWXjbKOkVkQ@mail.gmail.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0375027839132398798==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The comment above AcpiEvaluateObjectTyped says that the Pathname option is
optional.  The ACPICA User and and Programmer Reference Revision 6.2 makes
no mention of it being optional.

It seems as though the fix for

Bug 1381 - More improved error messages for predefined methods (return
value)

was either a bad fix or incomplete.  If Pathname is intended to be
optional, it was a bad fix.  If it is not optional, the fix should have
corrected the comment above the function body.

Any advice on what the correct behavior is would be most appreciated.

TIA,
Mike

--===============0375027839132398798==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj5UaGUgY29tbWVudCBhYm92ZSBBY3BpRXZhbHVhdGVPYmplY3RU
eXBlZCBzYXlzIHRoYXQgdGhlIFBhdGhuYW1lIG9wdGlvbiBpcyBvcHRpb25hbC7CoCBUaGUgQUNQ
SUNBIFVzZXIgYW5kIGFuZCBQcm9ncmFtbWVyIFJlZmVyZW5jZSBSZXZpc2lvbiA2LjIgbWFrZXMg
bm8gbWVudGlvbiBvZiBpdCBiZWluZyBvcHRpb25hbC48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2
Pkl0IHNlZW1zIGFzIHRob3VnaCB0aGUgZml4IGZvcjwvZGl2PjxkaXY+PGJyPjwvZGl2PkJ1ZyAx
MzgxIC0gTW9yZSBpbXByb3ZlZCBlcnJvciBtZXNzYWdlcyBmb3IgcHJlZGVmaW5lZCBtZXRob2Rz
IChyZXR1cm4gdmFsdWUpPGJyPjxkaXY+PGJyPjwvZGl2PjxkaXY+d2FzIGVpdGhlciBhIGJhZCBm
aXggb3IgaW5jb21wbGV0ZS7CoCBJZiBQYXRobmFtZSBpcyBpbnRlbmRlZCB0byBiZSBvcHRpb25h
bCwgaXQgd2FzIGEgYmFkIGZpeC7CoCBJZiBpdCBpcyBub3Qgb3B0aW9uYWwsIHRoZSBmaXggc2hv
dWxkIGhhdmUgY29ycmVjdGVkIHRoZSBjb21tZW50IGFib3ZlIHRoZSBmdW5jdGlvbiBib2R5Ljwv
ZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+QW55IGFkdmljZSBvbiB3aGF0IHRoZSBjb3JyZWN0IGJl
aGF2aW9yIGlzIHdvdWxkIGJlIG1vc3QgYXBwcmVjaWF0ZWQuPC9kaXY+PGRpdj48YnI+PC9kaXY+
PGRpdj5USUEsPC9kaXY+PGRpdj5NaWtlPC9kaXY+PC9kaXY+Cg==

--===============0375027839132398798==--

