Content-Type: multipart/mixed; boundary="===============6444090597859448429=="
MIME-Version: 1.0
From: nisha jain <nisha.jain at student.utdallas.edu>
Subject: [Devel] Problem in compilation of ACPI test suite
Date: Mon, 16 Nov 2009 18:15:43 -0600
Message-ID: <6b4365880911161615x76180a1fi397d190b4317cef1@mail.gmail.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6444090597859448429==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi All,

I am new to ACPI development. I have downloaded the UNIX Format Source Code
and Build Environment
<http://www.acpica.org/downloads/unix_source_code.php>of the ACPI
and successfully compiled it. I am facing problem in UNIX Format Test
Suite<http://www.acpica.org/downloads/unix_test_suite.php>installation
as i am getting following compilation errors.
After looking into Make file i am still unable to figure what is the reason
of the error.
Please if some one can tell me what is going wrong here?

root(a)utd-desktop:/home/utd/ACPI/acpica-unix-20091112/tests/aslts# make
install
/home/utd/ACPI/acpica-unix-20091112/tests/aslts/src
make[1]: Entering directory
`/home/utd/ACPI/acpica-unix-20091112/tests/aslts/src'
/home/utd/ACPI/acpica-unix-20091112/tests/aslts/src/runtime
make[2]: Entering directory
`/home/utd/ACPI/acpica-unix-20091112/tests/aslts/src/runtime'
/home/utd/ACPI/acpica-unix-20091112/tests/aslts/src/runtime/collections
make[3]: Entering directory
`/home/utd/ACPI/acpica-unix-20091112/tests/aslts/src/runtime/collections'
/home/utd/ACPI/acpica-unix-20091112/tests/aslts/src/runtime/collections/bde=
mo
make[4]: Entering directory
`/home/utd/ACPI/acpica-unix-20091112/tests/aslts/src/runtime/collections/bd=
emo'
/home/utd/ACPI/acpica-unix-20091112/tests/aslts/src/runtime/collections/bde=
mo/ACPICA
make[5]: Entering directory
`/home/utd/ACPI/acpica-unix-20091112/tests/aslts/src/runtime/collections/bd=
emo/ACPICA'
/home/utd/ACPI/acpica-unix-20091112/tests/aslts/src/runtime/collections/bde=
mo/ACPICA/bdemo
make[6]: Entering directory
`/home/utd/ACPI/acpica-unix-20091112/tests/aslts/src/runtime/collections/bd=
emo/ACPICA/bdemo'
Bad iASL 1: <>
make[6]: *** [install_test_case] Error 1
make[6]: Leaving directory
`/home/utd/ACPI/acpica-unix-20091112/tests/aslts/src/runtime/collections/bd=
emo/ACPICA/bdemo'
/home/utd/ACPI/acpica-unix-20091112/tests/aslts/src/runtime/collections/bde=
mo/ACPICA/bdemof
make[6]: Entering directory
`/home/utd/ACPI/acpica-unix-20091112/tests/aslts/src/runtime/collections/bd=
emo/ACPICA/bdemof'
Bad iASL 1: <>
...........

........... so on
............


make[2]: *** [install] Error 2
make[2]: Leaving directory
`/home/utd/ACPI/acpica-unix-20091112/tests/aslts/src/runtime'
make[1]: *** [install] Error 2
make[1]: Leaving directory
`/home/utd/ACPI/acpica-unix-20091112/tests/aslts/src'
make: *** [install] Error 2


I want to use the ACPI library for writing a small application for power
management and display.
My understanding is that in through test code i can understand the sequence
for API call and
their functionality. I have gone through the Programmer reference for API
functionality but
not sure if there is any specific sequence to call them. I am using Intel
dual core and Ubuntu platform.
I have enabled the BIOS settings for ACPI and i am able to run some of
applications to see the power
state of the CPU...


Thanks and Regards,
Nisha

