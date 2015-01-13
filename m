Content-Type: multipart/mixed; boundary="===============1746547603448520987=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH] acpi: acpica: utstate:  Remove unused function
Date: Tue, 13 Jan 2015 02:33:54 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88026AC9F1@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 3056635.sprz8UnhD7@vostro.rjw.lan
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1746547603448520987==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I've added this patch into the 201501 ACPICA materials for review:
https://github.com/acpica/acpica/pull/61
If it is merged, it will appear in Linux kernel after 201501 ACPICA release.
Thanks for reporting.

Best regards
-Lv

> From: Rafael J. Wysocki [mailto:rjw(a)rjwysocki.net]
> Sent: Tuesday, January 06, 2015 7:30 AM
> =

> On Monday, January 05, 2015 08:39:37 AM Zheng, Lv wrote:
> > Hi, Richard
> >
> > > From: Rickard Strandqvist [mailto:rickard_strandqvist(a)spectrumdigit=
al.se]
> > > Sent: Saturday, January 03, 2015 5:01 AM
> > >
> > > Remove the function acpi_ut_create_pkg_state_and_push() that is not u=
sed anywhere.
> > >
> > > This was partially found by using a static code analysis program call=
ed cppcheck.
> >
> > acpi_ut_create_pkg_state_and_push() is not even used in ACPICA.
> > We can remove it now.
> =

> Let's first remove it in upstream ACPICA, then, I suppose.
> =

> =

> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.

--===============1746547603448520987==--

