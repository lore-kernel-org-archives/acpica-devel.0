Content-Type: multipart/mixed; boundary="===============7170047318903659440=="
MIME-Version: 1.0
From: Sean Shoufu Luo <luoshoufu at gmail.com>
Subject: Re: [Devel] Battery Presence
Date: Tue, 06 Jul 2010 13:47:25 +0800
Message-ID: <AANLkTinwInMnIsuZaaXSZBsLOaZexVlGeDv_fqOHOZ3H@mail.gmail.com>
In-Reply-To: 1278383837.4537.6487.camel@rzhang1-desktop
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7170047318903659440==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Yes, i'm trying .... but now, in my mobile client, it seems, something else
wrong when enable ACPI sub system
I set ACPI_LV_ALL for debug, and it give me such output, and then system
hang. ......................... any idea?

 utxface-0152 [01] InitializeSubsystem   : ----Entry
utglobal-0854 [02] UtInitGlobals         : ----Entry
utglobal-0964 [02] UtInitGlobals         : ----Exit- AE_OK
 utmutex-0157 [02] UtMutexInitialize     : ----Entry
 utmutex-0253 [03] UtCreateMutex         : ----Entry 00000000
 utmutex-0268 [03] UtCreateMutex         : ----Exit- AE_OK
 utmutex-0253 [03] UtCreateMutex         : ----Entry 00000001
 utmutex-0268 [03] UtCreateMutex         : ----Exit- AE_OK
 utmutex-0253 [03] UtCreateMutex         : ----Entry 00000002
 utmutex-0268 [03] UtCreateMutex         : ----Exit- AE_OK
 utmutex-0253 [03] UtCreateMutex         : ----Entry 00000003
 utmutex-0268 [03] UtCreateMutex         : ----Exit- AE_OK
 utmutex-0253 [03] UtCreateMutex         : ----Entry 00000004
 utmutex-0268 [03] UtCreateMutex         : ----Exit- AE_OK
 utmutex-0253 [03] UtCreateMutex         : ----Entry 00000005
 utmutex-0268 [03] UtCreateMutex         : ----Exit- AE_OK
 utmutex-0253 [03] UtCreateMutex         : ----Entry 00000006
 utmutex-0268 [03] UtCreateMutex         : ----Exit- AE_OK
 utmutex-0253 [03] UtCreateMutex         : ----Entry 00000007
 utmutex-0268 [03] UtCreateMutex         : ----Exit- AE_OK
 utmutex-0188 [02] UtMutexInitialize     : ----Exit- AE_OK
