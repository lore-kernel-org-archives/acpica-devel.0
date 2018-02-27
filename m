Content-Type: multipart/mixed; boundary="===============2085503590925258190=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [PATCH] ACPICA: Silent warnings about empty body in
 if/else statement
Date: Tue, 27 Feb 2018 11:14:07 +0100
Message-ID: <CAJZ5v0iToN018B6Fu1ixqfKGeVgs32bwjevc_6tzfsDUuGrb_w@mail.gmail.com>
In-Reply-To: 20180227102302.47292d12@endymion
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2085503590925258190==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2018 at 10:23 AM, Jean Delvare <jdelvare(a)suse.de> wrote:
> Hi Rafael,

Hi,

> On Mon, 26 Feb 2018 23:11:37 +0100, Rafael J. Wysocki wrote:
>> On Mon, Feb 26, 2018 at 11:34 AM, Jean Delvare <jdelvare(a)suse.de> wrot=
e:
>> > When ACPI debugging is disabled, I see warnings like this one:
>> >
>> > drivers/i2c/busses/i2c-scmi.c: In function "acpi_smbus_cmi_add_cap":
>> > drivers/i2c/busses/i2c-scmi.c:328:39: warning: suggest braces around e=
mpty body in an "else" statement [-Wempty-body]
>> > drivers/i2c/busses/i2c-scmi.c:338:12: warning: suggest braces around e=
mpty body in an "else" statement [-Wempty-body]
>> >
>> > It is caused by ACPI_DEBUG_PRINT (or other similar macros) resolving
>> > to nothing. Make them resolve to the classic "do {} while (0)"
>> > construct instead if the compiler likes that, or just {} if not, to
>> > silent all such warnings.
>>
>> So first of all, acpi_smbus_cmi_add_cap() shouldn't really use
>> ACPI_DEBUG_PRINT() and similar.  They belong to ACPICA and their use
>> should be limited to it.
>
> OK, thanks for the information. I'll update the i2c-scmi driver to
> no longer use ACPI_DEBUG_PRINT. There are a few other drivers using it as
> well though (xo15-ebook and panasonic-laptop, as well as
> xen-acpi-memhotplug - not sure if you consider that one as more
> legitimate.)

None of them is valid IMO.  ACPI_DEBUG_PRINT() really should only be
used in the ACPICA code.

And we have acpi_handle_debug() even for everybody else.

>> I know that they are used in the other parts of the ACPI subsystem,
>> but they really should be replaced with the kernel's proper debug
>> statements in there.
>
> Ideally all these macros shouldn't be exposed to drivers which are not
> supposed to use them. Could they be moved to a header file internal to
> at least acpi?

We get that code from the upstream and I don't want to differ from it
in arbitrary ways.  I'm not sure about the possible consequences of
that change in the upstream code ATM, though.

--===============2085503590925258190==--

