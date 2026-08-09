Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D25D33F5AE
	for <acpica-devel@lists.linux.dev>; Sun,  9 Aug 2026 10:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786270413; cv=none; b=mY9jid3you5/2iIn+mNYsB0gCHkWSwJ3yELNjhDrJdxEzWUFg+MRdCPAL90AJ/SjBoX0H+jz36d6y8C+AFAbMDYjL71uCpzB+aqPFetk/w7uAKqKqdJKjPsu5syUjlH0IR6k7eHkezn2b5yUbCe/SaFaQlNTlISWTeIdYhSkS7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786270413; c=relaxed/simple;
	bh=Wvx7wBGn352ia1JVXQ7COgBMRtejoYYRe6SR7eqdabU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=K6Nx1NeK6dueZZa2pcLw6QB7ZjGE0InqYZUNv6Dpg5kynnhVYQdOAgo0RZoEpcpm6Lj4Ejkv2G9j5UYnZtLoUA0PwQcfJqRhzyDvo/12kmmlq9tCFxGRQEbDiPhR6tFST10Wvc4OqfWywSBvo0Ld9t4lLZoXsfc137+Fl7iBZWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-49f3a97f1caso596887b6e.0
        for <acpica-devel@lists.linux.dev>; Sun, 09 Aug 2026 03:13:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786270411; x=1786875211;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=II4IW74KW9UA7bbeb+dNchQ2rFI7+y7P77iR5Skd0+Y=;
        b=YNdjwHkemORuMrnuc8i1lk/udYi8w1hkUfpZUTc0W9uhaQPNC1QR4Uq5DcW3szB+og
         UNnUwV8TiJiWM3bG8OZKshTkOKkVlZU2VFp1uid7xMNc/HB2fgKb/EoymIDs9RwiKEyD
         YYWXuodjg9Yqf+f1pirIzbXuWWs0PqAivUT6n0y/PCLGxJI5a8ATWKjcaevKLE/t9I/A
         SCU0GIEt/MDHs6kskTuBY606Ju15pZHqWYhjWkBMyrPNWU16WGw5EuDYd3VdL005N4k6
         CD5AvO93jQ2Kz8+/Pe0b4LCp3uGCTIt2g0qeEyT/DOygtV2eWIB020cye2aKQpiqUzo7
         PtPQ==
X-Gm-Message-State: AOJu0Yz5tSVHRW0C3lzfPIQ7tMK37GL/TGxMHPKlqoytwBWWfAP9ujzg
	IvMVOBGprqQCywE215GwsYZf7mk6RnjB/lRl3JKAU5S4NL7sHSO2sTmrc8REzQdqhcFr9JmJvCv
	7RR0wNydgAlSZIniA/99djgM9l2jWh0sySkCu/ivFQ4/ZRA8STpzDNw/CkEO3sg==
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:124e:b0:489:5d05:552c with SMTP id
 5614622812f47-4b1aba7875bmr5989872b6e.18.1786270411277; Sun, 09 Aug 2026
 03:13:31 -0700 (PDT)
Date: Sun, 09 Aug 2026 03:13:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7852cb.01d0871a.3a0d52.0085.GAE@google.com>
Subject: [syzbot] [acpica?] KCSAN: data-race in vsnprintf / vsnprintf
From: syzbot <syzbot+f043307fae47600f98f4@syzkaller.appspotmail.com>
To: acpica-devel@lists.linux.dev, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rafael@kernel.org, robert.moore@intel.com, 
	saket.dumbre@intel.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    848acc8ffe1b Merge tag 'fsverity-for-linus' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1283b649580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=84b3039e8461eef5
dashboard link: https://syzkaller.appspot.com/bug?extid=f043307fae47600f98f4
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d1a0ae21bd78/disk-848acc8f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9be505d18eb6/vmlinux-848acc8f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8ab6a3838bc0/bzImage-848acc8f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f043307fae47600f98f4@syzkaller.appspotmail.com

**** Context Switch from TID 36034112 to TID 2691392 ****
  nsutils-0719 ns_get_node           : ----Entry ffffffff86882de5
  utmutex-0235 ut_acquire_mutex      : 
