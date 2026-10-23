Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792790896;
	b=unuzchR2XJ/TRSjWeUel3wL48m0m1uSfYB9giMKiGAjIawhjJhI848pKqT/viTLBp78R
	 l9g22upQdNSi20ZlrurlxCQW23ctKvU36NpW9mx/4FwQcFyupfaLjJTbPeN4t6mb0385k
	 WlueD/LNeYugI61PIuzEJbGbL4r/YA1rWv+d8srahFDVNtOljsT4oQREWTXTMc5Yl9fuI
	 jEZNb08ZmWYPqHOqlVJxQVeugQm+o534qZehwYKcA8G9epjv/9dU69GRVyZRDxcG7ctYV
	 w3goepO2IdFPhZbea6rXdGjdfELs3JPkUjtWT/ihRyRDlhv0qC49HZNVfHGb5mw4Gsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792790896;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=er4qv3iW6ReEviLeQ7+Y/klQYMZb0hBjkTnny5nEesc=;
	b=vba3ublpFdimwHAFNy0sIA4BDB3S4Lwh75Of29kmsgQ0lgyyKe9nKf1YWw+6qP2glkXk
	 oTtc5BnOS8LlzYuNTN6QNJksTgmstar75WSD/kHuBjuCuFsQHl1PcEXS/0YB/kJ3RDPoV
	 s5s3n5ZfuoecRP1iD6/Hy4X8/HCkyQpCmHHduGhK4gDhN/z5eXqttELwi1Br351VWp27h
	 C5Pe65cowtoM4AGflH+vp1Vl+bSH8N30SNN4gLIP/sCFUTH1QZ2wMPCceve4NJCaebUpq
	 19O+P6H9rWCNiZWtZJiXeeuJeGzZJmhY7K7GuF2HU6Z+FKeZHuikBPJY4FPtJdoSW0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=SAGAM0GM;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAA3606A31B
	for <acpica-devel@lists.linux.dev>; Fri, 23 Oct 2026 21:28:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DAA3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=SAGAM0GM
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 2E9BF20B7166; Fri, 23 Oct 2026 14:28:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2E9BF20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1792790886;
	bh=er4qv3iW6ReEviLeQ7+Y/klQYMZb0hBjkTnny5nEesc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SAGAM0GMPN5hY/uqsyBVf+tch0AHWQ2N1FNAQlF6AMkVYNgkss+DhI+eS72EJS8IK
	 lBN2pTJrLNJtxpvvpbT0XFmh5ltHnU1HRYv7H+vOb7dpPROLZ9q4Y+4eMhXgX0cWh3
	 G6sQeJjRANWv/Y4HJe1u3rz2JkTac68el+sK1r+Y=
Date: Fri, 23 Oct 2026 17:28:06 -0400
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, linux-efi@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	acpica-devel@lists.linux.dev
Subject: Re: [PATCH 1/2] ACPI: TAD: introduce acpi_tad_rtc_available()
Message-ID: <atvRZteFnxElaBhE@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20261022211304.2285792-1-hamzamahfooz@linux.microsoft.com>
 <70ca0757-f72d-4e9b-bcdf-c5a4a0ee7124@app.fastmail.com>
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Post: <mailto:acpica-devel@lists.linux.dev>
List-Help: <mailto:acpica-devel+help@lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:acpica-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70ca0757-f72d-4e9b-bcdf-c5a4a0ee7124@app.fastmail.com>

Hi Ard,

