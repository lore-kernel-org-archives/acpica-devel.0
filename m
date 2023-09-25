Return-Path: <keescook@chromium.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 42820402D0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 23588401DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695662001; x=1696266801;
 darn=lists.linuxfoundation.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=C8AVXr6vllU577ND8JQi6s5Wb2XnBxy1FQk2gXYImts=;
 b=hddFd7adsopk9jFxVcwRX0d+t2J38pgOF3ydOamy4aImPIe6LqQP5GMD3kcpovYzcU
 dyPivmLjk0dJKKWeEyj+APBcr4vJUROWHzP+I1HqozZFnDK6Fpd3qJyhVWH0AB3bzNJ0
 j6LqvKm5nLouCc+Q/uehkL1rN9LCE/CX+Z5a4=
From: Kees Cook <keescook@chromium.org>
Message-ID: <202309251012.AD87704BB@keescook>
References: <20230925074426.97856-1-xueshuai@linux.alibaba.com>
 <20230925074426.97856-2-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925074426.97856-2-xueshuai@linux.alibaba.com>
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
Date: Mon, 25 Sep 2023 17:13:24 -0000
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: tony.luck@intel.com, linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com, x86@kernel.org, robert.moore@intel.com, acpica-devel@lists.linuxfoundation.org, gpiccoli@igalia.com, mingo@redhat.com, bp@alien8.de, linux-hardening@vger.kernel.org, baolin.wang@linux.alibaba.com, hpa@zytor.com, james.morse@arm.com, tglx@linutronix.de, linux-edac@vger.kernel.org, ardb@kernel.org, lenb@kernel.org

On Mon, Sep 25, 2023 at 03:44:18PM +0800, Shuai Xue wrote:
> Move pstore creator id, section type and record struct to the common
> header, so that it can be use by MCE and GHES driver.

I would prefer this was not in the pstore header -- this is a backend
detail that should stay in backend headers.

-Kees

-- 
Kees Cook
