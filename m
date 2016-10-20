Content-Type: multipart/mixed; boundary="===============5748145692118190097=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] 4.9-rc1: [TMP_] ACPI namespace lookup failure,
 AE_ALREADY_EXISTS
Date: Thu, 20 Oct 2016 18:44:36 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886A256346@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 1476913001.7633.13.camel@intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5748145692118190097==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

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

The commit in question only modified code to make locks unlocked/locked.
Which should be transparent to the functional stuffs.
I'm not sure how it can lead to such error in the single-threading boot env=
ironment.
Please provide the acpidump output for further investigation.

Thanks and best regards
Lv

--===============5748145692118190097==--

