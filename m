Content-Type: multipart/mixed; boundary="===============5717627205707283705=="
MIME-Version: 1.0
From: gengdongjiu <gengdongjiu at huawei.com>
Subject: Re: [Devel] [PATCH v5 2/2] acpi: apei: Add SEI notification type
 support for ARMv8
Date: Wed, 18 Oct 2017 15:04:15 +0000
Message-ID: <0184EA26B2509940AA629AE1405DD7F2016AB428@DGGEMA503-MBX.china.huawei.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5717627205707283705==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

HI James,
   Thanks for the mail, for your some question, I think that is how to use =
NOTIFY_SEI, this patch just add a API to other user calling(such as KVM), b=
ecause KVM needs to use that.

> =

> Hi Dongjiu Geng,
> =

> On 17/10/17 09:02, Dongjiu Geng wrote:
> > ARMv8.2 requires implementation of the RAS extension, in this
> > extension it adds SEI(SError Interrupt) notification type, this patch
> > adds new GHES error source SEI handling functions.
> =

> This paragraph is merging two things that aren't related.
> The 'ARM v8.2 architecture extensions' have some RAS bits, which if your =
CPU implements v8.2 are required.
> =

> ACPIv6.1 added NOTIFY_SEI as a notification type for ARMv8 systems.
> =

> This patch adds a GHES function for NOTIFY_SEI. Please leave the CPU RAS =
extensions out of it.
> =

> =

> > Because this error source parsing and handling methods are similar
> > with the SEA. So share some SEA handling functions with the SEI
> >
> > Expose one API ghes_notify_abort() to external users. External modules
> > can call this exposed API to parse and handle the SEA or SEI.
> =

> This series doesn't add a caller/user for this new API, so why do we need=
 to do this now?

In RAS virtualization patch, for SEI, firstly I does not call APEI GHES dri=
ver, you suggest me calling APEI code. So I add NOTIFY_SEI support.


> =

> (I still haven't had a usable answer for 'what does your firmware do when=
 SError is masked', but I'll go beat that drum on the other thread).
> =

> =

> More important for the APEI code is: How do SEA and SEI interact?

The SEA and SEI can interact each other, in some case, it should be allow n=
esting

maybe we need to consider a better way. But I think the method should be im=
plemented in another place, not in this pace.
That is say, it is implemented in the caller or user. =


this patch just add a NOTIFY_SEI support, so that other user can call such =
as KVM.

> =

