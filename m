Return-Path: <sudeep.holla@arm.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7EB9A415E9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4C783400A2
From: Sudeep Holla <sudeep.holla@arm.com>
Message-ID: <20230324095329.3oat5nuqhuqqycsr@bogus>
References: <20230324075854.458341-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230324075854.458341-1-u.kleine-koenig@pengutronix.de>
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
Date: Fri, 24 Mar 2023 09:53:35 -0000
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, kernel@pengutronix.de, Sudeep Holla <sudeep.holla@arm.com>, acpica-devel@lists.linuxfoundation.org, Len Brown <lenb@kernel.org>

On Fri, Mar 24, 2023 at 08:58:54AM +0100, Uwe Kleine-K=F6nig wrote:
> The loop
>=20
> 	for (i =3D 0; i < ACPI_NUM_NOTIFY_TYPES; i++) {
> 		if (handler_type & (i + 1)) {
> 			...
> 		}
> 	}
>=20
> looks strange. Only with knowing that ACPI_NUM_NOTIFY_TYPES =3D=3D 2 you =
can
> see that the two least significant bits are checked. Still replace
>=20
> 	i + 1
>=20
> by
>=20
> 	1 << i
>=20
> which shouldn't make a relevant difference to compiler and compiled
> code, but is easier to understand for a human code reader.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

You need to submit this to ACPICA project first.
Documentation/driver-api/acpi/linuxized-acpica.rst explains the process.
Refer [1] for details for similar suggestion by Rafael.

--=20
Regards,
Sudeep

[1] https://lore.kernel.org/all/CAJZ5v0gPUBFzuFiRWW8KHAwB1Agy+Le=3DCWuRD0RT=
r4MkNeEmQw@mail.gmail.com

