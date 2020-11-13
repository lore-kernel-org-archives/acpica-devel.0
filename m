Content-Type: multipart/mixed; boundary="===============6823325117330637741=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] Re: [PATCH] ACPICA: fix -Wfallthrough
Date: Fri, 13 Nov 2020 21:43:50 +0000
Message-ID: <BYAPR11MB3256E6E37618702C5EA761A087E60@BYAPR11MB3256.namprd11.prod.outlook.com>
In-Reply-To: BYAPR11MB32564DD5B9D140AFE8C3D1EB87E60@BYAPR11MB3256.namprd11.prod.outlook.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6823325117330637741==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



-----Original Message-----
From: Moore, Robert =

Sent: Friday, November 13, 2020 1:42 PM
To: Nick Desaulniers <ndesaulniers(a)google.com>
Cc: Kaneda, Erik <erik.kaneda(a)intel.com>; Wysocki, Rafael J <rafael.j.wys=
ocki(a)intel.com>; Gustavo A . R . Silva <gustavoars(a)kernel.org>; clang-b=
uilt-linux(a)googlegroups.com; Len Brown <lenb(a)kernel.org>; linux-acpi(a)=
vger.kernel.org; devel(a)acpica.org; linux-kernel(a)vger.kernel.org
Subject: RE: [PATCH] ACPICA: fix -Wfallthrough



-----Original Message-----
From: Nick Desaulniers <ndesaulniers(a)google.com>
Sent: Friday, November 13, 2020 1:33 PM
To: Moore, Robert <robert.moore(a)intel.com>
Cc: Kaneda, Erik <erik.kaneda(a)intel.com>; Wysocki, Rafael J <rafael.j.wys=
ocki(a)intel.com>; Gustavo A . R . Silva <gustavoars(a)kernel.org>; clang-b=
uilt-linux(a)googlegroups.com; Len Brown <lenb(a)kernel.org>; linux-acpi(a)=
vger.kernel.org; devel(a)acpica.org; linux-kernel(a)vger.kernel.org
Subject: Re: [PATCH] ACPICA: fix -Wfallthrough

On Fri, Nov 13, 2020 at 1:27 PM Moore, Robert <robert.moore(a)intel.com> wr=
ote:
>
>
>
> -----Original Message-----
> From: ndesaulniers via sendgmr
> <ndesaulniers(a)ndesaulniers1.mtv.corp.google.com> On Behalf Of Nick =

> Desaulniers
> Sent: Tuesday, November 10, 2020 6:12 PM
> To: Moore, Robert <robert.moore(a)intel.com>; Kaneda, Erik =

> <erik.kaneda(a)intel.com>; Wysocki, Rafael J =

> <rafael.j.wysocki(a)intel.com>; Gustavo A . R . Silva =

> <gustavoars(a)kernel.org>
> Cc: clang-built-linux(a)googlegroups.com; Nick Desaulniers =

> <ndesaulniers(a)google.com>; Len Brown <lenb(a)kernel.org>; =

> linux-acpi(a)vger.kernel.org; devel(a)acpica.org; =

> linux-kernel(a)vger.kernel.org
> Subject: [PATCH] ACPICA: fix -Wfallthrough
>
> The "fallthrough" pseudo-keyword was added as a portable way to denote in=
tentional fallthrough. This code seemed to be using a mix of fallthrough co=
mments that GCC recognizes, and some kind of lint marker.
> I'm guessing that linter hasn't been run in a while from the mixed use of=
 the marker vs comments.
>
> /*lint -fallthrough */
>
> This is the lint marker

Yes; but from my patch, the hunk modifying
acpi_ex_store_object_to_node() and vsnprintf() seem to indicate that maybe =
the linter hasn't been run in a while.

Which linter is that?  I'm curious whether I should leave those be, and whe=
ther we're going to have an issue between compilers and linters as to which=
 line/order these would need to appear on.

It's an old version of PC-Lint, which we don't use anymore.

So, you can get rid of the lint markers.



>
> BTW, what version of gcc added -Wfallthrough?

GCC 7.1 added -Wimplicit-fallthrough.

