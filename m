Content-Type: multipart/mixed; boundary="===============9063024242735958191=="
MIME-Version: 1.0
From: Andriy Gapon <avg at FreeBSD.org>
Subject: Re: [Devel] ref-counting races?
Date: Sat, 10 Nov 2012 17:04:01 +0200
Message-ID: <509E6CE1.8050706@FreeBSD.org>
In-Reply-To: 509D2869.5030703@FreeBSD.org
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============9063024242735958191==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

on 09/11/2012 17:59 Andriy Gapon said the following:
> on 09/11/2012 17:42 Moore, Robert said the following:
>>> To make sure that we speak about the same thing - is e.g.
>>> AcpiUtEvaluateObject always called under that lock?
>>
>> Yes.
>>
>>
>> AcpiUtEvaluateObject
>>     AcpiNsEvaluate
>>         AcpiExEnterInterpreter ();
>>             AcpiUtAcquireMutex (ACPI_MTX_INTERPRETER);
>>         AcpiPsExecuteMethod (Info);
>>
> =

> This is not exactly what I meant.  ACPI_MTX_INTERPRETER does not cover th=
e calls
> to AcpiUtRemoveReference that can be made in AcpiUtEvaluateObject or in
> AcpiUtExecute_HID or in AcpiUtEvaluateNumericObject, etc.
> There could be other places in the code where AcpiUtRemoveReference or
> AcpiUtAddReference are called without any lock serializing the access to a
> reference counter.
> =


Just in case, AcpiEvaluateObject->AcpiNsResolveReferences seems to be an ex=
ample
of a place where AcpiUtAddReference is called without ACPI_MTX_INTERPRETER
serialization.
-- =

Andriy Gapon

--===============9063024242735958191==--

