Content-Type: multipart/mixed; boundary="===============6000059646565965338=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: fix possible NULL dereference
Date: Mon, 21 Sep 2015 00:59:24 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883406456A@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 20150918060537.GB31139@sudip-pc
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6000059646565965338==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If it is intentional, can we put something like assert(), BUG_ON() there so=
 that the checker can always be coded but not compiled when the binary is r=
eleased?

Thanks
-Lv

> From: Sudip Mukherjee [mailto:sudipm.mukherjee(a)gmail.com]
> Sent: Friday, September 18, 2015 2:06 PM
> =

> On Thu, Sep 10, 2015 at 07:06:02PM +0000, Moore, Robert wrote:
> > One of the things we always have to think about and look at is that oft=
en, things like this are *guaranteed" to be valid simply by
> virtue of the fact that the code has gotten as far as it has.
> >
> > So, rather than litter the code with NULL checks for every single acces=
s, we know up front that the object is valid.
> >
> > This isn't always true and there are some valid situations, but we woul=
d appreciate it if you help track this down.
> I tried but looks like acpi is very tough to understand. The only
> argument I can give in favor of my patch is that in all the places this
> function acpi_ns_get_secondary_object() has been used the return has
> been checked, only the three calls in this file acpi/acpica/dsargs.c
> has not checked the return. Like you said it might be intentional also
> to not check the return only in this file.
> =

> regards
> sudip

--===============6000059646565965338==--

