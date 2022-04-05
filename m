Content-Type: multipart/mixed; boundary="===============5642572293765986031=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH 2/3] acpica: Check that the EBDA pointer is in
 valid range
Date: Tue, 05 Apr 2022 15:14:27 +0200
Message-ID: <CAJZ5v0iSCrU3AeEaTxVkbma_0Wi9LPPRiP_NbmuAgDOeDS9c0g@mail.gmail.com>
In-Reply-To: YjM/6rqxZN19en2I@czspare1-lap.sysgo.cz
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5642572293765986031==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 17, 2022 at 3:12 PM Vit Kabele <vit(a)kabele.me> wrote:
>
> If the memory at 0x40e is uninitialized, the retrieved physical_memory
> address of EBDA may be beyond the low memory (i.e. above 640K).
>
> If so, the kernel may unintentionally access the VGA memory, that
> might not be decoded or even present in case of virtualization.
>
> Signed-off-by: Vit Kabele <vit(a)kabele.me>
> Reviewed-by: Rudolf Marek <r.marek(a)assembler.cz>
> ---
>  drivers/acpi/acpica/tbxfroot.c | 7 +++++--

Changes in the ACPICA code need to be submitted to the upstream ACPICA
project via https://github.com/acpica/acpica and they are pulled from
there into the kernel.

Of course, this applies to the next patch in the series too.

>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/acpica/tbxfroot.c b/drivers/acpi/acpica/tbxfroo=
t.c
> index 9fec3df6c3ba..67b7df1c0520 100644
> --- a/drivers/acpi/acpica/tbxfroot.c
> +++ b/drivers/acpi/acpica/tbxfroot.c
> @@ -138,8 +138,11 @@ acpi_find_root_pointer(acpi_physical_address *table_=
address)
>         acpi_os_unmap_memory(table_ptr, ACPI_EBDA_PTR_LENGTH);
>
>         /* EBDA present? */
> -
> -       if (physical_address > 0x400) {
> +       /* Check that the EBDA pointer from 0x40e is sane and does not po=
int
> +        * above valid low memory
> +        */
> +       if (physical_address > 0x400 &&
> +           physical_address < 0xA0000) {
>                 /*
>                  * 1b) Search EBDA paragraphs (EBDA is required to be a
>                  *     minimum of 1K length)
> --
> 2.30.2
>
--===============5642572293765986031==--

