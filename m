Content-Type: multipart/mixed; boundary="===============6816703888038183323=="
MIME-Version: 1.0
From: Ganapatrao Kulkarni <gpkulkarni at gmail.com>
Subject: Re: [Devel] [PATCH v4 1/2] ACPICA: ACPI 6.2: Add support for new SRAT
 subtable
Date: Thu, 22 Jun 2017 21:51:10 +0530
Message-ID: <CAFpQJXUUaR7K6e_3jan1uXq8h4Au1633yfpvgG0Cm3eEJydQ9w@mail.gmail.com>
In-Reply-To: 7426901.eKsnQBecvM@aspire.rjw.lan
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6816703888038183323==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 22, 2017 at 7:57 PM, Rafael J. Wysocki <rjw(a)rjwysocki.net> wr=
ote:
> On Thursday, June 22, 2017 02:13:18 PM Moore, Robert wrote:
>> This support is already in the ACPICA code base, but I can't speak to wh=
en it will be upstreamed to Linux. Lv would know this.
>
> It should be there in linux-next already AFAICS.
>
> Lorenzo, can you please double check?

thanks Rafael, this is added to linux-next on june12 [1].

When i sent my first version i.e on June 6, it was not there, hence i
have added to this series.
my bad, i have not checked when i sent subsequent versions.
this patch can be dropped.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/com=
mit/include/acpi/actbl1.h?id=3Da618c7f89a02f3c67a8f200855cff398855e3888

>
> Thanks,
> Rafael
>
>
>> > -----Original Message-----
>> > From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi(a)arm.com]
>> > Sent: Thursday, June 22, 2017 6:43 AM
>> > To: Ganapatrao Kulkarni <ganapatrao.kulkarni(a)cavium.com>; Zheng, Lv
>> > <lv.zheng(a)intel.com>; Moore, Robert <robert.moore(a)intel.com>; Rafa=
el J.
>> > Wysocki <rjw(a)rjwysocki.net>
>> > Cc: linux-acpi(a)vger.kernel.org; devel(a)acpica.org; linux-
>> > kernel(a)vger.kernel.org; linux-arm-kernel(a)lists.infradead.org;
>> > marc.zyngier(a)arm.com; catalin.marinas(a)arm.com; will.deacon(a)arm.c=
om;
>> > hanjun.guo(a)linaro.org; tglx(a)linutronix.de; jason(a)lakedaemon.net;
>> > jnair(a)caviumnetworks.com; gpkulkarni(a)gmail.com
>> > Subject: Re: [PATCH v4 1/2] ACPICA: ACPI 6.2: Add support for new SRAT
>> > subtable
>> >
>> > Hi Rafael, Lv, Robert,
>> >
>> > On Thu, Jun 22, 2017 at 11:40:11AM +0530, Ganapatrao Kulkarni wrote:
>> > > Add GIC ITS Affinity (ACPI 6.2) subtable to SRAT table.
>> > >
>> > > ACPICA commit 5bc67f63918da249bfe279ee461d152bb3e6f55b
>> > > Link: https://github.com/acpica/acpica/commit/5bc67f6
>> > >
>> > > Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni(a)cavium.com>
>> > > ---
>> > >  include/acpi/actbl1.h | 12 +++++++++++-
>> > >  1 file changed, 11 insertions(+), 1 deletion(-)
>> >
>> > This patch is fine to me but it is up to you or who sends the ACPICA
>> > pull request to send it upstream or give us an ACK so that it can go v=
ia
>> > irqchip.
>> >
>> > We need to know how this commit (and other ACPICA changes) will be sent
>> > upstream to handle trees dependencies, please advise it is a bit urgen=
t,
>> > thank you.
>> >
>> > Lorenzo
>> >
>> > > diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h index
>> > > b4ce55c..253c9db 100644
>> > > --- a/include/acpi/actbl1.h
>> > > +++ b/include/acpi/actbl1.h
>> > > @@ -1192,7 +1192,8 @@ enum acpi_srat_type {
>> > >   ACPI_SRAT_TYPE_MEMORY_AFFINITY =3D 1,
>> > >   ACPI_SRAT_TYPE_X2APIC_CPU_AFFINITY =3D 2,
>> > >   ACPI_SRAT_TYPE_GICC_AFFINITY =3D 3,
>> > > - ACPI_SRAT_TYPE_RESERVED =3D 4     /* 4 and greater are reserved */
>> > > + ACPI_SRAT_TYPE_GIC_ITS_AFFINITY =3D 4,    /* ACPI 6.2 */
>> > > + ACPI_SRAT_TYPE_RESERVED =3D 5     /* 5 and greater are reserved */
>> > >  };
>> > >
>> > >  /*
>> > > @@ -1260,6 +1261,15 @@ struct acpi_srat_gicc_affinity {
>> > >   u32 clock_domain;
>> > >  };
>> > >
>> > > +/* 4: GIC ITS Affinity (ACPI 6.2) */
>> > > +
>> > > +struct acpi_srat_its_affinity {
>> > > + struct acpi_subtable_header header;
>> > > + u32 proximity_domain;
>> > > + u16 reserved;
>> > > + u32 its_id;
>> > > +};
>> > > +
>> > >  /* Flags for struct acpi_srat_gicc_affinity */
>> > >
>> > >  #define ACPI_SRAT_GICC_ENABLED     (1)   /* 00: Use affinity struct=
ure
>> > */
>> > > --
>> > > 1.8.1.4
>> > >
>

thanks
Ganapat

--===============6816703888038183323==--

