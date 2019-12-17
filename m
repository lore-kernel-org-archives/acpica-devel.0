Content-Type: multipart/mixed; boundary="===============4407522386121044963=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [kbuild-all] Re: [pm:intel_idle+acpi 4/10]
 acpi_processor.c:undefined reference to `acpi_processor_ffh_cstate_probe'
Date: Tue, 17 Dec 2019 09:23:14 +0100
Message-ID: <CAJZ5v0gFbjbqTOD845RjzpJQXQY=ko=9GxwVxoqw0fPccfig4w@mail.gmail.com>
In-Reply-To: 831EE4E5E37DCC428EB295A351E66249522A215D@shsmsx102.ccr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4407522386121044963==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2019 at 1:31 AM Li, Philip <philip.li(a)intel.com> wrote:
>
> > Subject: [kbuild-all] Re: [pm:intel_idle+acpi 4/10] acpi_processor.c:un=
defined
> > reference to `acpi_processor_ffh_cstate_probe'
> >
> > On Mon, Dec 16, 2019 at 2:26 PM kbuild test robot <lkp(a)intel.com> wro=
te:
> > >
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-=
pm.git
> > intel_idle+acpi
> > > head:   dcedc03145600b929a32acb85b212131b079bc46
> > > commit: 0300cf31f061e6287810c894337f29df2e200e2d [4/10] ACPI: process=
or:
> > Export acpi_processor_evaluate_cst()
> >
> > Outdated.  Please stop sending these.
> thanks for the input Rafael, we will ignore the following tests on it.

Well, the branch has been rebased since then and effectively it is a new on=
e.

My point is that if something like that happens, the script should
discard the old branch and pull the new one from scratch.
--===============4407522386121044963==--

