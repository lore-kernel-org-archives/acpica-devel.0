Content-Type: multipart/mixed; boundary="===============3963103402362616474=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: AcpiGetSleepTypeData: Failure to find
 \_Sx should not result in a loud warning [v2]
Date: Fri, 09 Oct 2015 05:26:39 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BAC67EE@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 1AE640813FDE7649BE1B193DEA596E883BAC675E@SHSMSX101.ccr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3963103402362616474==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Please ignore this.
The fix is against the caller.

Thanks and best regards
-Lv

> -----Original Message-----
> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Zheng, Lv
> Sent: Friday, October 09, 2015 10:02 AM
> To: Prarit Bhargava; Moore, Robert; devel(a)acpica.org
> Cc: linux-acpi(a)vger.kernel.org; Wysocki, Rafael J
> Subject: Re: [Devel] [PATCH] ACPICA: AcpiGetSleepTypeData: Failure to fin=
d \_Sx should not result in a loud warning [v2]
> =

> Why don't you fix this in the invoker side?
> For example:
> If (acpi_get_handle())
> 	acpi_evaluate_object()
> So that the AE_NOT_FOUND warning can still be kept for the real troubles?
> There are really scenarios that such warning is useful for catching bugs.
> =

> Thanks and best regards
> -Lv
> =

> > -----Original Message-----
> > From: linux-acpi-owner(a)vger.kernel.org [mailto:linux-acpi-owner(a)vge=
r.kernel.org] On Behalf Of Prarit Bhargava
> > Sent: Thursday, October 08, 2015 10:23 PM
> > To: Moore, Robert; devel(a)acpica.org
> > Cc: Zheng, Lv; Wysocki, Rafael J; Len Brown; linux-acpi(a)vger.kernel.o=
rg
> > Subject: Re: [PATCH] ACPICA: AcpiGetSleepTypeData: Failure to find \_Sx=
 should not result in a loud warning [v2]
> >
> >
> >
> > On 10/08/2015 10:19 AM, Moore, Robert wrote:
> > > We'll do the ACPICA version of this, although with probably with some=
 changes.
> > > Thanks,
> >
> > Thanks Bob.  If you could let me know when this lands in github(?) that=
 would be
> > great.  I'll reference it in the backport upstream.
> >
> > P.
> >
> > > Bob
> > >
> > >
> > >> -----Original Message-----
> > >> From: Prarit Bhargava [mailto:prarit(a)redhat.com]
> > >> Sent: Wednesday, October 07, 2015 11:51 AM
> > >> To: devel(a)acpica.org
> > >> Cc: Prarit Bhargava; Moore, Robert; Zheng, Lv; Wysocki, Rafael J; Len
> > >> Brown; linux-acpi(a)vger.kernel.org
> > >> Subject: [PATCH] ACPICA: AcpiGetSleepTypeData: Failure to find \_Sx =
should
> > >> not result in a loud warning [v2]
> > >>
> > >> 48ffb94 ("ACPICA: AcpiGetSleepTypeData: Allow \_Sx to return either =
1 or 2
> > >> integers") changed the error handling in AcpiGetSleepTypeData such t=
hat
> > >>
> > >> ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S1_]
> > >> (20130517/hwxface-571)
> > >>
> > >> is displayed on systems not implementing individual ACPI \_Sx sleep
> > >> states.
> > >> Since these states are optional the loud warning is incorrect.  This=
 patch
