Content-Type: multipart/mixed; boundary="===============4574134125485065407=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH AUTOSEL 4.4 15/30] ACPICA: Avoid evaluating
 methods too early during system resume
Date: Wed, 10 Nov 2021 16:18:37 +0100
Message-ID: <CAJZ5v0gwW=5CNObEi3SpXLhaA8oeP4VYfkWoQv9iDjwQLxE_yA@mail.gmail.com>
In-Reply-To: BYAPR11MB3256001FA32D50DE6F56425087939@BYAPR11MB3256.namprd11.prod.outlook.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4574134125485065407==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bob,

This is the Linux version of ACPICA commit
0762982923f95eb652cf7ded27356b247c9774de and now it has been
automatically selected for backporting into the "stable" kernel
versions.

On Wed, Nov 10, 2021 at 4:10 PM Moore, Robert <robert.moore(a)intel.com> wr=
ote:
>
> Sasha,
> Can you re-do this patch in native ACPICA format, then add a pull request=
 to our github?
>
> Thanks,
> Bob
>
>
> -----Original Message-----
> From: Sasha Levin <sashal(a)kernel.org>
> Sent: Monday, November 08, 2021 5:09 PM
> To: linux-kernel(a)vger.kernel.org; stable(a)vger.kernel.org
> Cc: Wysocki, Rafael J <rafael.j.wysocki(a)intel.com>; Reik Keutterling <s=
pielkind(a)gmail.com>; Sasha Levin <sashal(a)kernel.org>; Moore, Robert <ro=
bert.moore(a)intel.com>; linux-acpi(a)vger.kernel.org; devel(a)acpica.org
> Subject: [PATCH AUTOSEL 4.4 15/30] ACPICA: Avoid evaluating methods too e=
arly during system resume
>
> From: "Rafael J. Wysocki" <rafael.j.wysocki(a)intel.com>
>
> [ Upstream commit d3c4b6f64ad356c0d9ddbcf73fa471e6a841cc5c ]
>
> ACPICA commit 0762982923f95eb652cf7ded27356b247c9774de
>
> During wakeup from system-wide sleep states, acpi_get_sleep_type_data() i=
s called and it tries to get memory from the slab allocator in order to eva=
luate a control method, but if KFENCE is enabled in the kernel, the memory =
allocation attempt causes an IRQ work to be queued and a self-IPI to be sen=
t to the CPU running the code which requires the memory controller to be re=
ady, so if that happens too early in the wakeup path, it doesn't work.
>
> Prevent that from taking place by calling acpi_get_sleep_type_data() for =
S0 upfront, when preparing to enter a given sleep state, and saving the dat=
a obtained by it for later use during system wakeup.
>
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=3D214271
> Reported-by: Reik Keutterling <spielkind(a)gmail.com>
> Tested-by: Reik Keutterling <spielkind(a)gmail.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki(a)intel.com>
> Signed-off-by: Sasha Levin <sashal(a)kernel.org>
> ---
>  drivers/acpi/acpica/acglobal.h  |  2 ++  drivers/acpi/acpica/hwesleep.c =
 |  8 ++------
