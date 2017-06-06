Content-Type: multipart/mixed; boundary="===============7545493403688839497=="
MIME-Version: 1.0
From: Devin Steffler <devinsteffler at gmail.com>
Subject: Re: [Devel] question about ACPICA internal cache manager
Date: Tue, 06 Jun 2017 12:39:09 -0400
Message-ID: <CAAuRk_i7si8xDfZ_-tWV8UAa_9-WW+avMR3-VwSJjvvkuYFRhQ@mail.gmail.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E37E5BF08E@ORSMSX110.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7545493403688839497==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I have raised the following bug:
http://bugs.acpica.org/show_bug.cgi?id=3D1392

I have attached the acpidump files to the bug.


On Tue, Jun 6, 2017 at 11:36 AM, Moore, Robert <robert.moore(a)intel.com>
wrote:

> Please send the acpidump for the machines (or at least one of them).
>
>
>
> Thanks.
>
>
>
>
>
> *From:* Devel [mailto:devel-bounces(a)acpica.org] *On Behalf Of *Devin
> Steffler
> *Sent:* Tuesday, June 6, 2017 7:01 AM
> *To:* devel(a)acpica.org
> *Subject:* Re: [Devel] question about ACPICA internal cache manager
>
>
>
> Is my following assumption correct?
>
> - Upon returning from AcpiEvaluateObject, ACPICA will have released to the
> cache all objects that were acquired from the cache in order to complete
> AcpiEvaluateObject.
>
>
>
> Are there any situations where AcpiEvaluateObject will acquire objects
> from the cache but not release them prior to returning from
> AcpiEvaluateObject? If yes, then what are those cases?
>
>
>
> Without any other guidance, I think this is a bug in ACPICA so I will
> raise a bug. I've tested my OSL on three laptops and each one gives
> different results:
>
> - Reading battery info 1 time     on Dell Latitude E6430:        0 bytes
> leaked
>
> - Reading battery info 10 times on Dell Latitude E6430:        0 bytes
> leaked
>
> - Reading battery info 1 time    on ASUS F555U:               152 bytes
> leaked
>
> - Reading battery info 10 times on ASUS F555U:            1520 bytes leak=
ed
>
> - Reading battery info 1 time    on Lenovo E460:               438 bytes
> leaked
>
> - Reading battery info 10 times on Lenovo E460:            4380 bytes
> leaked
>
>
>
> Attached are some more details on the leaks.
>
>
>
> Thanks,
>
> Devin
>
>
>
>
>
>
>
> On Tue, Jun 6, 2017 at 8:46 AM, Devin Steffler <devinsteffler(a)gmail.com>
> wrote:
>
> Hello,
>
>
>
> I have added a call to AcpiPurgeCachedObjects at the end of each poll.
>
>
>
> The code is calling _PSR, _STA, _BIF, and _BST every two seconds. The
> memory leak seems to be with _BIF as I don't get a leak if I comment that
> portion out. I believe that ACPICA is allocating objects in the cache but
> not releasing them during calls to AcpiEvaluateObject for the _BIF control
> method. Is there a way that I can verify this is the case? What is the be=
st
> way to troubleshoot this?
>
>
>
> Thanks,
> Devin
>
>
>
>
>
>
>
>
>
> On Mon, Jun 5, 2017 at 2:59 PM, Devin Steffler <devinsteffler(a)gmail.com>
> wrote:
>
> Hello,
>
>
>
> Note: I'm using ACPICA version 20170303.
>
>
>
> In my ACPICA OSL, for QNX, I am using the ACPICA internal cache manager by
> defining ACPI_USE_LOCAL_CACHE.
>
>
>
> Is it expected that my OSL will periodically call AcpiPurgeCachedObjects
> to free the cached objects? Currently I am not calling it at all.
>
>
>
> I'm asking because I appear to have a small memory leak relating to ACPICA
> cached objects.
>
>
>
> My ACPICA OSL basically does this every couple seconds:
>
> // ----------------------------------------------------------
>    Results.Length =3D ACPI_ALLOCATE_BUFFER;
>    Results.Pointer =3D NULL;
>    status =3D AcpiEvaluateObject(gBattery[i], "_BST", NULL, &Results);
> // ...
>    if (NULL !=3D Results.Pointer) {
>     AcpiOsFree(Results.Pointer);
>    }
>
> // ----------------------------------------------------------
>
> I have Valgrind running on my OSL and it points to the ACPICA cache
> (utcache.c) as the cause of the memory leak. An example is below:
>
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
>
> // ----------------------------------------------------------
>
>
>
> On exit, a call to AcpiTerminate is made and it doesn't free up the memory
> as well.
>
>
>
> Any tips on troubleshooting this would be greatly appreciated. If it looks
> like a bug then please advise and I'll raise an ACPICA bug.
>
>
>
> Thanks,
>
> Devin
>
>
>
>
>
>
>
>
>

