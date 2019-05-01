Content-Type: multipart/mixed; boundary="===============2776731011739206256=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [alsa-devel] [PATCH] ACPI / device_sysfs: change _ADR
 representation to 64 bits
Date: Wed, 01 May 2019 09:59:25 +0200
Message-ID: <CAJZ5v0iwm5tLRy2mLX6_uTk2wh+1Y4VaEcqDx5Z1WDLZHMnpEg@mail.gmail.com>
In-Reply-To: eda0ed4e-fc36-a53a-225f-e7d54bb73413@linux.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2776731011739206256==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2019 at 8:23 PM Pierre-Louis Bossart
<pierre-louis.bossart(a)linux.intel.com> wrote:
>
>
>
> On 4/16/19 3:09 AM, Rafael J. Wysocki wrote:
> > On Tue, Apr 16, 2019 at 5:29 AM Vinod Koul <vkoul(a)kernel.org> wrote:
> >>
> >> On 15-04-19, 10:18, Pierre-Louis Bossart wrote:
> >>> Standards such as the MIPI DisCo for SoundWire 1.0 specification
> >>> assume the _ADR field is 64 bits.
> >>>
> >>> _ADR is defined as an "Integer" represented as 64 bits since ACPI 2.0
> >>> released in 2002. The low levels already use _ADR as 64 bits, e.g. in
> >>> struct acpi_device_info.
> >>>
> >>> This patch bumps the representation used for sysfs to 64 bits.
> >>>
> >>> Example with a SoundWire device, the results show the complete
> >>> vendorID and linkID which were omitted before:
> >>>
> >>> Before:
> >>> $ more /sys/bus/acpi/devices/device\:38/adr
> >>> 0x5d070000
> >>> After:
> >>> $ more /sys/bus/acpi/devices/device\:38/adr
> >>> 0x000010025d070000
> >>
> >> This looks fine but the sysfs file is an ABI. Not sure if we can modify
> >> the value returned this way.. Though it should not cause userspace
> >> reading 32bits to break...
> >
> > Well, IIRC using "08" instead of "016" in the format field would
> > preserve the existing behavior for 32-bit values, wouldn't it?
>
> yes, but it makes the 64-bit address not aligned depending on the number
> of leading zeroes, see below. I get a migraine just looking at the result=
s.

Well, scripts reading them won't get that, but fair enough.

> Maybe add a test to use 08 for values that are below 0xFFFFFFFF and 16
> for addresses who really need the full range, typically because of an
> encoding?

That would be fine by me.

--===============2776731011739206256==--

