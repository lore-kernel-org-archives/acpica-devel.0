Return-Path: <raag.jadav@intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 33936705A1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 59F3670578
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697825517; x=1729361517;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=voEK7holIGvvAdy/wSR3LlIkMHvaF8zMe1eSBNdjLo0=;
 b=B1QX3J8GLxMwkTk4bzQv0Z5pGwap0f7oOlbYpBbTOO+HoQZh3Z5cw5Vk
 v4extxesYF00z4anLvZwERyKTVUxkfKwhQWBh9Q5TWdzfklI1SdEZwMs7
 yVVYND7NSZ8WwiwbkTgh7cbPdEHDt7j/a5nQlLHDFGRRaHyfWmQBFajje
 mDYAsl2Kdayjo6VC1jLuGgSaujzkBqDNZiODRK6cnqrXdy8x2Ziod2pxb
 6kbl7SY7c4qNs03JsGJLdvuxtRqtdI7+k12/mH4Rlk5yS6Mq9pOGprVwl
 sn+hU2F4hx3iUtLMRxWujr95qMS170efEmYNqZTxfIIdD5EV/FxqvXjty A==;
Date: Fri, 20 Oct 2023 21:11:48 +0300
From: Raag Jadav <raag.jadav@intel.com>
Message-ID: <ZTLC5Jo97gYsL5wX@black.fi.intel.com>
References: <20231020084732.17130-1-raag.jadav@intel.com>
 <20231020084732.17130-5-raag.jadav@intel.com>
 <ZTJYK02w8HZg26eI@smile.fi.intel.com>
 <ZTJmnv6CsZUt0pIS@black.fi.intel.com>
 <CAJZ5v0jvAeibnXSq92CBd1uXUgRnvsP0kEqfL8Du552=LT1dog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jvAeibnXSq92CBd1uXUgRnvsP0kEqfL8Du552=LT1dog@mail.gmail.com>
Subject: Re: [Acpica-devel] [PATCH v1 4/8] ACPI: utils: use
 acpi_dev_uid_match() for matching _UID
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: mark.rutland@arm.com, len.brown@intel.com, linux-hwmon@vger.kernel.org, linux-gpio@vger.kernel.org, will@kernel.org, mallikarjunappa.sangannavar@intel.com, robert.moore@intel.com, bala.senthil@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, acpica-devel@lists.linuxfoundation.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, mika.westerberg@linux.intel.com, linux@roeck-us.net

On Fri, Oct 20, 2023 at 07:11:53PM +0200, Rafael J. Wysocki wrote:
> On Fri, Oct 20, 2023 at 1:38 PM Raag Jadav <raag.jadav@intel.com> wrote:
> >
> > On Fri, Oct 20, 2023 at 01:36:27PM +0300, Andy Shevchenko wrote:
> > > On Fri, Oct 20, 2023 at 02:17:28PM +0530, Raag Jadav wrote:
> > > > Convert manual _UID references to use standard ACPI helpers.
> > >
> > > Yes, while not so obvious this is the correct replacement.
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > I think this is the only case which would suffer from the more obvious
> > behaviour, i.e.
> >
> > bool acpi_dev_uid_match(struct acpi_device *adev, const char *uid2)
> > {
> >         const char *uid1 = acpi_device_uid(adev);
> >
> >         return uid1 && uid2 && !strcmp(uid1, uid2);
> > }
> >
> > That said, we can't be particularly sure about it's potential future users,
> > especially when the usage will not be limited to just ACPI core since we're
> > exporting it.
> 
> I actually agree with this, so please switch over to the above.

Will send out a v2, thanks.

Andy, can I add your review for this?

Raag
