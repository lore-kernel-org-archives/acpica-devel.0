Content-Type: multipart/mixed; boundary="===============6624037823598127972=="
MIME-Version: 1.0
From: gengdongjiu <gengdongjiu at huawei.com>
Subject: Re: [Devel] [PATCH v9 3/7] acpi: apei: Add SEI notification type
 support for ARMv8
Date: Tue, 23 Jan 2018 17:23:29 +0800
Message-ID: <168c3f61-0d11-13a4-c383-1f6a97d0ef37@huawei.com>
In-Reply-To: 5A663DEC.8080804@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6624037823598127972==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 2018/1/23 3:39, James Morse wrote:
> Hi Dongjiu Geng,
> =

> (versions of patches 1,2 and 4 have been queued by Catalin)
> =

> (Nit 'ACPI / APEI:' is the normal subject prefix for ghes.c, this helps t=
he
> maintainers know which patches they need to pay attention to when you are
> touching multiple trees)
> =

> On 06/01/18 16:02, Dongjiu Geng wrote:
>> ARMv8.2 requires implementation of the RAS extension.
> =

>> In
>> this extension, it adds SEI(SError Interrupt) notification
>> type, this patch adds new GHES error source SEI handling
>> functions. =

> =

> This reads as if this patch is handling SError RAS notifications generate=
d by a
> CPU with the RAS extensions. These are about CPU->Software notifications.=
 APEI
> and GHES are a firmware first mechanism which is Software->Software.
> Reading the v8.2 documents won't help anyone with the APEI/GHES code.
> =

> Please describe this from the ACPI view, "ACPI 6.x adds support for NOTIF=
Y_SEI
> as a GHES notification mechanism... ",  its up to the arch code to spot a=
 v8.2
> RAS Error based on the cpu caps.Ok, I will modify it.

> =

> =

>> This error source parsing and handling method
>> is similar with the SEA.
> =

> There are problems with doing this:
> =

> Oct. 18, 2017, 10:26 a.m. James Morse wrote:
> | How do SEA and SEI interact?
> |
> | As far as I can see they can both interrupt each other, which isn't som=
ething
> | the single in_nmi() path in APEI can handle. I thinks we should fix this
> | first.
> =

> [..]
> =

> | SEA gets away with a lot of things because its synchronous. SEI isn't. =
Xie
> | XiuQi pointed to the memory_failure_queue() code. We can use this direc=
tly
> | from SEA, but not SEI. (what happens if an SError arrives while we are
> | queueing memory_failure work from an IRQ).
> |
> | The one that scares me is the trace-point reporting stuff. What happens=
 if an
> | SError arrives while we are enabling a trace point? (these are static-k=
eys
> | right?)
> |
> |  I don't think we can just plumb SEI in like this and be done with it.
> |  (I'm looking at teasing out the estatus cache code from being x86:NMI =
only.
> |  This way we solve the same 'cant do this from NMI context' with the sa=
me
> |  code'.)
> =

> =

> I will post what I've got for this estatus-cache thing as an RFC, its not=
 ready
> to be considered yet.Yes, I know you are dong that. Your serial's patch w=
ill consider all above things, right?
If your patch can be consider that, this patch can based on your patchset. =
thanks.

> =

> =

>> Expose API ghes_notify_sei() to external users. External
>> modules can call this exposed API to parse APEI table and
>> handle the SEI notification.
> =

> external modules? You mean called by the arch code when it gets this NOTI=
FY_SEI?
yes, called by kernel ARCH code, such as below, I remember I have discussed=
 with you.

 asmlinkage void do_serror(struct pt_regs *regs, unsigned int esr)
 {
 	nmi_enter();


	if (!ghes_notify_sei())
		return;



 	/* non-RAS errors are not containable */
 	if (!arm64_is_ras_serror(esr) || arm64_is_fatal_ras_serror(regs, esr))
 		arm64_serror_panic(regs, esr);

	nmi_exit();
}

> =

> =

> Thanks,
> =

> James
> =

> .
> =



--===============6624037823598127972==--

