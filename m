Return-Path: <andriy.shevchenko@linux.intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2596540569
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 764B540522
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688029730; x=1719565730;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=SX4TAKT5s6ztRMXiDOFeBmIy1i1UvOMhH2wnpOB8Uew=;
 b=e/fvcbSCJZFck2/wo49Z5iN9dRYeLzcQyzYFzUZqPHh+Jn7H3jUv3jSp
 WxPUuM71x1b/+y9029QJ9rGMY2VmtATgOuqTiZgI7aO3OhI3fFnHXzo5E
 /PofOvT8TituqOJ1ES45naMWka2lgBpXE4pQZ6cuzEiX/wsch0OBV7Uqt
 hoBXxOJjPpYI/CHT3OxmAx/Q2Qde7xdT8k1/mMrtgIv38ufz/UR1agd4M
 Ph9vsVo9AZn1Zeh/M8TX5g/CTdIQm2usxV96o7C4+wWVU8ikgBFymVC4Z
 0WA3305btRRNBBFahebRJqVV4FTp+qRlulvthFAePMVfEKCAchaqTsJz/ w==;
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Message-ID: <ZJ1KHJW6Jhma/rHc@smile.fi.intel.com>
References: <20230626110026.65825-1-andriy.shevchenko@linux.intel.com>
 <20230626110026.65825-2-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0jqP0N3=TB3w+HMwGMzctpRCjKa3a5iHKePP113T3CK-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jqP0N3=TB3w+HMwGMzctpRCjKa3a5iHKePP113T3CK-g@mail.gmail.com>
Subject: Re: [Acpica-devel] [PATCH v3 1/4] ACPI: bus: Constify
 acpi_companion_match() returned value
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Thu, 29 Jun 2023 09:08:51 -0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, Michael Walle <michael@walle.cc>, linux-i2c@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, Len Brown <lenb@kernel.org>

On Thu, Jun 29, 2023 at 10:49:17AM +0200, Rafael J. Wysocki wrote:
> On Mon, Jun 26, 2023 at 1:00 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > acpi_companion_match() doesn't alter the contents of the passed
> > parameter, so we don't expect that returned value can be altered
> > either. So constify it.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> This makes sense even without the rest of the series, so I can queue
> it up right away if you want me to do that.

Please, go ahead and thank you!

-- 
With Best Regards,
Andy Shevchenko


