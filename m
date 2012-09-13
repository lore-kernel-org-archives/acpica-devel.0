Content-Type: multipart/mixed; boundary="===============2500037686171605145=="
MIME-Version: 1.0
From: shuang-shuan guo <shuang-shuan.guo at hotmail.com>
Subject: [Devel] acd disassemble command
Date: Thu, 13 Sep 2012 07:01:47 +0000
Message-ID: <BAY153-W18503F08AA3DC5C03621F3D6910@phx.gbl>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2500037686171605145==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


hi, =

    I am a user of ACPI-CA, I have integrated the acpi-ca code into my appl=
ication. And, I can use the acpi-ca debugger to do some testing. Recently, =
I came across one issue. =

    When I was using the 'acd disassemble' to disassemble these type method=
s(highlighted with yellow as below), then the system will crash, it seems i=
t was accessing some invalid address.
The _CRS is under '\_SB_.LNKA'
                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (BUF0, ResourceTemplate()
                        {
                            IRQ (Level, ActiveLow, Shared) {0}

                        })
                        CreateWordField (BUF0, One, IRQW)
                        If (And (PIRB, 0x80))
                        {
                            Store (Zero, Local0)
                        }
                       Else
                        {
                            Store (One, Local0)
                        }
however, using the 'acd resources \_SB_.LNKA' can parse out the IRQ resourc=
e without any errors. I guess probably there is one issue in acpi-ca disass=
embler.
Is there any one can help me to address?  		 	   		 =20

