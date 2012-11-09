Content-Type: multipart/mixed; boundary="===============8837980237577171582=="
MIME-Version: 1.0
From: Andriy Gapon <avg at FreeBSD.org>
Subject: Re: [Devel] ref-counting races?
Date: Fri, 09 Nov 2012 17:59:37 +0200
Message-ID: <509D2869.5030703@FreeBSD.org>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E346BBFD23@ORSMSX101.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8837980237577171582==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

on 09/11/2012 17:42 Moore, Robert said the following:
>> To make sure that we speak about the same thing - is e.g.
>> AcpiUtEvaluateObject always called under that lock?
> =

> Yes.
> =

> =

> AcpiUtEvaluateObject
>     AcpiNsEvaluate
>         AcpiExEnterInterpreter ();
>             AcpiUtAcquireMutex (ACPI_MTX_INTERPRETER);
>         AcpiPsExecuteMethod (Info);
> =


This is not exactly what I meant.  ACPI_MTX_INTERPRETER does not cover the =
calls
to AcpiUtRemoveReference that can be made in AcpiUtEvaluateObject or in
AcpiUtExecute_HID or in AcpiUtEvaluateNumericObject, etc.
There could be other places in the code where AcpiUtRemoveReference or
AcpiUtAddReference are called without any lock serializing the access to a
reference counter.

-- =

Andriy Gapon

--===============8837980237577171582==--

