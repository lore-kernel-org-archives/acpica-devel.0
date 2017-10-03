Content-Type: multipart/mixed; boundary="===============2809612675063240410=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rjw at rjwysocki.net>
Subject: Re: [Devel] [PATCH 15/18] acpi: use ARRAY_SIZE
Date: Tue, 03 Oct 2017 13:39:22 +0200
Message-ID: <5437275.MVdmGJ04h3@aspire.rjw.lan>
In-Reply-To: 20171002211622.30d324ca@blatinox-laptop.localdomain
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2809612675063240410==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tuesday, October 3, 2017 3:16:22 AM CEST J=C3=A9r=C3=A9my Lefaure wrote:
> On Mon, 02 Oct 2017 14:27:52 +0200
> "Rafael J. Wysocki" <rjw(a)rjwysocki.net> wrote:
> =

> > ACPICA is soewhat special code, though and I'm not taking or ACKing pat=
ches
> > for it directly as a rule.
> > =

> > For one, I'm not sure if ACPICA can use ARRAY_SIZE at all.
> Why is it special code that can't use ARRAY_SIZE ? Is it because this
> macro is defined in linux/kernel.h ?

Basically, yes.

ACPICA is a separate project and the kernel acquires its source code from
the upstream (which is used by other OSes too).  That is not the case for
any other code in the kernel I know about.


We strive to keep the ACPICA code in the kernel as close to the upstream as
reasonably possible for maintenance reasons, so we avoid doing Linux-specif=
ic
things in it.

As a rule of thumb, if you do cleanups like this one, better avoid the ACPI=
CA
code. :-)

Thanks,
Rafael


--===============2809612675063240410==--

