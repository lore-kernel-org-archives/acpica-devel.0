Content-Type: multipart/mixed; boundary="===============2532523945163423108=="
MIME-Version: 1.0
From: Samuel Serapion <samcharly at hotmail.com>
Subject: Re: [Devel] Unable to boot in vmware 7
Date: Sat, 06 Mar 2010 17:41:25 -0500
Message-ID: <SNT111-W1357ACB126126C519CE5E6BD370@phx.gbl>
In-Reply-To: 4911F71203A09E4D9981D27F9D83085859DCCA73@orsmsx503.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2532523945163423108==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


I have fixed what might have been bugs in AcpiOsReadPciConfiguration and ad=
ded a dprint for its return value.
Still get an exception and EIP =3D 0. =

Just in case you have some doubts about AcpiOsReadPciConfiguration and you =
have some Windows driver dev nearby here is my implementation:


ACPI_STATUS
AcpiOsReadPciConfiguration (
    ACPI_PCI_ID             *PciId,
    UINT32                  Register,
    void                    *Value,
    UINT32                  Width)
{
    PCI_SLOT_NUMBER slot;
    ULONG result =3D 0;

    if (PciId->Bus >=3D 256 || PciId->Device >=3D 32 || PciId->Function >=
=3D 8)
        return AE_BAD_PARAMETER;

    slot.u.AsULONG =3D 0;
    slot.u.bits.DeviceNumber =3D PciId->Bus;
    slot.u.bits.FunctionNumber =3D PciId->Function;

    DPRINT1("AcpiOsReadPciConfiguration, slot=3D0x%X, func=3D0x%X\n", slot.=
u.AsULONG, Register);
    result =3D HalGetBusDataByOffset(PCIConfiguration,
        PciId->Bus,
        slot.u.AsULONG,
        Value,
        Register,
        Width);

    if(result)
    {
        DPRINT1("AcpiOsReadPciConfiguration returned AE_OK\n");
        return AE_OK;
    }
    else
    {
        DPRINT1("AcpiOsReadPciConfiguration returned AE_ERROR\n");
        return AE_ERROR;
    }
}


Debug log:


(drivers\bus\acpi\main.c:206) Driver Entry
(drivers\bus\acpi\main.c:36) Add Device: 0xB136C6F8
(drivers\bus\acpi\main.c:38) #################### Bus_CreateClose Creating =
FDO Device ####################
(drivers\bus\acpi\main.c:141) AddDevice: B133FEC0 to B136C6F8->B136C6F8 (Ro=
ot\*PNP0C08\0000)
(drivers\bus\acpi\pnp.c:47) FDO IRP_MN_FILTER_RESOURCE_REQUIREMENTS IRP:0xB=
134D5F8
(drivers\bus\acpi\pnp.c:47) FDO IRP_MN_START_DEVICE IRP:0xB134D5F8
ACPI: RSDP 000F6940 00024 (v02 PTLTD )
ACPI: XSDT 1FEF0885 0004C (v01 INTEL  440BX    06040000 VMW  01324272)
ACPI: FACP 1FEFEE98 000F4 (v04 INTEL  440BX    06040000 PTL  000F4240)
ACPI: DSDT 1FEF0A3D 0E45B (v01 PTLTD  Custom   06040000 MSFT 03000001)
ACPI: FACS 1FEFFFC0 00040
ACPI: BOOT 1FEF0A15 00028 (v01 PTLTD  $SBFTBL$ 06040000  LTP 00000001)
ACPI: APIC 1FEF09C5 00050 (v01 PTLTD     APIC   06040000  LTP 00000000)
ACPI: MCFG 1FEF0989 0003C (v01 PTLTD  $PCITBL$ 06040000  LTP 00000001)
ACPI: SRAT 1FEF0909 00080 (v02 VMWARE MEMPLUG  06040000 VMW  00000001)
Parsing all Control Methods:
Table [DSDT](id 0001) - 2794 Objects with 325 Devices 837 Methods 280 Regio=
ns
 tbxface-0601 [02] TbLoadNamespace       : ACPI Tables successfully acquired
(drivers\bus\acpi\pnp.c:306) Acpi subsystem init
(drivers\bus\acpi\busmgr\bus.c:1783) acpi_init(drivers\bus\acpi\busmgr\bus.=
c:1785) Subsystem revision 20100121
(drivers\bus\acpi\busmgr\bus.c:1665) acpi_bus_initevxfevnt-0184 [02] Enable=
                : Transition to ACPI mode successful
evgpeblk-1129 [04] EvCreateGpeBlock      : GPE 00 to 0F [_GPE] 2 regs on in=
t 0x9
Completing Region/Field/Buffer/Package initialization:.....................=
...........................................................................=
...........................................................................=
...........................................................................=
...........................................................................=
...........................................................................=
...........................................................................=
...........................................................................=
...........................................................................=
................................................
Initialized 280/280 Regions 0/0 Fields 26/26 Buffers 363/363 Packages (2803=
 nodes)
Initializing Device/Processor/Thermal objects by executing _INI methods:.(d=
rivers\bus\acpi\osl.c:720) AcpiOsDerivePciId returned 0
(drivers\bus\acpi\osl.c:496) AcpiOsReadPciConfiguration, slot=3D0x60, func=
=3D0x5C
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20100121/ev=
region-588)

**** Exception AE_ERROR during execution of method [\_SB_.PCI0.ISA_._INI] (=
Node B134BA98)

Method Execution Stack:
    Method [_INI] executing: [_INI] @00003 #002D:  ^^PWR.LPTE

Local Variables for method [_INI]:
    Local0: 00000000 <Null Object>
    Local1: 00000000 <Null Object>
    Local2: 00000000 <Null Object>
    Local3: 00000000 <Null Object>
    Local4: 00000000 <Null Object>
    Local5: 00000000 <Null Object>
    Local6: 00000000 <Null Object>
    Local7: 00000000 <Null Object>

Arguments for Method [_INI]:  (0 arguments defined, max concurrency =3D 0)
    Arg0:   00000000 <Null Object>
    Arg1:   00000000 <Null Object>
    Arg2:   00000000 <Null Object>
    Arg3:   00000000 <Null Object>
    Arg4:   00000000 <Null Object>
    Arg5:   00000000 <Null Object>
    Arg6:   00000000 <Null Object>

ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.ISA_._=
INI] (Node B134BA98), AE_ERROR
ACPI Exception: AE_ERROR, during \_SB_.PCI0.ISA_._INI._INI execution (20100=
121/nsinit-708)

