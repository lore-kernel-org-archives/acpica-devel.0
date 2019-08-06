Content-Type: multipart/mixed; boundary="===============0151322788863896088=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [PATCH V2 05/10] ACPI: cpufreq: Switch to QoS requests
 instead of cpufreq notifier
Date: Tue, 06 Aug 2019 10:01:05 +0200
Message-ID: <CAJZ5v0iqwc4mvqHoTHwoNS-T1zueS07S2e-1STEsKhFhoOh0dA@mail.gmail.com>
In-Reply-To: 20190806043904.dbpon4qf3mfsm4vz@vireshk-i7
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0151322788863896088==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2019 at 6:39 AM Viresh Kumar <viresh.kumar(a)linaro.org> wro=
te:
>
> On 05-08-19, 11:42, Rafael J. Wysocki wrote:
> > On Tuesday, July 23, 2019 8:14:05 AM CEST Viresh Kumar wrote:
> > > @@ -310,8 +339,11 @@ static int __init acpi_processor_driver_init(voi=
d)
> > >     cpuhp_setup_state_nocalls(CPUHP_ACPI_CPUDRV_DEAD, "acpi/cpu-drv:d=
ead",
> > >                               NULL, acpi_soft_cpu_dead);
> > >
> > > -   acpi_thermal_cpufreq_init();
> > > -   acpi_processor_ppc_init();
> > > +   if (!cpufreq_register_notifier(&acpi_processor_notifier_block,
> > > +                                  CPUFREQ_POLICY_NOTIFIER)) {
> > > +           acpi_processor_cpufreq_init =3D true;
> >
> > Can't that be set/cleared by acpi_processor_notifier() itself?
>
> This is required to be done only once at initialization and setting it
> to true again and again on every invocation of the notifier callback
> doesn't look right.
>
> I have updated the patch based on rest of your suggestions, please see
> if it looks okay now.

Yes, it does, thanks!

[No need to resend, I'll take it from this message.]

--===============0151322788863896088==--

