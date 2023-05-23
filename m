Return-Path: <keescook@chromium.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DC74840949
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 75F10408FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1684860262; x=1687452262;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=L9iP1ZVb5yqMQbzkFbXlAZweX7OqrHaDEWkJHs5lGVQ=;
 b=ntFQNonFSdidYKpES2RkJ39j44/LM+NMO0LxTwaAQig4V8Avhkp579EAxvp69JQolW
 bMpaPjNXCNJH1TsBHnTC9YdHFofv9KHiHg5AQoGw84dhBrNaYKX1EGcjScDwfbUtifj8
 RucUpo604PEzUZDSWfBZcsx29hrKDyWkVM1XY=
Date: Tue, 23 May 2023 09:44:20 -0700
From: Kees Cook <keescook@chromium.org>
Message-ID: <202305230943.0B7B2F73F@keescook>
References: <20230523161815.3083-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523161815.3083-1-wyes.karny@amd.com>
Subject: Re: [Acpica-devel] [PATCH] acpi: Replace struct acpi_table_slit
 1-element array with flex-array
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
To: Wyes Karny <wyes.karny@amd.com>
Cc: robert.moore@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, lenb@kernel.org

On Tue, May 23, 2023 at 04:18:15PM +0000, Wyes Karny wrote:
> struct acpi_table_slit is used for copying System Locality Information
> Table data from ACPI tables. Here `entry` is a flex array but it was
> using ancient 1-element fake flexible array, which has been deprecated.
> Replace it with a C99 flexible array.
> 
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>

Eek, thanks. I missed one! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
