Content-Type: multipart/mixed; boundary="===============2527038105395166889=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH] ACPICA: Fix a typo
Date: Tue, 30 Mar 2021 14:05:23 +0200
Message-ID: <CAJZ5v0gf4i+HLPYzETCiG740FCXBHe5hf2PeCfCiqVJODhaMyg@mail.gmail.com>
In-Reply-To: MWHPR11MB15993DB0504FBD17DB4B1792F07D9@MWHPR11MB1599.namprd11.prod.outlook.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2527038105395166889==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 30, 2021 at 2:19 AM Kaneda, Erik <erik.kaneda(a)intel.com> wrot=
e:
>
>
>
> > -----Original Message-----
> > From: Rafael J. Wysocki <rafael(a)kernel.org>
> > Sent: Monday, March 29, 2021 5:48 AM
> > To: Bhaskar Chowdhury <unixbhaskar(a)gmail.com>; Kaneda, Erik
> > <erik.kaneda(a)intel.com>
> > Cc: Wysocki, Rafael J <rafael.j.wysocki(a)intel.com>; ACPI Devel Maling=
 List
> > <linux-acpi(a)vger.kernel.org>; open list:ACPI COMPONENT ARCHITECTURE
> > (ACPICA) <devel(a)acpica.org>; Linux Kernel Mailing List <linux-
> > kernel(a)vger.kernel.org>; Randy Dunlap <rdunlap(a)infradead.org>
> > Subject: [Devel] Re: [PATCH] ACPICA: Fix a typo
> >
> > On Fri, Mar 26, 2021 at 1:22 AM Bhaskar Chowdhury
> > <unixbhaskar(a)gmail.com> wrote:
> > >
> > >
> > > s/optimzation/optimization/
> > >
> > > Signed-off-by: Bhaskar Chowdhury <unixbhaskar(a)gmail.com>
> > > ---
> > >  include/acpi/acoutput.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h
> > > index 1538a6853822..1b4c45815695 100644
> > > --- a/include/acpi/acoutput.h
> > > +++ b/include/acpi/acoutput.h
> > > @@ -362,7 +362,7 @@
> > >   *
> > >   * A less-safe version of the macros is provided for optional use if=
 the
> > >   * compiler uses excessive CPU stack (for example, this may happen i=
n the
> > > - * debug case if code optimzation is disabled.)
> > > + * debug case if code optimization is disabled.)
> > >   */
> > >
> > >  /* Exit trace helper macro */
> > > --
> >
> > Erik, could you pick up this patch, please?  It is simple enough IMV ...
>
> No problem, I'll pick it up

Thanks!
--===============2527038105395166889==--

