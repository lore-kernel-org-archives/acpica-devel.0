Content-Type: multipart/mixed; boundary="===============9205249802856895848=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] Can a userspace tool to read the Embedded Controller
 get	added to acpica sources?
Date: Thu, 09 Sep 2010 15:24:11 -0700
Message-ID: <4911F71203A09E4D9981D27F9D830858AF06FA92@orsmsx503.amr.corp.intel.com>
In-Reply-To: 201009021731.22944.trenn@suse.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============9205249802856895848==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


>I didn't adopt the whole coding style to ACPICA one,
>hope that is ok.

Any os-independent code should be in the acpica style. Otherwise, it is an =
os-dependent style.


>-----Original Message-----
>From: Thomas Renninger [mailto:trenn(a)suse.de]
>Sent: Thursday, September 02, 2010 8:31 AM
>To: Moore, Robert
>Cc: devel(a)acpica.org
>Subject: Re: [Devel] Can a userspace tool to read the Embedded Controller
>get added to acpica sources?
>
>On Friday 27 August 2010 23:47:55 Moore, Robert wrote:
>> Seems like it will have lots of very EC-specific stuff, so sure, we
>> can add to ACPICA. Make sure any OS-dependent stuff is modularized.
>Ok, I tried on that.
>
>Find attached the source file which should go to:
>source/tools/ec_access/ec_access.c
>and the Makefile for:
>generate/linux/Makefile.ec_access
>
>I used stderr, fprintf, open, read, write, sync.
>Beside the last, some other files are doing the same.
>
>I didn't explicitly check a real read/write on a recent kernel
>after these changes, but I did before and there weren't that much
>modifications.
>
>I didn't adopt the whole coding style to ACPICA one,
>hope that is ok.
>
>      Thomas

--===============9205249802856895848==--

