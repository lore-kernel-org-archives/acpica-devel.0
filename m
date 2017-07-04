Content-Type: multipart/mixed; boundary="===============1582836586515826594=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: Re: [Devel] [PATCH] coccinelle: api: detect unnecessary le16_to_cpu
Date: Tue, 04 Jul 2017 12:51:15 +0300
Message-ID: <CAHp75VdyurjwN+DZQuKnEzNe+XgZwiLLkc0Rg0NvFr=4D2GiQA@mail.gmail.com>
In-Reply-To: alpine.DEB.2.20.1707041104390.3346@hadrien
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1582836586515826594==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 4, 2017 at 12:11 PM, Julia Lawall <julia.lawall(a)lip6.fr> wrot=
e:
> Here is a revised version (not a patch because it doesn't support all of
> the various modes) and the results.  It doesn't return anything beyond
> what was mentioned in previous mails.
>
> For the following code:
>
>         ret =3D i2c_smbus_read_word_data(chip->client, reg << 1);
>         val[0] =3D (u16)ret & 0xFF;
>         val[1] =3D (u16)ret >> 8;
>
> do we want to see:
>
> put_unaligned(val,i2c_smbus_read_word_data(chip->client, reg << 1));

If and only if the type of the pointer is a byte type (u8 *, char *,
or alike) _and_ we try to use it as a provider for 16-bit value (2
bytes).

-- =

With Best Regards,
Andy Shevchenko

--===============1582836586515826594==--

