Content-Type: multipart/mixed; boundary="===============8580371865402873080=="
MIME-Version: 1.0
From: kbuild test robot <lkp at intel.com>
Subject: Re: [Devel] [PATCH] pm: Fix build issues in ds278* (thinkpad_acpi)
Date: Sun, 24 Dec 2017 18:57:09 +0800
Message-ID: <201712241833.Bzw9bOzN%fengguang.wu@intel.com>
In-Reply-To: 20171224100647.GA13797@thinkpad
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8580371865402873080==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ognjen,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on battery/master]
[also build test ERROR on v4.15-rc5 next-20171222]
[if your patch is applied to the wrong git tree, please drop us a note to h=
elp improve the system]

url:    https://github.com/0day-ci/linux/commits/Ognjen-Galic/pm-Fix-build-=
issues-in-ds278-thinkpad_acpi/20171224-181540
base:   git://git.infradead.org/battery-2.6.git master
config: i386-randconfig-x007-201752 (attached as .config)
compiler: gcc-7 (Debian 7.2.0-12) 7.2.1 20171025
reproduce:
        # save the attached .config to linux build tree
        make ARCH=3Di386 =


All error/warnings (new ones prefixed by >>):

   drivers/power//supply/ds2780_battery.c: In function 'ds2780_get_pmod_ena=
bled':
>> drivers/power//supply/ds2780_battery.c:453:29: error: implicit declarati=
on of function 'to_power_supply'; did you mean 'power_supply_put'? [-Werror=
=3Dimplicit-function-declaration]
     struct power_supply *psy =3D to_power_supply(dev);
                                ^~~~~~~~~~~~~~~
                                power_supply_put
>> drivers/power//supply/ds2780_battery.c:453:29: warning: initialization m=
akes pointer from integer without a cast [-Wint-conversion]
   drivers/power//supply/ds2780_battery.c: In function 'ds2780_set_pmod_ena=
bled':
   drivers/power//supply/ds2780_battery.c:472:29: warning: initialization m=
akes pointer from integer without a cast [-Wint-conversion]
     struct power_supply *psy =3D to_power_supply(dev);
                                ^~~~~~~~~~~~~~~
   drivers/power//supply/ds2780_battery.c: In function 'ds2780_get_sense_re=
sistor_value':
   drivers/power//supply/ds2780_battery.c:507:29: warning: initialization m=
akes pointer from integer without a cast [-Wint-conversion]
     struct power_supply *psy =3D to_power_supply(dev);
                                ^~~~~~~~~~~~~~~
   drivers/power//supply/ds2780_battery.c: In function 'ds2780_set_sense_re=
sistor_value':
   drivers/power//supply/ds2780_battery.c:525:29: warning: initialization m=
akes pointer from integer without a cast [-Wint-conversion]
     struct power_supply *psy =3D to_power_supply(dev);
                                ^~~~~~~~~~~~~~~
   drivers/power//supply/ds2780_battery.c: In function 'ds2780_get_rsgain_s=
etting':
   drivers/power//supply/ds2780_battery.c:545:29: warning: initialization m=
akes pointer from integer without a cast [-Wint-conversion]
     struct power_supply *psy =3D to_power_supply(dev);
                                ^~~~~~~~~~~~~~~
   drivers/power//supply/ds2780_battery.c: In function 'ds2780_set_rsgain_s=
etting':
   drivers/power//supply/ds2780_battery.c:562:29: warning: initialization m=
akes pointer from integer without a cast [-Wint-conversion]
     struct power_supply *psy =3D to_power_supply(dev);
                                ^~~~~~~~~~~~~~~
   drivers/power//supply/ds2780_battery.c: In function 'ds2780_get_pio_pin':
   drivers/power//supply/ds2780_battery.c:588:29: warning: initialization m=
akes pointer from integer without a cast [-Wint-conversion]
     struct power_supply *psy =3D to_power_supply(dev);
                                ^~~~~~~~~~~~~~~
   drivers/power//supply/ds2780_battery.c: In function 'ds2780_set_pio_pin':
   drivers/power//supply/ds2780_battery.c:606:29: warning: initialization m=
akes pointer from integer without a cast [-Wint-conversion]
     struct power_supply *psy =3D to_power_supply(dev);
                                ^~~~~~~~~~~~~~~
   drivers/power//supply/ds2780_battery.c: In function 'ds2780_read_param_e=
eprom_bin':
   drivers/power//supply/ds2780_battery.c:632:29: warning: initialization m=
