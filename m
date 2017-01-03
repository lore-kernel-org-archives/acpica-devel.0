Content-Type: multipart/mixed; boundary="===============5822317470686848301=="
MIME-Version: 1.0
From: Zhang Rui <rui.zhang at intel.com>
Subject: Re: [Devel] Missing _BQC method
Date: Tue, 03 Jan 2017 11:42:20 +0800
Message-ID: <1483414940.2320.35.camel@intel.com>
In-Reply-To: 8036e82a-c79b-6824-1245-bf5fb027a1fa@yahoo.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5822317470686848301==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sun, 2017-01-01 at 17:01 -0500, Anthony Jenkins wrote:
> What may the OSPM assume/do about a missing _BQC (Brightness Query
> Current level) method?

_BQC is optional according to the latest ACPI spec.
I don't know about the others, but in Linux, the brightness level is
set to 100% during boot if _BQC is missing, and a cached value is used
to save the current brightness level.=C2=A0

thanks,
rui
> =C2=A0=C2=A0The last two HP ENVY laptops I owned do not have
> this method, and FreeBSD's acpi_video driver (currently) requires it
> to
> control screen brightness - unless I can assume _only_ the OSPM can
> set
> the screen brightness.=C2=A0=C2=A0My current workaround is a patch to the=
 DSDT
> to
> add a simple method that copies and returns a variable used by _BCM
> (Brightness Control Method).
> =

> Thanks in advance,
>=20

--===============5822317470686848301==--

