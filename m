Content-Type: multipart/mixed; boundary="===============8471844443049709440=="
MIME-Version: 1.0
From: gengdongjiu <gengdongjiu at huawei.com>
Subject: =?utf-8?q?=5BDevel=5D_=E7=AD=94=E5=A4=8D=3A=5BPATCH_v9_0/7=5D_Handle_gues?=
 =?utf-8?q?t_RAS_Error_in_KVM_and_kernel?=
Date: Tue, 09 Jan 2018 15:10:15 +0000
Message-ID: <etPan.5a54db44.67fb1e34.64bd@localhost>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8471844443049709440==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi james/all,
          whether it is possible you can have a look at this series patches=
? thanks very much in advance for your time.
=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A=E8=80=BF=E4=B8=9C=E4=B9=85
=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9Achristoffer.dall,marc.zyngier,linux(a)a=
rmlinux.org.uk,Catalin Marinas,rjw,bp,robert.moore,lv.zheng,James.Morse,cor=
bet(a)lwn.net,Will.Deacon,linux-doc(a)vger.kernel.org,linux-kernel,linux-ar=
m-kernel,kvmarm,linux-acpi,devel(a)acpica.org
=E6=8A=84=E9=80=81=EF=BC=9A=E8=80=BF=E4=B8=9C=E4=B9=85,=E9=BB=84=E9=9F=B6=
=E5=AE=87
=E6=97=B6=E9=97=B4=EF=BC=9A2018-01-06 15:57:53
=E4=B8=BB=E9=A2=98:[PATCH v9 0/7] Handle guest RAS Error in KVM and kernel

This series patches mainly do below things:

1. Trap guest RAS ERR* registers accesses to EL2 from Non-secure EL1,
   KVM will will do a minimum simulation, these registers are simulated
   to RAZ/WI in KVM.
2. Route guest synchronous External Abort to EL2. If it is also routed
   to EL3 by firmware at the same time, system will trap to EL3 firmware in=
stead
   of EL2 KVM, then firmware judges whether EL2 routing is enabled, if enab=
led,
   jump back to EL2 KVM, otherwise jump back to EL1 host kernel.
3. Enable APEI ARv8 SEI notification to parse the CPER records for SError
   in the ACPI GHES driver, KVM will call handle_guest_sei() to let ACPI
   driver to parse the CPER recorded for SError which happened in the guest
4. If ACPI driver parsed the CPER record failed, KVM will classify the Error
   through Exception Syndrome Register and do different approaches according
   to Asynchronous Error Type
5. If the guest RAS SError is not propagated and not consumed, this excepti=
on
   is precise, we temporarily shut down the VM to isolate the error. For ot=
her
   Asynchronous Error Type, KVM directly injects virtual SError with IMPLEM=
ENTATION
   DEFINED ESR or KVM panic if the error is fatal. For the RAS extension, g=
uest
   virtual ESR must be set, because all-zero  means 'RAS error: Uncategoriz=
ed' instead
   of 'no valid ISS', so set this ESR to IMPLEMENTATION DEFINED by default =
if user space
   does not specify it.

change since v8:
1. update the patch [1/7] and [2/7] to align this serie.
   https://www.spinics.net/lists/arm-kernel/msg623513.html
   https://www.spinics.net/lists/arm-kernel/msg623520.html
2. In kvm ,check handle_guest_sei()'s return value. If this function return=
 true, stop
   classifying errors.
3. Temporarily shut down the VM to isolate the error for recoverable error =
(UER)
4. update some patch's commit messages and clean some patches

Dongjiu Geng (5):
  acpi: apei: Add SEI notification type support for ARMv8
  KVM: arm64: Trap RAS error registers and set HCR_EL2's TERR & TEA
  arm64: kvm: Introduce KVM_ARM_SET_SERROR_ESR ioctl
  arm64: kvm: Set Virtual SError Exception Syndrome for guest
  arm64: kvm: handle guest SError Interrupt by categorization

James Morse (1):
  KVM: arm64: Save ESR_EL2 on guest SError

