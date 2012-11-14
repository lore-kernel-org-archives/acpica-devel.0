Content-Type: multipart/mixed; boundary="===============0402616599023990448=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [RESEND] [PATCH 1/2] acpica Makefile: Make it possible
 to	pass additional CFLAGS when invoking make
Date: Wed, 14 Nov 2012 17:47:49 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E346BDA6FF@ORSMSX101.amr.corp.intel.com>
In-Reply-To: 1372054.QLoJ56Viao@hammer82.arch.suse.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0402616599023990448==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Yes, I understand. We are thinking about what the defaults should be.

However, of course we will add the ability to pass in flags.
Thanks,
Bob


> -----Original Message-----
> From: Thomas Renninger [mailto:trenn(a)suse.de]
> Sent: Wednesday, November 14, 2012 9:46 AM
> To: Moore, Robert
> Cc: devel(a)acpica.org
> Subject: Re: [Devel] [RESEND] [PATCH 1/2] acpica Makefile: Make it
> possible to pass additional CFLAGS when invoking make
> =

> On Wednesday, November 14, 2012 03:43:04 PM Moore, Robert wrote:
> > We have to think about _FORTIFY_SOURCE a bit more because we have had
> > problems on some hosts with the -O2 flag.
> =

> But this is the whole point.
> Currently I cannot see a possibility to pass a compiler flag dynamically
> via make at all to give someone the chance to remove _FORTIFY_SOURCE or
> add/remove other compiler flags dynamically (without the need of modifying
> the Makefile itself).
> =

> I do not care much about the default CFLAGS, but we need a possibility to
> pass optional flags dynamically.
> =

> Thanks,
> =

>    Thomas

--===============0402616599023990448==--

