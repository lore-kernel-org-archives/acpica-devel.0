Return-Path: <linux+acpica-devel=lists.linuxfoundation.org@armlinux.org.uk>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E92D140199
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 927A240189
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ni1GPgCl8w8Lwh/aSdbo/ks9Sgjz4jtglOS0ql7XSO4=; b=01c617rJlquZVt2QBAZvsxfiUn
 We9Aa2YJR/FiIGF2DchKsF4HTzXH4x13XmbhOFjuOjjTLrSvKEbbIiIVeMQu4u7PR8HN2WFJmMyfQ
 C6J8t3czF4AKG2F9u13+0fCagYzgASIqbySFKQ8DbW1a5cFRQtx6yrNueDmBMUQgJ3HEoQfA/tW2Y
 6zKGiVKt5ORIV3bWGHSyvSBoiOH7RlM0U2llB7+2OXH2TD8iVukcZ8K6w4/w+3LY6bhMz5YBBMP6H
 5M32zkEld5QtXKRKatFhDhrcgT9/IEWXaX/fsQh6kfxMZP7g104aTS23og0hO0W/VM5RGC4DF0bOO
 lTqzoc7Q==;
Date: Mon, 30 Oct 2023 17:51:03 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
Message-ID: <ZT/tB0ykr8JJd+E4@shell.armlinux.org.uk>
References: <ZTffkAdOqL2pI2la@shell.armlinux.org.uk>
 <C2C5C292-AD2C-4D98-8225-39ABE68C5395@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C2C5C292-AD2C-4D98-8225-39ABE68C5395@oracle.com>
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
To: Miguel Luis <miguel.luis@oracle.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Salil Mehta <salil.mehta@huawei.com>, "jianyong.wu@arm.com" <jianyong.wu@arm.com>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, James Morse <james.morse@arm.com>, "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, "justin.he@arm.com" <justin.he@arm.com>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "acpica-devel@lists.linuxfoundation.org" <acpica-devel@lists.linuxfoundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Oct 30, 2023 at 04:41:19PM +0000, Miguel Luis wrote:
> Hi Russell,
> 
> Tested on QEMU, based on Salil's RFC v2 [1], running with KVM.
> - boot
> - hotplug up to 'maxcpus'
> - hotunplug down to the number of boot cpus
> - hotplug vcpus and migrate with vcpus offline
> - hotplug vcpus and migrate with vcpus online
> - hotplug vcpus then unplug vcpus then migrate
> - successive live migrations (up until 6)
> 
> Feel free to add:
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> 
> Thank you
> Miguel
> 
> [1] https://lore.kernel.org/qemu-devel/20230926100436.28284-1-salil.mehta@huawei.com/

That's good news, thanks for testing!

I've pushed out an updated series against v6.6 earlier today in case
anyone wants something specifically against v6.6, but I don't think
there is any pressing reason to re-test. The only ACPI change
between the two is:

9b311b7313d6 ACPI: NFIT: Install Notify() handler before getting NFIT table

and the only arm64 changes are in dts files. Nothing significant in
kernel/ and nothing in drivers/base/.

So I think at this point, I will pause waiting for 6.7-rc1 (which
I'll do an updated patch set, since it will include changes queued
up) and hopefully followed by Rafael's comments. Maybe James will
also have some time to work on this again.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
