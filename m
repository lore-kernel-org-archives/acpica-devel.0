Content-Type: multipart/mixed; boundary="===============8162706136459046225=="
MIME-Version: 1.0
From: kbuild test robot <fengguang.wu at intel.com>
Subject: [Devel] [pm:bleeding-edge 66/71] drivers/acpi/scan.c:130:81: sparse:
 incorrect type in argument 3 (different modifiers)
Date: Mon, 19 Mar 2018 11:28:59 +0800
Message-ID: <201803191154.4OUmtxD0%fengguang.wu@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8162706136459046225==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git=
 bleeding-edge
head:   a9270e3c4bfe7b1b49da139186430d223f77a6f8
commit: 628c073bb72cd67c3fb34bee59683844bcf41752 [66/71] ACPI / scan: Send =
the change uevent with offine environmental data
reproduce:
        # apt-get install sparse
        git checkout 628c073bb72cd67c3fb34bee59683844bcf41752
        make ARCH=3Dx86_64 allmodconfig
        make C=3D1 CF=3D-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/acpi/scan.c:130:81: sparse: incorrect type in argument 3 (differ=
ent modifiers) @@    expected char **envp @@    got char cchar **envp @@
   drivers/acpi/scan.c:130:81:    expected char **envp
   drivers/acpi/scan.c:130:81:    got char const **<noident>
   drivers/acpi/scan.c: In function 'acpi_scan_is_offline':
   drivers/acpi/scan.c:130:53: error: passing argument 3 of 'kobject_uevent=
_env' from incompatible pointer type [-Werror=3Dincompatible-pointer-types]
        kobject_uevent_env(&pn->dev->kobj, KOBJ_CHANGE, envp);
                                                        ^~~~
   In file included from include/linux/module.h:17:0,
                    from drivers/acpi/scan.c:5:
   include/linux/kobject.h:219:5: note: expected 'char **' but argument is =
of type 'const char **'
    int kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
        ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +130 drivers/acpi/scan.c

    35	=

    36	static LIST_HEAD(acpi_dep_list);
    37	static DEFINE_MUTEX(acpi_dep_list_lock);
    38	LIST_HEAD(acpi_bus_id_list);
    39	static DEFINE_MUTEX(acpi_scan_lock);
    40	static LIST_HEAD(acpi_scan_handlers_list);
  > 41	DEFINE_MUTEX(acpi_device_lock);
    42	LIST_HEAD(acpi_wakeup_device_list);
    43	static DEFINE_MUTEX(acpi_hp_context_lock);
    44	=

    45	/*
    46	 * The UART device described by the SPCR table is the only object wh=
ich needs
    47	 * special-casing. Everything else is covered by ACPI namespace path=
s in STAO
    48	 * table.
    49	 */
    50	static u64 spcr_uart_addr;
    51	=

    52	struct acpi_dep_data {
    53		struct list_head node;
    54		acpi_handle master;
    55		acpi_handle slave;
    56	};
    57	=

    58	void acpi_scan_lock_acquire(void)
    59	{
    60		mutex_lock(&acpi_scan_lock);
    61	}
    62	EXPORT_SYMBOL_GPL(acpi_scan_lock_acquire);
    63	=

    64	void acpi_scan_lock_release(void)
    65	{
    66		mutex_unlock(&acpi_scan_lock);
    67	}
    68	EXPORT_SYMBOL_GPL(acpi_scan_lock_release);
    69	=

    70	void acpi_lock_hp_context(void)
    71	{
    72		mutex_lock(&acpi_hp_context_lock);
    73	}
    74	=

    75	void acpi_unlock_hp_context(void)
    76	{
    77		mutex_unlock(&acpi_hp_context_lock);
    78	}
    79	=

    80	void acpi_initialize_hp_context(struct acpi_device *adev,
    81					struct acpi_hotplug_context *hp,
    82					int (*notify)(struct acpi_device *, u32),
    83					void (*uevent)(struct acpi_device *, u32))
    84	{
    85		acpi_lock_hp_context();
    86		hp->notify =3D notify;
    87		hp->uevent =3D uevent;
    88		acpi_set_hp_context(adev, hp);
    89		acpi_unlock_hp_context();
    90	}
    91	EXPORT_SYMBOL_GPL(acpi_initialize_hp_context);
    92	=

    93	int acpi_scan_add_handler(struct acpi_scan_handler *handler)
    94	{
    95		if (!handler)
    96			return -EINVAL;
    97	=

    98		list_add_tail(&handler->list_node, &acpi_scan_handlers_list);
    99		return 0;
   100	}
   101	=

   102	int acpi_scan_add_handler_with_hotplug(struct acpi_scan_handler *han=
dler,
   103					       const char *hotplug_profile_name)
   104	{
   105		int error;
   106	=

   107		error =3D acpi_scan_add_handler(handler);
   108		if (error)
   109			return error;
   110	=

   111		acpi_sysfs_add_hotplug_profile(&handler->hotplug, hotplug_profile_n=
ame);
   112		return 0;
   113	}
   114	=

   115	bool acpi_scan_is_offline(struct acpi_device *adev, bool uevent)
   116	{
   117		struct acpi_device_physical_node *pn;
   118		bool offline =3D true;
   119		static const char *envp[] =3D { "EVENT=3Doffline", NULL };
   120	=

   121		/*
   122		 * acpi_container_offline() calls this for all of the container's
   123		 * children under the container's physical_node_lock lock.
   124		 */
   125		mutex_lock_nested(&adev->physical_node_lock, SINGLE_DEPTH_NESTING);
   126	=

   127		list_for_each_entry(pn, &adev->physical_node_list, node)
   128			if (device_supports_offline(pn->dev) && !pn->dev->offline) {
   129				if (uevent)
 > 130					kobject_uevent_env(&pn->dev->kobj, KOBJ_CHANGE, envp);
   131	=

   132				offline =3D false;
   133				break;
   134			}
   135	=

   136		mutex_unlock(&adev->physical_node_lock);
   137		return offline;
   138	}
   139	=


---
0-DAY kernel test infrastructure                Open Source Technology Cent=
er
https://lists.01.org/pipermail/kbuild-all                   Intel Corporati=
on

--===============8162706136459046225==--

