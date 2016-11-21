Content-Type: multipart/mixed; boundary="===============0369078395078937882=="
MIME-Version: 1.0
From: Al Stone <ahs3 at redhat.com>
Subject: Re: [Devel] Question about the code in
 source/components/hardware/hwxfsleep.c
Date: Mon, 21 Nov 2016 12:46:52 -0700
Message-ID: <08d8e4d2-bc84-52bf-f8af-c7fbd469754f@redhat.com>
In-Reply-To: 1726054798.2937692.1478908398300@mail.yahoo.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0369078395078937882==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 11/11/2016 04:53 PM, Kein Yuan wrote:
> Hi ACPICA experts,
>    A quick question, =

> =

> File: source/components/hardware/hwxfsleep.c
> Function: AcpiHwSetFirmwareWakingVector
> =

> static ACPI_STATUS
> AcpiHwSetFirmwareWakingVector (
>     ACPI_TABLE_FACS         *Facs,
>     ACPI_PHYSICAL_ADDRESS   PhysicalAddress,
>     ACPI_PHYSICAL_ADDRESS   PhysicalAddress64)
> {
>     ACPI_FUNCTION_TRACE (AcpiHwSetFirmwareWakingVector);
> =

> =

>     /*
>      * According to the ACPI specification 2.0c and later, the 64-bit
>      * waking vector should be cleared and the 32-bit waking vector should
>      * be used, unless we want the wake-up code to be called by the BIOS =
in
>      * Protected Mode. Some systems (for example HP dv5-1004nr) are known
>      * to fail to resume if the 64-bit vector is used.
>      */
> =

>     /* Set the 32-bit vector */
> =

>     Facs->FirmwareWakingVector =3D (UINT32) PhysicalAddress;
> =

>     if (Facs->Length > 32)   // ---------------------> Question for this =
compare
>     {
>         if (Facs->Version >=3D 1)
>         {
>             /* Set the 64-bit vector */
> =

>             Facs->XFirmwareWakingVector =3D PhysicalAddress64;
>         }
>         else
>         {
>             /* Clear the 64-bit vector if it exists */
> =

>             Facs->XFirmwareWakingVector =3D 0;
>         }
>     }
> =

>     return_ACPI_STATUS (AE_OK);
> }
> =

> Since the FACS structure defined as:
> typedef struct acpi_table_facs
> {
>     char                    Signature[4];           /* ASCII table signat=
ure */
>     UINT32                  Length;                 /* Length of structur=
e, in
> bytes */
>     UINT32                  HardwareSignature;      /* Hardware configura=
tion
> signature */
>     UINT32                  FirmwareWakingVector;   /* 32-bit physical ad=
dress
> of the Firmware Waking Vector */
>     UINT32                  GlobalLock;             /* Global Lock for sh=
ared
> hardware resources */
>     UINT32                  Flags;
>     UINT64                  XFirmwareWakingVector;  /* 64-bit version of =
the
> Firmware Waking Vector (ACPI 2.0+) */
>     UINT8                   Version;                /* Version of this ta=
ble
> (ACPI 2.0+) */
>     UINT8                   Reserved[3];            /* Reserved, must be =
zero */
>     UINT32                  OspmFlags;              /* Flags to be set by=
 OSPM
> (ACPI 4.0) */
>     UINT8                   Reserved1[24];          /* Reserved, must be =
zero */
> =

> } ACPI_TABLE_FACS;
> =

> =

> May I know in what case Facs->Length < 32?
> =

> If looks to me that Facs->XFirmwareWakingVector =3D PhysicalAddress64; wi=
ll always
> be executed?
> =

> Thanks,
> Kein

IIRC, very old versions of the FACS were < 32 bytes long; those old versions
did not have a XFirmwareWakingVector field, or a proper Version field.  For
that case, the function just returns after doing nothing.  If the FACS is
larger than 32 bytes, it should have a Version field, but it looks like ver=
sion
1 does not have a usable XFirmwareWakingVector field -- i.e., it is defined=
 in
the struct, but is not valid until a later version of the ACPI specification
where Facs->Version >=3D 2.  So, for Version =3D=3D 1, ignore the field, bu=
t for
versions > 1, set the field.

Does that help?

-- =

ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3(a)redhat.com
-----------------------------------

--===============0369078395078937882==--

