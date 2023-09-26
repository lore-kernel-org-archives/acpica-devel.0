Return-Path: <xueshuai@linux.alibaba.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4A86C82263
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F0ED282246
Message-ID: <9ae398ff-c6a2-fde8-a767-3b42a86b9c38@linux.alibaba.com>
MIME-Version: 1.0
Content-Language: en-US
References: <20230925074426.97856-1-xueshuai@linux.alibaba.com>
 <20230925074426.97856-2-xueshuai@linux.alibaba.com>
 <202309251012.AD87704BB@keescook>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <202309251012.AD87704BB@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Acpica-devel] [RFC PATCH v2 1/9] pstore: move pstore creator
 id, section type and record struct to common header
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Tue, 26 Sep 2023 06:47:26 -0000
To: Kees Cook <keescook@chromium.org>
Cc: tony.luck@intel.com, linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com, x86@kernel.org, robert.moore@intel.com, acpica-devel@lists.linuxfoundation.org, gpiccoli@igalia.com, mingo@redhat.com, bp@alien8.de, linux-hardening@vger.kernel.org, baolin.wang@linux.alibaba.com, hpa@zytor.com, james.morse@arm.com, tglx@linutronix.de, linux-edac@vger.kernel.org, ardb@kernel.org, lenb@kernel.org



On 2023/9/26 01:13, Kees Cook wrote:
> On Mon, Sep 25, 2023 at 03:44:18PM +0800, Shuai Xue wrote:
>> Move pstore creator id, section type and record struct to the common
>> header, so that it can be use by MCE and GHES driver.
> 
> I would prefer this was not in the pstore header -- this is a backend
> detail that should stay in backend headers.
> 
> -Kees
> 

Hi, Kees,

Which file do you prefer? Do you mean "include/linux/cper.h", it defines
the standard CPER sections, e.g. CPER_SEC_PLATFORM_MEM, CPER_SEC_PCIE, etc.

Thank you for comments.

Best Regards,
Shuai
