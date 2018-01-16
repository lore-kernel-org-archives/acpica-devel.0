Content-Type: multipart/mixed; boundary="===============4955809524040558351=="
MIME-Version: 1.0
From: gengdongjiu <gengdongjiu at huawei.com>
Subject: Re: [Devel] [PATCH v8 7/7] arm64: kvm: handle SError Interrupt by
 categorization
Date: Tue, 16 Jan 2018 19:22:53 +0800
Message-ID: <27cb4309-4ee3-b947-c991-7da0dc6721ab@huawei.com>
In-Reply-To: 5A58F8EB.9080909@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4955809524040558351==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,
  thanks very much for your mail and reply, I will check it ASAP. Due to re=
cently busy with other thing, so reply may be late.

On 2018/1/13 2:05, James Morse wrote:
> Hi gengdongjiu,
> =

> On 16/12/17 04:47, gengdongjiu wrote:
>> [...]
>>>
>>>> +     case ESR_ELx_AET_UER:   /* The error has not been propagated */
>>>> +             /*
>>>> +              * Userspace only handle the guest SError Interrupt(SEI)=
 if the
>>>> +              * error has not been propagated
>>>> +              */
>>>> +             run->exit_reason =3D KVM_EXIT_EXCEPTION;
>>>> +             run->ex.exception =3D ESR_ELx_EC_SERROR;
>>>> +             run->ex.error_code =3D KVM_SEI_SEV_RECOVERABLE;
>>>> +             return 0;
>>>
>>> We should not pass RAS notifications to user space. The kernel either h=
andles
>>> them, or it panics(). User space shouldn't even know if the kernel supp=
orts RAS
>>
>> For the  ESR_ELx_AET_UER(Recoverable error), let us see its definition
>> below, which get from [0]
> =

> [..]
> =

>> so we can see the  exception is precise and PE can recover execution
>> from the preferred return address of the exception, =

> =

>> so let guest handling it is
>> better, for example, if it is guest application RAS error, we can kill
>> the guest application instead of panic whole OS; if it is guest kernel
>> RAS error, guest will panic.
> =

> If the kernel takes an unhandled RAS error it should panic - we don't kno=
w where
> the error is.
> =

> I understand you want to kill-off guest tasks as a result of RAS errors, =
but
> this needs to go through the whole APEI->memory_failure()->sigbus machine=
ry so
> that the kernel knows the kernel can keep running.
> =

> This saves us signalling user-space when we don't need to. An example:
> code-corruption. Linux can happily re-read affected user-space executable=
s from
> disk, there is absolutely nothing user-space can do about it.
> Handling errors first in the kernel allows us to do recovery for all the
> affected processes, not just the one that happens to be running right now.
> =

> =

>> Host does not know which application of guest has error, so host can
>> not handle it,
> =

> It has to work this out, otherwise the errors we can handle never get a c=
hance.
> =

> This kernel is expected to look at the error description, (which for some=
 reason
> we aren't talking about here), e.g. the CPER records, and determine what
> recovery action is necessary for this error.
> For memory errors this may be re-reading from disk, or at the worst case,
> unmapping from all user-space users (including KVM's stage2) and raining =
signals
> on all affected processes.
> =

> For a memory error the important piece of information is the physical add=
ress.
> Only the kernel can do anything with this, it determines who owns the aff=
ected
> memory and what needs doing to recover from the error.
> =

> If you pass the notification to user-space, all it can do is signal the g=
uest to
> "stop doing whatever it is you're doing". The guest may have been able to
> re-read pages from disk, or otherwise handle the error.
> Has the error been handled? No: The error remains latent in the system.
> =

> =

>> panic OS is not a good choice for the Recoverable error.
> =

> If we don't know where the error is, and we can't make progress, its the =
only
> sane choice.
> =

> This code is never expected to run! (why are we arguing about it?) We sho=
uld get
> RAS errors as GHES notifications from firmware via some mechanism. If tho=
se are
> NOTIFY_SEI then APEI should claim the notification and kick off the appro=
priate
> handling based on the CPER records. If/when we get kernel-first, that can=
 claim
> the SError. What we're left with is RAS notifications that no-one claimed
> because there was no error-description found.
> =

> =

> =

> James
> =

> .
> =



--===============4955809524040558351==--

