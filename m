Content-Type: multipart/mixed; boundary="===============4317996973143062701=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: Re: [Devel] [PATCH v11 2/5] pm: add to_power_supply macro to the API
Date: Mon, 01 Jan 2018 11:56:17 +0200
Message-ID: <CAHp75VeBLaes42NN1L4ujfvkYAUOW9h9Q26mfsj7e7a86OC_Yg@mail.gmail.com>
In-Reply-To: 20171231141700.GA4612@thinkpad
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4317996973143062701==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 31, 2017 at 4:17 PM, Ognjen Galic <smclt30p(a)gmail.com> wrote:
> This patch adds the to_power_supply macro to upcast
> a device to a power_supply struct.
>
> This is needed because the same piece of code using
> container_of is used in various other places, so we
> abstract away such low-level operations via a macro.

The patch 5 must be folded into this one. I told you that.
Otherwise you will leave bisectability issue.

> Suggested-by: Andy Shevchenko <andriy.shevchenko(a)linux.intel.com>
> Signed-off-by: Ognjen Galic <smclt30p(a)gmail.com>
>

> v9:
> * Split the pm changes from the thinkpad_acpi patch
> into its own patch
>
> v10:
> * No changes in this patch in v10
>
> v11:
> * Fix changelog formatting

Changelog should go *after* --- line...

> ---

...to here.

>  drivers/power/supply/power_supply_core.c | 2 +-
>  include/linux/power_supply.h             | 2 ++

-- =

With Best Regards,
Andy Shevchenko

--===============4317996973143062701==--

