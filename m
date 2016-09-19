Content-Type: multipart/mixed; boundary="===============7402500642158200956=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA / Interpreter: Remove redundant newline
Date: Mon, 19 Sep 2016 09:30:44 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886A2223F1@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 20160914113031.GA7387@nazgul.tnic
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7402500642158200956==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> From: linux-acpi-owner(a)vger.kernel.org [mailto:linux-acpi-owner(a)vger.=
kernel.org] On Behalf Of Borislav
> Petkov
> Subject: Re: [PATCH] ACPICA / Interpreter: Remove redundant newline
> =

> On Wed, Sep 14, 2016 at 03:09:25AM +0000, Zheng, Lv wrote:
> > The newline is intentional for acpiexec.
> > So you should fix this issue in acpiexec, aka, in ACPICA upstream.
> =

> If you elaborate as to from where I get the sources and against which
> branch/version/...?, I can try to send you a patch.

You can obtain a local copy of acpica.git via:
$ git clone https://github.com/acpica/acpica

The fix patch should only be sent to devel(a)acpica.org.
And you'll see it in Linux upstream after an acpica release cycle.

Regards
Lv

> =

> --
> Regards/Gruss,
>     Boris.
> =

> ECO tip #101: Trim your mails when you reply.
> --
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo(a)vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--===============7402500642158200956==--

