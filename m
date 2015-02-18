Content-Type: multipart/mixed; boundary="===============1969237202402089685=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH 0/4] int to bool conversion
Date: Wed, 18 Feb 2015 19:09:31 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D27FE3F@ORSMSX112.amr.corp.intel.com>
In-Reply-To: 2189735.DtT3OIbRBT@vostro.rjw.lan
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1969237202402089685==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

"bool" can be problematic as it isn't totally portable. It is usually imple=
mented as a macro.

That=E2=80=99s why ACPICA doesn't use it.


> -----Original Message-----
> From: Rafael J. Wysocki [mailto:rjw(a)rjwysocki.net]
> Sent: Monday, January 26, 2015 5:33 AM
> To: Quentin Lambert
> Cc: Zhang, Rui; Moore, Robert; Zheng, Lv; Wysocki, Rafael J; Len Brown;
> Shaohua Li; linux-acpi(a)vger.kernel.org; devel(a)acpica.org; linux-
> kernel(a)vger.kernel.org
> Subject: Re: [PATCH 0/4] int to bool conversion
> =

> On Monday, January 26, 2015 09:30:55 AM Quentin Lambert wrote:
> > Sorry for the delay in answering ....
> >
> > On 22/01/2015 17:18, Rafael J. Wysocki wrote:
> > > On Thursday, January 22, 2015 09:49:41 AM Quentin Lambert wrote:
> > >> These patches convert local variables from int to bool when relevant.
> > > And what exactly is the need for that?  Does that fix any functional
> problems?
> > >
> > >
> > It doesn't fix any functional problem. The point of this patch is to
> > increase the code readability by lifting some of the ambiguities that
> > appear when using an integer variable as boolean.
> >
> > My understanding is that by explicitly using a boolean declaration
> > when it is relevant it clearly informs the reader that the variable is
> > going to represent a binary state. Moreover, using the keywords true
> > and false help indicate that the variable will not be involved in any
> > computation other than boolean arithmetic.
> =

> Well, in the new code, yes.  The existing code is a different matter
> though and it doesn't actually hurt if you leave the ints where they are,
> so there's no reason to make those changes.
> =

> If you change old code and the change is not trivial (eg. fixes of white
> space or comments, or kernel messages etc.) and someone enounters a bug
> that may be related to it, they will have to go through your changes to
> see if that's not the source of the bug.  That's not really productive.
> =

> =

> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.

--===============1969237202402089685==--

