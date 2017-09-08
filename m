Content-Type: multipart/mixed; boundary="===============8715643070565583861=="
MIME-Version: 1.0
From: gengdongjiu <gengdongjiu at huawei.com>
Subject: =?utf-8?q?=5BDevel=5D_=E7=AD=94=E5=A4=8D=3A_=5BPATCH_v6_4/7=5D_arm64=3A_k?=
 =?utf-8?q?vm=3A_support_user_space_to_query_RAS_extension_feature?=
Date: Fri, 08 Sep 2017 17:36:04 +0000
Message-ID: <0184EA26B2509940AA629AE1405DD7F2015F61EA@DGGEMA503-MBX.china.huawei.com>
In-Reply-To: 59B1747A.5030909@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8715643070565583861==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

HI James,

[...]
> =

> The code to signal memory-failure to user-space doesn't depend on the CPU=
's RAS-extensions.
I roughly check your answer and agree with your general idea.
late I will check it in detail.

I have a question, do you sure that if CPU does not support RAS-extensions =
kernel can still call memory-failure() to send signal to qemu?

After my checking the code, the general flow is RAS module detects the erro=
r or CPU consumes the hardware poison data, happen exception, then EL3 firm=
ware records the address to APEI table and send
notification to kernel. Kernel parses the APEI table to get address and cal=
l memory_failure() to identify the page to poison. That is to say, usually,=
 after RAS detect the error, it call memory_failure(),
otherwise, it does not know whether this address is poison.
I am worried about one thing, if hardware does not has RAS, OS cannot know =
which address is poison, so it cannot identify the address , then the addre=
ss that is delivered to Qemu(user space) may not right.

As you said, kernel can also call memory_failure() even without RAS support=
. in this without RAS case, how it consider the address is poison and needs=
 to send SIGBUS to QEMU?

> =

> If Qemu supports notifying the guest about RAS errors using CPER records,=
 it should generate a HEST describing firmware first. It can then
> choose the notification methods, some of which may require optional KVM A=
PIs to support.
> =

> Seattle has a HEST, it doesn't support the CPU RAS-extensions. The kernel=
 can notify user-space about memory_failure() on this machine. I
> would expect Qemu to be able to receive signals and describe memory error=
s to a guest (1).

Usually we consider the address got from APEI table is poison. If so, I wan=
t to know, without RAS and APEI table, how it identify the address to hwpoi=
son?


--===============8715643070565583861==--

