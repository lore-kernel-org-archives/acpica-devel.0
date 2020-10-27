Content-Type: multipart/mixed; boundary="===============3773285858206667715=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] Re: [PATCH] ACPICA: Also handle "orphan" _REG methods for
 GPIO OpRegions
Date: Tue, 27 Oct 2020 14:17:09 +0000
Message-ID: <BYAPR11MB32563BD4E4ABB7BEF135ABFB87160@BYAPR11MB3256.namprd11.prod.outlook.com>
In-Reply-To: MWHPR11MB159947FE046515CE985CA571F0190@MWHPR11MB1599.namprd11.prod.outlook.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3773285858206667715==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Looks OK to me.
Bob


-----Original Message-----
From: Kaneda, Erik <erik.kaneda(a)intel.com> =

Sent: Monday, October 26, 2020 1:56 PM
To: Hans de Goede <hdegoede(a)redhat.com>; Rafael J . Wysocki <rjw(a)rjwyso=
cki.net>; Len Brown <lenb(a)kernel.org>; Moore, Robert <robert.moore(a)inte=
l.com>
Cc: linux-acpi(a)vger.kernel.org; devel(a)acpica.org
Subject: RE: [PATCH] ACPICA: Also handle "orphan" _REG methods for GPIO OpR=
egions



> -----Original Message-----
> From: Hans de Goede <hdegoede(a)redhat.com>
> Sent: Sunday, October 25, 2020 2:46 AM
> To: Rafael J . Wysocki <rjw(a)rjwysocki.net>; Len Brown =

> <lenb(a)kernel.org>; Moore, Robert <robert.moore(a)intel.com>; Kaneda, =

> Erik <erik.kaneda(a)intel.com>
> Cc: Hans de Goede <hdegoede(a)redhat.com>; linux-acpi(a)vger.kernel.org; =

> devel(a)acpica.org
> Subject: [PATCH] ACPICA: Also handle "orphan" _REG methods for GPIO =

> OpRegions
> =

> Before this commit acpi_ev_execute_reg_methods() had special handling =

> to handle "orphan" (no matching OpRegion declared) _REG methods for EC =

> nodes.
> =

> On Intel Cherry Trail devices there are 2 possible ACPI OpRegions for =

> accessing GPIOs. The standard GeneralPurposeIo OpRegion and the Cherry =

> Trail specific UserDefined 0x9X OpRegions.
> =

> Having 2 different types of OpRegions leads to potential issues with =

> checks for OpRegion availability, or in other words checks if _REG has =

> been called for the OpRegion which the ACPI code wants to use.
> =

> Except for the "orphan" EC handling, ACPICA core does not call _REG on =

> an ACPI node which does not define an OpRegion matching the type being =

> registered; and the reference design DSDT, from which most Cherry =

> Trail DSDTs are derived, does not define GeneralPurposeIo, nor
> UserDefined(0x93)
> OpRegions for the GPO2 (UID 3) device, because no pins were assigned =

> ACPI controlled functions in the reference design.
> =

> Together this leads to the perfect storm, at least on the Cherry Trail =

> based Medion Akayo E1239T. This design does use a GPO2 pin from its =

> ACPI code and has added the Cherry Trail specific UserDefined(0x93) =

> opregion to its GPO2 ACPI node to access this pin.
> =

> But it uses a has _REG been called availability check for the standard =

> GeneralPurposeIo OpRegion. This clearly is a bug in the DSDT, but this =

> does work under Windows. This issue leads to the intel_vbtn driver =

> reporting the device always being in tablet-mode at boot, even if it =

> is in laptop mode. Which in turn causes userspace to ignore touchpad =

> events. So iow this issues causes the touchpad to not work at boot.
> =

> This commit fixes this by extending the "orphan" _REG method handling =

> to also apply to GPIO address-space handlers.
> =

> Note it seems that Windows always calls "orphan" _REG methods so me =

> may want to consider dropping the space-id check and always do =

> "orphan" _REG method handling.
> =

> Signed-off-by: Hans de Goede <hdegoede(a)redhat.com>
> ---
>  drivers/acpi/acpica/evregion.c | 54 =

> +++++++++++++++++-----------------
>  1 file changed, 27 insertions(+), 27 deletions(-)
> =

> diff --git a/drivers/acpi/acpica/evregion.c =

> b/drivers/acpi/acpica/evregion.c index 738d4b231f34..21ff341e34a4 =

> 100644
> --- a/drivers/acpi/acpica/evregion.c
> +++ b/drivers/acpi/acpica/evregion.c
> @@ -21,7 +21,8 @@ extern u8 acpi_gbl_default_address_spaces[];
>  /* Local prototypes */
> =

>  static void
> -acpi_ev_orphan_ec_reg_method(struct acpi_namespace_node =

> *ec_device_node);
> +acpi_ev_execute_orphan_reg_method(struct acpi_namespace_node
> *device_node,
> +				  acpi_adr_space_type space_id);
> =

