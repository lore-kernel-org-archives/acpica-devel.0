Return-Path: <raag.jadav@intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2DD9760758
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7348460672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697801896; x=1729337896;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=JePTitzuY0GQtcJN+j6l1yJWlx9JL0zZgTWlbLVx8N8=;
 b=nupC0tlijozd+DTfO72h2e9ZcrXW7s58OzbIafGY8fYMPECWeUDibOJo
 kNUUKlWynucxJTQC2tQvyzxOPMklW17KaVnWbc69TIZOym55gXV/Oj5La
 V/kWB+Vb9vrRBoPyTFHW1TsAqxHVMm3DJpfveMwZufHPEXSnP2pZtW7bG
 wIbaoLYaaOkBnorxXPJJD0nzrq1XjeVbdoeOel6K81jdJuVteBz8qjzKW
 hHAg8p08UF+OMErL/HNDCztJpj2y60X6GBd+hBYk6ybhQGvqmkQNCBG4x
 tPDUEoK3bPdNk2evxl9x+n9qmxwsbDCwS6LNYiz7OLTPVNdco0ICAa4H2 g==;
Date: Fri, 20 Oct 2023 14:38:06 +0300
From: Raag Jadav <raag.jadav@intel.com>
Message-ID: <ZTJmnv6CsZUt0pIS@black.fi.intel.com>
References: <20231020084732.17130-1-raag.jadav@intel.com>
 <20231020084732.17130-5-raag.jadav@intel.com>
 <ZTJYK02w8HZg26eI@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTJYK02w8HZg26eI@smile.fi.intel.com>
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
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: mark.rutland@arm.com, len.brown@intel.com, will@kernel.org, linux-gpio@vger.kernel.org, mallikarjunappa.sangannavar@intel.com, robert.moore@intel.com, bala.senthil@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, acpica-devel@lists.linuxfoundation.org, linux-hwmon@vger.kernel.org, mika.westerberg@linux.intel.com, linux@roeck-us.net

On Fri, Oct 20, 2023 at 01:36:27PM +0300, Andy Shevchenko wrote:
> On Fri, Oct 20, 2023 at 02:17:28PM +0530, Raag Jadav wrote:
> > Convert manual _UID references to use standard ACPI helpers.
> 
> Yes, while not so obvious this is the correct replacement.
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I think this is the only case which would suffer from the more obvious
behaviour, i.e.

bool acpi_dev_uid_match(struct acpi_device *adev, const char *uid2)
{
        const char *uid1 = acpi_device_uid(adev);

        return uid1 && uid2 && !strcmp(uid1, uid2);
}

That said, we can't be particularly sure about it's potential future users,
especially when the usage will not be limited to just ACPI core since we're
exporting it.

Raag
