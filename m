Content-Type: multipart/mixed; boundary="===============7513858923476823771=="
MIME-Version: 1.0
From: Sean Shoufu Luo <luoshoufu at gmail.com>
Subject: Re: [Devel] Battery Presence
Date: Thu, 08 Jul 2010 11:36:22 +0800
Message-ID: <AANLkTinvPtZpFADGNVwGpszeiYeopC7AB-xPiZ87GAtl@mail.gmail.com>
In-Reply-To: 1278489457.4537.8255.camel@rzhang1-desktop
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7513858923476823771==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Strangely, I can start it in debug mode, but cannot get it work in normal
mode, as I described the system will hang when try to enable APCI ... but it
doesn't happen in debug mode ...

On Wed, Jul 7, 2010 at 3:57 PM, Zhang Rui <rui.zhang(a)intel.com> wrote:

> hmm, how did you get the battery status if you can not boot with ACPI
> enabled?
>
> thanks,
> rui
>
> On Tue, 2010-07-06 at 13:47 +0800, Sean Shoufu Luo wrote:
> > Yes, i'm trying .... but now, in my mobile client, it seems, something
> > else wrong when enable ACPI sub system
> > I set ACPI_LV_ALL for debug, and it give me such output, and then
> > system hang. ......................... any idea?
> >
> >
> >  utxface-0152 [01] InitializeSubsystem   : ----Entry
> > utglobal-0854 [02] UtInitGlobals         : ----Entry
> > utglobal-0964 [02] UtInitGlobals         : ----Exit- AE_OK
> >  utmutex-0157 [02] UtMutexInitialize     : ----Entry
> >  utmutex-0253 [03] UtCreateMutex         : ----Entry 00000000
> >  utmutex-0268 [03] UtCreateMutex         : ----Exit- AE_OK
> >  utmutex-0253 [03] UtCreateMutex         : ----Entry 00000001
> >  utmutex-0268 [03] UtCreateMutex         : ----Exit- AE_OK
> >  utmutex-0253 [03] UtCreateMutex         : ----Entry 00000002
> >  utmutex-0268 [03] UtCreateMutex         : ----Exit- AE_OK
> >  utmutex-0253 [03] UtCreateMutex         : ----Entry 00000003
> >  utmutex-0268 [03] UtCreateMutex         : ----Exit- AE_OK
> >  utmutex-0253 [03] UtCreateMutex         : ----Entry 00000004
> >  utmutex-0268 [03] UtCreateMutex         : ----Exit- AE_OK
> >  utmutex-0253 [03] UtCreateMutex         : ----Entry 00000005
> >  utmutex-0268 [03] UtCreateMutex         : ----Exit- AE_OK
> >  utmutex-0253 [03] UtCreateMutex         : ----Entry 00000006
> >  utmutex-0268 [03] UtCreateMutex         : ----Exit- AE_OK
> >  utmutex-0253 [03] UtCreateMutex         : ----Entry 00000007
> >  utmutex-0268 [03] UtCreateMutex         : ----Exit- AE_OK
> >  utmutex-0188 [02] UtMutexInitialize     : ----Exit- AE_OK
> > nsaccess-0154 [02] NsRootInitialize      : ----Entry
> > nsaccess-0182 [02] NsRootInitialize      : Entering predefined entries
> > into namespace
> > nsaccess-0390 [03] NsLookup              : ----Entry
> > nsaccess-0414 [03] NsLookup              : Null scope prefix, using
> > root node (0xb54dec)
> > nsaccess-0496 [03] NsLookup              : Searching relative to
> > prefix scope ["\" ] (0xb54dec)
> > nsaccess-0607 [03] NsLookup              : Simple Pathname (1 segment,
> > Flags=3D0)
> >   nsdump-0175 [03] NsPrintPathname       : [_GPE]
> > nssearch-0392 [04] NsSearchAndEnter      : ----Entry
> > nssearch-0181 [05] NsSearchOneScope      : ----Entry
> >  nsnames-0228 [06] NsGetExternalPathname : ----Entry 0xb54dec
> >  utalloc-0423 [07] UtAllocate            : ----Entry 00000002
> >  utalloc-0446 [07] UtAllocate            : ----Exit- 0x1b143e7c
> >  nsnames-0257 [06] NsGetExternalPathname : ----Exit- 0x1b143e7c
> > nssearch-0195 [05] NsSearchOneScope      : Searching \ (0xb54dec) For
> > [_GPE] (Scope)
> > nssearch-0254 [05] NsSearchOneScope      : Name [_GPE] (Scope) not
> > found in search in scope ["\" ] 0xb54dec first child 0x0
> > nssearch-0256 [05] NsSearchOneScope      : ----Exit-
> > ****Exception****: AE_NOT_FOUND
> >  nsalloc-0150 [05] NsCreateNode          : ----Entry
> >  utalloc-0423 [06] UtAllocate            : ----Entry 00000014
> >  utalloc-0446 [06] UtAllocate            : ----Exit- 0x1b13c9c0
> >  nsalloc-0172 [05] NsCreateNode          : ----Exit- 0x1b13c9c0
> >  nsalloc-0336 [05] NsInstallNode         : ----Entry
> >  nsalloc-0382 [05] NsInstallNode         : _GPE (Scope) [Node
> > 0x1b13c9c0 Owner 0] added to "\"  (Device) [Node 0xb54dec]
> >  nsalloc-0384 [05] NsInstallNode         : ----Exit-
> > nssearch-0505 [04] NsSearchAndEnter      : ----Exit- AE_OK
> > nsaccess-0770 [03] NsLookup              : ----Exit- AE_OK
> > nsaccess-0390 [03] NsLookup              : ----Entry
> > nsaccess-0414 [03] NsLookup              : Null scope prefix, using
> > root node (0xb54dec)
> > nsaccess-0496 [03] NsLookup              : Searching relative to
> > prefix scope ["\" ] (0xb54dec)
> > nsaccess-0607 [03] NsLookup              : Simple Pathname (1 segment,
> > Flags=3D0)
> >   nsdump-0175 [03] NsPrintPathname       : [_PR_]
> > nssearch-0392 [04] NsSearchAndEnter      : ----Entry
> > nssearch-0181 [05] NsSearchOneScope      : ----Entry
> >  nsnames-0228 [06] NsGetExternalPathname : ----Entry 0xb54dec
> >  utalloc-0423 [07] UtAllocate            : ----Entry 00000002
> >  utalloc-0446 [07] UtAllocate            : ----Exit- 0x1b143e7c
> >  nsnames-0257 [06] NsGetExternalPathname : ----Exit- 0x1b143e7c
> > nssearch-0195 [05] NsSearchOneScope      : Searching \ (0xb54dec) For
> > [_PR_] (Scope)
> > nssearch-0254 [05] NsSearchOneScope      : Name [_PR_] (Scope) not
> > found in search in scope ["\" ] 0xb54dec first child 0x1b13c9c0
> > nssearch-0256 [05] NsSearchOneScope      : ----Exit-
> > ****Exception****: AE_NOT_FOUND
> >  nsalloc-0150 [05] NsCreateNode          : ----Entry
> >  utalloc-0423 [06] UtAllocate            : ----Entry 00000014
> >  utalloc-0446 [06] UtAllocate            : ----Exit- 0x1b1a8808
> >  nsalloc-0172 [05] NsCreateNode          : ----Exit- 0x1b1a8808
> >  nsalloc-0336 [05] NsInstallNode         : ----Entry
> >  nsalloc-0382 [05] NsInstallNode         : _PR_ (Scope) [Node
> > 0x1b1a8808 Owner 0] added to "\"  (Device) [Node 0xb54dec]
> >  nsalloc-0384 [05] NsInstallNode         : ----Exit-
> > nssearch-0505 [04] NsSearchAndEnter      : ----Exit- AE_OK
> > nsaccess-0770 [03] NsLookup              : ----Exit- AE_OK
> > nsaccess-0390 [03] NsLookup              : ----Entry
> > nsaccess-0414 [03] NsLookup              : Null scope prefix, using
> > root node (0xb54dec)
> > nsaccess-0496 [03] NsLookup              : Searching relative to
> > prefix scope ["\" ] (0xb54dec)
> > nsaccess-0607 [03] NsLookup              : Simple Pathname (1 segment,
> > Flags=3D0)
> >   nsdump-0175 [03] NsPrintPathname       : [_SB_]
> > nssearch-0392 [04] NsSearchAndEnter      : ----Entry
> > nssearch-0181 [05] NsSearchOneScope      : ----Entry
> >  nsnames-0228 [06] NsGetExternalPathname : ----Entry 0xb54dec
> >  utalloc-0423 [07] UtAllocate            : ----Entry 00000002
> >  utalloc-0446 [07] UtAllocate            : ----Exit- 0x1b1a87e4
> >  nsnames-0257 [06] NsGetExternalPathname : ----Exit- 0x1b1a87e4
> > nssearch-0195 [05] NsSearchOneScope      : Searching \ (0xb54dec) For
> > [_SB_] (Device)
> > nssearch-0254 [05] NsSearchOneScope      : Name [_SB_] (Device) not
> > found in search in scope ["\" ] 0xb54dec first child 0x1b13c9c0
> > nssearch-0256 [05] NsSearchOneScope      : ----Exit-
> > ****Exception****: AE_NOT_FOUND
> >  nsalloc-0150 [05] NsCreateNode          : ----Entry
> >  utalloc-0423 [06] UtAllocate            : ----Entry 00000014
> >  utalloc-0446 [06] UtAllocate            : ----Exit- 0x1b1a87d4
> >  nsalloc-0172 [05] NsCreateNode          : ----Exit- 0x1b1a87d4
> >  nsalloc-0336 [05] NsInstallNode         : ----Entry
> >  nsalloc-0382 [05] NsInstallNode         : _SB_ (Device) [Node
> > 0x1b1a87d4 Owner 0] added to "\"  (Device) [Node 0xb54dec]
> >  nsalloc-0384 [05] NsInstallNode         : ----Exit-
> > nssearch-0505 [04] NsSearchAndEnter      : ----Exit- AE_OK
> > nsaccess-0770 [03] NsLookup              : ----Exit- AE_OK
> > nsaccess-0390 [03] NsLookup              : ----Entry
> > nsaccess-0414 [03] NsLookup              : Null scope prefix, using
> > root node (0xb54dec)
> > nsaccess-0496 [03] NsLookup              : Searching relative to
> > prefix scope ["\" ] (0xb54dec)
> > nsaccess-0607 [03] NsLookup              : Simple Pathname (1 segment,
> > Flags=3D0)
> >   nsdump-0175 [03] NsPrintPathname       : [_SI_]
> > nssearch-0392 [04] NsSearchAndEnter      : ----Entry
> > nssearch-0181 [05] NsSearchOneScope      : ----Entry
> >  nsnames-0228 [06] NsGetExternalPathname : ----Entry 0xb54dec
> >  utalloc-0423 [07] UtAllocate            : ----Entry 00000002
> >  utalloc-0446 [07] UtAllocate            : ----Exit- 0x1b1a87b0
> >  nsnames-0257 [06] NsGetExternalPathname : ----Exit- 0x1b1a87b0
> > nssearch-0195 [05] NsSearchOneScope      : Searching \ (0xb54dec) For
> > [_SI_] (Scope)
> > nssearch-0254 [05] NsSearchOneScope      : Name [_SI_] (Scope) not
> > found in search in scope ["\" ] 0xb54dec first child 0x1b13c9c0
> > nssearch-0256 [05] NsSearchOneScope      : ----Exit-
> > ****Exception****: AE_NOT_FOUND
> >  nsalloc-0150 [05] NsCreateNode          : ----Entry
> >  utalloc-0423 [06] UtAllocate            : ----Entry 00000014
> >  utalloc-0446 [06] UtAllocate            : ----Exit- 0x1b1a87a0
> >  nsalloc-0172 [05] NsCreateNode          : ----Exit- 0x1b1a87a0
> >  nsalloc-0336 [05] NsInstallNode         : ----Entry
> >  nsalloc-0382 [05] NsInstallNode         : _SI_ (Scope) [Node
> > 0x1b1a87a0 Owner 0] added to "\"  (Device) [Node 0xb54dec]
> >  nsalloc-0384 [05] NsInstallNode         : ----Exit-
> > nssearch-0505 [04] NsSearchAndEnter      : ----Exit- AE_OK
> > nsaccess-0770 [03] NsLookup              : ----Exit- AE_OK
> > nsaccess-0390 [03] NsLookup              : ----Entry
> > nsaccess-0414 [03] NsLookup              : Null scope prefix, using
> > root node (0xb54dec)
> > nsaccess-0496 [03] NsLookup              : Searching relative to
> > prefix scope ["\" ] (0xb54dec)
> > nsaccess-0607 [03] NsLookup              : Simple Pathname (1 segment,
> > Flags=3D0)
> >   nsdump-0175 [03] NsPrintPathname       : [_TZ_]
> > nssearch-0392 [04] NsSearchAndEnter      : ----Entry
> > nssearch-0181 [05] NsSearchOneScope      : ----Entry
> >  nsnames-0228 [06] NsGetExternalPathname : ----Entry 0xb54dec
> >  utalloc-0423 [07] UtAllocate            : ----Entry 00000002
> >  utalloc-0446 [07] UtAllocate            : ----Exit- 0x1b1a877c
> >  nsnames-0257 [06] NsGetExternalPathname : ----Exit- 0x1b1a877c
> > nssearch-0195 [05] NsSearchOneScope      : Searching \ (0xb54dec) For
> > [_TZ_] (Thermal)
> > nssearch-0254 [05] NsSearchOneScope      : Name [_TZ_] (Thermal) not
> > found in search in scope ["\" ] 0xb54dec first child 0x1b13c9c0
> > nssearch-0256 [05] NsSearchOneScope      : ----Exit-
> > ****Exception****: AE_NOT_FOUND
> >  nsalloc-0150 [05] NsCreateNode          : ----Entry
> >  utalloc-0423 [06] UtAllocate            : ----Entry 00000014
> >  utalloc-0446 [06] UtAllocate            : ----Exit- 0x1b1a876c
> >  nsalloc-0172 [05] NsCreateNode          : ----Exit- 0x1b1a876c
> >  nsalloc-0336 [05] NsInstallNode         : ----Entry
> >  nsalloc-0382 [05] NsInstallNode         : _TZ_ (Thermal) [Node
> > 0x1b1a876c Owner 0] added to "\"  (Device) [Node 0xb54dec]
> >  nsalloc-0384 [05] NsInstallNode         : ----Exit-
> > nssearch-0505 [04] NsSearchAndEnter      : ----Exit- AE_OK
> > nsaccess-0770 [03] NsLookup              : ----Exit- AE_OK
> > nsaccess-0390 [03] NsLookup              : ----Entry
> > nsaccess-0414 [03] NsLookup              : Null scope prefix, using
> > root node (0xb54dec)
> > nsaccess-0496 [03] NsLookup              : Searching relative to
> > prefix scope ["\" ] (0xb54dec)
> > nsaccess-0607 [03] NsLookup              : Simple Pathname (1 segment,
> > Flags=3D0)
> >   nsdump-0175 [03] NsPrintPathname       : [_REV]
> > nssearch-0392 [04] NsSearchAndEnter      : ----Entry
> > nssearch-0181 [05] NsSearchOneScope      : ----Entry
> >  nsnames-0228 [06] NsGetExternalPathname : ----Entry 0xb54dec
> >  utalloc-0423 [07] UtAllocate            : ----Entry 00000002
> >  utalloc-0446 [07] UtAllocate            : ----Exit- 0x1b1a8748
> >  nsnames-0257 [06] NsGetExternalPathname : ----Exit- 0x1b1a8748
> > nssearch-0195 [05] NsSearchOneScope      : Searching \ (0xb54dec) For
> > [_REV] (Integer)
> > nssearch-0254 [05] NsSearchOneScope      : Name [_REV] (Integer) not
> > found in search in scope ["\" ] 0xb54dec first child 0x1b13c9c0
> > nssearch-0256 [05] NsSearchOneScope      : ----Exit-
> > ****Exception****: AE_NOT_FOUND
> >  nsalloc-0150 [05] NsCreateNode          : ----Entry
> >  utalloc-0423 [06] UtAllocate            : ----Entry 00000014
> >  utalloc-0446 [06] UtAllocate            : ----Exit- 0x1b1a8738
> >  nsalloc-0172 [05] NsCreateNode          : ----Exit- 0x1b1a8738
> >  nsalloc-0336 [05] NsInstallNode         : ----Entry
> >  nsalloc-0382 [05] NsInstallNode         : _REV (Integer) [Node
> > 0x1b1a8738 Owner 0] added to "\"  (Device) [Node 0xb54dec]
> >  nsalloc-0384 [05] NsInstallNode         : ----Exit-
> > nssearch-0505 [04] NsSearchAndEnter      : ----Exit- AE_OK
> > nsaccess-0770 [03] NsLookup              : ----Exit- AE_OK
> > utobject-0179 [03] UtCreateInternalObject: ----Entry Integer
> > utobject-0506 [04] UtAllocateObjectDescDb: ----Entry
> >  utalloc-0423 [05] UtAllocate            : ----Entry 00000028
> >  utalloc-0446 [05] UtAllocate            : ----Exit- 0x1b1a86e8
> > utobject-0523 [04] UtAllocateObjectDescDb: 0x1b1a86e8 Size 28
> > utobject-0525 [04] UtAllocateObjectDescDb: ----Exit- 0x1b1a86e8
> > utobject-0229 [03] UtCreateInternalObject: ----Exit- 0x1b1a86e8
> > nsobject-0161 [03] NsAttachObject        : ----Entry
> > nsobject-0241 [03] NsAttachObject        : Installing 0x1b1a86e8 into
> > Node 0x1b1a8738 [_REV]
> > utdelete-0755 [04] UtAddReference        : ----Entry 0x1b1a86e8
> > utdelete-0767 [04] UtAddReference        : Obj 0x1b1a86e8 Current
> > Refs=3D1 [To Be Incremented]
> > utdelete-0592 [05] UtUpdateObjectReferenc: ----Entry 0x1b1a86e8
> > utdelete-0495 [05] UtUpdateRefCount      : Obj 0x1b1a86e8 Refs=3D2,
> > [Incremented]
> > utdelete-0717 [05] UtUpdateObjectReferenc: ----Exit- AE_OK
> > utdelete-0772 [04] UtAddReference        : ----Exit-
> > nsobject-0276 [03] NsAttachObject        : ----Exit- AE_OK
> > utdelete-0793 [03] UtRemoveReference     : ----Entry 0x1b1a86e8
> > utdelete-0817 [03] UtRemoveReference     : Obj 0x1b1a86e8 Current
> > Refs=3D2 [To Be Decremented]
> > utdelete-0592 [04] UtUpdateObjectReferenc: ----Entry 0x1b1a86e8
> > utdelete-0514 [04] UtUpdateRefCount      : Obj 0x1b1a86e8 Refs=3D1,
> > [Decremented]
> > utdelete-0717 [04] UtUpdateObjectReferenc: ----Exit- AE_OK
> > utdelete-0825 [03] UtRemoveReference     : ----Exit-
> > nsaccess-0390 [03] NsLookup              : ----Entry
> > nsaccess-0414 [03] NsLookup              : Null scope prefix, using
> > root node (0xb54dec)
> > nsaccess-0496 [03] NsLookup              : Searching relative to
> > prefix scope ["\" ] (0xb54dec)
> > nsaccess-0607 [03] NsLookup              : Simple Pathname (1 segment,
> > Flags=3D0)
> >   nsdump-0175 [03] NsPrintPathname       : [_OS_]
> > nssearch-0392 [04] NsSearchAndEnter      : ----Entry
> > nssearch-0181 [05] NsSearchOneScope      : ----Entry
> >  nsnames-0228 [06] NsGetExternalPathname : ----Entry 0xb54dec
> >  utalloc-0423 [07] UtAllocate            : ----Entry 00000002
> >  utalloc-0446 [07] UtAllocate            : ----Exit- 0x1b1a8cc0
> >  nsnames-0257 [06] NsGetExternalPathname : ----Exit- 0x1b1a8cc0
> > nssearch-0195 [05] NsSearchOneScope      : Searching \ (0xb54dec) For
> > [_OS_] (String)
> > nssearch-0254 [05] NsSearchOneScope      : Name [_OS_] (String) not
> > found in search in scope ["\" ] 0xb54dec first child 0x1b13c9c0
> > nssearch-0256 [05] NsSearchOneScope      : ----Exit-
> > ****Exception****: AE_NOT_FOUND
> >  nsalloc-0150 [05] NsCreateNode          : ----Entry
> >  utalloc-0423 [06] UtAllocate            : ----Entry 00000014
> >  utalloc-0446 [06] UtAllocate            : ----Exit- 0x1b1a8cb0
> >  nsalloc-0172 [05] NsCreateNode          : ----Exit- 0x1b1a8cb0
> >  nsalloc-0336 [05] NsInstallNode         : ----Entry
> >  nsalloc-0382 [05] NsInstallNode         : _OS_ (String) [Node
> > 0x1b1a8cb0 Owner 0] added to "\"  (Device) [Node 0xb54dec]
> >  nsalloc-0384 [05] NsInstallNode         : ----Exit-
> > nssearch-0505 [04] NsSearchAndEnter      : ----Exit- AE_OK
> > nsaccess-0770 [03] NsLookup              : ----Exit- AE_OK
> > utobject-0179 [03] UtCreateInternalObject: ----Entry String
> > utobject-0506 [04] UtAllocateObjectDescDb: ----Entry
> >  utalloc-0423 [05] UtAllocate            : ----Entry 0
> >
> >
> >
> > On Tue, Jul 6, 2010 at 10:37 AM, Zhang Rui <rui.zhang(a)intel.com>
> > wrote:
> >
> >         On Tue, 2010-07-06 at 10:29 +0800, Sean Shoufu Luo wrote:
> >         > Previously, I have ported ACPICA to our system. These days,
> >         I wonna to
> >         > write ACPI driver for battery with Netbsd's version as
> >         guide, but I
> >         > found when I initialized battery driver, it would issue a
> >         command to
> >         > query _STA for battery presence. But its return value is
> >         0xf, that
> >         > indicates PRESENCE bit is not set (0x00000010).  I'm
> >         puzzled. I'm
> >         > using battery ....Why the battery not present?
> >         > Anyone can give any hint?
> >         >
> >
> >         please attach the acpidump output of this machine.
> >
> >         thanks,
> >         rui
> >
> >
> >
> >
>
>
>

--===============7513858923476823771==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PHNwYW4gY2xhc3M9IkFwcGxlLXN0eWxlLXNwYW4iIHN0eWxlPSJmb250LWZhbWlseTogYXJpYWws
IHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTogMTNweDsgYm9yZGVyLWNvbGxhcHNlOiBjb2xsYXBzZTsg
Ij5TdHJhbmdlbHksIEkgY2FuIHN0YXJ0IGl0IGluIGRlYnVnIG1vZGUsIGJ1dCBjYW5ub3QgZ2V0
IGl0IHdvcmsgaW4gbm9ybWFsIG1vZGUsIGFzIEkgZGVzY3JpYmVkIHRoZSBzeXN0ZW0gd2lsbCBo
YW5nIHdoZW4gdHJ5IHRvIGVuYWJsZSBBUENJIC4uLiBidXQgaXQgZG9lc24mIzM5O3QgaGFwcGVu
IGluIGRlYnVnIG1vZGUgLi4uPC9zcGFuPjxicj4KPGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3Rl
Ij5PbiBXZWQsIEp1bCA3LCAyMDEwIGF0IDM6NTcgUE0sIFpoYW5nIFJ1aSA8c3BhbiBkaXI9Imx0
ciI+Jmx0OzxhIGhyZWY9Im1haWx0bzpydWkuemhhbmdAaW50ZWwuY29tIj5ydWkuemhhbmdAaW50
ZWwuY29tPC9hPiZndDs8L3NwYW4+IHdyb3RlOjxicj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxf
cXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xp
ZDtwYWRkaW5nLWxlZnQ6MWV4OyI+CmhtbSwgaG93IGRpZCB5b3UgZ2V0IHRoZSBiYXR0ZXJ5IHN0
YXR1cyBpZiB5b3UgY2FuIG5vdCBib290IHdpdGggQUNQSTxicj4KZW5hYmxlZD88YnI+Cjxicj4K
dGhhbmtzLDxicj4KPGZvbnQgY29sb3I9IiM4ODg4ODgiPnJ1aTxicj4KPC9mb250PjxkaXY+PGRp
dj48L2Rpdj48ZGl2IGNsYXNzPSJoNSI+PGJyPgpPbiBUdWUsIDIwMTAtMDctMDYgYXQgMTM6NDcg
KzA4MDAsIFNlYW4gU2hvdWZ1IEx1byB3cm90ZTo8YnI+CiZndDsgWWVzLCBpJiMzOTttIHRyeWlu
ZyAuLi4uIGJ1dCBub3csIGluIG15IG1vYmlsZSBjbGllbnQsIGl0IHNlZW1zLCBzb21ldGhpbmc8
YnI+CiZndDsgZWxzZSB3cm9uZyB3aGVuIGVuYWJsZSBBQ1BJIHN1YiBzeXN0ZW08YnI+CiZndDsg
SSBzZXQgQUNQSV9MVl9BTEwgZm9yIGRlYnVnLCBhbmQgaXQgZ2l2ZSBtZSBzdWNoIG91dHB1dCwg
YW5kIHRoZW48YnI+CiZndDsgc3lzdGVtIGhhbmcuIC4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4g
YW55IGlkZWE/PGJyPgomZ3Q7PGJyPgomZ3Q7PGJyPgomZ3Q7IKB1dHhmYWNlLTAxNTIgWzAxXSBJ
bml0aWFsaXplU3Vic3lzdGVtIKAgOiAtLS0tRW50cnk8YnI+CiZndDsgdXRnbG9iYWwtMDg1NCBb
MDJdIFV0SW5pdEdsb2JhbHMgoCCgIKAgoCA6IC0tLS1FbnRyeTxicj4KJmd0OyB1dGdsb2JhbC0w
OTY0IFswMl0gVXRJbml0R2xvYmFscyCgIKAgoCCgIDogLS0tLUV4aXQtIEFFX09LPGJyPgomZ3Q7
IKB1dG11dGV4LTAxNTcgWzAyXSBVdE11dGV4SW5pdGlhbGl6ZSCgIKAgOiAtLS0tRW50cnk8YnI+
CiZndDsgoHV0bXV0ZXgtMDI1MyBbMDNdIFV0Q3JlYXRlTXV0ZXggoCCgIKAgoCA6IC0tLS1FbnRy
eSAwMDAwMDAwMDxicj4KJmd0OyCgdXRtdXRleC0wMjY4IFswM10gVXRDcmVhdGVNdXRleCCgIKAg
oCCgIDogLS0tLUV4aXQtIEFFX09LPGJyPgomZ3Q7IKB1dG11dGV4LTAyNTMgWzAzXSBVdENyZWF0
ZU11dGV4IKAgoCCgIKAgOiAtLS0tRW50cnkgMDAwMDAwMDE8YnI+CiZndDsgoHV0bXV0ZXgtMDI2
OCBbMDNdIFV0Q3JlYXRlTXV0ZXggoCCgIKAgoCA6IC0tLS1FeGl0LSBBRV9PSzxicj4KJmd0OyCg
dXRtdXRleC0wMjUzIFswM10gVXRDcmVhdGVNdXRleCCgIKAgoCCgIDogLS0tLUVudHJ5IDAwMDAw
MDAyPGJyPgomZ3Q7IKB1dG11dGV4LTAyNjggWzAzXSBVdENyZWF0ZU11dGV4IKAgoCCgIKAgOiAt
LS0tRXhpdC0gQUVfT0s8YnI+CiZndDsgoHV0bXV0ZXgtMDI1MyBbMDNdIFV0Q3JlYXRlTXV0ZXgg
oCCgIKAgoCA6IC0tLS1FbnRyeSAwMDAwMDAwMzxicj4KJmd0OyCgdXRtdXRleC0wMjY4IFswM10g
VXRDcmVhdGVNdXRleCCgIKAgoCCgIDogLS0tLUV4aXQtIEFFX09LPGJyPgomZ3Q7IKB1dG11dGV4
LTAyNTMgWzAzXSBVdENyZWF0ZU11dGV4IKAgoCCgIKAgOiAtLS0tRW50cnkgMDAwMDAwMDQ8YnI+
CiZndDsgoHV0bXV0ZXgtMDI2OCBbMDNdIFV0Q3JlYXRlTXV0ZXggoCCgIKAgoCA6IC0tLS1FeGl0
LSBBRV9PSzxicj4KJmd0OyCgdXRtdXRleC0wMjUzIFswM10gVXRDcmVhdGVNdXRleCCgIKAgoCCg
IDogLS0tLUVudHJ5IDAwMDAwMDA1PGJyPgomZ3Q7IKB1dG11dGV4LTAyNjggWzAzXSBVdENyZWF0
ZU11dGV4IKAgoCCgIKAgOiAtLS0tRXhpdC0gQUVfT0s8YnI+CiZndDsgoHV0bXV0ZXgtMDI1MyBb
MDNdIFV0Q3JlYXRlTXV0ZXggoCCgIKAgoCA6IC0tLS1FbnRyeSAwMDAwMDAwNjxicj4KJmd0OyCg
dXRtdXRleC0wMjY4IFswM10gVXRDcmVhdGVNdXRleCCgIKAgoCCgIDogLS0tLUV4aXQtIEFFX09L
PGJyPgomZ3Q7IKB1dG11dGV4LTAyNTMgWzAzXSBVdENyZWF0ZU11dGV4IKAgoCCgIKAgOiAtLS0t
RW50cnkgMDAwMDAwMDc8YnI+CiZndDsgoHV0bXV0ZXgtMDI2OCBbMDNdIFV0Q3JlYXRlTXV0ZXgg
oCCgIKAgoCA6IC0tLS1FeGl0LSBBRV9PSzxicj4KJmd0OyCgdXRtdXRleC0wMTg4IFswMl0gVXRN
dXRleEluaXRpYWxpemUgoCCgIDogLS0tLUV4aXQtIEFFX09LPGJyPgomZ3Q7IG5zYWNjZXNzLTAx
NTQgWzAyXSBOc1Jvb3RJbml0aWFsaXplIKAgoCCgOiAtLS0tRW50cnk8YnI+CiZndDsgbnNhY2Nl
c3MtMDE4MiBbMDJdIE5zUm9vdEluaXRpYWxpemUgoCCgIKA6IEVudGVyaW5nIHByZWRlZmluZWQg
ZW50cmllczxicj4KJmd0OyBpbnRvIG5hbWVzcGFjZTxicj4KJmd0OyBuc2FjY2Vzcy0wMzkwIFsw
M10gTnNMb29rdXAgoCCgIKAgoCCgIKAgoDogLS0tLUVudHJ5PGJyPgomZ3Q7IG5zYWNjZXNzLTA0
MTQgWzAzXSBOc0xvb2t1cCCgIKAgoCCgIKAgoCCgOiBOdWxsIHNjb3BlIHByZWZpeCwgdXNpbmc8
YnI+CiZndDsgcm9vdCBub2RlICgweGI1NGRlYyk8YnI+CiZndDsgbnNhY2Nlc3MtMDQ5NiBbMDNd
IE5zTG9va3VwIKAgoCCgIKAgoCCgIKA6IFNlYXJjaGluZyByZWxhdGl2ZSB0bzxicj4KJmd0OyBw
cmVmaXggc2NvcGUgWyZxdW90O1wmcXVvdDsgXSAoMHhiNTRkZWMpPGJyPgomZ3Q7IG5zYWNjZXNz
LTA2MDcgWzAzXSBOc0xvb2t1cCCgIKAgoCCgIKAgoCCgOiBTaW1wbGUgUGF0aG5hbWUgKDEgc2Vn
bWVudCw8YnI+CiZndDsgRmxhZ3M9MCk8YnI+CiZndDsgoCBuc2R1bXAtMDE3NSBbMDNdIE5zUHJp
bnRQYXRobmFtZSCgIKAgoCA6IFtfR1BFXTxicj4KJmd0OyBuc3NlYXJjaC0wMzkyIFswNF0gTnNT
ZWFyY2hBbmRFbnRlciCgIKAgoDogLS0tLUVudHJ5PGJyPgomZ3Q7IG5zc2VhcmNoLTAxODEgWzA1
XSBOc1NlYXJjaE9uZVNjb3BlIKAgoCCgOiAtLS0tRW50cnk8YnI+CiZndDsgoG5zbmFtZXMtMDIy
OCBbMDZdIE5zR2V0RXh0ZXJuYWxQYXRobmFtZSA6IC0tLS1FbnRyeSAweGI1NGRlYzxicj4KJmd0
OyCgdXRhbGxvYy0wNDIzIFswN10gVXRBbGxvY2F0ZSCgIKAgoCCgIKAgoDogLS0tLUVudHJ5IDAw
MDAwMDAyPGJyPgomZ3Q7IKB1dGFsbG9jLTA0NDYgWzA3XSBVdEFsbG9jYXRlIKAgoCCgIKAgoCCg
OiAtLS0tRXhpdC0gMHgxYjE0M2U3Yzxicj4KJmd0OyCgbnNuYW1lcy0wMjU3IFswNl0gTnNHZXRF
eHRlcm5hbFBhdGhuYW1lIDogLS0tLUV4aXQtIDB4MWIxNDNlN2M8YnI+CiZndDsgbnNzZWFyY2gt
MDE5NSBbMDVdIE5zU2VhcmNoT25lU2NvcGUgoCCgIKA6IFNlYXJjaGluZyBcICgweGI1NGRlYykg
Rm9yPGJyPgomZ3Q7IFtfR1BFXSAoU2NvcGUpPGJyPgomZ3Q7IG5zc2VhcmNoLTAyNTQgWzA1XSBO
c1NlYXJjaE9uZVNjb3BlIKAgoCCgOiBOYW1lIFtfR1BFXSAoU2NvcGUpIG5vdDxicj4KJmd0OyBm
b3VuZCBpbiBzZWFyY2ggaW4gc2NvcGUgWyZxdW90O1wmcXVvdDsgXSAweGI1NGRlYyBmaXJzdCBj
aGlsZCAweDA8YnI+CiZndDsgbnNzZWFyY2gtMDI1NiBbMDVdIE5zU2VhcmNoT25lU2NvcGUgoCCg
IKA6IC0tLS1FeGl0LTxicj4KJmd0OyAqKioqRXhjZXB0aW9uKioqKjogQUVfTk9UX0ZPVU5EPGJy
PgomZ3Q7IKBuc2FsbG9jLTAxNTAgWzA1XSBOc0NyZWF0ZU5vZGUgoCCgIKAgoCCgOiAtLS0tRW50
cnk8YnI+CiZndDsgoHV0YWxsb2MtMDQyMyBbMDZdIFV0QWxsb2NhdGUgoCCgIKAgoCCgIKA6IC0t
LS1FbnRyeSAwMDAwMDAxNDxicj4KJmd0OyCgdXRhbGxvYy0wNDQ2IFswNl0gVXRBbGxvY2F0ZSCg
IKAgoCCgIKAgoDogLS0tLUV4aXQtIDB4MWIxM2M5YzA8YnI+CiZndDsgoG5zYWxsb2MtMDE3MiBb
MDVdIE5zQ3JlYXRlTm9kZSCgIKAgoCCgIKA6IC0tLS1FeGl0LSAweDFiMTNjOWMwPGJyPgomZ3Q7
IKBuc2FsbG9jLTAzMzYgWzA1XSBOc0luc3RhbGxOb2RlIKAgoCCgIKAgOiAtLS0tRW50cnk8YnI+
CiZndDsgoG5zYWxsb2MtMDM4MiBbMDVdIE5zSW5zdGFsbE5vZGUgoCCgIKAgoCA6IF9HUEUgKFNj
b3BlKSBbTm9kZTxicj4KJmd0OyAweDFiMTNjOWMwIE93bmVyIDBdIGFkZGVkIHRvICZxdW90O1wm
cXVvdDsgoChEZXZpY2UpIFtOb2RlIDB4YjU0ZGVjXTxicj4KJmd0OyCgbnNhbGxvYy0wMzg0IFsw
NV0gTnNJbnN0YWxsTm9kZSCgIKAgoCCgIDogLS0tLUV4aXQtPGJyPgomZ3Q7IG5zc2VhcmNoLTA1
MDUgWzA0XSBOc1NlYXJjaEFuZEVudGVyIKAgoCCgOiAtLS0tRXhpdC0gQUVfT0s8YnI+CiZndDsg
bnNhY2Nlc3MtMDc3MCBbMDNdIE5zTG9va3VwIKAgoCCgIKAgoCCgIKA6IC0tLS1FeGl0LSBBRV9P
Szxicj4KJmd0OyBuc2FjY2Vzcy0wMzkwIFswM10gTnNMb29rdXAgoCCgIKAgoCCgIKAgoDogLS0t
LUVudHJ5PGJyPgomZ3Q7IG5zYWNjZXNzLTA0MTQgWzAzXSBOc0xvb2t1cCCgIKAgoCCgIKAgoCCg
OiBOdWxsIHNjb3BlIHByZWZpeCwgdXNpbmc8YnI+CiZndDsgcm9vdCBub2RlICgweGI1NGRlYyk8
YnI+CiZndDsgbnNhY2Nlc3MtMDQ5NiBbMDNdIE5zTG9va3VwIKAgoCCgIKAgoCCgIKA6IFNlYXJj
aGluZyByZWxhdGl2ZSB0bzxicj4KJmd0OyBwcmVmaXggc2NvcGUgWyZxdW90O1wmcXVvdDsgXSAo
MHhiNTRkZWMpPGJyPgomZ3Q7IG5zYWNjZXNzLTA2MDcgWzAzXSBOc0xvb2t1cCCgIKAgoCCgIKAg
oCCgOiBTaW1wbGUgUGF0aG5hbWUgKDEgc2VnbWVudCw8YnI+CiZndDsgRmxhZ3M9MCk8YnI+CiZn
dDsgoCBuc2R1bXAtMDE3NSBbMDNdIE5zUHJpbnRQYXRobmFtZSCgIKAgoCA6IFtfUFJfXTxicj4K
Jmd0OyBuc3NlYXJjaC0wMzkyIFswNF0gTnNTZWFyY2hBbmRFbnRlciCgIKAgoDogLS0tLUVudHJ5
PGJyPgomZ3Q7IG5zc2VhcmNoLTAxODEgWzA1XSBOc1NlYXJjaE9uZVNjb3BlIKAgoCCgOiAtLS0t
RW50cnk8YnI+CiZndDsgoG5zbmFtZXMtMDIyOCBbMDZdIE5zR2V0RXh0ZXJuYWxQYXRobmFtZSA6
IC0tLS1FbnRyeSAweGI1NGRlYzxicj4KJmd0OyCgdXRhbGxvYy0wNDIzIFswN10gVXRBbGxvY2F0
ZSCgIKAgoCCgIKAgoDogLS0tLUVudHJ5IDAwMDAwMDAyPGJyPgomZ3Q7IKB1dGFsbG9jLTA0NDYg
WzA3XSBVdEFsbG9jYXRlIKAgoCCgIKAgoCCgOiAtLS0tRXhpdC0gMHgxYjE0M2U3Yzxicj4KJmd0
OyCgbnNuYW1lcy0wMjU3IFswNl0gTnNHZXRFeHRlcm5hbFBhdGhuYW1lIDogLS0tLUV4aXQtIDB4
MWIxNDNlN2M8YnI+CiZndDsgbnNzZWFyY2gtMDE5NSBbMDVdIE5zU2VhcmNoT25lU2NvcGUgoCCg
IKA6IFNlYXJjaGluZyBcICgweGI1NGRlYykgRm9yPGJyPgomZ3Q7IFtfUFJfXSAoU2NvcGUpPGJy
PgomZ3Q7IG5zc2VhcmNoLTAyNTQgWzA1XSBOc1NlYXJjaE9uZVNjb3BlIKAgoCCgOiBOYW1lIFtf
UFJfXSAoU2NvcGUpIG5vdDxicj4KJmd0OyBmb3VuZCBpbiBzZWFyY2ggaW4gc2NvcGUgWyZxdW90
O1wmcXVvdDsgXSAweGI1NGRlYyBmaXJzdCBjaGlsZCAweDFiMTNjOWMwPGJyPgomZ3Q7IG5zc2Vh
cmNoLTAyNTYgWzA1XSBOc1NlYXJjaE9uZVNjb3BlIKAgoCCgOiAtLS0tRXhpdC08YnI+CiZndDsg
KioqKkV4Y2VwdGlvbioqKio6IEFFX05PVF9GT1VORDxicj4KJmd0OyCgbnNhbGxvYy0wMTUwIFsw
NV0gTnNDcmVhdGVOb2RlIKAgoCCgIKAgoDogLS0tLUVudHJ5PGJyPgomZ3Q7IKB1dGFsbG9jLTA0
MjMgWzA2XSBVdEFsbG9jYXRlIKAgoCCgIKAgoCCgOiAtLS0tRW50cnkgMDAwMDAwMTQ8YnI+CiZn
dDsgoHV0YWxsb2MtMDQ0NiBbMDZdIFV0QWxsb2NhdGUgoCCgIKAgoCCgIKA6IC0tLS1FeGl0LSAw
eDFiMWE4ODA4PGJyPgomZ3Q7IKBuc2FsbG9jLTAxNzIgWzA1XSBOc0NyZWF0ZU5vZGUgoCCgIKAg
oCCgOiAtLS0tRXhpdC0gMHgxYjFhODgwODxicj4KJmd0OyCgbnNhbGxvYy0wMzM2IFswNV0gTnNJ
bnN0YWxsTm9kZSCgIKAgoCCgIDogLS0tLUVudHJ5PGJyPgomZ3Q7IKBuc2FsbG9jLTAzODIgWzA1
XSBOc0luc3RhbGxOb2RlIKAgoCCgIKAgOiBfUFJfIChTY29wZSkgW05vZGU8YnI+CiZndDsgMHgx
YjFhODgwOCBPd25lciAwXSBhZGRlZCB0byAmcXVvdDtcJnF1b3Q7IKAoRGV2aWNlKSBbTm9kZSAw
eGI1NGRlY108YnI+CiZndDsgoG5zYWxsb2MtMDM4NCBbMDVdIE5zSW5zdGFsbE5vZGUgoCCgIKAg
oCA6IC0tLS1FeGl0LTxicj4KJmd0OyBuc3NlYXJjaC0wNTA1IFswNF0gTnNTZWFyY2hBbmRFbnRl
ciCgIKAgoDogLS0tLUV4aXQtIEFFX09LPGJyPgomZ3Q7IG5zYWNjZXNzLTA3NzAgWzAzXSBOc0xv
b2t1cCCgIKAgoCCgIKAgoCCgOiAtLS0tRXhpdC0gQUVfT0s8YnI+CiZndDsgbnNhY2Nlc3MtMDM5
MCBbMDNdIE5zTG9va3VwIKAgoCCgIKAgoCCgIKA6IC0tLS1FbnRyeTxicj4KJmd0OyBuc2FjY2Vz
cy0wNDE0IFswM10gTnNMb29rdXAgoCCgIKAgoCCgIKAgoDogTnVsbCBzY29wZSBwcmVmaXgsIHVz
aW5nPGJyPgomZ3Q7IHJvb3Qgbm9kZSAoMHhiNTRkZWMpPGJyPgomZ3Q7IG5zYWNjZXNzLTA0OTYg
WzAzXSBOc0xvb2t1cCCgIKAgoCCgIKAgoCCgOiBTZWFyY2hpbmcgcmVsYXRpdmUgdG88YnI+CiZn
dDsgcHJlZml4IHNjb3BlIFsmcXVvdDtcJnF1b3Q7IF0gKDB4YjU0ZGVjKTxicj4KJmd0OyBuc2Fj
Y2Vzcy0wNjA3IFswM10gTnNMb29rdXAgoCCgIKAgoCCgIKAgoDogU2ltcGxlIFBhdGhuYW1lICgx
IHNlZ21lbnQsPGJyPgomZ3Q7IEZsYWdzPTApPGJyPgomZ3Q7IKAgbnNkdW1wLTAxNzUgWzAzXSBO
c1ByaW50UGF0aG5hbWUgoCCgIKAgOiBbX1NCX108YnI+CiZndDsgbnNzZWFyY2gtMDM5MiBbMDRd
IE5zU2VhcmNoQW5kRW50ZXIgoCCgIKA6IC0tLS1FbnRyeTxicj4KJmd0OyBuc3NlYXJjaC0wMTgx
IFswNV0gTnNTZWFyY2hPbmVTY29wZSCgIKAgoDogLS0tLUVudHJ5PGJyPgomZ3Q7IKBuc25hbWVz
LTAyMjggWzA2XSBOc0dldEV4dGVybmFsUGF0aG5hbWUgOiAtLS0tRW50cnkgMHhiNTRkZWM8YnI+
CiZndDsgoHV0YWxsb2MtMDQyMyBbMDddIFV0QWxsb2NhdGUgoCCgIKAgoCCgIKA6IC0tLS1FbnRy
eSAwMDAwMDAwMjxicj4KJmd0OyCgdXRhbGxvYy0wNDQ2IFswN10gVXRBbGxvY2F0ZSCgIKAgoCCg
IKAgoDogLS0tLUV4aXQtIDB4MWIxYTg3ZTQ8YnI+CiZndDsgoG5zbmFtZXMtMDI1NyBbMDZdIE5z
R2V0RXh0ZXJuYWxQYXRobmFtZSA6IC0tLS1FeGl0LSAweDFiMWE4N2U0PGJyPgomZ3Q7IG5zc2Vh
cmNoLTAxOTUgWzA1XSBOc1NlYXJjaE9uZVNjb3BlIKAgoCCgOiBTZWFyY2hpbmcgXCAoMHhiNTRk
ZWMpIEZvcjxicj4KJmd0OyBbX1NCX10gKERldmljZSk8YnI+CiZndDsgbnNzZWFyY2gtMDI1NCBb
MDVdIE5zU2VhcmNoT25lU2NvcGUgoCCgIKA6IE5hbWUgW19TQl9dIChEZXZpY2UpIG5vdDxicj4K
Jmd0OyBmb3VuZCBpbiBzZWFyY2ggaW4gc2NvcGUgWyZxdW90O1wmcXVvdDsgXSAweGI1NGRlYyBm
aXJzdCBjaGlsZCAweDFiMTNjOWMwPGJyPgomZ3Q7IG5zc2VhcmNoLTAyNTYgWzA1XSBOc1NlYXJj
aE9uZVNjb3BlIKAgoCCgOiAtLS0tRXhpdC08YnI+CiZndDsgKioqKkV4Y2VwdGlvbioqKio6IEFF
X05PVF9GT1VORDxicj4KJmd0OyCgbnNhbGxvYy0wMTUwIFswNV0gTnNDcmVhdGVOb2RlIKAgoCCg
IKAgoDogLS0tLUVudHJ5PGJyPgomZ3Q7IKB1dGFsbG9jLTA0MjMgWzA2XSBVdEFsbG9jYXRlIKAg
oCCgIKAgoCCgOiAtLS0tRW50cnkgMDAwMDAwMTQ8YnI+CiZndDsgoHV0YWxsb2MtMDQ0NiBbMDZd
IFV0QWxsb2NhdGUgoCCgIKAgoCCgIKA6IC0tLS1FeGl0LSAweDFiMWE4N2Q0PGJyPgomZ3Q7IKBu
c2FsbG9jLTAxNzIgWzA1XSBOc0NyZWF0ZU5vZGUgoCCgIKAgoCCgOiAtLS0tRXhpdC0gMHgxYjFh
ODdkNDxicj4KJmd0OyCgbnNhbGxvYy0wMzM2IFswNV0gTnNJbnN0YWxsTm9kZSCgIKAgoCCgIDog
LS0tLUVudHJ5PGJyPgomZ3Q7IKBuc2FsbG9jLTAzODIgWzA1XSBOc0luc3RhbGxOb2RlIKAgoCCg
IKAgOiBfU0JfIChEZXZpY2UpIFtOb2RlPGJyPgomZ3Q7IDB4MWIxYTg3ZDQgT3duZXIgMF0gYWRk
ZWQgdG8gJnF1b3Q7XCZxdW90OyCgKERldmljZSkgW05vZGUgMHhiNTRkZWNdPGJyPgomZ3Q7IKBu
c2FsbG9jLTAzODQgWzA1XSBOc0luc3RhbGxOb2RlIKAgoCCgIKAgOiAtLS0tRXhpdC08YnI+CiZn
dDsgbnNzZWFyY2gtMDUwNSBbMDRdIE5zU2VhcmNoQW5kRW50ZXIgoCCgIKA6IC0tLS1FeGl0LSBB
RV9PSzxicj4KJmd0OyBuc2FjY2Vzcy0wNzcwIFswM10gTnNMb29rdXAgoCCgIKAgoCCgIKAgoDog
LS0tLUV4aXQtIEFFX09LPGJyPgomZ3Q7IG5zYWNjZXNzLTAzOTAgWzAzXSBOc0xvb2t1cCCgIKAg
oCCgIKAgoCCgOiAtLS0tRW50cnk8YnI+CiZndDsgbnNhY2Nlc3MtMDQxNCBbMDNdIE5zTG9va3Vw
IKAgoCCgIKAgoCCgIKA6IE51bGwgc2NvcGUgcHJlZml4LCB1c2luZzxicj4KJmd0OyByb290IG5v
ZGUgKDB4YjU0ZGVjKTxicj4KJmd0OyBuc2FjY2Vzcy0wNDk2IFswM10gTnNMb29rdXAgoCCgIKAg
oCCgIKAgoDogU2VhcmNoaW5nIHJlbGF0aXZlIHRvPGJyPgomZ3Q7IHByZWZpeCBzY29wZSBbJnF1
b3Q7XCZxdW90OyBdICgweGI1NGRlYyk8YnI+CiZndDsgbnNhY2Nlc3MtMDYwNyBbMDNdIE5zTG9v
a3VwIKAgoCCgIKAgoCCgIKA6IFNpbXBsZSBQYXRobmFtZSAoMSBzZWdtZW50LDxicj4KJmd0OyBG
bGFncz0wKTxicj4KJmd0OyCgIG5zZHVtcC0wMTc1IFswM10gTnNQcmludFBhdGhuYW1lIKAgoCCg
IDogW19TSV9dPGJyPgomZ3Q7IG5zc2VhcmNoLTAzOTIgWzA0XSBOc1NlYXJjaEFuZEVudGVyIKAg
oCCgOiAtLS0tRW50cnk8YnI+CiZndDsgbnNzZWFyY2gtMDE4MSBbMDVdIE5zU2VhcmNoT25lU2Nv
cGUgoCCgIKA6IC0tLS1FbnRyeTxicj4KJmd0OyCgbnNuYW1lcy0wMjI4IFswNl0gTnNHZXRFeHRl
cm5hbFBhdGhuYW1lIDogLS0tLUVudHJ5IDB4YjU0ZGVjPGJyPgomZ3Q7IKB1dGFsbG9jLTA0MjMg
WzA3XSBVdEFsbG9jYXRlIKAgoCCgIKAgoCCgOiAtLS0tRW50cnkgMDAwMDAwMDI8YnI+CiZndDsg
oHV0YWxsb2MtMDQ0NiBbMDddIFV0QWxsb2NhdGUgoCCgIKAgoCCgIKA6IC0tLS1FeGl0LSAweDFi
MWE4N2IwPGJyPgomZ3Q7IKBuc25hbWVzLTAyNTcgWzA2XSBOc0dldEV4dGVybmFsUGF0aG5hbWUg
OiAtLS0tRXhpdC0gMHgxYjFhODdiMDxicj4KJmd0OyBuc3NlYXJjaC0wMTk1IFswNV0gTnNTZWFy
Y2hPbmVTY29wZSCgIKAgoDogU2VhcmNoaW5nIFwgKDB4YjU0ZGVjKSBGb3I8YnI+CiZndDsgW19T
SV9dIChTY29wZSk8YnI+CiZndDsgbnNzZWFyY2gtMDI1NCBbMDVdIE5zU2VhcmNoT25lU2NvcGUg
oCCgIKA6IE5hbWUgW19TSV9dIChTY29wZSkgbm90PGJyPgomZ3Q7IGZvdW5kIGluIHNlYXJjaCBp
biBzY29wZSBbJnF1b3Q7XCZxdW90OyBdIDB4YjU0ZGVjIGZpcnN0IGNoaWxkIDB4MWIxM2M5YzA8
YnI+CiZndDsgbnNzZWFyY2gtMDI1NiBbMDVdIE5zU2VhcmNoT25lU2NvcGUgoCCgIKA6IC0tLS1F
eGl0LTxicj4KJmd0OyAqKioqRXhjZXB0aW9uKioqKjogQUVfTk9UX0ZPVU5EPGJyPgomZ3Q7IKBu
c2FsbG9jLTAxNTAgWzA1XSBOc0NyZWF0ZU5vZGUgoCCgIKAgoCCgOiAtLS0tRW50cnk8YnI+CiZn
dDsgoHV0YWxsb2MtMDQyMyBbMDZdIFV0QWxsb2NhdGUgoCCgIKAgoCCgIKA6IC0tLS1FbnRyeSAw
MDAwMDAxNDxicj4KJmd0OyCgdXRhbGxvYy0wNDQ2IFswNl0gVXRBbGxvY2F0ZSCgIKAgoCCgIKAg
oDogLS0tLUV4aXQtIDB4MWIxYTg3YTA8YnI+CiZndDsgoG5zYWxsb2MtMDE3MiBbMDVdIE5zQ3Jl
YXRlTm9kZSCgIKAgoCCgIKA6IC0tLS1FeGl0LSAweDFiMWE4N2EwPGJyPgomZ3Q7IKBuc2FsbG9j
LTAzMzYgWzA1XSBOc0luc3RhbGxOb2RlIKAgoCCgIKAgOiAtLS0tRW50cnk8YnI+CiZndDsgoG5z
YWxsb2MtMDM4MiBbMDVdIE5zSW5zdGFsbE5vZGUgoCCgIKAgoCA6IF9TSV8gKFNjb3BlKSBbTm9k
ZTxicj4KJmd0OyAweDFiMWE4N2EwIE93bmVyIDBdIGFkZGVkIHRvICZxdW90O1wmcXVvdDsgoChE
ZXZpY2UpIFtOb2RlIDB4YjU0ZGVjXTxicj4KJmd0OyCgbnNhbGxvYy0wMzg0IFswNV0gTnNJbnN0
YWxsTm9kZSCgIKAgoCCgIDogLS0tLUV4aXQtPGJyPgomZ3Q7IG5zc2VhcmNoLTA1MDUgWzA0XSBO
c1NlYXJjaEFuZEVudGVyIKAgoCCgOiAtLS0tRXhpdC0gQUVfT0s8YnI+CiZndDsgbnNhY2Nlc3Mt
MDc3MCBbMDNdIE5zTG9va3VwIKAgoCCgIKAgoCCgIKA6IC0tLS1FeGl0LSBBRV9PSzxicj4KJmd0
OyBuc2FjY2Vzcy0wMzkwIFswM10gTnNMb29rdXAgoCCgIKAgoCCgIKAgoDogLS0tLUVudHJ5PGJy
PgomZ3Q7IG5zYWNjZXNzLTA0MTQgWzAzXSBOc0xvb2t1cCCgIKAgoCCgIKAgoCCgOiBOdWxsIHNj
b3BlIHByZWZpeCwgdXNpbmc8YnI+CiZndDsgcm9vdCBub2RlICgweGI1NGRlYyk8YnI+CiZndDsg
bnNhY2Nlc3MtMDQ5NiBbMDNdIE5zTG9va3VwIKAgoCCgIKAgoCCgIKA6IFNlYXJjaGluZyByZWxh
dGl2ZSB0bzxicj4KJmd0OyBwcmVmaXggc2NvcGUgWyZxdW90O1wmcXVvdDsgXSAoMHhiNTRkZWMp
PGJyPgomZ3Q7IG5zYWNjZXNzLTA2MDcgWzAzXSBOc0xvb2t1cCCgIKAgoCCgIKAgoCCgOiBTaW1w
bGUgUGF0aG5hbWUgKDEgc2VnbWVudCw8YnI+CiZndDsgRmxhZ3M9MCk8YnI+CiZndDsgoCBuc2R1
bXAtMDE3NSBbMDNdIE5zUHJpbnRQYXRobmFtZSCgIKAgoCA6IFtfVFpfXTxicj4KJmd0OyBuc3Nl
YXJjaC0wMzkyIFswNF0gTnNTZWFyY2hBbmRFbnRlciCgIKAgoDogLS0tLUVudHJ5PGJyPgomZ3Q7
IG5zc2VhcmNoLTAxODEgWzA1XSBOc1NlYXJjaE9uZVNjb3BlIKAgoCCgOiAtLS0tRW50cnk8YnI+
CiZndDsgoG5zbmFtZXMtMDIyOCBbMDZdIE5zR2V0RXh0ZXJuYWxQYXRobmFtZSA6IC0tLS1FbnRy
eSAweGI1NGRlYzxicj4KJmd0OyCgdXRhbGxvYy0wNDIzIFswN10gVXRBbGxvY2F0ZSCgIKAgoCCg
IKAgoDogLS0tLUVudHJ5IDAwMDAwMDAyPGJyPgomZ3Q7IKB1dGFsbG9jLTA0NDYgWzA3XSBVdEFs
bG9jYXRlIKAgoCCgIKAgoCCgOiAtLS0tRXhpdC0gMHgxYjFhODc3Yzxicj4KJmd0OyCgbnNuYW1l
cy0wMjU3IFswNl0gTnNHZXRFeHRlcm5hbFBhdGhuYW1lIDogLS0tLUV4aXQtIDB4MWIxYTg3N2M8
YnI+CiZndDsgbnNzZWFyY2gtMDE5NSBbMDVdIE5zU2VhcmNoT25lU2NvcGUgoCCgIKA6IFNlYXJj
aGluZyBcICgweGI1NGRlYykgRm9yPGJyPgomZ3Q7IFtfVFpfXSAoVGhlcm1hbCk8YnI+CiZndDsg
bnNzZWFyY2gtMDI1NCBbMDVdIE5zU2VhcmNoT25lU2NvcGUgoCCgIKA6IE5hbWUgW19UWl9dIChU
aGVybWFsKSBub3Q8YnI+CiZndDsgZm91bmQgaW4gc2VhcmNoIGluIHNjb3BlIFsmcXVvdDtcJnF1
b3Q7IF0gMHhiNTRkZWMgZmlyc3QgY2hpbGQgMHgxYjEzYzljMDxicj4KJmd0OyBuc3NlYXJjaC0w
MjU2IFswNV0gTnNTZWFyY2hPbmVTY29wZSCgIKAgoDogLS0tLUV4aXQtPGJyPgomZ3Q7ICoqKipF
eGNlcHRpb24qKioqOiBBRV9OT1RfRk9VTkQ8YnI+CiZndDsgoG5zYWxsb2MtMDE1MCBbMDVdIE5z
Q3JlYXRlTm9kZSCgIKAgoCCgIKA6IC0tLS1FbnRyeTxicj4KJmd0OyCgdXRhbGxvYy0wNDIzIFsw
Nl0gVXRBbGxvY2F0ZSCgIKAgoCCgIKAgoDogLS0tLUVudHJ5IDAwMDAwMDE0PGJyPgomZ3Q7IKB1
dGFsbG9jLTA0NDYgWzA2XSBVdEFsbG9jYXRlIKAgoCCgIKAgoCCgOiAtLS0tRXhpdC0gMHgxYjFh
ODc2Yzxicj4KJmd0OyCgbnNhbGxvYy0wMTcyIFswNV0gTnNDcmVhdGVOb2RlIKAgoCCgIKAgoDog
LS0tLUV4aXQtIDB4MWIxYTg3NmM8YnI+CiZndDsgoG5zYWxsb2MtMDMzNiBbMDVdIE5zSW5zdGFs
bE5vZGUgoCCgIKAgoCA6IC0tLS1FbnRyeTxicj4KJmd0OyCgbnNhbGxvYy0wMzgyIFswNV0gTnNJ
bnN0YWxsTm9kZSCgIKAgoCCgIDogX1RaXyAoVGhlcm1hbCkgW05vZGU8YnI+CiZndDsgMHgxYjFh
ODc2YyBPd25lciAwXSBhZGRlZCB0byAmcXVvdDtcJnF1b3Q7IKAoRGV2aWNlKSBbTm9kZSAweGI1
NGRlY108YnI+CiZndDsgoG5zYWxsb2MtMDM4NCBbMDVdIE5zSW5zdGFsbE5vZGUgoCCgIKAgoCA6
IC0tLS1FeGl0LTxicj4KJmd0OyBuc3NlYXJjaC0wNTA1IFswNF0gTnNTZWFyY2hBbmRFbnRlciCg
IKAgoDogLS0tLUV4aXQtIEFFX09LPGJyPgomZ3Q7IG5zYWNjZXNzLTA3NzAgWzAzXSBOc0xvb2t1
cCCgIKAgoCCgIKAgoCCgOiAtLS0tRXhpdC0gQUVfT0s8YnI+CiZndDsgbnNhY2Nlc3MtMDM5MCBb
MDNdIE5zTG9va3VwIKAgoCCgIKAgoCCgIKA6IC0tLS1FbnRyeTxicj4KJmd0OyBuc2FjY2Vzcy0w
NDE0IFswM10gTnNMb29rdXAgoCCgIKAgoCCgIKAgoDogTnVsbCBzY29wZSBwcmVmaXgsIHVzaW5n
PGJyPgomZ3Q7IHJvb3Qgbm9kZSAoMHhiNTRkZWMpPGJyPgomZ3Q7IG5zYWNjZXNzLTA0OTYgWzAz
XSBOc0xvb2t1cCCgIKAgoCCgIKAgoCCgOiBTZWFyY2hpbmcgcmVsYXRpdmUgdG88YnI+CiZndDsg
cHJlZml4IHNjb3BlIFsmcXVvdDtcJnF1b3Q7IF0gKDB4YjU0ZGVjKTxicj4KJmd0OyBuc2FjY2Vz
cy0wNjA3IFswM10gTnNMb29rdXAgoCCgIKAgoCCgIKAgoDogU2ltcGxlIFBhdGhuYW1lICgxIHNl
Z21lbnQsPGJyPgomZ3Q7IEZsYWdzPTApPGJyPgomZ3Q7IKAgbnNkdW1wLTAxNzUgWzAzXSBOc1By
aW50UGF0aG5hbWUgoCCgIKAgOiBbX1JFVl08YnI+CiZndDsgbnNzZWFyY2gtMDM5MiBbMDRdIE5z
U2VhcmNoQW5kRW50ZXIgoCCgIKA6IC0tLS1FbnRyeTxicj4KJmd0OyBuc3NlYXJjaC0wMTgxIFsw
NV0gTnNTZWFyY2hPbmVTY29wZSCgIKAgoDogLS0tLUVudHJ5PGJyPgomZ3Q7IKBuc25hbWVzLTAy
MjggWzA2XSBOc0dldEV4dGVybmFsUGF0aG5hbWUgOiAtLS0tRW50cnkgMHhiNTRkZWM8YnI+CiZn
dDsgoHV0YWxsb2MtMDQyMyBbMDddIFV0QWxsb2NhdGUgoCCgIKAgoCCgIKA6IC0tLS1FbnRyeSAw
MDAwMDAwMjxicj4KJmd0OyCgdXRhbGxvYy0wNDQ2IFswN10gVXRBbGxvY2F0ZSCgIKAgoCCgIKAg
oDogLS0tLUV4aXQtIDB4MWIxYTg3NDg8YnI+CiZndDsgoG5zbmFtZXMtMDI1NyBbMDZdIE5zR2V0
RXh0ZXJuYWxQYXRobmFtZSA6IC0tLS1FeGl0LSAweDFiMWE4NzQ4PGJyPgomZ3Q7IG5zc2VhcmNo
LTAxOTUgWzA1XSBOc1NlYXJjaE9uZVNjb3BlIKAgoCCgOiBTZWFyY2hpbmcgXCAoMHhiNTRkZWMp
IEZvcjxicj4KJmd0OyBbX1JFVl0gKEludGVnZXIpPGJyPgomZ3Q7IG5zc2VhcmNoLTAyNTQgWzA1
XSBOc1NlYXJjaE9uZVNjb3BlIKAgoCCgOiBOYW1lIFtfUkVWXSAoSW50ZWdlcikgbm90PGJyPgom
Z3Q7IGZvdW5kIGluIHNlYXJjaCBpbiBzY29wZSBbJnF1b3Q7XCZxdW90OyBdIDB4YjU0ZGVjIGZp
cnN0IGNoaWxkIDB4MWIxM2M5YzA8YnI+CiZndDsgbnNzZWFyY2gtMDI1NiBbMDVdIE5zU2VhcmNo
T25lU2NvcGUgoCCgIKA6IC0tLS1FeGl0LTxicj4KJmd0OyAqKioqRXhjZXB0aW9uKioqKjogQUVf
Tk9UX0ZPVU5EPGJyPgomZ3Q7IKBuc2FsbG9jLTAxNTAgWzA1XSBOc0NyZWF0ZU5vZGUgoCCgIKAg
oCCgOiAtLS0tRW50cnk8YnI+CiZndDsgoHV0YWxsb2MtMDQyMyBbMDZdIFV0QWxsb2NhdGUgoCCg
IKAgoCCgIKA6IC0tLS1FbnRyeSAwMDAwMDAxNDxicj4KJmd0OyCgdXRhbGxvYy0wNDQ2IFswNl0g
VXRBbGxvY2F0ZSCgIKAgoCCgIKAgoDogLS0tLUV4aXQtIDB4MWIxYTg3Mzg8YnI+CiZndDsgoG5z
YWxsb2MtMDE3MiBbMDVdIE5zQ3JlYXRlTm9kZSCgIKAgoCCgIKA6IC0tLS1FeGl0LSAweDFiMWE4
NzM4PGJyPgomZ3Q7IKBuc2FsbG9jLTAzMzYgWzA1XSBOc0luc3RhbGxOb2RlIKAgoCCgIKAgOiAt
LS0tRW50cnk8YnI+CiZndDsgoG5zYWxsb2MtMDM4MiBbMDVdIE5zSW5zdGFsbE5vZGUgoCCgIKAg
oCA6IF9SRVYgKEludGVnZXIpIFtOb2RlPGJyPgomZ3Q7IDB4MWIxYTg3MzggT3duZXIgMF0gYWRk
ZWQgdG8gJnF1b3Q7XCZxdW90OyCgKERldmljZSkgW05vZGUgMHhiNTRkZWNdPGJyPgomZ3Q7IKBu
c2FsbG9jLTAzODQgWzA1XSBOc0luc3RhbGxOb2RlIKAgoCCgIKAgOiAtLS0tRXhpdC08YnI+CiZn
dDsgbnNzZWFyY2gtMDUwNSBbMDRdIE5zU2VhcmNoQW5kRW50ZXIgoCCgIKA6IC0tLS1FeGl0LSBB
RV9PSzxicj4KJmd0OyBuc2FjY2Vzcy0wNzcwIFswM10gTnNMb29rdXAgoCCgIKAgoCCgIKAgoDog
LS0tLUV4aXQtIEFFX09LPGJyPgomZ3Q7IHV0b2JqZWN0LTAxNzkgWzAzXSBVdENyZWF0ZUludGVy
bmFsT2JqZWN0OiAtLS0tRW50cnkgSW50ZWdlcjxicj4KJmd0OyB1dG9iamVjdC0wNTA2IFswNF0g
VXRBbGxvY2F0ZU9iamVjdERlc2NEYjogLS0tLUVudHJ5PGJyPgomZ3Q7IKB1dGFsbG9jLTA0MjMg
WzA1XSBVdEFsbG9jYXRlIKAgoCCgIKAgoCCgOiAtLS0tRW50cnkgMDAwMDAwMjg8YnI+CiZndDsg
oHV0YWxsb2MtMDQ0NiBbMDVdIFV0QWxsb2NhdGUgoCCgIKAgoCCgIKA6IC0tLS1FeGl0LSAweDFi
MWE4NmU4PGJyPgomZ3Q7IHV0b2JqZWN0LTA1MjMgWzA0XSBVdEFsbG9jYXRlT2JqZWN0RGVzY0Ri
OiAweDFiMWE4NmU4IFNpemUgMjg8YnI+CiZndDsgdXRvYmplY3QtMDUyNSBbMDRdIFV0QWxsb2Nh
dGVPYmplY3REZXNjRGI6IC0tLS1FeGl0LSAweDFiMWE4NmU4PGJyPgomZ3Q7IHV0b2JqZWN0LTAy
MjkgWzAzXSBVdENyZWF0ZUludGVybmFsT2JqZWN0OiAtLS0tRXhpdC0gMHgxYjFhODZlODxicj4K
Jmd0OyBuc29iamVjdC0wMTYxIFswM10gTnNBdHRhY2hPYmplY3QgoCCgIKAgoDogLS0tLUVudHJ5
PGJyPgomZ3Q7IG5zb2JqZWN0LTAyNDEgWzAzXSBOc0F0dGFjaE9iamVjdCCgIKAgoCCgOiBJbnN0
YWxsaW5nIDB4MWIxYTg2ZTggaW50bzxicj4KJmd0OyBOb2RlIDB4MWIxYTg3MzggW19SRVZdPGJy
PgomZ3Q7IHV0ZGVsZXRlLTA3NTUgWzA0XSBVdEFkZFJlZmVyZW5jZSCgIKAgoCCgOiAtLS0tRW50
cnkgMHgxYjFhODZlODxicj4KJmd0OyB1dGRlbGV0ZS0wNzY3IFswNF0gVXRBZGRSZWZlcmVuY2Ug
oCCgIKAgoDogT2JqIDB4MWIxYTg2ZTggQ3VycmVudDxicj4KJmd0OyBSZWZzPTEgW1RvIEJlIElu
Y3JlbWVudGVkXTxicj4KJmd0OyB1dGRlbGV0ZS0wNTkyIFswNV0gVXRVcGRhdGVPYmplY3RSZWZl
cmVuYzogLS0tLUVudHJ5IDB4MWIxYTg2ZTg8YnI+CiZndDsgdXRkZWxldGUtMDQ5NSBbMDVdIFV0
VXBkYXRlUmVmQ291bnQgoCCgIKA6IE9iaiAweDFiMWE4NmU4IFJlZnM9Miw8YnI+CiZndDsgW0lu
Y3JlbWVudGVkXTxicj4KJmd0OyB1dGRlbGV0ZS0wNzE3IFswNV0gVXRVcGRhdGVPYmplY3RSZWZl
cmVuYzogLS0tLUV4aXQtIEFFX09LPGJyPgomZ3Q7IHV0ZGVsZXRlLTA3NzIgWzA0XSBVdEFkZFJl
ZmVyZW5jZSCgIKAgoCCgOiAtLS0tRXhpdC08YnI+CiZndDsgbnNvYmplY3QtMDI3NiBbMDNdIE5z
QXR0YWNoT2JqZWN0IKAgoCCgIKA6IC0tLS1FeGl0LSBBRV9PSzxicj4KJmd0OyB1dGRlbGV0ZS0w
NzkzIFswM10gVXRSZW1vdmVSZWZlcmVuY2UgoCCgIDogLS0tLUVudHJ5IDB4MWIxYTg2ZTg8YnI+
CiZndDsgdXRkZWxldGUtMDgxNyBbMDNdIFV0UmVtb3ZlUmVmZXJlbmNlIKAgoCA6IE9iaiAweDFi
MWE4NmU4IEN1cnJlbnQ8YnI+CiZndDsgUmVmcz0yIFtUbyBCZSBEZWNyZW1lbnRlZF08YnI+CiZn
dDsgdXRkZWxldGUtMDU5MiBbMDRdIFV0VXBkYXRlT2JqZWN0UmVmZXJlbmM6IC0tLS1FbnRyeSAw
eDFiMWE4NmU4PGJyPgomZ3Q7IHV0ZGVsZXRlLTA1MTQgWzA0XSBVdFVwZGF0ZVJlZkNvdW50IKAg
oCCgOiBPYmogMHgxYjFhODZlOCBSZWZzPTEsPGJyPgomZ3Q7IFtEZWNyZW1lbnRlZF08YnI+CiZn
dDsgdXRkZWxldGUtMDcxNyBbMDRdIFV0VXBkYXRlT2JqZWN0UmVmZXJlbmM6IC0tLS1FeGl0LSBB
RV9PSzxicj4KJmd0OyB1dGRlbGV0ZS0wODI1IFswM10gVXRSZW1vdmVSZWZlcmVuY2UgoCCgIDog
LS0tLUV4aXQtPGJyPgomZ3Q7IG5zYWNjZXNzLTAzOTAgWzAzXSBOc0xvb2t1cCCgIKAgoCCgIKAg
oCCgOiAtLS0tRW50cnk8YnI+CiZndDsgbnNhY2Nlc3MtMDQxNCBbMDNdIE5zTG9va3VwIKAgoCCg
IKAgoCCgIKA6IE51bGwgc2NvcGUgcHJlZml4LCB1c2luZzxicj4KJmd0OyByb290IG5vZGUgKDB4
YjU0ZGVjKTxicj4KJmd0OyBuc2FjY2Vzcy0wNDk2IFswM10gTnNMb29rdXAgoCCgIKAgoCCgIKAg
oDogU2VhcmNoaW5nIHJlbGF0aXZlIHRvPGJyPgomZ3Q7IHByZWZpeCBzY29wZSBbJnF1b3Q7XCZx
dW90OyBdICgweGI1NGRlYyk8YnI+CiZndDsgbnNhY2Nlc3MtMDYwNyBbMDNdIE5zTG9va3VwIKAg
oCCgIKAgoCCgIKA6IFNpbXBsZSBQYXRobmFtZSAoMSBzZWdtZW50LDxicj4KJmd0OyBGbGFncz0w
KTxicj4KJmd0OyCgIG5zZHVtcC0wMTc1IFswM10gTnNQcmludFBhdGhuYW1lIKAgoCCgIDogW19P
U19dPGJyPgomZ3Q7IG5zc2VhcmNoLTAzOTIgWzA0XSBOc1NlYXJjaEFuZEVudGVyIKAgoCCgOiAt
LS0tRW50cnk8YnI+CiZndDsgbnNzZWFyY2gtMDE4MSBbMDVdIE5zU2VhcmNoT25lU2NvcGUgoCCg
IKA6IC0tLS1FbnRyeTxicj4KJmd0OyCgbnNuYW1lcy0wMjI4IFswNl0gTnNHZXRFeHRlcm5hbFBh
dGhuYW1lIDogLS0tLUVudHJ5IDB4YjU0ZGVjPGJyPgomZ3Q7IKB1dGFsbG9jLTA0MjMgWzA3XSBV
dEFsbG9jYXRlIKAgoCCgIKAgoCCgOiAtLS0tRW50cnkgMDAwMDAwMDI8YnI+CiZndDsgoHV0YWxs
b2MtMDQ0NiBbMDddIFV0QWxsb2NhdGUgoCCgIKAgoCCgIKA6IC0tLS1FeGl0LSAweDFiMWE4Y2Mw
PGJyPgomZ3Q7IKBuc25hbWVzLTAyNTcgWzA2XSBOc0dldEV4dGVybmFsUGF0aG5hbWUgOiAtLS0t
RXhpdC0gMHgxYjFhOGNjMDxicj4KJmd0OyBuc3NlYXJjaC0wMTk1IFswNV0gTnNTZWFyY2hPbmVT
Y29wZSCgIKAgoDogU2VhcmNoaW5nIFwgKDB4YjU0ZGVjKSBGb3I8YnI+CiZndDsgW19PU19dIChT
dHJpbmcpPGJyPgomZ3Q7IG5zc2VhcmNoLTAyNTQgWzA1XSBOc1NlYXJjaE9uZVNjb3BlIKAgoCCg
OiBOYW1lIFtfT1NfXSAoU3RyaW5nKSBub3Q8YnI+CiZndDsgZm91bmQgaW4gc2VhcmNoIGluIHNj
b3BlIFsmcXVvdDtcJnF1b3Q7IF0gMHhiNTRkZWMgZmlyc3QgY2hpbGQgMHgxYjEzYzljMDxicj4K
Jmd0OyBuc3NlYXJjaC0wMjU2IFswNV0gTnNTZWFyY2hPbmVTY29wZSCgIKAgoDogLS0tLUV4aXQt
PGJyPgomZ3Q7ICoqKipFeGNlcHRpb24qKioqOiBBRV9OT1RfRk9VTkQ8YnI+CiZndDsgoG5zYWxs
b2MtMDE1MCBbMDVdIE5zQ3JlYXRlTm9kZSCgIKAgoCCgIKA6IC0tLS1FbnRyeTxicj4KJmd0OyCg
dXRhbGxvYy0wNDIzIFswNl0gVXRBbGxvY2F0ZSCgIKAgoCCgIKAgoDogLS0tLUVudHJ5IDAwMDAw
MDE0PGJyPgomZ3Q7IKB1dGFsbG9jLTA0NDYgWzA2XSBVdEFsbG9jYXRlIKAgoCCgIKAgoCCgOiAt
LS0tRXhpdC0gMHgxYjFhOGNiMDxicj4KJmd0OyCgbnNhbGxvYy0wMTcyIFswNV0gTnNDcmVhdGVO
b2RlIKAgoCCgIKAgoDogLS0tLUV4aXQtIDB4MWIxYThjYjA8YnI+CiZndDsgoG5zYWxsb2MtMDMz
NiBbMDVdIE5zSW5zdGFsbE5vZGUgoCCgIKAgoCA6IC0tLS1FbnRyeTxicj4KJmd0OyCgbnNhbGxv
Yy0wMzgyIFswNV0gTnNJbnN0YWxsTm9kZSCgIKAgoCCgIDogX09TXyAoU3RyaW5nKSBbTm9kZTxi
cj4KJmd0OyAweDFiMWE4Y2IwIE93bmVyIDBdIGFkZGVkIHRvICZxdW90O1wmcXVvdDsgoChEZXZp
Y2UpIFtOb2RlIDB4YjU0ZGVjXTxicj4KJmd0OyCgbnNhbGxvYy0wMzg0IFswNV0gTnNJbnN0YWxs
Tm9kZSCgIKAgoCCgIDogLS0tLUV4aXQtPGJyPgomZ3Q7IG5zc2VhcmNoLTA1MDUgWzA0XSBOc1Nl
YXJjaEFuZEVudGVyIKAgoCCgOiAtLS0tRXhpdC0gQUVfT0s8YnI+CiZndDsgbnNhY2Nlc3MtMDc3
MCBbMDNdIE5zTG9va3VwIKAgoCCgIKAgoCCgIKA6IC0tLS1FeGl0LSBBRV9PSzxicj4KJmd0OyB1
dG9iamVjdC0wMTc5IFswM10gVXRDcmVhdGVJbnRlcm5hbE9iamVjdDogLS0tLUVudHJ5IFN0cmlu
Zzxicj4KJmd0OyB1dG9iamVjdC0wNTA2IFswNF0gVXRBbGxvY2F0ZU9iamVjdERlc2NEYjogLS0t
LUVudHJ5PGJyPgomZ3Q7IKB1dGFsbG9jLTA0MjMgWzA1XSBVdEFsbG9jYXRlIKAgoCCgIKAgoCCg
OiAtLS0tRW50cnkgMDxicj4KJmd0Ozxicj4KJmd0Ozxicj4KJmd0Ozxicj4KJmd0OyBPbiBUdWUs
IEp1bCA2LCAyMDEwIGF0IDEwOjM3IEFNLCBaaGFuZyBSdWkgJmx0OzxhIGhyZWY9Im1haWx0bzpy
dWkuemhhbmdAaW50ZWwuY29tIj5ydWkuemhhbmdAaW50ZWwuY29tPC9hPiZndDs8YnI+CiZndDsg
d3JvdGU6PGJyPgomZ3Q7PGJyPgomZ3Q7IKAgoCCgIKAgT24gVHVlLCAyMDEwLTA3LTA2IGF0IDEw
OjI5ICswODAwLCBTZWFuIFNob3VmdSBMdW8gd3JvdGU6PGJyPgomZ3Q7IKAgoCCgIKAgJmd0OyBQ
cmV2aW91c2x5LCBJIGhhdmUgcG9ydGVkIEFDUElDQSB0byBvdXIgc3lzdGVtLiBUaGVzZSBkYXlz
LDxicj4KJmd0OyCgIKAgoCCgIEkgd29ubmEgdG88YnI+CiZndDsgoCCgIKAgoCAmZ3Q7IHdyaXRl
IEFDUEkgZHJpdmVyIGZvciBiYXR0ZXJ5IHdpdGggTmV0YnNkJiMzOTtzIHZlcnNpb24gYXM8YnI+
CiZndDsgoCCgIKAgoCBndWlkZSwgYnV0IEk8YnI+CiZndDsgoCCgIKAgoCAmZ3Q7IGZvdW5kIHdo
ZW4gSSBpbml0aWFsaXplZCBiYXR0ZXJ5IGRyaXZlciwgaXQgd291bGQgaXNzdWUgYTxicj4KJmd0
OyCgIKAgoCCgIGNvbW1hbmQgdG88YnI+CiZndDsgoCCgIKAgoCAmZ3Q7IHF1ZXJ5IF9TVEEgZm9y
IGJhdHRlcnkgcHJlc2VuY2UuIEJ1dCBpdHMgcmV0dXJuIHZhbHVlIGlzPGJyPgomZ3Q7IKAgoCCg
IKAgMHhmLCB0aGF0PGJyPgomZ3Q7IKAgoCCgIKAgJmd0OyBpbmRpY2F0ZXMgUFJFU0VOQ0UgYml0
IGlzIG5vdCBzZXQgKDB4MDAwMDAwMTApLiCgSSYjMzk7bTxicj4KJmd0OyCgIKAgoCCgIHB1enps
ZWQuIEkmIzM5O208YnI+CiZndDsgoCCgIKAgoCAmZ3Q7IHVzaW5nIGJhdHRlcnkgLi4uLldoeSB0
aGUgYmF0dGVyeSBub3QgcHJlc2VudD88YnI+CiZndDsgoCCgIKAgoCAmZ3Q7IEFueW9uZSBjYW4g
Z2l2ZSBhbnkgaGludD88YnI+CiZndDsgoCCgIKAgoCAmZ3Q7PGJyPgomZ3Q7PGJyPgomZ3Q7IKAg
oCCgIKAgcGxlYXNlIGF0dGFjaCB0aGUgYWNwaWR1bXAgb3V0cHV0IG9mIHRoaXMgbWFjaGluZS48
YnI+CiZndDs8YnI+CiZndDsgoCCgIKAgoCB0aGFua3MsPGJyPgomZ3Q7IKAgoCCgIKAgcnVpPGJy
PgomZ3Q7PGJyPgomZ3Q7PGJyPgomZ3Q7PGJyPgomZ3Q7PGJyPgo8YnI+Cjxicj4KPC9kaXY+PC9k
aXY+PC9ibG9ja3F1b3RlPjwvZGl2Pjxicj4K

--===============7513858923476823771==--

