Return-Path: <groeck7@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6148560B50
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B17D060B49
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698260357; x=1698865157;
 darn=lists.linuxfoundation.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=wT/xmiiSCLh2Y6rSvgnA+8oiaYPyDP9YFnNHMvs/gJ0=;
 b=B0JmFlpfdW7zc6kW4xanBFga4urC1x/XdXbz+pfFGYH4ZSv4GBgqTaIsUM6nwURthd
 FsCgD4NetbZoHZ8T59lou4Cf+eXAUBeKTxkNxUm2GO+bpJ7R7V+j7iaGtT/EsHL79DlS
 NHirW5SwoXwO+QHBxWv1yCJRezHYwaTHVyqTGIbZlQLwRfs1hBSYmn8rtRGDJ0z0gDLz
 BCTozn/CtojOBz4hlYP3o/H/Zy/FDsA1bY7N9myczIcQXrGm+KKWRywMkMEU+6k2YWh4
 B18uAX2+9tqNhiAN3ufXmH1fZhT9VNTjgcClfEnxI0mBMK2ZHEUQiWcDaIOPqvD1GE9c
 fRcg==
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 25 Oct 2023 11:59:15 -0700
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <1de5bd70-5001-4661-93e5-6135597bd9c1@roeck-us.net>
References: <20231024062018.23839-1-raag.jadav@intel.com>
 <20231024062018.23839-6-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024062018.23839-6-raag.jadav@intel.com>
Subject: Re: [Acpica-devel] [PATCH v3 5/6] hwmon: nct6775: use
 acpi_dev_hid_uid_match() for matching _HID and _UID
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
Cc: mark.rutland@arm.com, len.brown@intel.com, linux-hwmon@vger.kernel.org, will@kernel.org, linux-gpio@vger.kernel.org, mallikarjunappa.sangannavar@intel.com, robert.moore@intel.com, bala.senthil@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Jonathan.Cameron@huawei.com, acpica-devel@lists.linuxfoundation.org, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-arm-kernel@lists.infradead.org

On Tue, Oct 24, 2023 at 11:50:17AM +0530, Raag Jadav wrote:
> Convert manual _UID references to use the standard ACPI helper.
> 
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>

Applied.

Guenter
