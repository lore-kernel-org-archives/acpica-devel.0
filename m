Content-Type: multipart/mixed; boundary="===============5513329364759180576=="
MIME-Version: 1.0
From: bugzilla-daemon at mail.opensource.intel.com
Subject: [Devel] [Bug 738] iASL mishandles Alias() when target is longer than
 single nameseg
Date: Wed, 26 Aug 2009 00:22:43 -0700
Message-ID: <20090826072244.1666B20679802@mail.opensource.intel.com>
In-Reply-To: bug-738-162@
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5513329364759180576==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

show_bug.cgi?id=3D738


Ming Lin <ming.m.lin(a)intel.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
 Attachment #841 is|0                           |1
           obsolete|                            |




--- Comment #11 from Ming Lin <ming.m.lin(a)intel.com>  2009-08-26 00:22:43=
 ---
Created an attachment (id=3D842)
 --> (attachment.cgi?id=3D842)
new patch

The patch at comment #6 was wrong, please ignore it.
It works just because the uninitialized "Node" accidentally points to a
valid node.

Scope(\_SB){
    Name(PRSA, ResourceTemplate(){    // Link name: LNKA
        IRQ(Level, ActiveLow, Shared, LLKA) {3,4,5,6,7,10,11,12,14,15}
    })
    Alias(PRSA,PRSB)    // Link name: LNKB
}

In LdNamespace1Begin, node "LLKA" is pushed, as below

#0  AcpiDsScopeStackPush  at ../dispatcher/dswscope.c:189
#1  AcpiNsLookup at ../namespace/nsaccess.c:761
#2  LdLoadResourceElements at aslload.c:337
#3  LdNamespace1Begin at aslload.c:536

But LdNamespace2Begin does not push "LLKA", as below

    /* Ignore Ops with no namespace node */

    Node =3D Op->Asl.Node;
    if (!Node)
    {
        return (AE_OK);
    }

Below patch sets the "Node" for Op, so LdNamespace2Begin can also push
"LLKA" just as LdNamespace1Begin does.

diff --git a/compiler/aslload.c b/compiler/aslload.c
index e61e062..8d06544 100644
--- a/compiler/aslload.c
+++ b/compiler/aslload.c
@@ -353,6 +353,7 @@ LdLoadResourceElements (

     Node->Value =3D (UINT32) Op->Asl.Value.Integer;
     Node->Op =3D Op;
+    Op->Asl.Node =3D Node;

     /*
      * Now enter the predefined fields, for easy lookup when referenced

-- =

Configure bugmail: userprefs.cgi?tab=3Demail
------- You are receiving this mail because: -------
You are on the CC list for the bug.

--===============5513329364759180576==--

