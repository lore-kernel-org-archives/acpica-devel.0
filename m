Return-Path: <raag.jadav@intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1861B4090D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4E16F401DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697810418; x=1729346418;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=mpqyGKvHVXV0RlwNW1oDdHVE8qJd2jWt5MyNnvZCE9A=;
 b=U8INFiJIi1/Pm8W68opgefwHzdwwW/kR0C2QtHNCm1eFrLOCtnwq/IQL
 LONf09r53Hqry2S6NfRNvF4V29J1uiCbVMy1o6xme10hiX9KRTpDM2Vwz
 WCBWRVBY8mNygR/t9rIaiK4zJrn+R/YXe/u40kYGn2XLsaVwG+eJC8EIZ
 GgNtRqiI/tNYYPX6QOZO59blpDllV+YAPj0w/Fn1vXZ88eZkK2UPAuAs7
 v+kCVJ6yZh+XyHVWCNEaxDPUXyLomlgVljcO6b0UCxBGZtxIpZijEYOR4
 /iWmyrsGX230Z0bq7DHjAF8ZT9DFosP8fAuYt+uAZrEqhFeU1LTf16ndy A==;
Date: Fri, 20 Oct 2023 17:00:09 +0300
From: Raag Jadav <raag.jadav@intel.com>
Message-ID: <ZTKH6bNPiy1fZKEG@black.fi.intel.com>
References: <20231020084732.17130-1-raag.jadav@intel.com>
 <20231020084732.17130-5-raag.jadav@intel.com>
 <ZTJYK02w8HZg26eI@smile.fi.intel.com>
 <ZTJmnv6CsZUt0pIS@black.fi.intel.com>
 <ZTKDsBPraERaautV@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTKDsBPraERaautV@smile.fi.intel.com>
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

On Fri, Oct 20, 2023 at 04:42:08PM +0300, Andy Shevchenko wrote:
> On Fri, Oct 20, 2023 at 02:38:06PM +0300, Raag Jadav wrote:
> > On Fri, Oct 20, 2023 at 01:36:27PM +0300, Andy Shevchenko wrote:
> > > On Fri, Oct 20, 2023 at 02:17:28PM +0530, Raag Jadav wrote:
> > > > Convert manual _UID references to use standard ACPI helpers.
> > > 
> > > Yes, while not so obvious this is the correct replacement.
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > I think this is the only case which would suffer from the more obvious
> > behaviour, i.e.
> 
> No, that's not true. The same with override CPU in the other patch, where the
> check is simply absent, but the result will be the same. So, all with negation
> will suffer from the "obvious" implementation.

Forgot to add, we don't need to change the original acpi_dev_hid_uid_match()
behaviour, i.e.

bool acpi_dev_hid_uid_match(struct acpi_device *adev,
                            const char *hid2, const char *uid2)
{
        const char *hid1 = acpi_device_hid(adev);

        if (strcmp(hid1, hid2))
                return false;

        if (!uid2)
                return true;

        return acpi_dev_uid_match(adev, uid2);
}

I'm fine with both, this just makes more sense to me.

Raag
