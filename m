Content-Type: multipart/mixed; boundary="===============0857047593822477941=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH 1/4] ACPI: Provide support for ACPI table
 adding	via OS
Date: Fri, 21 Feb 2014 07:28:02 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88024B23DE@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 1568883.1dLS7uNIC1@skinner
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0857047593822477941==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, Thomas

> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Thomas Renni=
nger
> Sent: Wednesday, February 19, 2014 2:44 AM
> =

> On Tuesday, February 18, 2014 10:27:23 AM H. Peter Anvin wrote:
> > Why can't you add SSDTs? It would be particularly useful.
> =

> There are 2 ways how ACPI tables get added:
>    - Via pointer from a root table (XSDT or RSDT iirc)
>    - Via load statement inside of ACPI context when ACPI BIOS
>      code gets executed (iirc the physical address is passed).
> =

> The latter is only for SSDTs.
> The problem is that you if you add an SSDT early, it might
> have been intended for overriding when an SSDT gets dynamically
> loaded later when the system is up which is particular useful as
> well if you want to debug this specific BIOS table.
> =

> This could be workarounded via a boot param:
> acpi=3Dallow_ssdt_adding
> But this is not nice. Maybe someone has a more elegant idea.
> Something could still be added if someone is really needing this.

I'm not sure if you are talking about the issue that:
If a system booted using customized DSDT embedded with SSDT, it also requir=
es dynamic SSDT loading be prevented in ACPICA.

Thanks and best regards
-Lv


> =

>      Thomas
> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> https://lists.acpica.org/mailman/listinfo/devel

--===============0857047593822477941==--