>  static acpi_status
>  acpi_ev_reg_run(acpi_handle obj_handle, @@ -684,10 +685,12 @@ =

> acpi_ev_execute_reg_methods(struct
> acpi_namespace_node *node,
>  				     ACPI_NS_WALK_UNLOCK,
> acpi_ev_reg_run, NULL,
>  				     &info, NULL);
> =

> -	/* Special case for EC: handle "orphan" _REG methods with no region
> */
> -
> -	if (space_id =3D=3D ACPI_ADR_SPACE_EC) {
> -		acpi_ev_orphan_ec_reg_method(node);
> +	/*
> +	 * Special case for EC and GPIO: handle "orphan" _REG methods with
> +	 * no region.
> +	 */
> +	if (space_id =3D=3D ACPI_ADR_SPACE_EC || space_id =3D=3D
> ACPI_ADR_SPACE_GPIO) {
> +		acpi_ev_execute_orphan_reg_method(node, space_id);
>  	}
> =

>  	ACPI_DEBUG_PRINT_RAW((ACPI_DB_NAMES,
> @@ -760,31 +763,28 @@ acpi_ev_reg_run(acpi_handle obj_handle,
> =

> =

> /**********************************************************
> *********************
>   *
> - * FUNCTION:    acpi_ev_orphan_ec_reg_method
> + * FUNCTION:    acpi_ev_execute_orphan_reg_method
>   *
> - * PARAMETERS:  ec_device_node      - Namespace node for an EC device
> + * PARAMETERS:  device_node     - Namespace node for an ACPI device
> + *              space_id        - The address space ID
>   *
>   * RETURN:      None
>   *
> - * DESCRIPTION: Execute an "orphan" _REG method that appears under =

> the EC
> + * DESCRIPTION: Execute an "orphan" _REG method that appears under an
> ACPI
>   *              device. This is a _REG method that has no corresponding =
region
> - *              within the EC device scope. The orphan _REG method appea=
rs to
> - *              have been enabled by the description of the ECDT in the =
ACPI
> - *              specification: "The availability of the region space can=
 be
> - *              detected by providing a _REG method object underneath the
> - *              Embedded Controller device."
> - *
> - *              To quickly access the EC device, we use the ec_device_no=
de used
> - *              during EC handler installation. Otherwise, we would need=
 to
> - *              perform a time consuming namespace walk, executing _HID
> - *              methods to find the EC device.
> + *              within the device's scope. ACPI tables depending on these
> + *              "orphan" _REG methods have been seen for both EC and GPIO
> + *              Operation Regions. Presumably the Windows ACPI implement=
ation
> + *              always calls the _REG method independent of the presence=
 of
> + *              an actual Operation Region with the correct address spac=
e ID.
>   *
>   *  MUTEX:      Assumes the namespace is locked
>   *
> =

> **********************************************************
> ********************/
> =

>  static void
> -acpi_ev_orphan_ec_reg_method(struct acpi_namespace_node
> *ec_device_node)
> +acpi_ev_execute_orphan_reg_method(struct acpi_namespace_node
> *device_node,
> +				  acpi_adr_space_type space_id)
>  {
>  	acpi_handle reg_method;
>  	struct acpi_namespace_node *next_node; @@ -792,9 +792,9 @@ =

> acpi_ev_orphan_ec_reg_method(struct
> acpi_namespace_node *ec_device_node)
>  	struct acpi_object_list args;
>  	union acpi_object objects[2];
> =

> -	ACPI_FUNCTION_TRACE(ev_orphan_ec_reg_method);
> +	ACPI_FUNCTION_TRACE(ev_execute_orphan_reg_method);
> =

> -	if (!ec_device_node) {
> +	if (!device_node) {
>  		return_VOID;
>  	}
> =

> @@ -804,7 +804,7 @@ acpi_ev_orphan_ec_reg_method(struct
> acpi_namespace_node *ec_device_node)
> =

>  	/* Get a handle to a _REG method immediately under the EC device */
> =

> -	status =3D acpi_get_handle(ec_device_node, METHOD_NAME__REG,
> &reg_method);
> +	status =3D acpi_get_handle(device_node, METHOD_NAME__REG,
> &reg_method);
>  	if (ACPI_FAILURE(status)) {
>  		goto exit;	/* There is no _REG method present */
>  	}
> @@ -816,23 +816,23 @@ acpi_ev_orphan_ec_reg_method(struct
> acpi_namespace_node *ec_device_node)
>  	 * with other space IDs to be present; but the code below will then
>  	 * execute the _REG method with the embedded_control space_ID =

> argument.
>  	 */
> -	next_node =3D acpi_ns_get_next_node(ec_device_node, NULL);
> +	next_node =3D acpi_ns_get_next_node(device_node, NULL);
>  	while (next_node) {
>  		if ((next_node->type =3D=3D ACPI_TYPE_REGION) &&
>  		    (next_node->object) &&
> -		    (next_node->object->region.space_id =3D=3D
> ACPI_ADR_SPACE_EC)) {
> +		    (next_node->object->region.space_id =3D=3D space_id)) {
>  			goto exit;	/* Do not execute the _REG */
>  		}
> =

> -		next_node =3D acpi_ns_get_next_node(ec_device_node,
> next_node);
> +		next_node =3D acpi_ns_get_next_node(device_node,
> next_node);
>  	}
> =

> -	/* Evaluate the _REG(embedded_control,Connect) method */
> +	/* Evaluate the _REG(space_id, Connect) method */
> =

>  	args.count =3D 2;
>  	args.pointer =3D objects;
>  	objects[0].type =3D ACPI_TYPE_INTEGER;
> -	objects[0].integer.value =3D ACPI_ADR_SPACE_EC;
> +	objects[0].integer.value =3D space_id;
>  	objects[1].type =3D ACPI_TYPE_INTEGER;
>  	objects[1].integer.value =3D ACPI_REG_CONNECT;
> =

> --
> 2.28.0

This looks good to me. Bob, any thoughts?

Erik
--===============3773285858206667715==--

