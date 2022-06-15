Content-Type: multipart/mixed; boundary="===============8722954689486339373=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: [Devel] Re: [RFC 2/4] ACPICA: Add \_SB.PC00,
 \SB.PCI0 to acpi_ns_early_initialize_devices()
Date: Wed, 15 Jun 2022 23:31:24 +0200
Message-ID: <CAHp75VcPEw93_3dZvKCadnAqrJCVvdVcKh+DodgBC68xkmJ7VQ@mail.gmail.com>
In-Reply-To: 20220615195643.12608-3-hdegoede@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8722954689486339373==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 15, 2022 at 9:57 PM Hans de Goede <hdegoede(a)redhat.com> wrote:
>
> Since ACPICA commit f005ee6b90d1 / Linux commit 2d3349de8072
> ("ACPICA: Namespace: Reorder \_SB._INI to make sure it is evaluated
> before _REG evaluations") acpi_initialize_objects() calls \_SB._INI
> before executing _REG OpRegion methods, because the _REG methods may
> rely on initialization done by this _INI method.
>
> In many DSDTs the \_SB.PC00._INI / \_SB.PCI0._INI methods set an OSYS
> global variable based on _OSI evaluations.
>
> In some cases there are _REG methods which depend on the OSYS value and
> before this change ACPICA would run these _REG methods before running
> _SB.PC00._INI / \_SB.PCI0._INI causing issues.
>
> 2 examples of problems caused by running _REG methods before these
> _INI methods are:
>
> 1. on a "Lenovo IdeaPad 5 15ITL05" \_SB.PC00.LPCB.EC0._REG gets
> evaluated before \_SB.PC00._INI and that _REG contains:
>
>     If ((OSYS =3D=3D 0x07DF))
>     {
>         Local0 =3D 0x06
>     }
>
>     If ((Acquire (LFCM, 0xA000) =3D=3D Zero))
>     {
>         OSTY =3D Local0
>         ...
>
> With OSTY being a SystemMemory OpRegion field, due to the _INI running
> too late, Local0 stays at 0. Causing OSTY to be set to 0 instead of 6,
> which causes the brightness up/down keys to not work:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D214899
>
> 2. On a "Lenovo Thinkbook 14-ILL" \\_SB_.PCI0.I2C0._REG gets
> evaluated before \_SB.PCI0._INI and that _REG contains:
>
>     If ((OSYS =3D=3D 0x07DF))
>     {
>         ...
>         LNUX =3D Zero
>         TPID =3D 0x4E
>     }
>     else
>     {
>         LNUX =3D One
>         TPID =3D 0xBB
>     }
>
> And then later on the TPID value gets used to decide for which of multiple
> devices describing the touchpad _STA should return 0xF and the one which
> gets enabled by TPID=3D0xBB is broken, causing to the touchpad to not wor=
k:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1842039
>
> Fix these issues by adding \_SB.PC00._INI / \_SB.PCI0._INI to the list of
> _INI methods to run early (before executing _REG methods).

...

> -       char path[ACPI_PATH_SEGMENT_LENGTH + 2];
> +       char path[ACPI_PATH_SEGMENT_LENGTH * 2 + 2];

Strictly speaking this should be, IIUC,

1 + ACPI_PATH_SEGMENT_LENGTH + ACPI_NAMESEG_SIZE + 1

\\ + path segment length (with a separator) + name + \0

That said, it seems the original code adds 1 unneeded byte.

Perhaps a comment in the code?

-- =

With Best Regards,
Andy Shevchenko
--===============8722954689486339373==--

