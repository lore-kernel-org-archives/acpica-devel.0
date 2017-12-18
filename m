Content-Type: multipart/mixed; boundary="===============2088766543479237819=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [PATCH 2/3 v6] battery: Add the ThinkPad "Not Charging"
 quirk
Date: Mon, 18 Dec 2017 18:30:57 +0100
Message-ID: <CAJZ5v0jR1ABy-hsGHOMpee9tctUiq6zX6nN44VgxnpdbZ4wiFg@mail.gmail.com>
In-Reply-To: CALgTWSv-4DSnU1MLiapL22rK-qaa45xCz6WuMnM_AeBtKYDidw@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2088766543479237819==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2017 at 11:21 AM, Ognjen Gali=C4=87 <smclt30p(a)gmail.com> =
wrote:
> On 16/12/2017, Rafael J. Wysocki <rafael(a)kernel.org> wrote:
>> On Sat, Dec 16, 2017 at 9:48 AM, Ognjen Galic <smclt30p(a)gmail.com> wro=
te:
>>> On Sat, Dec 16, 2017 at 01:33:55AM +0100, Rafael J. Wysocki wrote:
>>>> On Fri, Dec 15, 2017 at 5:57 PM, Ognjen Galic <smclt30p(a)gmail.com>
>>>> wrote:
>>>> > The EC/ACPI firmware on Lenovo ThinkPads used to report a status
>>>> > of "Unknown" when the battery is between the charge start and
>>>> > charge stop thresholds. On Windows, it reports "Not Charging"
>>>> > so the quirk has been added to also report correctly.
>>>> >
>>>> > Now the "status" attribute returns "Not Charging" when the
>>>> > battery on ThinkPads is not physicaly charging.
>>>> >
>>>> > Tested-by: Kevin Locke <kevin(a)kevinlocke.name>
>>>> > Tested-by: Christoph B=C3=B6hmwalder <christoph(a)boehmwalder.at>
>>>> > Signed-off-by: Ognjen Galic <smclt30p(a)gmail.com>
>>>>
>>>> It doesn't look like this is related to the [1/3] and [3/3], so why do
>>>> you make it part of the series?
>>>>
>>>
>>> I made it the same series because it is practically the same feature
>>> set. Without this patch and with 1/3 and 3/3 applied, there is a bug
>>> where the status attribute would show "Unknown" for a battery that is
>>> between the start and stop thresholds while attached to AC.
>>
>> OK, fair enough.
>>
>> I would reorder it as the first patch in the series, then, because the
>> other two are more related to each other.
>>
>> Thanks,
>> Rafael
>>
>
> Do I really need now to re-order and re-send the whole patchset for it
> to get merged?

I'm not sure I will take anything of it at this time.

Thanks,
Rafael

--===============2088766543479237819==--

