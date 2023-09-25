Return-Path: <jarkko@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C1A18410B5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EB89D4062C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1695654060;
 bh=GUTPMlEVCxAI4XqyqO0Rqf3KWAa3RuxtFqcc2gmHP1w=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
 b=pOGJqd26WmXtEWG9MwBrMWw6yfwLBt3Fw2NdJtV5xHWOD9eyLgAixcnEsCAXLJ0c4
 7TJ5DR4cATHHVbGVNr+Q3jly+GM51Q2ZlonAvbt1NhNKnW31AscOFyc1S4kvdkUiFM
 NWQyqQHZ5bj9XsrhrHNcluOpevJyyVSBpDTTYVHhmrH7/OVKUA4aUkIQWJdMfNAII+
 Hj8TmgzsACQLRXu6XyBY01uCt3rFzIl5g88tina/t3F2zrwDagissLn4I2EDC7UG+A
 Rv+zkYxxCros8yPuumZmQe9IYfZiz7vyqRTKGDzfZ1aP8XOR9pCn6QybtRugRVLJVo
 0+wnUc4uR62/Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Message-Id: <CVS371QBH3QK.3354DSBK53OFS@suppilovahvero>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20230919022127.69732-3-xueshuai@linux.alibaba.com>
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
Date: Mon, 25 Sep 2023 15:01:08 -0000
To: Shuai Xue <xueshuai@linux.alibaba.com>, rafael@kernel.org, wangkefeng.wang@huawei.com, tanxiaofei@huawei.com, mawupeng1@huawei.com, tony.luck@intel.com, linmiaohe@huawei.com, naoya.horiguchi@nec.com, james.morse@arm.com, gregkh@linuxfoundation.org, will@kernel.org
Cc: dave.hansen@linux.intel.com, linux-mm@kvack.org, hpa@zytor.com, acpica-devel@lists.linuxfoundation.org, ardb@kernel.org, justin.he@arm.com, x86@kernel.org, robert.moore@intel.com, linux-acpi@vger.kernel.org, mingo@redhat.com, zhuo.song@linux.alibaba.com, ying.huang@intel.com, lenb@kernel.org, ashish.kalra@amd.com, xiexiuqi@huawei.com, bp@alien8.de, baolin.wang@linux.alibaba.com, tglx@linutronix.de, linux-edac@vger.kernel.org, lvying6@huawei.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org, akpm@linux-foundation.org

On Tue Sep 19, 2023 at 5:21 AM EEST, Shuai Xue wrote:
> Hardware errors could be signaled by synchronous interrupt, e.g.  when an
> error is detected by a background scrubber, or signaled by synchronous
> exception, e.g. when an uncorrected error is consumed. Both synchronous a=
nd
> asynchronous error are queued and handled by a dedicated kthread in
> workqueue.
>
> commit 7f17b4a121d0 ("ACPI: APEI: Kick the memory_failure() queue for
> synchronous errors") keep track of whether memory_failure() work was
> queued, and make task_work pending to flush out the workqueue so that the
> work for synchronous error is processed before returning to user-space.
> The trick ensures that the corrupted page is unmapped and poisoned. And
> after returning to user-space, the task starts at current instruction whi=
ch
> triggering a page fault in which kernel will send SIGBUS to current proce=
ss
> due to VM_FAULT_HWPOISON.
>
> However, the memory failure recovery for hwpoison-aware mechanisms does n=
ot
> work as expected. For example, hwpoison-aware user-space processes like
> QEMU register their customized SIGBUS handler and enable early kill mode =
by
> seting PF_MCE_EARLY at initialization. Then the kernel will directy notif=
y
> the process by sending a SIGBUS signal in memory failure with wrong
> si_code: the actual user-space process accessing the corrupt memory
> location, but its memory failure work is handled in a kthread context, so
> it will send SIGBUS with BUS_MCEERR_AO si_code to the actual user-space
> process instead of BUS_MCEERR_AR in kill_proc().
>
> To this end, separate synchronous and asynchronous error handling into
> different paths like X86 platform does:
>
> - valid synchronous errors: queue a task_work to synchronously send SIGBU=
S
>   before ret_to_user.
> - valid asynchronous errors: queue a work into workqueue to asynchronousl=
y
>   handle memory failure.
> - abnormal branches such as invalid PA, unexpected severity, no memory
>   failure config support, invalid GUID section, OOM, etc.
>
> Then for valid synchronous errors, the current context in memory failure =
is
> exactly belongs to the task consuming poison data and it will send SIBBUS
> with proper si_code.
>
> Fixes: 7f17b4a121d0 ("ACPI: APEI: Kick the memory_failure() queue for syn=
chronous errors")
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Tested-by: Ma Wupeng <mawupeng1@huawei.com>
> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Reviewed-by: Xiaofei Tan <tanxiaofei@huawei.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Did 7f17b4a121d0 actually break something that was not broken before?

If not, this is (afaik) not a bug fix.

BR, Jarkko

