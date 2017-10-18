Content-Type: multipart/mixed; boundary="===============0836145769541769610=="
MIME-Version: 1.0
From: gengdongjiu <gengdongjiu at huawei.com>
Subject: Re: [Devel] [PATCH v5 2/2] acpi: apei: Add SEI notification type
 support for ARMv8
Date: Wed, 18 Oct 2017 17:17:27 +0800
Message-ID: <4b51bd4e-2bf7-3aed-f17c-565b49781009@huawei.com>
In-Reply-To: 20171018090649.e7qgdf2dwmr7yxc3@pd.tnic
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0836145769541769610==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On 2017/10/18 17:06, Borislav Petkov wrote:
> On Wed, Oct 18, 2017 at 01:00:44PM +0800, gengdongjiu wrote:
>> SError is System Error, which is a asynchronous exception in the Interna=
l CPU.
>>
>> In the ARM RAS Extension, there are mainly two type abort for CPU:
>> SEA(Synchronous External Abort)
>> SEI(SError Interrupt)
> And you're not writing it out as "System Error" because ...?

Thanks Borislav, can I write it as asynchronous exception or asynchronous a=
bort?


--===============0836145769541769610==--

