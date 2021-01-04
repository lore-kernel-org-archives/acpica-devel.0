Content-Type: multipart/mixed; boundary="===============5747871166469251490=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: [Devel] Re: [PATCH v4 15/15] ipu3-cio2: Add cio2-bridge to ipu3-cio2
 driver
Date: Mon, 04 Jan 2021 14:11:53 +0000
Message-ID: <CAHp75Vf6Z_qhw54jUu5tt85XxjZncaQFCNpYx=tqGTS9LsVPOg@mail.gmail.com>
In-Reply-To: 9026519f-1f33-9df0-de18-0881069f7aaa@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5747871166469251490==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 4, 2021 at 3:55 PM Daniel Scally <djrscally(a)gmail.com> wrote:
> On 04/01/2021 13:35, Kieran Bingham wrote:

...

> +static const struct cio2_sensor_config cio2_supported_sensors[] =3D {
> +       /* Sensor OVTI5693 */
> +       CIO2_SENSOR_CONFIG("INT33BE", 0),
> +       /* Sensor OVTI2680 */
> +       CIO2_SENSOR_CONFIG("OVTI2680", 0),
>
> As an inline comment won't fit for the sensors that we know link-frequenc=
ies for. That sound ok?

At least to me it looks okay.

It seems for v5 we need Rafael's blessing on a few patches (driver
properties / swnode / ACPI) and we are fine.

-- =

With Best Regards,
Andy Shevchenko
--===============5747871166469251490==--

