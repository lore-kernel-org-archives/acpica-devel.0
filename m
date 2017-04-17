Content-Type: multipart/mixed; boundary="===============2171788666494619265=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: Export mutex functions
Date: Mon, 17 Apr 2017 23:35:26 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CE93CD2@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 146dd98c-b9b6-70c9-ef9e-be11e6e2e323@roeck-us.net
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2171788666494619265==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> From: linux-acpi-owner(a)vger.kernel.org [mailto:linux-acpi-owner(a)vger.=
kernel.org] On Behalf Of Guenter
> Roeck
> Subject: Re: [PATCH] ACPICA: Export mutex functions
> =

> On 04/17/2017 02:48 AM, Zheng, Lv wrote:
> > Hi,
> >
> >> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Zheng, Lv
> >> Sent: Monday, April 17, 2017 5:40 PM
> >> To: Guenter Roeck <linux(a)roeck-us.net>; Moore, Robert <robert.moore(=
a)intel.com>
> >> Cc: linux-acpi(a)vger.kernel.org; devel(a)acpica.org; Wysocki, Rafael =
J <rafael.j.wysocki(a)intel.com>;
> >> linux-kernel(a)vger.kernel.org
> >> Subject: Re: [Devel] [PATCH] ACPICA: Export mutex functions
> >>
> >> Hi,
> >>
> >>> From: Guenter Roeck [mailto:linux(a)roeck-us.net]
> >>> Subject: Re: [PATCH] ACPICA: Export mutex functions
> >>>
> >>> On Wed, Apr 12, 2017 at 03:29:55PM +0000, Moore, Robert wrote:
> >>>> The ACPICA mutex functions are based on the host OS functions, so th=
ey don't really buy you
> >> anything.
> >>> You should just use the native Linux functions.
> >>>>
> >>>
> >>> You mean they don't really acquire the requested ACPI mutex,
> >>> and the underlying DSDT which declares and uses the mutex
> >>> just ignores if the mutex was acquired by acpi_acquire_mutex() ?
> >>>
> >>> To clarify: You are saying that code such as
> >>>
> >>> 	acpi_status status;
> >>>
> >>> 	status =3D acpi_acquire_mutex(NULL, "\\_SB.PCI0.SBRG.SIO1.MUT0", 0x1=
0);
> >>> 	if (ACPI_FAILURE(status)) {
> >>> 		pr_err("Failed to acquire ACPI mutex\n");
> >>> 		return -EBUSY;
> >>> 	}
> >>
> >> Why do you need to access \_SB.PCI0.SBRG.SIO1.MUT0?
> >> OSPM should only invoke entry methods predefined by ACPI spec or whate=
ver specs.
> >> There shouldn't be any needs that a driver acquires an arbitrary AML m=
utex.
> >> You do not seem to have justified the usage model, IMO.
> >>
> >> Thanks
> >> Lv
> >>
> >>> 	...
> >>>
> >>> when used in conjunction with
> >>>
> >>> 	...
> >>> 	Mutex (MUT0, 0x00)
> >>> 	Method (ENFG, 1, NotSerialized)
> >>> 	{
> >>> 		Acquire (MUT0, 0x0FFF)
> >>> 		...
> >>> 	}
> >>>
> >>> doesn't really provide exclusive access to the resource(s) protected
> >>> by MUT0, even if acpi_acquire_mutex() returns ACPI_SUCCESS ?
> >
> > IMO, the use case you are talking about is commonly seen in an operatio=
n region access code.
> > Most likely, we'll prepare a driver own lock, and use it for both drive=
r initiated accesses and AML
> initiated accesses.
> >
> > Finally, how can the driver writer know which mutex he should acquire?
> > AML mutexes should be invisible to the OS (except the global lock).
> >
> In my experimental code I am using DMI to determine the platform and prov=
ide
> the mutex name to the kernel driver needing it.
> =

> > So I'm really confused by your argument.
> > Please explain in details - what the resource is.
> >
> =

> Super-IO ports 0x2e, 0x2f. If you look through the Linux kernel, and sear=
ch for
> superio_enter(), you'll see where that address space is used (for the mos=
t part
> in watchdog, hwmon, and gpio drivers).
> =

> You are correct, the resource is in operation region access code.
> =

> Are you saying that the mutex (and other mutexes) may not be accessed fro=
m the OS,
> ie that the respective ACPI mutex functions are not really supposed to be=
 available
> for the OS ?
> =


First, the super-IO access driver itself should make sure that Super-IO por=
ts accesses are atomic.
It may lock around a transactional access including read-modify-write.
Let me call it L(SIO)/U(SIO).

