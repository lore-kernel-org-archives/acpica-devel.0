Content-Type: multipart/mixed; boundary="===============5319742224807554689=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH] include: acpi: A typo fix in the file cppc_acpi.h
Date: Fri, 19 Mar 2021 17:33:28 +0100
Message-ID: <CAJZ5v0j8x2FF6rEuZFUaokzPigPpxD6u0Cu2JK7Au3mj5d=93w@mail.gmail.com>
In-Reply-To: 859a36ad-f9c6-942d-770e-e9e0306d34e4@infradead.org
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5319742224807554689==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 17, 2021 at 6:17 AM Randy Dunlap <rdunlap(a)infradead.org> wrot=
e:
>
> On 3/16/21 10:06 PM, Bhaskar Chowdhury wrote:
> >
> > s/folowing/following/
> >
> > Signed-off-by: Bhaskar Chowdhury <unixbhaskar(a)gmail.com>
>
> Acked-by: Randy Dunlap <rdunlap(a)infradead.org>
>
> > ---
> >  include/acpi/cppc_acpi.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> > index c7fc4524e151..d174721bab33 100644
> > --- a/include/acpi/cppc_acpi.h
> > +++ b/include/acpi/cppc_acpi.h
> > @@ -31,7 +31,7 @@
> >  #define      CMD_READ 0
> >  #define      CMD_WRITE 1
> >
> > -/* Each register has the folowing format. */
> > +/* Each register has the following format. */
> >  struct cpc_reg {
> >       u8 descriptor;
> >       u16 length;
> > --

Applied as 5.13 material with a minor edit in the subject, thanks!
--===============5319742224807554689==--

