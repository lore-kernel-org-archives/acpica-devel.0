Content-Type: multipart/mixed; boundary="===============4661983649670099543=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH 0/4] ACPI: EC: Various cleanups
Date: Wed, 29 Jun 2022 19:42:21 +0200
Message-ID: <CAJZ5v0i08vYPyDFY3KeK9vxbgfND4HUD7qMjpmK8dHQaURy-tg@mail.gmail.com>
In-Reply-To: 20220620092546.8298-1-hdegoede@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4661983649670099543==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 20, 2022 at 11:26 AM Hans de Goede <hdegoede(a)redhat.com> wrot=
e:
>
> Hi All,
>
> Here is a set of cleanups / removal of no longer necessary
> quirks (or so I believe please review carefully). These are all
> things which I noticed while working on my:
> "[RFC 0/4] ACPI[CA]: fix ECDT EC probe ordering issues" series.
>
> Regards,
>
> Hans
>
> p.s.
> Talking about my "[RFC 0/4] ACPI[CA]: fix ECDT EC probe ordering issues"
> series, it would be great if someone can take a look at this and let me
> know if that series seems sane. Then I can convert the ACPICA changes
> from kernel patches to upstream github acpica patches and submit a
> pull-req for those at github.
>
>
> Hans de Goede (4):
>   ACPI: EC: Remove duplicate ThinkPad X1 Carbon 6th entry from DMI
>     quirks
>   ACPI: EC: Drop the EC_FLAGS_IGNORE_DSDT_GPE quirk
>   ACPI: EC: Re-use boot_ec when possible even when
>     EC_FLAGS_TRUST_DSDT_GPE is set
>   ACPI: EC: Drop unused ident initializers from dmi_system_id tables
>
>  drivers/acpi/ec.c | 140 ++++++++++++++++------------------------------
>  1 file changed, 48 insertions(+), 92 deletions(-)
>
> --

All four patches applied as 5.20 material, thanks!
--===============4661983649670099543==--

