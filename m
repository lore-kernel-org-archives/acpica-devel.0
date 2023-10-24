Return-Path: <linux+acpica-devel=lists.linuxfoundation.org@armlinux.org.uk>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6DAC47036F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0E22A6FC3E
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Mv2+9gUUjwW5p4nAhtEkX5YZZx1pxyCR6znx1hs0kpI=; b=rsZIaVku++xS3FLshJEaUmBzq+
 IZD6Cn2c0/et6Uo+JOt4WeR9dFq1Ut+rF5FrT6IV5KhIFvVMf+LLjBQLU47NDzgIwcmGbpVvhRTRU
 gCMWRDcUie6kOaY2a7dMFClZ3267XEs/FktAYAglK9oyph9oihl1JtFf48qSzAA3ywoyWzC0GfK9M
 PTB0JemBhYOU0lDTVo1ICvemFtxrnnzr1IC3EEZQvKuCtWm90ax0Ijo4QL9EWtWa0cPIQeUEmcXl+
 LV7aHQWDApKmS5tOWVE6eDqhk5hYbwHCvkYKAl3o4s/teUj9wygTZAZpbtSMTDvDNzQIg9tkuFtyu
 U9rcIOVQ==;
Date: Tue, 24 Oct 2023 17:31:45 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
Message-ID: <ZTfxcU3EsBNOGIUm@shell.armlinux.org.uk>
References: <ZTffkAdOqL2pI2la@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTffkAdOqL2pI2la@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Subject: Re: [Acpica-devel] [RFC PATCH v3 00/39] ACPI/arm64: add support for
 virtual cpuhotplug
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
To: linux-pm@vger.kernel.org, loongarch@lists.linux.dev, linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev, x86@kernel.org, acpica-devel@lists.linuxfoundation.org, linux-csky@vger.kernel.org, linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, Salil Mehta <salil.mehta@huawei.com>, jianyong.wu@arm.com, justin.he@arm.com, James Morse <james.morse@arm.com>

On Tue, Oct 24, 2023 at 04:15:28PM +0100, Russell King (Oracle) wrote:
> Hi,
> 
> I'm posting James' patch set updated with most of the review comments
> from his RFC v2 series back in September. Individual patches have a
> changelog attached at the bottom of the commit message. Those which
> I have finished updating have my S-o-b on them, those which still have
> outstanding review comments from RFC v2 do not. In some of these cases
> I've asked questions and am waiting for responses.
> 
> I'm posting this as RFC v3 because there's still some unaddressed
> comments and it's clearly not ready for merging. Even if it was ready
> to be merged, it is too late in this development cycle to be taking
> this change in, so there would be little point posting it non-RFC.
> Also James stated that he's waiting for confirmation from the
> Kubernetes/Kata folk - I have no idea what the status is there.
> 
> I will be sending each patch individually to a wider audience
> appropriate for that patch - apologies to those missing out on this
> cover message. I have added more mailing lists to the series with the
> exception of the acpica list in a hope of this cover message also
> reaching those folk.
> 
> The changes that aren't included are:
> 
> 1. Updates for my patch that was merged via Thomas (thanks!):
>    c4dd854f740c cpu-hotplug: Provide prototypes for arch CPU registration
>    rather than having this change spread through James' patches.
> 
> 2. New patch - simplification of PA-RISC's smp_prepare_boot_cpu()
> 
> 3. Moved "ACPI: Use the acpi_device_is_present() helper in more places"
>    and "ACPI: Rename acpi_scan_device_not_present() to be about
>    enumeration" to the beginning of the series - these two patches are
>    already queued up for merging into 6.7.
> 
> 4. Moved "arm64, irqchip/gic-v3, ACPI: Move MADT GICC enabled check into
>    a helper" to the beginning of the series, which has been submitted,
>    but as yet the fate of that posting isn't known.

Update: Catalin has just merged this patch! Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