Executed 1 _INI methods requiring 0 _STA executions (examined 328 objects)
evgpeblk-1234 [03] EvInitializeGpeBlock  : Found 3 Wake, Enabled 2 Runtime =
GPEs in this block
(drivers\bus\acpi\busmgr\bus.c:1553) acpi_bus_init_irq(drivers\bus\acpi\bus=
mgr\bus.c:1575) Using PIC for interrupt routing
(drivers\bus\acpi\busmgr\utils.c:51) Evaluate [\_SB_._STA]: AE_NOT_FOUND
(drivers\bus\acpi\busmgr\utils.c:51) Evaluate [\_SB_.PCI0._STA]: AE_NOT_FOU=
ND
(drivers\bus\acpi\busmgr\utils.c:51) Evaluate [\_SB_.PCI0.AGP_._STA]: AE_NO=
T_FOUND
(drivers\bus\acpi\busmgr\utils.c:51) Evaluate [\_SB_.PCI0.ISA_._STA]: AE_NO=
T_FOUND
(drivers\bus\acpi\busmgr\utils.c:51) Evaluate [\_SB_.PCI0.ISA_.MBRD._STA]: =
AE_NOT_FOUND
(drivers\bus\acpi\busmgr\utils.c:51) Evaluate [\_SB_.PCI0.ISA_.DMAC._STA]: =
AE_NOT_FOUND
(drivers\bus\acpi\busmgr\utils.c:51) Evaluate [\_SB_.PCI0.ISA_.PIC_._STA]: =
AE_NOT_FOUND
(drivers\bus\acpi\busmgr\utils.c:51) Evaluate [\_SB_.PCI0.ISA_.TIME._STA]: =
AE_NOT_FOUND
(drivers\bus\acpi\busmgr\utils.c:51) Evaluate [\_SB_.PCI0.ISA_.RTC_._STA]: =
AE_NOT_FOUND
(drivers\bus\acpi\busmgr\utils.c:51) Evaluate [\_SB_.PCI0.ISA_.SPKR._STA]: =
AE_NOT_FOUND
(drivers\bus\acpi\busmgr\utils.c:51) Evaluate [\_SB_.PCI0.ISA_.KBC_._STA]: =
AE_NOT_FOUND
(drivers\bus\acpi\busmgr\utils.c:274) Return value [0]
(drivers\bus\acpi\busmgr\utils.c:51) Evaluate [\_SB_.PCI0.ISA_.MOUS._STA]: =
AE_NOT_FOUND
(drivers\bus\acpi\osl.c:720) AcpiOsDerivePciId returned 0
(drivers\bus\acpi\osl.c:496) AcpiOsReadPciConfiguration, slot=3D0x0, func=
=3D0x60
(drivers\bus\acpi\osl.c:506) AcpiOsReadPciConfiguration returned AE_OK
(drivers\bus\acpi\busmgr\utils.c:274) Return value [11]
(drivers\bus\acpi\osl.c:496) AcpiOsReadPciConfiguration, slot=3D0x0, func=
=3D0x60
(drivers\bus\acpi\osl.c:506) AcpiOsReadPciConfiguration returned AE_OK
(drivers\bus\acpi\osl.c:496) AcpiOsReadPciConfiguration, slot=3D0x0, func=
=3D0x61
(drivers\bus\acpi\osl.c:506) AcpiOsReadPciConfiguration returned AE_OK
(drivers\bus\acpi\busmgr\utils.c:274) Return value [11]
(drivers\bus\acpi\osl.c:496) AcpiOsReadPciConfiguration, slot=3D0x0, func=
=3D0x61
(drivers\bus\acpi\osl.c:506) AcpiOsReadPciConfiguration returned AE_OK
(drivers\bus\acpi\osl.c:496) AcpiOsReadPciConfiguration, slot=3D0x0, func=
=3D0x62
(drivers\bus\acpi\osl.c:506) AcpiOsReadPciConfiguration returned AE_OK
(drivers\bus\acpi\busmgr\utils.c:274) Return value [11]
(drivers\bus\acpi\osl.c:496) AcpiOsReadPciConfiguration, slot=3D0x0, func=
=3D0x62
(drivers\bus\acpi\osl.c:506) AcpiOsReadPciConfiguration returned AE_OK
(drivers\bus\acpi\osl.c:496) AcpiOsReadPciConfiguration, slot=3D0x0, func=
=3D0x63
(drivers\bus\acpi\osl.c:506) AcpiOsReadPciConfiguration returned AE_OK
(drivers\bus\acpi\busmgr\utils.c:274) Return value [11]
(drivers\bus\acpi\osl.c:496) AcpiOsReadPciConfiguration, slot=3D0x0, func=
=3D0x63
(drivers\bus\acpi\osl.c:506) AcpiOsReadPciConfiguration returned AE_OK
(drivers\bus\acpi\busmgr\utils.c:51) Evaluate [\_SB_.PCI0.ISA_.SIO_._STA]: =
AE_NOT_FOUND
(drivers\bus\acpi\busmgr\utils.c:274) Return value [0]
(drivers\bus\acpi\busmgr\utils.c:274) Return value [15]
(drivers\bus\acpi\busmgr\utils.c:274) Return value [0]
(drivers\bus\acpi\busmgr\utils.c:274) Return value [15]
(drivers\bus\acpi\busmgr\utils.c:274) Return value [15]
(drivers\bus\acpi\busmgr\utils.c:274) Return value [0]
(drivers\bus\acpi\busmgr\utils.c:274) Return value [0]
(drivers\bus\acpi\busmgr\utils.c:274) Return value [0]
(drivers\bus\acpi\busmgr\utils.c:274) Return value [15]
(drivers\bus\acpi\busmgr\utils.c:51) Evaluate [\_SB_.PCI0.PWR_._STA]: AE_NO=
T_FOUND
(drivers\bus\acpi\busmgr\utils.c:51) Evaluate [\_SB_.PCI0.USB_._STA]: AE_NO=
T_FOUND
(drivers\bus\acpi\busmgr\utils.c:51) Evaluate [\_SB_.PCI0.IDE_._STA]: AE_NO=
T_FOUND
(drivers\bus\acpi\busmgr\utils.c:274) Return value [15]
(drivers\bus\acpi\osl.c:720) AcpiOsDerivePciId returned 0
(drivers\bus\acpi\osl.c:496) AcpiOsReadPciConfiguration, slot=3D0x0, func=
=3D0x0
(drivers\bus\acpi\osl.c:506) AcpiOsReadPciConfiguration returned AE_OK
PuTTYEntered debugger on last-chance exception (Exception Code: 0xc0000005)=
 (Page Fault)
Memory at 0x00000000 could not be read: Page not present.
kdb:> bt
Eip:
<00000000>
Frames:
kdb:>


From: robert.moore(a)intel.com
To: samcharly(a)hotmail.com; devel(a)acpica.org
Date: Thu, 4 Mar 2010 08:07:18 -0800
Subject: RE: [Devel] Unable to boot in vmware 7
















This appears to be the relevant part of
the trace:

 =


 =


exregion-0480 [-185] ExPciConfigSpaceHandle: Pci-Config 0
(32) Seg(0000) Bus(0000) Dev(0018) Func(0007) Reg(0000)

ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20100121/ev=
region-588)





 =


 =


This means that the function AcpiExPciConfigSpaceHandler
returned AE_ERROR.

 =


The basic implementation of this function simply calls
down to the OSL:

 =


    switch (Function)

    {

    case ACPI_READ:

 =


        *Value =3D 0;

        Status =3D AcpiOsReadPciConfiguration (PciId,
PciRegister,

                    Value, BitWidth);

        break;

 =


    case ACPI_WRITE:

 =


        Status =3D AcpiOsWritePciConfiguration (PciId,
PciRegister,

                    *Value, BitWidth);

        break;

 =


    default:

 =


        Status =3D AE_BAD_PARAMETER;

        break;

    }

 =


Which means that since AE_ERROR is being
returned (and the Function parameter is ACPI_READ), the error must come from
your implementation of AcpiOsReadPciConfiguration.

 =


Bob

 =




 =




 		 	   		  =

_________________________________________________________________
Hotmail: Trusted email with powerful SPAM protection.
https://signup.live.com/signup.aspx?id=3D60969

