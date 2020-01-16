Content-Type: multipart/mixed; boundary="===============5223666959452773427=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [RESEND PATCH] ACPICA: Enable sleep button on ACPI legacy
 wake
Date: Thu, 16 Jan 2020 10:40:08 +0100
Message-ID: <CAJZ5v0iHVzDzS5zZSTWOdy2CCSkyW74+p2-Et0+EcysOvL2CDg@mail.gmail.com>
In-Reply-To: 20200115232629.GA9231@dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5223666959452773427==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2020 at 12:26 AM Anchal Agarwal <anchalag(a)amazon.com> wro=
te:
>
> Currently we do not see sleep_enable bit set after guest resumes
> from hibernation. Hibernation is triggered in guest on receiving
> a sleep trigger from the hypervisor(S4 state). We see that power
> button is enabled on wake up from S4 state however sleep button
> isn't. This causes subsequent invocation of sleep state to fail
> in the guest. Any environment  going through acpi_hw_legacy_wake()
> won't have sleep button enabled.
>
> Signed-off-by: Anchal Agarwal <anchalag(a)amazon.com>
> Reviewed-by: Balbir Singh <sblbir(a)amazon.com>
> Reviewed-by: Frank van der Linden <fllinden(a)amazon.com>
> ---
>  drivers/acpi/acpica/hwsleep.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
> index b62db8ec446f..a176c7802760 100644
> --- a/drivers/acpi/acpica/hwsleep.c
> +++ b/drivers/acpi/acpica/hwsleep.c
> @@ -300,6 +300,17 @@ acpi_status acpi_hw_legacy_wake(u8 sleep_state)
>                                     [ACPI_EVENT_POWER_BUTTON].
>                                     status_register_id, ACPI_CLEAR_STATUS=
);
>
> +       /* Enable sleep button */
> +       (void)
> +             acpi_write_bit_register(acpi_gbl_fixed_event_info
> +                                     [ACPI_EVENT_SLEEP_BUTTON].
> +                                     enable_register_id, ACPI_ENABLE_EVE=
NT);
> +
> +       (void)
> +             acpi_write_bit_register(acpi_gbl_fixed_event_info
> +                                     [ACPI_EVENT_SLEEP_BUTTON].
> +                                     status_register_id, ACPI_CLEAR_STAT=
US);
> +
>         acpi_hw_execute_sleep_method(METHOD_PATHNAME__SST, ACPI_SST_WORKI=
NG);
>         return_ACPI_STATUS(status);
>  }

Erik, Bob, please pick this up if you don't have specific objections agains=
t it.

I'll wait for it to show up in an upstream release.
--===============5223666959452773427==--

