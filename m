Content-Type: multipart/mixed; boundary="===============6060759114334621286=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [pm:intel_idle+acpi 4/10] acpi_processor.c:undefined
 reference to `acpi_processor_ffh_cstate_probe'
Date: Mon, 16 Dec 2019 15:21:45 +0100
Message-ID: <CAJZ5v0iTOSnvZqKuL7gy7QBtdHxcM7wPS8qdgbvs6+sQxZX5yg@mail.gmail.com>
In-Reply-To: 201912162148.hTRbNfPp%lkp@intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6060759114334621286==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2019 at 2:26 PM kbuild test robot <lkp(a)intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.g=
it intel_idle+acpi
> head:   dcedc03145600b929a32acb85b212131b079bc46
> commit: 0300cf31f061e6287810c894337f29df2e200e2d [4/10] ACPI: processor: =
Export acpi_processor_evaluate_cst()

Outdated.  Please stop sending these.

> config: x86_64-randconfig-b002-20191216 (attached as .config)
> compiler: gcc-7 (Debian 7.5.0-1) 7.5.0
> reproduce:
>         git checkout 0300cf31f061e6287810c894337f29df2e200e2d
>         # save the attached .config to linux build tree
>         make ARCH=3Dx86_64
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp(a)intel.com>
>
> All errors (new ones prefixed by >>):
>
>    ld: drivers/acpi/acpi_processor.o: in function `acpi_processor_evaluat=
e_cst':
> >> acpi_processor.c:(.text+0x542): undefined reference to `acpi_processor=
_ffh_cstate_probe'
>
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology C=
enter
> https://lists.01.org/hyperkitty/list/kbuild-all(a)lists.01.org Intel Corp=
oration
--===============6060759114334621286==--

