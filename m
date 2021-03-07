Content-Type: multipart/mixed; boundary="===============6959635116914602044=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: [Devel] Re: [PATCH v3 1/6] ACPI: scan: Extend
 acpi_walk_dep_device_list()
Date: Sun, 07 Mar 2021 22:39:18 +0200
Message-ID: <CAHp75Vc2iwvh1RiYmQDPSvgNvGT_gBcGTK67F+MhWgXyoxqn0A@mail.gmail.com>
In-Reply-To: 615bad5e-6e68-43c9-dd0b-f26d2832d52f@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6959635116914602044==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 7, 2021 at 3:36 PM Daniel Scally <djrscally(a)gmail.com> wrote:
> On 22/02/2021 13:34, Andy Shevchenko wrote:
> > On Mon, Feb 22, 2021 at 3:12 PM Daniel Scally <djrscally(a)gmail.com> w=
rote:
> >> The acpi_walk_dep_device_list() is not as generalisable as its name
> >> implies, serving only to decrement the dependency count for each
> >> dependent device of the input. Extend the function to instead accept
> >> a callback which can be applied to all the dependencies in acpi_dep_li=
st.
> >> Replace all existing calls to the function with calls to a wrapper, pa=
ssing
> >> a callback that applies the same dependency reduction.
> > The code looks okay to me, if it was the initial idea, feel free to add
> > Reviewed-by: Andy Shevchenko <andy.shevchenko(a)gmail.com>
>
>
> Thank you!
>
>
> >> + */
> >> +void acpi_dev_flag_dependency_met(acpi_handle handle)
> >> +{
> > Since it's acpi_dev_* namespace, perhaps it should take struct acpi_dev=
ice here?
>
>
> I can do this, but I avoided it because in most of the uses in the
> kernel currently there's no struct acpi_device, they're just passing
> ACPI_HANDLE(dev) instead, so I'd need to get the adev with
> ACPI_COMPANION() in each place. It didn't seem worth it...but happy to
> do it if you'd prefer it that way?

I see, let Rafael decide then. I'm not pushing here.

-- =

With Best Regards,
Andy Shevchenko
--===============6959635116914602044==--