--===============2500037686171605145==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CjxoZWFkPgo8c3R5bGU+PCEtLQouaG1tZXNzYWdlIFAKewptYXJnaW46MHB4OwpwYWRk
aW5nOjBweAp9CmJvZHkuaG1tZXNzYWdlCnsKZm9udC1zaXplOiAxMHB0Owpmb250LWZhbWlseTpU
YWhvbWEKfQotLT48L3N0eWxlPjwvaGVhZD4KPGJvZHkgY2xhc3M9J2htbWVzc2FnZSc+PGRpdiBk
aXI9J2x0cic+CjxGT05UIHNpemU9Mz5oaSwgPC9GT05UPjxCUj4KJm5ic3A7Jm5ic3A7PEZPTlQg
c2l6ZT0zPiZuYnNwOyBJIGFtIGEgdXNlciBvZiBBQ1BJLUNBLCBJIGhhdmUgaW50ZWdyYXRlZCB0
aGUgYWNwaS1jYSBjb2RlIGludG8gbXkgYXBwbGljYXRpb24uIEFuZCwgSSBjYW4gdXNlIHRoZSBh
Y3BpLWNhIGRlYnVnZ2VyIHRvIGRvIHNvbWUgdGVzdGluZy4gUmVjZW50bHksIEkgY2FtZSBhY3Jv
c3Mgb25lIGlzc3VlLiA8L0ZPTlQ+PEJSPgo8Rk9OVCBzaXplPTM+Jm5ic3A7Jm5ic3A7Jm5ic3A7
IFdoZW4gSSB3YXMgdXNpbmcgdGhlICdhY2QgZGlzYXNzZW1ibGUnIHRvIGRpc2Fzc2VtYmxlIHRo
ZXNlIHR5cGUgbWV0aG9kcyhoaWdobGlnaHRlZCB3aXRoIHllbGxvdyBhcyBiZWxvdyksIHRoZW4g
dGhlIHN5c3RlbSB3aWxsIGNyYXNoLCBpdCBzZWVtcyBpdCB3YXMgYWNjZXNzaW5nIHNvbWUgaW52
YWxpZCBhZGRyZXNzLjwvRk9OVD48QlI+CjxGT05UIHNpemU9Mz5UaGUgX0NSUyBpcyB1bmRlciAn
XF9TQl8uTE5LQSc8L0ZPTlQ+PEJSPgo8U1BBTiBzdHlsZT0iRk9OVC1GQU1JTFk6IMvOzOU7IENP
TE9SOiBibGFjazsgRk9OVC1TSVpFOiAxMnB0OyBtc28tYmlkaS1mb250LWZhbWlseTogy87M5Tsg
bXNvLWFuc2ktbGFuZ3VhZ2U6IEVOLVVTOyBtc28tZmFyZWFzdC1sYW5ndWFnZTogWkgtQ047IG1z
by1iaWRpLWxhbmd1YWdlOiBBUi1TQSIgbGFuZz1FTi1VUz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgTWV0aG9kIChfQ1JTLCAwLCBOb3RT
ZXJpYWxpemVkKTxCUj4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsgezxCUj4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgPEZPTlQgc3R5bGU9
IkJBQ0tHUk9VTkQtQ09MT1I6ICNmZmZmMDAiPk5hbWUgKEJVRjAsIFJlc291cmNlVGVtcGxhdGUo
KTxCUj4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgezxCUj4mbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgSVJRIChMZXZlbCwgQWN0aXZlTG93LCBTaGFyZWQp
IHswfTxCUj48QlI+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IH0pPEJSPjwvRk9OVD4mbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsgQ3JlYXRlV29yZEZpZWxkIChCVUYwLCBPbmUsIElSUVcpPEJSPiZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBJZiAoQW5kIChQSVJCLCAweDgwKSk8QlI+Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7IHs8QlI+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7IFN0b3JlIChaZXJvLCBMb2NhbDApPEJSPiZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyB9PEJSPiZuYnNwOyZuYnNwOyAmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgRWxzZTxCUj4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsg
ezxCUj4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgU3Rv
cmUgKE9uZSwgTG9jYWwwKTxCUj4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgfTwvU1BBTj48QlI+
CjxTUEFOIHN0eWxlPSJGT05ULUZBTUlMWTogy87M5TsgQ09MT1I6IGJsYWNrOyBGT05ULVNJWkU6
IDEycHQ7IG1zby1iaWRpLWZvbnQtZmFtaWx5OiDLzszlOyBtc28tYW5zaS1sYW5ndWFnZTogRU4t
VVM7IG1zby1mYXJlYXN0LWxhbmd1YWdlOiBaSC1DTjsgbXNvLWJpZGktbGFuZ3VhZ2U6IEFSLVNB
IiBsYW5nPUVOLVVTPjxGT05UIGZhY2U9VGFob21hPmhvd2V2ZXIsIHVzaW5nIHRoZSAnYWNkIHJl
c291cmNlcyBcX1NCXy5MTktBJyBjYW4gcGFyc2Ugb3V0IHRoZSBJUlEgcmVzb3VyY2Ugd2l0aG91
dCBhbnkgZXJyb3JzLiBJIGd1ZXNzIHByb2JhYmx5IHRoZXJlIGlzIG9uZSBpc3N1ZSBpbiBhY3Bp
LWNhIGRpc2Fzc2VtYmxlci48L0ZPTlQ+PC9TUEFOPjxCUj4KPFNQQU4gc3R5bGU9IkZPTlQtRkFN
SUxZOiDLzszlOyBDT0xPUjogYmxhY2s7IEZPTlQtU0laRTogMTJwdDsgbXNvLWJpZGktZm9udC1m
YW1pbHk6IMvOzOU7IG1zby1hbnNpLWxhbmd1YWdlOiBFTi1VUzsgbXNvLWZhcmVhc3QtbGFuZ3Vh
Z2U6IFpILUNOOyBtc28tYmlkaS1sYW5ndWFnZTogQVItU0EiIGxhbmc9RU4tVVM+PEZPTlQgZmFj
ZT1UYWhvbWE+SXMgdGhlcmUgYW55IG9uZSBjYW4gaGVscCBtZSB0byBhZGRyZXNzPyA8L0ZPTlQ+
PC9TUEFOPjxCUj4gCQkgCSAgIAkJICA8L2Rpdj48L2JvZHk+CjwvaHRtbD4=
--===============2500037686171605145==--

