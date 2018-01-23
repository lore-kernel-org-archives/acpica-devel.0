Content-Type: multipart/mixed; boundary="===============2246285509612809445=="
MIME-Version: 1.0
From: gengdongjiu <gengdongjiu at huawei.com>
Subject: Re: [Devel] [PATCH v9 3/7] acpi: apei: Add SEI notification type
 support for ARMv8
Date: Tue, 23 Jan 2018 18:07:52 +0800
Message-ID: <53566b7c-d686-66be-ee84-a6a6257b526a@huawei.com>
In-Reply-To: 168c3f61-0d11-13a4-c383-1f6a97d0ef37@huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2246285509612809445==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

sorry fix a typo.

On 2018/1/23 17:23, gengdongjiu wrote:
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

Yes, I know you are dong that. Your serial's patch will consider all above =
things, right?
If your patch can be consider that, this patch can based on your patchset. =
thanks.

> =

>>


--===============2246285509612809445==--

