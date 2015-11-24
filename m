Content-Type: multipart/mixed; boundary="===============5272901839212020736=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH 1/5] ACPICA: Add acpi_dev_present
Date: Tue, 24 Nov 2015 14:15:03 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D998EDD@ORSMSX112.amr.corp.intel.com>
In-Reply-To: 5653EA53.8040909@huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5272901839212020736==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Hanjun Guo [mailto:guohanjun(a)huawei.com]
> Sent: Monday, November 23, 2015 8:41 PM
> To: Lukas Wunner; Moore, Robert
> Cc: Rafael J. Wysocki; linux-acpi(a)vger.kernel.org; devel(a)acpica.org;
> platform-driver-x86(a)vger.kernel.org; Darren Hart; Corentin Chary; Lee,
> Chun-Yi; alsa-devel(a)alsa-project.org; Takashi Iwai; Hui Wang; Mark Brow=
n;
> Zheng, Lv; David Box
> Subject: Re: [PATCH 1/5] ACPICA: Add acpi_dev_present
> =

> On 2015/11/24 7:32, Lukas Wunner wrote:
> > Hi Robert,
> >
> > On Mon, Nov 23, 2015 at 10:22:27PM +0000, Moore, Robert wrote:
> >>>> acpi_dev_present
> >> Do you really want to be walking the ACPICA namespace for every call?
> > That's what the drivers currently do. Typically this is called only
> > once on initialization by the driver's ->probe callback.
> >
> > What did you have in mind instead, cache the result? Or store the HIDs
> > in the namespace in a hash that can be queried faster?
> =

> Will those drivers be loaded before the acpi namespace is scanned? if not,
> I think those IDs already cached, in acpi_init_device_object(),


I was thinking about something like this. Traversing the namespace over and=
 over is truly brute force.



> =

> INIT_LIST_HEAD(&device->pnp.ids);
> ...
> acpi_set_pnp_ids(handle, &device->pnp, type);
> =

> please see API acpi_device_hid(), so I think you can introduce a API with
> acpi_device and HID passed as arguments in scan.c
> =

> Thanks
> Hanjun


--===============5272901839212020736==--

