Content-Type: multipart/mixed; boundary="===============1811230864789205547=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: [Devel] Re: [PATCH v1 1/1] ACPI: utils: Document
 for_each_acpi_dev_match() macro
Date: Mon, 12 Apr 2021 20:50:28 +0300
Message-ID: <CAHp75Vc3e4FcqKMn3YGGK+sNXLi5UqUL75_GcF-27hyn+iZp9Q@mail.gmail.com>
In-Reply-To: CAJZ5v0jJoWnnx7ce82trnzsnBTMEDf1oXwFBDc0RUj-=p7hjLQ@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1811230864789205547==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 12, 2021 at 8:27 PM Rafael J. Wysocki <rafael(a)kernel.org> wro=
te:
>
> On Sat, Apr 10, 2021 at 3:29 PM Andy Shevchenko
> <andy.shevchenko(a)gmail.com> wrote:
> >
> > The macro requires to call acpi_dev_put() on each iteration.
> > Due to this it doesn't tolerate sudden disappearence of the devices.

And should be "disappearance" :-)

> >
> > Document all these nuances to prevent users blindly call it without
> > understanding the possible issues.
> >
> > While at it, add the note to the acpi_dev_get_next_match_dev() and
> > advertise acpi_dev_put() instead of put_device() in the whole family
> > of the helper functions.

Thanks for reviewing this, I'll address all in v2.

-- =

With Best Regards,
Andy Shevchenko
--===============1811230864789205547==--

