Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37AA13B58A
	for <acpica-devel@lists.linux.dev>; Tue, 22 Oct 2024 22:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729635071; cv=none; b=TLaMvvtTzQTscQWFDzOlTkDHJwJxVILh7AC6/AFXg3YpHf47WLFw0WpmMxEELe3egSR1wbMylokyH2M7ciiaxnC6Oj8qGlK67yKVrMSl6B2dONBQSEGLdYkIUF/rNW7fzVFAnPrraTwDlqklrxo4g+ZUpZL4yta+nvAaK001O24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729635071; c=relaxed/simple;
	bh=HhjXGOIoQmTl111qLHD0aSi7QzSy2hSuthAv88Ng8Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2BOnEma9Pjj1zF/gGOjkWtK7+JNHjPRO4JCxl61hAuQp2BBc/Iv/Y19moWj5PlM8geeeNkyewWw+b3JMaFWqRpaz0Dqw6kTIAsONfGpCylvOJSYe7blj2JPcCQY4MKUhOaJI/LFHvmmlj7q9F7EBShn8qha3hEu5s39U9QninQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dy6wZo6R; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dy6wZo6R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729635070; x=1761171070;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HhjXGOIoQmTl111qLHD0aSi7QzSy2hSuthAv88Ng8Pg=;
  b=Dy6wZo6RaKrm83Hd5PFPYqz1yv7o2Dkg9C5FRpM0HWh8ba2YVZPexmFb
   aDKrnQaYhr1r7Eyqa7Y0tjptQ5UBFsXbuYOyat1HZC0Ce36fdCwjVPO9l
   peXUdWZGYW31mUUS8Wf/Czgty0lGG/wlQ362d5VrIKtj2w4uFXvP5UFn1
   O5Nalg2Sig0wfADqLLFwWzJn/3Sb80X2njCWcTbwmJibtC+Hqc3ptKFSV
   OPemCLHnOB7O+RXaQpDUkIB/HAabiUWMYAmhB8H/nPc8gMyxYwzCpig34
   Wh+gf54DhiyQd4/Kc/gXMUj+hV6C31BsxrMptc3zACdqORVrNO92hLKYG
   g==;
X-CSE-ConnectionGUID: DlFN5qlAQm+tipH3hdf4vA==
X-CSE-MsgGUID: WuHY9GkySeKsOFngaAis2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="46661306"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="46661306"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 15:11:10 -0700
X-CSE-ConnectionGUID: j7ea8Mo0Q3WhidcU3RqWAQ==
X-CSE-MsgGUID: ROGVkmVsSfOu1cwnRhFiKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="110801841"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 15:11:02 -0700
Date: Tue, 22 Oct 2024 15:10:59 -0700
From: Tony Luck <tony.luck@intel.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>
Cc: rafael@kernel.org, lenb@kernel.org, james.morse@arm.com, bp@alien8.de,
	robert.moore@intel.com, dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com, Benjamin.Cheatham@amd.com,
	Avadhut.Naik@amd.com, viro@zeniv.linux.org.uk, arnd@arndb.de,
	ira.weiny@intel.com, dave.jiang@intel.com,
	sthanneeru.opensrc@micron.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH 4/8] ACPI: APEI: EINJ: Enable the discovery of EINJv2
 capabilities
Message-ID: <Zxgi87DJvsUKTAyb@agluck-desk3.sc.intel.com>
References: <20241022213429.1561784-1-zaidal@os.amperecomputing.com>
 <20241022213429.1561784-5-zaidal@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022213429.1561784-5-zaidal@os.amperecomputing.com>

On Tue, Oct 22, 2024 at 02:34:25PM -0700, Zaid Alali wrote:
> @@ -692,7 +704,7 @@ int einj_validate_error_type(u64 type)
>  	if (tval & (tval - 1))
>  		return -EINVAL;
>  	if (!vendor)
> -		if (!(type & available_error_type))
> +		if (!(type & (available_error_type)))

Extra parentheses around available_error_type not needed.

-Tony
