Content-Type: multipart/mixed; boundary="===============2437390939382443788=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [rafael-pm:bleeding-edge 59/73]
 arch/x86/include/asm/pci_x86.h:133:19: error: expected ';
 ' after top level declarator
Date: Fri, 25 Feb 2022 16:10:17 +0100
Message-ID: <CAJZ5v0jmFJMrKT5RsR+JEfJHaYFxHTi2xjS0UnkNUhSn7-r==A@mail.gmail.com>
In-Reply-To: 0d4d70ca-a17f-b8de-53f7-a85a59304d36@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2437390939382443788==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 25, 2022 at 12:49 PM Hans de Goede <hdegoede(a)redhat.com> wrot=
e:
>
> Hi Rafael,
>
> On 2/25/22 00:24, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git bleeding-edge
> > head:   8276cbee5a52543c614a1e1bc2624188d5970848
> > commit: 62fabd56faafe033eb0be3ba24000b8db13d4c17 [59/73] x86/PCI: Disab=
le exclusion of E820 reserved addresses in some cases
> > config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive=
/20220225/202202250758.oDiHyXAy-lkp(a)intel.com/config)
> > compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d2=
71fc04d5b97b12e6b797c6067d3c96a8d7470e)
> > reproduce (this is a W=3D1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/s=
bin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-=
pm.git/commit/?id=3D62fabd56faafe033eb0be3ba24000b8db13d4c17
> >         git remote add rafael-pm https://git.kernel.org/pub/scm/linux/k=
ernel/git/rafael/linux-pm.git
> >         git fetch --no-tags rafael-pm bleeding-edge
> >         git checkout 62fabd56faafe033eb0be3ba24000b8db13d4c17
> >         # save the config file to linux build tree
> >         mkdir build_dir
> >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross =
W=3D1 O=3Dbuild_dir ARCH=3Dx86_64 SHELL=3D/bin/bash
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp(a)intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> >    In file included from arch/x86/kernel/resource.c:4:
> >    arch/x86/include/asm/pci_x86.h:97:8: error: unknown type name 'raw_s=
pinlock_t'
> >    extern raw_spinlock_t pci_config_lock;
> >           ^
> >>> arch/x86/include/asm/pci_x86.h:133:19: error: expected ';' after top =
level declarator
> >    extern void __init dmi_check_pciprobe(void);
> >                      ^
> >                      ;
> >    arch/x86/include/asm/pci_x86.h:134:19: error: expected ';' after top=
 level declarator
> >    extern void __init dmi_check_skip_isa_align(void);
> >                      ^
> >                      ;
>
> So the problem here seems to be that arch/x86/include/asm/pci_x86.h does =
not include
> all the headers which it relies on. Instead it release on the files which=
 include it
> to include those headers before hand.
>
> This should fix the errors reported here:
>
> --- a/arch/x86/include/asm/pci_x86.h
> +++ b/arch/x86/include/asm/pci_x86.h
> @@ -5,7 +5,9 @@
>   *     (c) 1999 Martin Mares <mj(a)ucw.cz>
>   */
>
> +#include <linux/init.h>
>  #include <linux/ioport.h>
> +#include <linux/spinlock.h>
>
>  #undef DEBUG
>
> I believe this is best squashed into the original commit,

Done, thanks!

> but let me know if
> you want me to send this out as a proper follow up patch; or if you want a
> new version of the troublesome commit to replace the original one.
--===============2437390939382443788==--