nsaccess-0154 [02] NsRootInitialize      : ----Entry
nsaccess-0182 [02] NsRootInitialize      : Entering predefined entries into
namespace
nsaccess-0390 [03] NsLookup              : ----Entry
nsaccess-0414 [03] NsLookup              : Null scope prefix, using root
node (0xb54dec)
nsaccess-0496 [03] NsLookup              : Searching relative to prefix
scope ["\" ] (0xb54dec)
nsaccess-0607 [03] NsLookup              : Simple Pathname (1 segment,
Flags=3D0)
  nsdump-0175 [03] NsPrintPathname       : [_GPE]
nssearch-0392 [04] NsSearchAndEnter      : ----Entry
nssearch-0181 [05] NsSearchOneScope      : ----Entry
 nsnames-0228 [06] NsGetExternalPathname : ----Entry 0xb54dec
 utalloc-0423 [07] UtAllocate            : ----Entry 00000002
 utalloc-0446 [07] UtAllocate            : ----Exit- 0x1b143e7c
 nsnames-0257 [06] NsGetExternalPathname : ----Exit- 0x1b143e7c
nssearch-0195 [05] NsSearchOneScope      : Searching \ (0xb54dec) For [_GPE]
(Scope)
nssearch-0254 [05] NsSearchOneScope      : Name [_GPE] (Scope) not found in
search in scope ["\" ] 0xb54dec first child 0x0
nssearch-0256 [05] NsSearchOneScope      : ----Exit- ****Exception****:
AE_NOT_FOUND
 nsalloc-0150 [05] NsCreateNode          : ----Entry
 utalloc-0423 [06] UtAllocate            : ----Entry 00000014
 utalloc-0446 [06] UtAllocate            : ----Exit- 0x1b13c9c0
 nsalloc-0172 [05] NsCreateNode          : ----Exit- 0x1b13c9c0
 nsalloc-0336 [05] NsInstallNode         : ----Entry
 nsalloc-0382 [05] NsInstallNode         : _GPE (Scope) [Node 0x1b13c9c0
Owner 0] added to "\"  (Device) [Node 0xb54dec]
 nsalloc-0384 [05] NsInstallNode         : ----Exit-
nssearch-0505 [04] NsSearchAndEnter      : ----Exit- AE_OK
nsaccess-0770 [03] NsLookup              : ----Exit- AE_OK
nsaccess-0390 [03] NsLookup              : ----Entry
nsaccess-0414 [03] NsLookup              : Null scope prefix, using root
node (0xb54dec)
nsaccess-0496 [03] NsLookup              : Searching relative to prefix
scope ["\" ] (0xb54dec)
nsaccess-0607 [03] NsLookup              : Simple Pathname (1 segment,
Flags=3D0)
  nsdump-0175 [03] NsPrintPathname       : [_PR_]
nssearch-0392 [04] NsSearchAndEnter      : ----Entry
nssearch-0181 [05] NsSearchOneScope      : ----Entry
 nsnames-0228 [06] NsGetExternalPathname : ----Entry 0xb54dec
 utalloc-0423 [07] UtAllocate            : ----Entry 00000002
 utalloc-0446 [07] UtAllocate            : ----Exit- 0x1b143e7c
 nsnames-0257 [06] NsGetExternalPathname : ----Exit- 0x1b143e7c
nssearch-0195 [05] NsSearchOneScope      : Searching \ (0xb54dec) For [_PR_]
(Scope)
nssearch-0254 [05] NsSearchOneScope      : Name [_PR_] (Scope) not found in
search in scope ["\" ] 0xb54dec first child 0x1b13c9c0
nssearch-0256 [05] NsSearchOneScope      : ----Exit- ****Exception****:
AE_NOT_FOUND
 nsalloc-0150 [05] NsCreateNode          : ----Entry
 utalloc-0423 [06] UtAllocate            : ----Entry 00000014
 utalloc-0446 [06] UtAllocate            : ----Exit- 0x1b1a8808
 nsalloc-0172 [05] NsCreateNode          : ----Exit- 0x1b1a8808
 nsalloc-0336 [05] NsInstallNode         : ----Entry
 nsalloc-0382 [05] NsInstallNode         : _PR_ (Scope) [Node 0x1b1a8808
Owner 0] added to "\"  (Device) [Node 0xb54dec]
 nsalloc-0384 [05] NsInstallNode         : ----Exit-
nssearch-0505 [04] NsSearchAndEnter      : ----Exit- AE_OK
nsaccess-0770 [03] NsLookup              : ----Exit- AE_OK
nsaccess-0390 [03] NsLookup              : ----Entry
nsaccess-0414 [03] NsLookup              : Null scope prefix, using root
node (0xb54dec)
nsaccess-0496 [03] NsLookup              : Searching relative to prefix
scope ["\" ] (0xb54dec)
nsaccess-0607 [03] NsLookup              : Simple Pathname (1 segment,
Flags=3D0)
  nsdump-0175 [03] NsPrintPathname       : [_SB_]
nssearch-0392 [04] NsSearchAndEnter      : ----Entry
nssearch-0181 [05] NsSearchOneScope      : ----Entry
 nsnames-0228 [06] NsGetExternalPathname : ----Entry 0xb54dec
 utalloc-0423 [07] UtAllocate            : ----Entry 00000002
 utalloc-0446 [07] UtAllocate            : ----Exit- 0x1b1a87e4
 nsnames-0257 [06] NsGetExternalPathname : ----Exit- 0x1b1a87e4
nssearch-0195 [05] NsSearchOneScope      : Searching \ (0xb54dec) For [_SB_]
(Device)
nssearch-0254 [05] NsSearchOneScope      : Name [_SB_] (Device) not found in
search in scope ["\" ] 0xb54dec first child 0x1b13c9c0
nssearch-0256 [05] NsSearchOneScope      : ----Exit- ****Exception****:
AE_NOT_FOUND
 nsalloc-0150 [05] NsCreateNode          : ----Entry
 utalloc-0423 [06] UtAllocate            : ----Entry 00000014
 utalloc-0446 [06] UtAllocate            : ----Exit- 0x1b1a87d4
 nsalloc-0172 [05] NsCreateNode          : ----Exit- 0x1b1a87d4
 nsalloc-0336 [05] NsInstallNode         : ----Entry
 nsalloc-0382 [05] NsInstallNode         : _SB_ (Device) [Node 0x1b1a87d4
Owner 0] added to "\"  (Device) [Node 0xb54dec]
 nsalloc-0384 [05] NsInstallNode         : ----Exit-
nssearch-0505 [04] NsSearchAndEnter      : ----Exit- AE_OK
nsaccess-0770 [03] NsLookup              : ----Exit- AE_OK
nsaccess-0390 [03] NsLookup              : ----Entry
nsaccess-0414 [03] NsLookup              : Null scope prefix, using root
node (0xb54dec)
nsaccess-0496 [03] NsLookup              : Searching relative to prefix
scope ["\" ] (0xb54dec)
nsaccess-0607 [03] NsLookup              : Simple Pathname (1 segment,
Flags=3D0)
  nsdump-0175 [03] NsPrintPathname       : [_SI_]
nssearch-0392 [04] NsSearchAndEnter      : ----Entry
nssearch-0181 [05] NsSearchOneScope      : ----Entry
 nsnames-0228 [06] NsGetExternalPathname : ----Entry 0xb54dec
 utalloc-0423 [07] UtAllocate            : ----Entry 00000002
 utalloc-0446 [07] UtAllocate            : ----Exit- 0x1b1a87b0
 nsnames-0257 [06] NsGetExternalPathname : ----Exit- 0x1b1a87b0
nssearch-0195 [05] NsSearchOneScope      : Searching \ (0xb54dec) For [_SI_]
(Scope)
nssearch-0254 [05] NsSearchOneScope      : Name [_SI_] (Scope) not found in
search in scope ["\" ] 0xb54dec first child 0x1b13c9c0
nssearch-0256 [05] NsSearchOneScope      : ----Exit- ****Exception****:
AE_NOT_FOUND
 nsalloc-0150 [05] NsCreateNode          : ----Entry
 utalloc-0423 [06] UtAllocate            : ----Entry 00000014
 utalloc-0446 [06] UtAllocate            : ----Exit- 0x1b1a87a0
 nsalloc-0172 [05] NsCreateNode          : ----Exit- 0x1b1a87a0
 nsalloc-0336 [05] NsInstallNode         : ----Entry
 nsalloc-0382 [05] NsInstallNode         : _SI_ (Scope) [Node 0x1b1a87a0
Owner 0] added to "\"  (Device) [Node 0xb54dec]
 nsalloc-0384 [05] NsInstallNode         : ----Exit-
nssearch-0505 [04] NsSearchAndEnter      : ----Exit- AE_OK
nsaccess-0770 [03] NsLookup              : ----Exit- AE_OK
nsaccess-0390 [03] NsLookup              : ----Entry
nsaccess-0414 [03] NsLookup              : Null scope prefix, using root
node (0xb54dec)
nsaccess-0496 [03] NsLookup              : Searching relative to prefix
scope ["\" ] (0xb54dec)
nsaccess-0607 [03] NsLookup              : Simple Pathname (1 segment,
Flags=3D0)
  nsdump-0175 [03] NsPrintPathname       : [_TZ_]
nssearch-0392 [04] NsSearchAndEnter      : ----Entry
nssearch-0181 [05] NsSearchOneScope      : ----Entry
 nsnames-0228 [06] NsGetExternalPathname : ----Entry 0xb54dec
 utalloc-0423 [07] UtAllocate            : ----Entry 00000002
 utalloc-0446 [07] UtAllocate            : ----Exit- 0x1b1a877c
 nsnames-0257 [06] NsGetExternalPathname : ----Exit- 0x1b1a877c
nssearch-0195 [05] NsSearchOneScope      : Searching \ (0xb54dec) For [_TZ_]
(Thermal)
nssearch-0254 [05] NsSearchOneScope      : Name [_TZ_] (Thermal) not found
in search in scope ["\" ] 0xb54dec first child 0x1b13c9c0
nssearch-0256 [05] NsSearchOneScope      : ----Exit- ****Exception****:
AE_NOT_FOUND
 nsalloc-0150 [05] NsCreateNode          : ----Entry
 utalloc-0423 [06] UtAllocate            : ----Entry 00000014
 utalloc-0446 [06] UtAllocate            : ----Exit- 0x1b1a876c
 nsalloc-0172 [05] NsCreateNode          : ----Exit- 0x1b1a876c
 nsalloc-0336 [05] NsInstallNode         : ----Entry
 nsalloc-0382 [05] NsInstallNode         : _TZ_ (Thermal) [Node 0x1b1a876c
Owner 0] added to "\"  (Device) [Node 0xb54dec]
 nsalloc-0384 [05] NsInstallNode         : ----Exit-
nssearch-0505 [04] NsSearchAndEnter      : ----Exit- AE_OK
nsaccess-0770 [03] NsLookup              : ----Exit- AE_OK
nsaccess-0390 [03] NsLookup              : ----Entry
nsaccess-0414 [03] NsLookup              : Null scope prefix, using root
node (0xb54dec)
nsaccess-0496 [03] NsLookup              : Searching relative to prefix
scope ["\" ] (0xb54dec)
nsaccess-0607 [03] NsLookup              : Simple Pathname (1 segment,
Flags=3D0)
  nsdump-0175 [03] NsPrintPathname       : [_REV]
nssearch-0392 [04] NsSearchAndEnter      : ----Entry
nssearch-0181 [05] NsSearchOneScope      : ----Entry
 nsnames-0228 [06] NsGetExternalPathname : ----Entry 0xb54dec
 utalloc-0423 [07] UtAllocate            : ----Entry 00000002
 utalloc-0446 [07] UtAllocate            : ----Exit- 0x1b1a8748
 nsnames-0257 [06] NsGetExternalPathname : ----Exit- 0x1b1a8748
nssearch-0195 [05] NsSearchOneScope      : Searching \ (0xb54dec) For [_REV]
(Integer)
nssearch-0254 [05] NsSearchOneScope      : Name [_REV] (Integer) not found
in search in scope ["\" ] 0xb54dec first child 0x1b13c9c0
nssearch-0256 [05] NsSearchOneScope      : ----Exit- ****Exception****:
AE_NOT_FOUND
 nsalloc-0150 [05] NsCreateNode          : ----Entry
 utalloc-0423 [06] UtAllocate            : ----Entry 00000014
 utalloc-0446 [06] UtAllocate            : ----Exit- 0x1b1a8738
 nsalloc-0172 [05] NsCreateNode          : ----Exit- 0x1b1a8738
 nsalloc-0336 [05] NsInstallNode         : ----Entry
 nsalloc-0382 [05] NsInstallNode         : _REV (Integer) [Node 0x1b1a8738
Owner 0] added to "\"  (Device) [Node 0xb54dec]
 nsalloc-0384 [05] NsInstallNode         : ----Exit-
nssearch-0505 [04] NsSearchAndEnter      : ----Exit- AE_OK
nsaccess-0770 [03] NsLookup              : ----Exit- AE_OK
utobject-0179 [03] UtCreateInternalObject: ----Entry Integer
utobject-0506 [04] UtAllocateObjectDescDb: ----Entry
 utalloc-0423 [05] UtAllocate            : ----Entry 00000028
 utalloc-0446 [05] UtAllocate            : ----Exit- 0x1b1a86e8
utobject-0523 [04] UtAllocateObjectDescDb: 0x1b1a86e8 Size 28
utobject-0525 [04] UtAllocateObjectDescDb: ----Exit- 0x1b1a86e8
utobject-0229 [03] UtCreateInternalObject: ----Exit- 0x1b1a86e8
nsobject-0161 [03] NsAttachObject        : ----Entry
nsobject-0241 [03] NsAttachObject        : Installing 0x1b1a86e8 into Node
0x1b1a8738 [_REV]
utdelete-0755 [04] UtAddReference        : ----Entry 0x1b1a86e8
utdelete-0767 [04] UtAddReference        : Obj 0x1b1a86e8 Current Refs=3D1 =
[To
Be Incremented]
utdelete-0592 [05] UtUpdateObjectReferenc: ----Entry 0x1b1a86e8
utdelete-0495 [05] UtUpdateRefCount      : Obj 0x1b1a86e8 Refs=3D2,
[Incremented]
utdelete-0717 [05] UtUpdateObjectReferenc: ----Exit- AE_OK
utdelete-0772 [04] UtAddReference        : ----Exit-
nsobject-0276 [03] NsAttachObject        : ----Exit- AE_OK
utdelete-0793 [03] UtRemoveReference     : ----Entry 0x1b1a86e8
utdelete-0817 [03] UtRemoveReference     : Obj 0x1b1a86e8 Current Refs=3D2 =
[To
Be Decremented]
utdelete-0592 [04] UtUpdateObjectReferenc: ----Entry 0x1b1a86e8
utdelete-0514 [04] UtUpdateRefCount      : Obj 0x1b1a86e8 Refs=3D1,
[Decremented]
utdelete-0717 [04] UtUpdateObjectReferenc: ----Exit- AE_OK
utdelete-0825 [03] UtRemoveReference     : ----Exit-
nsaccess-0390 [03] NsLookup              : ----Entry
nsaccess-0414 [03] NsLookup              : Null scope prefix, using root
node (0xb54dec)
nsaccess-0496 [03] NsLookup              : Searching relative to prefix
scope ["\" ] (0xb54dec)
nsaccess-0607 [03] NsLookup              : Simple Pathname (1 segment,
Flags=3D0)
  nsdump-0175 [03] NsPrintPathname       : [_OS_]
nssearch-0392 [04] NsSearchAndEnter      : ----Entry
nssearch-0181 [05] NsSearchOneScope      : ----Entry
 nsnames-0228 [06] NsGetExternalPathname : ----Entry 0xb54dec
 utalloc-0423 [07] UtAllocate            : ----Entry 00000002
 utalloc-0446 [07] UtAllocate            : ----Exit- 0x1b1a8cc0
 nsnames-0257 [06] NsGetExternalPathname : ----Exit- 0x1b1a8cc0
nssearch-0195 [05] NsSearchOneScope      : Searching \ (0xb54dec) For [_OS_]
(String)
nssearch-0254 [05] NsSearchOneScope      : Name [_OS_] (String) not found in
search in scope ["\" ] 0xb54dec first child 0x1b13c9c0
nssearch-0256 [05] NsSearchOneScope      : ----Exit- ****Exception****:
AE_NOT_FOUND
 nsalloc-0150 [05] NsCreateNode          : ----Entry
 utalloc-0423 [06] UtAllocate            : ----Entry 00000014
 utalloc-0446 [06] UtAllocate            : ----Exit- 0x1b1a8cb0
 nsalloc-0172 [05] NsCreateNode          : ----Exit- 0x1b1a8cb0
 nsalloc-0336 [05] NsInstallNode         : ----Entry
 nsalloc-0382 [05] NsInstallNode         : _OS_ (String) [Node 0x1b1a8cb0
Owner 0] added to "\"  (Device) [Node 0xb54dec]
 nsalloc-0384 [05] NsInstallNode         : ----Exit-
nssearch-0505 [04] NsSearchAndEnter      : ----Exit- AE_OK
nsaccess-0770 [03] NsLookup              : ----Exit- AE_OK
utobject-0179 [03] UtCreateInternalObject: ----Entry String
utobject-0506 [04] UtAllocateObjectDescDb: ----Entry
 utalloc-0423 [05] UtAllocate            : ----Entry 0


On Tue, Jul 6, 2010 at 10:37 AM, Zhang Rui <rui.zhang(a)intel.com> wrote:

> On Tue, 2010-07-06 at 10:29 +0800, Sean Shoufu Luo wrote:
> > Previously, I have ported ACPICA to our system. These days, I wonna to
> > write ACPI driver for battery with Netbsd's version as guide, but I
> > found when I initialized battery driver, it would issue a command to
> > query _STA for battery presence. But its return value is 0xf, that
> > indicates PRESENCE bit is not set (0x00000010).  I'm puzzled. I'm
> > using battery ....Why the battery not present?
> > Anyone can give any hint?
> >
> please attach the acpidump output of this machine.
>
> thanks,
> rui
>
>
>

--===============7170047318903659440==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

WWVzLCBpJiMzOTttIHRyeWluZyAuLi4uIGJ1dCBub3csIGluIG15IG1vYmlsZSBjbGllbnQsIGl0
IHNlZW1zLCBzb21ldGhpbmcgZWxzZSB3cm9uZyB3aGVuIGVuYWJsZSBBQ1BJIHN1YiBzeXN0ZW08
ZGl2Pkkgc2V0IEFDUElfTFZfQUxMIGZvciBkZWJ1ZywgYW5kIGl0IGdpdmUgbWUgc3VjaCBvdXRw
dXQsIGFuZCB0aGVuIHN5c3RlbSBoYW5nLiAuLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uIGFueSBp
ZGVhPzxicj4KPGRpdj48YnI+PC9kaXY+PGRpdj48ZGl2PqB1dHhmYWNlLTAxNTIgWzAxXSBJbml0
aWFsaXplU3Vic3lzdGVtIKAgOiAtLS0tRW50cnk8L2Rpdj48ZGl2PnV0Z2xvYmFsLTA4NTQgWzAy
XSBVdEluaXRHbG9iYWxzIKAgoCCgIKAgOiAtLS0tRW50cnk8L2Rpdj48ZGl2PnV0Z2xvYmFsLTA5
NjQgWzAyXSBVdEluaXRHbG9iYWxzIKAgoCCgIKAgOiAtLS0tRXhpdC0gQUVfT0s8L2Rpdj48ZGl2
PqB1dG11dGV4LTAxNTcgWzAyXSBVdE11dGV4SW5pdGlhbGl6ZSCgIKAgOiAtLS0tRW50cnk8L2Rp
dj4KPGRpdj6gdXRtdXRleC0wMjUzIFswM10gVXRDcmVhdGVNdXRleCCgIKAgoCCgIDogLS0tLUVu
dHJ5IDAwMDAwMDAwPC9kaXY+PGRpdj6gdXRtdXRleC0wMjY4IFswM10gVXRDcmVhdGVNdXRleCCg
IKAgoCCgIDogLS0tLUV4aXQtIEFFX09LPC9kaXY+PGRpdj6gdXRtdXRleC0wMjUzIFswM10gVXRD
cmVhdGVNdXRleCCgIKAgoCCgIDogLS0tLUVudHJ5IDAwMDAwMDAxPC9kaXY+PGRpdj6gdXRtdXRl
eC0wMjY4IFswM10gVXRDcmVhdGVNdXRleCCgIKAgoCCgIDogLS0tLUV4aXQtIEFFX09LPC9kaXY+
CjxkaXY+oHV0bXV0ZXgtMDI1MyBbMDNdIFV0Q3JlYXRlTXV0ZXggoCCgIKAgoCA6IC0tLS1FbnRy
eSAwMDAwMDAwMjwvZGl2PjxkaXY+oHV0bXV0ZXgtMDI2OCBbMDNdIFV0Q3JlYXRlTXV0ZXggoCCg
IKAgoCA6IC0tLS1FeGl0LSBBRV9PSzwvZGl2PjxkaXY+oHV0bXV0ZXgtMDI1MyBbMDNdIFV0Q3Jl
YXRlTXV0ZXggoCCgIKAgoCA6IC0tLS1FbnRyeSAwMDAwMDAwMzwvZGl2PjxkaXY+oHV0bXV0ZXgt
MDI2OCBbMDNdIFV0Q3JlYXRlTXV0ZXggoCCgIKAgoCA6IC0tLS1FeGl0LSBBRV9PSzwvZGl2Pgo8
ZGl2PqB1dG11dGV4LTAyNTMgWzAzXSBVdENyZWF0ZU11dGV4IKAgoCCgIKAgOiAtLS0tRW50cnkg
MDAwMDAwMDQ8L2Rpdj48ZGl2PqB1dG11dGV4LTAyNjggWzAzXSBVdENyZWF0ZU11dGV4IKAgoCCg
IKAgOiAtLS0tRXhpdC0gQUVfT0s8L2Rpdj48ZGl2PqB1dG11dGV4LTAyNTMgWzAzXSBVdENyZWF0
ZU11dGV4IKAgoCCgIKAgOiAtLS0tRW50cnkgMDAwMDAwMDU8L2Rpdj48ZGl2PqB1dG11dGV4LTAy
NjggWzAzXSBVdENyZWF0ZU11dGV4IKAgoCCgIKAgOiAtLS0tRXhpdC0gQUVfT0s8L2Rpdj4KPGRp
dj6gdXRtdXRleC0wMjUzIFswM10gVXRDcmVhdGVNdXRleCCgIKAgoCCgIDogLS0tLUVudHJ5IDAw
MDAwMDA2PC9kaXY+PGRpdj6gdXRtdXRleC0wMjY4IFswM10gVXRDcmVhdGVNdXRleCCgIKAgoCCg
IDogLS0tLUV4aXQtIEFFX09LPC9kaXY+PGRpdj6gdXRtdXRleC0wMjUzIFswM10gVXRDcmVhdGVN
dXRleCCgIKAgoCCgIDogLS0tLUVudHJ5IDAwMDAwMDA3PC9kaXY+PGRpdj6gdXRtdXRleC0wMjY4
IFswM10gVXRDcmVhdGVNdXRleCCgIKAgoCCgIDogLS0tLUV4aXQtIEFFX09LPC9kaXY+CjxkaXY+
oHV0bXV0ZXgtMDE4OCBbMDJdIFV0TXV0ZXhJbml0aWFsaXplIKAgoCA6IC0tLS1FeGl0LSBBRV9P
SzwvZGl2PjxkaXY+bnNhY2Nlc3MtMDE1NCBbMDJdIE5zUm9vdEluaXRpYWxpemUgoCCgIKA6IC0t
LS1FbnRyeTwvZGl2PjxkaXY+bnNhY2Nlc3MtMDE4MiBbMDJdIE5zUm9vdEluaXRpYWxpemUgoCCg
IKA6IEVudGVyaW5nIHByZWRlZmluZWQgZW50cmllcyBpbnRvIG5hbWVzcGFjZTwvZGl2Pgo8ZGl2
Pm5zYWNjZXNzLTAzOTAgWzAzXSBOc0xvb2t1cCCgIKAgoCCgIKAgoCCgOiAtLS0tRW50cnk8L2Rp
dj48ZGl2Pm5zYWNjZXNzLTA0MTQgWzAzXSBOc0xvb2t1cCCgIKAgoCCgIKAgoCCgOiBOdWxsIHNj
b3BlIHByZWZpeCwgdXNpbmcgcm9vdCBub2RlICgweGI1NGRlYyk8L2Rpdj48ZGl2Pm5zYWNjZXNz
LTA0OTYgWzAzXSBOc0xvb2t1cCCgIKAgoCCgIKAgoCCgOiBTZWFyY2hpbmcgcmVsYXRpdmUgdG8g
cHJlZml4IHNjb3BlIFsmcXVvdDtcJnF1b3Q7IF0gKDB4YjU0ZGVjKTwvZGl2Pgo8ZGl2Pm5zYWNj
ZXNzLTA2MDcgWzAzXSBOc0xvb2t1cCCgIKAgoCCgIKAgoCCgOiBTaW1wbGUgUGF0aG5hbWUgKDEg
c2VnbWVudCwgRmxhZ3M9MCk8L2Rpdj48ZGl2PqCgbnNkdW1wLTAxNzUgWzAzXSBOc1ByaW50UGF0
aG5hbWUgoCCgIKAgOiBbX0dQRV08L2Rpdj48ZGl2Pm5zc2VhcmNoLTAzOTIgWzA0XSBOc1NlYXJj
aEFuZEVudGVyIKAgoCCgOiAtLS0tRW50cnk8L2Rpdj48ZGl2Pm5zc2VhcmNoLTAxODEgWzA1XSBO
c1NlYXJjaE9uZVNjb3BlIKAgoCCgOiAtLS0tRW50cnk8L2Rpdj4KPGRpdj6gbnNuYW1lcy0wMjI4
IFswNl0gTnNHZXRFeHRlcm5hbFBhdGhuYW1lIDogLS0tLUVudHJ5IDB4YjU0ZGVjPC9kaXY+PGRp
dj6gdXRhbGxvYy0wNDIzIFswN10gVXRBbGxvY2F0ZSCgIKAgoCCgIKAgoDogLS0tLUVudHJ5IDAw
MDAwMDAyPC9kaXY+PGRpdj6gdXRhbGxvYy0wNDQ2IFswN10gVXRBbGxvY2F0ZSCgIKAgoCCgIKAg
oDogLS0tLUV4aXQtIDB4MWIxNDNlN2M8L2Rpdj48ZGl2PgqgbnNuYW1lcy0wMjU3IFswNl0gTnNH
ZXRFeHRlcm5hbFBhdGhuYW1lIDogLS0tLUV4aXQtIDB4MWIxNDNlN2M8L2Rpdj48ZGl2Pm5zc2Vh
cmNoLTAxOTUgWzA1XSBOc1NlYXJjaE9uZVNjb3BlIKAgoCCgOiBTZWFyY2hpbmcgXCAoMHhiNTRk
ZWMpIEZvciBbX0dQRV0gKFNjb3BlKTwvZGl2PjxkaXY+bnNzZWFyY2gtMDI1NCBbMDVdIE5zU2Vh
cmNoT25lU2NvcGUgoCCgIKA6IE5hbWUgW19HUEVdIChTY29wZSkgbm90IGZvdW5kIGluIHNlYXJj
aCBpbiBzY29wZSBbJnF1b3Q7XCZxdW90OyBdIDB4YjU0ZGVjIGZpcnN0IGNoaWxkIDB4MDwvZGl2
Pgo8ZGl2Pm5zc2VhcmNoLTAyNTYgWzA1XSBOc1NlYXJjaE9uZVNjb3BlIKAgoCCgOiAtLS0tRXhp
dC0gKioqKkV4Y2VwdGlvbioqKio6IEFFX05PVF9GT1VORDwvZGl2PjxkaXY+oG5zYWxsb2MtMDE1
MCBbMDVdIE5zQ3JlYXRlTm9kZSCgIKAgoCCgIKA6IC0tLS1FbnRyeTwvZGl2PjxkaXY+oHV0YWxs
b2MtMDQyMyBbMDZdIFV0QWxsb2NhdGUgoCCgIKAgoCCgIKA6IC0tLS1FbnRyeSAwMDAwMDAxNDwv
ZGl2Pgo8ZGl2PqB1dGFsbG9jLTA0NDYgWzA2XSBVdEFsbG9jYXRlIKAgoCCgIKAgoCCgOiAtLS0t
RXhpdC0gMHgxYjEzYzljMDwvZGl2PjxkaXY+oG5zYWxsb2MtMDE3MiBbMDVdIE5zQ3JlYXRlTm9k
ZSCgIKAgoCCgIKA6IC0tLS1FeGl0LSAweDFiMTNjOWMwPC9kaXY+PGRpdj6gbnNhbGxvYy0wMzM2
IFswNV0gTnNJbnN0YWxsTm9kZSCgIKAgoCCgIDogLS0tLUVudHJ5PC9kaXY+PGRpdj6gbnNhbGxv
Yy0wMzgyIFswNV0gTnNJbnN0YWxsTm9kZSCgIKAgoCCgIDogX0dQRSAoU2NvcGUpIFtOb2RlIDB4
MWIxM2M5YzAgT3duZXIgMF0gYWRkZWQgdG8gJnF1b3Q7XCZxdW90OyCgKERldmljZSkgW05vZGUg
MHhiNTRkZWNdPC9kaXY+CjxkaXY+oG5zYWxsb2MtMDM4NCBbMDVdIE5zSW5zdGFsbE5vZGUgoCCg
IKAgoCA6IC0tLS1FeGl0LTwvZGl2PjxkaXY+bnNzZWFyY2gtMDUwNSBbMDRdIE5zU2VhcmNoQW5k
RW50ZXIgoCCgIKA6IC0tLS1FeGl0LSBBRV9PSzwvZGl2PjxkaXY+bnNhY2Nlc3MtMDc3MCBbMDNd
IE5zTG9va3VwIKAgoCCgIKAgoCCgIKA6IC0tLS1FeGl0LSBBRV9PSzwvZGl2PjxkaXY+bnNhY2Nl
c3MtMDM5MCBbMDNdIE5zTG9va3VwIKAgoCCgIKAgoCCgIKA6IC0tLS1FbnRyeTwvZGl2Pgo8ZGl2
Pm5zYWNjZXNzLTA0MTQgWzAzXSBOc0xvb2t1cCCgIKAgoCCgIKAgoCCgOiBOdWxsIHNjb3BlIHBy
ZWZpeCwgdXNpbmcgcm9vdCBub2RlICgweGI1NGRlYyk8L2Rpdj48ZGl2Pm5zYWNjZXNzLTA0OTYg
WzAzXSBOc0xvb2t1cCCgIKAgoCCgIKAgoCCgOiBTZWFyY2hpbmcgcmVsYXRpdmUgdG8gcHJlZml4
IHNjb3BlIFsmcXVvdDtcJnF1b3Q7IF0gKDB4YjU0ZGVjKTwvZGl2PjxkaXY+bnNhY2Nlc3MtMDYw
NyBbMDNdIE5zTG9va3VwIKAgoCCgIKAgoCCgIKA6IFNpbXBsZSBQYXRobmFtZSAoMSBzZWdtZW50
LCBGbGFncz0wKTwvZGl2Pgo8ZGl2PqCgbnNkdW1wLTAxNzUgWzAzXSBOc1ByaW50UGF0aG5hbWUg
oCCgIKAgOiBbX1BSX108L2Rpdj48ZGl2Pm5zc2VhcmNoLTAzOTIgWzA0XSBOc1NlYXJjaEFuZEVu
dGVyIKAgoCCgOiAtLS0tRW50cnk8L2Rpdj48ZGl2Pm5zc2VhcmNoLTAxODEgWzA1XSBOc1NlYXJj
aE9uZVNjb3BlIKAgoCCgOiAtLS0tRW50cnk8L2Rpdj48ZGl2PqBuc25hbWVzLTAyMjggWzA2XSBO
c0dldEV4dGVybmFsUGF0aG5hbWUgOiAtLS0tRW50cnkgMHhiNTRkZWM8L2Rpdj4KPGRpdj6gdXRh
bGxvYy0wNDIzIFswN10gVXRBbGxvY2F0ZSCgIKAgoCCgIKAgoDogLS0tLUVudHJ5IDAwMDAwMDAy
PC9kaXY+PGRpdj6gdXRhbGxvYy0wNDQ2IFswN10gVXRBbGxvY2F0ZSCgIKAgoCCgIKAgoDogLS0t
LUV4aXQtIDB4MWIxNDNlN2M8L2Rpdj48ZGl2PqBuc25hbWVzLTAyNTcgWzA2XSBOc0dldEV4dGVy
bmFsUGF0aG5hbWUgOiAtLS0tRXhpdC0gMHgxYjE0M2U3YzwvZGl2PjxkaXY+Cm5zc2VhcmNoLTAx
OTUgWzA1XSBOc1NlYXJjaE9uZVNjb3BlIKAgoCCgOiBTZWFyY2hpbmcgXCAoMHhiNTRkZWMpIEZv
ciBbX1BSX10gKFNjb3BlKTwvZGl2PjxkaXY+bnNzZWFyY2gtMDI1NCBbMDVdIE5zU2VhcmNoT25l
U2NvcGUgoCCgIKA6IE5hbWUgW19QUl9dIChTY29wZSkgbm90IGZvdW5kIGluIHNlYXJjaCBpbiBz
Y29wZSBbJnF1b3Q7XCZxdW90OyBdIDB4YjU0ZGVjIGZpcnN0IGNoaWxkIDB4MWIxM2M5YzA8L2Rp
dj4KPGRpdj5uc3NlYXJjaC0wMjU2IFswNV0gTnNTZWFyY2hPbmVTY29wZSCgIKAgoDogLS0tLUV4
aXQtICoqKipFeGNlcHRpb24qKioqOiBBRV9OT1RfRk9VTkQ8L2Rpdj48ZGl2PqBuc2FsbG9jLTAx
NTAgWzA1XSBOc0NyZWF0ZU5vZGUgoCCgIKAgoCCgOiAtLS0tRW50cnk8L2Rpdj48ZGl2PqB1dGFs
bG9jLTA0MjMgWzA2XSBVdEFsbG9jYXRlIKAgoCCgIKAgoCCgOiAtLS0tRW50cnkgMDAwMDAwMTQ8
L2Rpdj4KPGRpdj6gdXRhbGxvYy0wNDQ2IFswNl0gVXRBbGxvY2F0ZSCgIKAgoCCgIKAgoDogLS0t
LUV4aXQtIDB4MWIxYTg4MDg8L2Rpdj48ZGl2PqBuc2FsbG9jLTAxNzIgWzA1XSBOc0NyZWF0ZU5v
ZGUgoCCgIKAgoCCgOiAtLS0tRXhpdC0gMHgxYjFhODgwODwvZGl2PjxkaXY+oG5zYWxsb2MtMDMz
NiBbMDVdIE5zSW5zdGFsbE5vZGUgoCCgIKAgoCA6IC0tLS1FbnRyeTwvZGl2PjxkaXY+oG5zYWxs
b2MtMDM4MiBbMDVdIE5zSW5zdGFsbE5vZGUgoCCgIKAgoCA6IF9QUl8gKFNjb3BlKSBbTm9kZSAw
eDFiMWE4ODA4IE93bmVyIDBdIGFkZGVkIHRvICZxdW90O1wmcXVvdDsgoChEZXZpY2UpIFtOb2Rl
IDB4YjU0ZGVjXTwvZGl2Pgo8ZGl2PqBuc2FsbG9jLTAzODQgWzA1XSBOc0luc3RhbGxOb2RlIKAg
oCCgIKAgOiAtLS0tRXhpdC08L2Rpdj48ZGl2Pm5zc2VhcmNoLTA1MDUgWzA0XSBOc1NlYXJjaEFu
ZEVudGVyIKAgoCCgOiAtLS0tRXhpdC0gQUVfT0s8L2Rpdj48ZGl2Pm5zYWNjZXNzLTA3NzAgWzAz
XSBOc0xvb2t1cCCgIKAgoCCgIKAgoCCgOiAtLS0tRXhpdC0gQUVfT0s8L2Rpdj48ZGl2Pm5zYWNj
ZXNzLTAzOTAgWzAzXSBOc0xvb2t1cCCgIKAgoCCgIKAgoCCgOiAtLS0tRW50cnk8L2Rpdj4KPGRp
dj5uc2FjY2Vzcy0wNDE0IFswM10gTnNMb29rdXAgoCCgIKAgoCCgIKAgoDogTnVsbCBzY29wZSBw
cmVmaXgsIHVzaW5nIHJvb3Qgbm9kZSAoMHhiNTRkZWMpPC9kaXY+PGRpdj5uc2FjY2Vzcy0wNDk2
IFswM10gTnNMb29rdXAgoCCgIKAgoCCgIKAgoDogU2VhcmNoaW5nIHJlbGF0aXZlIHRvIHByZWZp
eCBzY29wZSBbJnF1b3Q7XCZxdW90OyBdICgweGI1NGRlYyk8L2Rpdj48ZGl2Pm5zYWNjZXNzLTA2
MDcgWzAzXSBOc0xvb2t1cCCgIKAgoCCgIKAgoCCgOiBTaW1wbGUgUGF0aG5hbWUgKDEgc2VnbWVu
dCwgRmxhZ3M9MCk8L2Rpdj4KPGRpdj6goG5zZHVtcC0wMTc1IFswM10gTnNQcmludFBhdGhuYW1l
IKAgoCCgIDogW19TQl9dPC9kaXY+PGRpdj5uc3NlYXJjaC0wMzkyIFswNF0gTnNTZWFyY2hBbmRF
bnRlciCgIKAgoDogLS0tLUVudHJ5PC9kaXY+PGRpdj5uc3NlYXJjaC0wMTgxIFswNV0gTnNTZWFy
Y2hPbmVTY29wZSCgIKAgoDogLS0tLUVudHJ5PC9kaXY+PGRpdj6gbnNuYW1lcy0wMjI4IFswNl0g
TnNHZXRFeHRlcm5hbFBhdGhuYW1lIDogLS0tLUVudHJ5IDB4YjU0ZGVjPC9kaXY+CjxkaXY+oHV0
YWxsb2MtMDQyMyBbMDddIFV0QWxsb2NhdGUgoCCgIKAgoCCgIKA6IC0tLS1FbnRyeSAwMDAwMDAw
MjwvZGl2PjxkaXY+oHV0YWxsb2MtMDQ0NiBbMDddIFV0QWxsb2NhdGUgoCCgIKAgoCCgIKA6IC0t
LS1FeGl0LSAweDFiMWE4N2U0PC9kaXY+PGRpdj6gbnNuYW1lcy0wMjU3IFswNl0gTnNHZXRFeHRl
cm5hbFBhdGhuYW1lIDogLS0tLUV4aXQtIDB4MWIxYTg3ZTQ8L2Rpdj48ZGl2Pgpuc3NlYXJjaC0w
MTk1IFswNV0gTnNTZWFyY2hPbmVTY29wZSCgIKAgoDogU2VhcmNoaW5nIFwgKDB4YjU0ZGVjKSBG
b3IgW19TQl9dIChEZXZpY2UpPC9kaXY+PGRpdj5uc3NlYXJjaC0wMjU0IFswNV0gTnNTZWFyY2hP
bmVTY29wZSCgIKAgoDogTmFtZSBbX1NCX10gKERldmljZSkgbm90IGZvdW5kIGluIHNlYXJjaCBp
biBzY29wZSBbJnF1b3Q7XCZxdW90OyBdIDB4YjU0ZGVjIGZpcnN0IGNoaWxkIDB4MWIxM2M5YzA8
L2Rpdj4KPGRpdj5uc3NlYXJjaC0wMjU2IFswNV0gTnNTZWFyY2hPbmVTY29wZSCgIKAgoDogLS0t
LUV4aXQtICoqKipFeGNlcHRpb24qKioqOiBBRV9OT1RfRk9VTkQ8L2Rpdj48ZGl2PqBuc2FsbG9j
LTAxNTAgWzA1XSBOc0NyZWF0ZU5vZGUgoCCgIKAgoCCgOiAtLS0tRW50cnk8L2Rpdj48ZGl2PqB1
dGFsbG9jLTA0MjMgWzA2XSBVdEFsbG9jYXRlIKAgoCCgIKAgoCCgOiAtLS0tRW50cnkgMDAwMDAw
MTQ8L2Rpdj4KPGRpdj6gdXRhbGxvYy0wNDQ2IFswNl0gVXRBbGxvY2F0ZSCgIKAgoCCgIKAgoDog
LS0tLUV4aXQtIDB4MWIxYTg3ZDQ8L2Rpdj48ZGl2PqBuc2FsbG9jLTAxNzIgWzA1XSBOc0NyZWF0
ZU5vZGUgoCCgIKAgoCCgOiAtLS0tRXhpdC0gMHgxYjFhODdkNDwvZGl2PjxkaXY+oG5zYWxsb2Mt
MDMzNiBbMDVdIE5zSW5zdGFsbE5vZGUgoCCgIKAgoCA6IC0tLS1FbnRyeTwvZGl2PjxkaXY+oG5z
YWxsb2MtMDM4MiBbMDVdIE5zSW5zdGFsbE5vZGUgoCCgIKAgoCA6IF9TQl8gKERldmljZSkgW05v
ZGUgMHgxYjFhODdkNCBPd25lciAwXSBhZGRlZCB0byAmcXVvdDtcJnF1b3Q7IKAoRGV2aWNlKSBb
Tm9kZSAweGI1NGRlY108L2Rpdj4KPGRpdj6gbnNhbGxvYy0wMzg0IFswNV0gTnNJbnN0YWxsTm9k
ZSCgIKAgoCCgIDogLS0tLUV4aXQtPC9kaXY+PGRpdj5uc3NlYXJjaC0wNTA1IFswNF0gTnNTZWFy
Y2hBbmRFbnRlciCgIKAgoDogLS0tLUV4aXQtIEFFX09LPC9kaXY+PGRpdj5uc2FjY2Vzcy0wNzcw
IFswM10gTnNMb29rdXAgoCCgIKAgoCCgIKAgoDogLS0tLUV4aXQtIEFFX09LPC9kaXY+PGRpdj5u
c2FjY2Vzcy0wMzkwIFswM10gTnNMb29rdXAgoCCgIKAgoCCgIKAgoDogLS0tLUVudHJ5PC9kaXY+
CjxkaXY+bnNhY2Nlc3MtMDQxNCBbMDNdIE5zTG9va3VwIKAgoCCgIKAgoCCgIKA6IE51bGwgc2Nv
cGUgcHJlZml4LCB1c2luZyByb290IG5vZGUgKDB4YjU0ZGVjKTwvZGl2PjxkaXY+bnNhY2Nlc3Mt
MDQ5NiBbMDNdIE5zTG9va3VwIKAgoCCgIKAgoCCgIKA6IFNlYXJjaGluZyByZWxhdGl2ZSB0byBw
cmVmaXggc2NvcGUgWyZxdW90O1wmcXVvdDsgXSAoMHhiNTRkZWMpPC9kaXY+PGRpdj5uc2FjY2Vz
cy0wNjA3IFswM10gTnNMb29rdXAgoCCgIKAgoCCgIKAgoDogU2ltcGxlIFBhdGhuYW1lICgxIHNl
Z21lbnQsIEZsYWdzPTApPC9kaXY+CjxkaXY+oKBuc2R1bXAtMDE3NSBbMDNdIE5zUHJpbnRQYXRo
bmFtZSCgIKAgoCA6IFtfU0lfXTwvZGl2PjxkaXY+bnNzZWFyY2gtMDM5MiBbMDRdIE5zU2VhcmNo
QW5kRW50ZXIgoCCgIKA6IC0tLS1FbnRyeTwvZGl2PjxkaXY+bnNzZWFyY2gtMDE4MSBbMDVdIE5z
U2VhcmNoT25lU2NvcGUgoCCgIKA6IC0tLS1FbnRyeTwvZGl2PjxkaXY+oG5zbmFtZXMtMDIyOCBb
MDZdIE5zR2V0RXh0ZXJuYWxQYXRobmFtZSA6IC0tLS1FbnRyeSAweGI1NGRlYzwvZGl2Pgo8ZGl2
PqB1dGFsbG9jLTA0MjMgWzA3XSBVdEFsbG9jYXRlIKAgoCCgIKAgoCCgOiAtLS0tRW50cnkgMDAw
MDAwMDI8L2Rpdj48ZGl2PqB1dGFsbG9jLTA0NDYgWzA3XSBVdEFsbG9jYXRlIKAgoCCgIKAgoCCg
OiAtLS0tRXhpdC0gMHgxYjFhODdiMDwvZGl2PjxkaXY+oG5zbmFtZXMtMDI1NyBbMDZdIE5zR2V0
RXh0ZXJuYWxQYXRobmFtZSA6IC0tLS1FeGl0LSAweDFiMWE4N2IwPC9kaXY+PGRpdj4KbnNzZWFy
Y2gtMDE5NSBbMDVdIE5zU2VhcmNoT25lU2NvcGUgoCCgIKA6IFNlYXJjaGluZyBcICgweGI1NGRl
YykgRm9yIFtfU0lfXSAoU2NvcGUpPC9kaXY+PGRpdj5uc3NlYXJjaC0wMjU0IFswNV0gTnNTZWFy
Y2hPbmVTY29wZSCgIKAgoDogTmFtZSBbX1NJX10gKFNjb3BlKSBub3QgZm91bmQgaW4gc2VhcmNo
IGluIHNjb3BlIFsmcXVvdDtcJnF1b3Q7IF0gMHhiNTRkZWMgZmlyc3QgY2hpbGQgMHgxYjEzYzlj
MDwvZGl2Pgo8ZGl2Pm5zc2VhcmNoLTAyNTYgWzA1XSBOc1NlYXJjaE9uZVNjb3BlIKAgoCCgOiAt
LS0tRXhpdC0gKioqKkV4Y2VwdGlvbioqKio6IEFFX05PVF9GT1VORDwvZGl2PjxkaXY+oG5zYWxs
b2MtMDE1MCBbMDVdIE5zQ3JlYXRlTm9kZSCgIKAgoCCgIKA6IC0tLS1FbnRyeTwvZGl2PjxkaXY+
oHV0YWxsb2MtMDQyMyBbMDZdIFV0QWxsb2NhdGUgoCCgIKAgoCCgIKA6IC0tLS1FbnRyeSAwMDAw
MDAxNDwvZGl2Pgo8ZGl2PqB1dGFsbG9jLTA0NDYgWzA2XSBVdEFsbG9jYXRlIKAgoCCgIKAgoCCg
OiAtLS0tRXhpdC0gMHgxYjFhODdhMDwvZGl2PjxkaXY+oG5zYWxsb2MtMDE3MiBbMDVdIE5zQ3Jl
YXRlTm9kZSCgIKAgoCCgIKA6IC0tLS1FeGl0LSAweDFiMWE4N2EwPC9kaXY+PGRpdj6gbnNhbGxv
Yy0wMzM2IFswNV0gTnNJbnN0YWxsTm9kZSCgIKAgoCCgIDogLS0tLUVudHJ5PC9kaXY+PGRpdj6g
bnNhbGxvYy0wMzgyIFswNV0gTnNJbnN0YWxsTm9kZSCgIKAgoCCgIDogX1NJXyAoU2NvcGUpIFtO
b2RlIDB4MWIxYTg3YTAgT3duZXIgMF0gYWRkZWQgdG8gJnF1b3Q7XCZxdW90OyCgKERldmljZSkg
W05vZGUgMHhiNTRkZWNdPC9kaXY+CjxkaXY+oG5zYWxsb2MtMDM4NCBbMDVdIE5zSW5zdGFsbE5v
ZGUgoCCgIKAgoCA6IC0tLS1FeGl0LTwvZGl2PjxkaXY+bnNzZWFyY2gtMDUwNSBbMDRdIE5zU2Vh
cmNoQW5kRW50ZXIgoCCgIKA6IC0tLS1FeGl0LSBBRV9PSzwvZGl2PjxkaXY+bnNhY2Nlc3MtMDc3
MCBbMDNdIE5zTG9va3VwIKAgoCCgIKAgoCCgIKA6IC0tLS1FeGl0LSBBRV9PSzwvZGl2PjxkaXY+
bnNhY2Nlc3MtMDM5MCBbMDNdIE5zTG9va3VwIKAgoCCgIKAgoCCgIKA6IC0tLS1FbnRyeTwvZGl2
Pgo8ZGl2Pm5zYWNjZXNzLTA0MTQgWzAzXSBOc0xvb2t1cCCgIKAgoCCgIKAgoCCgOiBOdWxsIHNj
b3BlIHByZWZpeCwgdXNpbmcgcm9vdCBub2RlICgweGI1NGRlYyk8L2Rpdj48ZGl2Pm5zYWNjZXNz
LTA0OTYgWzAzXSBOc0xvb2t1cCCgIKAgoCCgIKAgoCCgOiBTZWFyY2hpbmcgcmVsYXRpdmUgdG8g
cHJlZml4IHNjb3BlIFsmcXVvdDtcJnF1b3Q7IF0gKDB4YjU0ZGVjKTwvZGl2PjxkaXY+bnNhY2Nl
c3MtMDYwNyBbMDNdIE5zTG9va3VwIKAgoCCgIKAgoCCgIKA6IFNpbXBsZSBQYXRobmFtZSAoMSBz
ZWdtZW50LCBGbGFncz0wKTwvZGl2Pgo8ZGl2PqCgbnNkdW1wLTAxNzUgWzAzXSBOc1ByaW50UGF0
aG5hbWUgoCCgIKAgOiBbX1RaX108L2Rpdj48ZGl2Pm5zc2VhcmNoLTAzOTIgWzA0XSBOc1NlYXJj
aEFuZEVudGVyIKAgoCCgOiAtLS0tRW50cnk8L2Rpdj48ZGl2Pm5zc2VhcmNoLTAxODEgWzA1XSBO
c1NlYXJjaE9uZVNjb3BlIKAgoCCgOiAtLS0tRW50cnk8L2Rpdj48ZGl2PqBuc25hbWVzLTAyMjgg
WzA2XSBOc0dldEV4dGVybmFsUGF0aG5hbWUgOiAtLS0tRW50cnkgMHhiNTRkZWM8L2Rpdj4KPGRp
dj6gdXRhbGxvYy0wNDIzIFswN10gVXRBbGxvY2F0ZSCgIKAgoCCgIKAgoDogLS0tLUVudHJ5IDAw
MDAwMDAyPC9kaXY+PGRpdj6gdXRhbGxvYy0wNDQ2IFswN10gVXRBbGxvY2F0ZSCgIKAgoCCgIKAg
oDogLS0tLUV4aXQtIDB4MWIxYTg3N2M8L2Rpdj48ZGl2PqBuc25hbWVzLTAyNTcgWzA2XSBOc0dl
dEV4dGVybmFsUGF0aG5hbWUgOiAtLS0tRXhpdC0gMHgxYjFhODc3YzwvZGl2PjxkaXY+Cm5zc2Vh
cmNoLTAxOTUgWzA1XSBOc1NlYXJjaE9uZVNjb3BlIKAgoCCgOiBTZWFyY2hpbmcgXCAoMHhiNTRk
ZWMpIEZvciBbX1RaX10gKFRoZXJtYWwpPC9kaXY+PGRpdj5uc3NlYXJjaC0wMjU0IFswNV0gTnNT
ZWFyY2hPbmVTY29wZSCgIKAgoDogTmFtZSBbX1RaX10gKFRoZXJtYWwpIG5vdCBmb3VuZCBpbiBz
ZWFyY2ggaW4gc2NvcGUgWyZxdW90O1wmcXVvdDsgXSAweGI1NGRlYyBmaXJzdCBjaGlsZCAweDFi
MTNjOWMwPC9kaXY+CjxkaXY+bnNzZWFyY2gtMDI1NiBbMDVdIE5zU2VhcmNoT25lU2NvcGUgoCCg
IKA6IC0tLS1FeGl0LSAqKioqRXhjZXB0aW9uKioqKjogQUVfTk9UX0ZPVU5EPC9kaXY+PGRpdj6g
bnNhbGxvYy0wMTUwIFswNV0gTnNDcmVhdGVOb2RlIKAgoCCgIKAgoDogLS0tLUVudHJ5PC9kaXY+
PGRpdj6gdXRhbGxvYy0wNDIzIFswNl0gVXRBbGxvY2F0ZSCgIKAgoCCgIKAgoDogLS0tLUVudHJ5
IDAwMDAwMDE0PC9kaXY+CjxkaXY+oHV0YWxsb2MtMDQ0NiBbMDZdIFV0QWxsb2NhdGUgoCCgIKAg
oCCgIKA6IC0tLS1FeGl0LSAweDFiMWE4NzZjPC9kaXY+PGRpdj6gbnNhbGxvYy0wMTcyIFswNV0g
TnNDcmVhdGVOb2RlIKAgoCCgIKAgoDogLS0tLUV4aXQtIDB4MWIxYTg3NmM8L2Rpdj48ZGl2PqBu
c2FsbG9jLTAzMzYgWzA1XSBOc0luc3RhbGxOb2RlIKAgoCCgIKAgOiAtLS0tRW50cnk8L2Rpdj48
ZGl2PqBuc2FsbG9jLTAzODIgWzA1XSBOc0luc3RhbGxOb2RlIKAgoCCgIKAgOiBfVFpfIChUaGVy
bWFsKSBbTm9kZSAweDFiMWE4NzZjIE93bmVyIDBdIGFkZGVkIHRvICZxdW90O1wmcXVvdDsgoChE
ZXZpY2UpIFtOb2RlIDB4YjU0ZGVjXTwvZGl2Pgo8ZGl2PqBuc2FsbG9jLTAzODQgWzA1XSBOc0lu
c3RhbGxOb2RlIKAgoCCgIKAgOiAtLS0tRXhpdC08L2Rpdj48ZGl2Pm5zc2VhcmNoLTA1MDUgWzA0
XSBOc1NlYXJjaEFuZEVudGVyIKAgoCCgOiAtLS0tRXhpdC0gQUVfT0s8L2Rpdj48ZGl2Pm5zYWNj
ZXNzLTA3NzAgWzAzXSBOc0xvb2t1cCCgIKAgoCCgIKAgoCCgOiAtLS0tRXhpdC0gQUVfT0s8L2Rp
dj48ZGl2Pm5zYWNjZXNzLTAzOTAgWzAzXSBOc0xvb2t1cCCgIKAgoCCgIKAgoCCgOiAtLS0tRW50
cnk8L2Rpdj4KPGRpdj5uc2FjY2Vzcy0wNDE0IFswM10gTnNMb29rdXAgoCCgIKAgoCCgIKAgoDog
TnVsbCBzY29wZSBwcmVmaXgsIHVzaW5nIHJvb3Qgbm9kZSAoMHhiNTRkZWMpPC9kaXY+PGRpdj5u
c2FjY2Vzcy0wNDk2IFswM10gTnNMb29rdXAgoCCgIKAgoCCgIKAgoDogU2VhcmNoaW5nIHJlbGF0
aXZlIHRvIHByZWZpeCBzY29wZSBbJnF1b3Q7XCZxdW90OyBdICgweGI1NGRlYyk8L2Rpdj48ZGl2
Pm5zYWNjZXNzLTA2MDcgWzAzXSBOc0xvb2t1cCCgIKAgoCCgIKAgoCCgOiBTaW1wbGUgUGF0aG5h
bWUgKDEgc2VnbWVudCwgRmxhZ3M9MCk8L2Rpdj4KPGRpdj6goG5zZHVtcC0wMTc1IFswM10gTnNQ
cmludFBhdGhuYW1lIKAgoCCgIDogW19SRVZdPC9kaXY+PGRpdj5uc3NlYXJjaC0wMzkyIFswNF0g
TnNTZWFyY2hBbmRFbnRlciCgIKAgoDogLS0tLUVudHJ5PC9kaXY+PGRpdj5uc3NlYXJjaC0wMTgx
IFswNV0gTnNTZWFyY2hPbmVTY29wZSCgIKAgoDogLS0tLUVudHJ5PC9kaXY+PGRpdj6gbnNuYW1l
cy0wMjI4IFswNl0gTnNHZXRFeHRlcm5hbFBhdGhuYW1lIDogLS0tLUVudHJ5IDB4YjU0ZGVjPC9k
aXY+CjxkaXY+oHV0YWxsb2MtMDQyMyBbMDddIFV0QWxsb2NhdGUgoCCgIKAgoCCgIKA6IC0tLS1F
bnRyeSAwMDAwMDAwMjwvZGl2PjxkaXY+oHV0YWxsb2MtMDQ0NiBbMDddIFV0QWxsb2NhdGUgoCCg
IKAgoCCgIKA6IC0tLS1FeGl0LSAweDFiMWE4NzQ4PC9kaXY+PGRpdj6gbnNuYW1lcy0wMjU3IFsw
Nl0gTnNHZXRFeHRlcm5hbFBhdGhuYW1lIDogLS0tLUV4aXQtIDB4MWIxYTg3NDg8L2Rpdj48ZGl2
Pgpuc3NlYXJjaC0wMTk1IFswNV0gTnNTZWFyY2hPbmVTY29wZSCgIKAgoDogU2VhcmNoaW5nIFwg
KDB4YjU0ZGVjKSBGb3IgW19SRVZdIChJbnRlZ2VyKTwvZGl2PjxkaXY+bnNzZWFyY2gtMDI1NCBb
MDVdIE5zU2VhcmNoT25lU2NvcGUgoCCgIKA6IE5hbWUgW19SRVZdIChJbnRlZ2VyKSBub3QgZm91
bmQgaW4gc2VhcmNoIGluIHNjb3BlIFsmcXVvdDtcJnF1b3Q7IF0gMHhiNTRkZWMgZmlyc3QgY2hp
bGQgMHgxYjEzYzljMDwvZGl2Pgo8ZGl2Pm5zc2VhcmNoLTAyNTYgWzA1XSBOc1NlYXJjaE9uZVNj
b3BlIKAgoCCgOiAtLS0tRXhpdC0gKioqKkV4Y2VwdGlvbioqKio6IEFFX05PVF9GT1VORDwvZGl2
PjxkaXY+oG5zYWxsb2MtMDE1MCBbMDVdIE5zQ3JlYXRlTm9kZSCgIKAgoCCgIKA6IC0tLS1FbnRy
eTwvZGl2PjxkaXY+oHV0YWxsb2MtMDQyMyBbMDZdIFV0QWxsb2NhdGUgoCCgIKAgoCCgIKA6IC0t
LS1FbnRyeSAwMDAwMDAxNDwvZGl2Pgo8ZGl2PqB1dGFsbG9jLTA0NDYgWzA2XSBVdEFsbG9jYXRl
IKAgoCCgIKAgoCCgOiAtLS0tRXhpdC0gMHgxYjFhODczODwvZGl2PjxkaXY+oG5zYWxsb2MtMDE3
MiBbMDVdIE5zQ3JlYXRlTm9kZSCgIKAgoCCgIKA6IC0tLS1FeGl0LSAweDFiMWE4NzM4PC9kaXY+
PGRpdj6gbnNhbGxvYy0wMzM2IFswNV0gTnNJbnN0YWxsTm9kZSCgIKAgoCCgIDogLS0tLUVudHJ5
PC9kaXY+PGRpdj6gbnNhbGxvYy0wMzgyIFswNV0gTnNJbnN0YWxsTm9kZSCgIKAgoCCgIDogX1JF
ViAoSW50ZWdlcikgW05vZGUgMHgxYjFhODczOCBPd25lciAwXSBhZGRlZCB0byAmcXVvdDtcJnF1
b3Q7IKAoRGV2aWNlKSBbTm9kZSAweGI1NGRlY108L2Rpdj4KPGRpdj6gbnNhbGxvYy0wMzg0IFsw
NV0gTnNJbnN0YWxsTm9kZSCgIKAgoCCgIDogLS0tLUV4aXQtPC9kaXY+PGRpdj5uc3NlYXJjaC0w
NTA1IFswNF0gTnNTZWFyY2hBbmRFbnRlciCgIKAgoDogLS0tLUV4aXQtIEFFX09LPC9kaXY+PGRp
dj5uc2FjY2Vzcy0wNzcwIFswM10gTnNMb29rdXAgoCCgIKAgoCCgIKAgoDogLS0tLUV4aXQtIEFF
X09LPC9kaXY+PGRpdj51dG9iamVjdC0wMTc5IFswM10gVXRDcmVhdGVJbnRlcm5hbE9iamVjdDog
LS0tLUVudHJ5IEludGVnZXI8L2Rpdj4KPGRpdj51dG9iamVjdC0wNTA2IFswNF0gVXRBbGxvY2F0
ZU9iamVjdERlc2NEYjogLS0tLUVudHJ5PC9kaXY+PGRpdj6gdXRhbGxvYy0wNDIzIFswNV0gVXRB
bGxvY2F0ZSCgIKAgoCCgIKAgoDogLS0tLUVudHJ5IDAwMDAwMDI4PC9kaXY+PGRpdj6gdXRhbGxv
Yy0wNDQ2IFswNV0gVXRBbGxvY2F0ZSCgIKAgoCCgIKAgoDogLS0tLUV4aXQtIDB4MWIxYTg2ZTg8
L2Rpdj48ZGl2PnV0b2JqZWN0LTA1MjMgWzA0XSBVdEFsbG9jYXRlT2JqZWN0RGVzY0RiOiAweDFi
MWE4NmU4IFNpemUgMjg8L2Rpdj4KPGRpdj51dG9iamVjdC0wNTI1IFswNF0gVXRBbGxvY2F0ZU9i
amVjdERlc2NEYjogLS0tLUV4aXQtIDB4MWIxYTg2ZTg8L2Rpdj48ZGl2PnV0b2JqZWN0LTAyMjkg
WzAzXSBVdENyZWF0ZUludGVybmFsT2JqZWN0OiAtLS0tRXhpdC0gMHgxYjFhODZlODwvZGl2Pjxk
aXY+bnNvYmplY3QtMDE2MSBbMDNdIE5zQXR0YWNoT2JqZWN0IKAgoCCgIKA6IC0tLS1FbnRyeTwv
ZGl2PjxkaXY+bnNvYmplY3QtMDI0MSBbMDNdIE5zQXR0YWNoT2JqZWN0IKAgoCCgIKA6IEluc3Rh
bGxpbmcgMHgxYjFhODZlOCBpbnRvIE5vZGUgMHgxYjFhODczOCBbX1JFVl08L2Rpdj4KPGRpdj51
dGRlbGV0ZS0wNzU1IFswNF0gVXRBZGRSZWZlcmVuY2UgoCCgIKAgoDogLS0tLUVudHJ5IDB4MWIx
YTg2ZTg8L2Rpdj48ZGl2PnV0ZGVsZXRlLTA3NjcgWzA0XSBVdEFkZFJlZmVyZW5jZSCgIKAgoCCg
OiBPYmogMHgxYjFhODZlOCBDdXJyZW50IFJlZnM9MSBbVG8gQmUgSW5jcmVtZW50ZWRdPC9kaXY+
PGRpdj51dGRlbGV0ZS0wNTkyIFswNV0gVXRVcGRhdGVPYmplY3RSZWZlcmVuYzogLS0tLUVudHJ5
IDB4MWIxYTg2ZTg8L2Rpdj4KPGRpdj51dGRlbGV0ZS0wNDk1IFswNV0gVXRVcGRhdGVSZWZDb3Vu
dCCgIKAgoDogT2JqIDB4MWIxYTg2ZTggUmVmcz0yLCBbSW5jcmVtZW50ZWRdPC9kaXY+PGRpdj51
dGRlbGV0ZS0wNzE3IFswNV0gVXRVcGRhdGVPYmplY3RSZWZlcmVuYzogLS0tLUV4aXQtIEFFX09L
PC9kaXY+PGRpdj51dGRlbGV0ZS0wNzcyIFswNF0gVXRBZGRSZWZlcmVuY2UgoCCgIKAgoDogLS0t
LUV4aXQtPC9kaXY+CjxkaXY+bnNvYmplY3QtMDI3NiBbMDNdIE5zQXR0YWNoT2JqZWN0IKAgoCCg
IKA6IC0tLS1FeGl0LSBBRV9PSzwvZGl2PjxkaXY+dXRkZWxldGUtMDc5MyBbMDNdIFV0UmVtb3Zl
UmVmZXJlbmNlIKAgoCA6IC0tLS1FbnRyeSAweDFiMWE4NmU4PC9kaXY+PGRpdj51dGRlbGV0ZS0w
ODE3IFswM10gVXRSZW1vdmVSZWZlcmVuY2UgoCCgIDogT2JqIDB4MWIxYTg2ZTggQ3VycmVudCBS
ZWZzPTIgW1RvIEJlIERlY3JlbWVudGVkXTwvZGl2Pgo8ZGl2PnV0ZGVsZXRlLTA1OTIgWzA0XSBV
dFVwZGF0ZU9iamVjdFJlZmVyZW5jOiAtLS0tRW50cnkgMHgxYjFhODZlODwvZGl2PjxkaXY+dXRk
ZWxldGUtMDUxNCBbMDRdIFV0VXBkYXRlUmVmQ291bnQgoCCgIKA6IE9iaiAweDFiMWE4NmU4IFJl
ZnM9MSwgW0RlY3JlbWVudGVkXTwvZGl2PjxkaXY+dXRkZWxldGUtMDcxNyBbMDRdIFV0VXBkYXRl
T2JqZWN0UmVmZXJlbmM6IC0tLS1FeGl0LSBBRV9PSzwvZGl2Pgo8ZGl2PnV0ZGVsZXRlLTA4MjUg
WzAzXSBVdFJlbW92ZVJlZmVyZW5jZSCgIKAgOiAtLS0tRXhpdC08L2Rpdj48ZGl2Pm5zYWNjZXNz
LTAzOTAgWzAzXSBOc0xvb2t1cCCgIKAgoCCgIKAgoCCgOiAtLS0tRW50cnk8L2Rpdj48ZGl2Pm5z
YWNjZXNzLTA0MTQgWzAzXSBOc0xvb2t1cCCgIKAgoCCgIKAgoCCgOiBOdWxsIHNjb3BlIHByZWZp
eCwgdXNpbmcgcm9vdCBub2RlICgweGI1NGRlYyk8L2Rpdj4KPGRpdj5uc2FjY2Vzcy0wNDk2IFsw
M10gTnNMb29rdXAgoCCgIKAgoCCgIKAgoDogU2VhcmNoaW5nIHJlbGF0aXZlIHRvIHByZWZpeCBz
Y29wZSBbJnF1b3Q7XCZxdW90OyBdICgweGI1NGRlYyk8L2Rpdj48ZGl2Pm5zYWNjZXNzLTA2MDcg
WzAzXSBOc0xvb2t1cCCgIKAgoCCgIKAgoCCgOiBTaW1wbGUgUGF0aG5hbWUgKDEgc2VnbWVudCwg
RmxhZ3M9MCk8L2Rpdj48ZGl2PqCgbnNkdW1wLTAxNzUgWzAzXSBOc1ByaW50UGF0aG5hbWUgoCCg
IKAgOiBbX09TX108L2Rpdj4KPGRpdj5uc3NlYXJjaC0wMzkyIFswNF0gTnNTZWFyY2hBbmRFbnRl
ciCgIKAgoDogLS0tLUVudHJ5PC9kaXY+PGRpdj5uc3NlYXJjaC0wMTgxIFswNV0gTnNTZWFyY2hP
bmVTY29wZSCgIKAgoDogLS0tLUVudHJ5PC9kaXY+PGRpdj6gbnNuYW1lcy0wMjI4IFswNl0gTnNH
ZXRFeHRlcm5hbFBhdGhuYW1lIDogLS0tLUVudHJ5IDB4YjU0ZGVjPC9kaXY+PGRpdj6gdXRhbGxv
Yy0wNDIzIFswN10gVXRBbGxvY2F0ZSCgIKAgoCCgIKAgoDogLS0tLUVudHJ5IDAwMDAwMDAyPC9k
aXY+CjxkaXY+oHV0YWxsb2MtMDQ0NiBbMDddIFV0QWxsb2NhdGUgoCCgIKAgoCCgIKA6IC0tLS1F
eGl0LSAweDFiMWE4Y2MwPC9kaXY+PGRpdj6gbnNuYW1lcy0wMjU3IFswNl0gTnNHZXRFeHRlcm5h
bFBhdGhuYW1lIDogLS0tLUV4aXQtIDB4MWIxYThjYzA8L2Rpdj48ZGl2Pm5zc2VhcmNoLTAxOTUg
WzA1XSBOc1NlYXJjaE9uZVNjb3BlIKAgoCCgOiBTZWFyY2hpbmcgXCAoMHhiNTRkZWMpIEZvciBb
X09TX10gKFN0cmluZyk8L2Rpdj4KPGRpdj5uc3NlYXJjaC0wMjU0IFswNV0gTnNTZWFyY2hPbmVT
Y29wZSCgIKAgoDogTmFtZSBbX09TX10gKFN0cmluZykgbm90IGZvdW5kIGluIHNlYXJjaCBpbiBz
Y29wZSBbJnF1b3Q7XCZxdW90OyBdIDB4YjU0ZGVjIGZpcnN0IGNoaWxkIDB4MWIxM2M5YzA8L2Rp
dj48ZGl2Pm5zc2VhcmNoLTAyNTYgWzA1XSBOc1NlYXJjaE9uZVNjb3BlIKAgoCCgOiAtLS0tRXhp
dC0gKioqKkV4Y2VwdGlvbioqKio6IEFFX05PVF9GT1VORDwvZGl2Pgo8ZGl2PqBuc2FsbG9jLTAx
NTAgWzA1XSBOc0NyZWF0ZU5vZGUgoCCgIKAgoCCgOiAtLS0tRW50cnk8L2Rpdj48ZGl2PqB1dGFs
bG9jLTA0MjMgWzA2XSBVdEFsbG9jYXRlIKAgoCCgIKAgoCCgOiAtLS0tRW50cnkgMDAwMDAwMTQ8
L2Rpdj48ZGl2PqB1dGFsbG9jLTA0NDYgWzA2XSBVdEFsbG9jYXRlIKAgoCCgIKAgoCCgOiAtLS0t
RXhpdC0gMHgxYjFhOGNiMDwvZGl2PjxkaXY+oG5zYWxsb2MtMDE3MiBbMDVdIE5zQ3JlYXRlTm9k
ZSCgIKAgoCCgIKA6IC0tLS1FeGl0LSAweDFiMWE4Y2IwPC9kaXY+CjxkaXY+oG5zYWxsb2MtMDMz
NiBbMDVdIE5zSW5zdGFsbE5vZGUgoCCgIKAgoCA6IC0tLS1FbnRyeTwvZGl2PjxkaXY+oG5zYWxs
b2MtMDM4MiBbMDVdIE5zSW5zdGFsbE5vZGUgoCCgIKAgoCA6IF9PU18gKFN0cmluZykgW05vZGUg
MHgxYjFhOGNiMCBPd25lciAwXSBhZGRlZCB0byAmcXVvdDtcJnF1b3Q7IKAoRGV2aWNlKSBbTm9k
ZSAweGI1NGRlY108L2Rpdj48ZGl2PqBuc2FsbG9jLTAzODQgWzA1XSBOc0luc3RhbGxOb2RlIKAg
oCCgIKAgOiAtLS0tRXhpdC08L2Rpdj4KPGRpdj5uc3NlYXJjaC0wNTA1IFswNF0gTnNTZWFyY2hB
bmRFbnRlciCgIKAgoDogLS0tLUV4aXQtIEFFX09LPC9kaXY+PGRpdj5uc2FjY2Vzcy0wNzcwIFsw
M10gTnNMb29rdXAgoCCgIKAgoCCgIKAgoDogLS0tLUV4aXQtIEFFX09LPC9kaXY+PGRpdj51dG9i
amVjdC0wMTc5IFswM10gVXRDcmVhdGVJbnRlcm5hbE9iamVjdDogLS0tLUVudHJ5IFN0cmluZzwv
ZGl2PjxkaXY+dXRvYmplY3QtMDUwNiBbMDRdIFV0QWxsb2NhdGVPYmplY3REZXNjRGI6IC0tLS1F
bnRyeTwvZGl2Pgo8ZGl2PqB1dGFsbG9jLTA0MjMgWzA1XSBVdEFsbG9jYXRlIKAgoCCgIKAgoCCg
OiAtLS0tRW50cnkgMDwvZGl2PjxkaXY+PGJyPjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9x
dW90ZSI+T24gVHVlLCBKdWwgNiwgMjAxMCBhdCAxMDozNyBBTSwgWmhhbmcgUnVpIDxzcGFuIGRp
cj0ibHRyIj4mbHQ7PGEgaHJlZj0ibWFpbHRvOnJ1aS56aGFuZ0BpbnRlbC5jb20iPnJ1aS56aGFu
Z0BpbnRlbC5jb208L2E+Jmd0Ozwvc3Bhbj4gd3JvdGU6PGJyPgo8YmxvY2txdW90ZSBjbGFzcz0i
Z21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2Nj
YyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4OyI+PGRpdj48ZGl2PjwvZGl2PjxkaXYgY2xhc3M9Img1
Ij5PbiBUdWUsIDIwMTAtMDctMDYgYXQgMTA6MjkgKzA4MDAsIFNlYW4gU2hvdWZ1IEx1byB3cm90
ZTo8YnI+CiZndDsgUHJldmlvdXNseSwgSSBoYXZlIHBvcnRlZCBBQ1BJQ0EgdG8gb3VyIHN5c3Rl
bS4gVGhlc2UgZGF5cywgSSB3b25uYSB0bzxicj4KJmd0OyB3cml0ZSBBQ1BJIGRyaXZlciBmb3Ig
YmF0dGVyeSB3aXRoIE5ldGJzZCYjMzk7cyB2ZXJzaW9uIGFzIGd1aWRlLCBidXQgSTxicj4KJmd0
OyBmb3VuZCB3aGVuIEkgaW5pdGlhbGl6ZWQgYmF0dGVyeSBkcml2ZXIsIGl0IHdvdWxkIGlzc3Vl
IGEgY29tbWFuZCB0bzxicj4KJmd0OyBxdWVyeSBfU1RBIGZvciBiYXR0ZXJ5IHByZXNlbmNlLiBC
dXQgaXRzIHJldHVybiB2YWx1ZSBpcyAweGYsIHRoYXQ8YnI+CiZndDsgaW5kaWNhdGVzIFBSRVNF
TkNFIGJpdCBpcyBub3Qgc2V0ICgweDAwMDAwMDEwKS4goEkmIzM5O20gcHV6emxlZC4gSSYjMzk7
bTxicj4KJmd0OyB1c2luZyBiYXR0ZXJ5IC4uLi5XaHkgdGhlIGJhdHRlcnkgbm90IHByZXNlbnQ/
PGJyPgomZ3Q7IEFueW9uZSBjYW4gZ2l2ZSBhbnkgaGludD88YnI+CiZndDs8YnI+CjwvZGl2Pjwv
ZGl2PnBsZWFzZSBhdHRhY2ggdGhlIGFjcGlkdW1wIG91dHB1dCBvZiB0aGlzIG1hY2hpbmUuPGJy
Pgo8YnI+CnRoYW5rcyw8YnI+Cjxmb250IGNvbG9yPSIjODg4ODg4Ij5ydWk8YnI+Cjxicj4KPGJy
Pgo8L2ZvbnQ+PC9ibG9ja3F1b3RlPjwvZGl2Pjxicj48L2Rpdj48L2Rpdj4K

--===============7170047318903659440==--

