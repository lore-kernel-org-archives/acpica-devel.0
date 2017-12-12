Content-Type: multipart/mixed; boundary="===============0148024803881194818=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rjw at rjwysocki.net>
Subject: Re: [Devel] [BUG] acpica: ltp_acpi test case causes kernel crash at
 acpi_ns_walk_namespace
Date: Wed, 13 Dec 2017 00:45:50 +0100
Message-ID: <9523980.S2jPabPoO5@aspire.rjw.lan>
In-Reply-To: 1513094360-1414-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0148024803881194818==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tuesday, December 12, 2017 4:59:19 PM CET Vadim Lomovtsev wrote:
> Hi guys,
> =

> While running LTP tests I've faced kernel crash caused by ltp_acpi test c=
ase.
> I have ACPI support enabled in kernel but kernel is boot with FDT having =
ACPI
> disabled. The ltp_acpi test case application is built along with ltp_acpi=
_cmds
> module to run ACPI tests.
> =

> So my question is - should we update acpica implementation at kernel side=
 by
> adding 'acpi_disabled' variable checking to the 'acpi_get_devices' functi=
on (see
> patch next to this email, maybe not a good approach) or this should be fi=
xed at LTP
> side so the ltp_acpi_cmds should be updated in order to check if acpi is =
enabled
> before running tests ?

There should be a check preventing acpi_get_devices() from being called in =
the
acpi_disabled case.

acpi_disabled is Linux-specific and the ACPICA code isn't, so the code call=
ing
ACPICA functions should check acpi_disabled when necessary.

Thanks,
Rafael


--===============0148024803881194818==--

