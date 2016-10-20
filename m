Content-Type: multipart/mixed; boundary="===============8548007395647766387=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] 4.9-rc1: [TMP_] ACPI namespace lookup failure,
 AE_ALREADY_EXISTS
Date: Thu, 20 Oct 2016 16:45:23 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886A2561D7@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 1476913001.7633.13.camel@intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8548007395647766387==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, Imre

> From: Deak, Imre
> Subject: 4.9-rc1: [TMP_] ACPI namespace lookup failure, AE_ALREADY_EXISTS
> =

> Hi,
> =

> after upgrading to 4.9-rc1 I get the following errors occasionally
> during boot and suspend-to-ram on an APL system:
> =

> [=C2=A0=C2=A0=C2=A059.513434] ACPI Error: [TMP_] Namespace lookup failure=
, AE_ALREADY_EXISTS (20160831/dswload2-330)
> [=C2=A0=C2=A0=C2=A059.513446] ACPI Exception: AE_ALREADY_EXISTS, During n=
ame lookup/catalog (20160831/psobject-227)
> [=C2=A0=C2=A0=C2=A059.513469] ACPI Error: Method parse/execution failed [=
\_SB.PCI0.SCPG] (Node=C2=A0ffff8802770b7bb8),
> AE_ALREADY_EXISTS (20160831/psparse-543)
> [=C2=A0=C2=A0=C2=A059.515415] ACPI Error: Method parse/execution failed [=
\_SB.PCI0.SDHA._PS3] (Node ffff8802770b7dc0),
> AE_ALREADY_EXISTS (20160831/psparse-543)
> [=C2=A0=C2=A0=C2=A059.517118] ACPI: Marking method _PS3 as Serialized bec=
ause of AE_ALREADY_EXISTS error

Could you send me acpidump output?

> =

> Other than these error messages, booting and suspend/resume seems to work=
 ok.
> Bisecting points to
> commit 74f51b80a0c4ff84fbeb7f12ea43ce66934d29aa
> Author: Lv Zheng <lv.zheng(a)intel.com>
> Date:=C2=A0=C2=A0=C2=A0Wed Sep 7 14:07:10 2016 +0800
> =

> =C2=A0=C2=A0=C2=A0=C2=A0ACPICA: Namespace: Fix dynamic table loading issu=
es
> =

> Reverting this on top of 4.9-rc1 gets rid of the error messages.

This fix is essential.
Without this, all of other ACPICA fixes can easily fall into dead locks.
So we won't simply revert it just because of non-functional-failure error m=
essages.
Instead, we will improve it.

Thanks and best regards
Lv

--===============8548007395647766387==--

