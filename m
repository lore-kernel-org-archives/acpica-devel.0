Content-Type: multipart/mixed; boundary="===============2167638078511819199=="
MIME-Version: 1.0
From: gengdongjiu <gengdongjiu at huawei.com>
Subject: Re: [Devel] [PATCH v11 6/6] target-arm: kvm64: Handle SError
 interrupt for the guest OS
Date: Wed, 13 Sep 2017 15:52:14 +0800
Message-ID: <5552cf68-b998-686b-8e7e-710399c2b014@huawei.com>
In-Reply-To: CAFEAcA8J5wZ23kQypzcbUScUResjWnN6rDG0b0idD1rv7F5Fsw@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2167638078511819199==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 2017/9/12 0:39, Peter Maydell wrote:
>>>> +    return  kvm_vcpu_ioctl(CPU(cpu), KVM_ARM_SEI, &syndrome);
>>> This looks odd. If we don't have the RAS extension why do we need to do=
 anything at all here ?
>> This is because Qemu may need to support non-RAS extension as discussed =
with ARM James before.
>> That is to say host hardware CPU does not support RAS, but guest support=
s.
>> That is under discussion.
>> When host hardware supports RAS, specify the syndrome to a valid value, =
otherwise, set it to 0.
> If the guest CPU doesn't support the RAS extension then we have
> no mechanism for delivering it a notification about the
> memory problem at all, so setting the syndrome to anything
> doesn't make sense.
> =

> I'm not sure what you should do in the case of "host
> supports telling us about a memory problem and has
> done so, but guest does not support being told about it",
> but I'm pretty sure it shouldn't be this.
Hi peter,
   thanks for the comments.

   in short, if the hardware CPU does not support RAS extension, do you thi=
nk whether the Qemu or guest OS
needs to support RAS(generate APEI table / record CPER / Error recovery).

CC James,

Hi James,
  you ever have below comments:

-----------------------------------------------------------------------
But you can use APEI in a guest on CPUs without the RAS extensions: the hos=
t may
signal memory errors to Qemu for any number of reasons.
------------------------------------------------------------------

in fact, I have a concern about it. If CPU without the RAS extension, the h=
ost should not deliver the sigbus.
in which case in your test that host still deliver sigbus without RAS?


--===============2167638078511819199==--

