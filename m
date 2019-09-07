Content-Type: multipart/mixed; boundary="===============8497878605751836894=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [pm:bleeding-edge 175/181]
 drivers/cpuidle/driver.c:270:4: error: 'cpuidle_prev_governor' undeclared;
 did you mean 'cpuidle_find_governor'?
Date: Sat, 07 Sep 2019 23:07:39 +0200
Message-ID: <CAJZ5v0i7Y6DSuYzh0H4n+S8Pd2YAqVZTM+0VCamzW9CBcqFs0g@mail.gmail.com>
In-Reply-To: 847405da-8a45-653b-d544-25b58ea48db1@oracle.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8497878605751836894==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2019 at 7:39 PM Joao Martins <joao.m.martins(a)oracle.com> w=
rote:
>
> On 9/6/19 5:44 PM, kbuild test robot wrote:
> > tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/rafael=
/linux-pm.git bleeding-edge
> > head:   79f0d67a241f0583b994c73437caa54a4e942737
> > commit: 73d2bcced00671c2b724a31c3a4b3401c3e278d0 [175/181] cpuidle: all=
ow governor switch on cpuidle_register_driver()
> > config: arm-defconfig (attached as .config)
> > compiler: arm-linux-gnueabi-gcc (GCC) 7.4.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/s=
bin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         git checkout 73d2bcced00671c2b724a31c3a4b3401c3e278d0
> >         # save the attached .config to linux build tree
> >         GCC_VERSION=3D7.4.0 make.cross ARCH=3Darm
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot <lkp(a)intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> >    drivers/cpuidle/driver.c: In function 'cpuidle_register_driver':
> >>> drivers/cpuidle/driver.c:270:4: error: 'cpuidle_prev_governor' undecl=
ared (first use in this function); did you mean 'cpuidle_find_governor'?
> >        cpuidle_prev_governor =3D cpuidle_curr_governor;
> >        ^~~~~~~~~~~~~~~~~~~~~
> >        cpuidle_find_governor
> >    drivers/cpuidle/driver.c:270:4: note: each undeclared identifier is =
reported only once for each function it appears in
> >    drivers/cpuidle/driver.c: In function 'cpuidle_unregister_driver':
> >    drivers/cpuidle/driver.c:301:6: error: 'cpuidle_prev_governor' undec=
lared (first use in this function); did you mean 'cpuidle_find_governor'?
> >      if (cpuidle_prev_governor) {
> >          ^~~~~~~~~~~~~~~~~~~~~
> >          cpuidle_find_governor
> >
> Sorry, didn't build-test with CONFIG_CPU_IDLE_MULTIPLE_DRIVERS=3Dy
>
> Rafael, should I take this message that you queued the series (and thus I=
 submit
> a follow up fixing this), or I can just submit a v3 of this particular se=
ries?

Please submit a v3.  Thanks!

--===============8497878605751836894==--

