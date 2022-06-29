Content-Type: multipart/mixed; boundary="===============6149099459715733660=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH 1/2] ACPI: Drop redundant check in
 acpi_device_remove()
Date: Wed, 29 Jun 2022 19:03:18 +0200
Message-ID: <CAJZ5v0hgPwRHyU6cG-gqtRM4wLaKGRoL3z1nS_FiTybLAcvgGA@mail.gmail.com>
In-Reply-To: 20220618112311.14661-1-u.kleine-koenig@pengutronix.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6149099459715733660==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 18, 2022 at 1:23 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig(a)pengutronix.de> wrote:
>
> A bus remove callback is only ever called by the device core with a
> bound driver. So there is no need to check if the driver is non-NULL.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig(a)pengutronix.de>
> ---
>  drivers/acpi/bus.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 86fa61a21826..67a3f8cf42f9 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -1062,12 +1062,11 @@ static void acpi_device_remove(struct device *dev)
>         struct acpi_device *acpi_dev =3D to_acpi_device(dev);
>         struct acpi_driver *acpi_drv =3D acpi_dev->driver;
>
> -       if (acpi_drv) {
> -               if (acpi_drv->ops.notify)
> -                       acpi_device_remove_notify_handler(acpi_dev);
> -               if (acpi_drv->ops.remove)
> -                       acpi_drv->ops.remove(acpi_dev);
> -       }
> +       if (acpi_drv->ops.notify)
> +               acpi_device_remove_notify_handler(acpi_dev);
> +       if (acpi_drv->ops.remove)
> +               acpi_drv->ops.remove(acpi_dev);
> +
>         acpi_dev->driver =3D NULL;
>         acpi_dev->driver_data =3D NULL;
>
>
> base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
> --

Applied (with minor modifications) as 5.20 material along with the [2/2].

Thanks!
--===============6149099459715733660==--

