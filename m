Content-Type: multipart/mixed; boundary="===============4778704335491415932=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: arm64: fix compile apci tools fail for
 arm64
Date: Thu, 20 Oct 2016 18:42:05 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886A256324@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: c88b5433-fbf0-1a15-11b2-b47c1872d48d@huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4778704335491415932==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> From: linux-acpi-owner(a)vger.kernel.org [mailto:linux-acpi-owner(a)vger.=
kernel.org] On Behalf Of Yisheng
> Xie
> Subject: Re: [PATCH] ACPICA: arm64: fix compile apci tools fail for arm64
> =

> Hi,
> =

> On 2016/10/19 6:07, Zheng, Lv wrote:
> > Hi,
> >
> > I'm not sure what you mean.
> > I mean you need ACPI_USE_SYSTEM_INTTYPES in case s64 has already been d=
efined in that environment.
> > Are you sure s64 should be defined for your environment?
> >
> s64 is not defined in my build environment but in kernel code.

Yes, in-kernel ACPICA applications trickily reused this to get it compiled =
in kernel source tree with minimal porting effort.
And it is working on x86.

> =

> > IMO, s64 is kernel space specific, while you are compiling user space t=
ools.
> > It looks to me like there is something wrong with ARM kernel's asm/type=
s.h.
> >
> >> I listed in change log. And I also have tried that way.
> >> However, it still have many other errors.(I am sorry to not have liste=
d all of them.)
> >>
> >> From the following log, you can see, all of the conflict type is from =
signal.h.
> >> And maybe this patch is a better way to fix these compile error, witho=
ut too much
> >> change of code.
> >>
> >> Are you sure that it will cause order problem when build ACPICA on oth=
er build
> >> environment, for it only effect aarch64.
> >
> > I'm not sure what this is.
> > How did you get this?
> > Were you compiling kernel acpi tools or compiling the kernel itself?
> >
> It's about compiling kernel acpi tools.
> =

> > For tool compilation, are you sure you have correctly configured your c=
ross-compilation environment?
> Maybe it is not my cross-compilation environment problem, for your also c=
an reproduce it,
> as your said in another email, right?

Yes, I reproduced it.
By commenting out <signal.h> inclusion from acenv.h.
Tools can be built by aarch64-linux-gnu tool chain downloaded from linaro.

However this is still not the root cause, IMO.

Thanks
Lv

> =

> > Will you see problems in compiling ACPICA applications from:
> > https://github.com/acpica/acpica
> >
> =

> > Thanks
> > Lv
> >
> > .
> >
> =

> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo(a)vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--===============4778704335491415932==--

