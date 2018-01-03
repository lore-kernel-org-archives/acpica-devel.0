Content-Type: multipart/mixed; boundary="===============4148572710815628519=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: Re: [Devel] [PATCH v12 3/4] thinkpad_acpi: Add support for battery
 thresholds
Date: Wed, 03 Jan 2018 16:42:35 +0200
Message-ID: <CAHp75Vdqz=VMcdaa04fVywFeHs+C6_a7ux0M1XE1=Q9TTpWOvA@mail.gmail.com>
In-Reply-To: 20180103115922.GA10135@thinkpad
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4148572710815628519==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2018 at 1:59 PM, Ognjen Galic <smclt30p(a)gmail.com> wrote:
> thinkpad_acpi registers two new attributes for each battery:
>
> 1) Charge start threshold
> /sys/class/power_supply/BATN/charge_start_threshold
>
> Valid values are [0, 99]. A value of 0 turns off the
> start threshold wear control.
>
> 2) Charge stop threshold
> /sys/class/power_supply/BATN/charge_stop_threshold
>
> Valid values are [1, 100]. A value of 100 turns off
> the stop threshold wear control. This must be
> configured first.
>
> Signed-off-by: Ognjen Galic <smclt30p(a)gmail.com>

Thanks for an update!

> ---
>
> Notes:

>     * Change int to acpi_status in tpacpi_battery_acpi_eval

Then you need to check return code with ACPI_FAILURE() or ACPI_SUCCESS() ma=
cros.
That is one of the additional burden while I can't see usefulness of
ACPI return codes in that function and why I suggested to use plain
int.

One more question: why don't you use dev_err()/dev_*() macros instead
of pr_*() ones?
(Note, it's a question, needs a bit of discussion, I would like to
hear a rationale of this, I think it might be one)

-- =

With Best Regards,
Andy Shevchenko

--===============4148572710815628519==--

