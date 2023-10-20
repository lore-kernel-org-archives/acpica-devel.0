Return-Path: <andriy.shevchenko@linux.intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B1C8170507
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D5A91703DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697809338; x=1729345338;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=5II17EGmJAiyNI3Q5XungjMq7Um49xLUOEDi/+9mSCY=;
 b=TnP27UQeANf38vRIqiZi40amw5QkkqW+lWABeEvS9PBnhaI1z0CWpVGF
 9YHc9UP1aSJjAsy1xweRbSprzskAfWCOYavdBGR8c3ga0K0KnF2XUDqaZ
 YHHyBgjV+xMJFSXtNwCm6PpBnUZsTFAz4HFxBWd4oXFUIc2yk5bH+A5w5
 JB76MnC+28tQVoBTXdV0FjIJMWi4+XA84XSIU6QRzbh4K0JpjIuDdzgtM
 zCts1g8AfHDQ3piKsSWi+GbjucX4PF/syVzvWvjqmeSBICb6Hml3SGwYV
 X20XgUwEeqsCbZtc6VjANFFJRfE6HGHoDv+c1Qdxh9O92c5r6+bYdzEE3 w==;
Date: Fri, 20 Oct 2023 16:42:08 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Message-ID: <ZTKDsBPraERaautV@smile.fi.intel.com>
References: <20231020084732.17130-1-raag.jadav@intel.com>
 <20231020084732.17130-5-raag.jadav@intel.com>
 <ZTJYK02w8HZg26eI@smile.fi.intel.com>
 <ZTJmnv6CsZUt0pIS@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTJmnv6CsZUt0pIS@black.fi.intel.com>
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
To: Raag Jadav <raag.jadav@intel.com>
Cc: mark.rutland@arm.com, len.brown@intel.com, will@kernel.org, linux-gpio@vger.kernel.org, mallikarjunappa.sangannavar@intel.com, robert.moore@intel.com, bala.senthil@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, acpica-devel@lists.linuxfoundation.org, linux-hwmon@vger.kernel.org, mika.westerberg@linux.intel.com, linux@roeck-us.net

On Fri, Oct 20, 2023 at 02:38:06PM +0300, Raag Jadav wrote:
> On Fri, Oct 20, 2023 at 01:36:27PM +0300, Andy Shevchenko wrote:
> > On Fri, Oct 20, 2023 at 02:17:28PM +0530, Raag Jadav wrote:
> > > Convert manual _UID references to use standard ACPI helpers.
> > 
> > Yes, while not so obvious this is the correct replacement.
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> I think this is the only case which would suffer from the more obvious
> behaviour, i.e.

No, that's not true. The same with override CPU in the other patch, where the
check is simply absent, but the result will be the same. So, all with negation
will suffer from the "obvious" implementation.

> bool acpi_dev_uid_match(struct acpi_device *adev, const char *uid2)
> {
>         const char *uid1 = acpi_device_uid(adev);
> 
>         return uid1 && uid2 && !strcmp(uid1, uid2);
> }
> 
> That said, we can't be particularly sure about it's potential future users,
> especially when the usage will not be limited to just ACPI core since we're
> exporting it.

-- 
With Best Regards,
Andy Shevchenko