> > >> changes the kernel to the older behaviour of not warning on a not fo=
und
> > >> \_Sx.
> > >>
> > >> Before patch:
> > >>
> > >> [root(a)dell-pem520-03 ~]# dmesg | grep "While evaluating Sleep Stat=
e"
> > >>  ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S1_]
> > >> (20130517/hwxface-571)  ACPI Exception: AE_NOT_FOUND, While evaluati=
ng
> > >> Sleep State [\_S2_] (20130517/hwxface-571)  ACPI Exception: AE_NOT_F=
OUND,
> > >> While evaluating Sleep State [\_S3_] (20130517/hwxface-571)
> > >> [root(a)dell-pem520-03 ~]#
> > >>
> > >> After patch:
> > >>
> > >> [root(a)dell-pem520-03 ~]# dmesg | grep "While evaluating Sleep Stat=
e"
> > >> [root(a)dell-pem520-03 ~]#
> > >>
> > >> v2: Suggested by Robert Moore: Do not warn on AE_NOT_FOUND, otherwis=
e warn
> > >> loudly
> > >>
> > >> Fixes: 48ffb94 ("ACPICA: AcpiGetSleepTypeData: Allow \_Sx to return =
either
> > >> 1 or 2 integers")
> > >> Cc: Robert Moore <robert.moore(a)intel.com>
> > >> Cc: Lv Zheng <lv.zheng(a)intel.com>
> > >> Cc: "Rafael J. Wysocki" <rafael.j.wysocki(a)intel.com>
> > >> Cc: Len Brown <lenb(a)kernel.org>
> > >> Cc: linux-acpi(a)vger.kernel.org
> > >> Signed-off-by: Prarit Bhargava <prarit(a)redhat.com>
> > >> ---
> > >>  drivers/acpi/acpica/hwxface.c |   15 ++++++++++-----
> > >>  1 file changed, 10 insertions(+), 5 deletions(-)
> > >>
> > >> diff --git a/drivers/acpi/acpica/hwxface.c b/drivers/acpi/acpica/hwx=
face.c
> > >> index 5f97468..b450133 100644
> > >> --- a/drivers/acpi/acpica/hwxface.c
> > >> +++ b/drivers/acpi/acpica/hwxface.c
> > >> @@ -507,9 +507,13 @@ acpi_get_sleep_type_data(u8 sleep_state, u8
> > >> *sleep_type_a, u8 *sleep_type_b)
> > >>  	info->relative_pathname =3D
> > >>  	    ACPI_CAST_PTR(char, acpi_gbl_sleep_state_names[sleep_state]);
> > >>  	status =3D acpi_ns_evaluate(info);
> > >> -	if (ACPI_FAILURE(status)) {
> > >> +	if (status =3D=3D AE_NOT_FOUND) {
> > >> +		/* \_Sx states are optional */
> > >>  		goto cleanup;
> > >>  	}
> > >> +	if (ACPI_FAILURE(status)) {
> > >> +		goto cleanup1;
> > >> +	}
> > >>
> > >>  	/* Must have a return object */
> > >>
> > >> @@ -517,7 +521,7 @@ acpi_get_sleep_type_data(u8 sleep_state, u8
> > >> *sleep_type_a, u8 *sleep_type_b)
> > >>  		ACPI_ERROR((AE_INFO, "No Sleep State object returned from
> > >> [%s]",
> > >>  			    info->relative_pathname));
> > >>  		status =3D AE_AML_NO_RETURN_VALUE;
> > >> -		goto cleanup;
> > >> +		goto cleanup1;
> > >>  	}
> > >>
> > >>  	/* Return object must be of type Package */ @@ -526,7 +530,7 @@
> > >> acpi_get_sleep_type_data(u8 sleep_state, u8 *sleep_type_a, u8
> > >> *sleep_type_b)
> > >>  		ACPI_ERROR((AE_INFO,
> > >>  			    "Sleep State return object is not a Package"));
> > >>  		status =3D AE_AML_OPERAND_TYPE;
> > >> -		goto cleanup1;
> > >> +		goto cleanup2;
> > >>  	}
> > >>
> > >>  	/*
> > >> @@ -570,16 +574,17 @@ acpi_get_sleep_type_data(u8 sleep_state, u8
> > >> *sleep_type_a, u8 *sleep_type_b)
> > >>  		break;
> > >>  	}
> > >>
> > >> -cleanup1:
> > >> +cleanup2:
> > >>  	acpi_ut_remove_reference(info->return_object);
> > >>
> > >> -cleanup:
> > >> +cleanup1:
> > >>  	if (ACPI_FAILURE(status)) {
> > >>  		ACPI_EXCEPTION((AE_INFO, status,
> > >>  				"While evaluating Sleep State [%s]",
> > >>  				info->relative_pathname));
> > >>  	}
> > >>
> > >> +cleanup:
> > >>  	ACPI_FREE(info);
> > >>  	return_ACPI_STATUS(status);
> > >>  }
> > >> --
> > >> 1.7.9.3
> > >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo(a)vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> https://lists.acpica.org/mailman/listinfo/devel

--===============3963103402362616474==--

