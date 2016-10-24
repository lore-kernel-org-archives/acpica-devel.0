Content-Type: multipart/mixed; boundary="===============5612735230594817803=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] 4.9-rc1: [TMP_] ACPI namespace lookup failure,
 AE_ALREADY_EXISTS
Date: Mon, 24 Oct 2016 06:10:43 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886A257836@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 1477216090.7258.9.camel@intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5612735230594817803==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, Imre

> From: Deak, Imre
> Subject: Re: 4.9-rc1: [TMP_] ACPI namespace lookup failure, AE_ALREADY_EX=
ISTS
> =

> On Fri, 2016-10-21 at 22:46 +0300, Zheng, Lv wrote:
> >=C2=A0[...]
> > I checked the code, only found one issue.
> > And I'm not sure if it is related.
> > Please send me the full dmesg containing the errors and the acpidump
> > output.
> =

> I attached the dmesg containing the error during boot (happened 1 out
> of 200 boots), during reboot (20 out of 200 reboots), during suspend
> (happened all the time).
> =

> I attached the acpidump output.

Thanks for the information.

> =

> > Please give the fix a try (see attachment).
> =

> The patch didn't apply on 4.9-rc1 or Linus' master, please see the
> attached patch for my attempt to resolve the conflicts. With the patch
> applied I could still trigger the same problem during suspend.

Could you pull this branch directly and try again:
https://github.com/zetalog/linux
Branch: acpica-lock

I've pushed the fix commit there.

Thanks in advance.

Best regards
Lv

> =

> --Imre
> =

> > I'm sorry for sending fix patch using attachment.
> > It's not convenient for me due to my current working environment.
> >
> > Thanks and best regards
> > Lv

--===============5612735230594817803==--

