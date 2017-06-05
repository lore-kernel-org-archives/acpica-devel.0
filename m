Content-Type: multipart/mixed; boundary="===============5802137250902511901=="
MIME-Version: 1.0
From: Devin Steffler <devinsteffler at gmail.com>
Subject: [Devel] question about ACPICA internal cache manager
Date: Mon, 05 Jun 2017 14:59:50 -0400
Message-ID: <CAAuRk_g+fC5pWXKzCsFuA7aK5ONkunmD+_3s-qMviT2H137inA@mail.gmail.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5802137250902511901==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Note: I'm using ACPICA version 20170303.

In my ACPICA OSL, for QNX, I am using the ACPICA internal cache manager by
defining ACPI_USE_LOCAL_CACHE.

Is it expected that my OSL will periodically call AcpiPurgeCachedObjects to
free the cached objects? Currently I am not calling it at all.

I'm asking because I appear to have a small memory leak relating to ACPICA
cached objects.

My ACPICA OSL basically does this every couple seconds:
// ----------------------------------------------------------
   Results.Length =3D ACPI_ALLOCATE_BUFFER;
   Results.Pointer =3D NULL;
   status =3D AcpiEvaluateObject(gBattery[i], "_BST", NULL, &Results);
// ...
   if (NULL !=3D Results.Pointer) {
    AcpiOsFree(Results.Pointer);
   }
// ----------------------------------------------------------

I have Valgrind running on my OSL and it points to the ACPICA cache
(utcache.c) as the cause of the memory leak. An example is below:
// ----------------------------------------------------------
=3D=3D435478549=3D=3D 20,670 (15,180 direct, 5,490 indirect) bytes in 345 b=
locks
are definitely lost in loss record 165 of 170
=3D=3D435478549=3D=3D    at 0xC7E3D: malloc (vg_replace_malloc.c:306 in
/usr/lib/valgrind/vgpreload_memcheck-x86-nto.so)
=3D=3D435478549=3D=3D    by 0x8049A26: AcpiOsAllocate (osl.c:169 in /devin/=
acpi-qnx)
=3D=3D435478549=3D=3D    by 0x8057451: AcpiOsAllocateZeroed (utalloc.c:185 =
in
/devin/acpi-qnx)
=3D=3D435478549=3D=3D    by 0x8057010: AcpiOsAcquireObject (utcache.c:452 in
/devin/acpi-qnx)
=3D=3D435478549=3D=3D    by 0x80511D7: AcpiUtAllocateObjectDescDbg (utobjec=
t.c:548
in /devin/acpi-qnx)
=3D=3D435478549=3D=3D    by 0x8050AFD: AcpiUtCreateInternalObjectDbg
(utobject.c:218 in /devin/acpi-qnx)
=3D=3D435478549=3D=3D    by 0x8095F9D: AcpiDsCreateOperand (dsutils.c:820 in
/devin/acpi-qnx)
=3D=3D435478549=3D=3D    by 0x8096268: AcpiDsCreateOperands (dsutils.c:915 =
in
/devin/acpi-qnx)
=3D=3D435478549=3D=3D    by 0x80948E7: AcpiDsExecEndOp (dswexec.c:559 in
/devin/acpi-qnx)
=3D=3D435478549=3D=3D    by 0x8065063: AcpiPsParseLoop (psloop.c:765 in
/devin/acpi-qnx)
=3D=3D435478549=3D=3D    by 0x8062C35: AcpiPsParseAml (psparse.c:632 in
/devin/acpi-qnx)
=3D=3D435478549=3D=3D    by 0x80616BC: AcpiPsExecuteMethod (psxface.c:349 in
/devin/acpi-qnx)
=3D=3D435478549=3D=3D    by 0x806EAD1: AcpiNsEvaluate (nseval.c:359 in
/devin/acpi-qnx)
=3D=3D435478549=3D=3D    by 0x8067482: AcpiEvaluateObject (nsxfeval.c:503 in
/devin/acpi-qnx)
// ----------------------------------------------------------

On exit, a call to AcpiTerminate is made and it doesn't free up the memory
as well.

Any tips on troubleshooting this would be greatly appreciated. If it looks
like a bug then please advise and I'll raise an ACPICA bug.

Thanks,
Devin

