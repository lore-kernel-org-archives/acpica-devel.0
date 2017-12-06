Content-Type: multipart/mixed; boundary="===============0617350523759275355=="
MIME-Version: 1.0
From: gengdongjiu <gengdongjiu at huawei.com>
Subject: Re: [Devel] [PATCH v8 7/7] arm64: kvm: handle SError Interrupt by
 categorization
Date: Wed, 06 Dec 2017 18:26:14 +0800
Message-ID: <4af78739-99da-4056-4db1-f80bfe11081a@huawei.com>
In-Reply-To: 5A0B1334.7060500@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0617350523759275355==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On 2017/11/15 0:00, James Morse wrote:
>> +		 * error has not been propagated
>> +		 */
>> +		run->exit_reason =3D KVM_EXIT_EXCEPTION;
>> +		run->ex.exception =3D ESR_ELx_EC_SERROR;
>> +		run->ex.error_code =3D KVM_SEI_SEV_RECOVERABLE;
>> +		return 0;
> We should not pass RAS notifications to user space. The kernel either han=
dles
> them, or it panics(). User space shouldn't even know if the kernel suppor=
ts RAS
> until it gets an MCEERR signal.
> =

> You're making your firmware-first notification an EL3->EL0 signal, bypass=
ing the OS.
> =

> If we get a RAS SError and there are no CPER records or values in the ERR=
 nodes,
> we should panic as it looks like the CPU/firmware is broken. (spurious RA=
S errors)

Hi james,
  sorry to disturb you!

  do you think whether we need to set the guest ESR by user space?  if need=
, I need to
notify user space that there is a SError happen and need to set ESR for gue=
st in some place of
KVM. so here I return a error code to user space. you mean we should not pa=
ss RAS notifications
to user space, so could you give some suggestion how to notify user space t=
o set guest ESR.

Thanks a lot in advance.


> =

> =



--===============0617350523759275355==--

