Content-Type: multipart/mixed; boundary="===============1320408173806763577=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH v2 0/5] ACPI: Do not call _STA on battery devices
 with unmet dependencies
Date: Thu, 08 Feb 2018 17:34:17 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B7570FA0@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 7efce3e1-4cb7-fa68-9024-73fa124b9171@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1320408173806763577==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> > The last one needs to go in via ACPICA anyway or we'll need to carry a
> > Linux-specific replacement for acpi_get_object_info().
> =

> Ack, I'm discussing how to proceed with this with the ACPICA people.
> =

> Regards,
> =

> Hans


I normally don't like to change external interfaces (the biggest reason bei=
ng the sheer number of different OS vendors that use ACPICA), but in this c=
ase, I feel it may be OK. This interface is probably not heavily used, and =
there is precedent for this when the invocation of _SUB was removed.

On the other hand, I think I saw it mentioned that Linux calls this interfa=
ce only once, is this correct? If so, perhaps it would be easiest to simply=
 remove this call and use direct control method invocations to obtain the d=
esired data.

If we go ahead and make this change to ACPICA: I have not seen the patch, b=
ut please make sure that all vestiges of this are removed. This includes al=
l invocations within ACPICA that examine the result of the _STA invocation,=
 the CurrentStatus field of ACPI_DEVICE_INFO, the ACPI_VALID_STA flag, etc.

Bob


--===============1320408173806763577==--

