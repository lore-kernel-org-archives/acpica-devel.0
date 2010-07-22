Content-Type: multipart/mixed; boundary="===============1800800162492321311=="
MIME-Version: 1.0
From: Lin Ming <ming.m.lin at intel.com>
Subject: Re: [Devel] acpica-unix-20100702
Date: Thu, 22 Jul 2010 15:12:45 +0800
Message-ID: <1279782765.20942.10.camel@minggr.sh.intel.com>
In-Reply-To: 529709.48550.qm@web53908.mail.re2.yahoo.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1800800162492321311==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2010-07-22 at 15:07 +0800, Robert Hinson wrote:
> I downloaded this and went to the compiler directory and ran make.
> =

> =

> It came up with an error saying:
> =

> =

> make: *** No rule to make target `../components/debugger/dbfileio.c',
> needed by `dbfileio.o'.  Stop.
> =

> =

> There is no components directory.
> =

> =

> Did it not get included?
> =


See patch at
http://lists.acpica.org/pipermail/devel/2010-July/000170.html

And final patch is at acpica git repository.
http://git.moblin.org/cgit.cgi/acpica/commit/?id=3Db87ffc0b382356b5b83e56fe=
73882a2be62b13c6

Lin Ming


--===============1800800162492321311==--

