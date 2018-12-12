Content-Type: multipart/mixed; boundary="===============0505593400308364143=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [PATCH v6 5/5] ACPICA: Remove PCI bits from ACPICA when
 CONFIG_PCI is unset
Date: Wed, 12 Dec 2018 22:06:58 +0100
Message-ID: <CAJZ5v0iN+OkN0+wy=jGA33Uz+wQT7=zxF-TX3e-TrHDnr4=YRA@mail.gmail.com>
In-Reply-To: 39dc076f-1b3d-ad0c-c4bb-056ac589f361@kernel.org
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0505593400308364143==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 12, 2018 at 8:34 PM Sinan Kaya <okaya(a)kernel.org> wrote:
>
> On 12/12/2018 2:02 PM, Schmauss, Erik wrote:
> >> ++ b/drivers/acpi/acpica/achware.h
> >> @@ -109,8 +109,17 @@ acpi_hw_enable_runtime_gpe_block(struct
> >> acpi_gpe_xrupt_info *gpe_xrupt_info,
> > CONFIG_PCI is a Linux-ism. We should stay with the OS-independent natur=
e of
> > ACPICA. Please use ACPI_PCI_CONFIGURED and put it above the comment lik=
e so:
> >
> > #ifdef ACPI_PCI_CONFIGURED
>
> Thanks for the feedback. My search for ACPI_PCI_CONFIGURED returned nothi=
ng.
>
> git grep ACPI_PCI_CONFIGURED
>
> @Rafael,
>
> How do you want to handle this?

I think what Eric suggested is effectively to introduce a new ACPICA
symbol.  Erik?

--===============0505593400308364143==--