akes pointer from integer without a cast [-Wint-conversion]
     struct power_supply *psy =3D to_power_supply(dev);
                                ^~~~~~~~~~~~~~~
   drivers/power//supply/ds2780_battery.c: In function 'ds2780_write_param_=
eeprom_bin':
   drivers/power//supply/ds2780_battery.c:645:29: warning: initialization m=
akes pointer from integer without a cast [-Wint-conversion]
     struct power_supply *psy =3D to_power_supply(dev);
                                ^~~~~~~~~~~~~~~
   drivers/power//supply/ds2780_battery.c: In function 'ds2780_read_user_ee=
prom_bin':
   drivers/power//supply/ds2780_battery.c:677:29: warning: initialization m=
akes pointer from integer without a cast [-Wint-conversion]
     struct power_supply *psy =3D to_power_supply(dev);
                                ^~~~~~~~~~~~~~~
   drivers/power//supply/ds2780_battery.c: In function 'ds2780_write_user_e=
eprom_bin':
   drivers/power//supply/ds2780_battery.c:690:29: warning: initialization m=
akes pointer from integer without a cast [-Wint-conversion]
     struct power_supply *psy =3D to_power_supply(dev);
                                ^~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   drivers/power//supply/ds2781_battery.c: In function 'ds2781_get_pmod_ena=
bled':
>> drivers/power//supply/ds2781_battery.c:455:29: error: implicit declarati=
on of function 'to_power_supply'; did you mean 'power_supply_put'? [-Werror=
=3Dimplicit-function-declaration]
     struct power_supply *psy =3D to_power_supply(dev);
                                ^~~~~~~~~~~~~~~
                                power_supply_put
>> drivers/power//supply/ds2781_battery.c:455:29: warning: initialization m=
akes pointer from integer without a cast [-Wint-conversion]
   drivers/power//supply/ds2781_battery.c: In function 'ds2781_set_pmod_ena=
bled':
   drivers/power//supply/ds2781_battery.c:474:29: warning: initialization m=
akes pointer from integer without a cast [-Wint-conversion]
     struct power_supply *psy =3D to_power_supply(dev);
                                ^~~~~~~~~~~~~~~
   drivers/power//supply/ds2781_battery.c: In function 'ds2781_get_sense_re=
sistor_value':
   drivers/power//supply/ds2781_battery.c:509:29: warning: initialization m=
akes pointer from integer without a cast [-Wint-conversion]
     struct power_supply *psy =3D to_power_supply(dev);
                                ^~~~~~~~~~~~~~~
   drivers/power//supply/ds2781_battery.c: In function 'ds2781_set_sense_re=
sistor_value':
   drivers/power//supply/ds2781_battery.c:527:29: warning: initialization m=
akes pointer from integer without a cast [-Wint-conversion]
     struct power_supply *psy =3D to_power_supply(dev);
                                ^~~~~~~~~~~~~~~
   drivers/power//supply/ds2781_battery.c: In function 'ds2781_get_rsgain_s=
etting':
   drivers/power//supply/ds2781_battery.c:547:29: warning: initialization m=
akes pointer from integer without a cast [-Wint-conversion]
     struct power_supply *psy =3D to_power_supply(dev);
                                ^~~~~~~~~~~~~~~
   drivers/power//supply/ds2781_battery.c: In function 'ds2781_set_rsgain_s=
etting':
   drivers/power//supply/ds2781_battery.c:564:29: warning: initialization m=
akes pointer from integer without a cast [-Wint-conversion]
     struct power_supply *psy =3D to_power_supply(dev);
                                ^~~~~~~~~~~~~~~
   drivers/power//supply/ds2781_battery.c: In function 'ds2781_get_pio_pin':
   drivers/power//supply/ds2781_battery.c:590:29: warning: initialization m=
akes pointer from integer without a cast [-Wint-conversion]
     struct power_supply *psy =3D to_power_supply(dev);
                                ^~~~~~~~~~~~~~~
   drivers/power//supply/ds2781_battery.c: In function 'ds2781_set_pio_pin':
   drivers/power//supply/ds2781_battery.c:608:29: warning: initialization m=
akes pointer from integer without a cast [-Wint-conversion]
     struct power_supply *psy =3D to_power_supply(dev);
                                ^~~~~~~~~~~~~~~
   drivers/power//supply/ds2781_battery.c: In function 'ds2781_read_param_e=
