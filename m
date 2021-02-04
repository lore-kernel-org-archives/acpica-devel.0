Content-Type: multipart/mixed; boundary="===============1547994686336718591=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH v6 08/16] ACPI / NUMA: add a stub function for
 node_to_pxm()
Date: Thu, 04 Feb 2021 19:45:25 +0100
Message-ID: <CAJZ5v0gJD1B92FsSo9xMrdFWYEh5DHqAQQ4TiFbHV=a2XpBEbg@mail.gmail.com>
In-Reply-To: 20210204183841.y4fgwjuggtbrnere@liuwe-devbox-debian-v2
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1547994686336718591==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 4, 2021 at 7:41 PM Wei Liu <wei.liu(a)kernel.org> wrote:
>
> On Wed, Feb 03, 2021 at 03:04:27PM +0000, Wei Liu wrote:
> > There is already a stub function for pxm_to_node but conversion to the
> > other direction is missing.
> >
> > It will be used by Microsoft Hypervisor code later.
> >
> > Signed-off-by: Wei Liu <wei.liu(a)kernel.org>
>
> Hi ACPI maintainers, if you're happy with this patch I can take it via
> the hyperv-next tree, given the issue is discovered when pxm_to_node is
> called in our code.

Yes, you can.

Thanks!

>
> > ---
> > v6: new
> > ---
> >  include/acpi/acpi_numa.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/include/acpi/acpi_numa.h b/include/acpi/acpi_numa.h
> > index a4c6ef809e27..40a91ce87e04 100644
> > --- a/include/acpi/acpi_numa.h
> > +++ b/include/acpi/acpi_numa.h
> > @@ -30,6 +30,10 @@ static inline int pxm_to_node(int pxm)
> >  {
> >       return 0;
> >  }
> > +static inline int node_to_pxm(int node)
> > +{
> > +     return 0;
> > +}
> >  #endif                               /* CONFIG_ACPI_NUMA */
> >
> >  #ifdef CONFIG_ACPI_HMAT
> > --
> > 2.20.1
> >
--===============1547994686336718591==--

