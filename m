Content-Type: multipart/mixed; boundary="===============1934679680838574062=="
MIME-Version: 1.0
From: Thomas Renninger <trenn at suse.de>
Subject: Re: [Devel] Reserved method (_PLD) is a buffer instead of a package
Date: Thu, 08 Jul 2010 11:11:59 +0200
Message-ID: <201007081111.59571.trenn@suse.de>
In-Reply-To: 4911F71203A09E4D9981D27F9D830858A10EFE45@orsmsx503.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1934679680838574062==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wednesday 07 July 2010 21:52:02 Moore, Robert wrote:
... =

> Newer versions of iASL will in fact complain about a named buffer that
> is returned, I think.
I checked with version 20100702 and it does not.
Never mind, I just want to get a picture about this problem.
It would be a feature/enhancement to get iasl behave equal, but probably
with a rather low prio...
 =

> Yes, your change at the end is correct.
Thanks!

> The ACPICA auto-repair code should be able to repair this problem. If
> a buffer is returned, it will wrap a package object around it.
Oh dear. If the world would be perfect, then...

> That doesn't change the fact that the original ASL is incorrect.
So the policy is to workaround/"runtime fix" the buggy ASL code in the =

kernel/interpreter (silently?) and complain about it in the compiler.
Sounds reasonable.

Thanks,

    Thomas

--===============1934679680838574062==--

