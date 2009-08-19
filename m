Content-Type: multipart/mixed; boundary="===============6805171316002289318=="
MIME-Version: 1.0
From: bugzilla-daemon at mail.opensource.intel.com
Subject: [Devel] [Bug 738] iASL mishandles Alias() when target is longer than
 single nameseg
Date: Wed, 19 Aug 2009 14:49:24 -0700
Message-ID: <20090819214924.B6FA32068DC60@mail.opensource.intel.com>
In-Reply-To: bug-738-162@
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6805171316002289318==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

show_bug.cgi?id=3D738


Sergiy <yakovlevs(a)ami.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|RESOLVED                    |REOPENED
                 CC|                            |yakovlevs(a)ami.com
         Resolution|FIXED                       |




--- Comment #4 from Sergiy <yakovlevs(a)ami.com>  2009-08-19 14:49:24 ---
In iASL ACPICA is version 20090730.
I found exactly opposite issue now.
I have a following code =


    Name(PRSA, ResourceTemplate(){    // Link name: LNKA
        IRQ(Level, ActiveLow, Shared, LLKA) {3,4,5,6,7,10,11,12,14,15}
    })
    Alias(PRSA,PRSB)    // Link name: LNKB
iASL generates not found error:

Here is the iASL output:
Build\PCItree.asl   194:     Alias(PRSA,PRSB)    // Link name: LNKB
Error    4064 -                       ^ Object not found or not accessible =
from
scope (PRSB)

-- =

Configure bugmail: userprefs.cgi?tab=3Demail
------- You are receiving this mail because: -------
You are on the CC list for the bug.

--===============6805171316002289318==--

