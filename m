Content-Type: multipart/mixed; boundary="===============6914058673998007394=="
MIME-Version: 1.0
From: Sean Shoufu Luo <luoshoufu at gmail.com>
Subject: Re: [Devel] Battery Presence
Date: Tue, 06 Jul 2010 17:46:56 +0800
Message-ID: <AANLkTilAWewbuzmgQnEIsna72NGt5d0VCsHeYVg6GIhJ@mail.gmail.com>
In-Reply-To: AANLkTinwInMnIsuZaaXSZBsLOaZexVlGeDv_fqOHOZ3H@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6914058673998007394==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

OK, I find the root cause that the reason system hang, that is when it try
call ACPICA API to enable ACPI by writing HW port (port 0x82f and value
0xe1), once the call outb, the system become hang .....................

In my understand, both which port and what value to write is decided by ACPI
TABLE, Which is provided by BIOS and cannot be invalid, why it will cause
system hang?



On Tue, Jul 6, 2010 at 1:47 PM, Sean Shoufu Luo <luoshoufu(a)gmail.com> wro=
te:

> Yes, i'm trying .... but now, in my mobile client, it seems, something el=
se
> wrong when enable ACPI sub system
> I set ACPI_LV_ALL for debug, and it give me such output, and then system
> hang. ......................... any idea?
>
>  utxface-0152 [01] InitializeSubsystem   : ----Entry
> utglobal-0854 [02] UtInitGlobals         : ----Entry
> utglobal-0964 [02] UtInitGlobals         : ----Exit- AE_OK
>  utmutex-0157 [02] UtMutexInitialize     : ----Entry
>  utmutex-0253 [03] UtCreateMutex         : ----Entry 00000000
>  utmutex-0268 [03] UtCreateMutex         : ----Exit- AE_OK
>  utmutex-0253 [03] UtCreateMutex         : ----Entry 00000001
>  utmutex-0268 [03] UtCreateMutex         : ----Exit- AE_OK
>  utmutex-0253 [03] UtCreateMutex         : ----Entry 00000002
>  utmutex-0268 [03] UtCreateMutex         : ----Exit- AE_OK
>  utmutex-0253 [03] UtCreateMutex         : ----Entry 00000003
>  utmutex-0268 [03] UtCreateMutex         : ----Exit- AE_OK
>  utmutex-0253 [03] UtCreateMutex         : ----Entry 00000004
>  utmutex-0268 [03] UtCreateMutex         : ----Exit- AE_OK
>  utmutex-0253 [03] UtCreateMutex         : ----Entry 00000005
>  utmutex-0268 [03] UtCreateMutex         : ----Exit- AE_OK
>  utmutex-0253 [03] UtCreateMutex         : ----Entry 00000006
>  utmutex-0268 [03] UtCreateMutex         : ----Exit- AE_OK
>  utmutex-0253 [03] UtCreateMutex         : ----Entry 00000007
>  utmutex-0268 [03] UtCreateMutex         : ----Exit- AE_OK
>  utmutex-0188 [02] UtMutexInitialize     : ----Exit- AE_OK
> nsaccess-0154 [02] NsRootInitialize      : ----Entry
> nsaccess-0182 [02] NsRootInitialize      : Entering predefined entries in=
to
> namespace
> nsaccess-0390 [03] NsLookup              : ----Entry
> nsaccess-0414 [03] NsLookup              : Null scope prefix, using root
> node (0xb54dec)
> nsaccess-0496 [03] NsLookup              : Searching relative to prefix
> scope ["\" ] (0xb54dec)
> nsaccess-0607 [03] NsLookup              : Simple Pathname (1 segment,
> Flags=3D0)
>   nsdump-0175 [03] NsPrintPathname       : [_GPE]
> nssearch-0392 [04] NsSearchAndEnter      : ----Entry
> nssearch-0181 [05] NsSearchOneScope      : ----Entry
>  nsnames-0228 [06] NsGetExternalPathname : ----Entry 0xb54dec
>  utalloc-0423 [07] UtAllocate            : ----Entry 00000002
>  utalloc-0446 [07] UtAllocate            : ----Exit- 0x1b143e7c
>  nsnames-0257 [06] NsGetExternalPathname : ----Exit- 0x1b143e7c
> nssearch-0195 [05] NsSearchOneScope      : Searching \ (0xb54dec) For
> [_GPE] (Scope)
> nssearch-0254 [05] NsSearchOneScope      : Name [_GPE] (Scope) not found =
in
> search in scope ["\" ] 0xb54dec first child 0x0
> nssearch-0256 [05] NsSearchOneScope      : ----Exit- ****Exception****:
> AE_NOT_FOUND
>  nsalloc-0150 [05] NsCreateNode          : ----Entry
>  utalloc-0423 [06] UtAllocate            : ----Entry 00000014
>  utalloc-0446 [06] UtAllocate            : ----Exit- 0x1b13c9c0
>  nsalloc-0172 [05] NsCreateNode          : ----Exit- 0x1b13c9c0
>  nsalloc-0336 [05] NsInstallNode         : ----Entry
>  nsalloc-0382 [05] NsInstallNode         : _GPE (Scope) [Node 0x1b13c9c0
> Owner 0] added to "\"  (Device) [Node 0xb54dec]
>  nsalloc-0384 [05] NsInstallNode         : ----Exit-
> nssearch-0505 [04] NsSearchAndEnter      : ----Exit- AE_OK
> nsaccess-0770 [03] NsLookup              : ----Exit- AE_OK
> nsaccess-0390 [03] NsLookup              : ----Entry
> nsaccess-0414 [03] NsLookup              : Null scope prefix, using root
> node (0xb54dec)
> nsaccess-0496 [03] NsLookup              : Searching relative to prefix
> scope ["\" ] (0xb54dec)
> nsaccess-0607 [03] NsLookup              : Simple Pathname (1 segment,
> Flags=3D0)
>   nsdump-0175 [03] NsPrintPathname       : [_PR_]
> nssearch-0392 [04] NsSearchAndEnter      : ----Entry
> nssearch-0181 [05] NsSearchOneScope      : ----Entry
>  nsnames-0228 [06] NsGetExternalPathname : ----Entry 0xb54dec
>  utalloc-0423 [07] UtAllocate            : ----Entry 00000002
>  utalloc-0446 [07] UtAllocate            : ----Exit- 0x1b143e7c
>  nsnames-0257 [06] NsGetExternalPathname : ----Exit- 0x1b143e7c
> nssearch-0195 [05] NsSearchOneScope      : Searching \ (0xb54dec) For
> [_PR_] (Scope)
> nssearch-0254 [05] NsSearchOneScope      : Name [_PR_] (Scope) not found =
in
> search in scope ["\" ] 0xb54dec first child 0x1b13c9c0
> nssearch-0256 [05] NsSearchOneScope      : ----Exit- ****Exception****:
> AE_NOT_FOUND
>  nsalloc-0150 [05] NsCreateNode          : ----Entry
>  utalloc-0423 [06] UtAllocate            : ----Entry 00000014
>  utalloc-0446 [06] UtAllocate            : ----Exit- 0x1b1a8808
>  nsalloc-0172 [05] NsCreateNode          : ----Exit- 0x1b1a8808
>  nsalloc-0336 [05] NsInstallNode         : ----Entry
>  nsalloc-0382 [05] NsInstallNode         : _PR_ (Scope) [Node 0x1b1a8808
> Owner 0] added to "\"  (Device) [Node 0xb54dec]
>  nsalloc-0384 [05] NsInstallNode         : ----Exit-
> nssearch-0505 [04] NsSearchAndEnter      : ----Exit- AE_OK
> nsaccess-0770 [03] NsLookup              : ----Exit- AE_OK
> nsaccess-0390 [03] NsLookup              : ----Entry
> nsaccess-0414 [03] NsLookup              : Null scope prefix, using root
> node (0xb54dec)
> nsaccess-0496 [03] NsLookup              : Searching relative to prefix
> scope ["\" ] (0xb54dec)
> nsaccess-0607 [03] NsLookup              : Simple Pathname (1 segment,
> Flags=3D0)
>   nsdump-0175 [03] NsPrintPathname       : [_SB_]
> nssearch-0392 [04] NsSearchAndEnter      : ----Entry
> nssearch-0181 [05] NsSearchOneScope      : ----Entry
>  nsnames-0228 [06] NsGetExternalPathname : ----Entry 0xb54dec
>  utalloc-0423 [07] UtAllocate            : ----Entry 00000002
>  utalloc-0446 [07] UtAllocate            : ----Exit- 0x1b1a87e4
>  nsnames-0257 [06] NsGetExternalPathname : ----Exit- 0x1b1a87e4
> nssearch-0195 [05] NsSearchOneScope      : Searching \ (0xb54dec) For
> [_SB_] (Device)
> nssearch-0254 [05] NsSearchOneScope      : Name [_SB_] (Device) not found
> in search in scope ["\" ] 0xb54dec first child 0x1b13c9c0
> nssearch-0256 [05] NsSearchOneScope      : ----Exit- ****Exception****:
> AE_NOT_FOUND
>  nsalloc-0150 [05] NsCreateNode          : ----Entry
>  utalloc-0423 [06] UtAllocate            : ----Entry 00000014
>  utalloc-0446 [06] UtAllocate            : ----Exit- 0x1b1a87d4
>  nsalloc-0172 [05] NsCreateNode          : ----Exit- 0x1b1a87d4
>  nsalloc-0336 [05] NsInstallNode         : ----Entry
>  nsalloc-0382 [05] NsInstallNode         : _SB_ (Device) [Node 0x1b1a87d4
> Owner 0] added to "\"  (Device) [Node 0xb54dec]
>  nsalloc-0384 [05] NsInstallNode         : ----Exit-
> nssearch-0505 [04] NsSearchAndEnter      : ----Exit- AE_OK
> nsaccess-0770 [03] NsLookup              : ----Exit- AE_OK
> nsaccess-0390 [03] NsLookup              : ----Entry
> nsaccess-0414 [03] NsLookup              : Null scope prefix, using root
> node (0xb54dec)
> nsaccess-0496 [03] NsLookup              : Searching relative to prefix
> scope ["\" ] (0xb54dec)
> nsaccess-0607 [03] NsLookup              : Simple Pathname (1 segment,
> Flags=3D0)
>   nsdump-0175 [03] NsPrintPathname       : [_SI_]
> nssearch-0392 [04] NsSearchAndEnter      : ----Entry
> nssearch-0181 [05] NsSearchOneScope      : ----Entry
>  nsnames-0228 [06] NsGetExternalPathname : ----Entry 0xb54dec
>  utalloc-0423 [07] UtAllocate            : ----Entry 00000002
>  utalloc-0446 [07] UtAllocate            : ----Exit- 0x1b1a87b0
>  nsnames-0257 [06] NsGetExternalPathname : ----Exit- 0x1b1a87b0
> nssearch-0195 [05] NsSearchOneScope      : Searching \ (0xb54dec) For
> [_SI_] (Scope)
> nssearch-0254 [05] NsSearchOneScope      : Name [_SI_] (Scope) not found =
in
> search in scope ["\" ] 0xb54dec first child 0x1b13c9c0
> nssearch-0256 [05] NsSearchOneScope      : ----Exit- ****Exception****:
> AE_NOT_FOUND
>  nsalloc-0150 [05] NsCreateNode          : ----Entry
>  utalloc-0423 [06] UtAllocate            : ----Entry 00000014
>  utalloc-0446 [06] UtAllocate            : ----Exit- 0x1b1a87a0
>  nsalloc-0172 [05] NsCreateNode          : ----Exit- 0x1b1a87a0
>  nsalloc-0336 [05] NsInstallNode         : ----Entry
>  nsalloc-0382 [05] NsInstallNode         : _SI_ (Scope) [Node 0x1b1a87a0
> Owner 0] added to "\"  (Device) [Node 0xb54dec]
>  nsalloc-0384 [05] NsInstallNode         : ----Exit-
> nssearch-0505 [04] NsSearchAndEnter      : ----Exit- AE_OK
> nsaccess-0770 [03] NsLookup              : ----Exit- AE_OK
> nsaccess-0390 [03] NsLookup              : ----Entry
> nsaccess-0414 [03] NsLookup              : Null scope prefix, using root
> node (0xb54dec)
> nsaccess-0496 [03] NsLookup              : Searching relative to prefix
> scope ["\" ] (0xb54dec)
> nsaccess-0607 [03] NsLookup              : Simple Pathname (1 segment,
> Flags=3D0)
>   nsdump-0175 [03] NsPrintPathname       : [_TZ_]
> nssearch-0392 [04] NsSearchAndEnter      : ----Entry
> nssearch-0181 [05] NsSearchOneScope      : ----Entry
>  nsnames-0228 [06] NsGetExternalPathname : ----Entry 0xb54dec
>  utalloc-0423 [07] UtAllocate            : ----Entry 00000002
>  utalloc-0446 [07] UtAllocate            : ----Exit- 0x1b1a877c
>  nsnames-0257 [06] NsGetExternalPathname : ----Exit- 0x1b1a877c
> nssearch-0195 [05] NsSearchOneScope      : Searching \ (0xb54dec) For
> [_TZ_] (Thermal)
> nssearch-0254 [05] NsSearchOneScope      : Name [_TZ_] (Thermal) not found
> in search in scope ["\" ] 0xb54dec first child 0x1b13c9c0
> nssearch-0256 [05] NsSearchOneScope      : ----Exit- ****Exception****:
> AE_NOT_FOUND
>  nsalloc-0150 [05] NsCreateNode          : ----Entry
>  utalloc-0423 [06] UtAllocate            : ----Entry 00000014
>  utalloc-0446 [06] UtAllocate            : ----Exit- 0x1b1a876c
>  nsalloc-0172 [05] NsCreateNode          : ----Exit- 0x1b1a876c
>  nsalloc-0336 [05] NsInstallNode         : ----Entry
>  nsalloc-0382 [05] NsInstallNode         : _TZ_ (Thermal) [Node 0x1b1a876c
> Owner 0] added to "\"  (Device) [Node 0xb54dec]
>  nsalloc-0384 [05] NsInstallNode         : ----Exit-
> nssearch-0505 [04] NsSearchAndEnter      : ----Exit- AE_OK
> nsaccess-0770 [03] NsLookup              : ----Exit- AE_OK
> nsaccess-0390 [03] NsLookup              : ----Entry
> nsaccess-0414 [03] NsLookup              : Null scope prefix, using root
> node (0xb54dec)
> nsaccess-0496 [03] NsLookup              : Searching relative to prefix
> scope ["\" ] (0xb54dec)
> nsaccess-0607 [03] NsLookup              : Simple Pathname (1 segment,
> Flags=3D0)
>   nsdump-0175 [03] NsPrintPathname       : [_REV]
> nssearch-0392 [04] NsSearchAndEnter      : ----Entry
> nssearch-0181 [05] NsSearchOneScope      : ----Entry
>  nsnames-0228 [06] NsGetExternalPathname : ----Entry 0xb54dec
>  utalloc-0423 [07] UtAllocate            : ----Entry 00000002
>  utalloc-0446 [07] UtAllocate            : ----Exit- 0x1b1a8748
>  nsnames-0257 [06] NsGetExternalPathname : ----Exit- 0x1b1a8748
> nssearch-0195 [05] NsSearchOneScope      : Searching \ (0xb54dec) For
> [_REV] (Integer)
> nssearch-0254 [05] NsSearchOneScope      : Name [_REV] (Integer) not found
> in search in scope ["\" ] 0xb54dec first child 0x1b13c9c0
> nssearch-0256 [05] NsSearchOneScope      : ----Exit- ****Exception****:
> AE_NOT_FOUND
>  nsalloc-0150 [05] NsCreateNode          : ----Entry
>  utalloc-0423 [06] UtAllocate            : ----Entry 00000014
>  utalloc-0446 [06] UtAllocate            : ----Exit- 0x1b1a8738
>  nsalloc-0172 [05] NsCreateNode          : ----Exit- 0x1b1a8738
>  nsalloc-0336 [05] NsInstallNode         : ----Entry
>  nsalloc-0382 [05] NsInstallNode         : _REV (Integer) [Node 0x1b1a8738
> Owner 0] added to "\"  (Device) [Node 0xb54dec]
>  nsalloc-0384 [05] NsInstallNode         : ----Exit-
> nssearch-0505 [04] NsSearchAndEnter      : ----Exit- AE_OK
> nsaccess-0770 [03] NsLookup              : ----Exit- AE_OK
> utobject-0179 [03] UtCreateInternalObject: ----Entry Integer
> utobject-0506 [04] UtAllocateObjectDescDb: ----Entry
>  utalloc-0423 [05] UtAllocate            : ----Entry 00000028
>  utalloc-0446 [05] UtAllocate            : ----Exit- 0x1b1a86e8
> utobject-0523 [04] UtAllocateObjectDescDb: 0x1b1a86e8 Size 28
> utobject-0525 [04] UtAllocateObjectDescDb: ----Exit- 0x1b1a86e8
> utobject-0229 [03] UtCreateInternalObject: ----Exit- 0x1b1a86e8
> nsobject-0161 [03] NsAttachObject        : ----Entry
> nsobject-0241 [03] NsAttachObject        : Installing 0x1b1a86e8 into Node
> 0x1b1a8738 [_REV]
> utdelete-0755 [04] UtAddReference        : ----Entry 0x1b1a86e8
> utdelete-0767 [04] UtAddReference        : Obj 0x1b1a86e8 Current Refs=3D1
> [To Be Incremented]
> utdelete-0592 [05] UtUpdateObjectReferenc: ----Entry 0x1b1a86e8
> utdelete-0495 [05] UtUpdateRefCount      : Obj 0x1b1a86e8 Refs=3D2,
> [Incremented]
> utdelete-0717 [05] UtUpdateObjectReferenc: ----Exit- AE_OK
> utdelete-0772 [04] UtAddReference        : ----Exit-
> nsobject-0276 [03] NsAttachObject        : ----Exit- AE_OK
> utdelete-0793 [03] UtRemoveReference     : ----Entry 0x1b1a86e8
> utdelete-0817 [03] UtRemoveReference     : Obj 0x1b1a86e8 Current Refs=3D2
> [To Be Decremented]
> utdelete-0592 [04] UtUpdateObjectReferenc: ----Entry 0x1b1a86e8
> utdelete-0514 [04] UtUpdateRefCount      : Obj 0x1b1a86e8 Refs=3D1,
> [Decremented]
> utdelete-0717 [04] UtUpdateObjectReferenc: ----Exit- AE_OK
> utdelete-0825 [03] UtRemoveReference     : ----Exit-
> nsaccess-0390 [03] NsLookup              : ----Entry
> nsaccess-0414 [03] NsLookup              : Null scope prefix, using root
> node (0xb54dec)
> nsaccess-0496 [03] NsLookup              : Searching relative to prefix
> scope ["\" ] (0xb54dec)
> nsaccess-0607 [03] NsLookup              : Simple Pathname (1 segment,
> Flags=3D0)
>   nsdump-0175 [03] NsPrintPathname       : [_OS_]
> nssearch-0392 [04] NsSearchAndEnter      : ----Entry
> nssearch-0181 [05] NsSearchOneScope      : ----Entry
>  nsnames-0228 [06] NsGetExternalPathname : ----Entry 0xb54dec
>  utalloc-0423 [07] UtAllocate            : ----Entry 00000002
>  utalloc-0446 [07] UtAllocate            : ----Exit- 0x1b1a8cc0
>  nsnames-0257 [06] NsGetExternalPathname : ----Exit- 0x1b1a8cc0
> nssearch-0195 [05] NsSearchOneScope      : Searching \ (0xb54dec) For
> [_OS_] (String)
> nssearch-0254 [05] NsSearchOneScope      : Name [_OS_] (String) not found
> in search in scope ["\" ] 0xb54dec first child 0x1b13c9c0
> nssearch-0256 [05] NsSearchOneScope      : ----Exit- ****Exception****:
> AE_NOT_FOUND
>  nsalloc-0150 [05] NsCreateNode          : ----Entry
>  utalloc-0423 [06] UtAllocate            : ----Entry 00000014
>  utalloc-0446 [06] UtAllocate            : ----Exit- 0x1b1a8cb0
>  nsalloc-0172 [05] NsCreateNode          : ----Exit- 0x1b1a8cb0
>  nsalloc-0336 [05] NsInstallNode         : ----Entry
>  nsalloc-0382 [05] NsInstallNode         : _OS_ (String) [Node 0x1b1a8cb0
> Owner 0] added to "\"  (Device) [Node 0xb54dec]
>  nsalloc-0384 [05] NsInstallNode         : ----Exit-
> nssearch-0505 [04] NsSearchAndEnter      : ----Exit- AE_OK
> nsaccess-0770 [03] NsLookup              : ----Exit- AE_OK
> utobject-0179 [03] UtCreateInternalObject: ----Entry String
> utobject-0506 [04] UtAllocateObjectDescDb: ----Entry
>  utalloc-0423 [05] UtAllocate            : ----Entry 0
>
>
> On Tue, Jul 6, 2010 at 10:37 AM, Zhang Rui <rui.zhang(a)intel.com> wrote:
>
>> On Tue, 2010-07-06 at 10:29 +0800, Sean Shoufu Luo wrote:
>> > Previously, I have ported ACPICA to our system. These days, I wonna to
>> > write ACPI driver for battery with Netbsd's version as guide, but I
>> > found when I initialized battery driver, it would issue a command to
>> > query _STA for battery presence. But its return value is 0xf, that
>> > indicates PRESENCE bit is not set (0x00000010).  I'm puzzled. I'm
>> > using battery ....Why the battery not present?
>> > Anyone can give any hint?
>> >
>> please attach the acpidump output of this machine.
>>
>> thanks,
>> rui
>>
>>
>>
>

--===============6914058673998007394==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

T0ssIEkgZmluZCB0aGUgcm9vdCBjYXVzZSB0aGF0IHRoZSByZWFzb24gc3lzdGVtIGhhbmcsIHRo
YXQgaXMgd2hlbiBpdCB0cnkgY2FsbCBBQ1BJQ0EgQVBJIHRvIGVuYWJsZSBBQ1BJIGJ5IHdyaXRp
bmcgSFcgcG9ydCAocG9ydCAweDgyZiBhbmQgdmFsdWUgMHhlMSksIG9uY2UgdGhlIGNhbGwgb3V0
YiwgdGhlIHN5c3RlbSBiZWNvbWUgaGFuZyAuLi4uLi4uLi4uLi4uLi4uLi4uLi48ZGl2Pgo8YnI+
PC9kaXY+PGRpdj5JbiBteSB1bmRlcnN0YW5kLCBib3RoIHdoaWNoIHBvcnQgYW5kIHdoYXQgdmFs
dWUgdG8gd3JpdGUgaXMgZGVjaWRlZCBieSBBQ1BJIFRBQkxFLCBXaGljaCBpcyBwcm92aWRlZCBi
eSBCSU9TIGFuZCBjYW5ub3QgYmUgaW52YWxpZCwgd2h5IGl0IHdpbGwgY2F1c2Ugc3lzdGVtIGhh
bmc/PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48YnI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1
b3RlIj4KT24gVHVlLCBKdWwgNiwgMjAxMCBhdCAxOjQ3IFBNLCBTZWFuIFNob3VmdSBMdW8gPHNw
YW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86bHVvc2hvdWZ1QGdtYWlsLmNvbSI+bHVv
c2hvdWZ1QGdtYWlsLmNvbTwvYT4mZ3Q7PC9zcGFuPiB3cm90ZTo8YnI+PGJsb2NrcXVvdGUgY2xh
c3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4
ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleDsiPgpZZXMsIGkmIzM5O20gdHJ5aW5nIC4uLi4g
YnV0IG5vdywgaW4gbXkgbW9iaWxlIGNsaWVudCwgaXQgc2VlbXMsIHNvbWV0aGluZyBlbHNlIHdy
b25nIHdoZW4gZW5hYmxlIEFDUEkgc3ViIHN5c3RlbTxkaXY+SSBzZXQgQUNQSV9MVl9BTEwgZm9y
IGRlYnVnLCBhbmQgaXQgZ2l2ZSBtZSBzdWNoIG91dHB1dCwgYW5kIHRoZW4gc3lzdGVtIGhhbmcu
IC4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4gYW55IGlkZWE/PGJyPgoKPGRpdj48YnI+PC9kaXY+
PGRpdj48ZGl2PqB1dHhmYWNlLTAxNTIgWzAxXSBJbml0aWFsaXplU3Vic3lzdGVtIKAgOiAtLS0t
RW50cnk8L2Rpdj48ZGl2PnV0Z2xvYmFsLTA4NTQgWzAyXSBVdEluaXRHbG9iYWxzIKAgoCCgIKAg
OiAtLS0tRW50cnk8L2Rpdj48ZGl2PnV0Z2xvYmFsLTA5NjQgWzAyXSBVdEluaXRHbG9iYWxzIKAg
oCCgIKAgOiAtLS0tRXhpdC0gQUVfT0s8L2Rpdj48ZGl2PgqgdXRtdXRleC0wMTU3IFswMl0gVXRN
dXRleEluaXRpYWxpemUgoCCgIDogLS0tLUVudHJ5PC9kaXY+CjxkaXY+oHV0bXV0ZXgtMDI1MyBb
MDNdIFV0Q3JlYXRlTXV0ZXggoCCgIKAgoCA6IC0tLS1FbnRyeSAwMDAwMDAwMDwvZGl2PjxkaXY+
oHV0bXV0ZXgtMDI2OCBbMDNdIFV0Q3JlYXRlTXV0ZXggoCCgIKAgoCA6IC0tLS1FeGl0LSBBRV9P
SzwvZGl2PjxkaXY+oHV0bXV0ZXgtMDI1MyBbMDNdIFV0Q3JlYXRlTXV0ZXggoCCgIKAgoCA6IC0t
LS1FbnRyeSAwMDAwMDAwMTwvZGl2PjxkaXY+oHV0bXV0ZXgtMDI2OCBbMDNdIFV0Q3JlYXRlTXV0
ZXggoCCgIKAgoCA6IC0tLS1FeGl0LSBBRV9PSzwvZGl2PgoKPGRpdj6gdXRtdXRleC0wMjUzIFsw
M10gVXRDcmVhdGVNdXRleCCgIKAgoCCgIDogLS0tLUVudHJ5IDAwMDAwMDAyPC9kaXY+PGRpdj6g
dXRtdXRleC0wMjY4IFswM10gVXRDcmVhdGVNdXRleCCgIKAgoCCgIDogLS0tLUV4aXQtIEFFX09L
PC9kaXY+PGRpdj6gdXRtdXRleC0wMjUzIFswM10gVXRDcmVhdGVNdXRleCCgIKAgoCCgIDogLS0t
LUVudHJ5IDAwMDAwMDAzPC9kaXY+PGRpdj6gdXRtdXRleC0wMjY4IFswM10gVXRDcmVhdGVNdXRl
eCCgIKAgoCCgIDogLS0tLUV4aXQtIEFFX09LPC9kaXY+Cgo8ZGl2PqB1dG11dGV4LTAyNTMgWzAz
XSBVdENyZWF0ZU11dGV4IKAgoCCgIKAgOiAtLS0tRW50cnkgMDAwMDAwMDQ8L2Rpdj48ZGl2PqB1
dG11dGV4LTAyNjggWzAzXSBVdENyZWF0ZU11dGV4IKAgoCCgIKAgOiAtLS0tRXhpdC0gQUVfT0s8
L2Rpdj48ZGl2PqB1dG11dGV4LTAyNTMgWzAzXSBVdENyZWF0ZU11dGV4IKAgoCCgIKAgOiAtLS0t
RW50cnkgMDAwMDAwMDU8L2Rpdj48ZGl2PqB1dG11dGV4LTAyNjggWzAzXSBVdENyZWF0ZU11dGV4
IKAgoCCgIKAgOiAtLS0tRXhpdC0gQUVfT0s8L2Rpdj4KCjxkaXY+oHV0bXV0ZXgtMDI1MyBbMDNd
IFV0Q3JlYXRlTXV0ZXggoCCgIKAgoCA6IC0tLS1FbnRyeSAwMDAwMDAwNjwvZGl2PjxkaXY+oHV0
bXV0ZXgtMDI2OCBbMDNdIFV0Q3JlYXRlTXV0ZXggoCCgIKAgoCA6IC0tLS1FeGl0LSBBRV9PSzwv
ZGl2PjxkaXY+oHV0bXV0ZXgtMDI1MyBbMDNdIFV0Q3JlYXRlTXV0ZXggoCCgIKAgoCA6IC0tLS1F
bnRyeSAwMDAwMDAwNzwvZGl2PjxkaXY+oHV0bXV0ZXgtMDI2OCBbMDNdIFV0Q3JlYXRlTXV0ZXgg
oCCgIKAgoCA6IC0tLS1FeGl0LSBBRV9PSzwvZGl2PgoKPGRpdj6gdXRtdXRleC0wMTg4IFswMl0g
VXRNdXRleEluaXRpYWxpemUgoCCgIDogLS0tLUV4aXQtIEFFX09LPC9kaXY+PGRpdj5uc2FjY2Vz
cy0wMTU0IFswMl0gTnNSb290SW5pdGlhbGl6ZSCgIKAgoDogLS0tLUVudHJ5PC9kaXY+PGRpdj5u
c2FjY2Vzcy0wMTgyIFswMl0gTnNSb290SW5pdGlhbGl6ZSCgIKAgoDogRW50ZXJpbmcgcHJlZGVm
aW5lZCBlbnRyaWVzIGludG8gbmFtZXNwYWNlPC9kaXY+Cgo8ZGl2Pm5zYWNjZXNzLTAzOTAgWzAz
XSBOc0xvb2t1cCCgIKAgoCCgIKAgoCCgOiAtLS0tRW50cnk8L2Rpdj48ZGl2Pm5zYWNjZXNzLTA0
MTQgWzAzXSBOc0xvb2t1cCCgIKAgoCCgIKAgoCCgOiBOdWxsIHNjb3BlIHByZWZpeCwgdXNpbmcg
cm9vdCBub2RlICgweGI1NGRlYyk8L2Rpdj48ZGl2Pm5zYWNjZXNzLTA0OTYgWzAzXSBOc0xvb2t1
cCCgIKAgoCCgIKAgoCCgOiBTZWFyY2hpbmcgcmVsYXRpdmUgdG8gcHJlZml4IHNjb3BlIFsmcXVv
dDtcJnF1b3Q7IF0gKDB4YjU0ZGVjKTwvZGl2PgoKPGRpdj5uc2FjY2Vzcy0wNjA3IFswM10gTnNM
b29rdXAgoCCgIKAgoCCgIKAgoDogU2ltcGxlIFBhdGhuYW1lICgxIHNlZ21lbnQsIEZsYWdzPTAp
PC9kaXY+PGRpdj6goG5zZHVtcC0wMTc1IFswM10gTnNQcmludFBhdGhuYW1lIKAgoCCgIDogW19H
UEVdPC9kaXY+PGRpdj5uc3NlYXJjaC0wMzkyIFswNF0gTnNTZWFyY2hBbmRFbnRlciCgIKAgoDog
LS0tLUVudHJ5PC9kaXY+PGRpdj5uc3NlYXJjaC0wMTgxIFswNV0gTnNTZWFyY2hPbmVTY29wZSCg
IKAgoDogLS0tLUVudHJ5PC9kaXY+Cgo8ZGl2PqBuc25hbWVzLTAyMjggWzA2XSBOc0dldEV4dGVy
bmFsUGF0aG5hbWUgOiAtLS0tRW50cnkgMHhiNTRkZWM8L2Rpdj48ZGl2PqB1dGFsbG9jLTA0MjMg
WzA3XSBVdEFsbG9jYXRlIKAgoCCgIKAgoCCgOiAtLS0tRW50cnkgMDAwMDAwMDI8L2Rpdj48ZGl2
PqB1dGFsbG9jLTA0NDYgWzA3XSBVdEFsbG9jYXRlIKAgoCCgIKAgoCCgOiAtLS0tRXhpdC0gMHgx
YjE0M2U3YzwvZGl2PjxkaXY+CgqgbnNuYW1lcy0wMjU3IFswNl0gTnNHZXRFeHRlcm5hbFBhdGhu
YW1lIDogLS0tLUV4aXQtIDB4MWIxNDNlN2M8L2Rpdj48ZGl2Pm5zc2VhcmNoLTAxOTUgWzA1XSBO
c1NlYXJjaE9uZVNjb3BlIKAgoCCgOiBTZWFyY2hpbmcgXCAoMHhiNTRkZWMpIEZvciBbX0dQRV0g
KFNjb3BlKTwvZGl2PjxkaXY+bnNzZWFyY2gtMDI1NCBbMDVdIE5zU2VhcmNoT25lU2NvcGUgoCCg
IKA6IE5hbWUgW19HUEVdIChTY29wZSkgbm90IGZvdW5kIGluIHNlYXJjaCBpbiBzY29wZSBbJnF1
b3Q7XCZxdW90OyBdIDB4YjU0ZGVjIGZpcnN0IGNoaWxkIDB4MDwvZGl2PgoKPGRpdj5uc3NlYXJj
aC0wMjU2IFswNV0gTnNTZWFyY2hPbmVTY29wZSCgIKAgoDogLS0tLUV4aXQtICoqKipFeGNlcHRp
b24qKioqOiBBRV9OT1RfRk9VTkQ8L2Rpdj48ZGl2PqBuc2FsbG9jLTAxNTAgWzA1XSBOc0NyZWF0
ZU5vZGUgoCCgIKAgoCCgOiAtLS0tRW50cnk8L2Rpdj48ZGl2PqB1dGFsbG9jLTA0MjMgWzA2XSBV
dEFsbG9jYXRlIKAgoCCgIKAgoCCgOiAtLS0tRW50cnkgMDAwMDAwMTQ8L2Rpdj4KCjxkaXY+oHV0
YWxsb2MtMDQ0NiBbMDZdIFV0QWxsb2NhdGUgoCCgIKAgoCCgIKA6IC0tLS1FeGl0LSAweDFiMTNj
OWMwPC9kaXY+PGRpdj6gbnNhbGxvYy0wMTcyIFswNV0gTnNDcmVhdGVOb2RlIKAgoCCgIKAgoDog
LS0tLUV4aXQtIDB4MWIxM2M5YzA8L2Rpdj48ZGl2PqBuc2FsbG9jLTAzMzYgWzA1XSBOc0luc3Rh
bGxOb2RlIKAgoCCgIKAgOiAtLS0tRW50cnk8L2Rpdj48ZGl2PqBuc2FsbG9jLTAzODIgWzA1XSBO
c0luc3RhbGxOb2RlIKAgoCCgIKAgOiBfR1BFIChTY29wZSkgW05vZGUgMHgxYjEzYzljMCBPd25l
ciAwXSBhZGRlZCB0byAmcXVvdDtcJnF1b3Q7IKAoRGV2aWNlKSBbTm9kZSAweGI1NGRlY108L2Rp
dj4KCjxkaXY+oG5zYWxsb2MtMDM4NCBbMDVdIE5zSW5zdGFsbE5vZGUgoCCgIKAgoCA6IC0tLS1F
eGl0LTwvZGl2PjxkaXY+bnNzZWFyY2gtMDUwNSBbMDRdIE5zU2VhcmNoQW5kRW50ZXIgoCCgIKA6
IC0tLS1FeGl0LSBBRV9PSzwvZGl2PjxkaXY+bnNhY2Nlc3MtMDc3MCBbMDNdIE5zTG9va3VwIKAg
oCCgIKAgoCCgIKA6IC0tLS1FeGl0LSBBRV9PSzwvZGl2PjxkaXY+bnNhY2Nlc3MtMDM5MCBbMDNd
IE5zTG9va3VwIKAgoCCgIKAgoCCgIKA6IC0tLS1FbnRyeTwvZGl2PgoKPGRpdj5uc2FjY2Vzcy0w
NDE0IFswM10gTnNMb29rdXAgoCCgIKAgoCCgIKAgoDogTnVsbCBzY29wZSBwcmVmaXgsIHVzaW5n
IHJvb3Qgbm9kZSAoMHhiNTRkZWMpPC9kaXY+PGRpdj5uc2FjY2Vzcy0wNDk2IFswM10gTnNMb29r
dXAgoCCgIKAgoCCgIKAgoDogU2VhcmNoaW5nIHJlbGF0aXZlIHRvIHByZWZpeCBzY29wZSBbJnF1
b3Q7XCZxdW90OyBdICgweGI1NGRlYyk8L2Rpdj48ZGl2Pgpuc2FjY2Vzcy0wNjA3IFswM10gTnNM
b29rdXAgoCCgIKAgoCCgIKAgoDogU2ltcGxlIFBhdGhuYW1lICgxIHNlZ21lbnQsIEZsYWdzPTAp
PC9kaXY+CjxkaXY+oKBuc2R1bXAtMDE3NSBbMDNdIE5zUHJpbnRQYXRobmFtZSCgIKAgoCA6IFtf
UFJfXTwvZGl2PjxkaXY+bnNzZWFyY2gtMDM5MiBbMDRdIE5zU2VhcmNoQW5kRW50ZXIgoCCgIKA6
IC0tLS1FbnRyeTwvZGl2PjxkaXY+bnNzZWFyY2gtMDE4MSBbMDVdIE5zU2VhcmNoT25lU2NvcGUg
oCCgIKA6IC0tLS1FbnRyeTwvZGl2PjxkaXY+oG5zbmFtZXMtMDIyOCBbMDZdIE5zR2V0RXh0ZXJu
YWxQYXRobmFtZSA6IC0tLS1FbnRyeSAweGI1NGRlYzwvZGl2PgoKPGRpdj6gdXRhbGxvYy0wNDIz
IFswN10gVXRBbGxvY2F0ZSCgIKAgoCCgIKAgoDogLS0tLUVudHJ5IDAwMDAwMDAyPC9kaXY+PGRp
dj6gdXRhbGxvYy0wNDQ2IFswN10gVXRBbGxvY2F0ZSCgIKAgoCCgIKAgoDogLS0tLUV4aXQtIDB4
MWIxNDNlN2M8L2Rpdj48ZGl2PqBuc25hbWVzLTAyNTcgWzA2XSBOc0dldEV4dGVybmFsUGF0aG5h
bWUgOiAtLS0tRXhpdC0gMHgxYjE0M2U3YzwvZGl2Pgo8ZGl2Pgpuc3NlYXJjaC0wMTk1IFswNV0g
TnNTZWFyY2hPbmVTY29wZSCgIKAgoDogU2VhcmNoaW5nIFwgKDB4YjU0ZGVjKSBGb3IgW19QUl9d
IChTY29wZSk8L2Rpdj48ZGl2Pm5zc2VhcmNoLTAyNTQgWzA1XSBOc1NlYXJjaE9uZVNjb3BlIKAg
oCCgOiBOYW1lIFtfUFJfXSAoU2NvcGUpIG5vdCBmb3VuZCBpbiBzZWFyY2ggaW4gc2NvcGUgWyZx
dW90O1wmcXVvdDsgXSAweGI1NGRlYyBmaXJzdCBjaGlsZCAweDFiMTNjOWMwPC9kaXY+Cgo8ZGl2
Pm5zc2VhcmNoLTAyNTYgWzA1XSBOc1NlYXJjaE9uZVNjb3BlIKAgoCCgOiAtLS0tRXhpdC0gKioq
KkV4Y2VwdGlvbioqKio6IEFFX05PVF9GT1VORDwvZGl2PjxkaXY+oG5zYWxsb2MtMDE1MCBbMDVd
IE5zQ3JlYXRlTm9kZSCgIKAgoCCgIKA6IC0tLS1FbnRyeTwvZGl2PjxkaXY+oHV0YWxsb2MtMDQy
MyBbMDZdIFV0QWxsb2NhdGUgoCCgIKAgoCCgIKA6IC0tLS1FbnRyeSAwMDAwMDAxNDwvZGl2PgoK
PGRpdj6gdXRhbGxvYy0wNDQ2IFswNl0gVXRBbGxvY2F0ZSCgIKAgoCCgIKAgoDogLS0tLUV4aXQt
IDB4MWIxYTg4MDg8L2Rpdj48ZGl2PqBuc2FsbG9jLTAxNzIgWzA1XSBOc0NyZWF0ZU5vZGUgoCCg
IKAgoCCgOiAtLS0tRXhpdC0gMHgxYjFhODgwODwvZGl2PjxkaXY+oG5zYWxsb2MtMDMzNiBbMDVd
IE5zSW5zdGFsbE5vZGUgoCCgIKAgoCA6IC0tLS1FbnRyeTwvZGl2PjxkaXY+oG5zYWxsb2MtMDM4
MiBbMDVdIE5zSW5zdGFsbE5vZGUgoCCgIKAgoCA6IF9QUl8gKFNjb3BlKSBbTm9kZSAweDFiMWE4
ODA4IE93bmVyIDBdIGFkZGVkIHRvICZxdW90O1wmcXVvdDsgoChEZXZpY2UpIFtOb2RlIDB4YjU0
ZGVjXTwvZGl2PgoKPGRpdj6gbnNhbGxvYy0wMzg0IFswNV0gTnNJbnN0YWxsTm9kZSCgIKAgoCCg
IDogLS0tLUV4aXQtPC9kaXY+PGRpdj5uc3NlYXJjaC0wNTA1IFswNF0gTnNTZWFyY2hBbmRFbnRl
ciCgIKAgoDogLS0tLUV4aXQtIEFFX09LPC9kaXY+PGRpdj5uc2FjY2Vzcy0wNzcwIFswM10gTnNM
b29rdXAgoCCgIKAgoCCgIKAgoDogLS0tLUV4aXQtIEFFX09LPC9kaXY+PGRpdj5uc2FjY2Vzcy0w
MzkwIFswM10gTnNMb29rdXAgoCCgIKAgoCCgIKAgoDogLS0tLUVudHJ5PC9kaXY+Cgo8ZGl2Pm5z
YWNjZXNzLTA0MTQgWzAzXSBOc0xvb2t1cCCgIKAgoCCgIKAgoCCgOiBOdWxsIHNjb3BlIHByZWZp
eCwgdXNpbmcgcm9vdCBub2RlICgweGI1NGRlYyk8L2Rpdj48ZGl2Pm5zYWNjZXNzLTA0OTYgWzAz
XSBOc0xvb2t1cCCgIKAgoCCgIKAgoCCgOiBTZWFyY2hpbmcgcmVsYXRpdmUgdG8gcHJlZml4IHNj
b3BlIFsmcXVvdDtcJnF1b3Q7IF0gKDB4YjU0ZGVjKTwvZGl2PjxkaXY+Cm5zYWNjZXNzLTA2MDcg
WzAzXSBOc0xvb2t1cCCgIKAgoCCgIKAgoCCgOiBTaW1wbGUgUGF0aG5hbWUgKDEgc2VnbWVudCwg
RmxhZ3M9MCk8L2Rpdj4KPGRpdj6goG5zZHVtcC0wMTc1IFswM10gTnNQcmludFBhdGhuYW1lIKAg
oCCgIDogW19TQl9dPC9kaXY+PGRpdj5uc3NlYXJjaC0wMzkyIFswNF0gTnNTZWFyY2hBbmRFbnRl
ciCgIKAgoDogLS0tLUVudHJ5PC9kaXY+PGRpdj5uc3NlYXJjaC0wMTgxIFswNV0gTnNTZWFyY2hP
bmVTY29wZSCgIKAgoDogLS0tLUVudHJ5PC9kaXY+PGRpdj6gbnNuYW1lcy0wMjI4IFswNl0gTnNH
ZXRFeHRlcm5hbFBhdGhuYW1lIDogLS0tLUVudHJ5IDB4YjU0ZGVjPC9kaXY+Cgo8ZGl2PqB1dGFs
bG9jLTA0MjMgWzA3XSBVdEFsbG9jYXRlIKAgoCCgIKAgoCCgOiAtLS0tRW50cnkgMDAwMDAwMDI8
L2Rpdj48ZGl2PqB1dGFsbG9jLTA0NDYgWzA3XSBVdEFsbG9jYXRlIKAgoCCgIKAgoCCgOiAtLS0t
RXhpdC0gMHgxYjFhODdlNDwvZGl2PjxkaXY+oG5zbmFtZXMtMDI1NyBbMDZdIE5zR2V0RXh0ZXJu
YWxQYXRobmFtZSA6IC0tLS1FeGl0LSAweDFiMWE4N2U0PC9kaXY+CjxkaXY+Cm5zc2VhcmNoLTAx
OTUgWzA1XSBOc1NlYXJjaE9uZVNjb3BlIKAgoCCgOiBTZWFyY2hpbmcgXCAoMHhiNTRkZWMpIEZv
ciBbX1NCX10gKERldmljZSk8L2Rpdj48ZGl2Pm5zc2VhcmNoLTAyNTQgWzA1XSBOc1NlYXJjaE9u
ZVNjb3BlIKAgoCCgOiBOYW1lIFtfU0JfXSAoRGV2aWNlKSBub3QgZm91bmQgaW4gc2VhcmNoIGlu
IHNjb3BlIFsmcXVvdDtcJnF1b3Q7IF0gMHhiNTRkZWMgZmlyc3QgY2hpbGQgMHgxYjEzYzljMDwv
ZGl2PgoKPGRpdj5uc3NlYXJjaC0wMjU2IFswNV0gTnNTZWFyY2hPbmVTY29wZSCgIKAgoDogLS0t
LUV4aXQtICoqKipFeGNlcHRpb24qKioqOiBBRV9OT1RfRk9VTkQ8L2Rpdj48ZGl2PqBuc2FsbG9j
LTAxNTAgWzA1XSBOc0NyZWF0ZU5vZGUgoCCgIKAgoCCgOiAtLS0tRW50cnk8L2Rpdj48ZGl2PqB1
dGFsbG9jLTA0MjMgWzA2XSBVdEFsbG9jYXRlIKAgoCCgIKAgoCCgOiAtLS0tRW50cnkgMDAwMDAw
MTQ8L2Rpdj4KCjxkaXY+oHV0YWxsb2MtMDQ0NiBbMDZdIFV0QWxsb2NhdGUgoCCgIKAgoCCgIKA6
IC0tLS1FeGl0LSAweDFiMWE4N2Q0PC9kaXY+PGRpdj6gbnNhbGxvYy0wMTcyIFswNV0gTnNDcmVh
dGVOb2RlIKAgoCCgIKAgoDogLS0tLUV4aXQtIDB4MWIxYTg3ZDQ8L2Rpdj48ZGl2PqBuc2FsbG9j
LTAzMzYgWzA1XSBOc0luc3RhbGxOb2RlIKAgoCCgIKAgOiAtLS0tRW50cnk8L2Rpdj48ZGl2PqBu
c2FsbG9jLTAzODIgWzA1XSBOc0luc3RhbGxOb2RlIKAgoCCgIKAgOiBfU0JfIChEZXZpY2UpIFtO
b2RlIDB4MWIxYTg3ZDQgT3duZXIgMF0gYWRkZWQgdG8gJnF1b3Q7XCZxdW90OyCgKERldmljZSkg
W05vZGUgMHhiNTRkZWNdPC9kaXY+Cgo8ZGl2PqBuc2FsbG9jLTAzODQgWzA1XSBOc0luc3RhbGxO
b2RlIKAgoCCgIKAgOiAtLS0tRXhpdC08L2Rpdj48ZGl2Pm5zc2VhcmNoLTA1MDUgWzA0XSBOc1Nl
YXJjaEFuZEVudGVyIKAgoCCgOiAtLS0tRXhpdC0gQUVfT0s8L2Rpdj48ZGl2Pm5zYWNjZXNzLTA3
NzAgWzAzXSBOc0xvb2t1cCCgIKAgoCCgIKAgoCCgOiAtLS0tRXhpdC0gQUVfT0s8L2Rpdj48ZGl2
Pm5zYWNjZXNzLTAzOTAgWzAzXSBOc0xvb2t1cCCgIKAgoCCgIKAgoCCgOiAtLS0tRW50cnk8L2Rp
dj4KCjxkaXY+bnNhY2Nlc3MtMDQxNCBbMDNdIE5zTG9va3VwIKAgoCCgIKAgoCCgIKA6IE51bGwg
c2NvcGUgcHJlZml4LCB1c2luZyByb290IG5vZGUgKDB4YjU0ZGVjKTwvZGl2PjxkaXY+bnNhY2Nl
c3MtMDQ5NiBbMDNdIE5zTG9va3VwIKAgoCCgIKAgoCCgIKA6IFNlYXJjaGluZyByZWxhdGl2ZSB0
byBwcmVmaXggc2NvcGUgWyZxdW90O1wmcXVvdDsgXSAoMHhiNTRkZWMpPC9kaXY+PGRpdj4KbnNh
Y2Nlc3MtMDYwNyBbMDNdIE5zTG9va3VwIKAgoCCgIKAgoCCgIKA6IFNpbXBsZSBQYXRobmFtZSAo
MSBzZWdtZW50LCBGbGFncz0wKTwvZGl2Pgo8ZGl2PqCgbnNkdW1wLTAxNzUgWzAzXSBOc1ByaW50
UGF0aG5hbWUgoCCgIKAgOiBbX1NJX108L2Rpdj48ZGl2Pm5zc2VhcmNoLTAzOTIgWzA0XSBOc1Nl
YXJjaEFuZEVudGVyIKAgoCCgOiAtLS0tRW50cnk8L2Rpdj48ZGl2Pm5zc2VhcmNoLTAxODEgWzA1
XSBOc1NlYXJjaE9uZVNjb3BlIKAgoCCgOiAtLS0tRW50cnk8L2Rpdj48ZGl2PqBuc25hbWVzLTAy
MjggWzA2XSBOc0dldEV4dGVybmFsUGF0aG5hbWUgOiAtLS0tRW50cnkgMHhiNTRkZWM8L2Rpdj4K
CjxkaXY+oHV0YWxsb2MtMDQyMyBbMDddIFV0QWxsb2NhdGUgoCCgIKAgoCCgIKA6IC0tLS1FbnRy
eSAwMDAwMDAwMjwvZGl2PjxkaXY+oHV0YWxsb2MtMDQ0NiBbMDddIFV0QWxsb2NhdGUgoCCgIKAg
oCCgIKA6IC0tLS1FeGl0LSAweDFiMWE4N2IwPC9kaXY+PGRpdj6gbnNuYW1lcy0wMjU3IFswNl0g
TnNHZXRFeHRlcm5hbFBhdGhuYW1lIDogLS0tLUV4aXQtIDB4MWIxYTg3YjA8L2Rpdj4KPGRpdj4K
bnNzZWFyY2gtMDE5NSBbMDVdIE5zU2VhcmNoT25lU2NvcGUgoCCgIKA6IFNlYXJjaGluZyBcICgw
eGI1NGRlYykgRm9yIFtfU0lfXSAoU2NvcGUpPC9kaXY+PGRpdj5uc3NlYXJjaC0wMjU0IFswNV0g
TnNTZWFyY2hPbmVTY29wZSCgIKAgoDogTmFtZSBbX1NJX10gKFNjb3BlKSBub3QgZm91bmQgaW4g
c2VhcmNoIGluIHNjb3BlIFsmcXVvdDtcJnF1b3Q7IF0gMHhiNTRkZWMgZmlyc3QgY2hpbGQgMHgx
YjEzYzljMDwvZGl2PgoKPGRpdj5uc3NlYXJjaC0wMjU2IFswNV0gTnNTZWFyY2hPbmVTY29wZSCg
IKAgoDogLS0tLUV4aXQtICoqKipFeGNlcHRpb24qKioqOiBBRV9OT1RfRk9VTkQ8L2Rpdj48ZGl2
PqBuc2FsbG9jLTAxNTAgWzA1XSBOc0NyZWF0ZU5vZGUgoCCgIKAgoCCgOiAtLS0tRW50cnk8L2Rp
dj48ZGl2PqB1dGFsbG9jLTA0MjMgWzA2XSBVdEFsbG9jYXRlIKAgoCCgIKAgoCCgOiAtLS0tRW50
cnkgMDAwMDAwMTQ8L2Rpdj4KCjxkaXY+oHV0YWxsb2MtMDQ0NiBbMDZdIFV0QWxsb2NhdGUgoCCg
IKAgoCCgIKA6IC0tLS1FeGl0LSAweDFiMWE4N2EwPC9kaXY+PGRpdj6gbnNhbGxvYy0wMTcyIFsw
NV0gTnNDcmVhdGVOb2RlIKAgoCCgIKAgoDogLS0tLUV4aXQtIDB4MWIxYTg3YTA8L2Rpdj48ZGl2
PqBuc2FsbG9jLTAzMzYgWzA1XSBOc0luc3RhbGxOb2RlIKAgoCCgIKAgOiAtLS0tRW50cnk8L2Rp
dj48ZGl2PqBuc2FsbG9jLTAzODIgWzA1XSBOc0luc3RhbGxOb2RlIKAgoCCgIKAgOiBfU0lfIChT
Y29wZSkgW05vZGUgMHgxYjFhODdhMCBPd25lciAwXSBhZGRlZCB0byAmcXVvdDtcJnF1b3Q7IKAo
RGV2aWNlKSBbTm9kZSAweGI1NGRlY108L2Rpdj4KCjxkaXY+oG5zYWxsb2MtMDM4NCBbMDVdIE5z
SW5zdGFsbE5vZGUgoCCgIKAgoCA6IC0tLS1FeGl0LTwvZGl2PjxkaXY+bnNzZWFyY2gtMDUwNSBb
MDRdIE5zU2VhcmNoQW5kRW50ZXIgoCCgIKA6IC0tLS1FeGl0LSBBRV9PSzwvZGl2PjxkaXY+bnNh
Y2Nlc3MtMDc3MCBbMDNdIE5zTG9va3VwIKAgoCCgIKAgoCCgIKA6IC0tLS1FeGl0LSBBRV9PSzwv
ZGl2PjxkaXY+bnNhY2Nlc3MtMDM5MCBbMDNdIE5zTG9va3VwIKAgoCCgIKAgoCCgIKA6IC0tLS1F
bnRyeTwvZGl2PgoKPGRpdj5uc2FjY2Vzcy0wNDE0IFswM10gTnNMb29rdXAgoCCgIKAgoCCgIKAg
oDogTnVsbCBzY29wZSBwcmVmaXgsIHVzaW5nIHJvb3Qgbm9kZSAoMHhiNTRkZWMpPC9kaXY+PGRp
dj5uc2FjY2Vzcy0wNDk2IFswM10gTnNMb29rdXAgoCCgIKAgoCCgIKAgoDogU2VhcmNoaW5nIHJl
bGF0aXZlIHRvIHByZWZpeCBzY29wZSBbJnF1b3Q7XCZxdW90OyBdICgweGI1NGRlYyk8L2Rpdj48
ZGl2Pgpuc2FjY2Vzcy0wNjA3IFswM10gTnNMb29rdXAgoCCgIKAgoCCgIKAgoDogU2ltcGxlIFBh
dGhuYW1lICgxIHNlZ21lbnQsIEZsYWdzPTApPC9kaXY+CjxkaXY+oKBuc2R1bXAtMDE3NSBbMDNd
IE5zUHJpbnRQYXRobmFtZSCgIKAgoCA6IFtfVFpfXTwvZGl2PjxkaXY+bnNzZWFyY2gtMDM5MiBb
MDRdIE5zU2VhcmNoQW5kRW50ZXIgoCCgIKA6IC0tLS1FbnRyeTwvZGl2PjxkaXY+bnNzZWFyY2gt
MDE4MSBbMDVdIE5zU2VhcmNoT25lU2NvcGUgoCCgIKA6IC0tLS1FbnRyeTwvZGl2PjxkaXY+oG5z
bmFtZXMtMDIyOCBbMDZdIE5zR2V0RXh0ZXJuYWxQYXRobmFtZSA6IC0tLS1FbnRyeSAweGI1NGRl
YzwvZGl2PgoKPGRpdj6gdXRhbGxvYy0wNDIzIFswN10gVXRBbGxvY2F0ZSCgIKAgoCCgIKAgoDog
LS0tLUVudHJ5IDAwMDAwMDAyPC9kaXY+PGRpdj6gdXRhbGxvYy0wNDQ2IFswN10gVXRBbGxvY2F0
ZSCgIKAgoCCgIKAgoDogLS0tLUV4aXQtIDB4MWIxYTg3N2M8L2Rpdj48ZGl2PqBuc25hbWVzLTAy
NTcgWzA2XSBOc0dldEV4dGVybmFsUGF0aG5hbWUgOiAtLS0tRXhpdC0gMHgxYjFhODc3YzwvZGl2
Pgo8ZGl2Pgpuc3NlYXJjaC0wMTk1IFswNV0gTnNTZWFyY2hPbmVTY29wZSCgIKAgoDogU2VhcmNo
aW5nIFwgKDB4YjU0ZGVjKSBGb3IgW19UWl9dIChUaGVybWFsKTwvZGl2PjxkaXY+bnNzZWFyY2gt
MDI1NCBbMDVdIE5zU2VhcmNoT25lU2NvcGUgoCCgIKA6IE5hbWUgW19UWl9dIChUaGVybWFsKSBu
b3QgZm91bmQgaW4gc2VhcmNoIGluIHNjb3BlIFsmcXVvdDtcJnF1b3Q7IF0gMHhiNTRkZWMgZmly
c3QgY2hpbGQgMHgxYjEzYzljMDwvZGl2PgoKPGRpdj5uc3NlYXJjaC0wMjU2IFswNV0gTnNTZWFy
Y2hPbmVTY29wZSCgIKAgoDogLS0tLUV4aXQtICoqKipFeGNlcHRpb24qKioqOiBBRV9OT1RfRk9V
TkQ8L2Rpdj48ZGl2PqBuc2FsbG9jLTAxNTAgWzA1XSBOc0NyZWF0ZU5vZGUgoCCgIKAgoCCgOiAt
LS0tRW50cnk8L2Rpdj48ZGl2PqB1dGFsbG9jLTA0MjMgWzA2XSBVdEFsbG9jYXRlIKAgoCCgIKAg
oCCgOiAtLS0tRW50cnkgMDAwMDAwMTQ8L2Rpdj4KCjxkaXY+oHV0YWxsb2MtMDQ0NiBbMDZdIFV0
QWxsb2NhdGUgoCCgIKAgoCCgIKA6IC0tLS1FeGl0LSAweDFiMWE4NzZjPC9kaXY+PGRpdj6gbnNh
bGxvYy0wMTcyIFswNV0gTnNDcmVhdGVOb2RlIKAgoCCgIKAgoDogLS0tLUV4aXQtIDB4MWIxYTg3
NmM8L2Rpdj48ZGl2PqBuc2FsbG9jLTAzMzYgWzA1XSBOc0luc3RhbGxOb2RlIKAgoCCgIKAgOiAt
LS0tRW50cnk8L2Rpdj48ZGl2PqBuc2FsbG9jLTAzODIgWzA1XSBOc0luc3RhbGxOb2RlIKAgoCCg
IKAgOiBfVFpfIChUaGVybWFsKSBbTm9kZSAweDFiMWE4NzZjIE93bmVyIDBdIGFkZGVkIHRvICZx
dW90O1wmcXVvdDsgoChEZXZpY2UpIFtOb2RlIDB4YjU0ZGVjXTwvZGl2PgoKPGRpdj6gbnNhbGxv
Yy0wMzg0IFswNV0gTnNJbnN0YWxsTm9kZSCgIKAgoCCgIDogLS0tLUV4aXQtPC9kaXY+PGRpdj5u
c3NlYXJjaC0wNTA1IFswNF0gTnNTZWFyY2hBbmRFbnRlciCgIKAgoDogLS0tLUV4aXQtIEFFX09L
PC9kaXY+PGRpdj5uc2FjY2Vzcy0wNzcwIFswM10gTnNMb29rdXAgoCCgIKAgoCCgIKAgoDogLS0t
LUV4aXQtIEFFX09LPC9kaXY+PGRpdj5uc2FjY2Vzcy0wMzkwIFswM10gTnNMb29rdXAgoCCgIKAg
oCCgIKAgoDogLS0tLUVudHJ5PC9kaXY+Cgo8ZGl2Pm5zYWNjZXNzLTA0MTQgWzAzXSBOc0xvb2t1
cCCgIKAgoCCgIKAgoCCgOiBOdWxsIHNjb3BlIHByZWZpeCwgdXNpbmcgcm9vdCBub2RlICgweGI1
NGRlYyk8L2Rpdj48ZGl2Pm5zYWNjZXNzLTA0OTYgWzAzXSBOc0xvb2t1cCCgIKAgoCCgIKAgoCCg
OiBTZWFyY2hpbmcgcmVsYXRpdmUgdG8gcHJlZml4IHNjb3BlIFsmcXVvdDtcJnF1b3Q7IF0gKDB4
YjU0ZGVjKTwvZGl2PjxkaXY+Cm5zYWNjZXNzLTA2MDcgWzAzXSBOc0xvb2t1cCCgIKAgoCCgIKAg
oCCgOiBTaW1wbGUgUGF0aG5hbWUgKDEgc2VnbWVudCwgRmxhZ3M9MCk8L2Rpdj4KPGRpdj6goG5z
ZHVtcC0wMTc1IFswM10gTnNQcmludFBhdGhuYW1lIKAgoCCgIDogW19SRVZdPC9kaXY+PGRpdj5u
c3NlYXJjaC0wMzkyIFswNF0gTnNTZWFyY2hBbmRFbnRlciCgIKAgoDogLS0tLUVudHJ5PC9kaXY+
PGRpdj5uc3NlYXJjaC0wMTgxIFswNV0gTnNTZWFyY2hPbmVTY29wZSCgIKAgoDogLS0tLUVudHJ5
PC9kaXY+PGRpdj6gbnNuYW1lcy0wMjI4IFswNl0gTnNHZXRFeHRlcm5hbFBhdGhuYW1lIDogLS0t
LUVudHJ5IDB4YjU0ZGVjPC9kaXY+Cgo8ZGl2PqB1dGFsbG9jLTA0MjMgWzA3XSBVdEFsbG9jYXRl
IKAgoCCgIKAgoCCgOiAtLS0tRW50cnkgMDAwMDAwMDI8L2Rpdj48ZGl2PqB1dGFsbG9jLTA0NDYg
WzA3XSBVdEFsbG9jYXRlIKAgoCCgIKAgoCCgOiAtLS0tRXhpdC0gMHgxYjFhODc0ODwvZGl2Pjxk
aXY+oG5zbmFtZXMtMDI1NyBbMDZdIE5zR2V0RXh0ZXJuYWxQYXRobmFtZSA6IC0tLS1FeGl0LSAw
eDFiMWE4NzQ4PC9kaXY+CjxkaXY+Cm5zc2VhcmNoLTAxOTUgWzA1XSBOc1NlYXJjaE9uZVNjb3Bl
IKAgoCCgOiBTZWFyY2hpbmcgXCAoMHhiNTRkZWMpIEZvciBbX1JFVl0gKEludGVnZXIpPC9kaXY+
PGRpdj5uc3NlYXJjaC0wMjU0IFswNV0gTnNTZWFyY2hPbmVTY29wZSCgIKAgoDogTmFtZSBbX1JF
Vl0gKEludGVnZXIpIG5vdCBmb3VuZCBpbiBzZWFyY2ggaW4gc2NvcGUgWyZxdW90O1wmcXVvdDsg
XSAweGI1NGRlYyBmaXJzdCBjaGlsZCAweDFiMTNjOWMwPC9kaXY+Cgo8ZGl2Pm5zc2VhcmNoLTAy
NTYgWzA1XSBOc1NlYXJjaE9uZVNjb3BlIKAgoCCgOiAtLS0tRXhpdC0gKioqKkV4Y2VwdGlvbioq
Kio6IEFFX05PVF9GT1VORDwvZGl2PjxkaXY+oG5zYWxsb2MtMDE1MCBbMDVdIE5zQ3JlYXRlTm9k
ZSCgIKAgoCCgIKA6IC0tLS1FbnRyeTwvZGl2PjxkaXY+oHV0YWxsb2MtMDQyMyBbMDZdIFV0QWxs
b2NhdGUgoCCgIKAgoCCgIKA6IC0tLS1FbnRyeSAwMDAwMDAxNDwvZGl2PgoKPGRpdj6gdXRhbGxv
Yy0wNDQ2IFswNl0gVXRBbGxvY2F0ZSCgIKAgoCCgIKAgoDogLS0tLUV4aXQtIDB4MWIxYTg3Mzg8
L2Rpdj48ZGl2PqBuc2FsbG9jLTAxNzIgWzA1XSBOc0NyZWF0ZU5vZGUgoCCgIKAgoCCgOiAtLS0t
RXhpdC0gMHgxYjFhODczODwvZGl2PjxkaXY+oG5zYWxsb2MtMDMzNiBbMDVdIE5zSW5zdGFsbE5v
ZGUgoCCgIKAgoCA6IC0tLS1FbnRyeTwvZGl2PjxkaXY+oG5zYWxsb2MtMDM4MiBbMDVdIE5zSW5z
dGFsbE5vZGUgoCCgIKAgoCA6IF9SRVYgKEludGVnZXIpIFtOb2RlIDB4MWIxYTg3MzggT3duZXIg
MF0gYWRkZWQgdG8gJnF1b3Q7XCZxdW90OyCgKERldmljZSkgW05vZGUgMHhiNTRkZWNdPC9kaXY+
Cgo8ZGl2PqBuc2FsbG9jLTAzODQgWzA1XSBOc0luc3RhbGxOb2RlIKAgoCCgIKAgOiAtLS0tRXhp
dC08L2Rpdj48ZGl2Pm5zc2VhcmNoLTA1MDUgWzA0XSBOc1NlYXJjaEFuZEVudGVyIKAgoCCgOiAt
LS0tRXhpdC0gQUVfT0s8L2Rpdj48ZGl2Pm5zYWNjZXNzLTA3NzAgWzAzXSBOc0xvb2t1cCCgIKAg
oCCgIKAgoCCgOiAtLS0tRXhpdC0gQUVfT0s8L2Rpdj48ZGl2PnV0b2JqZWN0LTAxNzkgWzAzXSBV
dENyZWF0ZUludGVybmFsT2JqZWN0OiAtLS0tRW50cnkgSW50ZWdlcjwvZGl2PgoKPGRpdj51dG9i
amVjdC0wNTA2IFswNF0gVXRBbGxvY2F0ZU9iamVjdERlc2NEYjogLS0tLUVudHJ5PC9kaXY+PGRp
dj6gdXRhbGxvYy0wNDIzIFswNV0gVXRBbGxvY2F0ZSCgIKAgoCCgIKAgoDogLS0tLUVudHJ5IDAw
MDAwMDI4PC9kaXY+PGRpdj6gdXRhbGxvYy0wNDQ2IFswNV0gVXRBbGxvY2F0ZSCgIKAgoCCgIKAg
oDogLS0tLUV4aXQtIDB4MWIxYTg2ZTg8L2Rpdj48ZGl2PnV0b2JqZWN0LTA1MjMgWzA0XSBVdEFs
bG9jYXRlT2JqZWN0RGVzY0RiOiAweDFiMWE4NmU4IFNpemUgMjg8L2Rpdj4KCjxkaXY+dXRvYmpl
Y3QtMDUyNSBbMDRdIFV0QWxsb2NhdGVPYmplY3REZXNjRGI6IC0tLS1FeGl0LSAweDFiMWE4NmU4
PC9kaXY+PGRpdj51dG9iamVjdC0wMjI5IFswM10gVXRDcmVhdGVJbnRlcm5hbE9iamVjdDogLS0t
LUV4aXQtIDB4MWIxYTg2ZTg8L2Rpdj48ZGl2Pm5zb2JqZWN0LTAxNjEgWzAzXSBOc0F0dGFjaE9i
amVjdCCgIKAgoCCgOiAtLS0tRW50cnk8L2Rpdj48ZGl2Pm5zb2JqZWN0LTAyNDEgWzAzXSBOc0F0
dGFjaE9iamVjdCCgIKAgoCCgOiBJbnN0YWxsaW5nIDB4MWIxYTg2ZTggaW50byBOb2RlIDB4MWIx
YTg3MzggW19SRVZdPC9kaXY+Cgo8ZGl2PnV0ZGVsZXRlLTA3NTUgWzA0XSBVdEFkZFJlZmVyZW5j
ZSCgIKAgoCCgOiAtLS0tRW50cnkgMHgxYjFhODZlODwvZGl2PjxkaXY+dXRkZWxldGUtMDc2NyBb
MDRdIFV0QWRkUmVmZXJlbmNlIKAgoCCgIKA6IE9iaiAweDFiMWE4NmU4IEN1cnJlbnQgUmVmcz0x
IFtUbyBCZSBJbmNyZW1lbnRlZF08L2Rpdj48ZGl2PnV0ZGVsZXRlLTA1OTIgWzA1XSBVdFVwZGF0
ZU9iamVjdFJlZmVyZW5jOiAtLS0tRW50cnkgMHgxYjFhODZlODwvZGl2PgoKPGRpdj51dGRlbGV0
ZS0wNDk1IFswNV0gVXRVcGRhdGVSZWZDb3VudCCgIKAgoDogT2JqIDB4MWIxYTg2ZTggUmVmcz0y
LCBbSW5jcmVtZW50ZWRdPC9kaXY+PGRpdj51dGRlbGV0ZS0wNzE3IFswNV0gVXRVcGRhdGVPYmpl
Y3RSZWZlcmVuYzogLS0tLUV4aXQtIEFFX09LPC9kaXY+PGRpdj51dGRlbGV0ZS0wNzcyIFswNF0g
VXRBZGRSZWZlcmVuY2UgoCCgIKAgoDogLS0tLUV4aXQtPC9kaXY+Cgo8ZGl2Pm5zb2JqZWN0LTAy
NzYgWzAzXSBOc0F0dGFjaE9iamVjdCCgIKAgoCCgOiAtLS0tRXhpdC0gQUVfT0s8L2Rpdj48ZGl2
PnV0ZGVsZXRlLTA3OTMgWzAzXSBVdFJlbW92ZVJlZmVyZW5jZSCgIKAgOiAtLS0tRW50cnkgMHgx
YjFhODZlODwvZGl2PjxkaXY+dXRkZWxldGUtMDgxNyBbMDNdIFV0UmVtb3ZlUmVmZXJlbmNlIKAg
oCA6IE9iaiAweDFiMWE4NmU4IEN1cnJlbnQgUmVmcz0yIFtUbyBCZSBEZWNyZW1lbnRlZF08L2Rp
dj4KCjxkaXY+dXRkZWxldGUtMDU5MiBbMDRdIFV0VXBkYXRlT2JqZWN0UmVmZXJlbmM6IC0tLS1F
bnRyeSAweDFiMWE4NmU4PC9kaXY+PGRpdj51dGRlbGV0ZS0wNTE0IFswNF0gVXRVcGRhdGVSZWZD
b3VudCCgIKAgoDogT2JqIDB4MWIxYTg2ZTggUmVmcz0xLCBbRGVjcmVtZW50ZWRdPC9kaXY+PGRp
dj51dGRlbGV0ZS0wNzE3IFswNF0gVXRVcGRhdGVPYmplY3RSZWZlcmVuYzogLS0tLUV4aXQtIEFF
X09LPC9kaXY+Cgo8ZGl2PnV0ZGVsZXRlLTA4MjUgWzAzXSBVdFJlbW92ZVJlZmVyZW5jZSCgIKAg
OiAtLS0tRXhpdC08L2Rpdj48ZGl2Pm5zYWNjZXNzLTAzOTAgWzAzXSBOc0xvb2t1cCCgIKAgoCCg
IKAgoCCgOiAtLS0tRW50cnk8L2Rpdj48ZGl2Pm5zYWNjZXNzLTA0MTQgWzAzXSBOc0xvb2t1cCCg
IKAgoCCgIKAgoCCgOiBOdWxsIHNjb3BlIHByZWZpeCwgdXNpbmcgcm9vdCBub2RlICgweGI1NGRl
Yyk8L2Rpdj4KCjxkaXY+bnNhY2Nlc3MtMDQ5NiBbMDNdIE5zTG9va3VwIKAgoCCgIKAgoCCgIKA6
IFNlYXJjaGluZyByZWxhdGl2ZSB0byBwcmVmaXggc2NvcGUgWyZxdW90O1wmcXVvdDsgXSAoMHhi
NTRkZWMpPC9kaXY+PGRpdj5uc2FjY2Vzcy0wNjA3IFswM10gTnNMb29rdXAgoCCgIKAgoCCgIKAg
oDogU2ltcGxlIFBhdGhuYW1lICgxIHNlZ21lbnQsIEZsYWdzPTApPC9kaXY+PGRpdj6goG5zZHVt
cC0wMTc1IFswM10gTnNQcmludFBhdGhuYW1lIKAgoCCgIDogW19PU19dPC9kaXY+Cgo8ZGl2Pm5z
c2VhcmNoLTAzOTIgWzA0XSBOc1NlYXJjaEFuZEVudGVyIKAgoCCgOiAtLS0tRW50cnk8L2Rpdj48
ZGl2Pm5zc2VhcmNoLTAxODEgWzA1XSBOc1NlYXJjaE9uZVNjb3BlIKAgoCCgOiAtLS0tRW50cnk8
L2Rpdj48ZGl2PqBuc25hbWVzLTAyMjggWzA2XSBOc0dldEV4dGVybmFsUGF0aG5hbWUgOiAtLS0t
RW50cnkgMHhiNTRkZWM8L2Rpdj48ZGl2PqB1dGFsbG9jLTA0MjMgWzA3XSBVdEFsbG9jYXRlIKAg
oCCgIKAgoCCgOiAtLS0tRW50cnkgMDAwMDAwMDI8L2Rpdj4KCjxkaXY+oHV0YWxsb2MtMDQ0NiBb
MDddIFV0QWxsb2NhdGUgoCCgIKAgoCCgIKA6IC0tLS1FeGl0LSAweDFiMWE4Y2MwPC9kaXY+PGRp
dj6gbnNuYW1lcy0wMjU3IFswNl0gTnNHZXRFeHRlcm5hbFBhdGhuYW1lIDogLS0tLUV4aXQtIDB4
MWIxYThjYzA8L2Rpdj48ZGl2Pm5zc2VhcmNoLTAxOTUgWzA1XSBOc1NlYXJjaE9uZVNjb3BlIKAg
oCCgOiBTZWFyY2hpbmcgXCAoMHhiNTRkZWMpIEZvciBbX09TX10gKFN0cmluZyk8L2Rpdj4KCjxk
aXY+bnNzZWFyY2gtMDI1NCBbMDVdIE5zU2VhcmNoT25lU2NvcGUgoCCgIKA6IE5hbWUgW19PU19d
IChTdHJpbmcpIG5vdCBmb3VuZCBpbiBzZWFyY2ggaW4gc2NvcGUgWyZxdW90O1wmcXVvdDsgXSAw
eGI1NGRlYyBmaXJzdCBjaGlsZCAweDFiMTNjOWMwPC9kaXY+PGRpdj5uc3NlYXJjaC0wMjU2IFsw
NV0gTnNTZWFyY2hPbmVTY29wZSCgIKAgoDogLS0tLUV4aXQtICoqKipFeGNlcHRpb24qKioqOiBB
RV9OT1RfRk9VTkQ8L2Rpdj4KCjxkaXY+oG5zYWxsb2MtMDE1MCBbMDVdIE5zQ3JlYXRlTm9kZSCg
IKAgoCCgIKA6IC0tLS1FbnRyeTwvZGl2PjxkaXY+oHV0YWxsb2MtMDQyMyBbMDZdIFV0QWxsb2Nh
dGUgoCCgIKAgoCCgIKA6IC0tLS1FbnRyeSAwMDAwMDAxNDwvZGl2PjxkaXY+oHV0YWxsb2MtMDQ0
NiBbMDZdIFV0QWxsb2NhdGUgoCCgIKAgoCCgIKA6IC0tLS1FeGl0LSAweDFiMWE4Y2IwPC9kaXY+
PGRpdj6gbnNhbGxvYy0wMTcyIFswNV0gTnNDcmVhdGVOb2RlIKAgoCCgIKAgoDogLS0tLUV4aXQt
IDB4MWIxYThjYjA8L2Rpdj4KCjxkaXY+oG5zYWxsb2MtMDMzNiBbMDVdIE5zSW5zdGFsbE5vZGUg
oCCgIKAgoCA6IC0tLS1FbnRyeTwvZGl2PjxkaXY+oG5zYWxsb2MtMDM4MiBbMDVdIE5zSW5zdGFs
bE5vZGUgoCCgIKAgoCA6IF9PU18gKFN0cmluZykgW05vZGUgMHgxYjFhOGNiMCBPd25lciAwXSBh
ZGRlZCB0byAmcXVvdDtcJnF1b3Q7IKAoRGV2aWNlKSBbTm9kZSAweGI1NGRlY108L2Rpdj48ZGl2
PqBuc2FsbG9jLTAzODQgWzA1XSBOc0luc3RhbGxOb2RlIKAgoCCgIKAgOiAtLS0tRXhpdC08L2Rp
dj4KCjxkaXY+bnNzZWFyY2gtMDUwNSBbMDRdIE5zU2VhcmNoQW5kRW50ZXIgoCCgIKA6IC0tLS1F
eGl0LSBBRV9PSzwvZGl2PjxkaXY+bnNhY2Nlc3MtMDc3MCBbMDNdIE5zTG9va3VwIKAgoCCgIKAg
oCCgIKA6IC0tLS1FeGl0LSBBRV9PSzwvZGl2PjxkaXY+dXRvYmplY3QtMDE3OSBbMDNdIFV0Q3Jl
YXRlSW50ZXJuYWxPYmplY3Q6IC0tLS1FbnRyeSBTdHJpbmc8L2Rpdj48ZGl2PnV0b2JqZWN0LTA1
MDYgWzA0XSBVdEFsbG9jYXRlT2JqZWN0RGVzY0RiOiAtLS0tRW50cnk8L2Rpdj4KCjxkaXY+oHV0
YWxsb2MtMDQyMyBbMDVdIFV0QWxsb2NhdGUgoCCgIKAgoCCgIKA6IC0tLS1FbnRyeSAwPC9kaXY+
PGRpdj48ZGl2PjwvZGl2PjxkaXYgY2xhc3M9Img1Ij48ZGl2Pjxicj48L2Rpdj48YnI+PGRpdiBj
bGFzcz0iZ21haWxfcXVvdGUiPk9uIFR1ZSwgSnVsIDYsIDIwMTAgYXQgMTA6MzcgQU0sIFpoYW5n
IFJ1aSA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhyZWY9Im1haWx0bzpydWkuemhhbmdAaW50ZWwu
Y29tIiB0YXJnZXQ9Il9ibGFuayI+cnVpLnpoYW5nQGludGVsLmNvbTwvYT4mZ3Q7PC9zcGFuPiB3
cm90ZTo8YnI+Cgo8YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46
MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij48
ZGl2PjxkaXY+PC9kaXY+PGRpdj5PbiBUdWUsIDIwMTAtMDctMDYgYXQgMTA6MjkgKzA4MDAsIFNl
YW4gU2hvdWZ1IEx1byB3cm90ZTo8YnI+CiZndDsgUHJldmlvdXNseSwgSSBoYXZlIHBvcnRlZCBB
Q1BJQ0EgdG8gb3VyIHN5c3RlbS4gVGhlc2UgZGF5cywgSSB3b25uYSB0bzxicj4KJmd0OyB3cml0
ZSBBQ1BJIGRyaXZlciBmb3IgYmF0dGVyeSB3aXRoIE5ldGJzZCYjMzk7cyB2ZXJzaW9uIGFzIGd1
aWRlLCBidXQgSTxicj4KJmd0OyBmb3VuZCB3aGVuIEkgaW5pdGlhbGl6ZWQgYmF0dGVyeSBkcml2
ZXIsIGl0IHdvdWxkIGlzc3VlIGEgY29tbWFuZCB0bzxicj4KJmd0OyBxdWVyeSBfU1RBIGZvciBi
YXR0ZXJ5IHByZXNlbmNlLiBCdXQgaXRzIHJldHVybiB2YWx1ZSBpcyAweGYsIHRoYXQ8YnI+CiZn
dDsgaW5kaWNhdGVzIFBSRVNFTkNFIGJpdCBpcyBub3Qgc2V0ICgweDAwMDAwMDEwKS4goEkmIzM5
O20gcHV6emxlZC4gSSYjMzk7bTxicj4KJmd0OyB1c2luZyBiYXR0ZXJ5IC4uLi5XaHkgdGhlIGJh
dHRlcnkgbm90IHByZXNlbnQ/PGJyPgomZ3Q7IEFueW9uZSBjYW4gZ2l2ZSBhbnkgaGludD88YnI+
CiZndDs8YnI+CjwvZGl2PjwvZGl2PnBsZWFzZSBhdHRhY2ggdGhlIGFjcGlkdW1wIG91dHB1dCBv
ZiB0aGlzIG1hY2hpbmUuPGJyPgo8YnI+CnRoYW5rcyw8YnI+Cjxmb250IGNvbG9yPSIjODg4ODg4
Ij5ydWk8YnI+Cjxicj4KPGJyPgo8L2ZvbnQ+PC9ibG9ja3F1b3RlPjwvZGl2Pjxicj48L2Rpdj48
L2Rpdj48L2Rpdj48L2Rpdj4KPC9ibG9ja3F1b3RlPjwvZGl2Pjxicj48L2Rpdj4K

--===============6914058673998007394==--

