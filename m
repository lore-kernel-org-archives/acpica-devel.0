Content-Type: multipart/mixed; boundary="===============6002064566357293740=="
MIME-Version: 1.0
From: Dale Ghent <daleg at elemental.org>
Subject: [Devel] New to ACPICA, could use a pointer
Date: Tue, 08 Mar 2016 10:19:40 -0500
Message-ID: <989CF009-260A-445C-BCC1-6005A78DAA97@elemental.org>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6002064566357293740==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hello!

I've taken up a small project to update the illumos kernel with the latest =
ACPICA code, as it's currently a few years overdue for one. One of my test =
cases is on VirtualBox, and I'm trying to figure out the cause (and thus th=
e remedy, or at the very least the reasons why it's happening) of a particu=
lar error message that's emitted on boot and loading our acpica kernel driv=
er. The output is as follows:

Mar  8 03:08:00 bloodacpi acpica: [ID 912267 kern.notice] ACPI: RSDP 0x    =
   0   E0000 000024 (v2 VBOX  )
Mar  8 03:08:00 bloodacpi acpica: [ID 416880 kern.notice] ACPI: XSDT 0x    =
   0DBFF0040 00004C (v1 VBOX   VBOXXSDT 00000001 ASL 00000061)
Mar  8 03:08:00 bloodacpi acpica: [ID 334289 kern.notice] ACPI: FACP 0x    =
   0DBFF0110 0000F4 (v4 VBOX   VBOXFACP 00000001 ASL  00000061)Mar  8 03:08=
:00 bloodacpi acpica: [ID 653090 kern.notice] ACPI: DSDT 0x       0DBFF0540=
 001CEB (v1 VBOX   VBOXBIOS 00000002 INTL 20100528)
Mar  8 03:08:00 bloodacpi acpica: [ID 138051 kern.notice] ACPI: FACS 0x    =
   0DBFF0240 000040
Mar  8 03:08:00 bloodacpi last message repeated 1 timeMar  8 03:08:00 blood=
acpi acpica: [ID 648033 kern.notice] ACPI: APIC 0x       0DBFF028
0 00006C (v2 VBOX   VBOXAPIC 00000001 ASL  00000061)
Mar  8 03:08:00 bloodacpi acpica: [ID 548506 kern.notice] ACPI: HPET 0x    =
   0DBFF02F0 000038 (v1 VBOX   VBOXHPET 00000001 ASL  00000061)
Mar  8 03:08:00 bloodacpi acpica: [ID 517261 kern.notice] ACPI: MCFG 0x    =
   0DBFF0330 00003C (v1 VBOX   VBOXMCFG 00000001 ASL  00000061)
Mar  8 03:08:00 bloodacpi acpica: [ID 272102 kern.notice] ACPI: SSDT 0x    =
   0DBFF0370 0001CC (v1 VBOX   VBOXCPUT 00000002 INTL 20100528)
Mar  8 03:08:00 bloodacpi acpica: [ID 791000 kern.notice] ACPI Error: No ha=
ndler for Region [SYSI] (ffffff01cb5fcc90) [SystemIO] (20160212/evregion-25=
5)
Mar  8 03:08:00 bloodacpi acpica: [ID 814936 kern.notice] ACPI Error: Regio=
n SystemIO (ID=3D1) has no handler (20160212/exfldio-395)
Mar  8 03:08:00 bloodacpi acpica: [ID 947390 kern.notice] ACPI Error: Metho=
d parse/execution failed [\] (Node fffffffffbd0c1e0), AE_NOT_EXIST (2016021=
2/psparse-631)
Mar  8 03:08:00 bloodacpi acpica: [ID 190582 kern.notice] ACPI: Executed 1 =
blocks of module-level executable AML code
Mar  8 03:08:00 bloodacpi acpica: [ID 542867 kern.notice] ACPI: 2 ACPI AML =
tables successfully acquired and loaded
Mar  8 03:08:00 bloodacpi acpica: [ID 100000 kern.notice]
Mar  8 03:08:00 bloodacpi acpica: [ID 823235 kern.notice] ACPI: Enabled 2 G=
PEs in block 00 to 07

The above is what's emitted. I'm curious about the "No hander for Region [S=
YSI]..." and related lines (as well as the odd spaces that have appeared in=
 the output between "0x" and the value after each table type, but that's a =
minor issue at the moment)

I *think* the relevant code to this issue is here:
http://grok.elemental.org/source/xref/illumos-omnios-bloody/usr/src/uts/int=
el/io/acpica/acpica.c#192

But after reading through things a few times, I'm not entirely sure if I'm =
actually missing something, or if these handlers need to be removed and rep=
laced with something else. This error for the SystemIO hander do not show u=
p under the current ACPICA code in illumos, which is based on ACPICA 201105=
27

Any tips would be appreciated.
/dale


--===============6002064566357293740==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSWNCQUVCQ0FBR0JRSlczdTJOQUFvSkVQ
L1ZxbncvYk85aGNmOFAvaVpiMFFlajRmYlBtbldweS9jSjBIK24KNlVUVjQ0MTJWeWdhS1F2UEd2
NGdVTWprMmErWVR6T09vdnNSeER3T2NzanE4NFhkRGV4SEFvRHlkYUZUS0RSSQp5Ly9WNWs0VEph
Q0t4NVdiaWFUT2xYT0VwemlHaUdHaGlwb2ZjR1Jsd25oUm10R0FXcDg3UzFYR0Y1QkkvRUJWCkNy
eVM5d1ZwNEZBSTB0NU9tY1FRWGZ1VzF1OHhOZmV5RVNjc1ZVbWRicDcyT0tkZ3p2RWRZVDRsUDVU
aDdaaUEKeWtJWEcrZEFSdUQrcTBib1pMemxoT2dsV1hTd09USFZoQ0tJcnB5WGJvSEVOZTdqTVdr
cDg0SmNmbThhdkdEVQpmenI4aElualBhK0d0dGF2bTlDMCtwRllYWmpDR1UwV1ZVSkpmZlhYQWpw
UU9rdjhMZ3NtRFY4N1g3SEF4c1JwCitSQ0N3dFZkSzJCTnJGSTNBazY1WFU4WlpVb1lDdVB5dUhE
OXdqU1g1N3dUQzFHMTB0NXNVdSsxWnM1SVRjRjcKeTBqWjlwTjE3YnZzZCtSK2hLY3FEeEdhUjBZ
Y3ZCVy9SS2s4U09KTGFRY0RqQlpwQVAzb0xRelJhTzhUT0RIZgpORjZjREhWcTlCbjgwZERlUnp4
QVFPM2R5YW9MNTFaRzZRRE55bU9ETlJpd0lYangzR2lFTjZySCtmQVlyZzk1CjhGSlNNNUhUb3k5
enNnQ2o0a0kyN3ExS25GRWRiMk8wZkpJZXg2eXJjcjVMcCtpU3pDRTNmNkEvbkU2bEU0SzUKNm9Q
Y1k5T2RJaXVNZ1hQR0tUS0xIL0FSaWpacFRCbVpaR0lDSzNIaGQxOXVWeTU2Mkk2eHFYMHNtVkE3
UHpWWQpiMEt1OHVkNXFZcU5tMmUrOENZaQo9b3BjUQotLS0tLUVORCBQR1AgU0lHTkFUVVJFLS0t
LS0K

--===============6002064566357293740==--

