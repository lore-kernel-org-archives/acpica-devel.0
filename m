Content-Type: multipart/mixed; boundary="===============1144862722495978742=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] Advice for in-kernel acpi patching
Date: Thu, 31 Oct 2013 02:41:06 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E8802479D73@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 52717ABC.6010204@gmx.net
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1144862722495978742==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Stefan Demha=
rter
> Sent: Thursday, October 31, 2013 5:32 AM
> To: devel(a)acpica.org
> Subject: [Devel] Advice for in-kernel acpi patching
> =

> Hi all,
> =

> I have a laptop (acer 3820tg) with muxed intel + radeon graphic cards whi=
ch has the following problem:
> =

> If I use the intel as primary card and switch the radeon card off an on, =
the mux wronlgy changes to the discrete card.
> This is particularily bad if you want to enable dynamic-power-off for the=
 radeon card.
> =

> I identifed the problem to be a specific STORE-call in the method PEGP._O=
N in the table SSDT1.
> I also wrote a module which patches the SSDT1 table on the fly. The funct=
ion which does the real patching is attached.
> =

> As of now I think it's a somewhat hacky solution which should be improved.
> =

> At first I have the following questions:
> - Is there already an easy way to patch acpi methods within the linux ker=
nel?
> - Do you agree that solving such stuff within the kernel is the right way=
 to go?

There are means in the Linux kernel can be used to achieve such kind of nam=
espace patching, please find the documentation at:
Documentation/acpi/dsdt-override
Documentation/initrd_table_override

I think the latter might be able to fit your requirement.

Thanks
-Lv

> =

> Any other advice would be appreciated, too.
> =

> Best Regards,
> Stefan
> =

> PS: I don't think loading a user-patched SSDT1 table at kernel start is t=
he right way to go because:
> - It doesn't work out of the box for new linux installations on the afore=
mentioned laptop.
> - If you change the bios setting for the graphic cards from switchable to=
 intel-only or radeon-only the patched SSDT1 table would be
> wrong.

--===============1144862722495978742==--

