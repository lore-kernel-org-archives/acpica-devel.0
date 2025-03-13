Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92ACA1FBCAE
	for <acpica-devel@lists.linux.dev>; Thu, 13 Mar 2025 09:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741859435; cv=none; b=F99r4KTdEM3Ypy6Aa92N2edDyL+cH+TDltYuCmJOvd0HNOfn8lcsl6C6eCA/zRKgt0WR7kJfqaXWqsCB5uXWHmea8TqK6jsFnW5a89ghXJTlKxXN8XwK7YXNheQ7wcSx7IgiffBCIuvzD79VJi5qXjhPnCedEPc54T+1+aesw2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741859435; c=relaxed/simple;
	bh=dB2yvqOOsEflbYq2UkHyBKo7vmZfH4nODpEtWrQMEaw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ER6Jfuo84wDmmmWfOKm0sWTEhuFkYcevNKrF61/zhYcLbeBcs1cf6PXKDM4aDlSiH1iVCWS2jjvwR6XqjvW/WxZUsHPdnNKyV0tvQYxuRuKIMCAT9SAWvm8cwLhQeUoxFFxRF37eG14qvDugwD1nIW0kD0FQYaKWHW3IAthatbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZD2gW1Rlbz6J6qB;
	Thu, 13 Mar 2025 17:45:59 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 897D1140B63;
	Thu, 13 Mar 2025 17:50:30 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 13 Mar
 2025 10:50:29 +0100
Date: Thu, 13 Mar 2025 09:50:28 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <robert.moore@intel.com>,
	<dan.j.williams@intel.com>, <Benjamin.Cheatham@amd.com>,
	<Avadhut.Naik@amd.com>, <viro@zeniv.linux.org.uk>, <arnd@arndb.de>,
	<ira.weiny@intel.com>, <dave.jiang@intel.com>,
	<sthanneeru.opensrc@micron.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <acpica-devel@lists.linux.dev>
Subject: Re: [PATCH v4 3/9] ACPI: APEI: EINJ: Fix kernel test robot sparse
 warning
Message-ID: <20250313095028.000068e5@huawei.com>
In-Reply-To: <20250306234810.75511-4-zaidal@os.amperecomputing.com>
References: <20250306234810.75511-1-zaidal@os.amperecomputing.com>
	<20250306234810.75511-4-zaidal@os.amperecomputing.com>
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

On Thu,  6 Mar 2025 15:48:04 -0800
Zaid Alali <zaidal@os.amperecomputing.com> wrote:

> This patch fixes the kernel test robot warning reported here:
> https://lore.kernel.org/all/202410241620.oApALow5-lkp@intel.com/
> 
> Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
Follow up below.

> ---
>  drivers/acpi/apei/einj-core.c | 104 +++++++++++++++++++---------------
>  1 file changed, 59 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
> index 04731a5b01fa..b40ed44c4983 100644
> --- a/drivers/acpi/apei/einj-core.c
> +++ b/drivers/acpi/apei/einj-core.c
> @@ -149,7 +149,7 @@ static DEFINE_MUTEX(einj_mutex);
>   */
>  bool einj_initialized __ro_after_init;
>  
> -static void *einj_param;
> +static void __iomem *einj_param;
>  
>  static void einj_exec_ctx_init(struct apei_exec_context *ctx)
>  {
> @@ -214,21 +214,23 @@ static void check_vendor_extension(u64 paddr,
>  				   struct set_error_type_with_address *v5param)
>  {
>  	int	offset = v5param->vendor_extension;
> -	struct	vendor_error_type_extension *v;
> +	struct	vendor_error_type_extension v;
> +	void __iomem *p;
>  	u32	sbdf;
>  
>  	if (!offset)
>  		return;
> -	v = acpi_os_map_iomem(paddr + offset, sizeof(*v));
> -	if (!v)
> +	p = acpi_os_map_iomem(paddr + offset, sizeof(v));
> +	if (!p)
>  		return;
> -	get_oem_vendor_struct(paddr, offset, v);
> -	sbdf = v->pcie_sbdf;
> +	memcpy_fromio(&v, p, sizeof(v));
> +	get_oem_vendor_struct(paddr, offset, &v);
> +	sbdf = v.pcie_sbdf;
>  	sprintf(vendor_dev, "%x:%x:%x.%x vendor_id=%x device_id=%x rev_id=%x\n",
>  		sbdf >> 24, (sbdf >> 16) & 0xff,
>  		(sbdf >> 11) & 0x1f, (sbdf >> 8) & 0x7,
> -		 v->vendor_id, v->device_id, v->rev_id);
> -	acpi_os_unmap_iomem(v, sizeof(*v));
> +		 v.vendor_id, v.device_id, v.rev_id);
> +	acpi_os_unmap_iomem(p, sizeof(v));
>  }
>  
>  static void *einj_get_parameter_address(void)

Doesn't this return type want the __iomem marking as well?

> @@ -252,26 +254,30 @@ static void *einj_get_parameter_address(void)
>  		entry++;