--===============2532523945163423108==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CjxoZWFkPgo8c3R5bGU+PCEtLQouaG1tZXNzYWdlIFAKewptYXJnaW46MHB4OwpwYWRk
aW5nOjBweAp9CmJvZHkuaG1tZXNzYWdlCnsKZm9udC1zaXplOiAxMHB0Owpmb250LWZhbWlseTpW
ZXJkYW5hCn0KLS0+PC9zdHlsZT4KPC9oZWFkPgo8Ym9keSBjbGFzcz0naG1tZXNzYWdlJz4KPHBy
ZSBjbGFzcz0iY29kZSI+SSBoYXZlIGZpeGVkIHdoYXQgbWlnaHQgaGF2ZSBiZWVuIGJ1Z3MgaW4g
QWNwaU9zUmVhZFBjaUNvbmZpZ3VyYXRpb24gYW5kIGFkZGVkIGEgZHByaW50IGZvciBpdHMgcmV0
dXJuIHZhbHVlLjxicj5TdGlsbCBnZXQgYW4gZXhjZXB0aW9uIGFuZCBFSVAgPSAwLiA8YnI+SnVz
dCBpbiBjYXNlIHlvdSBoYXZlIHNvbWUgZG91YnRzIGFib3V0IEFjcGlPc1JlYWRQY2lDb25maWd1
cmF0aW9uIGFuZCB5b3UgaGF2ZSBzb21lIFdpbmRvd3MgZHJpdmVyIGRldiBuZWFyYnkgaGVyZSBp
cyBteSBpbXBsZW1lbnRhdGlvbjo8YnI+PGJyPjxicj5BQ1BJX1NUQVRVUzxicj5BY3BpT3NSZWFk
UGNpQ29uZmlndXJhdGlvbiAoPGJyPiAgICBBQ1BJX1BDSV9JRCAgICAgICAgICAgICAqUGNpSWQs
PGJyPiAgICBVSU5UMzIgICAgICAgICAgICAgICAgICBSZWdpc3Rlciw8YnI+ICAgIHZvaWQgICAg
ICAgICAgICAgICAgICAgICpWYWx1ZSw8YnI+ICAgIFVJTlQzMiAgICAgICAgICAgICAgICAgIFdp
ZHRoKTxicj57PGJyPiAgICBQQ0lfU0xPVF9OVU1CRVIgc2xvdDs8YnI+ICAgIFVMT05HIHJlc3Vs
dCA9IDA7PGJyPjxicj4gICAgaWYgKFBjaUlkLSZndDtCdXMgJmd0Oz0gMjU2IHx8IFBjaUlkLSZn
dDtEZXZpY2UgJmd0Oz0gMzIgfHwgUGNpSWQtJmd0O0Z1bmN0aW9uICZndDs9IDgpPGJyPiAgICAg
ICAgcmV0dXJuIEFFX0JBRF9QQVJBTUVURVI7PGJyPjxicj4gICAgc2xvdC51LkFzVUxPTkcgPSAw
Ozxicj4gICAgc2xvdC51LmJpdHMuRGV2aWNlTnVtYmVyID0gUGNpSWQtJmd0O0J1czs8YnI+ICAg
IHNsb3QudS5iaXRzLkZ1bmN0aW9uTnVtYmVyID0gUGNpSWQtJmd0O0Z1bmN0aW9uOzxicj48YnI+
ICAgIERQUklOVDEoIkFjcGlPc1JlYWRQY2lDb25maWd1cmF0aW9uLCBzbG90PTB4JVgsIGZ1bmM9
MHglWFxuIiwgc2xvdC51LkFzVUxPTkcsIFJlZ2lzdGVyKTs8YnI+ICAgIHJlc3VsdCA9IEhhbEdl
dEJ1c0RhdGFCeU9mZnNldChQQ0lDb25maWd1cmF0aW9uLDxicj4gICAgICAgIFBjaUlkLSZndDtC
dXMsPGJyPiAgICAgICAgc2xvdC51LkFzVUxPTkcsPGJyPiAgICAgICAgVmFsdWUsPGJyPiAgICAg
ICAgUmVnaXN0ZXIsPGJyPiAgICAgICAgV2lkdGgpOzxicj48YnI+ICAgIGlmKHJlc3VsdCk8YnI+
ICAgIHs8YnI+ICAgICAgICBEUFJJTlQxKCJBY3BpT3NSZWFkUGNpQ29uZmlndXJhdGlvbiByZXR1
cm5lZCBBRV9PS1xuIik7PGJyPiAgICAgICAgcmV0dXJuIEFFX09LOzxicj4gICAgfTxicj4gICAg
ZWxzZTxicj4gICAgezxicj4gICAgICAgIERQUklOVDEoIkFjcGlPc1JlYWRQY2lDb25maWd1cmF0
aW9uIHJldHVybmVkIEFFX0VSUk9SXG4iKTs8YnI+ICAgICAgICByZXR1cm4gQUVfRVJST1I7PGJy
PiAgICB9PGJyPn08YnI+PGJyPjxicj5EZWJ1ZyBsb2c6PGJyPjxicj48YnI+KGRyaXZlcnNcYnVz
XGFjcGlcbWFpbi5jOjIwNikgRHJpdmVyIEVudHJ5PGJyPihkcml2ZXJzXGJ1c1xhY3BpXG1haW4u
YzozNikgQWRkIERldmljZTogMHhCMTM2QzZGODxicj4oZHJpdmVyc1xidXNcYWNwaVxtYWluLmM6
MzgpICMjIyMjIyMjIyMjIyMjIyMjIyMjIEJ1c19DcmVhdGVDbG9zZSBDcmVhdGluZyBGRE8gRGV2
aWNlICMjIyMjIyMjIyMjIyMjIyMjIyMjPGJyPihkcml2ZXJzXGJ1c1xhY3BpXG1haW4uYzoxNDEp
IEFkZERldmljZTogQjEzM0ZFQzAgdG8gQjEzNkM2RjgtJmd0O0IxMzZDNkY4IChSb290XCpQTlAw
QzA4XDAwMDApPGJyPihkcml2ZXJzXGJ1c1xhY3BpXHBucC5jOjQ3KSBGRE8gSVJQX01OX0ZJTFRF
Ul9SRVNPVVJDRV9SRVFVSVJFTUVOVFMgSVJQOjB4QjEzNEQ1Rjg8YnI+KGRyaXZlcnNcYnVzXGFj
cGlccG5wLmM6NDcpIEZETyBJUlBfTU5fU1RBUlRfREVWSUNFIElSUDoweEIxMzRENUY4PGJyPkFD
UEk6IFJTRFAgMDAwRjY5NDAgMDAwMjQgKHYwMiBQVExURCApPGJyPkFDUEk6IFhTRFQgMUZFRjA4
ODUgMDAwNEMgKHYwMSBJTlRFTCAgNDQwQlggICAgMDYwNDAwMDAgVk1XICAwMTMyNDI3Mik8YnI+
QUNQSTogRkFDUCAxRkVGRUU5OCAwMDBGNCAodjA0IElOVEVMICA0NDBCWCAgICAwNjA0MDAwMCBQ
VEwgIDAwMEY0MjQwKTxicj5BQ1BJOiBEU0RUIDFGRUYwQTNEIDBFNDVCICh2MDEgUFRMVEQgIEN1
c3RvbSAgIDA2MDQwMDAwIE1TRlQgMDMwMDAwMDEpPGJyPkFDUEk6IEZBQ1MgMUZFRkZGQzAgMDAw
NDA8YnI+QUNQSTogQk9PVCAxRkVGMEExNSAwMDAyOCAodjAxIFBUTFREICAkU0JGVEJMJCAwNjA0
MDAwMCAgTFRQIDAwMDAwMDAxKTxicj5BQ1BJOiBBUElDIDFGRUYwOUM1IDAwMDUwICh2MDEgUFRM
VEQgICAgIEFQSUMgICAwNjA0MDAwMCAgTFRQIDAwMDAwMDAwKTxicj5BQ1BJOiBNQ0ZHIDFGRUYw
OTg5IDAwMDNDICh2MDEgUFRMVEQgICRQQ0lUQkwkIDA2MDQwMDAwICBMVFAgMDAwMDAwMDEpPGJy
PkFDUEk6IFNSQVQgMUZFRjA5MDkgMDAwODAgKHYwMiBWTVdBUkUgTUVNUExVRyAgMDYwNDAwMDAg
Vk1XICAwMDAwMDAwMSk8YnI+UGFyc2luZyBhbGwgQ29udHJvbCBNZXRob2RzOjxicj5UYWJsZSBb
RFNEVF0oaWQgMDAwMSkgLSAyNzk0IE9iamVjdHMgd2l0aCAzMjUgRGV2aWNlcyA4MzcgTWV0aG9k
cyAyODAgUmVnaW9uczxicj4gdGJ4ZmFjZS0wNjAxIFswMl0gVGJMb2FkTmFtZXNwYWNlICAgICAg
IDogQUNQSSBUYWJsZXMgc3VjY2Vzc2Z1bGx5IGFjcXVpcmVkPGJyPihkcml2ZXJzXGJ1c1xhY3Bp
XHBucC5jOjMwNikgQWNwaSBzdWJzeXN0ZW0gaW5pdDxicj4oZHJpdmVyc1xidXNcYWNwaVxidXNt
Z3JcYnVzLmM6MTc4MykgYWNwaV9pbml0KGRyaXZlcnNcYnVzXGFjcGlcYnVzbWdyXGJ1cy5jOjE3
ODUpIFN1YnN5c3RlbSByZXZpc2lvbiAyMDEwMDEyMTxicj4oZHJpdmVyc1xidXNcYWNwaVxidXNt
Z3JcYnVzLmM6MTY2NSkgYWNwaV9idXNfaW5pdGV2eGZldm50LTAxODQgWzAyXSBFbmFibGUgICAg
ICAgICAgICAgICAgOiBUcmFuc2l0aW9uIHRvIEFDUEkgbW9kZSBzdWNjZXNzZnVsPGJyPmV2Z3Bl
YmxrLTExMjkgWzA0XSBFdkNyZWF0ZUdwZUJsb2NrICAgICAgOiBHUEUgMDAgdG8gMEYgW19HUEVd
IDIgcmVncyBvbiBpbnQgMHg5PGJyPkNvbXBsZXRpbmcgUmVnaW9uL0ZpZWxkL0J1ZmZlci9QYWNr
YWdlIGluaXRpYWxpemF0aW9uOi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLjxicj5Jbml0aWFsaXplZCAyODAvMjgwIFJlZ2lvbnMgMC8wIEZpZWxkcyAyNi8yNiBCdWZm
ZXJzIDM2My8zNjMgUGFja2FnZXMgKDI4MDMgbm9kZXMpPGJyPkluaXRpYWxpemluZyBEZXZpY2Uv
UHJvY2Vzc29yL1RoZXJtYWwgb2JqZWN0cyBieSBleGVjdXRpbmcgX0lOSSBtZXRob2RzOi4oZHJp
dmVyc1xidXNcYWNwaVxvc2wuYzo3MjApIEFjcGlPc0Rlcml2ZVBjaUlkIHJldHVybmVkIDA8YnI+
KGRyaXZlcnNcYnVzXGFjcGlcb3NsLmM6NDk2KSBBY3BpT3NSZWFkUGNpQ29uZmlndXJhdGlvbiwg
c2xvdD0weDYwLCBmdW5jPTB4NUM8YnI+QUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5l
ZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10gKDIwMTAwMTIxL2V2cmVnaW9uLTU4OCk8YnI+
PGJyPioqKiogRXhjZXB0aW9uIEFFX0VSUk9SIGR1cmluZyBleGVjdXRpb24gb2YgbWV0aG9kIFtc
X1NCXy5QQ0kwLklTQV8uX0lOSV0gKE5vZGUgQjEzNEJBOTgpPGJyPjxicj5NZXRob2QgRXhlY3V0
aW9uIFN0YWNrOjxicj4gICAgTWV0aG9kIFtfSU5JXSBleGVjdXRpbmc6IFtfSU5JXSBAMDAwMDMg
IzAwMkQ6ICBeXlBXUi5MUFRFPGJyPjxicj5Mb2NhbCBWYXJpYWJsZXMgZm9yIG1ldGhvZCBbX0lO
SV06PGJyPiAgICBMb2NhbDA6IDAwMDAwMDAwICZsdDtOdWxsIE9iamVjdCZndDs8YnI+ICAgIExv
Y2FsMTogMDAwMDAwMDAgJmx0O051bGwgT2JqZWN0Jmd0Ozxicj4gICAgTG9jYWwyOiAwMDAwMDAw
MCAmbHQ7TnVsbCBPYmplY3QmZ3Q7PGJyPiAgICBMb2NhbDM6IDAwMDAwMDAwICZsdDtOdWxsIE9i
amVjdCZndDs8YnI+ICAgIExvY2FsNDogMDAwMDAwMDAgJmx0O051bGwgT2JqZWN0Jmd0Ozxicj4g
ICAgTG9jYWw1OiAwMDAwMDAwMCAmbHQ7TnVsbCBPYmplY3QmZ3Q7PGJyPiAgICBMb2NhbDY6IDAw
MDAwMDAwICZsdDtOdWxsIE9iamVjdCZndDs8YnI+ICAgIExvY2FsNzogMDAwMDAwMDAgJmx0O051
bGwgT2JqZWN0Jmd0Ozxicj48YnI+QXJndW1lbnRzIGZvciBNZXRob2QgW19JTkldOiAgKDAgYXJn
dW1lbnRzIGRlZmluZWQsIG1heCBjb25jdXJyZW5jeSA9IDApPGJyPiAgICBBcmcwOiAgIDAwMDAw
MDAwICZsdDtOdWxsIE9iamVjdCZndDs8YnI+ICAgIEFyZzE6ICAgMDAwMDAwMDAgJmx0O051bGwg
T2JqZWN0Jmd0Ozxicj4gICAgQXJnMjogICAwMDAwMDAwMCAmbHQ7TnVsbCBPYmplY3QmZ3Q7PGJy
PiAgICBBcmczOiAgIDAwMDAwMDAwICZsdDtOdWxsIE9iamVjdCZndDs8YnI+ICAgIEFyZzQ6ICAg
MDAwMDAwMDAgJmx0O051bGwgT2JqZWN0Jmd0Ozxicj4gICAgQXJnNTogICAwMDAwMDAwMCAmbHQ7
TnVsbCBPYmplY3QmZ3Q7PGJyPiAgICBBcmc2OiAgIDAwMDAwMDAwICZsdDtOdWxsIE9iamVjdCZn
dDs8YnI+PGJyPkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRp
b24gZmFpbGVkIFtcX1NCXy5QQ0kwLklTQV8uX0lOSV0gKE5vZGUgQjEzNEJBOTgpLCBBRV9FUlJP
Ujxicj5BQ1BJIEV4Y2VwdGlvbjogQUVfRVJST1IsIGR1cmluZyBcX1NCXy5QQ0kwLklTQV8uX0lO
SS5fSU5JIGV4ZWN1dGlvbiAoMjAxMDAxMjEvbnNpbml0LTcwOCk8YnI+PGJyPkV4ZWN1dGVkIDEg
X0lOSSBtZXRob2RzIHJlcXVpcmluZyAwIF9TVEEgZXhlY3V0aW9ucyAoZXhhbWluZWQgMzI4IG9i
amVjdHMpPGJyPmV2Z3BlYmxrLTEyMzQgWzAzXSBFdkluaXRpYWxpemVHcGVCbG9jayAgOiBGb3Vu
ZCAzIFdha2UsIEVuYWJsZWQgMiBSdW50aW1lIEdQRXMgaW4gdGhpcyBibG9jazxicj4oZHJpdmVy
c1xidXNcYWNwaVxidXNtZ3JcYnVzLmM6MTU1MykgYWNwaV9idXNfaW5pdF9pcnEoZHJpdmVyc1xi
dXNcYWNwaVxidXNtZ3JcYnVzLmM6MTU3NSkgVXNpbmcgUElDIGZvciBpbnRlcnJ1cHQgcm91dGlu
Zzxicj4oZHJpdmVyc1xidXNcYWNwaVxidXNtZ3JcdXRpbHMuYzo1MSkgRXZhbHVhdGUgW1xfU0Jf
Ll9TVEFdOiBBRV9OT1RfRk9VTkQ8YnI+KGRyaXZlcnNcYnVzXGFjcGlcYnVzbWdyXHV0aWxzLmM6
NTEpIEV2YWx1YXRlIFtcX1NCXy5QQ0kwLl9TVEFdOiBBRV9OT1RfRk9VTkQ8YnI+KGRyaXZlcnNc
YnVzXGFjcGlcYnVzbWdyXHV0aWxzLmM6NTEpIEV2YWx1YXRlIFtcX1NCXy5QQ0kwLkFHUF8uX1NU
QV06IEFFX05PVF9GT1VORDxicj4oZHJpdmVyc1xidXNcYWNwaVxidXNtZ3JcdXRpbHMuYzo1MSkg
RXZhbHVhdGUgW1xfU0JfLlBDSTAuSVNBXy5fU1RBXTogQUVfTk9UX0ZPVU5EPGJyPihkcml2ZXJz
XGJ1c1xhY3BpXGJ1c21nclx1dGlscy5jOjUxKSBFdmFsdWF0ZSBbXF9TQl8uUENJMC5JU0FfLk1C
UkQuX1NUQV06IEFFX05PVF9GT1VORDxicj4oZHJpdmVyc1xidXNcYWNwaVxidXNtZ3JcdXRpbHMu
Yzo1MSkgRXZhbHVhdGUgW1xfU0JfLlBDSTAuSVNBXy5ETUFDLl9TVEFdOiBBRV9OT1RfRk9VTkQ8
YnI+KGRyaXZlcnNcYnVzXGFjcGlcYnVzbWdyXHV0aWxzLmM6NTEpIEV2YWx1YXRlIFtcX1NCXy5Q
Q0kwLklTQV8uUElDXy5fU1RBXTogQUVfTk9UX0ZPVU5EPGJyPihkcml2ZXJzXGJ1c1xhY3BpXGJ1
c21nclx1dGlscy5jOjUxKSBFdmFsdWF0ZSBbXF9TQl8uUENJMC5JU0FfLlRJTUUuX1NUQV06IEFF
X05PVF9GT1VORDxicj4oZHJpdmVyc1xidXNcYWNwaVxidXNtZ3JcdXRpbHMuYzo1MSkgRXZhbHVh
dGUgW1xfU0JfLlBDSTAuSVNBXy5SVENfLl9TVEFdOiBBRV9OT1RfRk9VTkQ8YnI+KGRyaXZlcnNc
YnVzXGFjcGlcYnVzbWdyXHV0aWxzLmM6NTEpIEV2YWx1YXRlIFtcX1NCXy5QQ0kwLklTQV8uU1BL
Ui5fU1RBXTogQUVfTk9UX0ZPVU5EPGJyPihkcml2ZXJzXGJ1c1xhY3BpXGJ1c21nclx1dGlscy5j
OjUxKSBFdmFsdWF0ZSBbXF9TQl8uUENJMC5JU0FfLktCQ18uX1NUQV06IEFFX05PVF9GT1VORDxi
cj4oZHJpdmVyc1xidXNcYWNwaVxidXNtZ3JcdXRpbHMuYzoyNzQpIFJldHVybiB2YWx1ZSBbMF08
YnI+KGRyaXZlcnNcYnVzXGFjcGlcYnVzbWdyXHV0aWxzLmM6NTEpIEV2YWx1YXRlIFtcX1NCXy5Q
Q0kwLklTQV8uTU9VUy5fU1RBXTogQUVfTk9UX0ZPVU5EPGJyPihkcml2ZXJzXGJ1c1xhY3BpXG9z
bC5jOjcyMCkgQWNwaU9zRGVyaXZlUGNpSWQgcmV0dXJuZWQgMDxicj4oZHJpdmVyc1xidXNcYWNw
aVxvc2wuYzo0OTYpIEFjcGlPc1JlYWRQY2lDb25maWd1cmF0aW9uLCBzbG90PTB4MCwgZnVuYz0w
eDYwPGJyPihkcml2ZXJzXGJ1c1xhY3BpXG9zbC5jOjUwNikgQWNwaU9zUmVhZFBjaUNvbmZpZ3Vy
YXRpb24gcmV0dXJuZWQgQUVfT0s8YnI+KGRyaXZlcnNcYnVzXGFjcGlcYnVzbWdyXHV0aWxzLmM6
Mjc0KSBSZXR1cm4gdmFsdWUgWzExXTxicj4oZHJpdmVyc1xidXNcYWNwaVxvc2wuYzo0OTYpIEFj
cGlPc1JlYWRQY2lDb25maWd1cmF0aW9uLCBzbG90PTB4MCwgZnVuYz0weDYwPGJyPihkcml2ZXJz
XGJ1c1xhY3BpXG9zbC5jOjUwNikgQWNwaU9zUmVhZFBjaUNvbmZpZ3VyYXRpb24gcmV0dXJuZWQg
QUVfT0s8YnI+KGRyaXZlcnNcYnVzXGFjcGlcb3NsLmM6NDk2KSBBY3BpT3NSZWFkUGNpQ29uZmln
dXJhdGlvbiwgc2xvdD0weDAsIGZ1bmM9MHg2MTxicj4oZHJpdmVyc1xidXNcYWNwaVxvc2wuYzo1
MDYpIEFjcGlPc1JlYWRQY2lDb25maWd1cmF0aW9uIHJldHVybmVkIEFFX09LPGJyPihkcml2ZXJz
XGJ1c1xhY3BpXGJ1c21nclx1dGlscy5jOjI3NCkgUmV0dXJuIHZhbHVlIFsxMV08YnI+KGRyaXZl
cnNcYnVzXGFjcGlcb3NsLmM6NDk2KSBBY3BpT3NSZWFkUGNpQ29uZmlndXJhdGlvbiwgc2xvdD0w
eDAsIGZ1bmM9MHg2MTxicj4oZHJpdmVyc1xidXNcYWNwaVxvc2wuYzo1MDYpIEFjcGlPc1JlYWRQ
Y2lDb25maWd1cmF0aW9uIHJldHVybmVkIEFFX09LPGJyPihkcml2ZXJzXGJ1c1xhY3BpXG9zbC5j
OjQ5NikgQWNwaU9zUmVhZFBjaUNvbmZpZ3VyYXRpb24sIHNsb3Q9MHgwLCBmdW5jPTB4NjI8YnI+
KGRyaXZlcnNcYnVzXGFjcGlcb3NsLmM6NTA2KSBBY3BpT3NSZWFkUGNpQ29uZmlndXJhdGlvbiBy
ZXR1cm5lZCBBRV9PSzxicj4oZHJpdmVyc1xidXNcYWNwaVxidXNtZ3JcdXRpbHMuYzoyNzQpIFJl
dHVybiB2YWx1ZSBbMTFdPGJyPihkcml2ZXJzXGJ1c1xhY3BpXG9zbC5jOjQ5NikgQWNwaU9zUmVh
ZFBjaUNvbmZpZ3VyYXRpb24sIHNsb3Q9MHgwLCBmdW5jPTB4NjI8YnI+KGRyaXZlcnNcYnVzXGFj
cGlcb3NsLmM6NTA2KSBBY3BpT3NSZWFkUGNpQ29uZmlndXJhdGlvbiByZXR1cm5lZCBBRV9PSzxi
cj4oZHJpdmVyc1xidXNcYWNwaVxvc2wuYzo0OTYpIEFjcGlPc1JlYWRQY2lDb25maWd1cmF0aW9u
LCBzbG90PTB4MCwgZnVuYz0weDYzPGJyPihkcml2ZXJzXGJ1c1xhY3BpXG9zbC5jOjUwNikgQWNw
aU9zUmVhZFBjaUNvbmZpZ3VyYXRpb24gcmV0dXJuZWQgQUVfT0s8YnI+KGRyaXZlcnNcYnVzXGFj
cGlcYnVzbWdyXHV0aWxzLmM6Mjc0KSBSZXR1cm4gdmFsdWUgWzExXTxicj4oZHJpdmVyc1xidXNc
YWNwaVxvc2wuYzo0OTYpIEFjcGlPc1JlYWRQY2lDb25maWd1cmF0aW9uLCBzbG90PTB4MCwgZnVu
Yz0weDYzPGJyPihkcml2ZXJzXGJ1c1xhY3BpXG9zbC5jOjUwNikgQWNwaU9zUmVhZFBjaUNvbmZp
Z3VyYXRpb24gcmV0dXJuZWQgQUVfT0s8YnI+KGRyaXZlcnNcYnVzXGFjcGlcYnVzbWdyXHV0aWxz
LmM6NTEpIEV2YWx1YXRlIFtcX1NCXy5QQ0kwLklTQV8uU0lPXy5fU1RBXTogQUVfTk9UX0ZPVU5E
PGJyPihkcml2ZXJzXGJ1c1xhY3BpXGJ1c21nclx1dGlscy5jOjI3NCkgUmV0dXJuIHZhbHVlIFsw
XTxicj4oZHJpdmVyc1xidXNcYWNwaVxidXNtZ3JcdXRpbHMuYzoyNzQpIFJldHVybiB2YWx1ZSBb
MTVdPGJyPihkcml2ZXJzXGJ1c1xhY3BpXGJ1c21nclx1dGlscy5jOjI3NCkgUmV0dXJuIHZhbHVl
IFswXTxicj4oZHJpdmVyc1xidXNcYWNwaVxidXNtZ3JcdXRpbHMuYzoyNzQpIFJldHVybiB2YWx1
ZSBbMTVdPGJyPihkcml2ZXJzXGJ1c1xhY3BpXGJ1c21nclx1dGlscy5jOjI3NCkgUmV0dXJuIHZh
bHVlIFsxNV08YnI+KGRyaXZlcnNcYnVzXGFjcGlcYnVzbWdyXHV0aWxzLmM6Mjc0KSBSZXR1cm4g
dmFsdWUgWzBdPGJyPihkcml2ZXJzXGJ1c1xhY3BpXGJ1c21nclx1dGlscy5jOjI3NCkgUmV0dXJu
IHZhbHVlIFswXTxicj4oZHJpdmVyc1xidXNcYWNwaVxidXNtZ3JcdXRpbHMuYzoyNzQpIFJldHVy
biB2YWx1ZSBbMF08YnI+KGRyaXZlcnNcYnVzXGFjcGlcYnVzbWdyXHV0aWxzLmM6Mjc0KSBSZXR1
cm4gdmFsdWUgWzE1XTxicj4oZHJpdmVyc1xidXNcYWNwaVxidXNtZ3JcdXRpbHMuYzo1MSkgRXZh
bHVhdGUgW1xfU0JfLlBDSTAuUFdSXy5fU1RBXTogQUVfTk9UX0ZPVU5EPGJyPihkcml2ZXJzXGJ1
c1xhY3BpXGJ1c21nclx1dGlscy5jOjUxKSBFdmFsdWF0ZSBbXF9TQl8uUENJMC5VU0JfLl9TVEFd
OiBBRV9OT1RfRk9VTkQ8YnI+KGRyaXZlcnNcYnVzXGFjcGlcYnVzbWdyXHV0aWxzLmM6NTEpIEV2
YWx1YXRlIFtcX1NCXy5QQ0kwLklERV8uX1NUQV06IEFFX05PVF9GT1VORDxicj4oZHJpdmVyc1xi
dXNcYWNwaVxidXNtZ3JcdXRpbHMuYzoyNzQpIFJldHVybiB2YWx1ZSBbMTVdPGJyPihkcml2ZXJz
XGJ1c1xhY3BpXG9zbC5jOjcyMCkgQWNwaU9zRGVyaXZlUGNpSWQgcmV0dXJuZWQgMDxicj4oZHJp
dmVyc1xidXNcYWNwaVxvc2wuYzo0OTYpIEFjcGlPc1JlYWRQY2lDb25maWd1cmF0aW9uLCBzbG90
PTB4MCwgZnVuYz0weDA8YnI+KGRyaXZlcnNcYnVzXGFjcGlcb3NsLmM6NTA2KSBBY3BpT3NSZWFk
UGNpQ29uZmlndXJhdGlvbiByZXR1cm5lZCBBRV9PSzxicj5QdVRUWUVudGVyZWQgZGVidWdnZXIg
b24gbGFzdC1jaGFuY2UgZXhjZXB0aW9uIChFeGNlcHRpb24gQ29kZTogMHhjMDAwMDAwNSkgKFBh
Z2UgRmF1bHQpPGJyPk1lbW9yeSBhdCAweDAwMDAwMDAwIGNvdWxkIG5vdCBiZSByZWFkOiBQYWdl
IG5vdCBwcmVzZW50Ljxicj5rZGI6Jmd0OyBidDxicj5FaXA6PGJyPiZsdDswMDAwMDAwMCZndDs8
YnI+RnJhbWVzOjxicj5rZGI6Jmd0Ozxicj48L3ByZT48YnI+PGJyPjxociBpZD0ic3RvcFNwZWxs
aW5nIj5Gcm9tOiByb2JlcnQubW9vcmVAaW50ZWwuY29tPGJyPlRvOiBzYW1jaGFybHlAaG90bWFp
bC5jb207IGRldmVsQGFjcGljYS5vcmc8YnI+RGF0ZTogVGh1LCA0IE1hciAyMDEwIDA4OjA3OjE4
IC0wODAwPGJyPlN1YmplY3Q6IFJFOiBbRGV2ZWxdIFVuYWJsZSB0byBib290IGluIHZtd2FyZSA3
PGJyPjxicj4KCgoKCgoKPHN0eWxlPgouRXh0ZXJuYWxDbGFzcyBwLmVjeE1zb05vcm1hbCwgLkV4
dGVybmFsQ2xhc3MgbGkuZWN4TXNvTm9ybWFsLCAuRXh0ZXJuYWxDbGFzcyBkaXYuZWN4TXNvTm9y
bWFsCnttYXJnaW4tYm90dG9tOi4wMDAxcHQ7Zm9udC1zaXplOjEyLjBwdDtmb250LWZhbWlseTon
VGltZXMgTmV3IFJvbWFuJzt9Ci5FeHRlcm5hbENsYXNzIGE6bGluaywgLkV4dGVybmFsQ2xhc3Mg
c3Bhbi5lY3hNc29IeXBlcmxpbmsKe2NvbG9yOmJsdWU7dGV4dC1kZWNvcmF0aW9uOnVuZGVybGlu
ZTt9Ci5FeHRlcm5hbENsYXNzIGE6dmlzaXRlZCwgLkV4dGVybmFsQ2xhc3Mgc3Bhbi5lY3hNc29I
eXBlcmxpbmtGb2xsb3dlZAp7Y29sb3I6Ymx1ZTt0ZXh0LWRlY29yYXRpb246dW5kZXJsaW5lO30K
LkV4dGVybmFsQ2xhc3MgcAp7bWFyZ2luLXJpZ2h0OjBpbjttYXJnaW4tbGVmdDowaW47Zm9udC1z
aXplOjEyLjBwdDtmb250LWZhbWlseTonVGltZXMgTmV3IFJvbWFuJzt9Ci5FeHRlcm5hbENsYXNz
IHAuZWN4ZWN4bXNvbm9ybWFsLCAuRXh0ZXJuYWxDbGFzcyBsaS5lY3hlY3htc29ub3JtYWwsIC5F
eHRlcm5hbENsYXNzIGRpdi5lY3hlY3htc29ub3JtYWwKe21hcmdpbi1yaWdodDowaW47bWFyZ2lu
LWxlZnQ6MGluO2ZvbnQtc2l6ZToxMi4wcHQ7Zm9udC1mYW1pbHk6J1RpbWVzIE5ldyBSb21hbic7
fQouRXh0ZXJuYWxDbGFzcyBwLmVjeGVjeG1zb25vcm1hbDEsIC5FeHRlcm5hbENsYXNzIGxpLmVj
eGVjeG1zb25vcm1hbDEsIC5FeHRlcm5hbENsYXNzIGRpdi5lY3hlY3htc29ub3JtYWwxCnttYXJn
aW4tcmlnaHQ6MGluO21hcmdpbi1ib3R0b206MGluO21hcmdpbi1sZWZ0OjBpbjttYXJnaW4tYm90
dG9tOi4wMDAxcHQ7Zm9udC1zaXplOjEyLjBwdDtmb250LWZhbWlseTonVGltZXMgTmV3IFJvbWFu
Jzt9Ci5FeHRlcm5hbENsYXNzIHNwYW4uZWN4ZWN4bXNvaHlwZXJsaW5rMQp7Y29sb3I6Ymx1ZTt0
ZXh0LWRlY29yYXRpb246dW5kZXJsaW5lO30KLkV4dGVybmFsQ2xhc3Mgc3Bhbi5lY3hlY3htc29o
eXBlcmxpbmtmb2xsb3dlZDEKe2NvbG9yOmJsdWU7dGV4dC1kZWNvcmF0aW9uOnVuZGVybGluZTt9
Ci5FeHRlcm5hbENsYXNzIHNwYW4uZWN4ZWN4ZW1haWxzdHlsZTE4MQp7Zm9udC1mYW1pbHk6QXJp
YWw7Y29sb3I6bmF2eTt9Ci5FeHRlcm5hbENsYXNzIHNwYW4uZWN4RW1haWxTdHlsZTI2Cntmb250
LWZhbWlseTpBcmlhbDtjb2xvcjpuYXZ5O30KQHBhZ2UgU2VjdGlvbjEKe3NpemU6OC41aW4gMTEu
MGluO30KLkV4dGVybmFsQ2xhc3MgZGl2LmVjeFNlY3Rpb24xCntwYWdlOlNlY3Rpb24xO30KPC9z
dHlsZT4KCgoKCgo8ZGl2IGNsYXNzPSJlY3hTZWN0aW9uMSI+Cgo8cCBjbGFzcz0iZWN4TXNvTm9y
bWFsIj48Zm9udCBjb2xvcj0iYmx1ZSIgZmFjZT0iVmVyZGFuYSIgc2l6ZT0iMiI+PHNwYW4gc3R5
bGU9ImZvbnQtc2l6ZTogMTBwdDsgZm9udC1mYW1pbHk6IFZlcmRhbmE7IGNvbG9yOiBibHVlOyI+
VGhpcyBhcHBlYXJzIHRvIGJlIHRoZSByZWxldmFudCBwYXJ0IG9mCnRoZSB0cmFjZTo8L3NwYW4+
PC9mb250PjwvcD4KCjxwIGNsYXNzPSJlY3hNc29Ob3JtYWwiPjxmb250IGNvbG9yPSJuYXZ5IiBm
YWNlPSJBcmlhbCIgc2l6ZT0iMiI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZTogMTBwdDsgZm9udC1m
YW1pbHk6IEFyaWFsOyBjb2xvcjogbmF2eTsiPiZuYnNwOzwvc3Bhbj48L2ZvbnQ+PC9wPgoKPHAg
Y2xhc3M9ImVjeE1zb05vcm1hbCI+PGZvbnQgY29sb3I9Im5hdnkiIGZhY2U9IkFyaWFsIiBzaXpl
PSIyIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOiAxMHB0OyBmb250LWZhbWlseTogQXJpYWw7IGNv
bG9yOiBuYXZ5OyI+Jm5ic3A7PC9zcGFuPjwvZm9udD48L3A+Cgo8cCBjbGFzcz0iZWN4TXNvTm9y
bWFsIj48Zm9udCBmYWNlPSJWZXJkYW5hIiBzaXplPSIyIj48c3BhbiBzdHlsZT0iZm9udC1zaXpl
OiAxMHB0OyBmb250LWZhbWlseTogVmVyZGFuYTsiPmV4cmVnaW9uLTA0ODAgWy0xODVdIEV4UGNp
Q29uZmlnU3BhY2VIYW5kbGU6IFBjaS1Db25maWcgMAooMzIpIFNlZygwMDAwKSBCdXMoMDAwMCkg
RGV2KDAwMTgpIEZ1bmMoMDAwNykgUmVnKDAwMDApPGJyPgpBQ1BJIEV4Y2VwdGlvbjogQUVfRVJS
T1IsIFJldHVybmVkIGJ5IEhhbmRsZXIgZm9yIFtQQ0lfQ29uZmlnXSAoMjAxMDAxMjEvZXZyZWdp
b24tNTg4KTxicj4KPGJyPgo8L3NwYW4+PC9mb250PjwvcD4KCjxwIGNsYXNzPSJlY3hNc29Ob3Jt
YWwiPjxmb250IGZhY2U9IlZlcmRhbmEiIHNpemU9IjIiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6
IDEwcHQ7IGZvbnQtZmFtaWx5OiBWZXJkYW5hOyI+Jm5ic3A7PC9zcGFuPjwvZm9udD48L3A+Cgo8
cCBjbGFzcz0iZWN4TXNvTm9ybWFsIj48Zm9udCBmYWNlPSJWZXJkYW5hIiBzaXplPSIyIj48c3Bh
biBzdHlsZT0iZm9udC1zaXplOiAxMHB0OyBmb250LWZhbWlseTogVmVyZGFuYTsiPiZuYnNwOzwv
c3Bhbj48L2ZvbnQ+PC9wPgoKPHAgY2xhc3M9ImVjeE1zb05vcm1hbCI+PGZvbnQgZmFjZT0iVmVy
ZGFuYSIgc2l6ZT0iMiI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZTogMTBwdDsgZm9udC1mYW1pbHk6
IFZlcmRhbmE7Ij5UaGlzIG1lYW5zIHRoYXQgdGhlIGZ1bmN0aW9uIEFjcGlFeFBjaUNvbmZpZ1Nw
YWNlSGFuZGxlcgpyZXR1cm5lZCBBRV9FUlJPUi48L3NwYW4+PC9mb250PjwvcD4KCjxwIGNsYXNz
PSJlY3hNc29Ob3JtYWwiPjxmb250IGZhY2U9IlZlcmRhbmEiIHNpemU9IjIiPjxzcGFuIHN0eWxl
PSJmb250LXNpemU6IDEwcHQ7IGZvbnQtZmFtaWx5OiBWZXJkYW5hOyI+Jm5ic3A7PC9zcGFuPjwv
Zm9udD48L3A+Cgo8cCBjbGFzcz0iZWN4TXNvTm9ybWFsIj48Zm9udCBmYWNlPSJWZXJkYW5hIiBz
aXplPSIyIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOiAxMHB0OyBmb250LWZhbWlseTogVmVyZGFu
YTsiPlRoZSBiYXNpYyBpbXBsZW1lbnRhdGlvbiBvZiB0aGlzIGZ1bmN0aW9uIHNpbXBseSBjYWxs
cwpkb3duIHRvIHRoZSBPU0w6PC9zcGFuPjwvZm9udD48L3A+Cgo8cCBjbGFzcz0iZWN4TXNvTm9y
bWFsIj48Zm9udCBmYWNlPSJWZXJkYW5hIiBzaXplPSIyIj48c3BhbiBzdHlsZT0iZm9udC1zaXpl
OiAxMHB0OyBmb250LWZhbWlseTogVmVyZGFuYTsiPiZuYnNwOzwvc3Bhbj48L2ZvbnQ+PC9wPgoK
PHAgY2xhc3M9ImVjeE1zb05vcm1hbCI+PGZvbnQgZmFjZT0iVmVyZGFuYSIgc2l6ZT0iMiI+PHNw
YW4gc3R5bGU9ImZvbnQtc2l6ZTogMTBwdDsgZm9udC1mYW1pbHk6IFZlcmRhbmE7Ij4mbmJzcDsm
bmJzcDsmbmJzcDsgc3dpdGNoIChGdW5jdGlvbik8L3NwYW4+PC9mb250PjwvcD4KCjxwIGNsYXNz
PSJlY3hNc29Ob3JtYWwiPjxmb250IGZhY2U9IlZlcmRhbmEiIHNpemU9IjIiPjxzcGFuIHN0eWxl
PSJmb250LXNpemU6IDEwcHQ7IGZvbnQtZmFtaWx5OiBWZXJkYW5hOyI+Jm5ic3A7Jm5ic3A7Jm5i
c3A7IHs8L3NwYW4+PC9mb250PjwvcD4KCjxwIGNsYXNzPSJlY3hNc29Ob3JtYWwiPjxmb250IGZh
Y2U9IlZlcmRhbmEiIHNpemU9IjIiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6IDEwcHQ7IGZvbnQt
ZmFtaWx5OiBWZXJkYW5hOyI+Jm5ic3A7Jm5ic3A7Jm5ic3A7IGNhc2UgQUNQSV9SRUFEOjwvc3Bh
bj48L2ZvbnQ+PC9wPgoKPHAgY2xhc3M9ImVjeE1zb05vcm1hbCI+PGZvbnQgZmFjZT0iVmVyZGFu
YSIgc2l6ZT0iMiI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZTogMTBwdDsgZm9udC1mYW1pbHk6IFZl
cmRhbmE7Ij4mbmJzcDs8L3NwYW4+PC9mb250PjwvcD4KCjxwIGNsYXNzPSJlY3hNc29Ob3JtYWwi
Pjxmb250IGZhY2U9IlZlcmRhbmEiIHNpemU9IjIiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6IDEw
cHQ7IGZvbnQtZmFtaWx5OiBWZXJkYW5hOyI+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7ICpWYWx1ZSA9IDA7PC9zcGFuPjwvZm9udD48L3A+Cgo8cCBjbGFzcz0iZWN4
TXNvTm9ybWFsIj48Zm9udCBmYWNlPSJWZXJkYW5hIiBzaXplPSIyIj48c3BhbiBzdHlsZT0iZm9u
dC1zaXplOiAxMHB0OyBmb250LWZhbWlseTogVmVyZGFuYTsiPiZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBTdGF0dXMgPSBBY3BpT3NSZWFkUGNpQ29uZmlndXJhdGlv
biAoUGNpSWQsClBjaVJlZ2lzdGVyLDwvc3Bhbj48L2ZvbnQ+PC9wPgoKPHAgY2xhc3M9ImVjeE1z
b05vcm1hbCI+PGZvbnQgZmFjZT0iVmVyZGFuYSIgc2l6ZT0iMiI+PHNwYW4gc3R5bGU9ImZvbnQt
c2l6ZTogMTBwdDsgZm9udC1mYW1pbHk6IFZlcmRhbmE7Ij4mbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgVmFsdWUsIEJpdFdpZHRoKTs8L3Nw
YW4+PC9mb250PjwvcD4KCjxwIGNsYXNzPSJlY3hNc29Ob3JtYWwiPjxmb250IGZhY2U9IlZlcmRh
bmEiIHNpemU9IjIiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6IDEwcHQ7IGZvbnQtZmFtaWx5OiBW
ZXJkYW5hOyI+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGJyZWFr
Ozwvc3Bhbj48L2ZvbnQ+PC9wPgoKPHAgY2xhc3M9ImVjeE1zb05vcm1hbCI+PGZvbnQgZmFjZT0i
VmVyZGFuYSIgc2l6ZT0iMiI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZTogMTBwdDsgZm9udC1mYW1p
bHk6IFZlcmRhbmE7Ij4mbmJzcDs8L3NwYW4+PC9mb250PjwvcD4KCjxwIGNsYXNzPSJlY3hNc29O
b3JtYWwiPjxmb250IGZhY2U9IlZlcmRhbmEiIHNpemU9IjIiPjxzcGFuIHN0eWxlPSJmb250LXNp
emU6IDEwcHQ7IGZvbnQtZmFtaWx5OiBWZXJkYW5hOyI+Jm5ic3A7Jm5ic3A7Jm5ic3A7IGNhc2Ug
QUNQSV9XUklURTo8L3NwYW4+PC9mb250PjwvcD4KCjxwIGNsYXNzPSJlY3hNc29Ob3JtYWwiPjxm
b250IGZhY2U9IlZlcmRhbmEiIHNpemU9IjIiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6IDEwcHQ7
IGZvbnQtZmFtaWx5OiBWZXJkYW5hOyI+Jm5ic3A7PC9zcGFuPjwvZm9udD48L3A+Cgo8cCBjbGFz
cz0iZWN4TXNvTm9ybWFsIj48Zm9udCBmYWNlPSJWZXJkYW5hIiBzaXplPSIyIj48c3BhbiBzdHls
ZT0iZm9udC1zaXplOiAxMHB0OyBmb250LWZhbWlseTogVmVyZGFuYTsiPiZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBTdGF0dXMgPSBBY3BpT3NXcml0ZVBjaUNvbmZp
Z3VyYXRpb24gKFBjaUlkLApQY2lSZWdpc3Rlciw8L3NwYW4+PC9mb250PjwvcD4KCjxwIGNsYXNz
PSJlY3hNc29Ob3JtYWwiPjxmb250IGZhY2U9IlZlcmRhbmEiIHNpemU9IjIiPjxzcGFuIHN0eWxl
PSJmb250LXNpemU6IDEwcHQ7IGZvbnQtZmFtaWx5OiBWZXJkYW5hOyI+Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICpWYWx1ZSwgQml0V2lk
dGgpOzwvc3Bhbj48L2ZvbnQ+PC9wPgoKPHAgY2xhc3M9ImVjeE1zb05vcm1hbCI+PGZvbnQgZmFj
ZT0iVmVyZGFuYSIgc2l6ZT0iMiI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZTogMTBwdDsgZm9udC1m
YW1pbHk6IFZlcmRhbmE7Ij4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsgYnJlYWs7PC9zcGFuPjwvZm9udD48L3A+Cgo8cCBjbGFzcz0iZWN4TXNvTm9ybWFsIj48Zm9u
dCBmYWNlPSJWZXJkYW5hIiBzaXplPSIyIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOiAxMHB0OyBm
b250LWZhbWlseTogVmVyZGFuYTsiPiZuYnNwOzwvc3Bhbj48L2ZvbnQ+PC9wPgoKPHAgY2xhc3M9
ImVjeE1zb05vcm1hbCI+PGZvbnQgZmFjZT0iVmVyZGFuYSIgc2l6ZT0iMiI+PHNwYW4gc3R5bGU9
ImZvbnQtc2l6ZTogMTBwdDsgZm9udC1mYW1pbHk6IFZlcmRhbmE7Ij4mbmJzcDsmbmJzcDsmbmJz
cDsgZGVmYXVsdDo8L3NwYW4+PC9mb250PjwvcD4KCjxwIGNsYXNzPSJlY3hNc29Ob3JtYWwiPjxm
b250IGZhY2U9IlZlcmRhbmEiIHNpemU9IjIiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6IDEwcHQ7
IGZvbnQtZmFtaWx5OiBWZXJkYW5hOyI+Jm5ic3A7PC9zcGFuPjwvZm9udD48L3A+Cgo8cCBjbGFz
cz0iZWN4TXNvTm9ybWFsIj48Zm9udCBmYWNlPSJWZXJkYW5hIiBzaXplPSIyIj48c3BhbiBzdHls
ZT0iZm9udC1zaXplOiAxMHB0OyBmb250LWZhbWlseTogVmVyZGFuYTsiPiZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBTdGF0dXMgPSBBRV9CQURfUEFSQU1FVEVSOzwv
c3Bhbj48L2ZvbnQ+PC9wPgoKPHAgY2xhc3M9ImVjeE1zb05vcm1hbCI+PGZvbnQgZmFjZT0iVmVy
ZGFuYSIgc2l6ZT0iMiI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZTogMTBwdDsgZm9udC1mYW1pbHk6
IFZlcmRhbmE7Ij4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgYnJl
YWs7PC9zcGFuPjwvZm9udD48L3A+Cgo8cCBjbGFzcz0iZWN4TXNvTm9ybWFsIj48Zm9udCBmYWNl
PSJWZXJkYW5hIiBzaXplPSIyIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOiAxMHB0OyBmb250LWZh
bWlseTogVmVyZGFuYTsiPiZuYnNwOyZuYnNwOyZuYnNwOyB9PC9zcGFuPjwvZm9udD48L3A+Cgo8
cCBjbGFzcz0iZWN4TXNvTm9ybWFsIj48Zm9udCBjb2xvcj0iYmx1ZSIgZmFjZT0iVmVyZGFuYSIg
c2l6ZT0iMiI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZTogMTBwdDsgZm9udC1mYW1pbHk6IFZlcmRh
bmE7IGNvbG9yOiBibHVlOyI+Jm5ic3A7PC9zcGFuPjwvZm9udD48L3A+Cgo8cCBjbGFzcz0iZWN4
TXNvTm9ybWFsIj48Zm9udCBjb2xvcj0iYmx1ZSIgZmFjZT0iVmVyZGFuYSIgc2l6ZT0iMiI+PHNw
YW4gc3R5bGU9ImZvbnQtc2l6ZTogMTBwdDsgZm9udC1mYW1pbHk6IFZlcmRhbmE7IGNvbG9yOiBi
bHVlOyI+V2hpY2ggbWVhbnMgdGhhdCBzaW5jZSBBRV9FUlJPUiBpcyBiZWluZwpyZXR1cm5lZCAo
YW5kIHRoZSBGdW5jdGlvbiBwYXJhbWV0ZXIgaXMgQUNQSV9SRUFEKSwgdGhlIGVycm9yIG11c3Qg
Y29tZSBmcm9tCnlvdXIgaW1wbGVtZW50YXRpb24gb2YgQWNwaU9zUmVhZFBjaUNvbmZpZ3VyYXRp
b24uPC9zcGFuPjwvZm9udD48L3A+Cgo8cCBjbGFzcz0iZWN4TXNvTm9ybWFsIj48Zm9udCBjb2xv
cj0iYmx1ZSIgZmFjZT0iVmVyZGFuYSIgc2l6ZT0iMiI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZTog
MTBwdDsgZm9udC1mYW1pbHk6IFZlcmRhbmE7IGNvbG9yOiBibHVlOyI+Jm5ic3A7PC9zcGFuPjwv
Zm9udD48L3A+Cgo8cCBjbGFzcz0iZWN4TXNvTm9ybWFsIj48Zm9udCBjb2xvcj0iYmx1ZSIgZmFj
ZT0iVmVyZGFuYSIgc2l6ZT0iMiI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZTogMTBwdDsgZm9udC1m
YW1pbHk6IFZlcmRhbmE7IGNvbG9yOiBibHVlOyI+Qm9iPC9zcGFuPjwvZm9udD48L3A+Cgo8cCBj
bGFzcz0iZWN4TXNvTm9ybWFsIj48Zm9udCBjb2xvcj0iYmx1ZSIgZmFjZT0iVmVyZGFuYSIgc2l6
ZT0iMiI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZTogMTBwdDsgZm9udC1mYW1pbHk6IFZlcmRhbmE7
IGNvbG9yOiBibHVlOyI+Jm5ic3A7PC9zcGFuPjwvZm9udD48L3A+Cgo8ZGl2IHN0eWxlPSJib3Jk
ZXItc3R5bGU6IG5vbmUgbm9uZSBub25lIHNvbGlkOyBib3JkZXItY29sb3I6IC1tb3otdXNlLXRl
eHQtY29sb3IgLW1vei11c2UtdGV4dC1jb2xvciAtbW96LXVzZS10ZXh0LWNvbG9yIGJsdWU7IGJv
cmRlci13aWR0aDogbWVkaXVtIG1lZGl1bSBtZWRpdW0gMS41cHQ7IHBhZGRpbmc6IDBpbiAwaW4g
MGluIDRwdDsiPgoKPHAgY2xhc3M9ImVjeE1zb05vcm1hbCI+PGZvbnQgZmFjZT0iVmVyZGFuYSIg
c2l6ZT0iMiI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZTogMTBwdDsgZm9udC1mYW1pbHk6IFZlcmRh
bmE7Ij4mbmJzcDs8L3NwYW4+PC9mb250PjwvcD4KCjwvZGl2PgoKPC9kaXY+IAkJIAkgICAJCSAg
PGJyIC8+PGhyIC8+SG90bWFpbDogVHJ1c3RlZCBlbWFpbCB3aXRoIHBvd2VyZnVsIFNQQU0gcHJv
dGVjdGlvbi4gPGEgaHJlZj0naHR0cHM6Ly9zaWdudXAubGl2ZS5jb20vc2lnbnVwLmFzcHg/aWQ9
NjA5NjknIHRhcmdldD0nX25ldyc+U2lnbiB1cCBub3cuPC9hPjwvYm9keT4KPC9odG1sPg==
--===============2532523945163423108==--

