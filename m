Content-Type: multipart/mixed; boundary="===============7789135032145456408=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] acpi: configfs: Unload SSDT on configfs entry
 removal
Date: Tue, 30 May 2017 21:16:48 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E5B8D42@ORSMSX110.amr.corp.intel.com>
In-Reply-To: fff98a5c-e18f-d326-e5de-7401173d9af4@siemens.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7789135032145456408==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Jan Kiszka [mailto:jan.kiszka(a)siemens.com]
> Sent: Monday, May 29, 2017 5:53 AM
> To: Mika Westerberg <mika.westerberg(a)linux.intel.com>
> Cc: Rafael J. Wysocki <rjw(a)rjwysocki.net>; Len Brown <lenb(a)kernel.org=
>;
> Zheng, Lv <lv.zheng(a)intel.com>; linux-acpi(a)vger.kernel.org; Linux Ker=
nel
> Mailing List <linux-kernel(a)vger.kernel.org>; devel(a)acpica.org; Moore,
> Robert <robert.moore(a)intel.com>
> Subject: Re: [PATCH] acpi: configfs: Unload SSDT on configfs entry
> removal
> =

> On 2017-05-29 14:47, Mika Westerberg wrote:
> > On Mon, May 29, 2017 at 01:33:29PM +0200, Jan Kiszka wrote:
> >> Enhance acpi_load_table to also return the table index. Use that
> >> index to unload the table again when the corresponding directory in
> >> configfs gets removed. This allows to change SSDTs without rebooting
> the system.
> >> It also allows to destroy devices again that a dynamically loaded
> >> SSDT created.
> >>
> >> This is widely similar to the DT overlay behavior.
> >>
> >> Signed-off-by: Jan Kiszka <jan.kiszka(a)siemens.com>
> >> ---
> >>
> >> Can someone explain to me why an unloaded table still sticks around
> >> in sysfs and why we cannot release its ID and rather have to use a
> >> new one when loading a modified version?
> >
> > IIRC ACPICA relies the fact that SSDTs are never unloaded. Bob (CC'd)
> > can correct me if I got it wrong.
> =



[Moore, Robert] =


I'm not entirely sure what the table manager code looks like at this time, =
but ACPICA does in fact support table unloading.

It is a rather dangerous thing to do, however -- unless you are careful abo=
ut it. Basically, all handles that reference the table to be unloaded will =
go bad.

> OK... Is that standard-driven or just a limitation of this
> implementation?
> =

> Is there an upper limit of tables? I'm thinking of lengthy development
> sessions that play with tables, loading and unloading modified versions.
> =

 =

[Moore, Robert] =


I think that the maximum number of loaded ACPI tables is 255 at any given t=
ime. However, things are cleaned up after an unload such that repeated load=
/unload cycles should not consume resources.


> Jan
> =

> --
> Siemens AG, Corporate Technology, CT RDA ITP SES-DE Corporate Competence
> Center Embedded Linux

--===============7789135032145456408==--

