Content-Type: multipart/mixed; boundary="===============0342567379697629372=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH 4.20 regression fix] ACPICA: Fix handling of
 buffer-size in acpi_ex_write_data_to_field()
Date: Tue, 27 Nov 2018 03:11:25 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B9524C4E@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E3B9524BDD@ORSMSX110.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0342567379697629372==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Also, please send the acpidump for whatever machine is showing a problem.

We want to look closely at the surface 3 code vs. the code for this machine.
Thanks,
Bob


-----Original Message-----
From: Moore, Robert =

Sent: Monday, November 26, 2018 2:33 PM
To: Schmauss, Erik <erik.schmauss(a)intel.com>; Rafael J. Wysocki <rjw(a)rj=
wysocki.net>; Hans de Goede <hdegoede(a)redhat.com>
Cc: Len Brown <lenb(a)kernel.org>; linux-acpi(a)vger.kernel.org; devel(a)ac=
pica.org
Subject: RE: [PATCH 4.20 regression fix] ACPICA: Fix handling of buffer-siz=
e in acpi_ex_write_data_to_field()

Looks like another round of issues with the completely ill-defined generic =
serial bus. Below is a summary of the problems we have seen with the Length=
 field.

I have not had time to completely read through this thread yet, so I'm post=
ing some text that I wrote a month or two ago.

Let me say this, however:

The biggest (and it is very big) issue is that the GenericSerialBus interfa=
ces are so poorly defined in the ACPI specification that any implementation=
 simply must guess at the proper behavior (Both the ACPI implementation and=
 any related drivers).

Bob



Problems with these ACPI chapters:
5.5.2.4.6.2 Declaring and Using a GenericSerialBus Data Buffer
5.5.2.4.6.3 Using the GenericSerialBus Protocols


1) All of the ASL code examples do not compile due to syntax errors. There =
are
10 such examples, often with multiple syntax errors.


2) The basic/common data buffer format is not fully defined:
    typedef struct
    {
        BYTE        Status;  // Byte 0 of the data buffer
        BYTE        Length;  // Byte 1 of the data buffer
        BYTE[x-1]   Data;    // Bytes 2-x of the arbitrary length data buff=
er,
    } // where x is the last index of the overall buffer

The "Length" field is not defined. Is it the length of "Data" or the Length=
 of the entire structure (Status + Length + Data)?

The example code from the spec illustrates how the "Length" term in the str=
ucture above is undefined. Again, is it the "length of entire structure" or=
 is it the "length of the Data element"?. The example code makes it appear =
that it is the length of the entire structure, but it is not fully clear be=
cause it is wrong in either case:

    Name(BUFF, Buffer(34)())            // Create GenericSerialBus data buf=
fer
as BUFF
    CreateByteField(BUFF, 0x00, STAT)   // STAT =3D Status (Byte)
    CreateByteField(BUFF, 0x01, LEN)    // LEN =3D Length (Byte)
    CreateField(BUFF, 0x10, 256, DATA)  // Data (Block)

    Store("ACPI", DATA)  // Fill in outgoing data
    Store(8, LEN)        // Length of the valid data
        (Actually should be 6? Or should it be 4?)




--===============0342567379697629372==--

