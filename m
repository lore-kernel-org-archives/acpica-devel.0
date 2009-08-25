Content-Type: multipart/mixed; boundary="===============0037577008291206573=="
MIME-Version: 1.0
From: bugzilla-daemon at mail.opensource.intel.com
Subject: [Devel] [Bug 738] iASL mishandles Alias() when target is longer than
 single nameseg
Date: Tue, 25 Aug 2009 08:57:09 -0700
Message-ID: <20090825155710.0FF63214CF3FD@mail.opensource.intel.com>
In-Reply-To: bug-738-162@
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0037577008291206573==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

show_bug.cgi?id=3D738





--- Comment #9 from Sergiy <yakovlevs(a)ami.com>  2009-08-25 08:57:09 ---
Dear Lin Ming

Sorry for confusing you but I thought that first 2 lines of comment #6 was =
the
patch:
Scope(\_SB){
    Name(PRSA, ResourceTemplate(){    // Link name: LNKA
    IRQ(Level, ActiveLow, Shared, LLKA) {3,4,5,6,7,10,11,12,14,15}
        Alias(PRSA,PRSB)    // Link name: LNKB
    })
}
Since it slightly different from what I have:

In your comment #6, Alias term located inside the scope of the
ResourceTemplate,
In example I was giving it was outside.
Scope(\_SB){
    Name(PRSA, ResourceTemplate(){    // Link name: LNKA
        IRQ(Level, ActiveLow, Shared, LLKA) {3,4,5,6,7,10,11,12,14,15}
    })
    Alias(PRSA,PRSB)    // Link name: LNKB
}

Meanwhile I'm having some difficulty building ACPI CA components.

I can't build the sources It is possible I'm missing some libraries or tool=
s.
I have VC 9 the project is for VC 6.

So could you please build the version of iASL with that fix for me and atta=
ch =

*.exe file to this ISSUE tracker. Or send it directly to my email
<yakovlevs(a)ami.com> with changed extension like iasl.ex_.

I'll be happy to test it with my project.

Thanks,
Sergiy.

-- =

Configure bugmail: userprefs.cgi?tab=3Demail
------- You are receiving this mail because: -------
You are on the CC list for the bug.

--===============0037577008291206573==--

