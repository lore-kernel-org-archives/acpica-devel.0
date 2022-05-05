Content-Type: multipart/mixed; boundary="===============0639254112643121245=="
MIME-Version: 1.0
From: Sudeep Holla <sudeep.holla at arm.com>
Subject: [Devel] Re: [PATCH 2/2] ACPI: ARM Performance Monitoring Unit Table
 (APMT) initial support
Date: Thu, 05 May 2022 12:42:00 +0100
Message-ID: <20220505114200.ys6ilkkcsakkbnkc@bogus>
In-Reply-To: SN6PR12MB4719E05A6BC7CAA2C00F35EFA0C39@SN6PR12MB4719.namprd12.prod.outlook.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0639254112643121245==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, May 04, 2022 at 10:08:39PM +0000, Besar Wicaksono wrote:
> Hi Sudeep,
> =

> > Any particular reason why you would like to rush and push this without
> > the actual driver to probe the device being added here ?
> =

> I plan to have two patch series, one for ACPI patch (this patch) and one =
for
> driver patch. My understanding is the driver patch will depend on this
> patch, but not the other way. So, I thought it would be better to get this
> patch approved first. However, if it helps the review of this patch, I am
> hoping to post the driver patch by end of the week and will CC you on that
> one.

Sure please do that. IMO, the driver is usually upstreamed first along with
the DT bindings(in ACPI case either the spec change or the std namespace no=
de)
The actual addition of the device happens via DT. ACPI APMT needs creation
of device here but I prefer to see the driver first.

> =

> > I really don't prefer this name:
> > 1. arm-coresight-pmu is much better than "csite". I see the short form
> >    used elsewhere in the kernel is just "cs" as in cs_etm,...etc
> > 2. Since APMT is more generic than just coresight(I understand coresight
> >    was the initial motivation for the generic specification) and also
> >    the type list seem to cover memory controller, SMMU,..etc, does
> >    it make sense to call it "arm-generic-pmu" or something similar.
> =

> Between these two, I would prefer arm-coresight-pmu just to anticipate
> another standard in the future from ARM. The APMT, to my understanding, is
> applicable only to CoreSight based PMUs. Using "coresight" as part of the
> device name is reasonable.

I read the APMT spec again and it has very little reference to coresight
though it is weirdly labelled as Coresight PMU for no sane reasons(Sorry I
know it's Arm to blame here and I bet something to do with marketing).

Anyways the APMT spec on its own covers all types of PMUs as I stated earli=
er.
So I prefer "arm-generic-pmu" or something better if you can come up with. I
am fine if you would like to retain arm-coresight-pmu when you post driver =
as
that's what the spec is labelled as.

Once you post the driver we can debate on that and come up with better name
with all the concerned parties involved.

> =

> > Not sure if the same device name will be re-used or PMUs can be registe=
red
> > with different name under perf subsystem, but the name matters for the =
user
> > space tools and decoders. They may use the name or type information to =
analyse
> > the data samples.
> >
> > So it is better to wait for all those discussion as part of the driver
> > upstreaming before you use this device name unless we are absolutely su=
re
> > the PMUs can be registered with different names in the driver(which cou=
ld
> > be possible, I just don't know)
> >
> > Apart from this name, I am OK with the changes here and happy to ack if=
 it
> > is OK to merge this without any driver to probe this device yet.
> =

> I believe using a different name to register the PMU is possible.
> In the current driver patch, we use a different name format to register t=
he
> PMU: arm_csite_pmu<numeric id>. Certainly the "csite" needs to change as
> well =F0=9F=98=8A. Another example like ARM CCI PMU uses device name "ARM=
-CCI PMU",
> but it is registered to perf subsystem as "CCI_400" or "CCI_500".
>

Agreed, those are details we can discuss once you post with all the
maintainers involved.

> If there is no objection, I can post update to this patch and go ahead wi=
th
> "arm-coresight-pmu" for the device name.

Sure as I mentioned above that should be fine. I will then raise it with
the maintainers how we managed to labelled the spec to confuse it with other
components. I prefer whatever we add must be easy to identify and doesn't
conflict with existing PMUs(like ARM CPU PMUs, or the coresight ETM PMUs,
..etc)

In short, just post the driver the way you prefer and let us start the
discussion there.

-- =

Regards,
Sudeep
--===============0639254112643121245==--

