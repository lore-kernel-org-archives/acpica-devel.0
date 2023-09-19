Return-Path: <xueshuai@linux.alibaba.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E31F082218
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9F3608217B
From: Shuai Xue <xueshuai@linux.alibaba.com>
Message-Id: <20230919022127.69732-1-xueshuai@linux.alibaba.com>
In-Reply-To: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Acpica-devel] [RESEND PATCH v8 0/2] ACPI: APEI: handle synchronous
	errors in task work with proper si_code
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Tue, 19 Sep 2023 02:21:43 -0000
To: rafael@kernel.org, wangkefeng.wang@huawei.com, tanxiaofei@huawei.com, mawupeng1@huawei.com, tony.luck@intel.com, linmiaohe@huawei.com, naoya.horiguchi@nec.com, james.morse@arm.com, gregkh@linuxfoundation.org, will@kernel.org
Cc: dave.hansen@linux.intel.com, linux-mm@kvack.org, hpa@zytor.com, acpica-devel@lists.linuxfoundation.org, ardb@kernel.org, justin.he@arm.com, x86@kernel.org, robert.moore@intel.com, linux-acpi@vger.kernel.org, mingo@redhat.com, zhuo.song@linux.alibaba.com, ying.huang@intel.com, lenb@kernel.org, ashish.kalra@amd.com, xiexiuqi@huawei.com, bp@alien8.de, baolin.wang@linux.alibaba.com, tglx@linutronix.de, linux-edac@vger.kernel.org, lvying6@huawei.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org, jarkko@kernel.org, xueshuai@linux.alibaba.com, akpm@linux-foundation.org

Hi, ALL,

I have rewritten the cover letter with the hope that the maintainer will truly
understand the necessity of this patch. Both Alibaba and Huawei met the same
issue in products, and we hope it could be fixed ASAP.

changes since v7:
- rebase to Linux v6.6-rc2 (no code changed)
- rewritten the cover letter to explain the motivation of this patchset

changes since v6:
- add more explicty error message suggested by Xiaofei
- pick up reviewed-by tag from Xiaofei
- pick up internal reviewed-by tag from Baolin

changes since v5 by addressing comments from Kefeng:
- document return value of memory_failure()
- drop redundant comments in call site of memory_failure() 
- make ghes_do_proc void and handle abnormal case within it
- pick up reviewed-by tag from Kefeng Wang 

changes since v4 by addressing comments from Xiaofei:
- do a force kill only for abnormal sync errors

changes since v3 by addressing comments from Xiaofei:
- do a force kill for abnormal memory failure error such as invalid PA,
unexpected severity, OOM, etc
- pcik up tested-by tag from Ma Wupeng

changes since v2 by addressing comments from Naoya:
- rename mce_task_work to sync_task_work
- drop ACPI_HEST_NOTIFY_MCE case in is_hest_sync_notify()
- add steps to reproduce this problem in cover letter

changes since v1:
- synchronous events by notify type
- Link: https://lore.kernel.org/lkml/20221206153354.92394-3-xueshuai@linux.alibaba.com/


There are two major types of uncorrected recoverable (UCR) errors :

- Action Required (AR): The error is detected and the processor already
  consumes the memory. OS requires to take action (for example, offline
  failure page/kill failure thread) to recover this error.

- Action Optional (AO): The error is detected out of processor execution
  context. Some data in the memory are corrupted. But the data have not
  been consumed. OS is optional to take action to recover this error.

The main difference between AR and AO errors is that AR errors are synchronous
events, while AO errors are asynchronous events. Synchronous exceptions, such as
Machine Check Exception (MCE) on X86 and Synchronous External Abort (SEA) on
Arm64, are signaled by the hardware when an error is detected and the memory
access has architecturally been executed.

Currently, both synchronous and asynchronous errors are queued as AO errors and
handled by a dedicated kernel thread in a work queue on the ARM64 platform. For
synchronous errors, memory_failure() is synced using a cancel_work_sync trick to
ensure that the corrupted page is unmapped and poisoned. Upon returning to
user-space, the process resumes at the current instruction, triggering a page
fault. As a result, the kernel sends a SIGBUS signal to the current process due
to VM_FAULT_HWPOISON.

However, this trick is not always be effective, this patch set improves the
recovery process in three specific aspects:

1. Handle synchronous exceptions with proper si_code

ghes_handle_memory_failure() queue both synchronous and asynchronous errors with
flag=0. Then the kernel will notify the process by sending a SIGBUS signal in
memory_failure() with wrong si_code: BUS_MCEERR_AO to the actual user-space
process instead of BUS_MCEERR_AR. The user-space processes rely on the si_code
to distinguish to handle memory failure.

