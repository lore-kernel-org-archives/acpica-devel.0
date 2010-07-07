Content-Type: multipart/mixed; boundary="===============1617258394805263102=="
MIME-Version: 1.0
From: Zhang Rui <rui.zhang at intel.com>
Subject: Re: [Devel] Battery Presence
Date: Wed, 07 Jul 2010 15:57:37 +0800
Message-ID: <1278489457.4537.8255.camel@rzhang1-desktop>
In-Reply-To: AANLkTinwInMnIsuZaaXSZBsLOaZexVlGeDv_fqOHOZ3H@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1617258394805263102==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

hmm, how did you get the battery status if you can not boot with ACPI
enabled?

thanks,
rui

On Tue, 2010-07-06 at 13:47 +0800, Sean Shoufu Luo wrote:
> Yes, i'm trying .... but now, in my mobile client, it seems, something
> else wrong when enable ACPI sub system
> I set ACPI_LV_ALL for debug, and it give me such output, and then
> system hang. ......................... any idea?
> =

> =

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
> nsaccess-0182 [02] NsRootInitialize      : Entering predefined entries
> into namespace
> nsaccess-0390 [03] NsLookup              : ----Entry
> nsaccess-0414 [03] NsLookup              : Null scope prefix, using
> root node (0xb54dec)
> nsaccess-0496 [03] NsLookup              : Searching relative to
> prefix scope ["\" ] (0xb54dec)
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
> nssearch-0254 [05] NsSearchOneScope      : Name [_GPE] (Scope) not
> found in search in scope ["\" ] 0xb54dec first child 0x0
> nssearch-0256 [05] NsSearchOneScope      : ----Exit-
> ****Exception****: AE_NOT_FOUND
>  nsalloc-0150 [05] NsCreateNode          : ----Entry
>  utalloc-0423 [06] UtAllocate            : ----Entry 00000014
>  utalloc-0446 [06] UtAllocate            : ----Exit- 0x1b13c9c0
>  nsalloc-0172 [05] NsCreateNode          : ----Exit- 0x1b13c9c0
>  nsalloc-0336 [05] NsInstallNode         : ----Entry
>  nsalloc-0382 [05] NsInstallNode         : _GPE (Scope) [Node
> 0x1b13c9c0 Owner 0] added to "\"  (Device) [Node 0xb54dec]
>  nsalloc-0384 [05] NsInstallNode         : ----Exit-
> nssearch-0505 [04] NsSearchAndEnter      : ----Exit- AE_OK
> nsaccess-0770 [03] NsLookup              : ----Exit- AE_OK
> nsaccess-0390 [03] NsLookup              : ----Entry
> nsaccess-0414 [03] NsLookup              : Null scope prefix, using
> root node (0xb54dec)
> nsaccess-0496 [03] NsLookup              : Searching relative to
> prefix scope ["\" ] (0xb54dec)
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
> nssearch-0254 [05] NsSearchOneScope      : Name [_PR_] (Scope) not
> found in search in scope ["\" ] 0xb54dec first child 0x1b13c9c0
> nssearch-0256 [05] NsSearchOneScope      : ----Exit-
> ****Exception****: AE_NOT_FOUND
>  nsalloc-0150 [05] NsCreateNode          : ----Entry
>  utalloc-0423 [06] UtAllocate            : ----Entry 00000014
>  utalloc-0446 [06] UtAllocate            : ----Exit- 0x1b1a8808
>  nsalloc-0172 [05] NsCreateNode          : ----Exit- 0x1b1a8808
>  nsalloc-0336 [05] NsInstallNode         : ----Entry
>  nsalloc-0382 [05] NsInstallNode         : _PR_ (Scope) [Node
> 0x1b1a8808 Owner 0] added to "\"  (Device) [Node 0xb54dec]
>  nsalloc-0384 [05] NsInstallNode         : ----Exit-
> nssearch-0505 [04] NsSearchAndEnter      : ----Exit- AE_OK
> nsaccess-0770 [03] NsLookup              : ----Exit- AE_OK
> nsaccess-0390 [03] NsLookup              : ----Entry
> nsaccess-0414 [03] NsLookup              : Null scope prefix, using
> root node (0xb54dec)
> nsaccess-0496 [03] NsLookup              : Searching relative to
> prefix scope ["\" ] (0xb54dec)
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
> nssearch-0254 [05] NsSearchOneScope      : Name [_SB_] (Device) not
> found in search in scope ["\" ] 0xb54dec first child 0x1b13c9c0
> nssearch-0256 [05] NsSearchOneScope      : ----Exit-
> ****Exception****: AE_NOT_FOUND
>  nsalloc-0150 [05] NsCreateNode          : ----Entry
>  utalloc-0423 [06] UtAllocate            : ----Entry 00000014
>  utalloc-0446 [06] UtAllocate            : ----Exit- 0x1b1a87d4
>  nsalloc-0172 [05] NsCreateNode          : ----Exit- 0x1b1a87d4
>  nsalloc-0336 [05] NsInstallNode         : ----Entry
>  nsalloc-0382 [05] NsInstallNode         : _SB_ (Device) [Node
> 0x1b1a87d4 Owner 0] added to "\"  (Device) [Node 0xb54dec]
>  nsalloc-0384 [05] NsInstallNode         : ----Exit-
> nssearch-0505 [04] NsSearchAndEnter      : ----Exit- AE_OK
> nsaccess-0770 [03] NsLookup              : ----Exit- AE_OK
> nsaccess-0390 [03] NsLookup              : ----Entry
> nsaccess-0414 [03] NsLookup              : Null scope prefix, using
> root node (0xb54dec)
> nsaccess-0496 [03] NsLookup              : Searching relative to
> prefix scope ["\" ] (0xb54dec)
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
> nssearch-0254 [05] NsSearchOneScope      : Name [_SI_] (Scope) not
> found in search in scope ["\" ] 0xb54dec first child 0x1b13c9c0
> nssearch-0256 [05] NsSearchOneScope      : ----Exit-
> ****Exception****: AE_NOT_FOUND
>  nsalloc-0150 [05] NsCreateNode          : ----Entry
>  utalloc-0423 [06] UtAllocate            : ----Entry 00000014
>  utalloc-0446 [06] UtAllocate            : ----Exit- 0x1b1a87a0
>  nsalloc-0172 [05] NsCreateNode          : ----Exit- 0x1b1a87a0
>  nsalloc-0336 [05] NsInstallNode         : ----Entry
>  nsalloc-0382 [05] NsInstallNode         : _SI_ (Scope) [Node
> 0x1b1a87a0 Owner 0] added to "\"  (Device) [Node 0xb54dec]
>  nsalloc-0384 [05] NsInstallNode         : ----Exit-
> nssearch-0505 [04] NsSearchAndEnter      : ----Exit- AE_OK
> nsaccess-0770 [03] NsLookup              : ----Exit- AE_OK
> nsaccess-0390 [03] NsLookup              : ----Entry
> nsaccess-0414 [03] NsLookup              : Null scope prefix, using
> root node (0xb54dec)
> nsaccess-0496 [03] NsLookup              : Searching relative to
> prefix scope ["\" ] (0xb54dec)
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
> nssearch-0254 [05] NsSearchOneScope      : Name [_TZ_] (Thermal) not
> found in search in scope ["\" ] 0xb54dec first child 0x1b13c9c0
> nssearch-0256 [05] NsSearchOneScope      : ----Exit-
> ****Exception****: AE_NOT_FOUND
>  nsalloc-0150 [05] NsCreateNode          : ----Entry
>  utalloc-0423 [06] UtAllocate            : ----Entry 00000014
>  utalloc-0446 [06] UtAllocate            : ----Exit- 0x1b1a876c
>  nsalloc-0172 [05] NsCreateNode          : ----Exit- 0x1b1a876c
>  nsalloc-0336 [05] NsInstallNode         : ----Entry
>  nsalloc-0382 [05] NsInstallNode         : _TZ_ (Thermal) [Node
> 0x1b1a876c Owner 0] added to "\"  (Device) [Node 0xb54dec]
>  nsalloc-0384 [05] NsInstallNode         : ----Exit-
> nssearch-0505 [04] NsSearchAndEnter      : ----Exit- AE_OK
> nsaccess-0770 [03] NsLookup              : ----Exit- AE_OK
> nsaccess-0390 [03] NsLookup              : ----Entry
> nsaccess-0414 [03] NsLookup              : Null scope prefix, using
> root node (0xb54dec)
> nsaccess-0496 [03] NsLookup              : Searching relative to
> prefix scope ["\" ] (0xb54dec)
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
> nssearch-0254 [05] NsSearchOneScope      : Name [_REV] (Integer) not
> found in search in scope ["\" ] 0xb54dec first child 0x1b13c9c0
> nssearch-0256 [05] NsSearchOneScope      : ----Exit-
> ****Exception****: AE_NOT_FOUND
>  nsalloc-0150 [05] NsCreateNode          : ----Entry
>  utalloc-0423 [06] UtAllocate            : ----Entry 00000014
>  utalloc-0446 [06] UtAllocate            : ----Exit- 0x1b1a8738
>  nsalloc-0172 [05] NsCreateNode          : ----Exit- 0x1b1a8738
>  nsalloc-0336 [05] NsInstallNode         : ----Entry
>  nsalloc-0382 [05] NsInstallNode         : _REV (Integer) [Node
> 0x1b1a8738 Owner 0] added to "\"  (Device) [Node 0xb54dec]
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
> nsobject-0241 [03] NsAttachObject        : Installing 0x1b1a86e8 into
> Node 0x1b1a8738 [_REV]
> utdelete-0755 [04] UtAddReference        : ----Entry 0x1b1a86e8
> utdelete-0767 [04] UtAddReference        : Obj 0x1b1a86e8 Current
> Refs=3D1 [To Be Incremented]
> utdelete-0592 [05] UtUpdateObjectReferenc: ----Entry 0x1b1a86e8
> utdelete-0495 [05] UtUpdateRefCount      : Obj 0x1b1a86e8 Refs=3D2,
> [Incremented]
> utdelete-0717 [05] UtUpdateObjectReferenc: ----Exit- AE_OK
> utdelete-0772 [04] UtAddReference        : ----Exit-
> nsobject-0276 [03] NsAttachObject        : ----Exit- AE_OK
> utdelete-0793 [03] UtRemoveReference     : ----Entry 0x1b1a86e8
> utdelete-0817 [03] UtRemoveReference     : Obj 0x1b1a86e8 Current
> Refs=3D2 [To Be Decremented]
> utdelete-0592 [04] UtUpdateObjectReferenc: ----Entry 0x1b1a86e8
> utdelete-0514 [04] UtUpdateRefCount      : Obj 0x1b1a86e8 Refs=3D1,
> [Decremented]
> utdelete-0717 [04] UtUpdateObjectReferenc: ----Exit- AE_OK
> utdelete-0825 [03] UtRemoveReference     : ----Exit-
> nsaccess-0390 [03] NsLookup              : ----Entry
> nsaccess-0414 [03] NsLookup              : Null scope prefix, using
> root node (0xb54dec)
> nsaccess-0496 [03] NsLookup              : Searching relative to
> prefix scope ["\" ] (0xb54dec)
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
> nssearch-0254 [05] NsSearchOneScope      : Name [_OS_] (String) not
> found in search in scope ["\" ] 0xb54dec first child 0x1b13c9c0
> nssearch-0256 [05] NsSearchOneScope      : ----Exit-
> ****Exception****: AE_NOT_FOUND
>  nsalloc-0150 [05] NsCreateNode          : ----Entry
>  utalloc-0423 [06] UtAllocate            : ----Entry 00000014
>  utalloc-0446 [06] UtAllocate            : ----Exit- 0x1b1a8cb0
>  nsalloc-0172 [05] NsCreateNode          : ----Exit- 0x1b1a8cb0
>  nsalloc-0336 [05] NsInstallNode         : ----Entry
>  nsalloc-0382 [05] NsInstallNode         : _OS_ (String) [Node
> 0x1b1a8cb0 Owner 0] added to "\"  (Device) [Node 0xb54dec]
>  nsalloc-0384 [05] NsInstallNode         : ----Exit-
> nssearch-0505 [04] NsSearchAndEnter      : ----Exit- AE_OK
> nsaccess-0770 [03] NsLookup              : ----Exit- AE_OK
> utobject-0179 [03] UtCreateInternalObject: ----Entry String
> utobject-0506 [04] UtAllocateObjectDescDb: ----Entry
>  utalloc-0423 [05] UtAllocate            : ----Entry 0
> =

> =

> =

> On Tue, Jul 6, 2010 at 10:37 AM, Zhang Rui <rui.zhang(a)intel.com>
> wrote:
>         =

>         On Tue, 2010-07-06 at 10:29 +0800, Sean Shoufu Luo wrote:
>         > Previously, I have ported ACPICA to our system. These days,
>         I wonna to
>         > write ACPI driver for battery with Netbsd's version as
>         guide, but I
>         > found when I initialized battery driver, it would issue a
>         command to
>         > query _STA for battery presence. But its return value is
>         0xf, that
>         > indicates PRESENCE bit is not set (0x00000010).  I'm
>         puzzled. I'm
>         > using battery ....Why the battery not present?
>         > Anyone can give any hint?
>         >
>         =

>         please attach the acpidump output of this machine.
>         =

>         thanks,
>         rui
>         =

>         =

> =

> =




--===============1617258394805263102==--

