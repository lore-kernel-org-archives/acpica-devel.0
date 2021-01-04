Content-Type: multipart/mixed; boundary="===============8811519629171872132=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] Re: [PATCH 1/2] ACPICA: Fix race in GenericSerialBus (I2C)
 and GPIO OpRegion parameter handling
Date: Mon, 04 Jan 2021 22:17:43 +0000
Message-ID: <BYAPR11MB3256C957AA72754D07D6583F87D20@BYAPR11MB3256.namprd11.prod.outlook.com>
In-Reply-To: 20201226142830.48818-2-hdegoede@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8811519629171872132==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hans,
Could you make a pull request for this (and any related patches) on our git=
hub?
Thanks,
Bob


-----Original Message-----
From: Hans de Goede <hdegoede(a)redhat.com> =

Sent: Saturday, December 26, 2020 6:28 AM
To: Rafael J . Wysocki <rjw(a)rjwysocki.net>; Len Brown <lenb(a)kernel.org>=
; Moore, Robert <robert.moore(a)intel.com>; Kaneda, Erik <erik.kaneda(a)int=
el.com>
Cc: Hans de Goede <hdegoede(a)redhat.com>; linux-acpi(a)vger.kernel.org; de=
vel(a)acpica.org
Subject: [PATCH 1/2] ACPICA: Fix race in GenericSerialBus (I2C) and GPIO Op=
Region parameter handling

The handling of the GenericSerialBus (I2C) and GPIO OpRegions in
acpi_ev_address_space_dispatch() passes a number of extra parameters to the=
 address-space handler through the address-space context pointer (instead o=
f using more function parameters).

The context is shared between threads, so if multiple threads try to call t=
he handler for the same address-space at the same time, then a second threa=
d could change the parameters of a first thread while the handler is runnin=
g for the first thread.

An example of this race hitting is the Lenovo Yoga Tablet2 1015L, where the=
re are both AttribBytes accesses and AttribByte accesses to the same addres=
s-space. The AttribBytes access stores the number of bytes to transfer in c=
ontext->access_length. Where as for the AttribByte access the number of byt=
es to transfer is always 1 and field_obj->field.access_length is unused (so=
 0). Both types of accesses racing from different threads leads to the foll=
owing problem:

1. Thread a. starts an AttribBytes access, stores a non 0 value from field_=
obj->field.access_length in context->access_length 2. Thread b. starts an A=
ttribByte access, stores 0 in
context->access_length
3. Thread a. calls i2c_acpi_space_handler() (under Linux). Which sees that =
the access-type is ACPI_GSB_ACCESS_ATTRIB_MULTIBYTE and calls acpi_gsb_i2c_=
read_bytes(..., context->access_length) 4. At this point context->access_le=
ngth is 0 (set by thread b.) rather then the field_obj->field.access_length=
 value from thread a.
This 0 length reads leads to the following errors being logged:

 i2c i2c-0: adapter quirk: no zero length (addr 0x0078, size 0, read)  i2c =
i2c-0: i2c read 0 bytes from client(a)0x78 starting at reg 0x0 failed, erro=
r: -95

Note this is just an example of the problems which this race can cause.
There are likely many more (sporadic) problems caused by this race.

This commit adds a new context_mutex to acpi_object_addr_handler and makes =
acpi_ev_address_space_dispatch() take that mutex when using the shared cont=
ext to pass extra parameters to an address-space handler, fixing this race.

Note the new mutex must be taken *after* exiting the interpreter, therefor =
the existing acpi_ex_exit_interpreter() call is moved to above the code whi=
ch stores the extra parameters in the context.

Signed-off-by: Hans de Goede <hdegoede(a)redhat.com>
---
 drivers/acpi/acpica/acobject.h  |  1 +
 drivers/acpi/acpica/evhandler.c |  6 ++++  drivers/acpi/acpica/evregion.c =
 | 61 ++++++++++++++++++++++++---------  drivers/acpi/acpica/evxfregn.c  | =
 1 +
 4 files changed, 52 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/acobject.=
