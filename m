Content-Type: multipart/mixed; boundary="===============0641620864839603875=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH 0/2] Fix DBG2 compilation template issue
Date: Wed, 23 Oct 2013 15:25:06 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37C78BE8D@ORSMSX103.amr.corp.intel.com>
In-Reply-To: CAFoFrHadi6h+77pB1dR7ixemLx+xy+A_eHdahvdm3MDq=2w82A@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0641620864839603875==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I have started on it, but if I don't have the time, perhaps you can help. I=
'll let you know of my progress later today.
Bob


> -----Original Message-----
> From: Naresh Bhat [mailto:naresh.bhat(a)linaro.org]
> Sent: Wednesday, October 23, 2013 2:07 AM
> To: Moore, Robert
> Cc: devel(a)acpica.org; linaro-acpi(a)lists.linaro.org
> Subject: Re: [Devel] [PATCH 0/2] Fix DBG2 compilation template issue
> =

> Hi Robert,
> =

> Thank you very much.  I will implement sub-table compilation method and
> post the patches.
> =

> Regards
> -Naresh Bhat
> =

> On 23 October 2013 02:28, Moore, Robert <robert.moore(a)intel.com> wrote:
> > The real issue is that the code to actually compile a DBG2 (including
> all subtables) has not been written yet.
> >
> > Here's an example of a large DBG2 with subtables.
> >
> >
> >
> > /*
> >  * Intel ACPI Component Architecture
> >  * AML Disassembler version 20120711-32 [Aug 14 2012]
> >  * Copyright (c) 2000 - 2012 Intel Corporation
> >  *
> >  * Disassembly of dbg2.aml, Tue Aug 14 09:34:28 2012
> >  *
> >  * ACPI Data Table [DBG2]
> >  *
> >  * Format: [HexOffset DecimalOffset ByteLength]  FieldName :
> > FieldValue  */
> >
> > [000h 0000   4]                    Signature : "DBG2"    [Debug Port
> table type 2]
> > [004h 0004   4]                 Table Length : 000000CE
> > [008h 0008   1]                     Revision : 01
> > [009h 0009   1]                     Checksum : B1
> > [00Ah 0010   6]                       Oem ID : "INTEL "
> > [010h 0016   8]                 Oem Table ID : "TEMPLATE"
> > [018h 0024   4]                 Oem Revision : 00000000
> > [01Ch 0028   4]              Asl Compiler ID : "INTL"
> > [020h 0032   4]        Asl Compiler Revision : 20120711
> >
> > [024h 0036   4]                  Info Offset : 0000002C
> > [028h 0040   4]                   Info Count : 00000002
> >
> > [02Ch 0044   1]                     Revision : 00
> > [02Dh 0045   2]                       Length : 004C
> > [02Fh 0047   1]               Register Count : 02
> > [030h 0048   2]              Namepath Length : 0009
> > [032h 0050   2]              Namepath Offset : 0036
> > [034h 0052   2]              OEM Data Length : 000D
> > [036h 0054   2]              OEM Data Offset : 003F
> > [038h 0056   2]                    Port Type : 8000
> > [03Ah 0058   2]                 Port Subtype : 0000
> > [03Ch 0060   2]                     Reserved : 0000
> > [03Eh 0062   2]          Base Address Offset : 0016
> > [040h 0064   2]          Address Size Offset : 002E
> >
> > [042h 0066  12]        Base Address Register : [Generic Address
> Structure]
> > [042h 0066   1]                     Space ID : 01 [SystemIO]
> > [043h 0067   1]                    Bit Width : 32
> > [044h 0068   1]                   Bit Offset : 00
> > [045h 0069   1]         Encoded Access Width : 03 [DWord Access:32]
> > [046h 0070   8]                      Address : 1122334455667788
> >
> >
> > [04Eh 0078  12]        Base Address Register : [Generic Address
> Structure]
> > [04Eh 0078   1]                     Space ID : 01 [SystemIO]
> > [04Fh 0079   1]                    Bit Width : 64
> > [050h 0080   1]                   Bit Offset : 00
> > [051h 0081   1]         Encoded Access Width : 04 [QWord Access:64]
> > [052h 0082   8]                      Address : AABBCCDDEEFF0011
> >
> > [05Ah 0090   4]                 Address Size : 76543210
> > [05Eh 0094   4]                 Address Size : FEDCBA98
> >
> > [062h 0098   9]                     Namepath : "MyDevice"
> >
> > [06Bh 0107  13]                     OEM Data : 01 02 03 04 05 06 07 08
> 09 0A 0B 0C 0D
> >
> > [078h 0120   1]                     Revision : 00
> > [079h 0121   2]                       Length : 0056
> > [07Bh 0123   1]               Register Count : 01
> > [07Ch 0124   2]              Namepath Length : 0010
> > [07Eh 0126   2]              Namepath Offset : 0026
> > [080h 0128   2]              OEM Data Length : 0020
> > [082h 0130   2]              OEM Data Offset : 0036
> > [084h 0132   2]                    Port Type : 8000
> > [086h 0134   2]                 Port Subtype : 0000
> > [088h 0136   2]                     Reserved : 0000
> > [08Ah 0138   2]          Base Address Offset : 0016
> > [08Ch 0140   2]          Address Size Offset : 0022
> >
> > [08Eh 0142  12]        Base Address Register : [Generic Address
> Structure]
> > [08Eh 0142   1]                     Space ID : 01 [SystemIO]
> > [08Fh 0143   1]                    Bit Width : 64
> > [090h 0144   1]                   Bit Offset : 00
> > [091h 0145   1]         Encoded Access Width : 04 [QWord Access:64]
> > [092h 0146   8]                      Address : AABBCCDDEEFF0011
> >
> > [09Ah 0154   4]                 Address Size : FEDCBA98
> >
> > [09Eh 0158  16]                     Namepath : "\\_SB_.PCI0.DBGP"
> >
> > [0AEh 0174  16]                     OEM Data : 41 42 43 44 45 46 47 48
> 49 50 51 52 53 54 55 56
> > [0BEh 0190  16]                              : 57 58 59 01 02 03 04 05
> 06 07 08 09 0A 0B 0C 0D
> >
> >
> >
> >
> >
> >
> >> -----Original Message-----
> >> From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] On
> >> Behalf Of naresh.bhat(a)linaro.org
> >> Sent: Wednesday, October 16, 2013 12:49 AM
> >> To: devel(a)acpica.org
> >> Cc: linaro-acpi(a)lists.linaro.org
> >> Subject: [Devel] [PATCH 0/2] Fix DBG2 compilation template issue
> >>
> >> From: Naresh Bhat <naresh.bhat(a)linaro.org>
> >>
> >> The patches try to fix the DBG2 table compilation issue and also
> >> tries to add a template support for DBG2 tables.
> >>
> >> Naresh Bhat (2):
> >>   iASL: Fix Table Info handler for DBG2
> >>   iASL: Add template support for dbg2
> >>
> >>  source/common/dmtable.c      |    2 +-
> >>  source/compiler/dtcompiler.h |    1 +
> >>  source/compiler/dttemplate.h |   10 ++++++++++
> >>  3 files changed, 12 insertions(+), 1 deletion(-)
> >>
> >> --
> >> 1.7.9.5
> >>
> >> _______________________________________________
> >> Devel mailing list
> >> Devel(a)acpica.org
> >> https://lists.acpica.org/mailman/listinfo/devel

--===============0641620864839603875==--

