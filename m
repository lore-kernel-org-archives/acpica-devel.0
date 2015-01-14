Content-Type: multipart/mixed; boundary="===============0940384049287804037=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH] acpica: utpredef: Remove some unused functions
Date: Wed, 14 Jan 2015 08:55:49 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88026B7475@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 1420384974-11745-1-git-send-email-rickard_strandqvist@spectrumdigital.se
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0940384049287804037==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, Rickard

The functions below seem already marked by "ACPI_ASL_COMPILER || ACPI_HELP_=
APP".
How did you detect them as used functions?

Thanks
-Lv


> -----Original Message-----
> From: Rickard Strandqvist [mailto:rickard_strandqvist(a)spectrumdigital.s=
e]
> Sent: Sunday, January 04, 2015 11:23 PM
> To: Moore, Robert; Zheng, Lv
> Cc: Rickard Strandqvist; Wysocki, Rafael J; Len Brown; linux-acpi(a)vger.=
kernel.org; devel(a)acpica.org; linux-kernel(a)vger.kernel.org
> Subject: [PATCH] acpica: utpredef: Remove some unused functions
> =

> Removes some functions that are not used anywhere:
> acpi_ut_get_resource_bit_width() acpi_ut_display_predefined_method() acpi=
_ut_match_resource_name()
> =

> This was partially found by using a static code analysis program called c=
ppcheck.
> =

> Signed-off-by: Rickard Strandqvist <rickard_strandqvist(a)spectrumdigital=
.se>
> ---
>  drivers/acpi/acpica/acutils.h  |    9 ---
>  drivers/acpi/acpica/utpredef.c |  134 ----------------------------------=
------
>  2 files changed, 143 deletions(-)
> =

> diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
> index 486d342..9b3fab1 100644
> --- a/drivers/acpi/acpica/acutils.h
> +++ b/drivers/acpi/acpica/acutils.h
> @@ -502,17 +502,8 @@ const union acpi_predefined_info *acpi_ut_get_next_p=
redefined_method(const union
> =

>  const union acpi_predefined_info *acpi_ut_match_predefined_method(char *=
name);
> =

> -const union acpi_predefined_info *acpi_ut_match_resource_name(char *name=
);
> -
> -void
> -acpi_ut_display_predefined_method(char *buffer,
> -				  const union acpi_predefined_info *this_name,
> -				  u8 multi_line);
> -
>  void acpi_ut_get_expected_return_types(char *buffer, u32 expected_btypes=
);
> =

> -u32 acpi_ut_get_resource_bit_width(char *buffer, u16 types);
> -
>  /*
>   * utstate - Generic state creation/cache routines
>   */
> diff --git a/drivers/acpi/acpica/utpredef.c b/drivers/acpi/acpica/utprede=
f.c
> index db30caf..f1ff33c 100644
> --- a/drivers/acpi/acpica/utpredef.c
> +++ b/drivers/acpi/acpica/utpredef.c
> @@ -209,105 +209,6 @@ static const char *ut_resource_type_names[] =3D {
> =

>  /***********************************************************************=
********
>   *
> - * FUNCTION:    acpi_ut_match_resource_name
> - *
> - * PARAMETERS:  name                - Name to find
> - *
> - * RETURN:      Pointer to entry in the resource table. NULL indicates n=
ot
> - *              found.
> - *
> - * DESCRIPTION: Check an object name against the predefined resource
> - *              descriptor object list.
> - *
> - ***********************************************************************=
*******/
> -
> -const union acpi_predefined_info *acpi_ut_match_resource_name(char *name)
> -{
> -	const union acpi_predefined_info *this_name;
> -
> -	/* Quick check for a predefined name, first character must be underscor=
e */
> -
> -	if (name[0] !=3D '_') {
> -		return (NULL);
> -	}
> -
> -	/* Search info table for a predefined method/object name */
> -
> -	this_name =3D acpi_gbl_resource_names;
> -	while (this_name->info.name[0]) {
> -		if (ACPI_COMPARE_NAME(name, this_name->info.name)) {
> -			return (this_name);
> -		}
> -
> -		this_name++;
> -	}
> -
> -	return (NULL);		/* Not found */
> -}
> -
> -/***********************************************************************=
********
> - *
> - * FUNCTION:    acpi_ut_display_predefined_method
> - *
> - * PARAMETERS:  buffer              - Scratch buffer for this function
> - *              this_name           - Entry in the predefined method/nam=
e table
> - *              multi_line          - TRUE if output should be on >1 line
> - *
> - * RETURN:      None
> - *
> - * DESCRIPTION: Display information about a predefined method. Number and
> - *              type of the input arguments, and expected type(s) for the
> - *              return value, if any.
> - *
> - ***********************************************************************=
*******/
> -
> -void
> -acpi_ut_display_predefined_method(char *buffer,
> -				  const union acpi_predefined_info *this_name,
> -				  u8 multi_line)
> -{
> -	u32 arg_count;
> -
> -	/*
> -	 * Get the argument count and the string buffer
> -	 * containing all argument types
> -	 */
> -	arg_count =3D acpi_ut_get_argument_types(buffer,
> -					       this_name->info.argument_list);
> -
> -	if (multi_line) {
> -		printf("      ");
> -	}
> -
> -	printf("%4.4s    Requires %s%u argument%s",
> -	       this_name->info.name,
> -	       (this_name->info.argument_list & ARG_COUNT_IS_MINIMUM) ?
> -	       "(at least) " : "", arg_count, arg_count !=3D 1 ? "s" : "");
> -
> -	/* Display the types for any arguments */
> -
> -	if (arg_count > 0) {
> -		printf(" (%s)", buffer);
> -	}
> -
> -	if (multi_line) {
> -		printf("\n    ");
> -	}
> -
> -	/* Get the return value type(s) allowed */
> -
> -	if (this_name->info.expected_btypes) {
> -		acpi_ut_get_expected_return_types(buffer,
> -						  this_name->info.
> -						  expected_btypes);
> -		printf("  Return value types: %s\n", buffer);
> -	} else {
> -		printf("  No return value\n");
> -	}
> -}
> -
> -/***********************************************************************=
********
> - *
>   * FUNCTION:    acpi_ut_get_argument_types
>   *
>   * PARAMETERS:  buffer              - Where to return the formatted types
> @@ -361,39 +262,4 @@ static u32 acpi_ut_get_argument_types(char *buffer, =
u16 argument_types)
>  	return (arg_count);
>  }
> =

> -/***********************************************************************=
********
> - *
> - * FUNCTION:    acpi_ut_get_resource_bit_width
> - *
> - * PARAMETERS:  buffer              - Where the formatted string is retu=
rned
> - *              types               - Bitfield of expected data types
> - *
> - * RETURN:      Count of return types. Formatted string in Buffer.
> - *
> - * DESCRIPTION: Format the resource bit widths into a printable string.
> - *
> - ***********************************************************************=
*******/
> -
> -u32 acpi_ut_get_resource_bit_width(char *buffer, u16 types)
> -{
> -	u32 i;
> -	u16 sub_index;
> -	u32 found;
> -
> -	*buffer =3D 0;
> -	sub_index =3D 1;
> -	found =3D 0;
> -
> -	for (i =3D 0; i < NUM_RESOURCE_WIDTHS; i++) {
> -		if (types & 1) {
> -			strcat(buffer, &(ut_resource_type_names[i][sub_index]));
> -			sub_index =3D 0;
> -			found++;
> -		}
> -
> -		types >>=3D 1;
> -	}
> -
> -	return (found);
> -}
>  #endif
> --
> 1.7.10.4


--===============0940384049287804037==--

