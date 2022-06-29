Content-Type: multipart/mixed; boundary="===============6304497251011390632=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH v3] ACPI: Split out processor thermal register
 from ACPI PSS
Date: Wed, 29 Jun 2022 18:53:07 +0200
Message-ID: <CAJZ5v0gbqxWjJjEJWJUt3HCMARtaewewNSHuD1zjoxOUeE89Rg@mail.gmail.com>
In-Reply-To: 871qvnpro3.fsf@stealth
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6304497251011390632==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 17, 2022 at 11:26 AM Punit Agrawal
<punit.agrawal(a)bytedance.com> wrote:
>
> Riwen Lu <luriwen(a)hotmail.com> writes:
>
> > From: Riwen Lu <luriwen(a)kylinos.cn>
> >
> > Commit 239708a3af44 ("ACPI: Split out ACPI PSS from ACPI Processor
> > driver"), moves processor thermal registration to acpi_pss_perf_init(),
> > which doesn't get executed if ACPI_CPU_FREQ_PSS is not enabled.
> >
> > As ARM64 supports P-states using CPPC, it should be possible to also
> > support processor passive cooling even if PSS is not enabled. Split
> > out the processor thermal cooling register from ACPI PSS to support
> > this, and move it into a separate function in processor_thermal.c.
> >
> > Signed-off-by: Riwen Lu <luriwen(a)kylinos.cn>
> >
> > ---
> > v1 -> v2:
> >  - Reword the commit message.
> >  - Update the signature of acpi_pss_perf_init() to void, and remove the
> >    acpi_device parameter.
> >  - Move the processor thermal register/remove into a separate function =
in
> >    processor_thermal.c.
> >
> > v2 -> v3:
> >  - Remove the "pr" NULL check in processor thermal init/exit fuction.
> >  - Pass the acpi_device into processor thermal init/exit, and remove the
> >    convert in it.
> > ---
> >  drivers/acpi/Kconfig             |  2 +-
> >  drivers/acpi/Makefile            |  5 +--
> >  drivers/acpi/processor_driver.c  | 72 ++++----------------------------
> >  drivers/acpi/processor_thermal.c | 54 ++++++++++++++++++++++++
> >  include/acpi/processor.h         |  8 +++-
> >  5 files changed, 71 insertions(+), 70 deletions(-)
> >
> > diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> > index 1e34f846508f..2457ade3f82d 100644
> > --- a/drivers/acpi/Kconfig
> > +++ b/drivers/acpi/Kconfig
> > @@ -255,7 +255,6 @@ config ACPI_DOCK
> >
> >  config ACPI_CPU_FREQ_PSS
> >       bool
> > -     select THERMAL
> >
> >  config ACPI_PROCESSOR_CSTATE
> >       def_bool y
> > @@ -287,6 +286,7 @@ config ACPI_PROCESSOR
> >       depends on X86 || IA64 || ARM64 || LOONGARCH
> >       select ACPI_PROCESSOR_IDLE
> >       select ACPI_CPU_FREQ_PSS if X86 || IA64 || LOONGARCH
> > +     select THERMAL
> >       default y
> >       help
> >         This driver adds support for the ACPI Processor package. It is =
required
> > diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> > index b5a8d3e00a52..0002eecbf870 100644
> > --- a/drivers/acpi/Makefile
> > +++ b/drivers/acpi/Makefile
> > @@ -109,10 +109,9 @@ obj-$(CONFIG_ACPI_PPTT)  +=3D pptt.o
> >  obj-$(CONFIG_ACPI_PFRUT)     +=3D pfr_update.o pfr_telemetry.o
> >
> >  # processor has its own "processor." module_param namespace
> > -processor-y                  :=3D processor_driver.o
> > +processor-y                  :=3D processor_driver.o processor_thermal=
.o
> >  processor-$(CONFIG_ACPI_PROCESSOR_IDLE) +=3D processor_idle.o
> > -processor-$(CONFIG_ACPI_CPU_FREQ_PSS)        +=3D processor_throttling=
.o       \
> > -     processor_thermal.o
> > +processor-$(CONFIG_ACPI_CPU_FREQ_PSS)        +=3D processor_throttling=
.o
> >  processor-$(CONFIG_CPU_FREQ) +=3D processor_perflib.o
> >
> >  obj-$(CONFIG_ACPI_PROCESSOR_AGGREGATOR) +=3D acpi_pad.o
> > diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_d=
river.c
> > index 368a9edefd0c..1278969eec1f 100644
> > --- a/drivers/acpi/processor_driver.c
> > +++ b/drivers/acpi/processor_driver.c
> > @@ -139,75 +139,17 @@ static int acpi_soft_cpu_dead(unsigned int cpu)
> >  }
> >
> >  #ifdef CONFIG_ACPI_CPU_FREQ_PSS
> > -static int acpi_pss_perf_init(struct acpi_processor *pr,
> > -             struct acpi_device *device)
> > +static void acpi_pss_perf_init(struct acpi_processor *pr)
> >  {
> > -     int result =3D 0;
> > -
> >       acpi_processor_ppc_has_changed(pr, 0);
> >
> >       acpi_processor_get_throttling_info(pr);
> >
> >       if (pr->flags.throttling)
> >               pr->flags.limit =3D 1;
> > -
> > -     pr->cdev =3D thermal_cooling_device_register("Processor", device,
> > -                                                &processor_cooling_ops=
);
> > -     if (IS_ERR(pr->cdev)) {
> > -             result =3D PTR_ERR(pr->cdev);
> > -             return result;
> > -     }
> > -
> > -     dev_dbg(&device->dev, "registered as cooling_device%d\n",
> > -             pr->cdev->id);
> > -
> > -     result =3D sysfs_create_link(&device->dev.kobj,
> > -                                &pr->cdev->device.kobj,
> > -                                "thermal_cooling");
> > -     if (result) {
> > -             dev_err(&device->dev,
> > -                     "Failed to create sysfs link 'thermal_cooling'\n"=
);
> > -             goto err_thermal_unregister;
> > -     }
> > -
> > -     result =3D sysfs_create_link(&pr->cdev->device.kobj,
> > -                                &device->dev.kobj,
> > -                                "device");
> > -     if (result) {
> > -             dev_err(&pr->cdev->device,
> > -                     "Failed to create sysfs link 'device'\n");
> > -             goto err_remove_sysfs_thermal;
> > -     }
> > -
> > -     return 0;
> > -
> > - err_remove_sysfs_thermal:
> > -     sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
> > - err_thermal_unregister:
> > -     thermal_cooling_device_unregister(pr->cdev);
> > -
> > -     return result;
> > -}
> > -
> > -static void acpi_pss_perf_exit(struct acpi_processor *pr,
> > -             struct acpi_device *device)
> > -{
> > -     if (pr->cdev) {
> > -             sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
> > -             sysfs_remove_link(&pr->cdev->device.kobj, "device");
> > -             thermal_cooling_device_unregister(pr->cdev);
> > -             pr->cdev =3D NULL;
> > -     }
> >  }
> >  #else
> > -static inline int acpi_pss_perf_init(struct acpi_processor *pr,
> > -             struct acpi_device *device)
> > -{
> > -     return 0;
> > -}
> > -
> > -static inline void acpi_pss_perf_exit(struct acpi_processor *pr,
> > -             struct acpi_device *device) {}
> > +static inline void acpi_pss_perf_init(struct acpi_processor *pr) {}
> >  #endif /* CONFIG_ACPI_CPU_FREQ_PSS */
> >
> >  static int __acpi_processor_start(struct acpi_device *device)
> > @@ -229,7 +171,9 @@ static int __acpi_processor_start(struct acpi_devic=
e *device)
> >       if (!cpuidle_get_driver() || cpuidle_get_driver() =3D=3D &acpi_id=
le_driver)
> >               acpi_processor_power_init(pr);
> >
> > -     result =3D acpi_pss_perf_init(pr, device);
> > +     acpi_pss_perf_init(pr);
> > +
> > +     result =3D acpi_processor_thermal_init(pr, device);
> >       if (result)
> >               goto err_power_exit;
> >
> > @@ -239,7 +183,7 @@ static int __acpi_processor_start(struct acpi_devic=
e *device)
> >               return 0;
> >
> >       result =3D -ENODEV;
> > -     acpi_pss_perf_exit(pr, device);
> > +     acpi_processor_thermal_exit(pr, device);
> >
> >  err_power_exit:
> >       acpi_processor_power_exit(pr);
> > @@ -277,10 +221,10 @@ static int acpi_processor_stop(struct device *dev)
> >               return 0;
> >       acpi_processor_power_exit(pr);
> >
> > -     acpi_pss_perf_exit(pr, device);
> > -
> >       acpi_cppc_processor_exit(pr);
> >
> > +     acpi_processor_thermal_exit(pr, device);
> > +
> >       return 0;
> >  }
> >
> > diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_=
thermal.c
> > index d8b2dfcd59b5..db6ac540e924 100644
> > --- a/drivers/acpi/processor_thermal.c
> > +++ b/drivers/acpi/processor_thermal.c
> > @@ -266,3 +266,57 @@ const struct thermal_cooling_device_ops processor_=
cooling_ops =3D {
> >       .get_cur_state =3D processor_get_cur_state,
> >       .set_cur_state =3D processor_set_cur_state,
> >  };
> > +
> > +int acpi_processor_thermal_init(struct acpi_processor *pr,
> > +                             struct acpi_device *device)
> > +{
> > +     int result =3D 0;
> > +
> > +     pr->cdev =3D thermal_cooling_device_register("Processor", device,
> > +                                                &processor_cooling_ops=
);
> > +     if (IS_ERR(pr->cdev)) {
> > +             result =3D PTR_ERR(pr->cdev);
> > +             return result;
> > +     }
> > +
> > +     dev_dbg(&device->dev, "registered as cooling_device%d\n",
> > +             pr->cdev->id);
> > +
> > +     result =3D sysfs_create_link(&device->dev.kobj,
> > +                                &pr->cdev->device.kobj,
> > +                                "thermal_cooling");
> > +     if (result) {
> > +             dev_err(&device->dev,
> > +                     "Failed to create sysfs link 'thermal_cooling'\n"=
);
> > +             goto err_thermal_unregister;
> > +     }
> > +
> > +     result =3D sysfs_create_link(&pr->cdev->device.kobj,
> > +                                &device->dev.kobj,
> > +                                "device");
> > +     if (result) {
> > +             dev_err(&pr->cdev->device,
> > +                     "Failed to create sysfs link 'device'\n");
> > +             goto err_remove_sysfs_thermal;
> > +     }
> > +
> > +     return 0;
> > +
> > +err_remove_sysfs_thermal:
> > +     sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
> > +err_thermal_unregister:
> > +     thermal_cooling_device_unregister(pr->cdev);
> > +
> > +     return result;
> > +}
> > +
> > +void acpi_processor_thermal_exit(struct acpi_processor *pr,
> > +                              struct acpi_device *device)
> > +{
> > +     if (pr->cdev) {
> > +             sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
> > +             sysfs_remove_link(&pr->cdev->device.kobj, "device");
> > +             thermal_cooling_device_unregister(pr->cdev);
> > +             pr->cdev =3D NULL;
> > +     }
> > +}
> > diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> > index 194027371928..ba1e3ed98d3d 100644
> > --- a/include/acpi/processor.h
> > +++ b/include/acpi/processor.h
> > @@ -442,8 +442,12 @@ static inline int acpi_processor_hotplug(struct ac=
pi_processor *pr)
> >
> >  /* in processor_thermal.c */
> >  int acpi_processor_get_limit_info(struct acpi_processor *pr);
> > +int acpi_processor_thermal_init(struct acpi_processor *pr,
> > +                             struct acpi_device *device);
> > +void acpi_processor_thermal_exit(struct acpi_processor *pr,
> > +                              struct acpi_device *device);
> >  extern const struct thermal_cooling_device_ops processor_cooling_ops;
> > -#if defined(CONFIG_ACPI_CPU_FREQ_PSS) & defined(CONFIG_CPU_FREQ)
> > +#ifdef CONFIG_CPU_FREQ
> >  void acpi_thermal_cpufreq_init(struct cpufreq_policy *policy);
> >  void acpi_thermal_cpufreq_exit(struct cpufreq_policy *policy);
> >  #else
> > @@ -455,6 +459,6 @@ static inline void acpi_thermal_cpufreq_exit(struct=
 cpufreq_policy *policy)
> >  {
> >       return;
> >  }
> > -#endif       /* CONFIG_ACPI_CPU_FREQ_PSS */
> > +#endif       /* CONFIG_CPU_FREQ */
> >
> >  #endif
>
> Thanks for updating the patch.
>
> FWIW,
>
> Reviewed-by: Punit Agrawal <punit.agrawal(a)bytedance.com>

Applied as 5.20 material under edited subject, thanks!
--===============6304497251011390632==--

