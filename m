Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D485272E43
	for <acpica-devel@lists.linux.dev>; Thu, 24 Jul 2025 08:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753344027; cv=none; b=DGMkfsGSil76AmNggRXD5o0/XV2RJrvFSbHs9yUPLEMGhYVBE7uuK88c+dodfPHU75kDUhNmKD8CXbaeGHXFn24Ch18ZUqRKNraZM//Cs2Tv8wZKbeWNPtZO0ZO8I0+qPagY2eW3/2pC9pCkflOROw9Pr5EIXUdjzgWA1eD3+N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753344027; c=relaxed/simple;
	bh=MZ9iUvSan3K97ELZMhoz0roLdqaBdfjuluYaezK//9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dDy9riKdDFeMVWWo19RQ4AGDJG9KRYr0PDhkXh29UzQEMI/UCDGHPD544JTENd16tYkiiUFlhTc3YzQ7CAma/NIMHv8GQBvWvzWBx6xul53VJWeYA2FqlxDpNEx+SpeQ17j7Dh+d42cTZLDKQSMZ/E12Ep8eqsLzgIlu0a+2WPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cxh0AcTi; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cxh0AcTi"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753344016; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=nhf3IJcOYSpRMKrPjWNbbcWsyyetTfh18hHD10/wjt4=;
	b=cxh0AcTiG0G5j+jpa9s0LAGShunot8JV7VJTjMV3mptWctU6YQchxAVTK7SLzQwzrjOyujYyFGxsHXkrK4X3cZcc3MleskWgBDp2PUYZ65MA4kMdDdwwlkieyQtIdliLZVd+4veCQqqrgsN3hMW05qqCL4MWExW/Sf8LF/2f2cA=
Received: from 30.246.181.19(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Wjlb2GV_1753344010 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 24 Jul 2025 16:00:11 +0800
Message-ID: <7ce9731a-b212-4e27-8809-0559eb36c5f2@linux.alibaba.com>
Date: Thu, 24 Jul 2025 16:00:09 +0800
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] vmcoreinfo: Track and log recoverable hardware errors
To: Breno Leitao <leitao@debian.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>, Robert Moore <robert.moore@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Hanjun Guo <guohanjun@huawei.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 acpica-devel@lists.linux.dev, osandov@osandov.com, konrad.wilk@oracle.com,
 linux-edac@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, kernel-team@meta.com
References: <20250722-vmcore_hw_error-v3-1-ff0683fc1f17@debian.org>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250722-vmcore_hw_error-v3-1-ff0683fc1f17@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi, Breno,

在 2025/7/23 00:56, Breno Leitao 写道:
> Introduce a generic infrastructure for tracking recoverable hardware
> errors (HW errors that did not cause a panic) and record them for vmcore
> consumption. This aids post-mortem crash analysis tools by preserving
> a count and timestamp for the last occurrence of such errors.
> 
> Add centralized logging for three common sources of recoverable hardware
> errors:

The term "recoverable" is highly ambiguous. Even within the x86
architecture, different vendors define errors differently. I'm not
trying to be pedantic about classification. As far as I know, for 2-bit
memory errors detected by scrub, AMD defines them as deferred errors
(DE) and handles them with log_error_deferred, while Intel uses
machine_check_poll. For 2-bit memory errors consumed by processes, both
Intel and AMD use MCE handling viado_machine_check(). Does your
HWERR_RECOV_MCE only focus on synchronous UE errors handled in
do_machine_check? What makes it special?

