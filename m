Content-Type: multipart/mixed; boundary="===============3724565443926396741=="
MIME-Version: 1.0
From: bugzilla-daemon at mail.opensource.intel.com
Subject: [Devel] [Bug 738] iASL mishandles Alias() when target is longer than
 single nameseg
Date: Mon, 24 Aug 2009 18:49:41 -0700
Message-ID: <20090825014941.60B5E236D0FAB@mail.opensource.intel.com>
In-Reply-To: bug-738-162@
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3724565443926396741==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

show_bug.cgi?id=3D738


Ming Lin <ming.m.lin(a)intel.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |ming.m.lin(a)intel.com




--- Comment #8 from Ming Lin <ming.m.lin(a)intel.com>  2009-08-24 18:49:40 =
---
(In reply to comment #7)
> =

> But this is not the fix for me.

Sorry, but I'm confused. =

Have you tried the patch at comment #6?
http://bugzilla.acpica.org/attachment.cgi?id=3D841
It's a C code patch, not an ASL code workaround.
It's the fix for you.

> =

> Could you tell me when to expect iASL with fix for this issue.
> =


Would you please help to test the patch?
If the patch fixes the bug, we will integrate it into next release.

Thanks,
Lin Ming

-- =

Configure bugmail: userprefs.cgi?tab=3Demail
------- You are receiving this mail because: -------
You are on the CC list for the bug.

--===============3724565443926396741==--

