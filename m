Content-Type: multipart/mixed; boundary="===============1882340893056218638=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [PATCH 2/3 v6] battery: Add the ThinkPad "Not Charging"
 quirk
Date: Sat, 16 Dec 2017 11:18:13 +0100
Message-ID: <CAJZ5v0gWooR7rtY0qmEyERr=A+BoLWoSAHh5Reh3xE5Gvks9+g@mail.gmail.com>
In-Reply-To: 20171216084850.GA19033@thinkpad
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1882340893056218638==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 16, 2017 at 9:48 AM, Ognjen Galic <smclt30p(a)gmail.com> wrote:
> On Sat, Dec 16, 2017 at 01:33:55AM +0100, Rafael J. Wysocki wrote:
>> On Fri, Dec 15, 2017 at 5:57 PM, Ognjen Galic <smclt30p(a)gmail.com> wro=
te:
>> > The EC/ACPI firmware on Lenovo ThinkPads used to report a status
>> > of "Unknown" when the battery is between the charge start and
>> > charge stop thresholds. On Windows, it reports "Not Charging"
>> > so the quirk has been added to also report correctly.
>> >
>> > Now the "status" attribute returns "Not Charging" when the
>> > battery on ThinkPads is not physicaly charging.
>> >
>> > Tested-by: Kevin Locke <kevin(a)kevinlocke.name>
>> > Tested-by: Christoph B=C3=B6hmwalder <christoph(a)boehmwalder.at>
>> > Signed-off-by: Ognjen Galic <smclt30p(a)gmail.com>
>>
>> It doesn't look like this is related to the [1/3] and [3/3], so why do
>> you make it part of the series?
>>
>
> I made it the same series because it is practically the same feature
> set. Without this patch and with 1/3 and 3/3 applied, there is a bug
> where the status attribute would show "Unknown" for a battery that is
> between the start and stop thresholds while attached to AC.

OK, fair enough.

I would reorder it as the first patch in the series, then, because the
other two are more related to each other.

Thanks,
Rafael

--===============1882340893056218638==--

