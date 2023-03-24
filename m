Return-Path: <ukl@pengutronix.de>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E2FF184092
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ED0E58408B
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Message-ID: <20230324105938.p4olsh27uy5zdbbv@pengutronix.de>
References: <20230324075854.458341-1-u.kleine-koenig@pengutronix.de>
 <20230324095329.3oat5nuqhuqqycsr@bogus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6obh4u7kdvvmvoef"
Content-Disposition: inline
In-Reply-To: <20230324095329.3oat5nuqhuqqycsr@bogus>
Subject: Re: [Acpica-devel] [PATCH] ACPICA: Make check to install handler
 more obviously correct
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Fri, 24 Mar 2023 11:00:26 -0000
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, kernel@pengutronix.de, acpica-devel@lists.linuxfoundation.org, Len Brown <lenb@kernel.org>


--6obh4u7kdvvmvoef
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Mar 24, 2023 at 09:53:29AM +0000, Sudeep Holla wrote:
> On Fri, Mar 24, 2023 at 08:58:54AM +0100, Uwe Kleine-K=F6nig wrote:
> > The loop
> >=20
> > 	for (i =3D 0; i < ACPI_NUM_NOTIFY_TYPES; i++) {
> > 		if (handler_type & (i + 1)) {
> > 			...
> > 		}
> > 	}
> >=20
> > looks strange. Only with knowing that ACPI_NUM_NOTIFY_TYPES =3D=3D 2 yo=
u can
> > see that the two least significant bits are checked. Still replace
> >=20
> > 	i + 1
> >=20
> > by
> >=20
> > 	1 << i
> >=20
> > which shouldn't make a relevant difference to compiler and compiled
> > code, but is easier to understand for a human code reader.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> You need to submit this to ACPICA project first.
> Documentation/driver-api/acpi/linuxized-acpica.rst explains the process.
> Refer [1] for details for similar suggestion by Rafael.

My motivation isn't big enough to even read that. If the usual kernel
workflow doesn't work for ACPICA, let's drop the patch.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6obh4u7kdvvmvoef
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQdgpkACgkQj4D7WH0S
/k7gkQgAp3/vWYTAeTxJdQBeEcQRLdOX0d0ON7QnL/VDoCTGQ1owOjd1/8/p9Xeg
PvpCIH0KcUGqiKCTrKXKPWaSAlfWZpk3CrwDgY2XxYOVVV5tzepEzrACvI2gxIIn
XjhemOYqnJ6varurw2UdgbTjpxQGGBAu5fswmo+gYchBqsnGqL/b23dH9n2IS4Ru
6Ng16VbiinNydejRKn9FWTH+p1/FCsO4qUIopwJPNrQaM1XW6VyeLW5QOA1fJ3zy
lskkWBSzT9iMsp6gDbLMo2v8IunYcuZi6Tz/rp4B/JmBfIkdR/UE3+rx6I901rCc
MEm0487K3lXqudOj8ZiDwn0I17Nc4Q==
=Ii3L
-----END PGP SIGNATURE-----

--6obh4u7kdvvmvoef--
