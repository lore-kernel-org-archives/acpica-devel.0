Return-Path: <helgaas@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 06DBD41E11
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E4C1041E0D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1691709441;
 bh=qPsFwAx57nmNmTH+gfAIk/AJ5OPfBVdOZsSrENFXzIs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=Brh2InwBRZ2PU8X4rPr7NVOjKO27ikzR6XL4NXBKIQA4X0kYcFx1XWbNXmhqCtCEC
 JQe5PDtZACf2j/D49hBAOHxA6OrsKkWjp8RNxi3vVGx4jo3CHrz4ydFunw62SLgGWQ
 iqYqZ0aOly/ZD5u/weZ3wTZjb2ijKjE7WBDTrX4+uvIGNcUuaJu4WTi9x7RBIvHD05
 uvW+VhEIfnWxkGRaYNlGrio577ImogHoJAqhqc2FY7kmx+VZ6itS9wC+q5MnO9g+Tl
 c+jEDBP9vZ0hARK+vshUBLKqft0wp4JsKhzOUmW6Yw1tyIlbGDG6h+AddXFNMoVcJt
 XyisDmtpVDKTg==
Date: Thu, 10 Aug 2023 18:17:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
Message-ID: <20230810231718.GA49532@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704120517.1322195-1-LeoLiu-oc@zhaoxin.com>
Subject: Re: [Acpica-devel] [PATCH v3 2/5] ACPI/APEI: Remove static from
	apei_hest_parse()
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
To: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
Cc: tony.luck@intel.com, linux-pci@vger.kernel.org, robert.moore@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, bp@alien8.de, bhelgaas@google.com, james.morse@arm.com, acpica-devel@lists.linuxfoundation.org, lenb@kernel.org

On Tue, Jul 04, 2023 at 08:05:17PM +0800, LeoLiu-oc wrote:
> From: leoliu-oc <leoliu-oc@zhaoxin.com>
> 
> Each dev with AER capability needs to call the apei_hest_parse function to
> match and extract register values from HEST PCIe AER structures.
> Therefore, remove static from apei_hest_parse() so that it can be called
> in another file.

Can you reword the subject line and commit log in the positive?
"Removing static" is a negative thing and it's semantically a bit too
low level -- it's clearly what the *code* does, but we can see that
from the patch, and what we want to know here is *why* it's important.
What this really does is expose apei_hest_parse() for use by other
subsystems.

Browsing the drivers/acpi commit log history, I see that Rafael adds
"()" after function names, so please do the same here (you did do that
once above, but not in the first line).

> Signed-off-by: leoliu-oc <leoliu-oc@zhaoxin.com>
> ---
>  drivers/acpi/apei/hest.c | 2 +-
>  include/acpi/apei.h      | 5 +++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
> index fb839a5c480ee..fd40c035c9b2e 100644
> --- a/drivers/acpi/apei/hest.c
> +++ b/drivers/acpi/apei/hest.c
> @@ -132,7 +132,7 @@ static bool hest_match_pci(struct acpi_hest_header *hest_hdr,
>  	return false;
>  }
>  
> -static int apei_hest_parse(apei_hest_func_t func, void *data)
> +int apei_hest_parse(apei_hest_func_t func, void *data)

If this is going to exported to the PCI subsystem, I think it needs
some kernel-doc.  For example, it's important to know that it stops
parsing the HEST if func returns anything non-zero.  This is how
pci_acpi_program_hest_aer_params() knows that it got good data that
matches the device it wants.

Given the fact that apei_hest_parse_aer() fills in the struct
acpi_hest_parse_aer_info with pointers into the HEST table data, it's
also important to know that this HEST table data is persistent.

>  {
>  	struct acpi_hest_header *hest_hdr;
>  	int i, rc, len;
> diff --git a/include/acpi/apei.h b/include/acpi/apei.h
> index 8a0b2b9edbafe..f975e4fe78fcb 100644
> --- a/include/acpi/apei.h
> +++ b/include/acpi/apei.h
> @@ -37,9 +37,14 @@ typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *data);
>  
>  #ifdef CONFIG_ACPI_APEI
>  void __init acpi_hest_init(void);
> +int apei_hest_parse(apei_hest_func_t func, void *data);
>  int apei_hest_parse_aer(struct acpi_hest_header *hest_hdr, void *data);
>  #else
>  static inline void acpi_hest_init(void) { }
> +static inline int apei_hest_parse(apei_hest_func_t func, void *data)
> +{
> +	return -EINVAL;
> +}
>  static inline int apei_hest_parse_aer(struct acpi_hest_header *hest_hdr, void *data)
>  {
>  	return -EINVAL;
> -- 
> 2.34.1
> 
