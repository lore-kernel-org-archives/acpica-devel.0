Content-Type: multipart/mixed; boundary="===============7132387673799002659=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH] ACPI / NUMA: Add stub function for pxm_to_node
Date: Wed, 30 Sep 2020 17:49:33 +0200
Message-ID: <CAJZ5v0hno=F9yuJHRQNix7eiLzP=WtY1rB3xxmmBzLYxW62-tg@mail.gmail.com>
In-Reply-To: a39af625-6e2e-3cb2-ece5-ea2b2dbb7c21@huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7132387673799002659==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2020 at 11:07 AM Hanjun Guo <guohanjun(a)huawei.com> wrote:
>
> On 2020/9/29 3:45, Nathan Chancellor wrote:
> > After commit 01feba590cd6 ("ACPI: Do not create new NUMA domains from
> > ACPI static tables that are not SRAT"):
> >
> > $ scripts/config --file arch/x86/configs/x86_64_defconfig -d NUMA -e AC=
PI_NFIT
> >
> > $ make -skj"$(nproc)" distclean defconfig drivers/acpi/nfit/
> > drivers/acpi/nfit/core.c: In function =E2=80=98acpi_nfit_register_regio=
n=E2=80=99:
> > drivers/acpi/nfit/core.c:3010:27: error: implicit declaration of
> > function =E2=80=98pxm_to_node=E2=80=99; did you mean =E2=80=98xa_to_nod=
e=E2=80=99?
> > [-Werror=3Dimplicit-function-declaration]
> >   3010 |   ndr_desc->target_node =3D pxm_to_node(spa->proximity_domain);
> >        |                           ^~~~~~~~~~~
> >        |                           xa_to_node
> > cc1: some warnings being treated as errors
> > ...
> >
> > Add a stub function like acpi_map_pxm_to_node had so that the build
> > continues to work.
> >
> > Fixes: 01feba590cd6 ("ACPI: Do not create new NUMA domains from ACPI st=
atic tables that are not SRAT")
> > Signed-off-by: Nathan Chancellor <natechancellor(a)gmail.com>
> > ---
> >
> > I am not sure if this is the right place or value for this. It looks
> > like there is going to be another stub function added here, which is
> > going through -mm:
> >
> > https://lkml.kernel.org/r/159643094925.4062302.14979872973043772305.stg=
it(a)dwillia2-desk3.amr.corp.intel.com
> >
> >   include/acpi/acpi_numa.h | 5 +++++
> >   1 file changed, 5 insertions(+)
> >
> > diff --git a/include/acpi/acpi_numa.h b/include/acpi/acpi_numa.h
> > index fdebcfc6c8df..09eb3bc20ff5 100644
> > --- a/include/acpi/acpi_numa.h
> > +++ b/include/acpi/acpi_numa.h
> > @@ -22,5 +22,10 @@ extern int acpi_numa __initdata;
> >   extern void bad_srat(void);
> >   extern int srat_disabled(void);
> >
> > +#else                                /* CONFIG_ACPI_NUMA */
> > +static inline int pxm_to_node(int pxm)
> > +{
> > +     return 0;
> > +}
> >   #endif                              /* CONFIG_ACPI_NUMA */
> >   #endif                              /* __ACP_NUMA_H */
>
> Looks good to me,
>
> Reviewed-by: Hanjun Guo <guohanjun(a)huawei.com>

Patch applied, thanks!
--===============7132387673799002659==--

