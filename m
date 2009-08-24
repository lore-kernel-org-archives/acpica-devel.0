Content-Type: multipart/mixed; boundary="===============4722476408030756609=="
MIME-Version: 1.0
From: bugzilla-daemon at mail.opensource.intel.com
Subject: [Devel] [Bug 738] iASL mishandles Alias() when target is longer than
 single nameseg
Date: Sun, 23 Aug 2009 19:32:46 -0700
Message-ID: <20090824023246.54A0B20F9F8B2@mail.opensource.intel.com>
In-Reply-To: bug-738-162@
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4722476408030756609==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

show_bug.cgi?id=3D738





--- Comment #6 from Ming Lin <ming.m.lin(a)intel.com>  2009-08-23 19:32:45 =
---
Created an attachment (id=3D841)
 --> (attachment.cgi?id=3D841)
proposed patch

Scope(\_SB){
    Name(PRSA, ResourceTemplate(){    // Link name: LNKA
    IRQ(Level, ActiveLow, Shared, LLKA) {3,4,5,6,7,10,11,12,14,15}
        Alias(PRSA,PRSB)    // Link name: LNKB
    })
}

LdNamespace1Begin pushes ScopeInfo for _SB, PRSA, LLKA
but LdNamespace2Begin only pushes ScopeInfo for _SB, _PRSA (no LLKA)

3 ScopeInfo pops in LdCommonNamespaceEnd, but only 2 ScopInfo pushes in
LdNamespace2Begin. This causes AcpiNsLookup fails for "PRSA", because ScopI=
nfo
was popped.

The attached one line patch fixes the bug.
I tested it with ASLTS, it works.

Sergiy, would you please help to test the patch?

Thanks.

-- =

Configure bugmail: userprefs.cgi?tab=3Demail
------- You are receiving this mail because: -------
You are on the CC list for the bug.

--===============4722476408030756609==--

