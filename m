Return-Path: <bp@alien8.de>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3112281EC2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E3A9681C11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
 t=1695912233; bh=h1/LDhE8fzT9yHzOAMn/O1uQcjI/GQRZwIc2SRP75FA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iZ5FRVunRWlEOnzVstKpLgxo9Pq1pLk58HzP++2IaqcTwzO8HrerFTvz+m0xvvPbA
 /1OYLbkPTP8O7vAFVM23V3gaF/swxmTcjRGRnDzcX6HKQ60eDJ9lFFmZx8SRyOwt4a
 gyyNnqRe+YgkZsoj+PJlVyCRJfSQBhxg8htG0sPi4XPKyx6hQkP8dikTsmct2e3Ifl
 UJ5PpeYWN6IbaMlFA2mv5N6SgFZhyMzBJOB702tLvbSQLn0+99W7IZfuPRozvWtxmP
 coGgcLA/k7hwojbNnq9oxY6uYA5481XGe2E0cDYK3VIVADW0p6WyVfAX8HuIcB+I2U
 OUTKPKDwtS5d8g/bLwq4yVYAm7OcT+lIFK1fKgmdggeKQqkNdKeDSu+7hSork76W1n
 B0xOU/+he+a/RqX6UyQyMS+kkfkQx7hIGxIeBZ9YgP8M1qEZJBd6Kl00RhuQRUBFV5
 wx2Ec8ZQlHwYd/MA6hQ5QH8u/cCNug+w7aFQVWzPunz/Ay7xqRMpbM+b4qRSHZmN+k
 RQig38hcXZ1IoLJa5xR1LXPxDFLcz61ZMbVx2/vem56E/luM49qcnwJQ5n6AMVJm2L
 xOIu9TAw8C3ZOTYf4EpvJUp2GAXG7WSB1O0j8IKufzGudrIurXHvYjx4Iijzna35tD
 I9qe4vVT+23x0C4PkzqztaUA=
From: Borislav Petkov <bp@alien8.de>
Message-ID: <20230928144345.GAZRWRIXH1Tfgn5EpO@fat_crate.local>
References: <20230925074426.97856-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230925074426.97856-1-xueshuai@linux.alibaba.com>
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
Date: Thu, 28 Sep 2023 14:50:52 -0000
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: tony.luck@intel.com, keescook@chromium.org, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com, x86@kernel.org, robert.moore@intel.com, gpiccoli@igalia.com, mingo@redhat.com, james.morse@arm.com, linux-hardening@vger.kernel.org, baolin.wang@linux.alibaba.com, hpa@zytor.com, acpica-devel@lists.linuxfoundation.org, tglx@linutronix.de, linux-edac@vger.kernel.org, linux-acpi@vger.kernel.org, ardb@kernel.org, lenb@kernel.org

On Mon, Sep 25, 2023 at 03:44:17PM +0800, Shuai Xue wrote:
> After /dev/mcelog character device deprecated by commit 5de97c9f6d85
> ("x86/mce: Factor out and deprecate the /dev/mcelog driver"), the
> serialized MCE error record, of previous boot in persistent storage is not
> collected via APEI ERST.

You lost me here. /dev/mcelog is deprecated but you can still use it and
apei_write_mce() still happens.

Looking at your patches, you're adding this to ghes so how about you sit
down first and explain your exact use case and what exactly you wanna
do?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