> As far as I can see they can both interrupt each other, which isn't somet=
hing the single in_nmi() path in APEI can handle. I thinks we should
> fix this first.
> (I'll try and polish my RFC that had a stab at that...)

Your fixing method use some lock? but I think it is not a good method. For =
example, when we handling SEI, then happen SEA, I think we need to handle t=
he SEA immediately instead of waiting SEI finish handling.


> =

> =

> SEA gets away with a lot of things because its synchronous. SEI isn't. Xi=
e XiuQi pointed to the memory_failure_queue() code. We can use
> this directly from SEA, but not SEI. (what happens if an SError arrives w=
hile we are queueing memory_failure work from an IRQ).

From my understand, xiexiuqi's code mainly solve =

memory_failure() execution later than SEA/SEI handling, memory_failure() ex=
ecution is in a workqueue process context=EF=BC=8Cnot in a SEA/SEI context.=
 They are in different contex.
For example, after the SEA/SEI handing finished, the memory_failure() workq=
ueue does not start running=E3=80=82so he add a flag to make sure this work=
queue can be timely scheduled.

For your question: "what happens if an SError arrives while we are queueing=
 memory_failure work from an IRQ",
I think SEA have the same issue, For example, when we are queueing memory_f=
ailure work from an IRQ, it happen SEA.
Do you mean xiexiuqi's patches can solve this problem?

> =

> The one that scares me is the trace-point reporting stuff. What happens i=
f an SError arrives while we are enabling a trace point? (these are
> static-keys right?)
> =

> =

> I don't think we can just plumb SEI in like this and be done with it.
> (I'm looking at teasing out the estatus cache code from being x86:NMI onl=
y. This way we solve the same 'cant do this from NMI context'
> with the same code'.)

Do you mean like this for caller/user to make sure it is from NMI context? =
 Or do something in the GHES driver code to make sure it is in NMI context.

.............................
	if (IS_ENABLED(CONFIG_ACPI_APEI_SEI)) {
		if (interrupts_enabled(regs))
			nmi_enter();

		ret =3D ghes_notify_seI();

		if (interrupts_enabled(regs))
			nmi_exit();
	}
..........................

> =

> =

> Thanks,
> =

> James
> =

> =

> =

> boring nits below:
> =

> > Note: For the SEI(SError Interrupt), it is asynchronous external
> > abort, the error address recorded by firmware may be not accurate.
> > If not accurate, EL3 firmware needs to identify the address to a
> > invalid value.
> =

> This paragraph keeps cropping up. Who expects an address with an SError?
> We don't get one for IRQs, but that never needs stating.

I do not check more code about the IRQ. Do you mean there is no address for=
 IRQ?
If so,  why you have question "what happens if an SError arrives while we a=
re queueing memory_failure work from an IRQ"?
Only when have address, the memory_failure work can be called.


> =

> =

> > Cc: Borislav Petkov <bp(a)suse.de>
> > Cc: James Morse <james.morse(a)arm.com>
> > Signed-off-by: Dongjiu Geng <gengdongjiu(a)huawei.com>
> > Tested-by: Tyler Baicar <tbaicar(a)codeaurora.org>
> =

> > Tested-by: Dongjiu Geng <gengdongjiu(a)huawei.com>
> =

> (It's expected you test your own code)
> =

> =

> =

> > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c index
> > 2509e4f..c98c1b3 100644
> > --- a/arch/arm64/mm/fault.c
> > +++ b/arch/arm64/mm/fault.c
> > @@ -585,7 +585,7 @@ static int do_sea(unsigned long addr, unsigned int =
esr, struct pt_regs *regs)
> >  		if (interrupts_enabled(regs))
> >  			nmi_enter();
> >
> > -		ret =3D ghes_notify_sea();
> > +		ret =3D ghes_notify_abort(ACPI_HEST_NOTIFY_SEA);
> >
> >  		if (interrupts_enabled(regs))
> >  			nmi_exit();
> > @@ -682,7 +682,7 @@ int handle_guest_sea(phys_addr_t addr, unsigned int=
 esr)
> >  	int ret =3D -ENOENT;
> >
> >  	if (IS_ENABLED(CONFIG_ACPI_APEI_SEA))
> > -		ret =3D ghes_notify_sea();
> > +		ret =3D ghes_notify_abort(ACPI_HEST_NOTIFY_SEA);
> >
> >  	return ret;
> >  }
> > diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
> > index de14d49..47fcb0c 100644
> > --- a/drivers/acpi/apei/Kconfig
> > +++ b/drivers/acpi/apei/Kconfig
> > @@ -54,6 +54,21 @@ config ACPI_APEI_SEA
> >  	  option allows the OS to look for such hardware error record, and
> >  	  take appropriate action.
> >
> > +config ACPI_APEI_SEI
> > +	bool "APEI Asynchronous SError Interrupt logging/recovering support"
> > +	depends on ARM64 && ACPI_APEI_GHES
> > +	default y
> > +	help
> > +	  This option should be enabled if the system supports
> > +	  firmware first handling of SEI (asynchronous SError interrupt).
> > +
> > +	  SEI happens with asynchronous external abort for errors on device
> > +	  memory reads on ARMv8 systems. If a system supports firmware first
> > +	  handling of SEI, the platform analyzes and handles hardware error
> > +	  notifications from SEI, and it may then form a HW error record for
> > +	  the OS to parse and handle. This option allows the OS to look for
> > +	  such hardware error record, and take appropriate action.
> > +
> >  config ACPI_APEI_MEMORY_FAILURE
> >  	bool "APEI memory error recovering support"
> >  	depends on ACPI_APEI && MEMORY_FAILURE diff --git
> > a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c index
> > 3eee30a..24b4233 100644
> > --- a/drivers/acpi/apei/ghes.c
> > +++ b/drivers/acpi/apei/ghes.c
> > @@ -815,43 +815,67 @@ static struct notifier_block ghes_notifier_hed =
=3D
> > {
> >
> >  #ifdef CONFIG_ACPI_APEI_SEA
> >  static LIST_HEAD(ghes_sea);
> > +#endif
> > +
> > +#ifdef CONFIG_ACPI_APEI_SEI
> > +static LIST_HEAD(ghes_sei);
> > +#endif
> >
> > +#if defined(CONFIG_ACPI_APEI_SEA) || defined(CONFIG_ACPI_APEI_SEI)
> >  /*
> > - * Return 0 only if one of the SEA error sources successfully
> > reported an error
> > - * record sent from the firmware.
> > + * Return 0 only if one of the SEA or SEI error sources successfully
> > + * reported an error record sent from the firmware.
> >   */
> > -int ghes_notify_sea(void)
> > +int ghes_notify_abort(u8 type)
> >  {
> >  	struct ghes *ghes;
> > +	struct list_head *head =3D NULL;
> >  	int ret =3D -ENOENT;
> >
> > -	rcu_read_lock();
> > -	list_for_each_entry_rcu(ghes, &ghes_sea, list) {
> > -		if (!ghes_proc(ghes))
> > -			ret =3D 0;
> =

> > +	if (type =3D=3D ACPI_HEST_NOTIFY_SEA)
> > +		head =3D &ghes_sea;
> > +	else if (type =3D=3D ACPI_HEST_NOTIFY_SEI)
> > +		head =3D &ghes_sei;
> =

> Surely if I only have one of CONFIG_ACPI_APEI_SE{A,I} this can't be compi=
led.
> =

> =

> > +
> > +	if (head) {
> > +		rcu_read_lock();
> > +		list_for_each_entry_rcu(ghes, head, list) {
> > +			if (!ghes_proc(ghes))
> > +				ret =3D 0;
> > +		}
> > +		rcu_read_unlock();
> >  	}
> > -	rcu_read_unlock();
> >  	return ret;
> >  }
> >
> > -static void ghes_sea_add(struct ghes *ghes)
> > +static void ghes_abort_add(struct ghes *ghes)
> >  {
> > -	mutex_lock(&ghes_list_mutex);
> > -	list_add_rcu(&ghes->list, &ghes_sea);
> > -	mutex_unlock(&ghes_list_mutex);
> > +	struct list_head *head =3D NULL;
> > +	u8 notify_type =3D ghes->generic->notify.type;
> > +
> =

> > +	if (notify_type =3D=3D ACPI_HEST_NOTIFY_SEA)
> > +		head =3D &ghes_sea;
> > +	else if (notify_type =3D=3D ACPI_HEST_NOTIFY_SEI)
> > +		head =3D &ghes_sei;
> =

> And here.
> =

> =

> > +
> > +	if (head) {
> > +		mutex_lock(&ghes_list_mutex);
> > +		list_add_rcu(&ghes->list, head);
> > +		mutex_unlock(&ghes_list_mutex);
> > +	}
> >  }
> >
> > -static void ghes_sea_remove(struct ghes *ghes)
> > +static void ghes_abort_remove(struct ghes *ghes)
> >  {
> >  	mutex_lock(&ghes_list_mutex);
> >  	list_del_rcu(&ghes->list);
> >  	mutex_unlock(&ghes_list_mutex);
> >  	synchronize_rcu();
> >  }
> > -#else /* CONFIG_ACPI_APEI_SEA */
> > -static inline void ghes_sea_add(struct ghes *ghes) { } -static inline
> > void ghes_sea_remove(struct ghes *ghes) { } -#endif /*
> > CONFIG_ACPI_APEI_SEA */
> > +#else
> > +static inline void ghes_abort_add(struct ghes *ghes) { } static
> > +inline void ghes_abort_remove(struct ghes *ghes) { } #endif
> >
> >  #ifdef CONFIG_HAVE_ACPI_APEI_NMI
> >  /*
> > @@ -1084,6 +1108,13 @@ static int ghes_probe(struct platform_device *gh=
es_dev)
> >  			goto err;
> >  		}
> >  		break;
> > +	case ACPI_HEST_NOTIFY_SEI:
> > +		if (!IS_ENABLED(CONFIG_ACPI_APEI_SEI)) {
> > +			pr_warn(GHES_PFX "Generic hardware error source: %d notified via SE=
I is not supported!\n",
> > +				generic->header.source_id);
> > +		goto err;
> > +	}
> > +	break;
> >  	case ACPI_HEST_NOTIFY_NMI:
> >  		if (!IS_ENABLED(CONFIG_HAVE_ACPI_APEI_NMI)) {
> >  			pr_warn(GHES_PFX "Generic hardware error source: %d notified via
> > NMI interrupt is not supported!\n", @@ -1153,7 +1184,8 @@ static int gh=
es_probe(struct platform_device *ghes_dev)
> >  		break;
> >
> >  	case ACPI_HEST_NOTIFY_SEA:
> > -		ghes_sea_add(ghes);
> > +	case ACPI_HEST_NOTIFY_SEI:
> > +		ghes_abort_add(ghes);
> >  		break;
> >  	case ACPI_HEST_NOTIFY_NMI:
> >  		ghes_nmi_add(ghes);
> > @@ -1206,7 +1238,8 @@ static int ghes_remove(struct platform_device *gh=
es_dev)
> >  		break;
> >
> >  	case ACPI_HEST_NOTIFY_SEA:
> > -		ghes_sea_remove(ghes);
> > +	case ACPI_HEST_NOTIFY_SEI:
> > +		ghes_abort_remove(ghes);
> >  		break;
> >  	case ACPI_HEST_NOTIFY_NMI:
> >  		ghes_nmi_remove(ghes);
> > diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h index
> > 9061c5c..ec6f4ba 100644
> > --- a/include/acpi/ghes.h
> > +++ b/include/acpi/ghes.h
> > @@ -118,6 +118,6 @@ static inline void *acpi_hest_get_next(struct acpi_=
hest_generic_data *gdata)
> >  	     (void *)section - (void *)(estatus + 1) < estatus->data_length; \
> >  	     section =3D acpi_hest_get_next(section))
> >
> > -int ghes_notify_sea(void);
> > +int ghes_notify_abort(u8 type);
> >
> >  #endif /* GHES_H */
> >


--===============5717627205707283705==--

