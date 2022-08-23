Content-Type: multipart/mixed; boundary="===============0002262407702533949=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH] power/acpi: Remove unnecessary return in
 acpi_os_** function; 
Date: Tue, 23 Aug 2022 19:15:01 +0200
Message-ID: <CAJZ5v0iFW4OxhWrPiBOvg7AneEuey27sFKYH_XEWSbA+qNppDg@mail.gmail.com>
In-Reply-To: 20220822091416.6177-1-zeming@nfschina.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0002262407702533949==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 22, 2022 at 11:16 AM Li zeming <zeming(a)nfschina.com> wrote:
>
> Remove the return in the function; it looks clearer.
>
> Signed-off-by: Li zeming <zeming(a)nfschina.com>

This is ACPICA code, so please submit changes against it to the
upstream ACPICA project on GitHub.  Thanks!

> ---
>  tools/power/acpi/os_specific/service_layers/osunixxf.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/tools/power/acpi/os_specific/service_layers/osunixxf.c b/too=
ls/power/acpi/os_specific/service_layers/osunixxf.c
> index b3651a04d68c..127630c38f1a 100644
> --- a/tools/power/acpi/os_specific/service_layers/osunixxf.c
> +++ b/tools/power/acpi/os_specific/service_layers/osunixxf.c
> @@ -510,8 +510,6 @@ void *acpi_os_map_memory(acpi_physical_address where,=
 acpi_size length)
>
>  void acpi_os_unmap_memory(void *where, acpi_size length)
>  {
> -
> -       return;
>  }
>  #endif
>
> @@ -1313,5 +1311,4 @@ acpi_os_execute(acpi_execute_type type,
>
>  void acpi_os_wait_events_complete(void)
>  {
> -       return;
>  }
> --
> 2.18.2
>
--===============0002262407702533949==--