>
>
> Signed-off-by: Nick Desaulniers <ndesaulniers(a)google.com>
> ---
>  drivers/acpi/acpica/dscontrol.c | 3 +--
>  drivers/acpi/acpica/dswexec.c   | 4 +---
>  drivers/acpi/acpica/dswload.c   | 3 +--
>  drivers/acpi/acpica/dswload2.c  | 3 +--
>  drivers/acpi/acpica/exfldio.c   | 3 +--
>  drivers/acpi/acpica/exresop.c   | 5 ++---
>  drivers/acpi/acpica/exstore.c   | 6 ++----
>  drivers/acpi/acpica/hwgpe.c     | 3 +--
>  drivers/acpi/acpica/utdelete.c  | 3 +--
>  drivers/acpi/acpica/utprint.c   | 2 +-
>  10 files changed, 12 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/acpi/acpica/dscontrol.c =

> b/drivers/acpi/acpica/dscontrol.c index 4b5b6e859f62..1e75e5fbfd19
> 100644
> --- a/drivers/acpi/acpica/dscontrol.c
> +++ b/drivers/acpi/acpica/dscontrol.c
> @@ -61,8 +61,7 @@ acpi_ds_exec_begin_control_op(struct acpi_walk_state *w=
alk_state,
>                                 break;
>                         }
>                 }
> -
> -               /*lint -fallthrough */
> +               fallthrough;
>
>         case AML_IF_OP:
>                 /*
> diff --git a/drivers/acpi/acpica/dswexec.c =

> b/drivers/acpi/acpica/dswexec.c index 1d4f8c81028c..e8c32d4fe55f
> 100644
> --- a/drivers/acpi/acpica/dswexec.c
> +++ b/drivers/acpi/acpica/dswexec.c
> @@ -597,9 +597,7 @@ acpi_status acpi_ds_exec_end_op(struct acpi_walk_stat=
e *walk_state)
>                                 if (ACPI_FAILURE(status)) {
>                                         break;
>                                 }
> -
> -                               /* Fall through */
> -                               /*lint -fallthrough */
> +                               fallthrough;
>
>                         case AML_INT_EVAL_SUBTREE_OP:
>
> diff --git a/drivers/acpi/acpica/dswload.c =

> b/drivers/acpi/acpica/dswload.c index 27069325b6de..afc663c3742d
> 100644
> --- a/drivers/acpi/acpica/dswload.c
> +++ b/drivers/acpi/acpica/dswload.c
> @@ -223,8 +223,7 @@ acpi_ds_load1_begin_op(struct acpi_walk_state *walk_s=
tate,
>                              parse_flags & ACPI_PARSE_MODULE_LEVEL)) {
>                                 break;
>                         }
> -
> -                       /*lint -fallthrough */
> +                       fallthrough;
>
>                 default:
>
> diff --git a/drivers/acpi/acpica/dswload2.c =

> b/drivers/acpi/acpica/dswload2.c index edadbe146506..1b794b6ba072
> 100644
> --- a/drivers/acpi/acpica/dswload2.c
> +++ b/drivers/acpi/acpica/dswload2.c
> @@ -213,8 +213,7 @@ acpi_ds_load2_begin_op(struct acpi_walk_state *walk_s=
tate,
>                              parse_flags & ACPI_PARSE_MODULE_LEVEL)) {
>                                 break;
>                         }
> -
> -                       /*lint -fallthrough */
> +                       fallthrough;
>
>                 default:
>
> diff --git a/drivers/acpi/acpica/exfldio.c =

