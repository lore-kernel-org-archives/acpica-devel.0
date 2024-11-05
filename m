Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E915B1DD86F
	for <acpica-devel@lists.linux.dev>; Tue,  5 Nov 2024 17:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730826695; cv=none; b=fT05B/EQuaGVVz41s4rt7dt0ehiLzuVIQ6D5nsEWre+UmsgZq7TN74eq52sO9L+i5ULPw0PmFQIeP5ibelHTHj+Ryk+7bLaskrhXbyU4moNBT3XXHUNQv9AbQFSvJHxG54hj7UX083OGru4Mzfi2MHOCPQZxS7rBBz1qLrEMEG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730826695; c=relaxed/simple;
	bh=k+13sDOUemdCoEV6fkj1PUKssHgSxnKjxUfr4Ze/nP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdwoNtNKEM1RDAyq5gJ7L5zQStjGLvDfUe5ih3CJcTsC6JTGw270SGxCb3XBwIXbCxAJz5QUYNplx0scHqsxI7oo4/YlKvkPcHkDx52Pz+w0QOvSlhtUIL/IIdFpZiWiO/Zkzx7ZiiG3+mqIXYeGIT+IhZUtuQhb2MKcmwV8i8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 082ECFEC;
	Tue,  5 Nov 2024 09:12:02 -0800 (PST)
Received: from bogus (unknown [10.57.55.239])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 209EE3F6A8;
	Tue,  5 Nov 2024 09:11:26 -0800 (PST)
Date: Tue, 5 Nov 2024 17:11:13 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: George Rurikov <grurikov@gmail.com>
Cc: Robert Moore <robert.moore@intel.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <lenb@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] ACPICA: Fix dereference in
 acpi_ev_address_space_dispatch()
Message-ID: <20241105171113.vifd2x2suoebpt3r@bogus>
References: <20241031173146.1459-1-grurikov@gmail.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031173146.1459-1-grurikov@gmail.com>

On Thu, Oct 31, 2024 at 05:31:46PM +0000, George Rurikov wrote:
> * # Be careful, this email looks suspicious; * WARNING!  This email has multiple suspicious indicators that suggest it is malicious, please handle links and attachments with extreme care. *
> When support for  PCC Opregion was added, validation of field_obj
> was missed.
> Based on the acpi_ev_address_space_dispatch function description,
> field_obj can be NULL, and also when acpi_ev_address_space_dispatch
> is called in the acpi_ex_region_read() NULL is passed as field_obj.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>

LGTM, please submit this to ACPICA project as specified in the documentation
if not already done. Otherwise a reference to the merge request there would
be good here.

--
Regards,
Sudeep
