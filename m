Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795803142;
	b=w8hFEWQxJ2fFhf4TO1mtJ+l4lIBxIZgWKzSn1VyBbh0D8YofBcmL7cYKLBrdwPrgfjzE
	 Bd0I4CMW3OR9GZPucwjo0GYxv78Gx8KnCsSeG1wK7DjwCMLnWx4nzCv6Iq6zOZPQLRUhw
	 CBdb+8evvD2nkL3NGuegewju3wF3Gz6dzEHHlrdw89qTyzopDQAawJTKG0Ju7amZ+TE0b
	 VEQcptK28wJoyu3BbHcO+7368lwNk5OuSUAlU/xyDM/sI+pWW2C30iRszQ97Qv2RFRquZ
	 ETJLA/3CVQg8wAiGAF63AnAe0bAt1DbXyxPkBfegE2uNuZrRYb1osjeh0mKx0NKW/tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795803142;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=NZGcvqBJEfT7g/whVf4ukhs+6BekUU6T21N+nSw//EY=;
	b=VNtArdYxw3ii703VcMY7pOsqwenvGG4FYaV4+3b1JPCSxmltx9klds/wqLFb2n0lG8nD
	 R9SYGshawkZwb6plNUC66Oxd/Hj3id7JM5G2Xrya36sMUIauAFcZn0dmXrYiRtCBTxrsP
	 GANQBPanXKuZSo/7Qfdv6FoRwGvaBB05y4KhTpfMKR+VeQcXNQ8Sc8h3kUOnjbYguINK6
	 OPTupJImMUAn07zN64bxYc/eT6UcvONIFErTZT+RMYl8FaFwY8aypB0FBeYqoxJ1ox27l
	 4hI6fGxEKQJnmv/NaVuLulnA4L7DUzgiPzsckL92QELDO8ZXy26PR7vdUe/y9Yc0sAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=HHc77jFv;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C8C606A324
	for <acpica-devel@lists.linux.dev>; Fri, 27 Nov 2026 18:12:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67C8C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=HHc77jFv
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 891F61575;
	Fri, 27 Nov 2026 10:12:18 -0800 (PST)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBA4E3F86C;
	Fri, 27 Nov 2026 10:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795803141; bh=BX01zZQ8nHBs4mxff7UBzSukxYsQTZNUpf0gX1VR81o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HHc77jFvjaccfHJE17xqKL/IqiGPQ+BeH6zBI+g2ieHQmh2//J2eW8wELdkkk8hRu
	 dO/oTl4A3EAMrpugvgDmxQrH2rsSUmToa4UBPRb6Y5gHJGiXiSml4XSNmZSjqEaPjT
	 FKNykJLuwmnANFhWJPm0cV+aM5RAEJZy25LS3Ack=
Date: Fri, 27 Nov 2026 18:12:15 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Steven Price <steven.price@arm.com>,
	Sami Mujawar <sami.mujawar@arm.com>, thuth@redhat.com,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, Len Brown <lenb@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mark Brown <broonie@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Gavin Shan <gshan@redhat.com>,
	Sudeep Holla <sudeep.holla@kernel.org>
Subject: Re: [PATCH RFC v3 3/8] arm64: acpi: Enable ACPI CCEL support
Message-ID: <awnH_1vFvFXpny-M@e129823.arm.com>
References: <20261127-arm_cca_mr-v3-0-df3230afce8f@arm.com>
 <20261127-arm_cca_mr-v3-3-df3230afce8f@arm.com>
 <3a46bcc3-33bb-4c9d-a3e5-44144406dbda@arm.com>
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Post: <mailto:acpica-devel@lists.linux.dev>
List-Help: <mailto:acpica-devel+help@lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:acpica-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a46bcc3-33bb-4c9d-a3e5-44144406dbda@arm.com>

On Fri, Nov 27, 2026 at 04:28:01PM +0000, Suzuki K Poulose wrote:
> On 27/11/2026 15:32, Yeoreum Yun wrote:
> > From: Suzuki K Poulose <suzuki.poulose@arm.com>
> > 
> > Add support for ACPI CCEL by handling the EfiACPIMemoryNVS type memory.
> > As per UEFI specifications NVS memory is reserved for Firmware use even
> > after exiting boot services. Thus map the region as read-only.
> > 
> > Cc: Sami Mujawar <sami.mujawar@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> > Cc: Steven Price <steven.price@arm.com>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > Cc: Gavin Shan <gshan@redhat.com>
> > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > ---
> >   arch/arm64/kernel/acpi.c | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> > 
> > diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> > index 681aa2bbc3995..3d6335db882d3 100644
> > --- a/arch/arm64/kernel/acpi.c
> > +++ b/arch/arm64/kernel/acpi.c
> > @@ -354,6 +354,17 @@ void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
> >   			prot = PAGE_KERNEL_RO;
> >   			break;
> > +		case EFI_ACPI_MEMORY_NVS:
> > +			/*
> > +			 * ACPI NVS marks an area reserved for use by the
> > +			 * firmware, even after exiting the boot service.
> > +			 * This may be used by the firmware for sharing dynamic
> > +			 * tables/data (e.g., ACPI CCEL) with the OS. Map it
> > +			 * as read-only.
> > +			 */
> > +			prot = PAGE_KERNEL_RO;
> > +			break;
> > +
> 
> Unfortunately this breaks some platforms, where the NVS must be mapped
> R/W. Thats why we dropped this patch.
> 
> https://lore.kernel.org/all/20251124103329.363afcc6@foz.lan

Thanks to share. anyway it's enough to read in this series.
So I'll drop this in the next spin. Thanks!

-- 
Sincerely,
Yeoreum Yun
