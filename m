Content-Type: multipart/mixed; boundary="===============4347496414525397135=="
MIME-Version: 1.0
From: =?utf-8?q?Gr=C3=A9goire_Sutre_=3Cgregoire=2Esutre_at_gmail=2Ecom=3E?=
Subject: [Devel] Why are empty packages invalid for predefined ACPI objects?
Date: Sat, 06 Nov 2010 16:23:30 +0100
Message-ID: <4CD572F2.8010805@gmail.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4347496414525397135==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

The package validation function AcpiNsCheckPackage() in file nspredef.c
requires that packages be non-empty:

     /* The package must have at least one element, else invalid */

     if (!Count)
     {
         ACPI_WARN_PREDEFINED ((AE_INFO, Data->Pathname, Data->NodeFlags,
             "Return Package has no elements (empty)"));

         return (AE_AML_OPERAND_VALUE);
     }

I don't see, from the ACPI specification, why packages for predefined
ACPI objects must be non-empty.

Where does this requirement come from?

Best regards,

Gr=C3=A9goire Sutre

--===============4347496414525397135==--