> b/drivers/acpi/acpica/exfldio.c index ade35ff1c7ba..9d1cabe0fed9
> 100644
> --- a/drivers/acpi/acpica/exfldio.c
> +++ b/drivers/acpi/acpica/exfldio.c
> @@ -433,8 +433,7 @@ acpi_ex_field_datum_io(union acpi_operand_object *obj=
_desc,
>                  * Now that the Bank has been selected, fall through to t=
he
>                  * region_field case and write the datum to the Operation=
 Region
>                  */
> -
> -               /*lint -fallthrough */
> +               fallthrough;
>
>         case ACPI_TYPE_LOCAL_REGION_FIELD:
>                 /*
> diff --git a/drivers/acpi/acpica/exresop.c =

> b/drivers/acpi/acpica/exresop.c index 4d1b22971d58..df48faa9a551
> 100644
> --- a/drivers/acpi/acpica/exresop.c
> +++ b/drivers/acpi/acpica/exresop.c
> @@ -197,8 +197,7 @@ acpi_ex_resolve_operands(u16 opcode,
>                                 case ACPI_REFCLASS_DEBUG:
>
>                                         target_op =3D AML_DEBUG_OP;
> -
> -                                       /*lint -fallthrough */
> +                                       fallthrough;
>
>                                 case ACPI_REFCLASS_ARG:
>                                 case ACPI_REFCLASS_LOCAL:
> @@ -264,7 +263,7 @@ acpi_ex_resolve_operands(u16 opcode,
>                          * Else not a string - fall through to the normal=
 Reference
>                          * case below
>                          */
> -                       /*lint -fallthrough */
> +                       fallthrough;
>
>                 case ARGI_REFERENCE:    /* References: */
>                 case ARGI_INTEGER_REF:
> diff --git a/drivers/acpi/acpica/exstore.c =

> b/drivers/acpi/acpica/exstore.c index 3adc0a29d890..2067baa7c120
> 100644
> --- a/drivers/acpi/acpica/exstore.c
> +++ b/drivers/acpi/acpica/exstore.c
> @@ -95,8 +95,7 @@ acpi_ex_store(union acpi_operand_object *source_desc,
>                 if (dest_desc->common.flags & AOPOBJ_AML_CONSTANT) {
>                         return_ACPI_STATUS(AE_OK);
>                 }
> -
> -               /*lint -fallthrough */
> +               fallthrough;
>
>         default:
>
> @@ -421,8 +420,7 @@ acpi_ex_store_object_to_node(union acpi_operand_objec=
t *source_desc,
>                                 }
>                                 break;
>                         }
> -
> -                       /* Fallthrough */
> +                       fallthrough;
>
>                 case ACPI_TYPE_DEVICE:
>                 case ACPI_TYPE_EVENT:
> diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c =

> index b13a4ed5bc63..fbfad80c8a53 100644
> --- a/drivers/acpi/acpica/hwgpe.c
> +++ b/drivers/acpi/acpica/hwgpe.c
> @@ -166,8 +166,7 @@ acpi_hw_low_set_gpe(struct acpi_gpe_event_info *gpe_e=
vent_info, u32 action)
>                 if (!(register_bit & gpe_register_info->enable_mask)) {
>                         return (AE_BAD_PARAMETER);
>                 }
> -
> -               /*lint -fallthrough */
> +               fallthrough;
>
>         case ACPI_GPE_ENABLE:
>
> diff --git a/drivers/acpi/acpica/utdelete.c =

> b/drivers/acpi/acpica/utdelete.c index 4c0d4e434196..8076e7947585
> 100644
> --- a/drivers/acpi/acpica/utdelete.c
> +++ b/drivers/acpi/acpica/utdelete.c
> @@ -111,8 +111,7 @@ static void acpi_ut_delete_internal_obj(union acpi_op=
erand_object *object)
>                         (void)acpi_ev_delete_gpe_block(object->device.
>                                                        gpe_block);
>                 }
> -
> -               /*lint -fallthrough */
> +               fallthrough;
>
>         case ACPI_TYPE_PROCESSOR:
>         case ACPI_TYPE_THERMAL:
> diff --git a/drivers/acpi/acpica/utprint.c =

> b/drivers/acpi/acpica/utprint.c index 681c11f4af4e..f7e43baf5ff2
> 100644
> --- a/drivers/acpi/acpica/utprint.c
> +++ b/drivers/acpi/acpica/utprint.c
> @@ -475,7 +475,7 @@ int vsnprintf(char *string, acpi_size size, const cha=
r *format, va_list args)
>                 case 'X':
>
>                         type |=3D ACPI_FORMAT_UPPER;
> -                       /* FALLTHROUGH */
> +                       fallthrough;
>
>                 case 'x':
>
> --
> 2.29.2.222.g5d2a92d10f8-goog
>


--
Thanks,
~Nick Desaulniers

--===============6823325117330637741==--