----Entry
**** Cont1292 
==================================================================
BUG: KCSAN: data-race in vsnprintf / vsnprintf

write to 0xffffffff89405bd8 of 1 bytes by task 39 on cpu 1:
 vsnprintf+0x815/0x8c0 lib/vsprintf.c:2977
 vsprintf+0x2a/0x40 lib/vsprintf.c:3090
 acpi_os_vprintf drivers/acpi/osl.c:162 [inline]
 acpi_os_printf+0x87/0x200 drivers/acpi/osl.c:153
 acpi_debug_print+0x1a9/0x200 drivers/acpi/acpica/utdebug.c:197
 acpi_ns_build_internal_name+0x589/0x5d0 drivers/acpi/acpica/nsutils.c:-1
 acpi_ns_internalize_name+0x265/0x310 drivers/acpi/acpica/nsutils.c:339
 acpi_ns_get_node_unlocked+0xed/0x2d0 drivers/acpi/acpica/nsutils.c:666
 acpi_ns_get_node+0x76/0xc0 drivers/acpi/acpica/nsutils.c:726
 acpi_get_handle+0xfd/0x180 drivers/acpi/acpica/nsxfname.c:98
 acpi_has_method+0x46/0x80 drivers/acpi/utils.c:672
 acpi_pci_set_power_state+0x5d/0x190 drivers/pci/pci-acpi.c:1084
 platform_pci_set_power_state drivers/pci/pci.c:1068 [inline]
 pci_power_up+0x40/0x3b0 drivers/pci/pci.c:1306
 pci_pm_power_up_and_verify_state+0x29/0x130 drivers/pci/pci.c:3153
 pci_pm_default_resume_early drivers/pci/pci-driver.c:591 [inline]
 pci_pm_resume_noirq+0xcb/0x320 drivers/pci/pci-driver.c:996
 dpm_run_callback+0x53/0x2f0 drivers/base/power/main.c:510
 device_resume_noirq+0x851/0x880 drivers/base/power/main.c:857
 async_resume_noirq+0x2c/0x40 drivers/base/power/main.c:879
 async_run_entry_fn+0x52/0x180 kernel/async.c:129
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0x4d4/0x9a0 kernel/workqueue.c:3405
 worker_thread+0x569/0x750 kernel/workqueue.c:3486
 kthread+0x221/0x270 kernel/kthread.c:436
 ret_from_fork+0x146/0x330 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

write to 0xffffffff89405bd8 of 1 bytes by task 12 on cpu 0:
 vsnprintf+0x815/0x8c0 lib/vsprintf.c:2977
 vsprintf+0x2a/0x40 lib/vsprintf.c:3090
 acpi_os_vprintf drivers/acpi/osl.c:162 [inline]
 acpi_os_printf+0x87/0x200 drivers/acpi/osl.c:153
 acpi_debug_print+0x1a9/0x200 drivers/acpi/acpica/utdebug.c:197
 acpi_os_wait_semaphore+0x11b/0x2b0 drivers/acpi/osl.c:1292
 acpi_ut_acquire_mutex+0x242/0x4a0 drivers/acpi/acpica/utmutex.c:241
 acpi_ns_get_node+0x46/0xc0 drivers/acpi/acpica/nsutils.c:721
 acpi_get_handle+0xfd/0x180 drivers/acpi/acpica/nsxfname.c:98
 acpi_has_method+0x46/0x80 drivers/acpi/utils.c:672
 acpi_pci_set_power_state+0x5d/0x190 drivers/pci/pci-acpi.c:1084
 platform_pci_set_power_state drivers/pci/pci.c:1068 [inline]
 pci_power_up+0x40/0x3b0 drivers/pci/pci.c:1306
 pci_pm_power_up_and_verify_state+0x29/0x130 drivers/pci/pci.c:3153
 pci_pm_default_resume_early drivers/pci/pci-driver.c:591 [inline]
 pci_pm_resume_noirq+0xcb/0x320 drivers/pci/pci-driver.c:996
 dpm_run_callback+0x53/0x2f0 drivers/base/power/main.c:510
 device_resume_noirq+0x851/0x880 drivers/base/power/main.c:857
 async_resume_noirq+0x2c/0x40 drivers/base/power/main.c:879
 async_run_entry_fn+0x52/0x180 kernel/async.c:129
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0x4d4/0x9a0 kernel/workqueue.c:3405
 worker_thread+0x569/0x750 kernel/workqueue.c:3486
 kthread+0x221/0x270 kernel/kthread.c:436
 ret_from_fork+0x146/0x330 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

