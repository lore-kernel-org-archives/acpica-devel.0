Content-Type: multipart/mixed; boundary="===============6440958655609711226=="
MIME-Version: 1.0
From: =?utf-8?q?Wei=2C_Dong_=28=E9=AD=8F=E4=B8=9C_UEFI-ACPI=29_=3Cdong=2Ewei_at?=
 =?utf-8?q?_hp=2Ecom=3E?=
Subject: Re: [Devel] ACPI 5.0 implementation for armv7 and armv8 architecture
Date: Tue, 18 Dec 2012 00:00:22 +0000
Message-ID: <D9DB7F56087E294C83142799ED69E2A077338527@G4W3293.americas.hpqcorp.net>
In-Reply-To: 50CFAB0B.4000305@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6440958655609711226==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Al,

I fully agree. I was hoping Andrew could introduce Ayan to the LEG work:-)

- DW
- =

-----Original Message-----
From: Al Stone [mailto:ahs3(a)redhat.com] =

Sent: Monday, December 17, 2012 3:30 PM
To: Wei, Dong (=E9=AD=8F=E4=B8=9C UEFI-ACPI)
Cc: Ayan Halder; devel(a)acpica.org; Andrew N. Sloss
Subject: Re: [Devel] ACPI 5.0 implementation for armv7 and armv8 architectu=
re

I've only lurked on this list in the past, but this work sounds very simila=
r to work I've been tasked to take on for Linaro (please see https://wiki.l=
inaro.org/LEG for the context).  I'll be looking at Cortex A9/A15 and ARMv8=
 for the same reasons so I'm thinking perhaps we should coordinate our effo=
rts here...

On 12/02/2012 08:37 PM, Wei, Dong (=E9=AD=8F=E4=B8=9C UEFI-ACPI) wrote:
> Copying Andrew Sloss from ARM.
>
> -DW
>
> *From:*devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] *On =

> Behalf Of *Ayan Halder
> *Sent:* Sunday, December 02, 2012 5:30 AM
> *To:* devel(a)acpica.org
> *Subject:* [Devel] ACPI 5.0 implementation for armv7 and armv8 =

> architecture
>
> Hi,
>
> I am planning to implement ACPI5.0 on an SOC having Cortex A5 and =

> Atlas cpu( based on armv8 architecture) running linux on top of them.
>
> As per the ACPI 5.0 hardware specification(Fixed Hardware/ Generic =

> Hardware  model) of ACPI5.0, the processor needs to support various =

> low power modes(C0, C1, C2, C3) and sleep states(S1, S2, S3, S4, S5) =

> via register interfaces as well as OEM provided AML(ACPI Machine Language=
).
>
> Therefore, which instructions in armv7 and armv8 put the processor =

> into the afore-mentioned low power modes and sleep states?
>
> ( The arm instruction manual specifies =E2=80=9Cwfe=E2=80=9D and =E2=80=
=9Cwfi=E2=80=9D to put the =

> processor in a sleep state, but I am not sure if this confirms to the =

> ACPI 5.0 requirements )
>
> Besides, does arm provide any AML(ACPI Machine Language) code to put =

> the processor to low power modes? If not, then how do we create an =

> ACPI machine language code for armv7 and armv8 architecture and do we =

> have an AML interpreter for armv7 and armv8 architecture?
>
> Regards,
>
> Ayan Kumar Halder
>
>
>
> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> http://lists.acpica.org/listinfo/devel
>


--
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3(a)redhat.com
-----------------------------------

--===============6440958655609711226==--

