Content-Type: multipart/mixed; boundary="===============2142399120455138986=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: Re: [Devel] [PATCH v11 5/5] pm: Remove to_power_supply impl in ds278*
Date: Mon, 01 Jan 2018 11:56:59 +0200
Message-ID: <CAHp75VczqpO93aYec+dzJCZ1Nkcfi1Vx=7oVc3YBSFf6mkkQPQ@mail.gmail.com>
In-Reply-To: 20171231141757.GA4674@thinkpad
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2142399120455138986==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 31, 2017 at 4:17 PM, Ognjen Galic <smclt30p(a)gmail.com> wrote:
> This patch fixes a issue introduced by patch:
> pm: add to_power_supply macro to the API
>
> In that patch a new macro has been defined in the
> power_supply.h header with the same name as the private
> function name in the ds278* battery modules that does the
> same thing, thus clashing and producing build errors.
>
> This patch removes that private implementation.

Must be folded into patch 2.

-- =

With Best Regards,
Andy Shevchenko

--===============2142399120455138986==--

