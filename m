Return-Path: <bp@alien8.de>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 064AB41747
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5E65540296
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
 t=1698327155; bh=IJ1V12YW64qC6BC7ZhZrpC5tlmChNK1ADdplDg6cN1E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GlM4dY7kejY+5ZPpNqUXaknSK9h3QGnUbWAWftm4h2R6kml3tNrQsAM50HfvkVkAH
 JJDxckvoURo8eWdEMsw+6wH9X/ElJs+2mPj4SvaRkXA9LzvkiFwPOY3SRwEpYeY9QN
 vIokrVV6jPGeJVc44SqK8FLpCHXK4hBUzNf4CmKDff/EZLjsIaAxdOuhDsFUkD0GpO
 OS+dGWFWb571Bcgn8Y7xhNSqzqvaAWV+Y65CKVGTFRy3aKTwRLw6OQi345ovl219pZ
 jm+6K0OJ7G1LSVg2WBzI1G5HxRU8IRXVmUU0V/EgfkqKU7tVAfPMbkaa2SGOqaF8Jw
 foLokjuwiVQPaRBHWStqjg9y2QdrRmaJkXk/71tM1eH+DepiC/PO3kdzlvEXEBcKrN
 6eO5EAecViH4eM1HwZA9d1iWrdwBALWu/JioLEGn7CgEoqdHoP3IKGUaj8UgH7amlB
 EKAVcpE3u1DETWOpRlRsEusXrtHp58s+6qXB2Ylux3cPz7ePRYzhXtk9qt0F71Rh5T
 CA+ZWk8DdfBhc73MHZMrgwWEQKwiCWiuwERz5HeYDSgta8cJYSQlWCA+IaRpOErkQv
 S/LxWakrGtaQaCNJh+PXbk1w3wLcU+91tcF5cV3nD/BOf1o0iIq/zRm0k2F3IVotkD
 WcmkBrAOJtZpQRxQT7eGCQBE=
Date: Thu, 26 Oct 2023 15:32:09 +0200
From: Borislav Petkov <bp@alien8.de>
Message-ID: <20231026133209.GCZTpqWVNUmqtBrnTw@fat_crate.local>
References: <20230925074426.97856-1-xueshuai@linux.alibaba.com>
 <20230928144345.GAZRWRIXH1Tfgn5EpO@fat_crate.local>
 <f654be8f-aa98-1bed-117b-ebdf96d23df1@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f654be8f-aa98-1bed-117b-ebdf96d23df1@linux.alibaba.com>
Subject: Re: [Acpica-devel] [RFC PATCH v2 0/9] Use ERST for persistent
 storage of MCE and APEI errors
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: tony.luck@intel.com, keescook@chromium.org, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com, x86@kernel.org, robert.moore@intel.com, gpiccoli@igalia.com, mingo@redhat.com, james.morse@arm.com, linux-hardening@vger.kernel.org, baolin.wang@linux.alibaba.com, hpa@zytor.com, acpica-devel@lists.linuxfoundation.org, tglx@linutronix.de, linux-edac@vger.kernel.org, linux-acpi@vger.kernel.org, ardb@kernel.org, lenb@kernel.org

On Sat, Oct 07, 2023 at 03:15:45PM +0800, Shuai Xue wrote:
> So, IMHO, it's better to add a way to retrieve MCE records through switching
> to the new generation rasdaemon solution.

rasdaemon already collects errors and even saves them in a database of
sorts. No kernel changes needed.

> Sorry for the poor cover letter. I hope the following response can clarify
> the matter.
> 
> Q1: What is the exact problem?
> 
> Traditionally, fatal hardware errors will cause Linux print error log to
> console, e.g. print_mce() or __ghes_print_estatus(), then reboot. With
> Linux, the primary method for obtaining debugging information of a serious
> error or fault is via the kdump mechanism.

Not necessarily - see above.

> In the public cloud scenario, multiple virtual machines run on a
> single physical server, and if that server experiences a failure, it can
> potentially impact multiple tenants. It is crucial for us to thoroughly
> analyze the root causes of each instance failure in order to:
> 
> - Provide customers with a detailed explanation of the outage to reassure them.
> - Collect the characteristics of the failures, such as ECC syndrome, to enable fault prediction.
> - Explore potential solutions to prevent widespread outages.

Huh, are you talking about providing customers with error information
from the *underlying* physical machine which runs the cloud VMs? That
sounds suspicious, to say the least.

AFAICT, all you can tell the VM owner is: yah, the hw had an
uncorrectable error in its memory and crashed. Is that the use case?

To be able to tell the VM owners why it crashed?

> In short, it is necessary to serialize hardware error information available
> for post-mortem debugging.
> 
> Q2: What exactly I wanna do:
> 
> The MCE handler, do_machine_check(), saves the MCE record to persistent
> storage and it is retrieved by mcelog. Mcelog has been deprecated when
> kernel 4.12 released in 2017, and the help of the configuration option
> CONFIG_X86_MCELOG_LEGACY suggest to consider switching to the new
> generation rasdaemon solution. The GHES handler does not support APEI error
> record now.

I think you're confusing things: MCEs do get reported to userspace
through the trace_mc_record tracepoint and rasdaemon opens it and reads
error info from there. And then writes it out to its db. So that works
now.

GHES is something different: it is a fw glue around error reporting so
that you don't have to develop a reporting driver for every platform but
you can use a single one - only the fw glue needs to be added.

The problem with GHES is that it is notoriously buggy and currently
it loads on a single platform only on x86.

ARM are doing something in that area - you're better off talking to
James Morse about it. And he's on Cc.

> To serialize hardware error information available for post-mortem
> debugging:
> - add support to save APEI error record into flash via ERST before go panic,
> - add support to retrieve MCE or APEI error record from the flash and emit
> the related tracepoint after system boot successful again so that rasdaemon
> can collect them

Now that is yet another thing: you want to save error records into
firmware. First of all, you don't really need it if you do kdump as
explained above.

Then, that thing has its own troubles: it is buggy like every firmware
is and it can brick the machine.

I'm not saying it is not useful - there are some use cases for it which
are being worked on but if all you wanna do is dump MCEs to rasdaemon,
that works even now.

But then you have an ARM patch there and I'm confused because MCEs are
x86 thing - ARM has different stuff.

So I think you need to elaborate more here.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