--===============5802137250902511901==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj5IZWxsbyw8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pk5vdGU6
IEkmIzM5O20gdXNpbmcgQUNQSUNBIHZlcnNpb24gMjAxNzAzMDMuPC9kaXY+PGRpdj48YnI+PC9k
aXY+PGRpdj5JbiBteSBBQ1BJQ0EgT1NMLCBmb3IgUU5YLCBJIGFtIHVzaW5nIHRoZSBBQ1BJQ0Eg
aW50ZXJuYWwgY2FjaGUgbWFuYWdlciBieSBkZWZpbmluZyBBQ1BJX1VTRV9MT0NBTF9DQUNIRS48
L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PklzIGl0IGV4cGVjdGVkIHRoYXQgbXkgT1NMIHdpbGwg
cGVyaW9kaWNhbGx5IGNhbGwgQWNwaVB1cmdlQ2FjaGVkT2JqZWN0cyB0byBmcmVlIHRoZSBjYWNo
ZWQgb2JqZWN0cz8gQ3VycmVudGx5IEkgYW0gbm90IGNhbGxpbmcgaXQgYXQgYWxsLjwvZGl2Pjxk
aXY+PGJyPjwvZGl2PjxkaXY+SSYjMzk7bSBhc2tpbmcgYmVjYXVzZSBJIGFwcGVhciB0byBoYXZl
IGEgc21hbGwgbWVtb3J5IGxlYWsgcmVsYXRpbmcgdG8gQUNQSUNBIGNhY2hlZCBvYmplY3RzLjwv
ZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+TXkgQUNQSUNBIE9TTCBiYXNpY2FsbHkgZG9lcyB0aGlz
IGV2ZXJ5IGNvdXBsZSBzZWNvbmRzOjwvZGl2PjxkaXY+Ly8gLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTxicj7CoMKgwqBSZXN1bHRzLkxl
bmd0aCA9IEFDUElfQUxMT0NBVEVfQlVGRkVSOzxicj7CoMKgwqBSZXN1bHRzLlBvaW50ZXIgPSBO
VUxMOzxicj7CoMKgwqBzdGF0dXMgPSBBY3BpRXZhbHVhdGVPYmplY3QoZ0JhdHRlcnlbaV0sICZx
dW90O19CU1QmcXVvdDssIE5VTEwsICZhbXA7UmVzdWx0cyk7PGJyPi8vIC4uLjxicj7CoMKgwqBp
ZiAoTlVMTCAhPSBSZXN1bHRzLlBvaW50ZXIpIHs8YnI+wqDCoMKgwqBBY3BpT3NGcmVlKFJlc3Vs
dHMuUG9pbnRlcik7PGJyPsKgwqDCoH08L2Rpdj48ZGl2Pi8vIC0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08YnI+PGJyPjwvZGl2PjxkaXY+
SSBoYXZlIFZhbGdyaW5kIHJ1bm5pbmcgb24gbXkgT1NMIGFuZCBpdCBwb2ludHMgdG8gdGhlIEFD
UElDQSBjYWNoZSAodXRjYWNoZS5jKSBhcyB0aGUgY2F1c2Ugb2YgdGhlIG1lbW9yeSBsZWFrLiBB
biBleGFtcGxlIGlzIGJlbG93OjwvZGl2PjxkaXY+Ly8gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTxicj49PTQzNTQ3ODU0OT09IDIwLDY3
MCAoMTUsMTgwIGRpcmVjdCwgNSw0OTAgaW5kaXJlY3QpIGJ5dGVzIGluIDM0NSBibG9ja3MgYXJl
IGRlZmluaXRlbHkgbG9zdCBpbiBsb3NzIHJlY29yZCAxNjUgb2YgMTcwPGJyPj09NDM1NDc4NTQ5
PT3CoMKgwqAgYXQgMHhDN0UzRDogbWFsbG9jICh2Z19yZXBsYWNlX21hbGxvYy5jOjMwNiBpbiAv
dXNyL2xpYi92YWxncmluZC92Z3ByZWxvYWRfbWVtY2hlY2steDg2LW50by5zbyk8YnI+PT00MzU0
Nzg1NDk9PcKgwqDCoCBieSAweDgwNDlBMjY6IEFjcGlPc0FsbG9jYXRlIChvc2wuYzoxNjkgaW4g
L2RldmluL2FjcGktcW54KTxicj49PTQzNTQ3ODU0OT09wqDCoMKgIGJ5IDB4ODA1NzQ1MTogQWNw
aU9zQWxsb2NhdGVaZXJvZWQgKHV0YWxsb2MuYzoxODUgaW4gL2RldmluL2FjcGktcW54KTxicj49
PTQzNTQ3ODU0OT09wqDCoMKgIGJ5IDB4ODA1NzAxMDogQWNwaU9zQWNxdWlyZU9iamVjdCAodXRj
YWNoZS5jOjQ1MiBpbiAvZGV2aW4vYWNwaS1xbngpPGJyPj09NDM1NDc4NTQ5PT3CoMKgwqAgYnkg
MHg4MDUxMUQ3OiBBY3BpVXRBbGxvY2F0ZU9iamVjdERlc2NEYmcgKHV0b2JqZWN0LmM6NTQ4IGlu
IC9kZXZpbi9hY3BpLXFueCk8YnI+PT00MzU0Nzg1NDk9PcKgwqDCoCBieSAweDgwNTBBRkQ6IEFj
cGlVdENyZWF0ZUludGVybmFsT2JqZWN0RGJnICh1dG9iamVjdC5jOjIxOCBpbiAvZGV2aW4vYWNw
aS1xbngpPGJyPj09NDM1NDc4NTQ5PT3CoMKgwqAgYnkgMHg4MDk1RjlEOiBBY3BpRHNDcmVhdGVP
cGVyYW5kIChkc3V0aWxzLmM6ODIwIGluIC9kZXZpbi9hY3BpLXFueCk8YnI+PT00MzU0Nzg1NDk9
PcKgwqDCoCBieSAweDgwOTYyNjg6IEFjcGlEc0NyZWF0ZU9wZXJhbmRzIChkc3V0aWxzLmM6OTE1
IGluIC9kZXZpbi9hY3BpLXFueCk8YnI+PT00MzU0Nzg1NDk9PcKgwqDCoCBieSAweDgwOTQ4RTc6
IEFjcGlEc0V4ZWNFbmRPcCAoZHN3ZXhlYy5jOjU1OSBpbiAvZGV2aW4vYWNwaS1xbngpPGJyPj09
NDM1NDc4NTQ5PT3CoMKgwqAgYnkgMHg4MDY1MDYzOiBBY3BpUHNQYXJzZUxvb3AgKHBzbG9vcC5j
Ojc2NSBpbiAvZGV2aW4vYWNwaS1xbngpPGJyPj09NDM1NDc4NTQ5PT3CoMKgwqAgYnkgMHg4MDYy
QzM1OiBBY3BpUHNQYXJzZUFtbCAocHNwYXJzZS5jOjYzMiBpbiAvZGV2aW4vYWNwaS1xbngpPGJy
Pj09NDM1NDc4NTQ5PT3CoMKgwqAgYnkgMHg4MDYxNkJDOiBBY3BpUHNFeGVjdXRlTWV0aG9kIChw
c3hmYWNlLmM6MzQ5IGluIC9kZXZpbi9hY3BpLXFueCk8YnI+PT00MzU0Nzg1NDk9PcKgwqDCoCBi
eSAweDgwNkVBRDE6IEFjcGlOc0V2YWx1YXRlIChuc2V2YWwuYzozNTkgaW4gL2RldmluL2FjcGkt
cW54KTxicj49PTQzNTQ3ODU0OT09wqDCoMKgIGJ5IDB4ODA2NzQ4MjogQWNwaUV2YWx1YXRlT2Jq
ZWN0IChuc3hmZXZhbC5jOjUwMyBpbiAvZGV2aW4vYWNwaS1xbngpPC9kaXY+PGRpdj4vLyAtLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPC9k
aXY+PGRpdj48YnI+PC9kaXY+PGRpdj5PbiBleGl0LCBhIGNhbGwgdG8gQWNwaVRlcm1pbmF0ZSBp
cyBtYWRlIGFuZCBpdCBkb2VzbiYjMzk7dCBmcmVlIHVwIHRoZSBtZW1vcnkgYXMgd2VsbC48L2Rp
dj48ZGl2Pjxicj48L2Rpdj48ZGl2PkFueSB0aXBzIG9uIHRyb3VibGVzaG9vdGluZyB0aGlzIHdv
dWxkIGJlIGdyZWF0bHkgYXBwcmVjaWF0ZWQuIElmIGl0IGxvb2tzIGxpa2UgYSBidWcgdGhlbiBw
bGVhc2UgYWR2aXNlIGFuZCBJJiMzOTtsbCByYWlzZSBhbiBBQ1BJQ0EgYnVnLjwvZGl2PjxkaXY+
PGJyPjwvZGl2PjxkaXY+VGhhbmtzLDwvZGl2PjxkaXY+RGV2aW48L2Rpdj48ZGl2Pjxicj48L2Rp
dj48ZGl2Pjxicj48L2Rpdj48L2Rpdj4K

--===============5802137250902511901==--

