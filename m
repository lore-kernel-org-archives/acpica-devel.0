Content-Type: multipart/mixed; boundary="===============1064414855079341931=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] AcpiXtract: fix warning on int printed with %u
 specifier
Date: Thu, 02 Jul 2015 15:39:27 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D30976E@ORSMSX112.amr.corp.intel.com>
In-Reply-To: 55955145.4000507@canonical.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1064414855079341931==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Sorry. Sometimes I'm not real good about this.


> -----Original Message-----
> From: Colin Ian King [mailto:colin.king(a)canonical.com]
> Sent: Thursday, July 02, 2015 7:57 AM
> To: Moore, Robert; devel(a)acpica.org
> Subject: Re: [Devel] [PATCH] AcpiXtract: fix warning on int printed with
> %u specifier
> =

> On 02/07/15 14:23, Moore, Robert wrote:
> > Got it, thanks.
> >
> Thanks for applying it. However, the patch landed with the following
> commit message:
> =

> commit 03f9b1938b163cc09306b3ba17c4bb701abf079d
> Author: Robert Moore <Robert.Moore(a)intel.com>
> Date:   Thu Jul 2 06:22:18 2015 -0700
> =

>     acpixtract: Replace an "int" with "unsigned int"
> =

>     The variable is used with %u printf, causing a warning via a
>     static analysis tool. Reported by Colin Ian King.
> =

> This is a misrepresentation. I fixed it. Not just reported it. I know it
> is a minor thing, but re-working the commit message in such a disingenuous
> way as to take credit away from authors makes me want to no longer
> contribute to ACPICA.  This has not been the first time credit on fixes
> has been misrepresented "by accident" by re-working the commit messages.
> =

> =

> >
> >> -----Original Message-----
> >> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Colin King
> >> Sent: Wednesday, July 01, 2015 12:02 AM
> >> To: devel(a)acpica.org
> >> Subject: [Devel] [PATCH] AcpiXtract: fix warning on int printed with
> >> %u specifier
> >>
> >> From: Colin Ian King <colin.king(a)canonical.com>
> >>
> >> A signed integer is being printed using %u.  Since the integer is
> >> never going to be negative, make it unsigned and this also cleans up
> >> the warning found by static analysis:
> >>
> >> [source/tools/acpixtract/acpixtract.c:819]: (warning) %u in
> >>   format string (no. 1) requires 'unsigned int' but the argument
> >>   type is 'int'.
> >>
> >> Signed-off-by: Colin Ian King <colin.king(a)canonical.com>
> >> ---
> >>  source/tools/acpixtract/acpixtract.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/source/tools/acpixtract/acpixtract.c
> >> b/source/tools/acpixtract/acpixtract.c
> >> index fa2cb5a..7e961ff 100644
> >> --- a/source/tools/acpixtract/acpixtract.c
> >> +++ b/source/tools/acpixtract/acpixtract.c
> >> @@ -738,7 +738,7 @@ AxListTables (
> >>      FILE                    *InputFile;
> >>      size_t                  HeaderSize;
> >>      unsigned char           Header[48];
> >> -    int                     TableCount =3D 0;
> >> +    unsigned int            TableCount =3D 0;
> >>      ACPI_TABLE_HEADER       *TableHeader =3D (ACPI_TABLE_HEADER *) (v=
oid
> *)
> >> Header;
> >>
> >>
> >> --
> >> 2.1.4
> >>
> >> _______________________________________________
> >> Devel mailing list
> >> Devel(a)acpica.org
> >> https://lists.acpica.org/mailman/listinfo/devel


--===============1064414855079341931==--