>  drivers/acpi/acpica/hwsleep.c   | 11 ++++-------
>  drivers/acpi/acpica/hwxfsleep.c |  7 +++++++
>  4 files changed, 15 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acgloba=
l.h index faa97604d878e..f178d11597c09 100644
> --- a/drivers/acpi/acpica/acglobal.h
> +++ b/drivers/acpi/acpica/acglobal.h
> @@ -256,6 +256,8 @@ extern struct acpi_bit_register_info
>
>  ACPI_GLOBAL(u8, acpi_gbl_sleep_type_a);  ACPI_GLOBAL(u8, acpi_gbl_sleep_=
type_b);
> +ACPI_GLOBAL(u8, acpi_gbl_sleep_type_a_s0); ACPI_GLOBAL(u8,
> +acpi_gbl_sleep_type_b_s0);
>
>  /***********************************************************************=
******
>   *
> diff --git a/drivers/acpi/acpica/hwesleep.c b/drivers/acpi/acpica/hweslee=
p.c index e5599f6108083..e4998cc0ce283 100644
> --- a/drivers/acpi/acpica/hwesleep.c
> +++ b/drivers/acpi/acpica/hwesleep.c
> @@ -184,17 +184,13 @@ acpi_status acpi_hw_extended_sleep(u8 sleep_state)
>
>  acpi_status acpi_hw_extended_wake_prep(u8 sleep_state)  {
> -       acpi_status status;
>         u8 sleep_type_value;
>
>         ACPI_FUNCTION_TRACE(hw_extended_wake_prep);
>
> -       status =3D acpi_get_sleep_type_data(ACPI_STATE_S0,
> -                                         &acpi_gbl_sleep_type_a,
> -                                         &acpi_gbl_sleep_type_b);
> -       if (ACPI_SUCCESS(status)) {
> +       if (acpi_gbl_sleep_type_a_s0 !=3D ACPI_SLEEP_TYPE_INVALID) {
>                 sleep_type_value =3D
> -                   ((acpi_gbl_sleep_type_a << ACPI_X_SLEEP_TYPE_POSITION=
) &
> +                   ((acpi_gbl_sleep_type_a_s0 << ACPI_X_SLEEP_TYPE_POSIT=
ION) &
>                      ACPI_X_SLEEP_TYPE_MASK);
>
>                 (void)acpi_write((u64)(sleep_type_value | ACPI_X_SLEEP_EN=
ABLE), diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hws=
leep.c index 7d21cae6d6028..7e44ba8c6a1ab 100644
> --- a/drivers/acpi/acpica/hwsleep.c
> +++ b/drivers/acpi/acpica/hwsleep.c
> @@ -217,7 +217,7 @@ acpi_status acpi_hw_legacy_sleep(u8 sleep_state)
>
>  acpi_status acpi_hw_legacy_wake_prep(u8 sleep_state)  {
> -       acpi_status status;
> +       acpi_status status =3D AE_OK;
>         struct acpi_bit_register_info *sleep_type_reg_info;
>         struct acpi_bit_register_info *sleep_enable_reg_info;
>         u32 pm1a_control;
> @@ -230,10 +230,7 @@ acpi_status acpi_hw_legacy_wake_prep(u8 sleep_state)
>          * This is unclear from the ACPI Spec, but it is required
>          * by some machines.
>          */
> -       status =3D acpi_get_sleep_type_data(ACPI_STATE_S0,
> -                                         &acpi_gbl_sleep_type_a,
> -                                         &acpi_gbl_sleep_type_b);
> -       if (ACPI_SUCCESS(status)) {
> +       if (acpi_gbl_sleep_type_a_s0 !=3D ACPI_SLEEP_TYPE_INVALID) {
>                 sleep_type_reg_info =3D
>                     acpi_hw_get_bit_register_info(ACPI_BITREG_SLEEP_TYPE);
>                 sleep_enable_reg_info =3D
> @@ -254,9 +251,9 @@ acpi_status acpi_hw_legacy_wake_prep(u8 sleep_state)
>
>                         /* Insert the SLP_TYP bits */
>
> -                       pm1a_control |=3D (acpi_gbl_sleep_type_a <<
> +                       pm1a_control |=3D (acpi_gbl_sleep_type_a_s0 <<
>                                          sleep_type_reg_info->bit_positio=
n);
> -                       pm1b_control |=3D (acpi_gbl_sleep_type_b <<
> +                       pm1b_control |=3D (acpi_gbl_sleep_type_b_s0 <<
>                                          sleep_type_reg_info->bit_positio=
n);
>
>                         /* Write the control registers and ignore any err=
ors */ diff --git a/drivers/acpi/acpica/hwxfsleep.c b/drivers/acpi/acpica/h=
wxfsleep.c index d62a61612b3f1..b04e2b0f62246 100644
> --- a/drivers/acpi/acpica/hwxfsleep.c
> +++ b/drivers/acpi/acpica/hwxfsleep.c
> @@ -372,6 +372,13 @@ acpi_status acpi_enter_sleep_state_prep(u8 sleep_sta=
te)
>                 return_ACPI_STATUS(status);
>         }
>
> +       status =3D acpi_get_sleep_type_data(ACPI_STATE_S0,
> +                                         &acpi_gbl_sleep_type_a_s0,
> +                                         &acpi_gbl_sleep_type_b_s0);
> +       if (ACPI_FAILURE(status)) {
> +               acpi_gbl_sleep_type_a_s0 =3D ACPI_SLEEP_TYPE_INVALID;
> +       }
> +
>         /* Execute the _PTS method (Prepare To Sleep) */
>
>         arg_list.count =3D 1;
> --
> 2.33.0
>
--===============4574134125485065407==--

