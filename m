Content-Type: multipart/mixed; boundary="===============3754714908065000342=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH 1/2] acpi: Avoid soft lockup complaints during boot
Date: Fri, 02 Mar 2018 15:08:53 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B7574620@ORSMSX110.amr.corp.intel.com>
In-Reply-To: CAJZ5v0gP2_mTmS4GBMETj+yxFH76eth1V63adgYkqoeiMW7ErA@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3754714908065000342==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: rjwysocki(a)gmail.com [mailto:rjwysocki(a)gmail.com] On Behalf Of
> Rafael J. Wysocki
> Sent: Monday, February 26, 2018 1:51 AM
> To: Bart Van Assche <Bart.VanAssche(a)wdc.com>
> Cc: rafael(a)kernel.org; Schmauss, Erik <erik.schmauss(a)intel.com>; Moor=
e,
> Robert <robert.moore(a)intel.com>; Wu, Fengguang <fengguang.wu(a)intel.co=
m>;
> devel(a)acpica.org; linux-acpi(a)vger.kernel.org; Wysocki, Rafael J
> <rafael.j.wysocki(a)intel.com>
> Subject: Re: [PATCH 1/2] acpi: Avoid soft lockup complaints during boot
> =

> On Fri, Feb 23, 2018 at 5:18 PM, Bart Van Assche
> <Bart.VanAssche(a)wdc.com> wrote:
> > On Fri, 2018-02-23 at 11:05 +0100, Rafael J. Wysocki wrote:
> >> On Fri, Feb 23, 2018 at 1:22 AM, Bart Van Assche
> <bart.vanassche(a)wdc.com> wrote:
> >> > Avoid that the following is reported during boot with kmemleak
> >> > enabled:
> >>
> >> OK, so why is this fix the right one in your view?
> >
> > No Linux kernel code should keep running for multiple seconds without
> > giving the scheduler a chance to schedule another thread. Hence the
> > insertion of the
> > cond_resched() call.
> =

> I see.
> =

> > It is very well possible that the fact that this code keeps the CPU
> > for itself so long is a bug by itself. However, I'm not familiar
> > enough with the ACPI code to figure out whether any alternative
> > solutions exist that would be better than the patch I posted.
> =

> OK, we'll look at the code and see how it can be improved upstream.
> =

> Thanks a lot for letting us know about this issue!

We would like to take a look at this issue with respect to ACPICA. Please s=
end the dmesg and acpidump for the machine.

Thanks,
Bob



--===============3754714908065000342==--