> 
>    - PCIe AER Correctable errors
>    - x86 Machine Check Exceptions (MCE)
>    - APEI/CPER GHES corrected or recoverable errors
> 
> hwerror_data is write-only at kernel runtime, and it is meant to be
> read from vmcore using tools like crash/drgn. For example, this is how
> it looks like when opening the crashdump from drgn.
> 
> 	>>> prog['hwerror_data']
> 	(struct hwerror_info[3]){
> 		{
> 			.count = (int)844,
> 			.timestamp = (time64_t)1752852018,
> 		},
> 		...
> 
> This helps fleet operators quickly triage whether a crash may be
> influenced by hardware recoverable errors (which executes a uncommon
> code path in the kernel), especially when recoverable errors occurred
> shortly before a panic, such as the bug fixed by
> commit ee62ce7a1d90 ("page_pool: Track DMA-mapped pages and unmap them
> when destroying the pool")
> 
> This is not intended to replace full hardware diagnostics but provides
> a fast way to correlate hardware events with kernel panics quickly.
> 
> Suggested-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Changes in v3:
> - Add more information about this feature in the commit message
>    (Borislav Petkov)
> - Renamed the function to hwerr_log_error_type() and use hwerr as
>    suffix (Borislav Petkov)
> - Make the empty function static inline (kernel test robot)
> - Link to v2: https://lore.kernel.org/r/20250721-vmcore_hw_error-v2-1-ab65a6b43c5a@debian.org
> 
> Changes in v2:
> - Split the counter by recoverable error (Tony Luck)
> - Link to v1: https://lore.kernel.org/r/20250714-vmcore_hw_error-v1-1-8cf45edb6334@debian.org
> ---
>   arch/x86/kernel/cpu/mce/core.c |  3 +++
>   drivers/acpi/apei/ghes.c       |  8 ++++++--
>   drivers/pci/pcie/aer.c         |  2 ++
>   include/linux/vmcore_info.h    | 14 ++++++++++++++
>   kernel/vmcore_info.c           | 18 ++++++++++++++++++
>   5 files changed, 43 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 4da4eab56c81d..cb225a42eebbb 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -45,6 +45,7 @@
>   #include <linux/task_work.h>
>   #include <linux/hardirq.h>
>   #include <linux/kexec.h>
> +#include <linux/vmcore_info.h>
>   
>   #include <asm/fred.h>
>   #include <asm/cpu_device_id.h>
> @@ -1692,6 +1693,8 @@ noinstr void do_machine_check(struct pt_regs *regs)
>   out:
>   	instrumentation_end();
>   
> +	/* Given it didn't panic, mark it as recoverable */
> +	hwerr_log_error_type(HWERR_RECOV_MCE);
>   clear:
>   	mce_wrmsrq(MSR_IA32_MCG_STATUS, 0);
>   }
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index a0d54993edb3b..ebda2aa3d68f2 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -43,6 +43,7 @@
>   #include <linux/uuid.h>
>   #include <linux/ras.h>
>   #include <linux/task_work.h>
> +#include <linux/vmcore_info.h>
>   
>   #include <acpi/actbl1.h>
>   #include <acpi/ghes.h>
> @@ -1136,13 +1137,16 @@ static int ghes_proc(struct ghes *ghes)
>   {
>   	struct acpi_hest_generic_status *estatus = ghes->estatus;
>   	u64 buf_paddr;
> -	int rc;
> +	int rc, sev;
>   
>   	rc = ghes_read_estatus(ghes, estatus, &buf_paddr, FIX_APEI_GHES_IRQ);
>   	if (rc)
>   		goto out;
>   
> -	if (ghes_severity(estatus->error_severity) >= GHES_SEV_PANIC)
> +	sev = ghes_severity(estatus->error_severity);
> +	if (sev == GHES_SEV_RECOVERABLE || sev ==  GHES_SEV_CORRECTED)
> +		hwerr_log_error_type(HWERR_RECOV_GHES);

APEI does not define an error type named GHES. GHES is just a kernel
driver name. Many hardware error types can be handled in GHES (see
ghes_do_proc), for example, AER is routed by GHES when firmware-first
mode is used. As far as I know, firmware-first mode is commonly used in
production. Should GHES errors be categorized into AER, memory, and CXL
memory instead?

Thanks.
Shuai