h index 9f0219a8cb98..dd7efafcb103 100644
--- a/drivers/acpi/acpica/acobject.h
+++ b/drivers/acpi/acpica/acobject.h
@@ -284,6 +284,7 @@ struct acpi_object_addr_handler {
 	acpi_adr_space_handler handler;
 	struct acpi_namespace_node *node;	/* Parent device */
 	void *context;
+	acpi_mutex context_mutex;
 	acpi_adr_space_setup setup;
 	union acpi_operand_object *region_list;	/* Regions using this handler */
 	union acpi_operand_object *next;
diff --git a/drivers/acpi/acpica/evhandler.c b/drivers/acpi/acpica/evhandle=
r.c index 5884eba047f7..347199f29afe 100644
--- a/drivers/acpi/acpica/evhandler.c
+++ b/drivers/acpi/acpica/evhandler.c
@@ -489,6 +489,12 @@ acpi_ev_install_space_handler(struct acpi_namespace_no=
de *node,
 =

 	/* Init handler obj */
 =

+	status =3D acpi_os_create_mutex(&handler_obj->address_space.context_mutex=
);
+	if (ACPI_FAILURE(status)) {
+		acpi_ut_remove_reference(handler_obj);
+		goto unlock_and_exit;
+	}
+
 	handler_obj->address_space.space_id =3D (u8)space_id;
 	handler_obj->address_space.handler_flags =3D flags;
 	handler_obj->address_space.region_list =3D NULL; diff --git a/drivers/acp=
i/acpica/evregion.c b/drivers/acpi/acpica/evregion.c index 21ff341e34a4..8e=
84eb0641e0 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -112,6 +112,8 @@ acpi_ev_address_space_dispatch(union acpi_operand_objec=
t *region_obj,
 	union acpi_operand_object *region_obj2;
 	void *region_context =3D NULL;
 	struct acpi_connection_info *context;
+	acpi_mutex context_mutex;
+	bool context_locked;
 	acpi_physical_address address;
 =

 	ACPI_FUNCTION_TRACE(ev_address_space_dispatch);
@@ -136,6 +138,8 @@ acpi_ev_address_space_dispatch(union acpi_operand_objec=
t *region_obj,
 	}
 =

 	context =3D handler_desc->address_space.context;
+	context_mutex =3D handler_desc->address_space.context_mutex;
+	context_locked =3D false;
 =

 	/*
 	 * It may be the case that the region has never been initialized.
@@ -204,6 +208,23 @@ acpi_ev_address_space_dispatch(union acpi_operand_obje=
ct *region_obj,
 	handler =3D handler_desc->address_space.handler;
 	address =3D (region_obj->region.address + region_offset);
 =

+	ACPI_DEBUG_PRINT((ACPI_DB_OPREGION,
+			  "Handler %p (@%p) Address %8.8X%8.8X [%s]\n",
+			  &region_obj->region.handler->address_space, handler,
+			  ACPI_FORMAT_UINT64(address),
+			  acpi_ut_get_region_name(region_obj->region.
+						  space_id)));
+
+	if (!(handler_desc->address_space.handler_flags &
+	      ACPI_ADDR_HANDLER_DEFAULT_INSTALLED)) {
+		/*
+		 * For handlers other than the default (supplied) handlers, we must
+		 * exit the interpreter because the handler *might* block -- we don't
+		 * know what it will do, so we can't hold the lock on the interpreter.
+		 */
+		acpi_ex_exit_interpreter();
+	}
+
 	/*
 	 * Special handling for generic_serial_bus and general_purpose_io:
 	 * There are three extra parameters that must be passed to the @@ -212,6 =
+233,11 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region=
_obj,
 	 *   2) Length of the above buffer
 	 *   3) Actual access length from the access_as() op
 	 *
+	 * Since we pass these extra parameters via the context, which is
+	 * shared between threads, we must lock the context to avoid these
+	 * parameters being changed from another thread before the handler
+	 * has completed running.
+	 *
 	 * In addition, for general_purpose_io, the Address and bit_width fields
 	 * are defined as follows:
 	 *   1) Address is the pin number index of the field (bit offset from
@@ -221,6 +247,13 @@ acpi_ev_address_space_dispatch(union acpi_operand_obje=
ct *region_obj,
 	if ((region_obj->region.space_id =3D=3D ACPI_ADR_SPACE_GSBUS) &&
 	    context && field_obj) {
 =

+		status =3D acpi_os_acquire_mutex(context_mutex, ACPI_WAIT_FOREVER);
+		if (ACPI_FAILURE(status)) {
+			goto re_enter_interpreter;
+		}
+
+		context_locked =3D true;
+
 		/* Get the Connection (resource_template) buffer */
 =

 		context->connection =3D field_obj->field.resource_buffer; @@ -230,6 +263=
,13 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 	if ((region_obj->region.space_id =3D=3D ACPI_ADR_SPACE_GPIO) &&
 	    context && field_obj) {
 =

+		status =3D acpi_os_acquire_mutex(context_mutex, ACPI_WAIT_FOREVER);
+		if (ACPI_FAILURE(status)) {
+			goto re_enter_interpreter;
+		}
+
+		context_locked =3D true;
+
 		/* Get the Connection (resource_template) buffer */
 =

 		context->connection =3D field_obj->field.resource_buffer; @@ -239,28 +27=
9,14 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_ob=
j,
 		bit_width =3D field_obj->field.bit_length;
 	}
 =

-	ACPI_DEBUG_PRINT((ACPI_DB_OPREGION,
-			  "Handler %p (@%p) Address %8.8X%8.8X [%s]\n",
-			  &region_obj->region.handler->address_space, handler,
-			  ACPI_FORMAT_UINT64(address),
-			  acpi_ut_get_region_name(region_obj->region.
-						  space_id)));
-
-	if (!(handler_desc->address_space.handler_flags &
-	      ACPI_ADDR_HANDLER_DEFAULT_INSTALLED)) {
-		/*
-		 * For handlers other than the default (supplied) handlers, we must
-		 * exit the interpreter because the handler *might* block -- we don't
-		 * know what it will do, so we can't hold the lock on the interpreter.
-		 */
-		acpi_ex_exit_interpreter();
-	}
-
 	/* Call the handler */
 =

 	status =3D handler(function, address, bit_width, value, context,
 			 region_obj2->extra.region_context);
 =

+	if (context_locked)
+		acpi_os_release_mutex(context_mutex);
+
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status, "Returned by Handler for [%s]",
 				acpi_ut_get_region_name(region_obj->region.
@@ -277,6 +303,7 @@ acpi_ev_address_space_dispatch(union acpi_operand_objec=
t *region_obj,
 		}
 	}
 =

+re_enter_interpreter:
 	if (!(handler_desc->address_space.handler_flags &
 	      ACPI_ADDR_HANDLER_DEFAULT_INSTALLED)) {
 		/*
diff --git a/drivers/acpi/acpica/evxfregn.c b/drivers/acpi/acpica/evxfregn.=
c index da97fd0c6b51..74d0ee8a5736 100644
--- a/drivers/acpi/acpica/evxfregn.c
+++ b/drivers/acpi/acpica/evxfregn.c
@@ -201,6 +201,7 @@ acpi_remove_address_space_handler(acpi_handle device,
 =

 			/* Now we can delete the handler object */
 =

+			acpi_os_release_mutex(handler_obj->address_space.context_mutex);
 			acpi_ut_remove_reference(handler_obj);
 			goto unlock_and_exit;
 		}
--
2.28.0

--===============8811519629171872132==--

