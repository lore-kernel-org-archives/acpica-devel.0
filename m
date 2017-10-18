Content-Type: multipart/mixed; boundary="===============4895128586282049238=="
MIME-Version: 1.0
From: gengdongjiu <gengdongjiu at huawei.com>
Subject: Re: [Devel] [PATCH v5 2/2] acpi: apei: Add SEI notification type
 support for ARMv8
Date: Wed, 18 Oct 2017 18:21:38 +0800
Message-ID: <cdbf7880-a515-6394-fc24-6a4498cace2c@huawei.com>
In-Reply-To: 59E72290.6060604@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4895128586282049238==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 2017/10/18 17:44, James Morse wrote:
>> The thing is abbreviated as "SEI" and apparently means "System Error
>> Interrupt". Nothing else.
> ARM has 'external abort', which are either synchronous or asynchronous, b=
oth are
> delivered as different types of exception.
> =

> Asynchronous external abort is treated as a special kind of interrupt, 'S=
Error
> Interrupt', (where SError stands for System Error, but its rarely written=
 like
> that). 'SEI' is a relatively new abbreviation for SError interrupt.
> =

> =

> What should we call this thing? In the ACPI code I'd prefer 'SEI' as that=
 is
> what the ACPI spec calls it. Here we are talking about an GHES notificati=
on.
> =

> But in the arm64 arch code this should be called SError Interrupt as this=
 is
> what the ARM-ARM calls it. This code cares about exception routing and in=
terrupt
> masking.
> =

> =

> But, I don't really care.

Thanks very much James's clear explanation.
I agree with James.

In the ACPI sepc, we usually call SEI as SError Interrupt, we rarely call S=
Error to System Error,
Anyway I will explain clearly about the abbreviations in my next version pa=
tch.


--===============4895128586282049238==--

