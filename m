Content-Type: multipart/mixed; boundary="===============3088908070886145568=="
MIME-Version: 1.0
From: Devin Steffler <devinsteffler at gmail.com>
Subject: Re: [Devel] question about ACPICA internal cache manager
Date: Tue, 06 Jun 2017 08:46:22 -0400
Message-ID: <CAAuRk_jL5Q2ydrf4z3hbMRwW93p5jqxTKUpqV-h0n+WgtB9TbQ@mail.gmail.com>
In-Reply-To: CAAuRk_g+fC5pWXKzCsFuA7aK5ONkunmD+_3s-qMviT2H137inA@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3088908070886145568==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

I have added a call to AcpiPurgeCachedObjects at the end of each poll.

The code is calling _PSR, _STA, _BIF, and _BST every two seconds. The
memory leak seems to be with _BIF as I don't get a leak if I comment that
portion out. I believe that ACPICA is allocating objects in the cache but
not releasing them during calls to AcpiEvaluateObject for the _BIF control
method. Is there a way that I can verify this is the case? What is the best
way to troubleshoot this?

Thanks,
Devin




On Mon, Jun 5, 2017 at 2:59 PM, Devin Steffler <devinsteffler(a)gmail.com>
wrote:

> Hello,
>
> Note: I'm using ACPICA version 20170303.
>
> In my ACPICA OSL, for QNX, I am using the ACPICA internal cache manager by
> defining ACPI_USE_LOCAL_CACHE.
>
> Is it expected that my OSL will periodically call AcpiPurgeCachedObjects
> to free the cached objects? Currently I am not calling it at all.
>
> I'm asking because I appear to have a small memory leak relating to ACPICA
> cached objects.
>
> My ACPICA OSL basically does this every couple seconds:
> // ----------------------------------------------------------
>    Results.Length =3D ACPI_ALLOCATE_BUFFER;
>    Results.Pointer =3D NULL;
>    status =3D AcpiEvaluateObject(gBattery[i], "_BST", NULL, &Results);
> // ...
>    if (NULL !=3D Results.Pointer) {
>     AcpiOsFree(Results.Pointer);
>    }
> // ----------------------------------------------------------
>
> I have Valgrind running on my OSL and it points to the ACPICA cache
> (utcache.c) as the cause of the memory leak. An example is below:
> // ----------------------------------------------------------
> =3D=3D435478549=3D=3D 20,670 (15,180 direct, 5,490 indirect) bytes in 345=
 blocks
> are definitely lost in loss record 165 of 170
> =3D=3D435478549=3D=3D    at 0xC7E3D: malloc (vg_replace_malloc.c:306 in
> /usr/lib/valgrind/vgpreload_memcheck-x86-nto.so)
> =3D=3D435478549=3D=3D    by 0x8049A26: AcpiOsAllocate (osl.c:169 in
> /devin/acpi-qnx)
> =3D=3D435478549=3D=3D    by 0x8057451: AcpiOsAllocateZeroed (utalloc.c:18=
5 in
> /devin/acpi-qnx)
> =3D=3D435478549=3D=3D    by 0x8057010: AcpiOsAcquireObject (utcache.c:452=
 in
> /devin/acpi-qnx)
> =3D=3D435478549=3D=3D    by 0x80511D7: AcpiUtAllocateObjectDescDbg (utobj=
ect.c:548
> in /devin/acpi-qnx)
> =3D=3D435478549=3D=3D    by 0x8050AFD: AcpiUtCreateInternalObjectDbg
> (utobject.c:218 in /devin/acpi-qnx)
> =3D=3D435478549=3D=3D    by 0x8095F9D: AcpiDsCreateOperand (dsutils.c:820=
 in
> /devin/acpi-qnx)
> =3D=3D435478549=3D=3D    by 0x8096268: AcpiDsCreateOperands (dsutils.c:91=
5 in
> /devin/acpi-qnx)
> =3D=3D435478549=3D=3D    by 0x80948E7: AcpiDsExecEndOp (dswexec.c:559 in
> /devin/acpi-qnx)
> =3D=3D435478549=3D=3D    by 0x8065063: AcpiPsParseLoop (psloop.c:765 in
> /devin/acpi-qnx)
> =3D=3D435478549=3D=3D    by 0x8062C35: AcpiPsParseAml (psparse.c:632 in
> /devin/acpi-qnx)
> =3D=3D435478549=3D=3D    by 0x80616BC: AcpiPsExecuteMethod (psxface.c:349=
 in
> /devin/acpi-qnx)
> =3D=3D435478549=3D=3D    by 0x806EAD1: AcpiNsEvaluate (nseval.c:359 in
> /devin/acpi-qnx)
> =3D=3D435478549=3D=3D    by 0x8067482: AcpiEvaluateObject (nsxfeval.c:503=
 in
> /devin/acpi-qnx)
> // ----------------------------------------------------------
>
> On exit, a call to AcpiTerminate is made and it doesn't free up the memory
> as well.
>
> Any tips on troubleshooting this would be greatly appreciated. If it looks
> like a bug then please advise and I'll raise an ACPICA bug.
>
> Thanks,
> Devin
>
>
>

