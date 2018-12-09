Content-Type: multipart/mixed; boundary="===============2118410967107960840=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: Re: [Devel] [PATCH v2 3/3] PCI/ACPI: allow ACPI to be built without
 PCI support
Date: Sun, 09 Dec 2018 08:20:24 +0200
Message-ID: <CAHp75VeCSPv81Bf2zjgFfD1YW2B6Z0YdhJsGR+Hvrf54mvdOPA@mail.gmail.com>
In-Reply-To: 20181208214644.5374-3-okaya@kernel.org
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2118410967107960840==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 8, 2018 at 11:46 PM Sinan Kaya <okaya(a)kernel.org> wrote:
>
> We are compiling PCI code today for systems with ACPI and no PCI
> device present. Remove the useless code and reduce the tight
> dependency.

> +#ifdef CONFIG_PCI
>  struct pci_dev *acpi_get_pci_dev(acpi_handle);
> +#else
> +static inline struct pci_dev *acpi_get_pci_dev(acpi_handle hndl)

Can you spell handle fully?

> +{
> +       return NULL;
> +}
> +#endif

-- =

With Best Regards,
Andy Shevchenko

--===============2118410967107960840==--

