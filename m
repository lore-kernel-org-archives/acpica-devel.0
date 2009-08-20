Content-Type: multipart/mixed; boundary="===============4499758046357143918=="
MIME-Version: 1.0
From: bugzilla-daemon at mail.opensource.intel.com
Subject: [Devel] [Bug 738] iASL mishandles Alias() when target is longer than
 single nameseg
Date: Thu, 20 Aug 2009 08:25:20 -0700
Message-ID: <20090820152520.6409020682076@mail.opensource.intel.com>
In-Reply-To: bug-738-162@
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4499758046357143918==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

show_bug.cgi?id=3D738


Sergiy <yakovlevs(a)ami.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
           Severity|normal                      |blocker




--- Comment #5 from Sergiy <yakovlevs(a)ami.com>  2009-08-20 08:25:19 ---
Little bit more information about this issue.

the code I'm compiling is like that:

Scope(\_SB){
...
    Name(PRSA, ResourceTemplate(){    // Link name: LNKA
        IRQ(Level, ActiveLow, Shared, LLKA) {3,4,5,6,7,10,11,12,14,15}
    })
    Alias(PRSA,PRSB)    // Link name: LNKB
    Alias(PRSA,PRSC)    // Link name: LNKC
    Alias(PRSA,PRSD)    // Link name: LNKD
    Alias(PRSA,PRSE)    // Link name: LNKE
    Alias(PRSA,PRSF)    // Link name: LNKF
    Alias(PRSA,PRSG)    // Link name: LNKG
    Alias(PRSA,PRSH)    // Link name: LNKH
....
}//end _SB Scope.

iASL generates error only at first ALIAS statement!

This is an Output screen:
//-----------------------------------------------
Intel ACPI Component Architecture
ASL Optimizing Compiler version 20090730 [Jul 30 2009]
Copyright (C) 2000 - 2009 Intel Corporation
Supports ACPI Specification Revision 4.0

Build\PCItree.asl   194:     Alias(PRSA,PRSB)    // Link name: LNKB
Error    4064 -                       ^ Object not found or not accessible =
from
scope (PRSB)

Board\IO\WPCD376I\WPCD376I.ASL   180:         Acquire(MUT0, 0xFFF)
Warning  1104 -            Possible operator timeout is ignored ^ =


ASL Input:  C:\A_WORK\DQ35JO_PCI.WRK\2009_08_05.RES\DSDT.ASL - 64 lines, 26=
1805
bytes, 1720 keywords
Compilation complete. 1 Errors, 1 Warnings, 0 Remarks, 460 Optimizations

BTW same issue exists in previouse version of iASL ACPI 3.0a compatible.

Thanks,
Sergiy.

-- =

Configure bugmail: userprefs.cgi?tab=3Demail
------- You are receiving this mail because: -------
You are on the CC list for the bug.

--===============4499758046357143918==--