Xie XiuQi (1):
  arm64: cpufeature: Detect CPU RAS Extentions

 Documentation/virtual/kvm/api.txt    | 11 ++++++
 arch/arm/include/asm/kvm_host.h      |  1 +
 arch/arm/kvm/guest.c                 |  9 +++++
 arch/arm64/Kconfig                   | 16 +++++++++
 arch/arm64/include/asm/cpucaps.h     |  3 +-
 arch/arm64/include/asm/esr.h         | 11 ++++++
 arch/arm64/include/asm/kvm_arm.h     |  2 ++
 arch/arm64/include/asm/kvm_emulate.h | 17 +++++++++
 arch/arm64/include/asm/kvm_host.h    |  2 ++
 arch/arm64/include/asm/sysreg.h      | 15 ++++++++
 arch/arm64/include/asm/system_misc.h |  1 +
 arch/arm64/kernel/cpufeature.c       | 13 +++++++
 arch/arm64/kvm/guest.c               | 14 ++++++++
 arch/arm64/kvm/handle_exit.c         | 68 ++++++++++++++++++++++++++++++++=
+---
 arch/arm64/kvm/hyp/switch.c          | 25 +++++++++++--
 arch/arm64/kvm/inject_fault.c        | 13 ++++++-
 arch/arm64/kvm/reset.c               |  3 ++
 arch/arm64/kvm/sys_regs.c            | 10 ++++++
 arch/arm64/mm/fault.c                | 16 +++++++++
 drivers/acpi/apei/Kconfig            | 15 ++++++++
 drivers/acpi/apei/ghes.c             | 53 ++++++++++++++++++++++++++++
 include/acpi/ghes.h                  |  1 +
 include/uapi/linux/kvm.h             |  3 ++
 virt/kvm/arm/arm.c                   |  7 ++++
 24 files changed, 320 insertions(+), 9 deletions(-)

--
1.9.1


