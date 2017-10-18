Content-Type: multipart/mixed; boundary="===============3722702811834468335=="
MIME-Version: 1.0
From: James Morse <james.morse at arm.com>
Subject: Re: [Devel] [PATCH v5 2/2] acpi: apei: Add SEI notification type
 support for ARMv8
Date: Wed, 18 Oct 2017 10:44:48 +0100
Message-ID: <59E72290.6060604@arm.com>
In-Reply-To: 20171018092547.guf54e6aqbzzfxrq@pd.tnic
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3722702811834468335==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Borislav!

On 18/10/17 10:25, Borislav Petkov wrote:
> On Wed, Oct 18, 2017 at 05:17:27PM +0800, gengdongjiu wrote:
>> Thanks Borislav, can I write it as asynchronous exception or
>> asynchronous abort?
> =

> WTF?!

Yup.


> The thing is abbreviated as "SEI" and apparently means "System Error
> Interrupt". Nothing else.

ARM has 'external abort', which are either synchronous or asynchronous, bot=
h are
delivered as different types of exception.

Asynchronous external abort is treated as a special kind of interrupt, 'SEr=
ror
Interrupt', (where SError stands for System Error, but its rarely written l=
ike
that). 'SEI' is a relatively new abbreviation for SError interrupt.


What should we call this thing? In the ACPI code I'd prefer 'SEI' as that is
what the ACPI spec calls it. Here we are talking about an GHES notification.

But in the arm64 arch code this should be called SError Interrupt as this is
what the ARM-ARM calls it. This code cares about exception routing and inte=
rrupt
masking.


But, I don't really care.


Thanks,

James

--===============3722702811834468335==--

