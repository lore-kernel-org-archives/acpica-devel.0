Return-Path: <ukl@pengutronix.de>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3DFA840347
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7CAEE4016C
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Message-ID: <20230324145716.irqgescu3pvnjobt@pengutronix.de>
References: <20230324075854.458341-1-u.kleine-koenig@pengutronix.de>
 <20230324095329.3oat5nuqhuqqycsr@bogus>
 <20230324105938.p4olsh27uy5zdbbv@pengutronix.de>
 <20230324143849.2y4rdnes3irhw2b2@bogus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="icdv5bytu7kohzlb"
Content-Disposition: inline
In-Reply-To: <20230324143849.2y4rdnes3irhw2b2@bogus>
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
Date: Fri, 24 Mar 2023 14:57:39 -0000
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, kernel@pengutronix.de, acpica-devel@lists.linuxfoundation.org, Len Brown <lenb@kernel.org>


--icdv5bytu7kohzlb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Mar 24, 2023 at 02:38:49PM +0000, Sudeep Holla wrote:
> On Fri, Mar 24, 2023 at 11:59:38AM +0100, Uwe Kleine-K=F6nig wrote:
> >
> > My motivation isn't big enough to even read that. If the usual kernel
> > workflow doesn't work for ACPICA, let's drop the patch.
>=20
> :(, but ACPICA is reused on other OSes and hence the need to be a separate
> project. It is very similar to the way DTC changes are done elsewhere and
> imported into the kernel.

Feel free to pick up my patch.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--icdv5bytu7kohzlb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQduksACgkQj4D7WH0S
/k5iEAf/WFpLa/DLOX6wun2sCZzWLLazByHJx6+oUS7i3vD8dcSylkI8SYrDtmju
XUqNM1mX0TfJX0U8WY66OoaJhMIXnAzRr+qhqOP1SbuP6JOU1NuuoC2wKIHzohCK
TNmzoOPa84bhhBio4A4QF9P6Eqd64WAGhOCsE0uR33ml3QoFvv6eAd2Tt2uOGScv
aU/I9Dhln5l7xLt6gcMFtWXosYY+6V8g7IOIAecja8WrWg2duzbNVkT8PMN+mSoS
gjMnp/vxQCa+NyXHTN1ja8k6IMaIjm20s4OZCLJJwHQ60KLPFubIRS0aG3n3VAIz
ScLkmf/rehsF6mmgb9oZ7bZZQKAFrA==
=aiOU
-----END PGP SIGNATURE-----

--icdv5bytu7kohzlb--
