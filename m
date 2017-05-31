Content-Type: multipart/mixed; boundary="===============4728112921201388947=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] acpi: configfs: Unload SSDT on configfs entry
 removal
Date: Wed, 31 May 2017 14:30:42 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E5BAF0B@ORSMSX110.amr.corp.intel.com>
In-Reply-To: CAJZ5v0ibeMhrdfs8x8gjqASGt8xf1wLXnN9sQf2A5zU6goeGSQ@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4728112921201388947==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: rjwysocki(a)gmail.com [mailto:rjwysocki(a)gmail.com] On Behalf Of
> Rafael J. Wysocki
> Sent: Tuesday, May 30, 2017 2:42 PM
> To: Moore, Robert <robert.moore(a)intel.com>; Jan Kiszka
> <jan.kiszka(a)siemens.com>
> Cc: Mika Westerberg <mika.westerberg(a)linux.intel.com>; Rafael J. Wysocki
> <rjw(a)rjwysocki.net>; Len Brown <lenb(a)kernel.org>; Zheng, Lv
> <lv.zheng(a)intel.com>; linux-acpi(a)vger.kernel.org; Linux Kernel Mailing
> List <linux-kernel(a)vger.kernel.org>; devel(a)acpica.org
> Subject: Re: [PATCH] acpi: configfs: Unload SSDT on configfs entry
> removal
> =

> On Tue, May 30, 2017 at 11:16 PM, Moore, Robert <robert.moore(a)intel.com>
> wrote:
> >
> >
> >> -----Original Message-----
> >> From: Jan Kiszka [mailto:jan.kiszka(a)siemens.com]
> >> Sent: Monday, May 29, 2017 5:53 AM
> >> To: Mika Westerberg <mika.westerberg(a)linux.intel.com>
> >> Cc: Rafael J. Wysocki <rjw(a)rjwysocki.net>; Len Brown
> >> <lenb(a)kernel.org>; Zheng, Lv <lv.zheng(a)intel.com>;
> >> linux-acpi(a)vger.kernel.org; Linux Kernel Mailing List
> >> <linux-kernel(a)vger.kernel.org>; devel(a)acpica.org; Moore, Robert
> >> <robert.moore(a)intel.com>
> >> Subject: Re: [PATCH] acpi: configfs: Unload SSDT on configfs entry
> >> removal
> >>
> >> On 2017-05-29 14:47, Mika Westerberg wrote:
> >> > On Mon, May 29, 2017 at 01:33:29PM +0200, Jan Kiszka wrote:
> >> >> Enhance acpi_load_table to also return the table index. Use that
> >> >> index to unload the table again when the corresponding directory
> >> >> in configfs gets removed. This allows to change SSDTs without
> >> >> rebooting
> >> the system.
> >> >> It also allows to destroy devices again that a dynamically loaded
> >> >> SSDT created.
> >> >>
> >> >> This is widely similar to the DT overlay behavior.
> >> >>
> >> >> Signed-off-by: Jan Kiszka <jan.kiszka(a)siemens.com>
> >> >> ---
> >> >>
> >> >> Can someone explain to me why an unloaded table still sticks
> >> >> around in sysfs and why we cannot release its ID and rather have
> >> >> to use a new one when loading a modified version?
> >> >
> >> > IIRC ACPICA relies the fact that SSDTs are never unloaded. Bob
> >> > (CC'd) can correct me if I got it wrong.
> >>
> >
> >
> > [Moore, Robert]
> >
> > I'm not entirely sure what the table manager code looks like at this
> time, but ACPICA does in fact support table unloading.
> >
> > It is a rather dangerous thing to do, however -- unless you are
> careful about it. Basically, all handles that reference the table to be
> unloaded will go bad.
> =

> Right.
> =

> Linux should handle that in theory, but the code in there is mostly very
> lightly tested AFAICS.
> =

[Moore, Robert] =


The load/unload functionality works with the current table interfaces. For =
example, the AML debugger supports both Load and Unload commands:


  Load <Input Filename>           Load ACPI table from a file
  Unload <Namepath>               Unload an ACPI table via namespace object


- load ssdt.aml
Input file ssdt.aml, Length 0x3A (58) bytes
ACPI: Host-directed Dynamic ACPI Table Load:
ACPI: SSDT 0x00000000004A1B18 00003A (v02 Intel  _SSDT_01 00000001 INTL 201=
70303)
ACPI Exec: Table Event INSTALL, [SSDT] 004A1B18
ACPI Exec: Table Event LOAD, [SSDT] 004A1B18


- unload _T32
ACPI Exec: Table Event UNLOAD, [SSDT] 004A1B18
Parent of [_T32] (004A1028) unloaded and uninstalled



> >> OK... Is that standard-driven or just a limitation of this
> >> implementation?
> >>
> >> Is there an upper limit of tables? I'm thinking of lengthy
> >> development sessions that play with tables, loading and unloading
> modified versions.
> >>
> >
> > [Moore, Robert]
> >
> > I think that the maximum number of loaded ACPI tables is 255 at any
> given time. However, things are cleaned up after an unload such that
> repeated load/unload cycles should not consume resources.
> =

> I'm not sure if this is going to work seamlessly right away, but it
> certainly can be made work.
> =

> That said, the change as proposed would be an API modification forcing
> all of the OSes using ACPICA to change (or to carry out-of-the-tree
> patches), so not nice.
> =

> What about adding a separate version of acpi_load_table() returning an
> index (or an error on failures) instead of the status and leaving the
> existing acpi_load_table() as is?
> =

> Thanks,
> Rafael

--===============4728112921201388947==--

