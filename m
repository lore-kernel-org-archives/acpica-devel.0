Content-Type: multipart/mixed; boundary="===============1934862455665529164=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rjw at rjwysocki.net>
Subject: Re: [Devel] [PATCH 4.20 regression fix] ACPICA: Fix handling of
 buffer-size in acpi_ex_write_data_to_field()
Date: Mon, 26 Nov 2018 23:41:15 +0100
Message-ID: <25303254.caTxHKLQR8@aspire.rjw.lan>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E3B9524BDD@ORSMSX110.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1934862455665529164==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Monday, November 26, 2018 11:33:25 PM CET Moore, Robert wrote:
> Looks like another round of issues with the completely ill-defined generi=
c serial bus. Below is a summary of the problems we have seen with the Leng=
th field.
> =

> I have not had time to completely read through this thread yet, so I'm po=
sting some text that I wrote a month or two ago.
> =

> Let me say this, however:
> =

> The biggest (and it is very big) issue is that the GenericSerialBus inter=
faces are so poorly defined in the ACPI specification that any implementati=
on simply must guess at the proper behavior (Both the ACPI implementation a=
nd any related drivers).

OK, so what about the $subject patch?

Machines don't boot without it and that's rather serious, so I'm inclined to
apply it as a quick fix for 4.20, unless you have a better idea.


> Problems with these ACPI chapters:
> 5.5.2.4.6.2 Declaring and Using a GenericSerialBus Data Buffer
> 5.5.2.4.6.3 Using the GenericSerialBus Protocols
> =

> =

> 1) All of the ASL code examples do not compile due to syntax errors. Ther=
e are
> 10 such examples, often with multiple syntax errors.
> =

> =

> 2) The basic/common data buffer format is not fully defined:
>     typedef struct
>     {
>         BYTE        Status;  // Byte 0 of the data buffer
>         BYTE        Length;  // Byte 1 of the data buffer
>         BYTE[x-1]   Data;    // Bytes 2-x of the arbitrary length data bu=
ffer,
>     } // where x is the last index of the overall buffer
> =

> The "Length" field is not defined. Is it the length of "Data" or the Leng=
th of the entire structure (Status + Length + Data)?
> =

> The example code from the spec illustrates how the "Length" term in the s=
tructure above is undefined. Again, is it the "length of entire structure" =
or is it the "length of the Data element"?. The example code makes it appea=
r that it is the length of the entire structure, but it is not fully clear =
because it is wrong in either case:
> =

>     Name(BUFF, Buffer(34)())            // Create GenericSerialBus data b=
uffer
> as BUFF
>     CreateByteField(BUFF, 0x00, STAT)   // STAT =3D Status (Byte)
>     CreateByteField(BUFF, 0x01, LEN)    // LEN =3D Length (Byte)
>     CreateField(BUFF, 0x10, 256, DATA)  // Data (Block)
> =

>     Store("ACPI", DATA)  // Fill in outgoing data
>     Store(8, LEN)        // Length of the valid data
>         (Actually should be 6? Or should it be 4?)
> =

> =

> =




--===============1934862455665529164==--

