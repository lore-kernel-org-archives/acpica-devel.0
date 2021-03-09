Content-Type: multipart/mixed; boundary="===============2560049941921458032=="
MIME-Version: 1.0
From: Jakub Czapiga <jacz at semihalf.com>
Subject: [Devel] ACPI table testing with ACPICA
Date: Tue, 09 Mar 2021 19:25:57 +0100
Message-ID: <CAFyd4VbFdF0hyPm60w+AT1KO=TzxQS+oE-j2TiQDsuL7=B+Q8g@mail.gmail.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2560049941921458032==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello everyone,

I am working on a system for AML testing. Basically I want to create some
kind of unit-testing environment allowing to load generated ACPI tables
(preferably from memory buffer) and check methods' behavior, check
variables, check if all required objects are present etc.

My first idea was to dump generated ACPI tables into files, load them into
AcpiExec process and communicate with it using Python. I wonder if it is
possible to use provided source code as a library and write tests in C
instead of Python with a custom framework.

Could you please guide me in the right direction?

P.S.
https://acpica.org/contact does not work. Captcha is empty.

Regards,
Jakub Czapiga
jacz(a)semihalf.com

--===============2560049941921458032==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdj5IZWxsbyBldmVyeW9uZSw8L2Rpdj48ZGl2Pjxicj48L2Rpdj48
ZGl2PkkgYW0gd29ya2luZyBvbiBhIHN5c3RlbSBmb3IgQU1MIHRlc3RpbmcuIApCYXNpY2FsbHkg
SSB3YW50IHRvIGNyZWF0ZSBzb21lIGtpbmQgb2YgdW5pdC10ZXN0aW5nIGVudmlyb25tZW50IAph
bGxvd2luZyB0byBsb2FkIGdlbmVyYXRlZCBBQ1BJIHRhYmxlcyAocHJlZmVyYWJseSBmcm9tIG1l
bW9yeSBidWZmZXIpIAphbmQgY2hlY2sgbWV0aG9kcyYjMzk7IGJlaGF2aW9yLCBjaGVjayB2YXJp
YWJsZXMsIGNoZWNrIGlmIGFsbCByZXF1aXJlZCAKb2JqZWN0cyBhcmUgcHJlc2VudCBldGMuIDxi
cj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pk15IGZpcnN0IGlkZWEgd2FzIHRvIGR1bXAgZ2Vu
ZXJhdGVkIEFDUEkgdGFibGVzIGludG8gZmlsZXMsIGxvYWQgdGhlbSAKaW50byBBY3BpRXhlYyBw
cm9jZXNzIGFuZCBjb21tdW5pY2F0ZSB3aXRoIGl0IHVzaW5nIFB5dGhvbi4gSSB3b25kZXIgaWYg
Cml0IGlzIHBvc3NpYmxlIHRvIHVzZSBwcm92aWRlZCBzb3VyY2UgY29kZSBhcyBhIGxpYnJhcnkg
YW5kIHdyaXRlIHRlc3RzIAppbiBDIGluc3RlYWQgb2YgUHl0aG9uIHdpdGggYSBjdXN0b20gZnJh
bWV3b3JrLiA8YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5Db3VsZCB5b3UgcGxlYXNlIGd1
aWRlIG1lIGluIHRoZSByaWdodCBkaXJlY3Rpb24/PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5Q
LlMuPC9kaXY+PGRpdj48YSBocmVmPSJodHRwczovL2FjcGljYS5vcmcvY29udGFjdCI+aHR0cHM6
Ly9hY3BpY2Eub3JnL2NvbnRhY3Q8L2E+IGRvZXMgbm90IHdvcmsuIENhcHRjaGEgaXMgZW1wdHku
PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+UmVnYXJkcyw8L2Rpdj48ZGl2Pkpha3ViIEN6
YXBpZ2E8L2Rpdj48ZGl2PjxhIGhyZWY9Im1haWx0bzpqYWN6QHNlbWloYWxmLmNvbSI+amFjekBz
ZW1paGFsZi5jb208L2E+PGJyPjwvZGl2PjwvZGl2Pgo=

--===============2560049941921458032==--

