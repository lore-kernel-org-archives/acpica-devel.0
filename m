Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828372046B1
	for <acpica-devel@lists.linux.dev>; Tue, 10 Dec 2024 20:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733864020; cv=none; b=YfcECm19EUoZSzqf6gPQbZGO9tTA8XFu93ETUxSK7RfCZxlzcDIk4XO0a0BwW1ycgzZOOnoZjqIbvBhQsuQtgmMRIdA4tATfF67agUO0zEWqBGx+w1cXBLvo7wVlCyZ2dEou+sHI5BNVSPIZMZu6u4Mzu7kqoCRgppB7tvGPrKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733864020; c=relaxed/simple;
	bh=31LfL6mjPS1xsStD1eGVuT27O7F4GBZV6V514vOglIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TAgGaFyLwt80SDhEQ+QkDZj/6pppZFs/ymyQfh3IO02EqPHVUe9Se1cFZlD67axQ0iF05fNgcvYdwxiUSm0YkJu2XLQ3X/HYbKR7V1B0Ajryk17P9StmXdoPeJ3Dh4BAchGNZEvxBiv8QbSCWt8U7pyo4mKlyFxuozkDGXJYQpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i8/+jfRV; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i8/+jfRV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733864020; x=1765400020;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=31LfL6mjPS1xsStD1eGVuT27O7F4GBZV6V514vOglIo=;
  b=i8/+jfRVGLQbOLwg5jQG6zcrvWf9YJ4zbTkvhrx6GqctsmLIOrWiDj3Z
   zSmtWpcA15mnkQfD4+Ch7XeSZTmyOiv563of1YZnW9WAuLNdBO11LxGu0
   ILCv9uR/IksZE2l6odF9C5oz8zVENeYTXQnFyurKyKMcH7t+C41O+2BoH
   rAg7vvuvC0RUZnkX137oSRp77xwKzTjZo+7Afh4u2nwclS9QtHh6kdcon
   YngI71q08ygblO37/qFyQGCoDVMeomW1Enr/PuD/e9AHkOM17zhbSdHII
   g8JDKfSvzYTDq/dk443GRI+NaWyrk93GMIuZNc6J32ludunFenzJgiUV5
   A==;
X-CSE-ConnectionGUID: 9OIyCZv7SUGcgzP1PWWFDA==
X-CSE-MsgGUID: OIhtu7D0RFSV6+vsc5hoBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34366430"
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="34366430"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 12:53:39 -0800
X-CSE-ConnectionGUID: rKdIPVNVQySlVifuPUcJYA==
X-CSE-MsgGUID: 6dcOQfZqSXmw5eYrhAUzLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="100583305"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 12:53:37 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 7ED5E11F81D;
	Tue, 10 Dec 2024 22:53:33 +0200 (EET)
Date: Tue, 10 Dec 2024 20:53:33 +0000
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v3 3/7] ACPI: bus: implement
 acpi_get_physical_device_location when !ACPI
Message-ID: <Z1iqTe5_tiJ_ehzU@kekkonen.localdomain>
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
 <20241210-fix-ipu-v3-3-00e409c84a6c@chromium.org>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210-fix-ipu-v3-3-00e409c84a6c@chromium.org>

Hi Ricardo,

On Tue, Dec 10, 2024 at 07:56:00PM +0000, Ricardo Ribalda wrote:
> Provide an implementation of acpi_get_physical_device_location that can
> be used when CONFIG_ACPI is not set.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> 
> dasadsd

Yes?

Apart from this,

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

-- 
Regards,

Sakari Ailus
