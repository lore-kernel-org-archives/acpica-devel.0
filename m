Return-Path: <keescook@chromium.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B70D1415C3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7EF1440018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692919313; x=1693524113;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8w5mv6lG3O3l4xUxVWDEcklkLQovn+KSfkFXrkAtd8o=;
 b=HUNbIF3SZFESQtWsYGw4ufoOPQfn0DMhz6J6tkXQyiqY0N4QCZMi+uH9lXx7i5V4JS
 WShu9Elj1MhAzOogVa/Zk7n3ucdznSw165k9gkqJc5lkHungrIP+gxo55QxUrPQoUgLX
 K4NXLnL4+wIUv0fIgiY8+1FVzP9yZ1K5RkeQY=
From: Kees Cook <keescook@chromium.org>
Message-ID: <202308241612.DFE4119@keescook>
References: <20230824-strncpy-drivers-acpi-acpica-v1-1-d027ba183b66@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824-strncpy-drivers-acpi-acpica-v1-1-d027ba183b66@google.com>
Subject: Re: [Acpica-devel] [PATCH RFC] ACPICA: remove acpi_ut_safe_strncpy
 in favor of strscpy
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Thu, 24 Aug 2023 23:21:55 -0000
To: Justin Stitt <justinstitt@google.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Nick Desaulniers <ndesaulniers@google.com>, Robert Moore <robert.moore@intel.com>, linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>, linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, Len Brown <lenb@kernel.org>

On Thu, Aug 24, 2023 at 10:02:02PM +0000, Justin Stitt wrote:
> I wanted to gather some thoughts on removing `acpi_ut_safe_strncpy` (and
> potentially other `acpi...safe...()` interfaces) in favor of
> pre-existing interfaces in the kernel (like strscpy).
> 
> Running a git blame shows these functions were implemented 10 years ago
> and their implementations generally mirror the _newer_ and more robust
> stuff in lib/string.h -- Let's just use these, right?
> 
> I appreciate any comments and whether or not I should stop at just
> `strncpy`.

ACPICA is actually a separate upstream project, so changes are best made
there[1]. However, this code base is shared with many OSes and
compilers, so there won't be a common "strscpy" available. Perhaps the
right thing to do here is to implement acpi_ut_safe_strncpy() in terms
of strnlen(), memcpy(), and memset(). That would make the upstream
project safe against "too long reads", etc, and would require no
collateral changes:

void acpi_ut_safe_strncpy(char *dest, char *source, acpi_size dest_size)
{
	/* Do not over-read the source string. */
	acpi_size len = 0;

	if (dest_size > 0)
		len = strnlen(source, dest_size - 1);
	if (len)
		memcpy(dest, source, len)
	/* Always terminate destination string and pad to dest_size. */
	memset(dest + len, '\0', dest_size - len);
}

-Kees

[1] https://github.com/acpica/acpica
    e.g. https://github.com/acpica/acpica/pull/856

-- 
Kees Cook