eprom_bin':
   drivers/power//supply/ds2781_battery.c:634:29: warning: initialization m=
akes pointer from integer without a cast [-Wint-conversion]
     struct power_supply *psy =3D to_power_supply(dev);
                                ^~~~~~~~~~~~~~~
   drivers/power//supply/ds2781_battery.c: In function 'ds2781_write_param_=
eeprom_bin':
   drivers/power//supply/ds2781_battery.c:647:29: warning: initialization m=
akes pointer from integer without a cast [-Wint-conversion]
     struct power_supply *psy =3D to_power_supply(dev);
                                ^~~~~~~~~~~~~~~
   drivers/power//supply/ds2781_battery.c: In function 'ds2781_read_user_ee=
prom_bin':
   drivers/power//supply/ds2781_battery.c:679:29: warning: initialization m=
akes pointer from integer without a cast [-Wint-conversion]
     struct power_supply *psy =3D to_power_supply(dev);
                                ^~~~~~~~~~~~~~~
   drivers/power//supply/ds2781_battery.c: In function 'ds2781_write_user_e=
eprom_bin':
   drivers/power//supply/ds2781_battery.c:693:29: warning: initialization m=
akes pointer from integer without a cast [-Wint-conversion]
     struct power_supply *psy =3D to_power_supply(dev);
                                ^~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +453 drivers/power//supply/ds2780_battery.c

275ac746 drivers/power/ds2780_battery.c Clifton Barnes 2011-05-26  446  =

275ac746 drivers/power/ds2780_battery.c Clifton Barnes 2011-05-26  447  sta=
tic ssize_t ds2780_get_pmod_enabled(struct device *dev,
275ac746 drivers/power/ds2780_battery.c Clifton Barnes 2011-05-26  448  	st=
ruct device_attribute *attr,
275ac746 drivers/power/ds2780_battery.c Clifton Barnes 2011-05-26  449  	ch=
ar *buf)
275ac746 drivers/power/ds2780_battery.c Clifton Barnes 2011-05-26  450  {
275ac746 drivers/power/ds2780_battery.c Clifton Barnes 2011-05-26  451  	in=
t ret;
275ac746 drivers/power/ds2780_battery.c Clifton Barnes 2011-05-26  452  	u8=
 control_reg;
275ac746 drivers/power/ds2780_battery.c Clifton Barnes 2011-05-26 @453  	st=
ruct power_supply *psy =3D to_power_supply(dev);
275ac746 drivers/power/ds2780_battery.c Clifton Barnes 2011-05-26  454  	st=
ruct ds2780_device_info *dev_info =3D to_ds2780_device_info(psy);
275ac746 drivers/power/ds2780_battery.c Clifton Barnes 2011-05-26  455  =

275ac746 drivers/power/ds2780_battery.c Clifton Barnes 2011-05-26  456  	/*=
 Get power mode */
275ac746 drivers/power/ds2780_battery.c Clifton Barnes 2011-05-26  457  	re=
t =3D ds2780_get_control_register(dev_info, &control_reg);
275ac746 drivers/power/ds2780_battery.c Clifton Barnes 2011-05-26  458  	if=
 (ret < 0)
275ac746 drivers/power/ds2780_battery.c Clifton Barnes 2011-05-26  459  		r=
eturn ret;
275ac746 drivers/power/ds2780_battery.c Clifton Barnes 2011-05-26  460  =

275ac746 drivers/power/ds2780_battery.c Clifton Barnes 2011-05-26  461  	re=
turn sprintf(buf, "%d\n",
275ac746 drivers/power/ds2780_battery.c Clifton Barnes 2011-05-26  462  		 =
!!(control_reg & DS2780_CONTROL_REG_PMOD));
275ac746 drivers/power/ds2780_battery.c Clifton Barnes 2011-05-26  463  }
275ac746 drivers/power/ds2780_battery.c Clifton Barnes 2011-05-26  464  =


:::::: The code at line 453 was first introduced by commit
:::::: 275ac74629c4d8ec430d7edecb16d936f46a47c5 w1: add Maxim/Dallas DS2780=
 Stand-Alone Fuel Gauge IC support

:::::: TO: Clifton Barnes <cabarnes(a)indesign-llc.com>
:::::: CC: Linus Torvalds <torvalds(a)linux-foundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Cent=
er
https://lists.01.org/pipermail/kbuild-all                   Intel Corporati=
on

--===============8580371865402873080==
Content-Type: application/gzip
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="config.gz"

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
--===============8580371865402873080==--