For example, hwpoison-aware user-space processes use the si_code:
BUS_MCEERR_AO for 'action optional' early notifications, and BUS_MCEERR_AR
for 'action required' synchronous/late notifications. Specifically, when a
signal with SIGBUS_MCEERR_AR is delivered to QEMU, it will inject a vSEA to
Guest kernel. In contrast, a signal with SIGBUS_MCEERR_AO will be ignored
by QEMU.[1]

Fix it by seting memory failure flags as MF_ACTION_REQUIRED on synchronous events. (PATCH 1)

2. Handle memory_failure() abnormal fails to avoid a unnecessary reboot

If process mapping fault page, but memory_failure() abnormal return before
try_to_unmap(), for example, the fault page process mapping is KSM page.
In this case, arm64 cannot use the page fault process to terminate the
synchronous exception loop.[4]

This loop can potentially exceed the platform firmware threshold or even trigger
a kernel hard lockup, leading to a system reboot. However, kernel has the
capability to recover from this error.

Fix it by performing a force kill when memory_failure() abnormal fails or when
other abnormal synchronous errors occur. These errors can include situations
such as invalid PA, unexpected severity, no memory failure config support,
invalid GUID section, OOM, etc. (PATCH 2)

3. Handle memory_failure() in current process context which consuming poison

When synchronous errors occur, memory_failure() assume that current process
context is exactly that consuming poison synchronous error.

For example, kill_accessing_process() holds mmap locking of current->mm, does
pagetable walk to find the error virtual address, and sends SIGBUS to the
current process with error info. However, the mm of kworker is not valid,
resulting in a null-pointer dereference. I have fixed this in[3].

    commit 77677cdbc2aa mm,hwpoison: check mm when killing accessing process

Another example is that collect_procs()/kill_procs() walk the task list, only
collect and send sigbus to task which consuming poison. But memory_failure() is
queued and handled by a dedicated kernel thread on arm64 platform.

Fix it by queuing memory_failure() as a task work which runs in current
execution context to synchronously send SIGBUS before ret_to_user. (PATCH 2)

** In summary, this patch set handles synchronous errors in task work with
proper si_code so that hwpoison-aware process can recover from errors, and
fixes (potentially)abnormal cases. **

Lv Ying and XiuQi from Huawei also proposed to address similar problem[2][4].
Acknowledge to discussion with them.

To reproduce this problem:

	# STEP1: enable early kill mode
	#sysctl -w vm.memory_failure_early_kill=1
	vm.memory_failure_early_kill = 1

	# STEP2: inject an UCE error and consume it to trigger a synchronous error
	#einj_mem_uc single
	0: single   vaddr = 0xffffb0d75400 paddr = 4092d55b400
	injecting ...
	triggering ...
	signal 7 code 5 addr 0xffffb0d75000
	page not present
	Test passed

The si_code (code 5) from einj_mem_uc indicates that it is BUS_MCEERR_AO error
and it is not fact.

After this patch set:

	# STEP1: enable early kill mode
	#sysctl -w vm.memory_failure_early_kill=1
	vm.memory_failure_early_kill = 1

	# STEP2: inject an UCE error and consume it to trigger a synchronous error
	#einj_mem_uc single
	0: single   vaddr = 0xffffb0d75400 paddr = 4092d55b400
	injecting ...
	triggering ...
	signal 7 code 4 addr 0xffffb0d75000
	page not present
	Test passed

The si_code (code 4) from einj_mem_uc indicates that it is BUS_MCEERR_AR error
as we expected.

[1] Add ARMv8 RAS virtualization support in QEMU https://patchew.org/QEMU/20200512030609.19593-1-gengdongjiu@huawei.com/
[2] https://lore.kernel.org/lkml/20221205115111.131568-3-lvying6@huawei.com/
[3] https://lkml.kernel.org/r/20220914064935.7851-1-xueshuai@linux.alibaba.com
[4] https://lore.kernel.org/lkml/20221209095407.383211-1-lvying6@huawei.com/

Shuai Xue (2):
  ACPI: APEI: set memory failure flags as MF_ACTION_REQUIRED on
    synchronous events
  ACPI: APEI: handle synchronous exceptions in task work

 arch/x86/kernel/cpu/mce/core.c |   9 +--
 drivers/acpi/apei/ghes.c       | 113 ++++++++++++++++++++++-----------
 include/acpi/ghes.h            |   3 -
 mm/memory-failure.c            |  17 +----
 4 files changed, 79 insertions(+), 63 deletions(-)

-- 
2.39.3

