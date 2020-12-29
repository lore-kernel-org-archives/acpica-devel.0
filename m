Content-Type: multipart/mixed; boundary="===============8085971806373591375=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [External] Re: [pm:bleeding-edge 8612/8615]
 drivers/acpi/platform_profile.c:147:24: warning: address of array
 'pprof->choices' will always evaluate to 'true'
Date: Tue, 29 Dec 2020 16:46:38 +0100
Message-ID: <CAJZ5v0gyAXmbbjbW=sh9UzZRaJMuc0_Btx4V+4DhrSQOPrt3Mg@mail.gmail.com>
In-Reply-To: 22e7ec14-faab-bddd-fff2-303ab3bff01e@lenovo.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8085971806373591375==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 29, 2020 at 4:36 PM Mark Pearson <markpearson(a)lenovo.com> wro=
te:
>
> Hi Rafael
>
> On 29/12/2020 10:23, Rafael J. Wysocki wrote:
> > On Tue, Dec 29, 2020 at 12:18 AM Mark Pearson <markpearson(a)lenovo.com=
> wrote:
> >>
> >> Hi Hans
> >>
> >> On 27/12/2020 06:56, Hans de Goede wrote:
> >>> Hi,
> >>>
> >>> On 12/27/20 6:11 AM, kernel test robot wrote:
> >>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux=
-pm.git bleeding-edge
> >>>> head:   a33520709645543f108361fe21fa9434a351c4e9
> >>>> commit: 8c9b909fb1282e43792433e6c1cba125ccfc6201 [8612/8615] ACPI: p=
latform-profile: Add platform profile support
> >>>> config: x86_64-randconfig-a015-20201221 (attached as .config)
> >>>> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project=
 cee1e7d14f4628d6174b33640d502bff3b54ae45)
> >>>> reproduce (this is a W=3D1 build):
> >>>>         wget https://raw.githubusercontent.com/intel/lkp-tests/maste=
r/sbin/make.cross -O ~/bin/make.cross
> >>>>         chmod +x ~/bin/make.cross
> >>>>         # install x86_64 cross compiling tool for clang build
> >>>>         # apt-get install binutils-x86-64-linux-gnu
> >>>>         # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/lin=
ux-pm.git/commit/?id=3D8c9b909fb1282e43792433e6c1cba125ccfc6201
> >>>>         git remote add pm https://git.kernel.org/pub/scm/linux/kerne=
l/git/rafael/linux-pm.git
> >>>>         git fetch --no-tags pm bleeding-edge
> >>>>         git checkout 8c9b909fb1282e43792433e6c1cba125ccfc6201
> >>>>         # save the attached .config to linux build tree
> >>>>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cro=
ss ARCH=3Dx86_64
> >>>>
> >>>> If you fix the issue, kindly add following tag as appropriate
> >>>> Reported-by: kernel test robot <lkp(a)intel.com>
> >>>>
> >>>> All warnings (new ones prefixed by >>):
> >>>>
> >>>>>> drivers/acpi/platform_profile.c:147:24: warning: address of array =
'pprof->choices' will always evaluate to 'true' [-Wpointer-bool-conversion]
> >>>>            if (!pprof || !pprof->choices || !pprof->profile_set ||
> >>>>                          ~~~~~~~~^~~~~~~
> >>>>    1 warning generated.
> >>>
> >>>
> >>> Ah, this is caused by changing choices from a single long to:
> >>>
> >>>       unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
> >>>
> >>> So that we can use for_each_set_bit and are future proof for more then
> >>> 32 profiles.
> >>>
> >>> To fix this the check should be changed into this (untested):
> >>>
> >>> #include <linux/bitmap.h>
> >>>
> >>>       if (!pprof || bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAS=
T) ||
> >>>           !pprof->profile_set || !pprof->profile_get) {
> >>>               mutex_unlock(&profile_lock);
> >>>               return -EINVAL;
> >>>       }
> >>>
> >>> Mark can you provide a (tested) patch for this?
> >>>
> >>> Regards,
> >>>
> >>> Hans
> >>>
> >> Will do!
> >
> > Please note that I'm not going to push the material to Linus with this
> > warning, so if you want it to go into 5.11, that needs to be addressed
> > timely.
> >
> > Thanks!
> >
> Understood :) I tested this last night and it looks good. Do I push this
> as a v8 patch on the current series or as a new standalone patch?

An incremental patch to fix the issue, please.
--===============8085971806373591375==--

