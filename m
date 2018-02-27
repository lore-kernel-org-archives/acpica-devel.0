Content-Type: multipart/mixed; boundary="===============1086412576134814245=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [PATCH] ACPICA: Silent warnings about empty body in
 if/else statement
Date: Tue, 27 Feb 2018 13:42:47 +0100
Message-ID: <CAJZ5v0hmZ69iNOgBGOh25fpxyhfB97Kh8V1Rn3vwVXBD5AjBHQ@mail.gmail.com>
In-Reply-To: 20180227133700.0f995b28@endymion
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1086412576134814245==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2018 at 1:37 PM, Jean Delvare <jdelvare(a)suse.de> wrote:
> On Tue, 27 Feb 2018 11:14:07 +0100, Rafael J. Wysocki wrote:
>> On Tue, Feb 27, 2018 at 10:23 AM, Jean Delvare <jdelvare(a)suse.de> wrot=
e:
>> > OK, thanks for the information. I'll update the i2c-scmi driver to
>> > no longer use ACPI_DEBUG_PRINT. There are a few other drivers using it=
 as
>> > well though (xo15-ebook and panasonic-laptop, as well as
>> > xen-acpi-memhotplug - not sure if you consider that one as more
>> > legitimate.)
>>
>> None of them is valid IMO.  ACPI_DEBUG_PRINT() really should only be
>> used in the ACPICA code.
>
> What about ACPI_ERROR()? The i2c-scmi driver uses these as well. Should
> I convert them to dev_err()?

I think so.

That or acpi_handle_error().

--===============1086412576134814245==--