Then the operation region driver need to lock around an entire AML opregion=
 field read/write initiated by Store().
It may include several read-modify-write transactions.
Let me call it L(SOR)/U(SOR).
There might be one problem here as ACPICA cannot pass an entire AML opregio=
n access to the address space callback once.
That might be the root cause of your problem.
But may not affect your use case.
You should know this better than me.
In case of EC driver (drivers/acpi/ec.c), I noticed that it is safe without=
 improve this in ACPICA.
However for other operation regions, I have no idea.
Maybe you can tell me if we need to make this improvement in ACPICA.

Then the mutexes provided in AML is meant serialize accesses in AML.
Let me call it L(SMX)/U(SMX).
Not for the purpose to replace the SIO/SOR.

So from the AML point of view, the entire functionality may be performed in=
 this way:
L(SMX)
  Read(some requests)
    L(SOR)
      L(SIO)
        Read(super IO)
      U(SIO)
    U(SOR)
  Write(some responses)
    L(SOR)
      L(SIO)
        Read(super IO)
      U(SIO)
      L(SIO)
        Read(super IO)
        Modify
        Write(super IO)
      U(SIO)
      ...
    U(SOR)
U(SMX)

It should work without allowing the OS driver to access the mutex provided =
in AML.
IMO, that could be the original design aspect for AML mutexes.

Thanks and best regards
Lv

> Thanks,
> Guenter
> =

> > Thanks
> > Lv
> >
> >
> >>>
> >>> Outch. Really ?
> >>>
> >>> Thanks,
> >>> Guenter
> >>>
> >>>>
> >>>>> -----Original Message-----
> >>>>> From: Guenter Roeck [mailto:linux(a)roeck-us.net]
> >>>>> Sent: Wednesday, April 12, 2017 8:13 AM
> >>>>> To: Moore, Robert <robert.moore(a)intel.com>; Zheng, Lv
> >>>>> <lv.zheng(a)intel.com>; Wysocki, Rafael J <rafael.j.wysocki(a)intel=
.com>;
> >>>>> Len Brown <lenb(a)kernel.org>
> >>>>> Cc: linux-acpi(a)vger.kernel.org; devel(a)acpica.org; linux-
> >>>>> kernel(a)vger.kernel.org; Guenter Roeck <linux(a)roeck-us.net>
> >>>>> Subject: [PATCH] ACPICA: Export mutex functions
> >>>>>
> >>>>> Mutex functions may be needed by drivers. Examples are accesses to
> >>>>> Super-IO SIO registers (0x2e/0x2f or 0x4e/0x4f) or Super-IO
> >>>>> environmental monitor registers, both which may also be accessed th=
rough
> >>>>> DSDT.
> >>>>>
> >>>>> Signed-off-by: Guenter Roeck <linux(a)roeck-us.net>
> >>>>> ---
> >>>>>  drivers/acpi/acpica/utxfmutex.c | 2 ++
> >>>>>  1 file changed, 2 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/acpi/acpica/utxfmutex.c
> >>>>> b/drivers/acpi/acpica/utxfmutex.c index c016211c35ae..5d20581f4b2f
> >>>>> 100644
> >>>>> --- a/drivers/acpi/acpica/utxfmutex.c
> >>>>> +++ b/drivers/acpi/acpica/utxfmutex.c
> >>>>> @@ -150,6 +150,7 @@ acpi_acquire_mutex(acpi_handle handle, acpi_str=
ing
> >>>>> pathname, u16 timeout)
> >>>>>  	status =3D acpi_os_acquire_mutex(mutex_obj->mutex.os_mutex, timeo=
ut);
> >>>>>  	return (status);
> >>>>>  }
> >>>>> +ACPI_EXPORT_SYMBOL(acpi_acquire_mutex)
> >>>>>
> >>>>>
> >>>>> /******************************************************************=
*****
> >>>>> ********
> >>>>>   *
> >>>>> @@ -185,3 +186,4 @@ acpi_status acpi_release_mutex(acpi_handle hand=
le,
> >>>>> acpi_string pathname)
> >>>>>  	acpi_os_release_mutex(mutex_obj->mutex.os_mutex);
> >>>>>  	return (AE_OK);
> >>>>>  }
> >>>>> +ACPI_EXPORT_SYMBOL(acpi_release_mutex)
> >>>>> --
> >>>>> 2.7.4
> >>>>
> >> _______________________________________________
> >> Devel mailing list
> >> Devel(a)acpica.org
> >> https://lists.acpica.org/mailman/listinfo/devel
> >
> =

> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo(a)vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--===============2171788666494619265==--

