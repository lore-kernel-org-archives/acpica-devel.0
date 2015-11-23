Content-Type: multipart/mixed; boundary="===============5033587148606132889=="
MIME-Version: 1.0
From: Lukas Wunner <lukas at wunner.de>
Subject: Re: [Devel] [PATCH 2/5] eeepc-wmi: Use acpi_dev_present
Date: Mon, 23 Nov 2015 20:55:27 +0100
Message-ID: <20151123195527.GA26288@wunner.de>
In-Reply-To: 20151123190413.GU7413@malice.jf.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5033587148606132889==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Darren,

On Mon, Nov 23, 2015 at 11:04:13AM -0800, Darren Hart wrote:
> On Mon, Nov 23, 2015 at 03:34:55PM +0100, Lukas Wunner wrote:
> > Use shiny new acpi_dev_present and remove all the boilerplate to search
> > for a particular ACPI device. No functional change.
> =

> You did add a pr_warn, which is technically a functional change. Did you =
intend
> to leave that in?

That's not an addition of mine, I moved it from eeepc_wmi_parse_device()
to eeepc_wmi_probe() so that everything behaves exactly as before.
(See the deleted lines further up in the patch.)


> Rafael, I assume you will pick this up along with the acpi_dev_present AC=
PI
> change if you take that. Pleaes let me know if not.

The last patch in the series concerned Intel ASoC (sound/soc/intel/)
and the maintainer Mark Brown <broonie(a)kernel.org> has replied that
"This will collide with some other work done on the Intel code in -next I
expect, probably best to merge this via ASoC (so pulling a shared branch
for the new API) or just wait till 4.5 to do the conversion."
[full quote of his message as it wasn't cc: platform-driver-x86]

So I guess Mark might pull it in, haven't heard back from the ACPI
maintainers yet.


> Otherwise,
> Acked-by: Darren Hart <dvhart(a)linux.intel.com>

Awesome, thanks!

Best regards,

Lukas

--===============5033587148606132889==--

