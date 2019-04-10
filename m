Content-Type: multipart/mixed; boundary="===============6561741045730723811=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [pm:bleeding-edge 47/52]
 drivers//acpi/acpi_configfs.c:112:32: error: 'ACPI_NAME_SIZE' undeclared;
 did you mean 'APR_NAME_SIZE'?
Date: Wed, 10 Apr 2019 17:41:48 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B95830E0@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 201904091650.n4PgwLCA%lkp@intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6561741045730723811==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We renamed some of these:


Renamed some internal macros to improve code understanding and maintenance.=
 The macros below all operate on single 4-character ACPI NameSegs, not gene=
ric strings (old -> new):
    ACPI_NAME_SIZE    -> ACPI_NAMESEG_SIZE
    ACPI_COMPARE_NAME -> ACPI_COMPARE_NAMESEG
    ACPI_MOVE_NAME    -> ACPI_COPY_NAMESEG



> -----Original Message-----
> From: lkp
> Sent: Tuesday, April 9, 2019 1:42 AM
> To: Moore, Robert <robert.moore(a)intel.com>
> Cc: kbuild-all(a)01.org; linux-acpi(a)vger.kernel.org; devel(a)acpica.org;
> linux-pm(a)vger.kernel.org; Rafael J. Wysocki <rjw(a)rjwysocki.net>;
> Schmauss, Erik <erik.schmauss(a)intel.com>
> Subject: [pm:bleeding-edge 47/52] drivers//acpi/acpi_configfs.c:112:32:
> error: 'ACPI_NAME_SIZE' undeclared; did you mean 'APR_NAME_SIZE'?
> =

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-
> pm.git bleeding-edge
> head:   ea3d77d1940b15ef51a4f4936d05e99fab4cecff
> commit: 756ae0e33ac30984626b5f570c21c2bd1defac4d [47/52] ACPICA: Rename
> nameseg length macro/define for clarity
> config: i386-randconfig-x001-201914 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         git checkout 756ae0e33ac30984626b5f570c21c2bd1defac4d
>         # save the attached .config to linux build tree
>         make ARCH=3Di386
> =

> All error/warnings (new ones prefixed by >>):
> =

>    drivers//acpi/acpi_configfs.c: In function
> 'acpi_table_signature_show':
> >> drivers//acpi/acpi_configfs.c:112:32: error: 'ACPI_NAME_SIZE'
> undeclared (first use in this function); did you mean 'APR_NAME_SIZE'?
>      return sprintf(str, "%.*s\n", ACPI_NAME_SIZE, h->signature);
>                                    ^~~~~~~~~~~~~~
>                                    APR_NAME_SIZE
>    drivers//acpi/acpi_configfs.c:112:32: note: each undeclared
> identifier is reported only once for each function it appears in
>    drivers//acpi/acpi_configfs.c: In function
> 'acpi_table_asl_compiler_id_show':
>    drivers//acpi/acpi_configfs.c:173:32: error: 'ACPI_NAME_SIZE'
> undeclared (first use in this function); did you mean 'APR_NAME_SIZE'?
>      return sprintf(str, "%.*s\n", ACPI_NAME_SIZE, h->asl_compiler_id);
>                                    ^~~~~~~~~~~~~~
>                                    APR_NAME_SIZE
> >> drivers//acpi/acpi_configfs.c:174:1: warning: control reaches end of
> non-void function [-Wreturn-type]
>     }
>     ^
>    drivers//acpi/acpi_configfs.c: In function
> 'acpi_table_signature_show':
>    drivers//acpi/acpi_configfs.c:113:1: warning: control reaches end of
> non-void function [-Wreturn-type]
>     }
>     ^
> =

> vim +112 drivers//acpi/acpi_configfs.c
> =

> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  104
> c62c15a9 drivers/acpi/acpi_configfs.c Andy Shevchenko  2019-03-11  105
> static ssize_t acpi_table_signature_show(struct config_item *cfg, char
> *str)
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  106
> {
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  107
> 	struct acpi_table_header *h =3D get_header(cfg);
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  108
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  109
> 	if (!h)
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  110
> 		return -EINVAL;
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  111
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08 @112
> 	return sprintf(str, "%.*s\n", ACPI_NAME_SIZE, h->signature);
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  113
> }
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  114
> c62c15a9 drivers/acpi/acpi_configfs.c Andy Shevchenko  2019-03-11  115
> static ssize_t acpi_table_length_show(struct config_item *cfg, char
> *str)
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  116
> {
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  117
> 	struct acpi_table_header *h =3D get_header(cfg);
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  118
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  119
> 	if (!h)
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  120
> 		return -EINVAL;
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  121
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  122
> 	return sprintf(str, "%d\n", h->length);
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  123
> }
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  124
> c62c15a9 drivers/acpi/acpi_configfs.c Andy Shevchenko  2019-03-11  125
> static ssize_t acpi_table_revision_show(struct config_item *cfg, char
> *str)
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  126
> {
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  127
> 	struct acpi_table_header *h =3D get_header(cfg);
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  128
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  129
> 	if (!h)
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  130
> 		return -EINVAL;
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  131
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  132
> 	return sprintf(str, "%d\n", h->revision);
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  133
> }
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  134
> c62c15a9 drivers/acpi/acpi_configfs.c Andy Shevchenko  2019-03-11  135
> static ssize_t acpi_table_oem_id_show(struct config_item *cfg, char
> *str)
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  136
> {
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  137
> 	struct acpi_table_header *h =3D get_header(cfg);
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  138
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  139
> 	if (!h)
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  140
> 		return -EINVAL;
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  141
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  142
> 	return sprintf(str, "%.*s\n", ACPI_OEM_ID_SIZE, h->oem_id);
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  143
> }
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  144
> c62c15a9 drivers/acpi/acpi_configfs.c Andy Shevchenko  2019-03-11  145
> static ssize_t acpi_table_oem_table_id_show(struct config_item *cfg,
> char *str)
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  146
> {
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  147
> 	struct acpi_table_header *h =3D get_header(cfg);
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  148
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  149
> 	if (!h)
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  150
> 		return -EINVAL;
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  151
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  152
> 	return sprintf(str, "%.*s\n", ACPI_OEM_TABLE_ID_SIZE, h-
> >oem_table_id);
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  153
> }
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  154
> c62c15a9 drivers/acpi/acpi_configfs.c Andy Shevchenko  2019-03-11  155
> static ssize_t acpi_table_oem_revision_show(struct config_item *cfg,
> char *str)
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  156
> {
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  157
> 	struct acpi_table_header *h =3D get_header(cfg);
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  158
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  159
> 	if (!h)
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  160
> 		return -EINVAL;
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  161
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  162
> 	return sprintf(str, "%d\n", h->oem_revision);
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  163
> }
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  164
> c62c15a9 drivers/acpi/acpi_configfs.c Andy Shevchenko  2019-03-11  165
> static ssize_t acpi_table_asl_compiler_id_show(struct config_item *cfg,
> c62c15a9 drivers/acpi/acpi_configfs.c Andy Shevchenko  2019-03-11  166
> 					       char *str)
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  167
> {
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  168
> 	struct acpi_table_header *h =3D get_header(cfg);
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  169
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  170
> 	if (!h)
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  171
> 		return -EINVAL;
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  172
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  173
> 	return sprintf(str, "%.*s\n", ACPI_NAME_SIZE, h->asl_compiler_id);
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08 @174
> }
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  175
> =

> :::::: The code at line 112 was first introduced by commit
> :::::: 612bd01fc6e04c3ce9eb59587b4a7e4ebd6aff35 ACPI: add support for
> loading SSDTs via configfs
> =

> :::::: TO: Octavian Purdila <octavian.purdila(a)intel.com>
> :::::: CC: Rafael J. Wysocki <rafael.j.wysocki(a)intel.com>
> =

> ---
> 0-DAY kernel test infrastructure                Open Source Technology
> Center
> https://lists.01.org/pipermail/kbuild-all                   Intel
> Corporation

--===============6561741045730723811==--

