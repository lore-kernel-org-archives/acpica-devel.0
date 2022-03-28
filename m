Content-Type: multipart/mixed; boundary="===============8892647503231965771=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH 05/22] acpica: Replace comments with C99
 initializers
Date: Mon, 28 Mar 2022 14:33:29 +0200
Message-ID: <CAJZ5v0iJ=t26mnxHx9B+_A3ue7tVjgATN=TTtNNf2UNfuySd7Q@mail.gmail.com>
In-Reply-To: 20220326165909.506926-5-benni@stuerz.xyz
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8892647503231965771==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 26, 2022 at 6:09 PM Benjamin St=C3=BCrz <benni(a)stuerz.xyz> wr=
ote:
>
> This replaces comments with C99's designated
> initializers because the kernel supports them now.

However, note that all of the ACPICA material should be submitted to
the upstream ACPICA project via https://github.com/acpica/acpica

Also please note that the set of compilers that need to be supported
by the ACPICA project is greater than the set of compilers that can
build the Linux kernel.


> Signed-off-by: Benjamin St=C3=BCrz <benni(a)stuerz.xyz>
> ---
>  drivers/acpi/acpica/utdecode.c | 183 ++++++++++++++++-----------------
>  1 file changed, 90 insertions(+), 93 deletions(-)
>
> diff --git a/drivers/acpi/acpica/utdecode.c b/drivers/acpi/acpica/utdecod=
e.c
> index bcd3871079d7..d19868d2ea46 100644
> --- a/drivers/acpi/acpica/utdecode.c
> +++ b/drivers/acpi/acpica/utdecode.c
> @@ -156,37 +156,37 @@ static const char acpi_gbl_bad_type[] =3D "UNDEFINE=
D";
>  /* Printable names of the ACPI object types */
>
>  static const char *acpi_gbl_ns_type_names[] =3D {
> -       /* 00 */ "Untyped",
> -       /* 01 */ "Integer",
> -       /* 02 */ "String",
> -       /* 03 */ "Buffer",
> -       /* 04 */ "Package",
> -       /* 05 */ "FieldUnit",
> -       /* 06 */ "Device",
> -       /* 07 */ "Event",
> -       /* 08 */ "Method",
> -       /* 09 */ "Mutex",
> -       /* 10 */ "Region",
> -       /* 11 */ "Power",
> -       /* 12 */ "Processor",
> -       /* 13 */ "Thermal",
> -       /* 14 */ "BufferField",
> -       /* 15 */ "DdbHandle",
> -       /* 16 */ "DebugObject",
> -       /* 17 */ "RegionField",
> -       /* 18 */ "BankField",
> -       /* 19 */ "IndexField",
> -       /* 20 */ "Reference",
> -       /* 21 */ "Alias",
> -       /* 22 */ "MethodAlias",
> -       /* 23 */ "Notify",
> -       /* 24 */ "AddrHandler",
> -       /* 25 */ "ResourceDesc",
> -       /* 26 */ "ResourceFld",
> -       /* 27 */ "Scope",
> -       /* 28 */ "Extra",
> -       /* 29 */ "Data",
> -       /* 30 */ "Invalid"
> +       [0]  =3D "Untyped",
> +       [1]  =3D "Integer",
> +       [2]  =3D "String",
> +       [3]  =3D "Buffer",
> +       [4]  =3D "Package",
> +       [5]  =3D "FieldUnit",
> +       [6]  =3D "Device",
> +       [7]  =3D "Event",
> +       [8]  =3D "Method",
> +       [9]  =3D "Mutex",
> +       [10] =3D "Region",
> +       [11] =3D "Power",
> +       [12] =3D "Processor",
> +       [13] =3D "Thermal",
> +       [14] =3D "BufferField",
> +       [15] =3D "DdbHandle",
> +       [16] =3D "DebugObject",
> +       [17] =3D "RegionField",
> +       [18] =3D "BankField",
> +       [19] =3D "IndexField",
> +       [20] =3D "Reference",
> +       [21] =3D "Alias",
> +       [22] =3D "MethodAlias",
> +       [23] =3D "Notify",
> +       [24] =3D "AddrHandler",
> +       [25] =3D "ResourceDesc",
> +       [26] =3D "ResourceFld",
> +       [27] =3D "Scope",
> +       [28] =3D "Extra",
> +       [29] =3D "Data",
> +       [30] =3D "Invalid"
>  };
>
>  const char *acpi_ut_get_type_name(acpi_object_type type)
> @@ -284,22 +284,22 @@ const char *acpi_ut_get_node_name(void *object)
>  /* Printable names of object descriptor types */
>
>  static const char *acpi_gbl_desc_type_names[] =3D {
> -       /* 00 */ "Not a Descriptor",
> -       /* 01 */ "Cached Object",
> -       /* 02 */ "State-Generic",
> -       /* 03 */ "State-Update",
> -       /* 04 */ "State-Package",
> -       /* 05 */ "State-Control",
> -       /* 06 */ "State-RootParseScope",
> -       /* 07 */ "State-ParseScope",
> -       /* 08 */ "State-WalkScope",
> -       /* 09 */ "State-Result",
> -       /* 10 */ "State-Notify",
> -       /* 11 */ "State-Thread",
> -       /* 12 */ "Tree Walk State",
> -       /* 13 */ "Parse Tree Op",
> -       /* 14 */ "Operand Object",
> -       /* 15 */ "Namespace Node"
> +       [0]  =3D "Not a Descriptor",
> +       [1]  =3D "Cached Object",
> +       [2]  =3D "State-Generic",
> +       [3]  =3D "State-Update",
> +       [4]  =3D "State-Package",
> +       [5]  =3D "State-Control",
> +       [6]  =3D "State-RootParseScope",
> +       [7]  =3D "State-ParseScope",
> +       [8]  =3D "State-WalkScope",
> +       [9]  =3D "State-Result",
> +       [10] =3D "State-Notify",
> +       [11] =3D "State-Thread",
> +       [12] =3D "Tree Walk State",
> +       [13] =3D "Parse Tree Op",
> +       [14] =3D "Operand Object",
> +       [15] =3D "Namespace Node"
>  };
>
>  const char *acpi_ut_get_descriptor_name(void *object)
> @@ -331,13 +331,13 @@ const char *acpi_ut_get_descriptor_name(void *objec=
t)
>  /* Printable names of reference object sub-types */
>
>  static const char *acpi_gbl_ref_class_names[] =3D {
> -       /* 00 */ "Local",
> -       /* 01 */ "Argument",
> -       /* 02 */ "RefOf",
> -       /* 03 */ "Index",
> -       /* 04 */ "DdbHandle",
> -       /* 05 */ "Named Object",
> -       /* 06 */ "Debug"
> +       [0] =3D "Local",
> +       [1] =3D "Argument",
> +       [2] =3D "RefOf",
> +       [3] =3D "Index",
> +       [4] =3D "DdbHandle",
> +       [5] =3D "Named Object",
> +       [6] =3D "Debug"
>  };
>
>  const char *acpi_ut_get_reference_name(union acpi_operand_object *object)
> @@ -416,25 +416,22 @@ const char *acpi_ut_get_mutex_name(u32 mutex_id)
>  /* Names for Notify() values, used for debug output */
>
>  static const char *acpi_gbl_generic_notify[ACPI_GENERIC_NOTIFY_MAX + 1] =
=3D {
> -       /* 00 */ "Bus Check",
> -       /* 01 */ "Device Check",
> -       /* 02 */ "Device Wake",
> -       /* 03 */ "Eject Request",
> -       /* 04 */ "Device Check Light",
> -       /* 05 */ "Frequency Mismatch",
> -       /* 06 */ "Bus Mode Mismatch",
> -       /* 07 */ "Power Fault",
> -       /* 08 */ "Capabilities Check",
> -       /* 09 */ "Device PLD Check",
> -       /* 0A */ "Reserved",
> -       /* 0B */ "System Locality Update",
> -                                                               /* 0C */ =
"Reserved (was previously Shutdown Request)",
> -                                                               /* Reserv=
ed in ACPI 6.0 */
> -       /* 0D */ "System Resource Affinity Update",
> -                                                               /* 0E */ =
"Heterogeneous Memory Attributes Update",
> -                                                               /* ACPI 6=
.2 */
> -                                               /* 0F */ "Error Disconnec=
t Recover"
> -                                               /* ACPI 6.3 */
> +       [0]  =3D "Bus Check",
> +       [1]  =3D "Device Check",
> +       [2]  =3D "Device Wake",
> +       [3]  =3D "Eject Request",
> +       [4]  =3D "Device Check Light",
> +       [5]  =3D "Frequency Mismatch",
> +       [6]  =3D "Bus Mode Mismatch",
> +       [7]  =3D "Power Fault",
> +       [8]  =3D "Capabilities Check",
> +       [9]  =3D "Device PLD Check",
> +       [10] =3D "Reserved",
> +       [11] =3D "System Locality Update",
> +       [12] =3D "Reserved (was previously Shutdown Request)",  /* Reserv=
ed in ACPI 6.0 */
> +       [13] =3D "System Resource Affinity Update",
> +       [14] =3D "Heterogeneous Memory Attributes Update",      /* ACPI 6=
.2 */
> +       [15] =3D "Error Disconnect Recover"                     /* ACPI 6=
.3 */
>  };
>
>  static const char *acpi_gbl_device_notify[5] =3D {
> @@ -521,26 +518,26 @@ const char *acpi_ut_get_notify_name(u32 notify_valu=
e, acpi_object_type type)
>   ***********************************************************************=
*******/
>
>  static const char *acpi_gbl_argument_type[20] =3D {
> -       /* 00 */ "Unknown ARGP",
> -       /* 01 */ "ByteData",
> -       /* 02 */ "ByteList",
> -       /* 03 */ "CharList",
> -       /* 04 */ "DataObject",
> -       /* 05 */ "DataObjectList",
> -       /* 06 */ "DWordData",
> -       /* 07 */ "FieldList",
> -       /* 08 */ "Name",
> -       /* 09 */ "NameString",
> -       /* 0A */ "ObjectList",
> -       /* 0B */ "PackageLength",
> -       /* 0C */ "SuperName",
> -       /* 0D */ "Target",
> -       /* 0E */ "TermArg",
> -       /* 0F */ "TermList",
> -       /* 10 */ "WordData",
> -       /* 11 */ "QWordData",
> -       /* 12 */ "SimpleName",
> -       /* 13 */ "NameOrRef"
> +       [0x00] =3D "Unknown ARGP",
> +       [0x01] =3D "ByteData",
> +       [0x02] =3D "ByteList",
> +       [0x03] =3D "CharList",
> +       [0x04] =3D "DataObject",
> +       [0x05] =3D "DataObjectList",
> +       [0x06] =3D "DWordData",
> +       [0x07] =3D "FieldList",
> +       [0x08] =3D "Name",
> +       [0x09] =3D "NameString",
> +       [0x0A] =3D "ObjectList",
> +       [0x0B] =3D "PackageLength",
> +       [0x0C] =3D "SuperName",
> +       [0x0D] =3D "Target",
> +       [0x0E] =3D "TermArg",
> +       [0x0F] =3D "TermList",
> +       [0x10] =3D "WordData",
> +       [0x11] =3D "QWordData",
> +       [0x12] =3D "SimpleName",
> +       [0x13] =3D "NameOrRef"
>  };
>
>  const char *acpi_ut_get_argument_type_name(u32 arg_type)
> --
> 2.35.1
>
--===============8892647503231965771==--