On Fri, Oct 23, 2026 at 03:50:20PM +0200, Ard Biesheuvel wrote:
> Hello Hamza,
> 
> On Thu, 22 Oct 2026, at 23:13, Hamza Mahfooz wrote:
> > Code outside of the TAD driver, such as the EFI subsystem, may need to
> > know whether or not the RTC can be driven via the ACPI TAD, for example
> > to avoid registering a redundant RTC.
> >
> > For this purpose, add a new header, include/acpi/acpi_tad.h, containing
> > a define for the TAD's hardware ID, the TAD capability flags moved there
> > from the driver, and a helper, acpi_tad_rtc_available(), that returns
> > whether or not acpi-tad will register an RTC class device for a TAD.
> >
> > acpi-tad does that for a TAD that implements the Get/Set Real Time
> > methods, as advertised by bit 2 of its _GCP return value, but only if
> > the TAD has been enumerated as a platform device, so make the helper
> > check both.
> >
> > Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> > ---
> >  drivers/acpi/acpi_tad.c | 15 ++-------
> >  include/acpi/acpi_tad.h | 67 +++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 70 insertions(+), 12 deletions(-)
> >  create mode 100644 include/acpi/acpi_tad.h
> >
> > diff --git a/drivers/acpi/acpi_tad.c b/drivers/acpi/acpi_tad.c
> > index 45459a4ca..5fb978523 100644
> > --- a/drivers/acpi/acpi_tad.c
> > +++ b/drivers/acpi/acpi_tad.c
> > @@ -33,21 +33,12 @@
> >  #include <linux/rtc.h>
> >  #include <linux/suspend.h>
> > 
> > +#include <acpi/acpi_tad.h>
> > +
> >  MODULE_DESCRIPTION("ACPI Time and Alarm (TAD) Device Driver");
> >  MODULE_LICENSE("GPL v2");
> >  MODULE_AUTHOR("Rafael J. Wysocki");
> > 
> > -/* ACPI TAD capability flags (ACPI 6.6, Section 9.17.2) */
> > -#define ACPI_TAD_AC_WAKE	BIT(0)
> > -#define ACPI_TAD_DC_WAKE	BIT(1)
> > -#define ACPI_TAD_RT		BIT(2)
> > -#define ACPI_TAD_RT_IN_MS	BIT(3)
> > -#define ACPI_TAD_S4_S5__GWS	BIT(4)
> > -#define ACPI_TAD_AC_S4_WAKE	BIT(5)
> > -#define ACPI_TAD_AC_S5_WAKE	BIT(6)
> > -#define ACPI_TAD_DC_S4_WAKE	BIT(7)
> > -#define ACPI_TAD_DC_S5_WAKE	BIT(8)
> > -
> >  /* ACPI TAD alarm timer selection */
> >  #define ACPI_TAD_AC_TIMER	(u32)0
> >  #define ACPI_TAD_DC_TIMER	(u32)1
> > @@ -895,7 +886,7 @@ static int acpi_tad_probe(struct platform_device *pdev)
> >  }
> > 
> >  static const struct acpi_device_id acpi_tad_ids[] = {
> > -	{"ACPI000E", 0},
> > +	{ACPI_TAD_HID, 0},
> >  	{}
> >  };
> > 
> > diff --git a/include/acpi/acpi_tad.h b/include/acpi/acpi_tad.h
> > new file mode 100644
> > index 000000000..4825e10e9
> > --- /dev/null
> > +++ b/include/acpi/acpi_tad.h
> > @@ -0,0 +1,67 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * ACPI Time and Alarm Device (TAD) definitions (ACPI 6.6, Section 9.17)
> > + */
> > +#ifndef __ACPI_TAD_H
> > +#define __ACPI_TAD_H
> > +
> > +#include <linux/acpi.h>
> > +#include <linux/bits.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/types.h>
> > +
> > +#define ACPI_TAD_HID		"ACPI000E"
> > +
> > +/* ACPI TAD capability flags (ACPI 6.6, Section 9.17.2) */
> > +#define ACPI_TAD_AC_WAKE	BIT(0)
> > +#define ACPI_TAD_DC_WAKE	BIT(1)
> > +#define ACPI_TAD_RT		BIT(2)
> > +#define ACPI_TAD_RT_IN_MS	BIT(3)
> > +#define ACPI_TAD_S4_S5__GWS	BIT(4)
> > +#define ACPI_TAD_AC_S4_WAKE	BIT(5)
> > +#define ACPI_TAD_AC_S5_WAKE	BIT(6)
> > +#define ACPI_TAD_DC_S4_WAKE	BIT(7)
> > +#define ACPI_TAD_DC_S5_WAKE	BIT(8)
> > +
> > +#if IS_ENABLED(CONFIG_ACPI_TAD) && IS_ENABLED(CONFIG_RTC_CLASS)
> > +/**
> > + * acpi_tad_rtc_available - Check if the RTC can be driven via the ACPI TAD
> > + *
> > + * Check if there is a TAD that the acpi-tad driver will register an RTC class
> > + * device for.
> > + *
> > + * Context: Process context, after the ACPI namespace has been scanned.
> > + *
> > + * Return: %true if acpi-tad will provide an RTC, %false otherwise.
> > + */
> > +static inline bool acpi_tad_rtc_available(void)
> > +{
> > +	struct acpi_device *adev;
> > +	unsigned long long caps;
> > +	struct device *dev;
> > +	acpi_status status;
> > +
> 
> This needs a acpi_disabled check I think
> 
> > +	adev = acpi_dev_get_first_match_dev(ACPI_TAD_HID, NULL, -1);
> > +	if (!adev)
> > +		return false;
> > +
> > +	dev = bus_find_device_by_acpi_dev(&platform_bus_type, adev);
> > +	if (!dev) {
> > +		acpi_dev_put(adev);
> > +		return false;
> > +	}
> > +	put_device(dev);
> > +
> > +	status = acpi_evaluate_integer(adev->handle, "_GCP", NULL, &caps);
> > +	acpi_dev_put(adev);
> > +
> > +	return ACPI_SUCCESS(status) && (caps & ACPI_TAD_RT);
> > +}
> > +#else
> > +static inline bool acpi_tad_rtc_available(void)
> > +{
> > +	return false;
> > +}
> > +#endif /* CONFIG_ACPI_TAD && CONFIG_RTC_CLASS */
> > +
> > +#endif /* __ACPI_TAD_H */
> 
> I get that the mutual exclusion is a bit tricky to model here, but
> I'm not crazy about the general shape of this patch.
> 
> Can we make this look more like 'acpi_has_watchdog()' today, i.e.,
> move this into the acpi-tad driver and export it, and call it from
> the rtc-efi driver? That will make rtc-efi.ko depend on acpi-tad.ko
> when both are built as modules, which is what we actually want to
> happen in this case because we might get stuck without an RTC
> otherwise if the module is denylisted etc.
> 
> E.g., add this to linux/acpi.h
> 
> #if IS_REACHABLE(CONFIG_ACPI_TAD)
> bool acpi_has_rtc(void);
> #else
> static inline bool acpi_has_rtc(void) { return false; }
> #endif
> 
> and decline the rtc-efi driver probe if it returns true.
> 
> We'll need to add a rule to RTC_EFI to ensure that both
> drivers are available, i.e.,
> 
> depends on !ACPI || ACPI_TAD
> 
> Even nicer would be if we could unbind acpi-tad from ACPI000E:00
> and bind rtc-efi instead at runtime, but that would require acpi_has_rtc()
> to take into account whether anything is bound to the driver, so I'm
> not sure if that is feasible.

I did look into this suggestion but I couldn't think of a clean way to
implement it. Also, it appears that we would have to switch rtc-efi from
module_platform_driver_probe() to module_platform_driver() (of which I
don't know if there is an appetite for). So, I've left it be for now.
