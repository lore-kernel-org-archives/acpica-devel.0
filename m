Return-Path: <sudeep.holla@arm.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1435640347
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0DCDA40176
From: Sudeep Holla <sudeep.holla@arm.com>
Message-ID: <20230324143849.2y4rdnes3irhw2b2@bogus>
References: <20230324075854.458341-1-u.kleine-koenig@pengutronix.de>
 <20230324095329.3oat5nuqhuqqycsr@bogus>
 <20230324105938.p4olsh27uy5zdbbv@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230324105938.p4olsh27uy5zdbbv@pengutronix.de>
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
Date: Fri, 24 Mar 2023 14:38:55 -0000
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, kernel@pengutronix.de, Sudeep Holla <sudeep.holla@arm.com>, acpica-devel@lists.linuxfoundation.org, Len Brown <lenb@kernel.org>

On Fri, Mar 24, 2023 at 11:59:38AM +0100, Uwe Kleine-K=F6nig wrote:
>
> My motivation isn't big enough to even read that. If the usual kernel
> workflow doesn't work for ACPICA, let's drop the patch.

:(, but ACPICA is reused on other OSes and hence the need to be a separate
project. It is very similar to the way DTC changes are done elsewhere and
imported into the kernel.

--
Regards,
Sudeep
