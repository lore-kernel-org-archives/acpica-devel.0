Return-Path: <andi.shyti@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8198B60864
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EA4AD607AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1687339891;
 bh=EUSesneT0o86LDgLJNC+GIV1CW3amoMBxOwhWtk/CFI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=S3uQfPk/+C7R/9fVCGwbVnwyI2AiuPZpH64i0GBcknHTOTb3hmaHgjDTLZo85u75b
 cV1kRKE4hWXJP31yVZBTYQUJd/Zl28tJflwBdlPM5paW7FLxiJQLQcJ+eXnzDsmlfa
 tqtjot9z5h6bv2WfGk8ALIEOACFwCQkkuyv9e6ZqVMziUoLjTC4kTDKZgT+WMK6HDe
 CW4fuYq6vofJQBZfPb/lsMxX3Oy54MDrW+V8Qr+QA5FxI2uOTP5V7/A1u4018aUfp0
 kJ24ducK9uMxpX362dmronQyDr9VXx59UhARjHg9WeoYvPWQoLR5YEPojxCBx61VPC
 fNtzycYcXIZyQ==
From: Andi Shyti <andi.shyti@kernel.org>
Message-ID: <20230621093128.azqlkwulmkb3tvgl@intel.intel>
References: <20230620163534.1042-1-andriy.shevchenko@linux.intel.com>
 <20230620163534.1042-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620163534.1042-2-andriy.shevchenko@linux.intel.com>
Subject: Re: [Acpica-devel] [PATCH v1 2/2] ACPI: platform: Move SMB0001 HID
 to the header and reuse
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Wed, 21 Jun 2023 09:31:33 -0000
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org, Robert Moore <robert.moore@intel.com>, Wolfram Sang <wsa@kernel.org>, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, Len Brown <lenb@kernel.org>

Hi Andy,

On Tue, Jun 20, 2023 at 07:35:34PM +0300, Andy Shevchenko wrote:
> There are at least two places in the kernel that are using
> the SMB0001 HID. Make it to be available via acpi_drivers.h
> header file. While at it, replace hard coded one with a
> definition.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org> 

Andi
