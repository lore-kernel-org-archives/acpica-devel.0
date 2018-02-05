Content-Type: multipart/mixed; boundary="===============4576852335476914870=="
MIME-Version: 1.0
From: gengdongjiu <gengdongjiu at huawei.com>
Subject: Re: [Devel] [PATCH v9 3/7] acpi: apei: Add SEI notification type
 support for ARMv8
Date: Mon, 05 Feb 2018 11:24:26 +0000
Message-ID: <0184EA26B2509940AA629AE1405DD7F201AC71DE@DGGEMA503-MBS.china.huawei.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4576852335476914870==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

[...]
> =

> > Yes, I know you are dong that. Your serial's patch will consider all ab=
ove
> things, right?
> =

> Assuming I got it right, yes. It currently makes the race Xie XiuQi spott=
ed worse,
> which I want to fix too. (details on the cover letter)

Ok.

> =

> =

> > If your patch can be consider that, this patch can based on your patchs=
et.
> thanks.
> =

> I'd like to pick these patches onto the end of that series, but first I w=
ant to
> know what NOTIFY_SEI means for any OS. The ACPI spec doesn't say, and
> because its asynchronous, route-able and mask-able, there are many more
> corners than NOTFIY_SEA.
> =

> This thing is a notification using an emulated SError exception. (emulated
> because physical-SError must be routed to EL3 for firmware-first, and
> virtual-SError belongs to EL2).
> =

> Does your firmware emulate SError exactly as the TakeException() pseudo c=
ode
> in the Arm-Arm?

Yes, it is.

> Is the emulated SError routed following the routing rules for HCR_EL2.{AM=
O,
> TGE}?

Yes, it is.

> What does your firmware do when it wants to emulate SError but its masked?
> (e.g.1: The physical-SError interrupted EL2 and the SPSR shows EL2 had
> PSTATE.A  set.
>  e.g.2: The physical-SError interrupted EL2 but HCR_EL2 indicates the
> emulated  SError should go to EL1. This effectively masks SError.)

Currently we does not consider much about the mask status(SPSR).
I remember that you ever suggested firmware should reboot if the mask statu=
s is set(SPSR), right?
I ever suggest our firmware team to evaluate that, but there is no response.

I CC "liu jun" <liujun88(a)hisilicon.com> who is our UEFI firmware Architec=
t, if you have firmware requirements, you can
raise again.

> =

> Answers to these let us determine whether a bug is in the firmware or the
> kernel. If firmware is expecting the OS to do something special, I'd like=
 to know
> about it from the beginning!

I know your meaning, thanks for raising it again.

> =

> =

> >>> Expose API ghes_notify_sei() to external users. External modules can
> >>> call this exposed API to parse APEI table and handle the SEI
> >>> notification.
> >>
> >> external modules? You mean called by the arch code when it gets this
> NOTIFY_SEI?
> =

> > yes, called by kernel ARCH code, such as below, I remember I have discu=
ssed
> with you.
> =

> Sure. The phrase 'external modules' usually means the '.ko' files that li=
ve in
> /lib/modules, nothing outside the kernel tree should be doing this stuff.

I will rename 'external modules' to other name. Thanks.

> =

> =

> Thanks,
> =

> James


--===============4576852335476914870==--