--===============8471844443049709440==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjwvaGVhZD4NCjxib2R5Pg0KPGRpdj5IaSBqYW1l
cy9hbGwsPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7IHdoZXRoZXIgaXQgaXMgcG9zc2libGUgeW91IGNhbiBoYXZlIGEgbG9vayBhdCB0
aGlzIHNlcmllcyBwYXRjaGVzPyB0aGFua3MgdmVyeSBtdWNoIGluIGFkdmFuY2UgZm9yIHlvdXIg
dGltZS4NCjxicj4NCjwvZGl2Pg0KPGRpdiBuYW1lPSJBbnlPZmZpY2UtQmFja2dyb3VuZC1JbWFn
ZSIgc3R5bGU9ImJvcmRlci10b3A6MXB4IHNvbGlkICNCNUM0REY7Zm9udC1zaXplOjE0cHg7bGlu
ZS1oZWlnaHQ6MjBweDtwYWRkaW5nOjhweDsgYmFja2dyb3VuZC1pbWFnZTp1cmwoZGF0YTppbWFn
ZS9wbmc7YmFzZTY0LGlWQk9SdzBLR2dvQUFBQU5TVWhFVWdBQUFBRUFBQUJCQ0FZQUFBQVFUYzds
QUFBQUNYQklXWE1BQUFzVEFBQUxFd0VBbXB3WUFBQUFCR2RCVFVFQUFMR09mUHRSa3dBQUFDQmpT
RkpOQUFCNkpRQUFnSU1BQVBuL0FBQ0E2UUFBZFRBQUFPcGdBQUE2bUFBQUYyJiM0MztTWDhWR0FB
QUFOMGxFUVZSNDJtSjQ4dTdQZnlZR0JvWi9jT0l2S2dzYjhRZVZoWi80allYN0d3c1hweGgmIzQz
O2dnaFRjTG9GSjRIbVMyd0VVbGdCQmdBalBrTlJRbEdQZkFBQUFBQkpSVTVFcmtKZ2dnPT0pOyBi
YWNrZ3JvdW5kLXJlcGVhdDogcmVwZWF0LXg7Ij4NCjxkaXYgc3R5bGU9IndvcmQtYnJlYWs6YnJl
YWstYWxsOyI+PGI+5Y+R5Lu25Lq677yaPC9iPuiAv+S4nOS5hTwvZGl2Pg0KPGRpdiBzdHlsZT0i
d29yZC1icmVhazpicmVhay1hbGw7Ij48Yj7mlLbku7bkurrvvJo8L2I+Y2hyaXN0b2ZmZXIuZGFs
bCxtYXJjLnp5bmdpZXIsbGludXhAYXJtbGludXgub3JnLnVrLENhdGFsaW4gTWFyaW5hcyxyancs
YnAscm9iZXJ0Lm1vb3JlLGx2LnpoZW5nLEphbWVzLk1vcnNlLGNvcmJldEBsd24ubmV0LFdpbGwu
RGVhY29uLGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmcsbGludXgta2VybmVsLGxpbnV4LWFybS1r
ZXJuZWwsa3ZtYXJtLGxpbnV4LWFjcGksZGV2ZWxAYWNwaWNhLm9yZzwvZGl2Pg0KPGRpdiBzdHls
ZT0id29yZC1icmVhazpicmVhay1hbGw7Ij48Yj7mioTpgIHvvJo8L2I+6IC/5Lic5LmFLOm7hOmf
tuWuhzwvZGl2Pg0KPGRpdiBzdHlsZT0id29yZC1icmVhazpicmVhay1hbGw7Ij48Yj7ml7bpl7Tv
vJo8L2I+MjAxOC0wMS0wNiAxNTo1Nzo1MzwvZGl2Pg0KPGRpdiBzdHlsZT0id29yZC1icmVhazpi
cmVhay1hbGw7Ij48Yj7kuLvpopg6PC9iPltQQVRDSCB2OSAwLzddIEhhbmRsZSBndWVzdCBSQVMg
RXJyb3IgaW4gS1ZNIGFuZCBrZXJuZWw8L2Rpdj4NCjxkaXY+PGJyPg0KPC9kaXY+DQo8L2Rpdj4N
CjxkaXYgbmFtZT0iY29udGVudCIgc3R5bGU9IndvcmQtd3JhcDpicmVhay13b3JkOyI+DQo8ZGl2
Pjxmb250IHNpemU9IjIiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTBwdDsiPg0KPGRpdiBjbGFz
cz0iUGxhaW5UZXh0Ij5UaGlzIHNlcmllcyBwYXRjaGVzIG1haW5seSBkbyBiZWxvdyB0aGluZ3M6
PGJyPg0KPGJyPg0KMS4gVHJhcCBndWVzdCBSQVMgRVJSKiByZWdpc3RlcnMgYWNjZXNzZXMgdG8g
RUwyIGZyb20gTm9uLXNlY3VyZSBFTDEsPGJyPg0KJm5ic3A7Jm5ic3A7IEtWTSB3aWxsIHdpbGwg
ZG8gYSBtaW5pbXVtIHNpbXVsYXRpb24sIHRoZXNlIHJlZ2lzdGVycyBhcmUgc2ltdWxhdGVkPGJy
Pg0KJm5ic3A7Jm5ic3A7IHRvIFJBWi9XSSBpbiBLVk0uPGJyPg0KMi4gUm91dGUgZ3Vlc3Qgc3lu
Y2hyb25vdXMgRXh0ZXJuYWwgQWJvcnQgdG8gRUwyLiBJZiBpdCBpcyBhbHNvIHJvdXRlZDxicj4N
CiZuYnNwOyZuYnNwOyB0byBFTDMgYnkgZmlybXdhcmUgYXQgdGhlIHNhbWUgdGltZSwgc3lzdGVt
IHdpbGwgdHJhcCB0byBFTDMgZmlybXdhcmUgaW5zdGVhZDxicj4NCiZuYnNwOyZuYnNwOyBvZiBF
TDIgS1ZNLCB0aGVuIGZpcm13YXJlIGp1ZGdlcyB3aGV0aGVyIEVMMiByb3V0aW5nIGlzIGVuYWJs
ZWQsIGlmIGVuYWJsZWQsPGJyPg0KJm5ic3A7Jm5ic3A7IGp1bXAgYmFjayB0byBFTDIgS1ZNLCBv
dGhlcndpc2UganVtcCBiYWNrIHRvIEVMMSBob3N0IGtlcm5lbC48YnI+DQozLiBFbmFibGUgQVBF
SSBBUnY4IFNFSSBub3RpZmljYXRpb24gdG8gcGFyc2UgdGhlIENQRVIgcmVjb3JkcyBmb3IgU0Vy
cm9yPGJyPg0KJm5ic3A7Jm5ic3A7IGluIHRoZSBBQ1BJIEdIRVMgZHJpdmVyLCBLVk0gd2lsbCBj
YWxsIGhhbmRsZV9ndWVzdF9zZWkoKSB0byBsZXQgQUNQSTxicj4NCiZuYnNwOyZuYnNwOyBkcml2
ZXIgdG8gcGFyc2UgdGhlIENQRVIgcmVjb3JkZWQgZm9yIFNFcnJvciB3aGljaCBoYXBwZW5lZCBp
biB0aGUgZ3Vlc3Q8YnI+DQo0LiBJZiBBQ1BJIGRyaXZlciBwYXJzZWQgdGhlIENQRVIgcmVjb3Jk
IGZhaWxlZCwgS1ZNIHdpbGwgY2xhc3NpZnkgdGhlIEVycm9yPGJyPg0KJm5ic3A7Jm5ic3A7IHRo
cm91Z2ggRXhjZXB0aW9uIFN5bmRyb21lIFJlZ2lzdGVyIGFuZCBkbyBkaWZmZXJlbnQgYXBwcm9h
Y2hlcyBhY2NvcmRpbmc8YnI+DQombmJzcDsmbmJzcDsgdG8gQXN5bmNocm9ub3VzIEVycm9yIFR5
cGU8YnI+DQo1LiBJZiB0aGUgZ3Vlc3QgUkFTIFNFcnJvciBpcyBub3QgcHJvcGFnYXRlZCBhbmQg
bm90IGNvbnN1bWVkLCB0aGlzIGV4Y2VwdGlvbjxicj4NCiZuYnNwOyZuYnNwOyBpcyBwcmVjaXNl
LCB3ZSB0ZW1wb3JhcmlseSBzaHV0IGRvd24gdGhlIFZNIHRvIGlzb2xhdGUgdGhlIGVycm9yLiBG
b3Igb3RoZXI8YnI+DQombmJzcDsmbmJzcDsgQXN5bmNocm9ub3VzIEVycm9yIFR5cGUsIEtWTSBk
aXJlY3RseSBpbmplY3RzIHZpcnR1YWwgU0Vycm9yIHdpdGggSU1QTEVNRU5UQVRJT048YnI+DQom
bmJzcDsmbmJzcDsgREVGSU5FRCBFU1Igb3IgS1ZNIHBhbmljIGlmIHRoZSBlcnJvciBpcyBmYXRh
bC4gRm9yIHRoZSBSQVMgZXh0ZW5zaW9uLCBndWVzdDxicj4NCiZuYnNwOyZuYnNwOyB2aXJ0dWFs
IEVTUiBtdXN0IGJlIHNldCwgYmVjYXVzZSBhbGwtemVybyZuYnNwOyBtZWFucyAnUkFTIGVycm9y
OiBVbmNhdGVnb3JpemVkJyBpbnN0ZWFkPGJyPg0KJm5ic3A7Jm5ic3A7IG9mICdubyB2YWxpZCBJ
U1MnLCBzbyBzZXQgdGhpcyBFU1IgdG8gSU1QTEVNRU5UQVRJT04gREVGSU5FRCBieSBkZWZhdWx0
IGlmIHVzZXIgc3BhY2U8YnI+DQombmJzcDsmbmJzcDsgZG9lcyBub3Qgc3BlY2lmeSBpdC48YnI+
DQo8YnI+DQpjaGFuZ2Ugc2luY2Ugdjg6PGJyPg0KMS4gdXBkYXRlIHRoZSBwYXRjaCBbMS83XSBh
bmQgWzIvN10gdG8gYWxpZ24gdGhpcyBzZXJpZS48YnI+DQombmJzcDsmbmJzcDsgPGEgaHJlZj0i
aHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvYXJtLWtlcm5lbC9tc2c2MjM1MTMuaHRtbCIg
dGFyZ2V0PSJfQkxBTksiPg0KaHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvYXJtLWtlcm5l
bC9tc2c2MjM1MTMuaHRtbDwvYT48YnI+DQombmJzcDsmbmJzcDsgPGEgaHJlZj0iaHR0cHM6Ly93
d3cuc3Bpbmljcy5uZXQvbGlzdHMvYXJtLWtlcm5lbC9tc2c2MjM1MjAuaHRtbCIgdGFyZ2V0PSJf
QkxBTksiPg0KaHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvYXJtLWtlcm5lbC9tc2c2MjM1
MjAuaHRtbDwvYT48YnI+DQoyLiBJbiBrdm0gLGNoZWNrIGhhbmRsZV9ndWVzdF9zZWkoKSdzIHJl
dHVybiB2YWx1ZS4gSWYgdGhpcyBmdW5jdGlvbiByZXR1cm4gdHJ1ZSwgc3RvcDxicj4NCiZuYnNw
OyZuYnNwOyBjbGFzc2lmeWluZyBlcnJvcnMuPGJyPg0KMy4gVGVtcG9yYXJpbHkgc2h1dCBkb3du
IHRoZSBWTSB0byBpc29sYXRlIHRoZSBlcnJvciBmb3IgcmVjb3ZlcmFibGUgZXJyb3IgKFVFUik8
YnI+DQo0LiB1cGRhdGUgc29tZSBwYXRjaCdzIGNvbW1pdCBtZXNzYWdlcyBhbmQgY2xlYW4gc29t
ZSBwYXRjaGVzPGJyPg0KPGJyPg0KRG9uZ2ppdSBHZW5nICg1KTo8YnI+DQombmJzcDsgYWNwaTog
YXBlaTogQWRkIFNFSSBub3RpZmljYXRpb24gdHlwZSBzdXBwb3J0IGZvciBBUk12ODxicj4NCiZu
YnNwOyBLVk06IGFybTY0OiBUcmFwIFJBUyBlcnJvciByZWdpc3RlcnMgYW5kIHNldCBIQ1JfRUwy
J3MgVEVSUiAmYW1wOyBURUE8YnI+DQombmJzcDsgYXJtNjQ6IGt2bTogSW50cm9kdWNlIEtWTV9B
Uk1fU0VUX1NFUlJPUl9FU1IgaW9jdGw8YnI+DQombmJzcDsgYXJtNjQ6IGt2bTogU2V0IFZpcnR1
YWwgU0Vycm9yIEV4Y2VwdGlvbiBTeW5kcm9tZSBmb3IgZ3Vlc3Q8YnI+DQombmJzcDsgYXJtNjQ6
IGt2bTogaGFuZGxlIGd1ZXN0IFNFcnJvciBJbnRlcnJ1cHQgYnkgY2F0ZWdvcml6YXRpb248YnI+
DQo8YnI+DQpKYW1lcyBNb3JzZSAoMSk6PGJyPg0KJm5ic3A7IEtWTTogYXJtNjQ6IFNhdmUgRVNS
X0VMMiBvbiBndWVzdCBTRXJyb3I8YnI+DQo8YnI+DQpYaWUgWGl1UWkgKDEpOjxicj4NCiZuYnNw
OyBhcm02NDogY3B1ZmVhdHVyZTogRGV0ZWN0IENQVSBSQVMgRXh0ZW50aW9uczxicj4NCjxicj4N
CiZuYnNwO0RvY3VtZW50YXRpb24vdmlydHVhbC9rdm0vYXBpLnR4dCZuYnNwOyZuYnNwOyZuYnNw
OyB8IDExICYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQzOzxicj4NCiZuYnNwO2FyY2gvYXJt
L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmgmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgfCZu
YnNwOyAxICYjNDM7PGJyPg0KJm5ic3A7YXJjaC9hcm0va3ZtL2d1ZXN0LmMmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgfCZuYnNwOyA5ICYjNDM7JiM0MzsmIzQzOyYjNDM7
JiM0Mzs8YnI+DQombmJzcDthcmNoL2FybTY0L0tjb25maWcmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgfCAxNiAmIzQzOyYjNDM7JiM0MzsmIzQzOyYj
NDM7JiM0MzsmIzQzOyYjNDM7JiM0Mzs8YnI+DQombmJzcDthcmNoL2FybTY0L2luY2x1ZGUvYXNt
L2NwdWNhcHMuaCZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB8Jm5ic3A7IDMgJiM0MzstPGJyPg0K
Jm5ic3A7YXJjaC9hcm02NC9pbmNsdWRlL2FzbS9lc3IuaCZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB8IDExICYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0Mzsm
IzQzOzxicj4NCiZuYnNwO2FyY2gvYXJtNjQvaW5jbHVkZS9hc20va3ZtX2FybS5oJm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7IHwmbmJzcDsgMiAmIzQzOyYjNDM7PGJyPg0KJm5ic3A7YXJjaC9hcm02
NC9pbmNsdWRlL2FzbS9rdm1fZW11bGF0ZS5oIHwgMTcgJiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQz
OyYjNDM7JiM0MzsmIzQzOyYjNDM7PGJyPg0KJm5ic3A7YXJjaC9hcm02NC9pbmNsdWRlL2FzbS9r
dm1faG9zdC5oJm5ic3A7Jm5ic3A7Jm5ic3A7IHwmbmJzcDsgMiAmIzQzOyYjNDM7PGJyPg0KJm5i
c3A7YXJjaC9hcm02NC9pbmNsdWRlL2FzbS9zeXNyZWcuaCZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyB8IDE1ICYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0Mzs8YnI+
DQombmJzcDthcmNoL2FybTY0L2luY2x1ZGUvYXNtL3N5c3RlbV9taXNjLmggfCZuYnNwOyAxICYj
NDM7PGJyPg0KJm5ic3A7YXJjaC9hcm02NC9rZXJuZWwvY3B1ZmVhdHVyZS5jJm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHwgMTMgJiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQzOyYj
NDM7JiM0Mzs8YnI+DQombmJzcDthcmNoL2FybTY0L2t2bS9ndWVzdC5jJm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7IHwgMTQgJiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQz
Ozxicj4NCiZuYnNwO2FyY2gvYXJtNjQva3ZtL2hhbmRsZV9leGl0LmMmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgfCA2OCAmIzQzOyYjNDM7JiM0MzsmIzQz
OyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0Mzsm
IzQzOyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0
MzsmIzQzOyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0MzstLS08YnI+DQombmJzcDthcmNoL2FybTY0
L2t2bS9oeXAvc3dpdGNoLmMmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsgfCAyNSAmIzQzOyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQzOyYj
NDM7JiM0MzsmIzQzOyYjNDM7LS08YnI+DQombmJzcDthcmNoL2FybTY0L2t2bS9pbmplY3RfZmF1
bHQuYyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB8IDEzICYjNDM7
JiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQzOy08YnI+DQombmJzcDthcmNoL2FybTY0L2t2bS9yZXNl
dC5jJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHwmbmJzcDsgMyAmIzQzOyYjNDM7PGJyPg0K
Jm5ic3A7YXJjaC9hcm02NC9rdm0vc3lzX3JlZ3MuYyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB8IDEwICYjNDM7JiM0Mzsm
IzQzOyYjNDM7JiM0MzsmIzQzOzxicj4NCiZuYnNwO2FyY2gvYXJtNjQvbW0vZmF1bHQuYyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB8IDE2ICYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0
MzsmIzQzOyYjNDM7JiM0MzsmIzQzOzxicj4NCiZuYnNwO2RyaXZlcnMvYWNwaS9hcGVpL0tjb25m
aWcmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsgfCAxNSAmIzQzOyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQzOyYjNDM7
PGJyPg0KJm5ic3A7ZHJpdmVycy9hY3BpL2FwZWkvZ2hlcy5jJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHwgNTMg
JiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQzOyYj
NDM7JiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQz
OyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0Mzs8YnI+DQombmJzcDtpbmNsdWRlL2FjcGkvZ2hlcy5o
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHwmbmJzcDsgMSAm
IzQzOzxicj4NCiZuYnNwO2luY2x1ZGUvdWFwaS9saW51eC9rdm0uaCZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB8
Jm5ic3A7IDMgJiM0MzsmIzQzOzxicj4NCiZuYnNwO3ZpcnQva3ZtL2FybS9hcm0uYyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB8Jm5ic3A7IDcgJiM0
MzsmIzQzOyYjNDM7JiM0Mzs8YnI+DQombmJzcDsyNCBmaWxlcyBjaGFuZ2VkLCAzMjAgaW5zZXJ0
aW9ucygmIzQzOyksIDkgZGVsZXRpb25zKC0pPGJyPg0KPGJyPg0KLS0gPGJyPg0KMS45LjE8YnI+
DQo8YnI+DQo8L2Rpdj4NCjwvc3Bhbj48L2ZvbnQ+PC9kaXY+DQo8L2Rpdj4NCjwvYm9keT4NCjwv
aHRtbD4NCg==

--===============8471844443049709440==--

