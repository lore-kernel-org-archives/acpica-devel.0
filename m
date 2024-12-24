Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E076E1C5491
	for <acpica-devel@lists.linux.dev>; Tue, 24 Dec 2024 15:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735055481; cv=none; b=PDVP+560O1zo2iZM3Sfs2bDP7xEwh2Q63niPGvZhnOLbR4XD8sRS2OVFuKRdB8japaLQGFxeed7cQzWVscMJNpLntq5++VBFary+2hbn0f/vazWQjKmcC3t3293p8pJ6aL5UnyJnBCOaDrDyuBipDUdfiy/D5w5JHg5jbYcH7L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735055481; c=relaxed/simple;
	bh=Rwp65D8HlzMHS77CO6br69GE75UQy6NZ8JuSyPfrOw4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jjmU2umQ5TNE6HSnxphA1JfiWCt77gpSt/sjaFWP6XQ/hhcNhN49dmmmDMP9MZbTnBPyIXaSczldGRi/2nBn1M3gY4SxkXrFg+0DfuvTt0K0LspUYplEihXIpax6Jw7xqN8w6KnPmr4QgQKWBvpsEfk3/KVFGFcEVkEEWH4xMyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YHfV31ztqz6LDDR;
	Tue, 24 Dec 2024 23:50:03 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C1BAC14038F;
	Tue, 24 Dec 2024 23:51:16 +0800 (CST)
Received: from localhost (10.48.156.150) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Dec
 2024 16:51:15 +0100
Date: Tue, 24 Dec 2024 15:51:13 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <robert.moore@intel.com>,
	<dan.j.williams@intel.com>, <Benjamin.Cheatham@amd.com>,
	<Avadhut.Naik@amd.com>, <viro@zeniv.linux.org.uk>, <arnd@arndb.de>,
	<ira.weiny@intel.com>, <dave.jiang@intel.com>,
	<sthanneeru.opensrc@micron.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <acpica-devel@lists.linux.dev>
Subject: Re: [PATCH v2 6/9] ACPI: APEI: EINJ: Add einjv2 extension struct
Message-ID: <20241224155113.00001d29@huawei.com>
In-Reply-To: <20241205211854.43215-7-zaidal@os.amperecomputing.com>
References: <20241205211854.43215-1-zaidal@os.amperecomputing.com>
	<20241205211854.43215-7-zaidal@os.amperecomputing.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu,  5 Dec 2024 13:18:51 -0800
Zaid Alali <zaidal@os.amperecomputing.com> wrote:

> Add einjv2 extension struct and EINJv2 error types to prepare
> the driver for EINJv2 support. ACPI specifications(1) enables

Reference got lost? 

> EINJv2 by extending set_error_type_with_address struct.
> 
> Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
> ---
>  drivers/acpi/apei/einj-core.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
> index 2c57e25252ac..039d36472342 100644
> --- a/drivers/acpi/apei/einj-core.c
> +++ b/drivers/acpi/apei/einj-core.c

> +struct einjv2_extension_struct {
> +	u32 length;
> +	u16 revision;
> +	u16 component_arr_count;
> +	struct syndrome_array component_arr[];

__counted_by marking seems appropriate here.

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

