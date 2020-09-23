Content-Type: multipart/mixed; boundary="===============1613866283435152063=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] Re: Automatic dereference when reading from ArgX
Date: Wed, 23 Sep 2020 16:38:08 +0000
Message-ID: <BYAPR11MB3256F56601FD2F961B268C5F87380@BYAPR11MB3256.namprd11.prod.outlook.com>
In-Reply-To: 20200922224728.2835.56590@ml01.vlan13.01.org
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1613866283435152063==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This seems to make things work (Because taking a DeRefOf on an Arg is the s=
ame as taking a DeRefOf on the base object (An integer in this case). Which=
 causes an error.

    Method (DRFA, 1) {
        //printf("Arg0: %o", DeRefOf(Arg0))
        printf("Arg0: %o", Arg0)
        //Store (DeRefOf(Arg0), INTX)
        Store (Arg0, INTX)       // <- line 10
        Debug =3D INTX
    }

    Method (MAIN, 0)
    {
        DRFA(INT5) //RefOf(INT5))
    }
}

- ev main
Evaluating \MAIN
ACPI Debug:  "Arg0: 0000000000000005"
ACPI Debug:  0x0000000000000005
No object was returned from evaluation of \MAIN


-----Original Message-----
From: dunkaist(a)gmail.com <dunkaist(a)gmail.com> =

Sent: Tuesday, September 22, 2020 3:47 PM
To: devel(a)acpica.org
Subject: [Devel] Automatic dereference when reading from ArgX

Hello,

I've been struggling to find out how acpiexec behavior corresponds to what =
ACPI spec says.


ACPI 6.3 spec, Chapter 19.3.5.9.1 ArgX Objects, 1. Read from ArgX parameter=
s:
> ObjectReference - Automatic dereference, return the target of the referen=
ce. Use of DeRefOf returns the same.

ACPI spec, Table 19-421 Reading from ArgX Objects:
> Parameter: RefOf(Obj)
> MTHD ArgX Type: Reference to object Obj Read operation on ArgX: =

> Store(Arg0, ...) Result of read: Obj


Then, here is a table I've written (argx_deref.asl):

DefinitionBlock ("", "DSDT", 1, "BLAH", "BLAHDSDT", 0x00000001)
{
    Name (INT5, 5)
    Name (INTX, 0)

    Method (DRFA, 1) {
        printf("Arg0: %o", DeRefOf(Arg0))
        printf("Arg0: %o", Arg0)
        Store (DeRefOf(Arg0), INTX)
        Store (Arg0, INTX)       // <- line 10
        Debug =3D INTX
    }

    Method (MAIN, 0)
    {
        DRFA(RefOf(INT5))
    }
}


Finally, the output of `acpiexec -m -eo argx_deref.aml':

> Intel ACPI Component Architecture
> AML Execution/Debug Utility version 20200717
> ...
>    Nested method call     :     DRFA
> ACPI Debug:  "Arg0: 00000005"
> ACPI Debug:  "Arg0: [Reference Object]"
> ACPI Error: Cannot assign type [Reference] to [Integer] (must be type Int=
/Str/Buf) (20200717/exstoren-239)
> Failed at AML Offset 00024, Opcode 0070: Store (Arg0, INTX) /* External r=
eference */
> ...


So, it turnes out (or at least seems to me) that Store(Arg0, ...) at line 1=
0 reads a Reference object, not an Integer one as the spec says.
I.e. there is no automatic dereference.

Do I miss something? Could you elaborate on this, please?

Thank you,
Ivan
_______________________________________________
Devel mailing list -- devel(a)acpica.org
To unsubscribe send an email to devel-leave(a)acpica.org
%(web_page_url)slistinfo%(cgiext)s/%(_internal_name)s
--===============1613866283435152063==--

