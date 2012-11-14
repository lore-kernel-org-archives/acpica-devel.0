Content-Type: multipart/mixed; boundary="===============6824293770239821943=="
MIME-Version: 1.0
From: Thomas Renninger <trenn at suse.de>
Subject: Re: [Devel] [RESEND] [PATCH 1/2] acpica Makefile: Make it possible
 to	pass additional CFLAGS when invoking make
Date: Wed, 14 Nov 2012 18:46:17 +0100
Message-ID: <1372054.QLoJ56Viao@hammer82.arch.suse.de>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E346BD9D7F@ORSMSX101.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6824293770239821943==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wednesday, November 14, 2012 03:43:04 PM Moore, Robert wrote:
> We have to think about _FORTIFY_SOURCE a bit more because we have had
> problems on some hosts with the -O2 flag.

But this is the whole point.
Currently I cannot see a possibility to pass a compiler flag dynamically
via make at all to give someone the chance to remove
_FORTIFY_SOURCE or add/remove other compiler flags dynamically
(without the need of modifying the Makefile itself).

I do not care much about the default CFLAGS, but we need a
possibility to pass optional flags dynamically.

Thanks,

   Thomas

--===============6824293770239821943==--