--===============7545493403688839497==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj5JIGhhdmUgcmFpc2VkIHRoZSBmb2xsb3dpbmcgYnVnOjwvZGl2
PjxkaXY+PGEgaHJlZj0iaHR0cDovL2J1Z3MuYWNwaWNhLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MTM5
MiI+aHR0cDovL2J1Z3MuYWNwaWNhLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MTM5MjwvYT48L2Rpdj48
ZGl2Pjxicj48L2Rpdj48ZGl2PkkgaGF2ZSBhdHRhY2hlZCB0aGUgYWNwaWR1bXAgZmlsZXMgdG8g
dGhlIGJ1Zy48L2Rpdj48ZGl2Pjxicj48L2Rpdj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9leHRy
YSI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj5PbiBUdWUsIEp1biA2LCAyMDE3IGF0IDEx
OjM2IEFNLCBNb29yZSwgUm9iZXJ0IDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJlZj0ibWFpbHRv
OnJvYmVydC5tb29yZUBpbnRlbC5jb20iIHRhcmdldD0iX2JsYW5rIj5yb2JlcnQubW9vcmVAaW50
ZWwuY29tPC9hPiZndDs8L3NwYW4+IHdyb3RlOjxicj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxf
cXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xp
ZDtwYWRkaW5nLWxlZnQ6MWV4Ij4KCgoKCgo8ZGl2IGxhbmc9IkVOLVVTIiB2bGluaz0icHVycGxl
IiBsaW5rPSJibHVlIj4KPGRpdiBjbGFzcz0ibV8zNjk1NDgyMTI1NTgxNjc3NDMyV29yZFNlY3Rp
b24xIj4KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOnJnYigzMSw3Mywx
MjUpO2ZvbnQtZmFtaWx5OiZxdW90O0NhbGlicmkmcXVvdDssc2Fucy1zZXJpZjtmb250LXNpemU6
MTFwdCI+UGxlYXNlIHNlbmQgdGhlIGFjcGlkdW1wIGZvciB0aGUgbWFjaGluZXMgKG9yIGF0IGxl
YXN0IG9uZSBvZiB0aGVtKS48dT48L3U+PHU+PC91Pjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29O
b3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjpyZ2IoMzEsNzMsMTI1KTtmb250LWZhbWlseTomcXVv
dDtDYWxpYnJpJnF1b3Q7LHNhbnMtc2VyaWY7Zm9udC1zaXplOjExcHQiPjx1PjwvdT7CoDx1Pjwv
dT48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6cmdi
KDMxLDczLDEyNSk7Zm9udC1mYW1pbHk6JnF1b3Q7Q2FsaWJyaSZxdW90OyxzYW5zLXNlcmlmO2Zv
bnQtc2l6ZToxMXB0Ij5UaGFua3MuPHU+PC91Pjx1PjwvdT48L3NwYW4+PC9wPgo8cCBjbGFzcz0i
TXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6cmdiKDMxLDczLDEyNSk7Zm9udC1mYW1pbHk6
JnF1b3Q7Q2FsaWJyaSZxdW90OyxzYW5zLXNlcmlmO2ZvbnQtc2l6ZToxMXB0Ij48dT48L3U+wqA8
dT48L3U+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9y
OnJnYigzMSw3MywxMjUpO2ZvbnQtZmFtaWx5OiZxdW90O0NhbGlicmkmcXVvdDssc2Fucy1zZXJp
Zjtmb250LXNpemU6MTFwdCI+PHU+PC91PsKgPHU+PC91Pjwvc3Bhbj48L3A+CjxkaXYgc3R5bGU9
ImJvcmRlci13aWR0aDptZWRpdW0gbWVkaXVtIG1lZGl1bSAxLjVwdDtib3JkZXItc3R5bGU6bm9u
ZSBub25lIG5vbmUgc29saWQ7Ym9yZGVyLWNvbG9yOmN1cnJlbnRDb2xvciBjdXJyZW50Q29sb3Ig
Y3VycmVudENvbG9yIGJsdWU7cGFkZGluZzowaW4gMGluIDBpbiA0cHQiPgo8ZGl2Pgo8ZGl2IHN0
eWxlPSJib3JkZXItd2lkdGg6MXB0IG1lZGl1bSBtZWRpdW07Ym9yZGVyLXN0eWxlOnNvbGlkIG5v
bmUgbm9uZTtib3JkZXItY29sb3I6cmdiKDIyNSwyMjUsMjI1KSBjdXJyZW50Q29sb3IgY3VycmVu
dENvbG9yO3BhZGRpbmc6M3B0IDBpbiAwaW4iPgo8cCBjbGFzcz0iTXNvTm9ybWFsIj48Yj48c3Bh
biBzdHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7Q2FsaWJyaSZxdW90OyxzYW5zLXNlcmlmO2ZvbnQt
c2l6ZToxMXB0Ij5Gcm9tOjwvc3Bhbj48L2I+PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90
O0NhbGlicmkmcXVvdDssc2Fucy1zZXJpZjtmb250LXNpemU6MTFwdCI+IERldmVsIFttYWlsdG86
PGEgaHJlZj0ibWFpbHRvOmRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZyIgdGFyZ2V0PSJfYmxhbmsi
PmRldmVsLWJvdW5jZXNAYWNwaWNhLjx3YnI+b3JnPC9hPl0KPGI+T24gQmVoYWxmIE9mIDwvYj5E
ZXZpbiBTdGVmZmxlcjxicj4KPGI+U2VudDo8L2I+IFR1ZXNkYXksIEp1bmUgNiwgMjAxNyA3OjAx
IEFNPGJyPgo8Yj5Ubzo8L2I+IDxhIGhyZWY9Im1haWx0bzpkZXZlbEBhY3BpY2Eub3JnIiB0YXJn
ZXQ9Il9ibGFuayI+ZGV2ZWxAYWNwaWNhLm9yZzwvYT48YnI+CjxiPlN1YmplY3Q6PC9iPiBSZTog
W0RldmVsXSBxdWVzdGlvbiBhYm91dCBBQ1BJQ0EgaW50ZXJuYWwgY2FjaGUgbWFuYWdlcjx1Pjwv
dT48dT48L3U+PC9zcGFuPjwvcD4KPC9kaXY+CjwvZGl2PjxkaXY+PGRpdiBjbGFzcz0iaDUiPgo8
cCBjbGFzcz0iTXNvTm9ybWFsIj48dT48L3U+wqA8dT48L3U+PC9wPgo8ZGl2Pgo8ZGl2Pgo8cCBj
bGFzcz0iTXNvTm9ybWFsIj5JcyBteSBmb2xsb3dpbmcgYXNzdW1wdGlvbiBjb3JyZWN0Pzx1Pjwv
dT48dT48L3U+PC9wPgo8L2Rpdj4KPGRpdj4KPHAgY2xhc3M9Ik1zb05vcm1hbCI+LSBVcG9uIHJl
dHVybmluZyBmcm9tIEFjcGlFdmFsdWF0ZU9iamVjdCwgQUNQSUNBIHdpbGwgaGF2ZSByZWxlYXNl
ZCB0byB0aGUgY2FjaGUgYWxsIG9iamVjdHMgdGhhdCB3ZXJlIGFjcXVpcmVkIGZyb20gdGhlIGNh
Y2hlIGluIG9yZGVyIHRvIGNvbXBsZXRlIEFjcGlFdmFsdWF0ZU9iamVjdC48dT48L3U+PHU+PC91
PjwvcD4KPC9kaXY+CjxkaXY+CjxwIGNsYXNzPSJNc29Ob3JtYWwiPjx1PjwvdT7CoDx1PjwvdT48
L3A+CjwvZGl2Pgo8ZGl2Pgo8cCBjbGFzcz0iTXNvTm9ybWFsIj5BcmUgdGhlcmUgYW55IHNpdHVh
dGlvbnMgd2hlcmUgQWNwaUV2YWx1YXRlT2JqZWN0IHdpbGwgYWNxdWlyZSBvYmplY3RzIGZyb20g
dGhlIGNhY2hlIGJ1dCBub3QgcmVsZWFzZSB0aGVtIHByaW9yIHRvIHJldHVybmluZyBmcm9tIEFj
cGlFdmFsdWF0ZU9iamVjdD8gSWYgeWVzLCB0aGVuIHdoYXQgYXJlIHRob3NlIGNhc2VzPzx1Pjwv
dT48dT48L3U+PC9wPgo8L2Rpdj4KPGRpdj4KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHU+PC91PsKg
PHU+PC91PjwvcD4KPC9kaXY+CjxkaXY+CjxwIGNsYXNzPSJNc29Ob3JtYWwiPldpdGhvdXQgYW55
IG90aGVyIGd1aWRhbmNlLCBJIHRoaW5rIHRoaXMgaXMgYSBidWcgaW4gQUNQSUNBIHNvIEkgd2ls
bCByYWlzZSBhIGJ1Zy4gSSYjMzk7dmUgdGVzdGVkIG15IE9TTCBvbiB0aHJlZSBsYXB0b3BzIGFu
ZCBlYWNoIG9uZSBnaXZlcyBkaWZmZXJlbnQgcmVzdWx0czo8dT48L3U+PHU+PC91PjwvcD4KPC9k
aXY+CjxkaXY+CjxkaXY+CjxwIGNsYXNzPSJNc29Ob3JtYWwiPi0gUmVhZGluZyBiYXR0ZXJ5IGlu
Zm8gMSB0aW1lwqDCoMKgwqAgb24gRGVsbCBMYXRpdHVkZSBFNjQzMDrCoCDCoMKgwqDCoMKgIDAg
Ynl0ZXMgbGVha2VkPHU+PC91Pjx1PjwvdT48L3A+CjwvZGl2Pgo8cCBjbGFzcz0iTXNvTm9ybWFs
Ij4tIFJlYWRpbmcgYmF0dGVyeSBpbmZvIDEwIHRpbWVzIG9uIERlbGwgTGF0aXR1ZGUgRTY0MzA6
wqDCoMKgwqAgwqDCoCAwIGJ5dGVzIGxlYWtlZDx1PjwvdT48dT48L3U+PC9wPgo8L2Rpdj4KPGRp
dj4KPGRpdj4KPHAgY2xhc3M9Ik1zb05vcm1hbCI+LSBSZWFkaW5nIGJhdHRlcnkgaW5mbyAxIHRp
bWXCoMKgIMKgb24gQVNVUyBGNTU1VTrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDE1MiBi
eXRlcyBsZWFrZWQ8dT48L3U+PHU+PC91PjwvcD4KPC9kaXY+CjxwIGNsYXNzPSJNc29Ob3JtYWwi
Pi0gUmVhZGluZyBiYXR0ZXJ5IGluZm8gMTAgdGltZXMgb24gQVNVUyBGNTU1VTrCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIDE1MjAgYnl0ZXMgbGVha2VkPHU+PC91Pjx1PjwvdT48L3A+CjwvZGl2Pgo8
ZGl2Pgo8ZGl2Pgo8cCBjbGFzcz0iTXNvTm9ybWFsIj4tIFJlYWRpbmcgYmF0dGVyeSBpbmZvIDEg
dGltZcKgwqDCoMKgb24gTGVub3ZvIEU0NjA6wqDCoMKgwqDCoMKgwqAgwqDCoMKgwqDCoMKgIDQz
OCBieXRlcyBsZWFrZWQ8dT48L3U+PHU+PC91PjwvcD4KPC9kaXY+CjxwIGNsYXNzPSJNc29Ob3Jt
YWwiPi0gUmVhZGluZyBiYXR0ZXJ5IGluZm8gMTAgdGltZXMgb24gTGVub3ZvIEU0NjA6wqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgNDM4MCBieXRlcyBsZWFrZWQ8dT48L3U+PHU+PC91PjwvcD4KPC9k
aXY+CjxkaXY+CjxwIGNsYXNzPSJNc29Ob3JtYWwiPjx1PjwvdT7CoDx1PjwvdT48L3A+CjwvZGl2
Pgo8ZGl2Pgo8cCBjbGFzcz0iTXNvTm9ybWFsIj5BdHRhY2hlZCBhcmUgc29tZSBtb3JlIGRldGFp
bHMgb24gdGhlIGxlYWtzLjx1PjwvdT48dT48L3U+PC9wPgo8L2Rpdj4KPGRpdj4KPHAgY2xhc3M9
Ik1zb05vcm1hbCI+PHU+PC91PsKgPHU+PC91PjwvcD4KPC9kaXY+CjxkaXY+CjxwIGNsYXNzPSJN
c29Ob3JtYWwiPlRoYW5rcyw8dT48L3U+PHU+PC91PjwvcD4KPC9kaXY+CjxkaXY+CjxwIGNsYXNz
PSJNc29Ob3JtYWwiPkRldmluPHU+PC91Pjx1PjwvdT48L3A+CjwvZGl2Pgo8ZGl2Pgo8cCBjbGFz
cz0iTXNvTm9ybWFsIj48dT48L3U+wqA8dT48L3U+PC9wPgo8L2Rpdj4KPGRpdj4KPHAgY2xhc3M9
Ik1zb05vcm1hbCI+PHU+PC91PsKgPHU+PC91PjwvcD4KPC9kaXY+CjwvZGl2Pgo8ZGl2Pgo8cCBj
bGFzcz0iTXNvTm9ybWFsIj48dT48L3U+wqA8dT48L3U+PC9wPgo8ZGl2Pgo8cCBjbGFzcz0iTXNv
Tm9ybWFsIj5PbiBUdWUsIEp1biA2LCAyMDE3IGF0IDg6NDYgQU0sIERldmluIFN0ZWZmbGVyICZs
dDs8YSBocmVmPSJtYWlsdG86ZGV2aW5zdGVmZmxlckBnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5r
Ij5kZXZpbnN0ZWZmbGVyQGdtYWlsLmNvbTwvYT4mZ3Q7IHdyb3RlOjx1PjwvdT48dT48L3U+PC9w
Pgo8YmxvY2txdW90ZSBzdHlsZT0iYm9yZGVyLXdpZHRoOm1lZGl1bSBtZWRpdW0gbWVkaXVtIDFw
dDtib3JkZXItc3R5bGU6bm9uZSBub25lIG5vbmUgc29saWQ7Ym9yZGVyLWNvbG9yOmN1cnJlbnRD
b2xvciBjdXJyZW50Q29sb3IgY3VycmVudENvbG9yIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZzow
aW4gMGluIDBpbiA2cHQ7bWFyZ2luLXJpZ2h0OjBpbjttYXJnaW4tbGVmdDo0LjhwdCI+CjxkaXY+
CjxkaXY+CjxwIGNsYXNzPSJNc29Ob3JtYWwiPkhlbGxvLDx1PjwvdT48dT48L3U+PC9wPgo8L2Rp
dj4KPGRpdj4KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHU+PC91PsKgPHU+PC91PjwvcD4KPC9kaXY+
CjxkaXY+CjxwIGNsYXNzPSJNc29Ob3JtYWwiPkkgaGF2ZSBhZGRlZCBhIGNhbGwgdG8gQWNwaVB1
cmdlQ2FjaGVkT2JqZWN0cyBhdCB0aGUgZW5kIG9mIGVhY2ggcG9sbC48dT48L3U+PHU+PC91Pjwv
cD4KPC9kaXY+CjxkaXY+CjxwIGNsYXNzPSJNc29Ob3JtYWwiPjx1PjwvdT7CoDx1PjwvdT48L3A+
CjwvZGl2Pgo8ZGl2Pgo8cCBjbGFzcz0iTXNvTm9ybWFsIj5UaGUgY29kZSBpcyBjYWxsaW5nIF9Q
U1IsIF9TVEEsIF9CSUYsIGFuZCBfQlNUIGV2ZXJ5IHR3byBzZWNvbmRzLiBUaGUgbWVtb3J5IGxl
YWsgc2VlbXMgdG8gYmUgd2l0aCBfQklGIGFzIEkgZG9uJiMzOTt0IGdldCBhIGxlYWsgaWYgSSBj
b21tZW50IHRoYXQgcG9ydGlvbiBvdXQuIEkgYmVsaWV2ZSB0aGF0IEFDUElDQSBpcyBhbGxvY2F0
aW5nIG9iamVjdHMgaW4gdGhlIGNhY2hlIGJ1dCBub3QgcmVsZWFzaW5nIHRoZW0KIGR1cmluZyBj
YWxscyB0byBBY3BpRXZhbHVhdGVPYmplY3QgZm9yIHRoZSBfQklGIGNvbnRyb2wgbWV0aG9kLiBJ
cyB0aGVyZSBhIHdheSB0aGF0IEkgY2FuIHZlcmlmeSB0aGlzIGlzIHRoZSBjYXNlPyBXaGF0IGlz
IHRoZSBiZXN0IHdheSB0byB0cm91Ymxlc2hvb3QgdGhpcz88dT48L3U+PHU+PC91PjwvcD4KPC9k
aXY+CjxkaXY+CjxwIGNsYXNzPSJNc29Ob3JtYWwiPjx1PjwvdT7CoDx1PjwvdT48L3A+CjwvZGl2
Pgo8ZGl2Pgo8cCBjbGFzcz0iTXNvTm9ybWFsIj5UaGFua3MsPGJyPgpEZXZpbjx1PjwvdT48dT48
L3U+PC9wPgo8L2Rpdj4KPGRpdj4KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHU+PC91PsKgPHU+PC91
PjwvcD4KPC9kaXY+CjxkaXY+CjxwIGNsYXNzPSJNc29Ob3JtYWwiPjx1PjwvdT7CoDx1PjwvdT48
L3A+CjwvZGl2Pgo8ZGl2Pgo8cCBjbGFzcz0iTXNvTm9ybWFsIj48dT48L3U+wqA8dT48L3U+PC9w
Pgo8L2Rpdj4KPC9kaXY+CjxkaXY+CjxkaXY+CjxkaXY+CjxwIGNsYXNzPSJNc29Ob3JtYWwiPjx1
PjwvdT7CoDx1PjwvdT48L3A+CjxkaXY+CjxwIGNsYXNzPSJNc29Ob3JtYWwiPk9uIE1vbiwgSnVu
IDUsIDIwMTcgYXQgMjo1OSBQTSwgRGV2aW4gU3RlZmZsZXIgJmx0OzxhIGhyZWY9Im1haWx0bzpk
ZXZpbnN0ZWZmbGVyQGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmRldmluc3RlZmZsZXJAZ21h
aWwuY29tPC9hPiZndDsgd3JvdGU6PHU+PC91Pjx1PjwvdT48L3A+CjxibG9ja3F1b3RlIHN0eWxl
PSJib3JkZXItd2lkdGg6bWVkaXVtIG1lZGl1bSBtZWRpdW0gMXB0O2JvcmRlci1zdHlsZTpub25l
IG5vbmUgbm9uZSBzb2xpZDtib3JkZXItY29sb3I6Y3VycmVudENvbG9yIGN1cnJlbnRDb2xvciBj
dXJyZW50Q29sb3IgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nOjBpbiAwaW4gMGluIDZwdDttYXJn
aW4tcmlnaHQ6MGluO21hcmdpbi1sZWZ0OjQuOHB0Ij4KPGRpdj4KPGRpdj4KPHAgY2xhc3M9Ik1z
b05vcm1hbCI+SGVsbG8sPHU+PC91Pjx1PjwvdT48L3A+CjwvZGl2Pgo8ZGl2Pgo8cCBjbGFzcz0i
TXNvTm9ybWFsIj48dT48L3U+wqA8dT48L3U+PC9wPgo8L2Rpdj4KPGRpdj4KPHAgY2xhc3M9Ik1z
b05vcm1hbCI+Tm90ZTogSSYjMzk7bSB1c2luZyBBQ1BJQ0EgdmVyc2lvbiAyMDE3MDMwMy48dT48
L3U+PHU+PC91PjwvcD4KPC9kaXY+CjxkaXY+CjxwIGNsYXNzPSJNc29Ob3JtYWwiPjx1PjwvdT7C
oDx1PjwvdT48L3A+CjwvZGl2Pgo8ZGl2Pgo8cCBjbGFzcz0iTXNvTm9ybWFsIj5JbiBteSBBQ1BJ
Q0EgT1NMLCBmb3IgUU5YLCBJIGFtIHVzaW5nIHRoZSBBQ1BJQ0EgaW50ZXJuYWwgY2FjaGUgbWFu
YWdlciBieSBkZWZpbmluZyBBQ1BJX1VTRV9MT0NBTF9DQUNIRS48dT48L3U+PHU+PC91PjwvcD4K
PC9kaXY+CjxkaXY+CjxwIGNsYXNzPSJNc29Ob3JtYWwiPjx1PjwvdT7CoDx1PjwvdT48L3A+Cjwv
ZGl2Pgo8ZGl2Pgo8cCBjbGFzcz0iTXNvTm9ybWFsIj5JcyBpdCBleHBlY3RlZCB0aGF0IG15IE9T
TCB3aWxsIHBlcmlvZGljYWxseSBjYWxsIEFjcGlQdXJnZUNhY2hlZE9iamVjdHMgdG8gZnJlZSB0
aGUgY2FjaGVkIG9iamVjdHM/IEN1cnJlbnRseSBJIGFtIG5vdCBjYWxsaW5nIGl0IGF0IGFsbC48
dT48L3U+PHU+PC91PjwvcD4KPC9kaXY+CjxkaXY+CjxwIGNsYXNzPSJNc29Ob3JtYWwiPjx1Pjwv
dT7CoDx1PjwvdT48L3A+CjwvZGl2Pgo8ZGl2Pgo8cCBjbGFzcz0iTXNvTm9ybWFsIj5JJiMzOTtt
IGFza2luZyBiZWNhdXNlIEkgYXBwZWFyIHRvIGhhdmUgYSBzbWFsbCBtZW1vcnkgbGVhayByZWxh
dGluZyB0byBBQ1BJQ0EgY2FjaGVkIG9iamVjdHMuPHU+PC91Pjx1PjwvdT48L3A+CjwvZGl2Pgo8
ZGl2Pgo8cCBjbGFzcz0iTXNvTm9ybWFsIj48dT48L3U+wqA8dT48L3U+PC9wPgo8L2Rpdj4KPGRp
dj4KPHAgY2xhc3M9Ik1zb05vcm1hbCI+TXkgQUNQSUNBIE9TTCBiYXNpY2FsbHkgZG9lcyB0aGlz
IGV2ZXJ5IGNvdXBsZSBzZWNvbmRzOjx1PjwvdT48dT48L3U+PC9wPgo8L2Rpdj4KPGRpdj4KPHAg
Y2xhc3M9Ik1zb05vcm1hbCI+Ly8gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPHdicj4t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPGJyPgrCoMKgwqBSZXN1bHRzLkxlbmd0aCA9IEFD
UElfQUxMT0NBVEVfQlVGRkVSOzxicj4KwqDCoMKgUmVzdWx0cy5Qb2ludGVyID0gTlVMTDs8YnI+
CsKgwqDCoHN0YXR1cyA9IEFjcGlFdmFsdWF0ZU9iamVjdChnQmF0dGVyeVtpXTx3YnI+LCAmcXVv
dDtfQlNUJnF1b3Q7LCBOVUxMLCAmYW1wO1Jlc3VsdHMpOzxicj4KLy8gLi4uPGJyPgrCoMKgwqBp
ZiAoTlVMTCAhPSBSZXN1bHRzLlBvaW50ZXIpIHs8YnI+CsKgwqDCoMKgQWNwaU9zRnJlZShSZXN1
bHRzLjx3YnI+UG9pbnRlcik7PGJyPgrCoMKgwqB9PHU+PC91Pjx1PjwvdT48L3A+CjwvZGl2Pgo8
ZGl2Pgo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0ibWFyZ2luLWJvdHRvbToxMnB0Ij4vLyAt
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08d2JyPi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS08dT48L3U+PHU+PC91PjwvcD4KPC9kaXY+CjxkaXY+CjxwIGNsYXNzPSJNc29Ob3JtYWwi
PkkgaGF2ZSBWYWxncmluZCBydW5uaW5nIG9uIG15IE9TTCBhbmQgaXQgcG9pbnRzIHRvIHRoZSBB
Q1BJQ0EgY2FjaGUgKHV0Y2FjaGUuYykgYXMgdGhlIGNhdXNlIG9mIHRoZSBtZW1vcnkgbGVhay4g
QW4gZXhhbXBsZSBpcyBiZWxvdzo8dT48L3U+PHU+PC91PjwvcD4KPC9kaXY+CjxkaXY+CjxwIGNs
YXNzPSJNc29Ob3JtYWwiPi8vIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTx3YnI+LS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTxicj4KPT00MzU0Nzg1NDk9PSAyMCw2NzAgKDE1LDE4
MCBkaXJlY3QsIDUsNDkwIGluZGlyZWN0KSBieXRlcyBpbiAzNDUgYmxvY2tzIGFyZSBkZWZpbml0
ZWx5IGxvc3QgaW4gbG9zcyByZWNvcmQgMTY1IG9mIDE3MDxicj4KPT00MzU0Nzg1NDk9PcKgwqDC
oCBhdCAweEM3RTNEOiBtYWxsb2MgKHZnX3JlcGxhY2VfbWFsbG9jLmM6MzA2IGluIC91c3IvbGli
L3ZhbGdyaW5kL3ZncHJlbG9hZF88d2JyPm1lbWNoZWNrLXg4Ni1udG8uc28pPGJyPgo9PTQzNTQ3
ODU0OT09wqDCoMKgIGJ5IDB4ODA0OUEyNjogQWNwaU9zQWxsb2NhdGUgKG9zbC5jOjE2OSBpbiAv
ZGV2aW4vYWNwaS1xbngpPGJyPgo9PTQzNTQ3ODU0OT09wqDCoMKgIGJ5IDB4ODA1NzQ1MTogQWNw
aU9zQWxsb2NhdGVaZXJvZWQgKHV0YWxsb2MuYzoxODUgaW4gL2RldmluL2FjcGktcW54KTxicj4K
PT00MzU0Nzg1NDk9PcKgwqDCoCBieSAweDgwNTcwMTA6IEFjcGlPc0FjcXVpcmVPYmplY3QgKHV0
Y2FjaGUuYzo0NTIgaW4gL2RldmluL2FjcGktcW54KTxicj4KPT00MzU0Nzg1NDk9PcKgwqDCoCBi
eSAweDgwNTExRDc6IEFjcGlVdEFsbG9jYXRlT2JqZWN0RGVzY0RiZyAodXRvYmplY3QuYzo1NDgg
aW4gL2RldmluL2FjcGktcW54KTxicj4KPT00MzU0Nzg1NDk9PcKgwqDCoCBieSAweDgwNTBBRkQ6
IEFjcGlVdENyZWF0ZUludGVybmFsT2JqZWN0RGJnICh1dG9iamVjdC5jOjIxOCBpbiAvZGV2aW4v
YWNwaS1xbngpPGJyPgo9PTQzNTQ3ODU0OT09wqDCoMKgIGJ5IDB4ODA5NUY5RDogQWNwaURzQ3Jl
YXRlT3BlcmFuZCAoZHN1dGlscy5jOjgyMCBpbiAvZGV2aW4vYWNwaS1xbngpPGJyPgo9PTQzNTQ3
ODU0OT09wqDCoMKgIGJ5IDB4ODA5NjI2ODogQWNwaURzQ3JlYXRlT3BlcmFuZHMgKGRzdXRpbHMu
Yzo5MTUgaW4gL2RldmluL2FjcGktcW54KTxicj4KPT00MzU0Nzg1NDk9PcKgwqDCoCBieSAweDgw
OTQ4RTc6IEFjcGlEc0V4ZWNFbmRPcCAoZHN3ZXhlYy5jOjU1OSBpbiAvZGV2aW4vYWNwaS1xbngp
PGJyPgo9PTQzNTQ3ODU0OT09wqDCoMKgIGJ5IDB4ODA2NTA2MzogQWNwaVBzUGFyc2VMb29wIChw
c2xvb3AuYzo3NjUgaW4gL2RldmluL2FjcGktcW54KTxicj4KPT00MzU0Nzg1NDk9PcKgwqDCoCBi
eSAweDgwNjJDMzU6IEFjcGlQc1BhcnNlQW1sIChwc3BhcnNlLmM6NjMyIGluIC9kZXZpbi9hY3Bp
LXFueCk8YnI+Cj09NDM1NDc4NTQ5PT3CoMKgwqAgYnkgMHg4MDYxNkJDOiBBY3BpUHNFeGVjdXRl
TWV0aG9kIChwc3hmYWNlLmM6MzQ5IGluIC9kZXZpbi9hY3BpLXFueCk8YnI+Cj09NDM1NDc4NTQ5
PT3CoMKgwqAgYnkgMHg4MDZFQUQxOiBBY3BpTnNFdmFsdWF0ZSAobnNldmFsLmM6MzU5IGluIC9k
ZXZpbi9hY3BpLXFueCk8YnI+Cj09NDM1NDc4NTQ5PT3CoMKgwqAgYnkgMHg4MDY3NDgyOiBBY3Bp
RXZhbHVhdGVPYmplY3QgKG5zeGZldmFsLmM6NTAzIGluIC9kZXZpbi9hY3BpLXFueCk8dT48L3U+
PHU+PC91PjwvcD4KPC9kaXY+CjxkaXY+CjxwIGNsYXNzPSJNc29Ob3JtYWwiPi8vIC0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLTx3YnI+LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTx1
PjwvdT48dT48L3U+PC9wPgo8L2Rpdj4KPGRpdj4KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHU+PC91
PsKgPHU+PC91PjwvcD4KPC9kaXY+CjxkaXY+CjxwIGNsYXNzPSJNc29Ob3JtYWwiPk9uIGV4aXQs
IGEgY2FsbCB0byBBY3BpVGVybWluYXRlIGlzIG1hZGUgYW5kIGl0IGRvZXNuJiMzOTt0IGZyZWUg
dXAgdGhlIG1lbW9yeSBhcyB3ZWxsLjx1PjwvdT48dT48L3U+PC9wPgo8L2Rpdj4KPGRpdj4KPHAg
Y2xhc3M9Ik1zb05vcm1hbCI+PHU+PC91PsKgPHU+PC91PjwvcD4KPC9kaXY+CjxkaXY+CjxwIGNs
YXNzPSJNc29Ob3JtYWwiPkFueSB0aXBzIG9uIHRyb3VibGVzaG9vdGluZyB0aGlzIHdvdWxkIGJl
IGdyZWF0bHkgYXBwcmVjaWF0ZWQuIElmIGl0IGxvb2tzIGxpa2UgYSBidWcgdGhlbiBwbGVhc2Ug
YWR2aXNlIGFuZCBJJiMzOTtsbCByYWlzZSBhbiBBQ1BJQ0EgYnVnLjx1PjwvdT48dT48L3U+PC9w
Pgo8L2Rpdj4KPGRpdj4KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHU+PC91PsKgPHU+PC91PjwvcD4K
PC9kaXY+CjxkaXY+CjxwIGNsYXNzPSJNc29Ob3JtYWwiPlRoYW5rcyw8dT48L3U+PHU+PC91Pjwv
cD4KPC9kaXY+CjxkaXY+CjxwIGNsYXNzPSJNc29Ob3JtYWwiPkRldmluPHU+PC91Pjx1PjwvdT48
L3A+CjwvZGl2Pgo8ZGl2Pgo8cCBjbGFzcz0iTXNvTm9ybWFsIj48dT48L3U+wqA8dT48L3U+PC9w
Pgo8L2Rpdj4KPGRpdj4KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHU+PC91PsKgPHU+PC91PjwvcD4K
PC9kaXY+CjwvZGl2Pgo8L2Jsb2NrcXVvdGU+CjwvZGl2Pgo8cCBjbGFzcz0iTXNvTm9ybWFsIj48
dT48L3U+wqA8dT48L3U+PC9wPgo8L2Rpdj4KPC9kaXY+CjwvZGl2Pgo8L2Jsb2NrcXVvdGU+Cjwv
ZGl2Pgo8cCBjbGFzcz0iTXNvTm9ybWFsIj48dT48L3U+wqA8dT48L3U+PC9wPgo8L2Rpdj4KPC9k
aXY+PC9kaXY+PC9kaXY+CjwvZGl2Pgo8L2Rpdj4KCjwvYmxvY2txdW90ZT48L2Rpdj48YnI+PC9k
aXY+Cg==

--===============7545493403688839497==--

