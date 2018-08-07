Content-Type: multipart/mixed; boundary="===============2423783436772313506=="
MIME-Version: 1.0
From: gengdongjiu <gengdongjiu at huawei.com>
Subject: Re: [Devel] [PATCH] arm64: clean the additional checks before calling
 ghes_notify_sea()
Date: Tue, 07 Aug 2018 14:37:36 +0800
Message-ID: <2c3baa9e-c647-01a9-cef6-eb61ba6c529c@huawei.com>
In-Reply-To: 20180806142623.GA15275@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2423783436772313506==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 2018/8/6 22:26, Will Deacon wrote:
>> Will,
>>      This patch will be applied, right? thanks
> I haven't queued it in the arm64 tree, since it touches include/acpi/ghes=
.h
> and you don't have an ack from the acpi folks. I acked it so that you cou=
ld
> route it via the acpi tree without me holding you up.

Thanks the explanation.
yes, this patch touches the "include/acpi/ghes.h", I will repost this patch=
 to let acpi
folks review it.


> =

> Will
> =

>>>> This cleanup is ever mentioned by Mark Rutland in [1]


--===============2423783436772313506==--

