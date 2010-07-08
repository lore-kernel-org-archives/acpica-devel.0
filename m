Content-Type: multipart/mixed; boundary="===============2219128930646280470=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] Reserved method (_PLD) is a buffer instead of a package
Date: Thu, 08 Jul 2010 08:36:10 -0700
Message-ID: <4911F71203A09E4D9981D27F9D830858A1164BA7@orsmsx503.amr.corp.intel.com>
In-Reply-To: 201007081111.59571.trenn@suse.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2219128930646280470==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



>-----Original Message-----
>From: Thomas Renninger [mailto:trenn(a)suse.de]
>Sent: Thursday, July 08, 2010 2:12 AM
>To: Moore, Robert
>Cc: devel(a)acpica.org
>Subject: Re: [Devel] Reserved method (_PLD) is a buffer instead of a
>package
>
>On Wednesday 07 July 2010 21:52:02 Moore, Robert wrote:
>...
>> Newer versions of iASL will in fact complain about a named buffer that
>> is returned, I think.
>I checked with version 20100702 and it does not.


Maybe only in very limited cases, because a named object can be changed at =
runtime.


>Never mind, I just want to get a picture about this problem.
>It would be a feature/enhancement to get iasl behave equal, but probably
>with a rather low prio...
>
>> Yes, your change at the end is correct.
>Thanks!
>
>> The ACPICA auto-repair code should be able to repair this problem. If
>> a buffer is returned, it will wrap a package object around it.
>Oh dear. If the world would be perfect, then...
>
>> That doesn't change the fact that the original ASL is incorrect.
>So the policy is to workaround/"runtime fix" the buggy ASL code in the
>kernel/interpreter (silently?) and complain about it in the compiler.
>Sounds reasonable.

Yes, that is the behavior.

1) The goal of iASL is to catch as many errors at compile time as possible.

2) The goal of ACPICA is to detect and repair as many errors at runtime as =
possible, and to always provide the drivers with valid data (from the evalu=
ation of a predefined ACPI name) as long as AE_OK has been returned.

>
>Thanks,
>
>    Thomas

--===============2219128930646280470==--

