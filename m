Content-Type: multipart/mixed; boundary="===============2055084222628884108=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [PATCH 1/2] acpi: Avoid soft lockup complaints during boot
Date: Mon, 26 Feb 2018 10:51:06 +0100
Message-ID: <CAJZ5v0gP2_mTmS4GBMETj+yxFH76eth1V63adgYkqoeiMW7ErA@mail.gmail.com>
In-Reply-To: 1519402695.2904.10.camel@wdc.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2055084222628884108==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2018 at 5:18 PM, Bart Van Assche <Bart.VanAssche(a)wdc.com>=
 wrote:
> On Fri, 2018-02-23 at 11:05 +0100, Rafael J. Wysocki wrote:
>> On Fri, Feb 23, 2018 at 1:22 AM, Bart Van Assche <bart.vanassche(a)wdc.c=
om> wrote:
>> > Avoid that the following is reported during boot with kmemleak
>> > enabled:
>>
>> OK, so why is this fix the right one in your view?
>
> No Linux kernel code should keep running for multiple seconds without giv=
ing
> the scheduler a chance to schedule another thread. Hence the insertion of=
 the
> cond_resched() call.

I see.

> It is very well possible that the fact that this code keeps the CPU for
> itself so long is a bug by itself. However, I'm not familiar enough with =
the
> ACPI code to figure out whether any alternative solutions exist that woul=
d be
> better than the patch I posted.

OK, we'll look at the code and see how it can be improved upstream.

Thanks a lot for letting us know about this issue!

--===============2055084222628884108==--

