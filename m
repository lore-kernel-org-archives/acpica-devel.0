Content-Type: multipart/mixed; boundary="===============8475187699677105220=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH v2 1/1] ACPI: scan: Use unique number for
 instance_no
Date: Fri, 19 Mar 2021 19:51:00 +0100
Message-ID: <CAJZ5v0jihmos4gza_+0MzGsUfxJJ-5LGBOURVebdGsE_RuPhFA@mail.gmail.com>
In-Reply-To: 20210319183234.23629-1-andriy.shevchenko@linux.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8475187699677105220==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 19, 2021 at 7:33 PM Andy Shevchenko
<andriy.shevchenko(a)linux.intel.com> wrote:
>
> Current mechanism of incrementing and decrementing plain integer
> to get a next free instance_no when creating an ACPI device is buggy.
>
> The simple integer and operations line increment and decrement
> on top of it can't cover the possible gaps during run time. The
> arbitrary instantiation and elimination of the devices is racy

But it isn't racy AFAICS.  It always happens under acpi_device_lock().

> and after a couple of iterations with unequal amount of devices
> being added and removed we may reproduce a bug:
--===============8475187699677105220==--

