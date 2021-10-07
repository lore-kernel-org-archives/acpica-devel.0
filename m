Content-Type: multipart/mixed; boundary="===============7525465995545116270=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [rafael-pm:bleeding-edge 47/54]
 drivers/cpufreq/mediatek-cpufreq-hw.c:112:17: error: too few arguments to
 function 'cpufreq_table_find_index_dl'
Date: Thu, 07 Oct 2021 16:59:02 +0200
Message-ID: <CAJZ5v0h3HZBDyv-jH7m86kzXk+aG9PvpO1RT1rRfvt2VmurcXg@mail.gmail.com>
In-Reply-To: 20211007112614.GA101488@e120877-lin.cambridge.arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7525465995545116270==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 7, 2021 at 1:26 PM Vincent Donnefort
<vincent.donnefort(a)arm.com> wrote:
>
>
> On Thu, Oct 07, 2021 at 06:35:55PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git bleeding-edge
> > head:   6cb3f7cfca6963de4f486c4bd99fdefa56f75870
> > commit: 1f39fa0dccff71d4788089b5e617229b19166867 [47/54] cpufreq: Intro=
ducing CPUFREQ_RELATION_E
> > config: arm-buildonly-randconfig-r001-20211007 (attached as .config)
> > compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
> > reproduce (this is a W=3D1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/s=
bin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-=
pm.git/commit/?id=3D1f39fa0dccff71d4788089b5e617229b19166867
> >         git remote add rafael-pm https://git.kernel.org/pub/scm/linux/k=
ernel/git/rafael/linux-pm.git
> >         git fetch --no-tags rafael-pm bleeding-edge
> >         git checkout 1f39fa0dccff71d4788089b5e617229b19166867
> >         # save the attached .config to linux build tree
> >         mkdir build_dir
> >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-11.2.0 make.c=
ross O=3Dbuild_dir ARCH=3Darm SHELL=3D/bin/bash drivers/cpufreq/
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp(a)intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> >    drivers/cpufreq/mediatek-cpufreq-hw.c: In function 'mtk_cpufreq_hw_f=
ast_switch':
> > >> drivers/cpufreq/mediatek-cpufreq-hw.c:112:17: error: too few argumen=
ts to function 'cpufreq_table_find_index_dl'
> >      112 |         index =3D cpufreq_table_find_index_dl(policy, target=
_freq);
> >          |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    In file included from drivers/cpufreq/mediatek-cpufreq-hw.c:7:
> >    include/linux/cpufreq.h:814:19: note: declared here
> >      814 | static inline int cpufreq_table_find_index_dl(struct cpufreq=
_policy *policy,
> >          |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
>
> Rafael,
>
> The issue is this patch
>
>   cpufreq: Introducing CPUFREQ_RELATION_E
>
> How would you like to proceed? Do you want a v8 patch-set with the fix or=
 just
> that patch updated?

Please send an incremental fix on top of the series.
--===============7525465995545116270==--

