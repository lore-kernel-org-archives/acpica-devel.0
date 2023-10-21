Return-Path: <raag.jadav@intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9F4E884D8E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6BCEF84D90
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697871085; x=1729407085;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=naPtkrzRmbCE7KFu9q04yne3z9WnO3pY8BdWgIrnkMw=;
 b=AgBy88PnP1r4MY8kM6VovRPPgcNKaPj4l184fIDRQXd8LEAzLu4worMQ
 +BFmQccnn+CbBr75nlmr/zPmT5CgFnmYnDOMi6HQ7p0SMXSBDDi4WLOIk
 E0HCTu4hc8+WY//jRmQzeqoZoq6lmjYv/ayCJYSXj9SBIiImxmDeDbuC7
 wKpYkHpqbnA3q52nuOYbEo9S5OGGFV2YLvH2H9EKpR07F7BVscHXmzXrI
 ssA4PfO0/Q8c5NrjwQ+yxafbLlzqhr9KB60Mc0Pslx66neRNH29NRmCvw
 J6KTLy1q5MyJTaNTBhUROqKpXODQD9Bt/prJ4ZQEnPPGaCk2yulj0+MWW Q==;
Date: Sat, 21 Oct 2023 09:51:15 +0300
From: Raag Jadav <raag.jadav@intel.com>
Message-ID: <ZTN042OQ4kx1PaQt@black.fi.intel.com>
References: <20231020084732.17130-1-raag.jadav@intel.com>
 <20231020084732.17130-5-raag.jadav@intel.com>
 <ZTJYK02w8HZg26eI@smile.fi.intel.com>
 <ZTJmnv6CsZUt0pIS@black.fi.intel.com>
 <CAJZ5v0jvAeibnXSq92CBd1uXUgRnvsP0kEqfL8Du552=LT1dog@mail.gmail.com>
 <ZTLC5Jo97gYsL5wX@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZTLC5Jo97gYsL5wX@black.fi.intel.com>
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
To: "Rafael J. Wysocki" <rafael@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: mark.rutland@arm.com, len.brown@intel.com, linux-hwmon@vger.kernel.org, linux-gpio@vger.kernel.org, will@kernel.org, mallikarjunappa.sangannavar@intel.com, robert.moore@intel.com, bala.senthil@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, acpica-devel@lists.linuxfoundation.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, mika.westerberg@linux.intel.com, linux@roeck-us.net

On Fri, Oct 20, 2023 at 09:11:56PM +0300, Raag Jadav wrote:
> On Fri, Oct 20, 2023 at 07:11:53PM +0200, Rafael J. Wysocki wrote:
> > On Fri, Oct 20, 2023 at 1:38 PM Raag Jadav <raag.jadav@intel.com> wrote:
> > >
> > > On Fri, Oct 20, 2023 at 01:36:27PM +0300, Andy Shevchenko wrote:
> > > > On Fri, Oct 20, 2023 at 02:17:28PM +0530, Raag Jadav wrote:
> > > > > Convert manual _UID references to use standard ACPI helpers.
> > > >
> > > > Yes, while not so obvious this is the correct replacement.
> > > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > >
> > > I think this is the only case which would suffer from the more obvious
> > > behaviour, i.e.
> > >
> > > bool acpi_dev_uid_match(struct acpi_device *adev, const char *uid2)
> > > {
> > >         const char *uid1 = acpi_device_uid(adev);
> > >
> > >         return uid1 && uid2 && !strcmp(uid1, uid2);
> > > }
> > >
> > > That said, we can't be particularly sure about it's potential future users,
> > > especially when the usage will not be limited to just ACPI core since we're
> > > exporting it.
> > 
> > I actually agree with this, so please switch over to the above.
> 
> Will send out a v2, thanks.
> 
> Andy, can I add your review for this?

IIUC you agree with the usage format, but not the actual helper.
So I'm gonna drop it from the first patch and keep it for the rest,
except this one.

Let me know if I'm doing this wrong.

Raag
