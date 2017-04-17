Content-Type: multipart/mixed; boundary="===============9021806094490145908=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: Export mutex functions
Date: Mon, 17 Apr 2017 19:27:37 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E59345B@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E37E59332C@ORSMSX110.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============9021806094490145908==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


> -----Original Message-----
> From: Moore, Robert
> Sent: Monday, April 17, 2017 10:13 AM
> To: Guenter Roeck <linux(a)roeck-us.net>; Zheng, Lv <lv.zheng(a)intel.com>
> Cc: Wysocki, Rafael J <rafael.j.wysocki(a)intel.com>; Len Brown
> <lenb(a)kernel.org>; linux-acpi(a)vger.kernel.org; devel(a)acpica.org; li=
nux-
> kernel(a)vger.kernel.org
> Subject: RE: [PATCH] ACPICA: Export mutex functions
> =

> There is a model for the drivers to directly acquire an AML mutex
> object. That is why the acquire/release public interfaces were added to
> ACPICA.
> =

> I forget all of the details, but the model was developed with MS and
> others during the ACPI 6.0 timeframe.
> =

> =

[Moore, Robert] =



Here is the case where the OS may need to directly acquire an AML mutex:

From the ACPI spec:

19.6.2 Acquire (Acquire a Mutex)

Note: For Mutex objects referenced by a _DLM object, the host OS may also c=
ontend for ownership.




Other than this case, the OS/drivers should never need to directly acquire =
an AML mutex.
Bob


--===============9021806094490145908==--

