Content-Type: multipart/mixed; boundary="===============4382419505907076551=="
MIME-Version: 1.0
From: Besar Wicaksono <bwicaksono at nvidia.com>
Subject: [Devel] Re: [PATCH 2/2] ACPI: ARM Performance Monitoring Unit Table
 (APMT) initial support
Date: Wed, 04 May 2022 22:08:39 +0000
Message-ID: <
 <SN6PR12MB4719E05A6BC7CAA2C00F35EFA0C39@SN6PR12MB4719.namprd12.prod.outlook.com>>
In-Reply-To: 20220504182633.a3mwuiohfqtjvpep@bogus
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4382419505907076551==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sudeep,

> Any particular reason why you would like to rush and push this without
> the actual driver to probe the device being added here ?

I plan to have two patch series, one for ACPI patch (this patch) and one fo=
r driver patch.
My understanding is the driver patch will depend on this patch, but not the=
 other way. So, I thought it would be better to get this patch approved fir=
st.
However, if it helps the review of this patch, I am hoping to post the driv=
er patch by end of the week and will CC you on that one.

> I really don't prefer this name:
> 1. arm-coresight-pmu is much better than "csite". I see the short form
>    used elsewhere in the kernel is just "cs" as in cs_etm,...etc
> 2. Since APMT is more generic than just coresight(I understand coresight
>    was the initial motivation for the generic specification) and also
>    the type list seem to cover memory controller, SMMU,..etc, does
>    it make sense to call it "arm-generic-pmu" or something similar.

Between these two, I would prefer arm-coresight-pmu just to anticipate anot=
her standard in the future from ARM.
The APMT, to my understanding, is applicable only to CoreSight based PMUs. =
Using "coresight" as part of the device name is reasonable.

> Not sure if the same device name will be re-used or PMUs can be registered
> with different name under perf subsystem, but the name matters for the us=
er
> space tools and decoders. They may use the name or type information to an=
alyse
> the data samples.
>
> So it is better to wait for all those discussion as part of the driver
> upstreaming before you use this device name unless we are absolutely sure
> the PMUs can be registered with different names in the driver(which could
> be possible, I just don't know)
>
> Apart from this name, I am OK with the changes here and happy to ack if it
> is OK to merge this without any driver to probe this device yet.

I believe using a different name to register the PMU is possible.
In the current driver patch, we use a different name format to register the=
 PMU: arm_csite_pmu<numeric id>. Certainly the "csite" needs to change as w=
ell =F0=9F=98=8A
Another example like ARM CCI PMU uses device name "ARM-CCI PMU", but it is =
registered to perf subsystem as "CCI_400" or "CCI_500".

If there is no objection, I can post update to this patch and go ahead with=
 "arm-coresight-pmu" for the device name.

Regards,
Besar


--===============4382419505907076551==--

