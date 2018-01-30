Content-Type: multipart/mixed; boundary="===============0909784058739767279=="
MIME-Version: 1.0
From: James Morse <james.morse at arm.com>
Subject: Re: [Devel] [PATCH v9 3/7] acpi: apei: Add SEI notification type
 support for ARMv8
Date: Tue, 30 Jan 2018 19:39:40 +0000
Message-ID: <5A70C9FC.5080100@arm.com>
In-Reply-To: 168c3f61-0d11-13a4-c383-1f6a97d0ef37@huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0909784058739767279==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi gengdongjiu,

On 23/01/18 09:23, gengdongjiu wrote:
> On 2018/1/23 3:39, James Morse wrote:
>> gengdongjiu wrote:
>>> This error source parsing and handling method
>>> is similar with the SEA.
>>
>> There are problems with doing this:
>>
>> Oct. 18, 2017, 10:26 a.m. James Morse wrote:
>> | How do SEA and SEI interact?
>> |
>> | As far as I can see they can both interrupt each other, which isn't so=
mething
>> | the single in_nmi() path in APEI can handle. I thinks we should fix th=
is
>> | first.
>>
>> [..]
>>
>> | SEA gets away with a lot of things because its synchronous. SEI isn't.=
 Xie
>> | XiuQi pointed to the memory_failure_queue() code. We can use this dire=
ctly
>> | from SEA, but not SEI. (what happens if an SError arrives while we are
>> | queueing memory_failure work from an IRQ).
>> |
>> | The one that scares me is the trace-point reporting stuff. What happen=
s if an
>> | SError arrives while we are enabling a trace point? (these are static-=
keys
>> | right?)
>> |
>> |  I don't think we can just plumb SEI in like this and be done with it.
>> |  (I'm looking at teasing out the estatus cache code from being x86:NMI=
 only.
>> |  This way we solve the same 'cant do this from NMI context' with the s=
ame
>> |  code'.)
>>
>>
>> I will post what I've got for this estatus-cache thing as an RFC, its no=
t ready
>> to be considered yet.

> Yes, I know you are dong that. Your serial's patch will consider all abov=
e things, right?

Assuming I got it right, yes. It currently makes the race Xie XiuQi spotted
worse, which I want to fix too. (details on the cover letter)


> If your patch can be consider that, this patch can based on your patchset=
. thanks.

I'd like to pick these patches onto the end of that series, but first I wan=
t to
know what NOTIFY_SEI means for any OS. The ACPI spec doesn't say, and becau=
se
its asynchronous, route-able and mask-able, there are many more corners than
NOTFIY_SEA.

This thing is a notification using an emulated SError exception. (emulated
because physical-SError must be routed to EL3 for firmware-first, and
virtual-SError belongs to EL2).

Does your firmware emulate SError exactly as the TakeException() pseudo cod=
e in
the Arm-Arm?
Is the emulated SError routed following the routing rules for HCR_EL2.{AMO,=
 TGE}?
What does your firmware do when it wants to emulate SError but its masked?
(e.g.1: The physical-SError interrupted EL2 and the SPSR shows EL2 had PSTA=
TE.A
 set.
 e.g.2: The physical-SError interrupted EL2 but HCR_EL2 indicates the emula=
ted
 SError should go to EL1. This effectively masks SError.)


Answers to these let us determine whether a bug is in the firmware or the
kernel. If firmware is expecting the OS to do something special, I'd like to
know about it from the beginning!


>>> Expose API ghes_notify_sei() to external users. External
>>> modules can call this exposed API to parse APEI table and
>>> handle the SEI notification.
>>
>> external modules? You mean called by the arch code when it gets this NOT=
IFY_SEI?

> yes, called by kernel ARCH code, such as below, I remember I have discuss=
ed with you.

Sure. The phrase 'external modules' usually means the '.ko' files that live=
 in
/lib/modules, nothing outside the kernel tree should be doing this stuff.


Thanks,

James


--===============0909784058739767279==--

