Return-Path: <naoya.horiguchi@linux.dev>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 113A581D70
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5C50882180
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1696321756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SvHEdL127DkwY1o1/aHJZdaismZDLKyIFOf23kZMKII=;
 b=SnZnaakkCBrskHWe8xJL1L5kXJ04u9tThP9M8iKTR/CDUx+XLVjReoLcedlF6WCxvIyGD6
 OhdcyIniVLeOQ4Kzd3U+6O26XoRzrW7252N8bpgQy1lQ/Hvcody5jaKDq/8yQ6j4TdM4hz
 ijfc3ipmQGWFZBIAd/Eq8b9RfxVpS2E=
From: Naoya Horiguchi <naoya.horiguchi@linux.dev>
Message-ID: <20231003082858.GA750796@ik1-406-35019.vs.sakura.ne.jp>
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20230919022127.69732-3-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230919022127.69732-3-xueshuai@linux.alibaba.com>
Subject: Re: [Acpica-devel] [RESEND PATCH v8 2/2] ACPI: APEI: handle
 synchronous exceptions in task work
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Tue, 03 Oct 2023 08:39:34 -0000
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: linmiaohe@huawei.com, wangkefeng.wang@huawei.com, mawupeng1@huawei.com, dave.hansen@linux.intel.com, linux-mm@kvack.org, hpa@zytor.com, acpica-devel@lists.linuxfoundation.org, will@kernel.org, ardb@kernel.org, justin.he@arm.com, x86@kernel.org, robert.moore@intel.com, linux-acpi@vger.kernel.org, mingo@redhat.com, zhuo.song@linux.alibaba.com, ying.huang@intel.com, lenb@kernel.org, ashish.kalra@amd.com, xiexiuqi@huawei.com, tanxiaofei@huawei.com, bp@alien8.de, baolin.wang@linux.alibaba.com, tglx@linutronix.de, linux-edac@vger.kernel.org, tony.luck@intel.com, gregkh@linuxfoundation.org, lvying6@huawei.com, naoya.horiguchi@nec.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org, jarkko@kernel.org, james.morse@arm.com, akpm@linux-foundation.org

On Tue, Sep 19, 2023 at 10:21:27AM +0800, Shuai Xue wrote:
> Hardware errors could be signaled by synchronous interrupt, e.g.  when an
> error is detected by a background scrubber, or signaled by synchronous
> exception, e.g. when an uncorrected error is consumed. Both synchronous and
> asynchronous error are queued and handled by a dedicated kthread in
> workqueue.
> 
> commit 7f17b4a121d0 ("ACPI: APEI: Kick the memory_failure() queue for
> synchronous errors") keep track of whether memory_failure() work was
> queued, and make task_work pending to flush out the workqueue so that the
> work for synchronous error is processed before returning to user-space.
> The trick ensures that the corrupted page is unmapped and poisoned. And
> after returning to user-space, the task starts at current instruction which
> triggering a page fault in which kernel will send SIGBUS to current process
> due to VM_FAULT_HWPOISON.
> 
> However, the memory failure recovery for hwpoison-aware mechanisms does not
> work as expected. For example, hwpoison-aware user-space processes like
> QEMU register their customized SIGBUS handler and enable early kill mode by
> seting PF_MCE_EARLY at initialization. Then the kernel will directy notify
> the process by sending a SIGBUS signal in memory failure with wrong
> si_code: the actual user-space process accessing the corrupt memory
> location, but its memory failure work is handled in a kthread context, so
> it will send SIGBUS with BUS_MCEERR_AO si_code to the actual user-space
> process instead of BUS_MCEERR_AR in kill_proc().
> 
> To this end, separate synchronous and asynchronous error handling into
> different paths like X86 platform does:
> 
> - valid synchronous errors: queue a task_work to synchronously send SIGBUS
>   before ret_to_user.
> - valid asynchronous errors: queue a work into workqueue to asynchronously
>   handle memory failure.
> - abnormal branches such as invalid PA, unexpected severity, no memory
>   failure config support, invalid GUID section, OOM, etc.
> 
> Then for valid synchronous errors, the current context in memory failure is
> exactly belongs to the task consuming poison data and it will send SIBBUS
> with proper si_code.
> 
> Fixes: 7f17b4a121d0 ("ACPI: APEI: Kick the memory_failure() queue for synchronous errors")
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Tested-by: Ma Wupeng <mawupeng1@huawei.com>
> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Reviewed-by: Xiaofei Tan <tanxiaofei@huawei.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  arch/x86/kernel/cpu/mce/core.c |  9 +---
>  drivers/acpi/apei/ghes.c       | 84 +++++++++++++++++++++-------------
>  include/acpi/ghes.h            |  3 --
>  mm/memory-failure.c            | 17 ++-----
>  4 files changed, 56 insertions(+), 57 deletions(-)
> 
...

> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 4d6e43c88489..80e1ea1cc56d 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2163,7 +2163,9 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>   *
>   * Return: 0 for successfully handled the memory error,
>   *         -EOPNOTSUPP for hwpoison_filter() filtered the error event,
> - *         < 0(except -EOPNOTSUPP) on failure.
> + *         -EHWPOISON for already sent SIGBUS to the current process with
> + *         the proper error info,

The meaning of this comment is understood, but the sentence seems to be
a little too long. Could you sort this out with bullet points (like below)?

 * Return values:
 *   0             - success
 *   -EOPNOTSUPP   - hwpoison_filter() filtered the error event.
 *   -EHWPOISON    - sent SIGBUS to the current process with the proper
 *                   error info by kill_accessing_process().
 *   other negative values - failure

> + *         other negative error code on failure.
>   */
>  int memory_failure(unsigned long pfn, int flags)
>  {
> @@ -2445,19 +2447,6 @@ static void memory_failure_work_func(struct work_struct *work)
>  	}
>  }
>  
> -/*
> - * Process memory_failure work queued on the specified CPU.
> - * Used to avoid return-to-userspace racing with the memory_failure workqueue.
> - */
> -void memory_failure_queue_kick(int cpu)
> -{
> -	struct memory_failure_cpu *mf_cpu;
> -
> -	mf_cpu = &per_cpu(memory_failure_cpu, cpu);
> -	cancel_work_sync(&mf_cpu->work);
> -	memory_failure_work_func(&mf_cpu->work);
> -}
> -

The declaration of memory_failure_queue_kick() still remains in include/linux/mm.h,
so you can remove it together.

Thanks,
Naoya Horiguchi
