Content-Type: multipart/mixed; boundary="===============6614475301291898009=="
MIME-Version: 1.0
From: Zhang, Rui <rui.zhang at intel.com>
Subject: Re: [Devel] Advice for in-kernel acpi patching
Date: Thu, 31 Oct 2013 12:31:33 +0000
Message-ID: <744357E9AAD1214791ACBA4B0B9092630119918D@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 1AE640813FDE7649BE1B193DEA596E8802479D73@SHSMSX101.ccr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6614475301291898009==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Zheng, Lv
> Sent: Thursday, October 31, 2013 10:41 AM
> To: Stefan Demharter; devel(a)acpica.org
> Subject: Re: [Devel] Advice for in-kernel acpi patching
> =

> > From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Stefan
> > Demharter
> > Sent: Thursday, October 31, 2013 5:32 AM
> > To: devel(a)acpica.org
> > Subject: [Devel] Advice for in-kernel acpi patching
> >
> > Hi all,
> >
> > I have a laptop (acer 3820tg) with muxed intel + radeon graphic cards
> which has the following problem:
> >
> > If I use the intel as primary card and switch the radeon card off an
> on, the mux wronlgy changes to the discrete card.
> > This is particularily bad if you want to enable dynamic-power-off for
> the radeon card.
> >
> > I identifed the problem to be a specific STORE-call in the method
> PEGP._ON in the table SSDT1.
> > I also wrote a module which patches the SSDT1 table on the fly. The
> function which does the real patching is attached.
> >
> > As of now I think it's a somewhat hacky solution which should be
> improved.
> >
> > At first I have the following questions:
> > - Is there already an easy way to patch acpi methods within the linux
> kernel?
> > - Do you agree that solving such stuff within the kernel is the right
> way to go?
> =

> There are means in the Linux kernel can be used to achieve such kind of
> namespace patching, please find the documentation at:
> Documentation/acpi/dsdt-override
> Documentation/initrd_table_override

Plus, Documentation/acpi/method_customizing.txt introduces a way to overrid=
e a control method at runtime, without rebuilding the kernel, please check =
if it helps.

Thanks,
rui
> =

> I think the latter might be able to fit your requirement.
> =

> Thanks
> -Lv
> =

> >
> > Any other advice would be appreciated, too.
> >
> > Best Regards,
> > Stefan
> >
> > PS: I don't think loading a user-patched SSDT1 table at kernel start
> is the right way to go because:
> > - It doesn't work out of the box for new linux installations on the
> aforementioned laptop.
> > - If you change the bios setting for the graphic cards from
> switchable
> > to intel-only or radeon-only the patched SSDT1 table would be wrong.
> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> https://lists.acpica.org/mailman/listinfo/devel

--===============6614475301291898009==--

