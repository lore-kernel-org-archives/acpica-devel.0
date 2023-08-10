Return-Path: <helgaas@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3991D83F4B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9FE5583BB6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1691709404;
 bh=ZmrWlyLDwcmwi9hUwauGbIn2pC+uqr3wNk2fOa0Tmtc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=SAQglvG+C+UjhCWhv1P2LHig050JiUg/j9MWLFVK7hj/7mnBjMFPkSx3X1+Idlcyg
 QIMjHYxCCTUwVrso10FiV0kAgIMUzJ42bV+ca6NDs7NdHwhxYGQj8x6iBfaFl2cRG1
 XleuAEM/5LZlE7noiElqHs04GtNmocgk2R146bojaFK6ezYM5KXep2tZrdG/kenI6D
 QXcD5JAT3G5jFgHAbLGmy7RZc/aAV7R98EntmgFz3xT2nGQLwtH+mJmPYcBMJt1t00
 A0Wq9he4ONcMxtxl+6gmV7HNhz6pR8vAY73AyftNFcj2cVLf6cicQtJi6abjZdd6H9
 ZpXHJtoll7FEQ==
Date: Thu, 10 Aug 2023 18:16:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
Message-ID: <20230810231642.GA50403@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704120530.1322257-1-LeoLiu-oc@zhaoxin.com>
Subject: Re: [Acpica-devel] [PATCH v3 3/5] PCI: Add PCIe to PCI/PCI-X Bridge
	AER fields
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

On Tue, Jul 04, 2023 at 08:05:30PM +0800, LeoLiu-oc wrote:
> From: leoliu-oc <leoliu-oc@zhaoxin.com>
> 
> Define Secondary Uncorrectable Error Mask Register, Secondary
> Uncorrectable Error Severity Register and Secondary Error Capabilities and
> Control Register bits in AER capability for PCIe to PCI/PCI-X Bridge.
> Please refer to PCIe to PCI/PCI-X Bridge Specification, sec 5.2.3.2,
> 5.2.3.3 and 5.2.3.4.
> 
> Signed-off-by: leoliu-oc <leoliu-oc@zhaoxin.com>
> ---
>  include/uapi/linux/pci_regs.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index e5f558d964939..28e20c4d0afc3 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -800,6 +800,9 @@
>  #define  PCI_ERR_ROOT_FATAL_RCV		0x00000040 /* Fatal Received */
>  #define  PCI_ERR_ROOT_AER_IRQ		0xf8000000 /* Advanced Error Interrupt Message Number */
>  #define PCI_ERR_ROOT_ERR_SRC	0x34	/* Error Source Identification */
> +#define PCI_ERR_UNCOR_MASK2		0x30	/* PCIe to PCI/PCI-X Bridge */
> +#define PCI_ERR_UNCOR_SEVER2	0x34	/* PCIe to PCI/PCI-X Bridge */
> +#define PCI_ERR_CAP2			0x38	/* PCIe to PCI/PCI-X Bridge */

These need to line up with the offsets above, i.e.,
PCI_ERR_ROOT_ERR_SRC.

I think these should be named:

  PCI_ERR_SEC_UNCOR_MASK
  PCI_ERR_SEC_UNCOR_SEVER
  PCI_ERR_SEC_ERR_CAP

because "Secondary" in this context doesn't have anything to do with
"2"; it just means the secondary (downstream) interface of the bridge.

Bjorn
