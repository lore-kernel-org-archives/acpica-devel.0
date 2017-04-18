Content-Type: multipart/mixed; boundary="===============7309123356100621003=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: Export mutex functions
Date: Tue, 18 Apr 2017 07:06:24 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CE93F6A@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 0a9550c7-f36b-feb3-f83c-7b868cbf2e3a@roeck-us.net
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7309123356100621003==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> From: Guenter Roeck [mailto:linux(a)roeck-us.net]
> Subject: Re: [PATCH] ACPICA: Export mutex functions
> =

> On 04/17/2017 04:53 PM, Zheng, Lv wrote:
> > Hi,
> >
> >> From: Guenter Roeck [mailto:linux(a)roeck-us.net]
> >> Subject: Re: [PATCH] ACPICA: Export mutex functions
> >>
> >> On Mon, Apr 17, 2017 at 11:29:38PM +0200, Rafael J. Wysocki wrote:
> >>> On Mon, Apr 17, 2017 at 11:03 PM, Guenter Roeck <linux(a)roeck-us.net=
> wrote:
> >>>> On Mon, Apr 17, 2017 at 08:40:38PM +0000, Moore, Robert wrote:
> >>>>>
> >>>>>
> >>>>>> From: Guenter Roeck [mailto:linux(a)roeck-us.net]
> >>>>>> Subject: Re: [PATCH] ACPICA: Export mutex functions
> >>>>>>
> >>>>>> On Mon, Apr 17, 2017 at 07:27:37PM +0000, Moore, Robert wrote:
> >>>>>>>
> >>>>>>>> From: Moore, Robert
> >>>>>>>> Subject: RE: [PATCH] ACPICA: Export mutex functions
> >>>>>>>>
> >>>>>>>> There is a model for the drivers to directly acquire an AML mutex
> >>>>>>>> object. That is why the acquire/release public interfaces were a=
dded
> >>>>>>>> to ACPICA.
> >>>>>>>>
> >>>>>>>> I forget all of the details, but the model was developed with MS=
 and
> >>>>>>>> others during the ACPI 6.0 timeframe.
> >>>>>>>>
> >>>>>>>>
> >>>>>>> [Moore, Robert]
> >>>>>>>
> >>>>>>>
> >>>>>>> Here is the case where the OS may need to directly acquire an AML
> >>>>>> mutex:
> >>>>>>>
> >>>>>>> From the ACPI spec:
> >>>>>>>
> >>>>>>> 19.6.2 Acquire (Acquire a Mutex)
> >>>>>>>
> >>>>>>> Note: For Mutex objects referenced by a _DLM object, the host OS =
may
> >>>>>> also contend for ownership.
> >>>>>>>
> >>>>>> From the context in the dsdt, and from description of expected use=
 cases
> >>>>>> for _DLM objects I can find, this is what the mutex is used for (to
> >>>>>> serialize access to a resource on a low pin count serial interconn=
ect,
> >>>>>> aka LPC).
> >>>>>>
> >>>>>> What does that mean in practice ? That I am not supposed to use it
> >>>>>> because it doesn't follow standard ACPI mutex declaration rules ?
> >>>>>>
> >>>>>> Thanks,
> >>>>>> Guenter
> >>>>>>
> >>>>>>>
> >>>>> [Moore, Robert]
> >>>>>
> >>>>> I'm not an expert on the _DLM method, but I would point you to the =
description section in the
> >> ACPI spec, 5.7.5 _DLM (DeviceLock Mutex).
> >>>>>
> >>>>
> >>>> I did. However, not being an ACPI expert, that doesn't tell me anyth=
ing.
> >>>
> >>> Basically, if the kernel and AML need to access a device concurrently,
> >>> there should be a _DLM object under that device in the ACPI tables.
> >>> In that case it is expected to return a list of (AML) mutexes that can
> >>> be acquired by the kernel in order to synchronize device access with
> >>> respect to AML (and for each mutex it may also return a description of
> >>> the specific resources to be protected by it).
> >>>
> >>> Bottom line: without _DLM, the kernel cannot synchronize things with
> >>> respect to AML properly, because it has no information how to do that
> >>> then.
> >>
> >> That is all quite interesting. I do see the mutex in question used on =
various
> >> motherboards from various vendors (I checked boards from Gigabyte, MSI=
, and
> >> Intel). Interestingly, the naming seems to be consistent - it is alway=
s named
> >> "MUT0". For the most part, it seems to be available on more recent
> >> motherboards; older motherboards tend to use the resource without lock=
ing.
> >> However, I don't see any mention of "_DLM" in any of the DSDTs.
> >>
> >
> > OK, then you might be having problems in your opregion driver.
> >
> >> At the same time, access to ports 0x2e/0x2f is widely used in the kern=
el.
> >> As mentioned before, it is used in watchdog, hardware monitoring, and =
gpio
> >> drivers, but also in parallel port and infrared driver code. Effective=
ly
> >> that means that all this code is inherently unsafe on systems with ACPI
> >> support.
> >>
> >> I had thought about implementing a set of utility functions to make th=
e kernel
> >> code safer to use if the mutex is found to exist.
> >
> > As what you've mentioned, there are already lots of parallel accesses i=
n kernel without enabling
> ACPI.
> > Are these accesses mutually exclusive (safe)?
> =

> In-kernel, yes (using request_muxed_region). Against ACPI, no.
> =

> > If so, why do you need to invent a new synchronization mechanism?
> >
> =

> Because I am seeing a problem with the current code (more specifically,
> with the it87 hwmon driver) on new Gigabyte boards.

I checked superio_enter()/superio_exit(), IMO, the mutual exclusion
might be handled using 1 of the following 2 solutions:

1. _DLM, then you can find superio related mutex from _DLM and
   acquire/release it in superio_enter()/superio_exit().
   You really need a set of new APIs to acquire the _DLM related mutex.
   If you don't have _DLM in your DSDT, directly exporting ACPICA mutex
   functions seem to be a reasonable solution.
2. Normally, AML developer should abstract superio accesses into customized
   opregion, then you can prepare a superio opregion driver.

> =

> >> Right now I wonder, though,
> >> if such code would have a chance to be accepted. Any thoughts on that ?
> >
> > Is that possible to make it safe in the opregion driver?
> >
> =

> Sorry, I don't think I understand what you mean with "opregion driver".
> Do you refer to the drivers accessing the memory region in question,
> or in other words replicating the necessary code in every driver accessing
> that region ? Sure, I can do that, if that is the preferred solution;
> I have no problem with that. However, that would require exporting
> the ACPI mutex functions. My understanding is that you are opposed to
> exporting those, so I assume that is not what you refer to.
> Can you clarify ?

I mean solution 2.
From it87_find() I really couldn't see a possibility to convert superio
accesses into opregions. Could you paste some example superio access AML
code from your DSDT here.

Thanks and best regards
Lv

--===============7309123356100621003==--

