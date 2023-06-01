Return-Path: <keescook@chromium.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 472908430F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 07581842B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1685638652; x=1688230652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O+pr6mlvTApyiKkbVHDanPXS/dQX3RLJfgRaODr8lBU=;
 b=DmhdF08EAAqn3dYc2MIfdQSzT08RSo4NONk8DZ3MZGu4VFAv4jnZzeq4nhEX377KuQ
 Uqpg3ojyXVchaFjngBrxyVVNR8DbajCT6C6rAzd/zg5yPSPO0cRdQKITE20GOJiTcfqn
 Jb3ix2Ncl6iH/gmLTqH19bKIoIF4e2i+llomw=
From: Kees Cook <keescook@chromium.org>
Date: Thu,  1 Jun 2023 09:56:42 -0700
Message-Id: <168563860014.2889935.9236369807138013890.b4-ty@chromium.org>
In-Reply-To: <20230523161815.3083-1-wyes.karny@amd.com>
References: <20230523161815.3083-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
To: lenb@kernel.org, rafael@kernel.org, wyes.karny@amd.com, robert.moore@intel.com
Cc: linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org

On Tue, 23 May 2023 16:18:15 +0000, Wyes Karny wrote:
> struct acpi_table_slit is used for copying System Locality Information
> Table data from ACPI tables. Here `entry` is a flex array but it was
> using ancient 1-element fake flexible array, which has been deprecated.
> Replace it with a C99 flexible array.
> 
> 

Since this is a fix for -fstrict-flex-arrays=3, I can carry this in the
hardening tree until it shows up in upstream ACPICA.

Applied to for-next/hardening, thanks!

[1/1] acpi: Replace struct acpi_table_slit 1-element array with flex-array
      https://git.kernel.org/kees/c/0233ca593eba

-- 
Kees Cook

