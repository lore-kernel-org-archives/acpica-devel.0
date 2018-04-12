Content-Type: multipart/mixed; boundary="===============5611456140722039270=="
MIME-Version: 1.0
From: gengdongjiu <gengdongjiu at huawei.com>
Subject: Re: [Devel] [PATCH v11 0/4] set VSESR_EL2 by user space and support
 NOTIFY_SEI notification
Date: Thu, 12 Apr 2018 14:09:35 +0800
Message-ID: <5161fb31-e5bb-872c-3e12-d7d38326aaca@huawei.com>
In-Reply-To: d94439b6-9b9a-9bd0-ddec-3bb63ede9461@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5611456140722039270==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James=EF=BC=8C
   thanks for this mail.

On 2018/4/10 22:15, James Morse wrote:
> Hi Dongjiu Geng,
> =

> On 09/04/18 22:36, Dongjiu Geng wrote:
>> 1. Detect whether KVM can set set guest SError syndrome
>> 2. Support to Set VSESR_EL2 and inject SError by user space.
>> 3. Support live migration to keep SError pending state and VSESR_EL2 val=
ue.
>> 4. ACPI 6.1 adds support for NOTIFY_SEI as a GHES notification mechanism=
, so support this
>>    notification in software, KVM or kernel ARCH code call handle_guest_s=
ei() to let ACP driver
>>    to handle this notification.
> =

> Please don't post code during the merge-window, will this apply to v4.17-=
rc1? We
> can't know until its tagged.
I do not know when it is merge-window. About the apply version, it does not=
 have limited.

> =

> =

> This series is doing two separate things, please split it into two series.
OK, thanks!

> =

> But on the ACPI front: I don't see how any OS can support your NOTIFY_SEI=
 when
> firmware is ignoring the normal world's PSTATE.A.
> =

> The latest lobe of that discussion was on the list here:
> https://www.mail-archive.com/linux-kernel(a)vger.kernel.org/msg1611496.ht=
ml
I have replied the mail.
I still have some questions that need to clarify with you.
After clarification, we will follow that.
The question is in the reply of this mail "https://www.mail-archive.com/lin=
ux-kernel(a)vger.kernel.org/msg1611496.html"

> =

> =

> As it is, we would need to spot SError being delivered while SError is ma=
sked,
> spray nasty messages about firmware being horrifically buggy, then panic(=
). For
> a corrected error, this looks bad, but its preferable to letting firmware
> silently overwrite the exception registers, causing linux to spin through=
 the
> vectors 'eret' with all exceptions masked.
> I still think its best to wait for firmware that does the right thing.
Let us  discuss that in another mail.
In a summary, I think firmware follow below rule can be OK, right?
1. The exception came from the EL that SError should be routed to(according=
 to hcr_EL2.{AMO, TGE}),but PSTATE.A was set, EL3 firmware can't deliver SE=
rror;
2. The exception came from the EL that SError should not be routed to(accor=
ding to hcr_EL2.{AMO, TGE}),even though the PSTATE.A was set,EL3 firmware s=
till deliver SError

> =

> =

> Thanks,
> =

> James
> =

> .
> =



--===============5611456140722039270==--

