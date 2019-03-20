Content-Type: multipart/mixed; boundary="===============2019953001655064032=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [PATCH] drivers/acpi: Clear status of an event before
 enabling it
Date: Thu, 21 Mar 2019 00:11:28 +0100
Message-ID: <CAJZ5v0h7dYEFHSOHengJ3OFyXBW+XZVbjCAegpzqg1VxeeaXog@mail.gmail.com>
In-Reply-To: 20190320222844.134765-1-furquan@google.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2019953001655064032==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2019 at 11:34 PM Furquan Shaikh <furquan(a)google.com> wrot=
e:
>
> Commit 18996f2db918 ("ACPICA: Events: Stop unconditionally
> clearing ACPI IRQs during suspend/resume") was added to stop clearing
> of event status bits unconditionally on suspend and resume paths. This
> was done because of an issue
> reported (https://bugzilla.kernel.org/show_bug.cgi?id=3D196249) where
> lid status stays closed even on resume (which happens because event
> status bits are cleared unconditionally on resume). Though this change
> fixed the issue on suspend path, it introduced regressions on several
> resume paths.
>
> First regression was reported and fixed on S5 path by the following
> change: commit fa85015c0d95 ("ACPICA: Clear status of all events when
> entering S5"). Next regression was reported and fixed on all legacy
> sleep paths by the commit f317c7dc12b7 ("ACPICA: Clear status of all
> events when entering sleep states"). However, regression still exists
> on S0ix sleep path since it does not follow the legacy sleep path.

What exactly is failing?

> In case of S0ix, events are enabled as part of device suspend path. If
> status bits for the events are set when they are enabled, it could
> result in premature wake from S0ix. This change ensures that status is
> cleared for any event that is being enabled so that any stale events
> are cleared out.
>
> Signed-off-by: Furquan Shaikh <furquan(a)google.com>
> ---
>  drivers/acpi/acpica/evgpe.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
> index 62d3aa74277b4..61455ab42fc87 100644
> --- a/drivers/acpi/acpica/evgpe.c
> +++ b/drivers/acpi/acpica/evgpe.c
> @@ -81,8 +81,12 @@ acpi_status acpi_ev_enable_gpe(struct acpi_gpe_event_i=
nfo *gpe_event_info)
>
>         ACPI_FUNCTION_TRACE(ev_enable_gpe);
>
> -       /* Enable the requested GPE */
> +       /* Clear the GPE (of stale events) */
> +       status =3D acpi_hw_clear_gpe(gpe_event_info);
> +       if (ACPI_FAILURE(status))
> +               return_ACPI_STATUS(status);

Well, this may cause events to be missed.

>
> +       /* Enable the requested GPE */
>         status =3D acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_ENABLE);
>         return_ACPI_STATUS(status);
>  }
> --
> 2.21.0.225.g810b269d1ac-goog
>

--===============2019953001655064032==--

