Content-Type: multipart/mixed; boundary="===============8404074639357088000=="
MIME-Version: 1.0
From: Hanjun Guo <hanjun.guo at linaro.org>
Subject: Re: [Devel] [PATCH 1/5] ACPICA: Add acpi_dev_present
Date: Tue, 24 Nov 2015 14:54:43 +0000
Message-ID: <56547A2B.8030401@linaro.org>
In-Reply-To: 2460979.tXaWt9xg5Q@vostro.rjw.lan
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8404074639357088000==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 11/24/2015 10:22 PM, Rafael J. Wysocki wrote:
> On Tuesday, November 24, 2015 12:40:51 PM Hanjun Guo wrote:
>> On 2015/11/24 7:32, Lukas Wunner wrote:
>>> Hi Robert,
>>>
>>> On Mon, Nov 23, 2015 at 10:22:27PM +0000, Moore, Robert wrote:
>>>>>> acpi_dev_present
>>>> Do you really want to be walking the ACPICA namespace for every call?
>>> That's what the drivers currently do. Typically this is called only once
>>> on initialization by the driver's ->probe callback.
>>>
>>> What did you have in mind instead, cache the result? Or store the HIDs
>>> in the namespace in a hash that can be queried faster?
>>
>> Will those drivers be loaded before the acpi namespace is scanned? if no=
t, I think
>> those IDs already cached, in acpi_init_device_object(),
>>
>> INIT_LIST_HEAD(&device->pnp.ids);
>> ...
>> acpi_set_pnp_ids(handle, &device->pnp, type);
>>
>> please see API acpi_device_hid(), so I think you can introduce a API with
>> acpi_device and HID passed as arguments in scan.c
>
> I'd prefer that to go to utils.c to be honest, even if the namespace need=
s to
> be walked.

I agree, utils.c is the better place to go.

Thanks
Hanjun

--===============8404074639357088000==--

