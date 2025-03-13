Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34DF1FC3
	for <acpica-devel@lists.linux.dev>; Thu, 13 Mar 2025 09:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741858958; cv=none; b=B/xGbfVpO6t3Fn+6kxkub2dbndHWvhH9sCCnJElShwVFZ+mQn6t2hMABeWXrGChdL/wQw3kCSNaQPJKTXnMdWb1IGELPRtOuGRmfgABt/hzc4NHsh6A0YTIoQq4nv85lF6Vxm6SUun52LSCQOjZa4vG+WY+9TLhhAWK+bwknaIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741858958; c=relaxed/simple;
	bh=qZ5vfvpUrKsLdGPtkFTdyXDmyZok76YvHsEQ6mib4gQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fBo29ibOIXk0CEVJ9P35A8k6rNoiHLNLHJQWDF0Vn4xSyZZQZVnAuB/zzXhK4lfF4DYaRtwLGckKZ1k5m8U41rp6VNxxKuPwBz/RW+88WFggY8++4DBq1g1DrLdI0uGJ91FNgsyQLtk/9U3Tfzdhi1BEPlXXc+KatJJXcJ4tFFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZD2Wv3pCKz6H8g6;
	Thu, 13 Mar 2025 17:39:23 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 139F9140D26;
	Thu, 13 Mar 2025 17:42:33 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 13 Mar
 2025 10:42:32 +0100
Date: Thu, 13 Mar 2025 09:42:30 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <robert.moore@intel.com>,
	<dan.j.williams@intel.com>, <Benjamin.Cheatham@amd.com>,
	<Avadhut.Naik@amd.com>, <viro@zeniv.linux.org.uk>, <arnd@arndb.de>,
	<ira.weiny@intel.com>, <dave.jiang@intel.com>,
	<sthanneeru.opensrc@micron.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <acpica-devel@lists.linux.dev>
Subject: Re: [PATCH v4 6/9] ACPI: APEI: EINJ: Add einjv2 extension struct
Message-ID: <20250313094230.00004696@huawei.com>
In-Reply-To: <20250306234810.75511-7-zaidal@os.amperecomputing.com>
References: <20250306234810.75511-1-zaidal@os.amperecomputing.com>
	<20250306234810.75511-7-zaidal@os.amperecomputing.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu,  6 Mar 2025 15:48:07 -0800
Zaid Alali <zaidal@os.amperecomputing.com> wrote:

> Add einjv2 extension struct and EINJv2 error types to prepare
> the driver for EINJv2 support. ACPI specifications(1) enables
> EINJv2 by extending set_error_type_with_address struct.
> 
> (1) https://bugzilla.tianocore.org/show_bug.cgi?id=4615
Still seems to be down.
Also, we have tag for this.
> 
> Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>

Link: https://bugzilla.tianocore.org/show_bug.cgi?id=4615 # [1]


One additional request inline.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/acpi/apei/einj-core.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
> index aee9a7b17313..32b8d102f399 100644
> --- a/drivers/acpi/apei/einj-core.c
> +++ b/drivers/acpi/apei/einj-core.c
> @@ -50,6 +50,28 @@
>   */
>  static int acpi5;
>  
> +struct syndrome_array {
> +	union {
> +		u32	acpi_id;
> +		u32	device_id;
> +		u32	pcie_sbdf;
> +		u8	vendor_id[16];
> +	} comp_id;
> +	union {
> +		u32	proc_synd;
> +		u32	mem_synd;
> +		u32	pcie_synd;
> +		u8	vendor_synd[16];
> +	} comp_synd;
> +};
> +
> +struct einjv2_extension_struct {
> +	u32 length;
> +	u16 revision;
> +	u16 component_arr_count;
> +	struct syndrome_array component_arr[];

__counted_by(component_arr_count);
should be fine and marking these is always good to do in
new code (and old code if you have time!)


> +};
> +
>  struct set_error_type_with_address {
>  	u32	type;
>  	u32	vendor_extension;
> @@ -58,6 +80,7 @@ struct set_error_type_with_address {
>  	u64	memory_address;
>  	u64	memory_address_range;
>  	u32	pcie_sbdf;
> +	struct	einjv2_extension_struct einjv2_struct;
>  };
>  enum {
>  	SETWA_FLAGS_APICID = 1,

