Content-Type: multipart/mixed; boundary="===============1828367566066931149=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] 4.9-rc1: [TMP_] ACPI namespace lookup failure,
 AE_ALREADY_EXISTS
Date: Thu, 20 Oct 2016 23:05:25 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886A25657B@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: CAJZ5v0jMtzSg8JCLQDzYRK5xtdWOJTUKktHKjhAw1o0nRG2Thw@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1828367566066931149==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, Rafael

> From: rjwysocki(a)gmail.com [mailto:rjwysocki(a)gmail.com] On Behalf Of R=
afael J. Wysocki
> Subject: Re: 4.9-rc1: [TMP_] ACPI namespace lookup failure, AE_ALREADY_EX=
ISTS
> =

> On Thu, Oct 20, 2016 at 8:44 PM, Zheng, Lv <lv.zheng(a)intel.com> wrote:
> > Hi,
> >
> >> From: Deak, Imre
> >> Subject: 4.9-rc1: [TMP_] ACPI namespace lookup failure, AE_ALREADY_EXI=
STS
> >>
> >> Hi,
> >>
> >> after upgrading to 4.9-rc1 I get the following errors occasionally
> >> during boot and suspend-to-ram on an APL system:
> >>
> >> [   59.513434] ACPI Error: [TMP_] Namespace lookup failure, AE_ALREADY=
_EXISTS (20160831/dswload2-
> 330)
> >> [   59.513446] ACPI Exception: AE_ALREADY_EXISTS, During name lookup/c=
atalog (20160831/psobject-227)
> >> [   59.513469] ACPI Error: Method parse/execution failed [\_SB.PCI0.SC=
PG] (Node ffff8802770b7bb8),
> >> AE_ALREADY_EXISTS (20160831/psparse-543)
> >> [   59.515415] ACPI Error: Method parse/execution failed [\_SB.PCI0.SD=
HA._PS3] (Node
> ffff8802770b7dc0),
> >> AE_ALREADY_EXISTS (20160831/psparse-543)
> >> [   59.517118] ACPI: Marking method _PS3 as Serialized because of AE_A=
LREADY_EXISTS error
> >>
> >> Other than these error messages, booting and suspend/resume seems to w=
ork ok.
> >> Bisecting points to
> >> commit 74f51b80a0c4ff84fbeb7f12ea43ce66934d29aa
> >> Author: Lv Zheng <lv.zheng(a)intel.com>
> >> Date:   Wed Sep 7 14:07:10 2016 +0800
> >>
> >>     ACPICA: Namespace: Fix dynamic table loading issues
> >>
> >> Reverting this on top of 4.9-rc1 gets rid of the error messages.
> >
> > The commit in question only modified code to make locks unlocked/locked.
> > Which should be transparent to the functional stuffs.
> =

> It might change the relative timing of thigs (which might result in
> ordering changes).

Yes, I'll check that with the acpidump.
To see if this is caused by wrong reduced lock affection scope.

> =

> > I'm not sure how it can lead to such error in the single-threading boot=
 environment.
> =

> Why do you think it's single-threaded?  At least suspend/resume isn't
> in general.

I just say that because it is also reported as "occasionally during boot".

Thanks and best regards
Lv

--===============1828367566066931149==--