--===============3088908070886145568==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj5IZWxsbyw8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkkgaGF2
ZSBhZGRlZCBhIGNhbGwgdG8gQWNwaVB1cmdlQ2FjaGVkT2JqZWN0cyBhdCB0aGUgZW5kIG9mIGVh
Y2ggcG9sbC48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlRoZSBjb2RlIGlzIGNhbGxpbmcgX1BT
UiwgX1NUQSwgX0JJRiwgYW5kIF9CU1QgZXZlcnkgdHdvIHNlY29uZHMuIFRoZSBtZW1vcnkgbGVh
ayBzZWVtcyB0byBiZSB3aXRoIF9CSUYgYXMgSSBkb24mIzM5O3QgZ2V0IGEgbGVhayBpZiBJIGNv
bW1lbnQgdGhhdCBwb3J0aW9uIG91dC4gSSBiZWxpZXZlIHRoYXQgQUNQSUNBIGlzIGFsbG9jYXRp
bmcgb2JqZWN0cyBpbiB0aGUgY2FjaGUgYnV0IG5vdCByZWxlYXNpbmcgdGhlbSBkdXJpbmcgY2Fs
bHMgdG8gQWNwaUV2YWx1YXRlT2JqZWN0IGZvciB0aGUgX0JJRiBjb250cm9sIG1ldGhvZC4gSXMg
dGhlcmUgYSB3YXkgdGhhdCBJIGNhbiB2ZXJpZnkgdGhpcyBpcyB0aGUgY2FzZT8gV2hhdCBpcyB0
aGUgYmVzdCB3YXkgdG8gdHJvdWJsZXNob290IHRoaXM/PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRp
dj5UaGFua3MsPGJyPkRldmluPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRp
dj48YnI+PC9kaXY+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPjxicj48ZGl2IGNsYXNz
PSJnbWFpbF9xdW90ZSI+T24gTW9uLCBKdW4gNSwgMjAxNyBhdCAyOjU5IFBNLCBEZXZpbiBTdGVm
ZmxlciA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhyZWY9Im1haWx0bzpkZXZpbnN0ZWZmbGVyQGdt
YWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmRldmluc3RlZmZsZXJAZ21haWwuY29tPC9hPiZndDs8
L3NwYW4+IHdyb3RlOjxicj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJt
YXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6
MWV4Ij48ZGl2IGRpcj0ibHRyIj48ZGl2PkhlbGxvLDwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+
Tm90ZTogSSYjMzk7bSB1c2luZyBBQ1BJQ0EgdmVyc2lvbiAyMDE3MDMwMy48L2Rpdj48ZGl2Pjxi
cj48L2Rpdj48ZGl2PkluIG15IEFDUElDQSBPU0wsIGZvciBRTlgsIEkgYW0gdXNpbmcgdGhlIEFD
UElDQSBpbnRlcm5hbCBjYWNoZSBtYW5hZ2VyIGJ5IGRlZmluaW5nIEFDUElfVVNFX0xPQ0FMX0NB
Q0hFLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SXMgaXQgZXhwZWN0ZWQgdGhhdCBteSBPU0wg
d2lsbCBwZXJpb2RpY2FsbHkgY2FsbCBBY3BpUHVyZ2VDYWNoZWRPYmplY3RzIHRvIGZyZWUgdGhl
IGNhY2hlZCBvYmplY3RzPyBDdXJyZW50bHkgSSBhbSBub3QgY2FsbGluZyBpdCBhdCBhbGwuPC9k
aXY+PGRpdj48YnI+PC9kaXY+PGRpdj5JJiMzOTttIGFza2luZyBiZWNhdXNlIEkgYXBwZWFyIHRv
IGhhdmUgYSBzbWFsbCBtZW1vcnkgbGVhayByZWxhdGluZyB0byBBQ1BJQ0EgY2FjaGVkIG9iamVj
dHMuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5NeSBBQ1BJQ0EgT1NMIGJhc2ljYWxseSBkb2Vz
IHRoaXMgZXZlcnkgY291cGxlIHNlY29uZHM6PC9kaXY+PGRpdj4vLyAtLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS08d2JyPi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08YnI+wqDCoMKg
UmVzdWx0cy5MZW5ndGggPSBBQ1BJX0FMTE9DQVRFX0JVRkZFUjs8YnI+wqDCoMKgUmVzdWx0cy5Q
b2ludGVyID0gTlVMTDs8YnI+wqDCoMKgc3RhdHVzID0gQWNwaUV2YWx1YXRlT2JqZWN0KGdCYXR0
ZXJ5W2ldPHdicj4sICZxdW90O19CU1QmcXVvdDssIE5VTEwsICZhbXA7UmVzdWx0cyk7PGJyPi8v
IC4uLjxicj7CoMKgwqBpZiAoTlVMTCAhPSBSZXN1bHRzLlBvaW50ZXIpIHs8YnI+wqDCoMKgwqBB
Y3BpT3NGcmVlKFJlc3VsdHMuPHdicj5Qb2ludGVyKTs8YnI+wqDCoMKgfTwvZGl2PjxkaXY+Ly8g
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPHdicj4tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tPGJyPjxicj48L2Rpdj48ZGl2PkkgaGF2ZSBWYWxncmluZCBydW5uaW5nIG9uIG15IE9T
TCBhbmQgaXQgcG9pbnRzIHRvIHRoZSBBQ1BJQ0EgY2FjaGUgKHV0Y2FjaGUuYykgYXMgdGhlIGNh
dXNlIG9mIHRoZSBtZW1vcnkgbGVhay4gQW4gZXhhbXBsZSBpcyBiZWxvdzo8L2Rpdj48ZGl2Pi8v
IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTx3YnI+LS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLTxicj49PTQzNTQ3ODU0OT09IDIwLDY3MCAoMTUsMTgwIGRpcmVjdCwgNSw0OTAgaW5k
aXJlY3QpIGJ5dGVzIGluIDM0NSBibG9ja3MgYXJlIGRlZmluaXRlbHkgbG9zdCBpbiBsb3NzIHJl
Y29yZCAxNjUgb2YgMTcwPGJyPj09NDM1NDc4NTQ5PT3CoMKgwqAgYXQgMHhDN0UzRDogbWFsbG9j
ICh2Z19yZXBsYWNlX21hbGxvYy5jOjMwNiBpbiAvdXNyL2xpYi92YWxncmluZC92Z3ByZWxvYWRf
PHdicj5tZW1jaGVjay14ODYtbnRvLnNvKTxicj49PTQzNTQ3ODU0OT09wqDCoMKgIGJ5IDB4ODA0
OUEyNjogQWNwaU9zQWxsb2NhdGUgKG9zbC5jOjE2OSBpbiAvZGV2aW4vYWNwaS1xbngpPGJyPj09
NDM1NDc4NTQ5PT3CoMKgwqAgYnkgMHg4MDU3NDUxOiBBY3BpT3NBbGxvY2F0ZVplcm9lZCAodXRh
bGxvYy5jOjE4NSBpbiAvZGV2aW4vYWNwaS1xbngpPGJyPj09NDM1NDc4NTQ5PT3CoMKgwqAgYnkg
MHg4MDU3MDEwOiBBY3BpT3NBY3F1aXJlT2JqZWN0ICh1dGNhY2hlLmM6NDUyIGluIC9kZXZpbi9h
Y3BpLXFueCk8YnI+PT00MzU0Nzg1NDk9PcKgwqDCoCBieSAweDgwNTExRDc6IEFjcGlVdEFsbG9j
YXRlT2JqZWN0RGVzY0RiZyAodXRvYmplY3QuYzo1NDggaW4gL2RldmluL2FjcGktcW54KTxicj49
PTQzNTQ3ODU0OT09wqDCoMKgIGJ5IDB4ODA1MEFGRDogQWNwaVV0Q3JlYXRlSW50ZXJuYWxPYmpl
Y3REYmcgKHV0b2JqZWN0LmM6MjE4IGluIC9kZXZpbi9hY3BpLXFueCk8YnI+PT00MzU0Nzg1NDk9
PcKgwqDCoCBieSAweDgwOTVGOUQ6IEFjcGlEc0NyZWF0ZU9wZXJhbmQgKGRzdXRpbHMuYzo4MjAg
aW4gL2RldmluL2FjcGktcW54KTxicj49PTQzNTQ3ODU0OT09wqDCoMKgIGJ5IDB4ODA5NjI2ODog
QWNwaURzQ3JlYXRlT3BlcmFuZHMgKGRzdXRpbHMuYzo5MTUgaW4gL2RldmluL2FjcGktcW54KTxi
cj49PTQzNTQ3ODU0OT09wqDCoMKgIGJ5IDB4ODA5NDhFNzogQWNwaURzRXhlY0VuZE9wIChkc3dl
eGVjLmM6NTU5IGluIC9kZXZpbi9hY3BpLXFueCk8YnI+PT00MzU0Nzg1NDk9PcKgwqDCoCBieSAw
eDgwNjUwNjM6IEFjcGlQc1BhcnNlTG9vcCAocHNsb29wLmM6NzY1IGluIC9kZXZpbi9hY3BpLXFu
eCk8YnI+PT00MzU0Nzg1NDk9PcKgwqDCoCBieSAweDgwNjJDMzU6IEFjcGlQc1BhcnNlQW1sIChw
c3BhcnNlLmM6NjMyIGluIC9kZXZpbi9hY3BpLXFueCk8YnI+PT00MzU0Nzg1NDk9PcKgwqDCoCBi
eSAweDgwNjE2QkM6IEFjcGlQc0V4ZWN1dGVNZXRob2QgKHBzeGZhY2UuYzozNDkgaW4gL2Rldmlu
L2FjcGktcW54KTxicj49PTQzNTQ3ODU0OT09wqDCoMKgIGJ5IDB4ODA2RUFEMTogQWNwaU5zRXZh
bHVhdGUgKG5zZXZhbC5jOjM1OSBpbiAvZGV2aW4vYWNwaS1xbngpPGJyPj09NDM1NDc4NTQ5PT3C
oMKgwqAgYnkgMHg4MDY3NDgyOiBBY3BpRXZhbHVhdGVPYmplY3QgKG5zeGZldmFsLmM6NTAzIGlu
IC9kZXZpbi9hY3BpLXFueCk8L2Rpdj48ZGl2Pi8vIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLTx3YnI+LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTwvZGl2PjxkaXY+PGJyPjwvZGl2
PjxkaXY+T24gZXhpdCwgYSBjYWxsIHRvIEFjcGlUZXJtaW5hdGUgaXMgbWFkZSBhbmQgaXQgZG9l
c24mIzM5O3QgZnJlZSB1cCB0aGUgbWVtb3J5IGFzIHdlbGwuPC9kaXY+PGRpdj48YnI+PC9kaXY+
PGRpdj5BbnkgdGlwcyBvbiB0cm91Ymxlc2hvb3RpbmcgdGhpcyB3b3VsZCBiZSBncmVhdGx5IGFw
cHJlY2lhdGVkLiBJZiBpdCBsb29rcyBsaWtlIGEgYnVnIHRoZW4gcGxlYXNlIGFkdmlzZSBhbmQg
SSYjMzk7bGwgcmFpc2UgYW4gQUNQSUNBIGJ1Zy48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlRo
YW5rcyw8L2Rpdj48ZGl2PkRldmluPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+
PC9kaXY+CjwvYmxvY2txdW90ZT48L2Rpdj48YnI+PC9kaXY+Cg==

--===============3088908070886145568==--

