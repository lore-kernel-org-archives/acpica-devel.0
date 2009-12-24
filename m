Content-Type: multipart/mixed; boundary="===============8182963076182234327=="
MIME-Version: 1.0
From: Len Brown <lenb at kernel.org>
Subject: Re: [Devel] Regarding ACPI library
Date: Thu, 24 Dec 2009 15:16:51 -0500
Message-ID: <alpine.LFD.2.00.0912241507390.4159@localhost.localdomain>
In-Reply-To: 6b4365880912231733v58fb8b84wf3bc896113328421@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8182963076182234327==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 23 Dec 2009, nisha jain wrote:

> Hi All,
> =

> I am working on research related to Power management and control for sing=
le and multiprocessors and I came across ACPI standard. I want
> to get all CPU power information (c state and frequency p state informati=
on) for different applications and kernel processes running
> into system (with load).=C2=A0 I went through user manual of the ACPI and=
 as per my understaning there is some information written by the
> ACPI HW/SW module and ACPI is already a part of most Linux kernels.I went=
 through all the acpi site but there is no sample program to
> show its usage also i have installed the UNIX Format Source Code and Buil=
d Environment and=C2=A0 UNIX Format Test Suite of the ACPI and
> successfully compiled it. I am not sure how and which acpi APIs needs to =
be called to get such information and how to install the ACPI
> library...Also I want to control CPU frquency and state not sure how to a=
chieve it using ACPI library?
> =

> I am using an environment with Intel Dual Core Tm processor and Ubuntu pl=
atform.

Hi Nisha,
ACPI is an interface between the hardware and the OS,
not an interface between the kernel and user-space.

So generally the ACPICA core is hidden inside the kernel
and not directly visible to user-space.

So your question is really about the Linux APIs for
user-space utilities to get to the stuff that is
implemented by ACPI.

On Linux, we endeavor to expose ACPI directly to application layer
only for debugging hooks -- eg the old /proc/acpi/*
and the new /sys/firmware/acpi/*

In general, we try to have generic policy code that doesn't
directly know if ACPI is involved in the underlying implementation.
For example, cpufreq abstracts ACPI P-states, cpuidle
abstracts ACPI C-states, thermal abstracts ACPI thermal & T-states,
power supply abstracts ACPI battery etc.

Note that the powertop application is available in most recent distros
to grab and summarize a lot of what you may be seeking.
It looks in /sys/devices/system/cpu/* for cpufreq and cpuidle info.

cheers,
-Len Brown
Intel Open Source Technology Center

--===============8182963076182234327==--