value changed: 0x6d -> 0x65

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 12 Comm: kworker/u8:0 Tainted: G        W           syzkaller #0 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Workqueue: async async_run_entry_fn
==================================================================
]
Waiting for semaphore[ffff8881000c3390|1|65535]

**** Context Switch from TID 29995968 to TID 2691392 ****

      osl-1310 os_wait_semaphore     : Acquired semaphore[ffff8881000c3390|1|65535]  utmutex-0244 ut_acquire_mutex      : Thread 2691392 acquired Mutex [ACPI_MTX_Namespace]
  nsutils-0644 ns_get_node_unlocked  : ----Entry ffffffff86882de5
  nsutils-0318 ns_internalize_name   : ----Entry
  nsutils-0208 ns_build_internal_name: ----Entry
  nsutils-0289 ns_build_internal_name: Returning [ffff88810163f348] (rel) "_EJ0"
  nsutils-0293 ns_build_internal_name: ----Exit- AE_OK
  nsutils-0346 ns_internalize_name   : ----Exit- AE_OK
 nsaccess-0303 ns_lookup             : ----Entry
 nsaccess-0399 ns_lookup             : Searching relative to prefix scope [S04_] (ffff888100a953f0)
 nsaccess-0522 ns_lookup             : Simple Pathname (1 segment, Flags=2)
   nsdump-0064 ns_print_pathname     : [_EJ0]
 nssearch-0261 ns_search_and_enter   : ----Entry
 nssearch-0066 ns_search_one_scope   : ----Entry
  nsnames-0301 ns_get_normalized_path: ----Entry ffff888100a953f0
  nsnames-0202 ns_build_normalized_pa: ----Entry ffff888100a953f0
  nsnames-0275 ns_build_normalized_pa: ----Exit- 000000000000000E
  nsnames-0202 ns_build_normalized_pa: ----Entry ffff888100a953f0
  nsnames-0275 ns_build_normalized_pa: ----Exit- 000000000000000E
acpi_ns_get_normalized_pathname: Path "\_SB.PCI0.S04"
  nsnames-0326 ns_get_normalized_path: ----Exit- ffff888100aaad10
 nssearch-0074 ns_search_one_scope   : Searching \_SB.PCI0.S04 (ffff888100a953f0) For [_EJ0] (Untyped)
 nssearch-0126 ns_search_one_scope   : Name [_EJ0] (Untyped) not found in search in scope [S04_] ffff888100a953f0 first child ffff888100a953c0
 nssearch-0134 ns_search_one_scope   : ----Exit- ****Exception****: AE_NOT_FOUND
 nssearch-0364 ns_search_and_enter   : _EJ0 Not found in ffff888100a953f0 [Not adding]
 nssearch-0368 ns_search_and_enter   : ----Exit- ****Exception****: AE_NOT_FOUND
 nsaccess-0605 ns_lookup             : Name [_EJ0] not found in scope [S04_] ffff888100a953f0
 nsaccess-0644 ns_lookup             : ----Exit- ****Exception****: AE_NOT_FOUND
  nsutils-0682 ns_get_node_unlocked  : _EJ0, AE_NOT_FOUND
  nsutils-0687 ns_get_node_unlocked  : ----Exit- ****Exception****: AE_NOT_FOUND
  utmutex-0277 ut_release_mutex      : Thread 2691392 releasing Mutex [ACPI_MTX_Namespace]
      osl-1334 os_signal_semaphore   : Signaling semaphore[ffff8881000c3390|1]
  nsutils-0730 ns_get_node           : ----Exit- ****Exception****: AE_NOT_FOUND


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
