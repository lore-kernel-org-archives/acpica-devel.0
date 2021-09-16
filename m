Content-Type: multipart/mixed; boundary="===============8006494517392178825=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [rafael-pm:bleeding-edge 6/11]
 drivers/base/swnode.c:1120:17: error: too many arguments to function
 'software_node_notify'
Date: Thu, 16 Sep 2021 12:04:12 +0200
Message-ID: <CAJZ5v0idEO8LUvh+yWCV-f7Ha37thLo5fhnypMRSwEXLRd4EYQ@mail.gmail.com>
In-Reply-To: YULrCIRyvuryjoGE@kuha.fi.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8006494517392178825==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 16, 2021 at 8:58 AM Heikki Krogerus
<heikki.krogerus(a)linux.intel.com> wrote:
>
> On Thu, Sep 16, 2021 at 08:13:24AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git bleeding-edge
> > head:   9808623e1bba7d929b50865d7e2d7042cd4e5e7b
> > commit: 810fc8571f8b70a4263266d979f97edec2804574 [6/11] software node: =
balance refcount for managed sw nodes
> > config: arc-randconfig-r001-20210916 (attached as .config)
> > compiler: arc-elf-gcc (GCC) 11.2.0
> > reproduce (this is a W=3D1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/s=
bin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-=
pm.git/commit/?id=3D810fc8571f8b70a4263266d979f97edec2804574
> >         git remote add rafael-pm https://git.kernel.org/pub/scm/linux/k=
ernel/git/rafael/linux-pm.git
> >         git fetch --no-tags rafael-pm bleeding-edge
> >         git checkout 810fc8571f8b70a4263266d979f97edec2804574
> >         # save the attached .config to linux build tree
> >         mkdir build_dir
> >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-11.2.0 make.c=
ross O=3Dbuild_dir ARCH=3Darc SHELL=3D/bin/bash drivers/
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp(a)intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> >    drivers/base/swnode.c: In function 'device_create_managed_software_n=
ode':
> > >> drivers/base/swnode.c:1120:17: error: too many arguments to function=
 'software_node_notify'
> >     1120 |                 software_node_notify(dev, KOBJ_ADD);
> >          |                 ^~~~~~~~~~~~~~~~~~~~
> >    In file included from drivers/base/swnode.c:14:
> >    drivers/base/base.h:206:6: note: declared here
> >      206 | void software_node_notify(struct device *dev);
> >          |      ^~~~~~~~~~~~~~~~~~~~
>
> Ah, that was modified in commit 384f5a857bae ("software nodes: Split
> software_node_notify()").
>
> So the patch is OK for stable, but for v5.15-rc1 it has to be changed:
>
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 7bd0f3cfb7eb4..c46f6a8e14d23 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -1116,6 +1116,9 @@ int device_create_managed_software_node(struct devi=
ce *dev,
>         to_swnode(fwnode)->managed =3D true;
>         set_secondary_fwnode(dev, fwnode);
>
> +       if (device_is_registered(dev))
> +               software_node_notify(dev);
> +
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(device_create_managed_software_node);
>
>
> Rafael, how do want to handle this?

I'll fix up the commit, thanks!
--===============8006494517392178825==--

