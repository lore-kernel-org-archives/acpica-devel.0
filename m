Content-Type: multipart/mixed; boundary="===============0857402976884667010=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH 3/4] acpi: exsystem: Warn about sleeps greater
 than 50 ms
Date: Fri, 25 Feb 2022 16:39:38 +0100
Message-ID: <CAJZ5v0gLn=EEsLLZBtFUKA9SkK88S1HQxj_Z11sPgnRE9T_RmQ@mail.gmail.com>
In-Reply-To: 20220224113807.91771-3-pmenzel@molgen.mpg.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0857402976884667010==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 24, 2022 at 12:38 PM Paul Menzel <pmenzel(a)molgen.mpg.de> wrot=
e:
>
> Quick boottime is important, so warn about sleeps greater than 50 ms in
> ACPI.
>
> 50 ms is still long compared to distribution Linux kernels reaching initrd
> in 350 ms, so should probably changed to 10 ms, so people are aware
> about this.
>
> Signed-off-by: Paul Menzel <pmenzel(a)molgen.mpg.de>

First off, as ACPICA material, this should be submitted to the
upstream project via https://github.com/acpica/acpica/.

> ---
>  drivers/acpi/acpica/exsystem.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/acpi/acpica/exsystem.c b/drivers/acpi/acpica/exsyste=
m.c
> index 00f66af31ffa..bdffb8aac05c 100644
> --- a/drivers/acpi/acpica/exsystem.c
> +++ b/drivers/acpi/acpica/exsystem.c
> @@ -167,6 +167,11 @@ acpi_status acpi_ex_system_do_sleep(u64 how_long_ms)
>
>         acpi_ex_exit_interpreter();
>
> +       if (how_long_ms > 50) {
> +               ACPI_WARNING((AE_INFO,

Second, the log level is somewhat high for something like this.

> +                   "Time parameter %llu > 50 ms. Please contact firmware=
 vendor for more responsive system.", how_long_ms));

Also, I would rephrase the warning message to something like "Firmware
issue: Excessive delay (%llu ms) in ACPI Control Method".

> +       }
> +
>         /*
>          * For compatibility with other ACPI implementations and to preve=
nt
>          * accidental deep sleeps, limit the sleep time to something reas=
onable.
> --
> 2.35.1
>
--===============0857402976884667010==--

