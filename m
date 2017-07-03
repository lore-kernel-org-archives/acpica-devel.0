Content-Type: multipart/mixed; boundary="===============6677920908934302153=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: Re: [Devel] [PATCH] coccinelle: api: detect unnecessary le16_to_cpu
Date: Mon, 03 Jul 2017 20:33:53 +0300
Message-ID: <CAHp75VeLV_ySCRN3B=MSoZdyrbXXqqEXrgC+hJCDoLLCJRComQ@mail.gmail.com>
In-Reply-To: 20170703171427.qtpodt7watymphac@earth
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6677920908934302153==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 3, 2017 at 8:14 PM, Sebastian Reichel
<sebastian.reichel(a)collabora.co.uk> wrote:
> Hi,
>
> On Mon, Jul 03, 2017 at 07:37:59PM +0300, Andy Shevchenko wrote:
>> On Mon, Jul 3, 2017 at 4:36 PM, Sebastian Reichel
>> <sebastian.reichel(a)collabora.co.uk> wrote:
>> > On Sat, Jul 01, 2017 at 09:28:10PM +0200, Julia Lawall wrote:
>>
>> >  * drivers/gpio/gpio-pca953x.c (line 190-192)
>>
>> It has double conversion there:
>> 1. LE CPU: Read as LE and converted to LE (no-op), so, just u16
>> 2. BE CPU: Read as BE and converted to LE, makes it __le16
>>
>> Looks like the conversion is not needed, only get_unaligned() is necessa=
ry.
>>
>> P.S. What about lines 244-245 there? I think they are no-op.
>> Interesting that those two parts were added in quite different
>> commits.
>
> val[0] =3D (u16)ret & 0xFF;
> val[1] =3D (u16)ret >> 8;
>
> looks like cpu_to_be16()?

cpu_to_le16(). No-op on LE CPU.

Perhaps they should be replaced by put_unaligned().

-- =

With Best Regards,
Andy Shevchenko

--===============6677920908934302153==--