--===============6444090597859448429==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgQWxsLDxicj48YnI+SSBhbSBuZXcgdG8gQUNQSSBkZXZlbG9wbWVudC4gSSBoYXZlIGRvd25s
b2FkZWQgdGhlIDxhIGhyZWY9Imh0dHA6Ly93d3cuYWNwaWNhLm9yZy9kb3dubG9hZHMvdW5peF9z
b3VyY2VfY29kZS5waHAiPlVOSVggRm9ybWF0IFNvdXJjZSBDb2RlIGFuZCBCdWlsZCBFbnZpcm9u
bWVudDwvYT4gIG9mIHRoZSBBQ1BJIDxicj5hbmQgc3VjY2Vzc2Z1bGx5IGNvbXBpbGVkIGl0LiBJ
IGFtIGZhY2luZyBwcm9ibGVtIGluIDxhIGhyZWY9Imh0dHA6Ly93d3cuYWNwaWNhLm9yZy9kb3du
bG9hZHMvdW5peF90ZXN0X3N1aXRlLnBocCI+VU5JWCBGb3JtYXQgVGVzdCBTdWl0ZTwvYT4gaW5z
dGFsbGF0aW9uIGFzIGkgYW0gZ2V0dGluZyBmb2xsb3dpbmcgY29tcGlsYXRpb24gZXJyb3JzLjxi
cj4KQWZ0ZXIgbG9va2luZyBpbnRvIE1ha2UgZmlsZSBpIGFtIHN0aWxsIHVuYWJsZSB0byBmaWd1
cmUgd2hhdCBpcyB0aGUgcmVhc29uIG9mIHRoZSBlcnJvci4gPGJyPlBsZWFzZSBpZiBzb21lIG9u
ZSBjYW4gdGVsbCBtZSB3aGF0IGlzIGdvaW5nIHdyb25nIGhlcmU/IDxicj48YnI+cm9vdEB1dGQt
ZGVza3RvcDovaG9tZS91dGQvQUNQSS9hY3BpY2EtdW5peC0yMDA5MTExMi90ZXN0cy9hc2x0cyMg
bWFrZSBpbnN0YWxsPGJyPgovaG9tZS91dGQvQUNQSS9hY3BpY2EtdW5peC0yMDA5MTExMi90ZXN0
cy9hc2x0cy9zcmM8YnI+bWFrZVsxXTogRW50ZXJpbmcgZGlyZWN0b3J5IGAvaG9tZS91dGQvQUNQ
SS9hY3BpY2EtdW5peC0yMDA5MTExMi90ZXN0cy9hc2x0cy9zcmMmIzM5Ozxicj4vaG9tZS91dGQv
QUNQSS9hY3BpY2EtdW5peC0yMDA5MTExMi90ZXN0cy9hc2x0cy9zcmMvcnVudGltZTxicj5tYWtl
WzJdOiBFbnRlcmluZyBkaXJlY3RvcnkgYC9ob21lL3V0ZC9BQ1BJL2FjcGljYS11bml4LTIwMDkx
MTEyL3Rlc3RzL2FzbHRzL3NyYy9ydW50aW1lJiMzOTs8YnI+Ci9ob21lL3V0ZC9BQ1BJL2FjcGlj
YS11bml4LTIwMDkxMTEyL3Rlc3RzL2FzbHRzL3NyYy9ydW50aW1lL2NvbGxlY3Rpb25zPGJyPm1h
a2VbM106IEVudGVyaW5nIGRpcmVjdG9yeSBgL2hvbWUvdXRkL0FDUEkvYWNwaWNhLXVuaXgtMjAw
OTExMTIvdGVzdHMvYXNsdHMvc3JjL3J1bnRpbWUvY29sbGVjdGlvbnMmIzM5Ozxicj4vaG9tZS91
dGQvQUNQSS9hY3BpY2EtdW5peC0yMDA5MTExMi90ZXN0cy9hc2x0cy9zcmMvcnVudGltZS9jb2xs
ZWN0aW9ucy9iZGVtbzxicj4KbWFrZVs0XTogRW50ZXJpbmcgZGlyZWN0b3J5IGAvaG9tZS91dGQv
QUNQSS9hY3BpY2EtdW5peC0yMDA5MTExMi90ZXN0cy9hc2x0cy9zcmMvcnVudGltZS9jb2xsZWN0
aW9ucy9iZGVtbyYjMzk7PGJyPi9ob21lL3V0ZC9BQ1BJL2FjcGljYS11bml4LTIwMDkxMTEyL3Rl
c3RzL2FzbHRzL3NyYy9ydW50aW1lL2NvbGxlY3Rpb25zL2JkZW1vL0FDUElDQTxicj5tYWtlWzVd
OiBFbnRlcmluZyBkaXJlY3RvcnkgYC9ob21lL3V0ZC9BQ1BJL2FjcGljYS11bml4LTIwMDkxMTEy
L3Rlc3RzL2FzbHRzL3NyYy9ydW50aW1lL2NvbGxlY3Rpb25zL2JkZW1vL0FDUElDQSYjMzk7PGJy
PgovaG9tZS91dGQvQUNQSS9hY3BpY2EtdW5peC0yMDA5MTExMi90ZXN0cy9hc2x0cy9zcmMvcnVu
dGltZS9jb2xsZWN0aW9ucy9iZGVtby9BQ1BJQ0EvYmRlbW88YnI+bWFrZVs2XTogRW50ZXJpbmcg
ZGlyZWN0b3J5IGAvaG9tZS91dGQvQUNQSS9hY3BpY2EtdW5peC0yMDA5MTExMi90ZXN0cy9hc2x0
cy9zcmMvcnVudGltZS9jb2xsZWN0aW9ucy9iZGVtby9BQ1BJQ0EvYmRlbW8mIzM5Ozxicj4KQmFk
IGlBU0wgMTogJmx0OyZndDs8YnI+bWFrZVs2XTogKioqIFtpbnN0YWxsX3Rlc3RfY2FzZV0gRXJy
b3IgMTxicj5tYWtlWzZdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL2hvbWUvdXRkL0FDUEkvYWNwaWNh
LXVuaXgtMjAwOTExMTIvdGVzdHMvYXNsdHMvc3JjL3J1bnRpbWUvY29sbGVjdGlvbnMvYmRlbW8v
QUNQSUNBL2JkZW1vJiMzOTs8YnI+L2hvbWUvdXRkL0FDUEkvYWNwaWNhLXVuaXgtMjAwOTExMTIv
dGVzdHMvYXNsdHMvc3JjL3J1bnRpbWUvY29sbGVjdGlvbnMvYmRlbW8vQUNQSUNBL2JkZW1vZjxi
cj4KbWFrZVs2XTogRW50ZXJpbmcgZGlyZWN0b3J5IGAvaG9tZS91dGQvQUNQSS9hY3BpY2EtdW5p
eC0yMDA5MTExMi90ZXN0cy9hc2x0cy9zcmMvcnVudGltZS9jb2xsZWN0aW9ucy9iZGVtby9BQ1BJ
Q0EvYmRlbW9mJiMzOTs8YnI+QmFkIGlBU0wgMTogJmx0OyZndDs8YnI+Li4uLi4uLi4uLi48YnI+
PGJyPi4uLi4uLi4uLi4uIHNvIG9uPGJyPi4uLi4uLi4uLi4uLjxicj48YnI+PGJyPm1ha2VbMl06
ICoqKiBbaW5zdGFsbF0gRXJyb3IgMjxicj4KbWFrZVsyXTogTGVhdmluZyBkaXJlY3RvcnkgYC9o
b21lL3V0ZC9BQ1BJL2FjcGljYS11bml4LTIwMDkxMTEyL3Rlc3RzL2FzbHRzL3NyYy9ydW50aW1l
JiMzOTs8YnI+bWFrZVsxXTogKioqIFtpbnN0YWxsXSBFcnJvciAyPGJyPm1ha2VbMV06IExlYXZp
bmcgZGlyZWN0b3J5IGAvaG9tZS91dGQvQUNQSS9hY3BpY2EtdW5peC0yMDA5MTExMi90ZXN0cy9h
c2x0cy9zcmMmIzM5Ozxicj5tYWtlOiAqKiogW2luc3RhbGxdIEVycm9yIDI8YnI+Cjxicj48YnI+
SSB3YW50IHRvIHVzZSB0aGUgQUNQSSBsaWJyYXJ5IGZvciB3cml0aW5nIGEgc21hbGwgYXBwbGlj
YXRpb24gZm9yIHBvd2VyIG1hbmFnZW1lbnQgYW5kIGRpc3BsYXkuPGJyPk15IHVuZGVyc3RhbmRp
bmcgaXMgdGhhdCBpbiB0aHJvdWdoIHRlc3QgY29kZSBpIGNhbiB1bmRlcnN0YW5kIHRoZSBzZXF1
ZW5jZSBmb3IgQVBJIGNhbGwgYW5kIDxicj50aGVpciBmdW5jdGlvbmFsaXR5LiBJIGhhdmUgZ29u
ZSB0aHJvdWdoIHRoZSBQcm9ncmFtbWVyIHJlZmVyZW5jZSBmb3IgQVBJIGZ1bmN0aW9uYWxpdHkg
YnV0IDxicj4Kbm90IHN1cmUgaWYgdGhlcmUgaXMgYW55IHNwZWNpZmljIHNlcXVlbmNlIHRvIGNh
bGwgdGhlbS4gSSBhbSB1c2luZyBJbnRlbCBkdWFsIGNvcmUgYW5kIFVidW50dSBwbGF0Zm9ybS4g
PGJyPgpJIGhhdmUgZW5hYmxlZCB0aGUgQklPUyBzZXR0aW5ncyBmb3IgQUNQSSBhbmQgaSBhbSBh
YmxlIHRvIHJ1biBzb21lIG9mIGFwcGxpY2F0aW9ucyB0byBzZWUgdGhlIHBvd2VyIDxicj5zdGF0
ZSBvZiB0aGUgQ1BVLi4uPGJyPjxicj48YnI+VGhhbmtzIGFuZCBSZWdhcmRzLDxicj5OaXNoYTxi
cj4K

--===============6444090597859448429==--

