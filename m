Content-Type: multipart/mixed; boundary="===============7007116123359897424=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [PATCH] ACPICA: Silent warnings about empty body in
 if/else statement
Date: Mon, 26 Feb 2018 23:11:37 +0100
Message-ID: <CAJZ5v0gkswV4xxB11FzyRD1DnnNKXGG-nyJ83fFwRfU9x9BBLQ@mail.gmail.com>
In-Reply-To: 20180226113431.3e43a032@endymion
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7007116123359897424==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2018 at 11:34 AM, Jean Delvare <jdelvare(a)suse.de> wrote:
> When ACPI debugging is disabled, I see warnings like this one:
>
> drivers/i2c/busses/i2c-scmi.c: In function "acpi_smbus_cmi_add_cap":
> drivers/i2c/busses/i2c-scmi.c:328:39: warning: suggest braces around empt=
y body in an "else" statement [-Wempty-body]
> drivers/i2c/busses/i2c-scmi.c:338:12: warning: suggest braces around empt=
y body in an "else" statement [-Wempty-body]
>
> It is caused by ACPI_DEBUG_PRINT (or other similar macros) resolving
> to nothing. Make them resolve to the classic "do {} while (0)"
> construct instead if the compiler likes that, or just {} if not, to
> silent all such warnings.

So first of all, acpi_smbus_cmi_add_cap() shouldn't really use
ACPI_DEBUG_PRINT() and similar.  They belong to ACPICA and their use
should be limited to it.

I know that they are used in the other parts of the ACPI subsystem,
but they really should be replaced with the kernel's proper debug
statements in there.

Thanks,
Rafael

--===============7007116123359897424==--

