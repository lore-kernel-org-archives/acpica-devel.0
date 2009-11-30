Content-Type: multipart/mixed; boundary="===============4443289162837025513=="
MIME-Version: 1.0
From: Lin Ming <ming.m.lin at intel.com>
Subject: Re: [Devel] Using latest acpica release to write a driver.
Date: Mon, 30 Nov 2009 09:39:10 +0800
Message-ID: <1259545150.4877.11.camel@minggr.sh.intel.com>
In-Reply-To: SNT111-W69CF48131ED34E8F7D766BD990@phx.gbl
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4443289162837025513==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, 2009-11-28 at 10:35 +0800, Samuel Serapion wrote:
> Hi guys, this is my second attempt trying to write an acpi driver for
> ReactOS/Windows using your library.

We are glad that ReactOS is using the ACPICA code.

> But ive been running into some problems trying to run it in vmware
> 7.0. Attached is a log of this. If this isnt the right forum for this
> please feel free to point me in the right direction and call me names
> and what not.

ACPI: RSDP 000F6940 00024 (v02 PTLTD )
ACPI: XSDT 0C2F0885 0004C (v01 INTEL  440BX    06040000 VMW  01324272)
ACPI: FACP 0C2FEE98 000F4 (v04 INTEL  440BX    06040000 PTL  000F4240)
ACPI: DSDT 0C2F0A3D 0E45B (v01 PTLTD  Custom   06040000 MSFT 03000001)
ACPI: FACS 0C2FFFC0 00040
ACPI: BOOT 0C2F0A15 00028 (v01 PTLTD  $SBFTBL$ 06040000  LTP 00000001)
ACPI: APIC 0C2F09C5 00050 (v01 PTLTD     APIC   06040000  LTP 00000000)
ACPI: MCFG 0C2F0989 0003C (v01 PTLTD  $PCITBL$ 06040000  LTP 00000001)
ACPI: SRAT 0C2F0909 00080 (v02 VMWARE MEMPLUG  06040000 VMW  00000001)

Could you dump these acpi tables?
You can run a linux (Fedora, Ubuntu or others) on VMWare, then dump the
tables with acpidump tool.

Memory at 0x0000000C could not be read: Page not present.
kdb:> bt
Eip:
<acpi.sys:8a76 (drivers/bus/acpi/executer/exfield.c:278
(AcpiExReadDataFromField))>

Is this a bug of the bus driver, why is a not present page accessed?

Lin Ming

> =

> I would also like to say 2 other things, first thanks for making this
> great library, without it it would be imposible for open source
> projects to implement sane acpi support and second, stop confusing
> windows with msvc, gcc has been ported to windows since forever ago
> and a lot of people use it.(re platform headers).
> =

> Thanks in advance!
> =

> =

> ______________________________________________________________________
> Windows Live: Make it easier for your friends to see what you=E2=80=99re =
up to
> on Facebook.


--===============4443289162837025513==--

