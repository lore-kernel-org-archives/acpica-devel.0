Content-Type: multipart/mixed; boundary="===============5670522055157416741=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] Re: [PATCH] ACPICA: Fix a typo in acuuid.h
Date: Fri, 14 Feb 2020 20:21:48 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B96EA166@ORSMSX110.amr.corp.intel.com>
In-Reply-To: BL0PR11MB29466C25466F5A88B4D4F5B9F0150@BL0PR11MB2946.namprd11.prod.outlook.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5670522055157416741==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Ok, got it.
Thanks,
Bob
-

-----Original Message-----
From: Kaneda, Erik <erik.kaneda(a)intel.com> =

Sent: Friday, February 14, 2020 9:08 AM
To: Rafael J. Wysocki <rjw(a)rjwysocki.net>; Christophe JAILLET <christophe=
.jaillet(a)wanadoo.fr>
Cc: lenb(a)kernel.org; Moore, Robert <robert.moore(a)intel.com>; linux-acpi=
(a)vger.kernel.org; devel(a)acpica.org; linux-kernel(a)vger.kernel.org; ker=
nel-janitors(a)vger.kernel.org
Subject: RE: [PATCH] ACPICA: Fix a typo in acuuid.h



> -----Original Message-----
> From: linux-acpi-owner(a)vger.kernel.org <linux-acpi- =

> owner(a)vger.kernel.org> On Behalf Of Rafael J. Wysocki
> Sent: Friday, February 14, 2020 2:02 AM
> To: Christophe JAILLET <christophe.jaillet(a)wanadoo.fr>; Kaneda, Erik =

> <erik.kaneda(a)intel.com>
> Cc: lenb(a)kernel.org; Moore, Robert <robert.moore(a)intel.com>; linux- =

> acpi(a)vger.kernel.org; devel(a)acpica.org; linux-kernel(a)vger.kernel.or=
g; =

> kernel-janitors(a)vger.kernel.org
> Subject: Re: [PATCH] ACPICA: Fix a typo in acuuid.h
> =

> On Friday, February 14, 2020 7:30:03 AM CET Christophe JAILLET wrote:
> > The comment related to the ending of the include guard should be =

> > related to __ACUUID_H__, not __AUUID_H__ (i.e. 'C' is missing).
> >
> > Signed-off-by: Christophe JAILLET <christophe.jaillet(a)wanadoo.fr>
> =

> Erik, please route this through the upstream.

Thanks for your patch!

I'll add it to our next release (in March)

Erik
> =

> Thanks!
> =

> > ---
> >  include/acpi/acuuid.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/acpi/acuuid.h b/include/acpi/acuuid.h index
> > 9dd4689a39cf..9e1367b19069 100644
> > --- a/include/acpi/acuuid.h
> > +++ b/include/acpi/acuuid.h
> > @@ -57,4 +57,4 @@
> >  #define UUID_THERMAL_EXTENSIONS         "14d399cd-7a27-4b18-8fb4-
> 7cb7b9f4e500"
> >  #define UUID_DEVICE_PROPERTIES          "daffd814-6eba-4d8c-8a91-
> bc9bbf4aa301"
> >
> > -#endif/* __AUUID_H__ */
> > +#endif/* __ACUUID_H__ */
> >
> =

> =

> =



--===============5670522055157416741==--

