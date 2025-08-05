Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD61A42049
	for <acpica-devel@lists.linux.dev>; Tue,  5 Aug 2025 13:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754398815; cv=none; b=hWobfKufXFrJvhEXu+9ufTUkWNkcHWSEE4z7YTe3ceC+Qu89rzoh8fp4JuF6iE5AkDJbYZTL8fAUunteWDTn4cZZ0gsLDDFaH6xtdHgemT5WR9rLI5wnPqhP9eESrP/GXReB75Vcmx5uc5LKe3olFkv01lnhCtAyN8Ztex/SDX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754398815; c=relaxed/simple;
	bh=4t7dMcqzc7zDlbYdbuJAk8tlv9zQyDoso6MSnjmvM50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdlaTrk9DCw8tUM8zrs/4/SRZHSOqbC/1EYW7j+BYZ1c66sUYMhx5DnMszoA6YaAqTDiHVJpo7UKGWZCNHCb9sKov/ioWXNB8BMr+YsPxP1EYqqHd7Cp0BJGuo52WI7nLUi4fZ1knxVjXikoD6HrAW7wekIn4Zq4HIEIsqwsIOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6153a19dddfso8591323a12.1
        for <acpica-devel@lists.linux.dev>; Tue, 05 Aug 2025 06:00:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754398812; x=1755003612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzQHx1i5Fs/JOgRu+gEHkLfTlj9ZTI1ibV6XEx4O938=;
        b=vyK6o3UodvCrQ13stPISgYQupOqUbkRvFeIDXKUOihMYa/AsrC3WlmnBZ9Md7cevL1
         2TClnVmhH7vyEdVxhtSPzKg/WhLO1YNjTHT0Drfxj2fM8rHFj7ssbA69jymO7l3mGgEn
         hHxaXxVeD2xfZe8ZssbQ7Ukl1KGapEukr4Pp44MEhOVGXC4Tae2DZbpH7axm08OHnysv
         93QwGRoWD3QK3tykPmwLXurNciRAxVXoU7/3quxC9r9KRICObnTGQjrosW16gI5PIV+U
         jELCRmLpEdS8NOFgCgjeBpiEc0bONx1Ywd5Qx+PSxpEtI+rnTvcH3upiVi2bNs6kyvGm
         j+Cg==
X-Forwarded-Encrypted: i=1; AJvYcCVwisyg7JCQm1nOpD7uUQUym69HfJNe2x0hPxZ0ImCoTuVPZHWQbA6BwK1Bq0N39L/6z86PfZ1RsWMMe+U=@lists.linux.dev
X-Gm-Message-State: AOJu0YyjpvOktAsTjKZD+17ntpDtmtfAZ6dz54+kR2hkXNw3xoCfqpua
	/2GKZG4gr5FNQyJYd0yKbpkrp5177JZAGu8wdBvYfEQNPJda/ZMhF4da
X-Gm-Gg: ASbGncswFL/7ELJ9lTg/SkQ2DMIvqP5zmMFqMW/PuWgU+duI6PbzO2G2pMmmnE7R6pe
	Q1CEmFt+K4c9EGHfDpeVlTwHfd2esD7mzlNIncoIAfqX5ZhD0rUDDG5/qCZDdLS31eC6jffkXwU
	nIoDPFmPYfpF7YU4/7pqHh651FEUNZ7xWjlAf/dncOgbo39EZHT94zh2kT0pROGXFKMiJ9m67IQ
	GT5jY45gZkC592y/P1jkD69EsFwvuGXiXwcU29Y7rwwUJXeNFnXKbtrI57Nj2IMcvwdo4uhG0Uu
	Uvr1KGUq4dIgiUeeoYXdgXsI8MgH7eU3feDHVefgpWV0/l2ESp+rirBq2k0eglCUPaAGWR3p/1J
	ZqjRhaYnUHDBB
X-Google-Smtp-Source: AGHT+IGjZSNpW7mJUj3kJ0f8IpMzBnPj+YUjP2KOPDwITdV1e7i/FDQIvzJwDgp/H8IFr3t8Mztalg==
X-Received: by 2002:a05:6402:4402:b0:615:b0e2:124b with SMTP id 4fb4d7f45d1cf-615e715bd27mr13276935a12.24.1754398811018;
        Tue, 05 Aug 2025 06:00:11 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f2a448sm8429117a12.20.2025.08.05.06.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 06:00:10 -0700 (PDT)
Date: Tue, 5 Aug 2025 06:00:07 -0700
From: Breno Leitao <leitao@debian.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
	Robert Moore <robert.moore@intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Hanjun Guo <guohanjun@huawei.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev, osandov@osandov.com, 
	xueshuai@linux.alibaba.com, konrad.wilk@oracle.com, linux-edac@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, kernel-team@meta.com, osandov@fb.com
Subject: Re: [PATCH v4] vmcoreinfo: Track and log recoverable hardware errors
Message-ID: <j4ac55vpiemdjdbfzoktoqv763fhpv6q2agmgaeggvahfj5kuy@v7l5lrrdwkjj>
References: <20250801-vmcore_hw_error-v4-1-fa1fe65edb83@debian.org>
 <85663f65-d746-4e2c-b8a6-d594d9d0ba42@intel.com>
 <f3yl424iqiyctgz4j36hzjrhkgae3a2h5smhalm2qbmq3nrpzd@oeuprthscfez>
 <0c045f1b-44d0-430c-9e8a-58b65dd84453@intel.com>
 <buhwuankenpnvmio6jeoxverixoyfpn2eh62ix7vzxw7xvlxcv@rpibcrufr2yg>
 <842d675e-4c22-4f13-b40b-c4b5208e4223@intel.com>
 <ipdhflmgqrlq2vor657fiwex66jqw2do747uvu3tvrcsvtvdjj@lg5zrcua2dgn>
 <529fbbc1-90fe-467b-9bd2-d1a18bb38670@intel.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <529fbbc1-90fe-467b-9bd2-d1a18bb38670@intel.com>

On Mon, Aug 04, 2025 at 10:41:05AM -0700, Dave Hansen wrote:
> On 8/4/25 10:12, Breno Leitao wrote:
> ...
> > +- These errros are divided by are, which includes CPU, Memory, PCI, CXL and
> > +  others.
> 
> There's a double typo in there I think:
> 
> 	errros => errors
> and
> 	are,=>area,
> 
> > --- a/include/linux/vmcore_info.h
> > +++ b/include/linux/vmcore_info.h
> > @@ -77,4 +77,20 @@ extern u32 *vmcoreinfo_note;
> >  Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
> >  			  void *data, size_t data_len);
> >  void final_note(Elf_Word *buf);
> > +
> > +enum hwerr_error_type {
> > +	HWERR_RECOV_CPU,
> > +	HWERR_RECOV_MEMORY,
> > +	HWERR_RECOV_PCI,
> > +	HWERR_RECOV_CXL,
> > +	HWERR_RECOV_OTHERS,
> > +	HWERR_RECOV_MAX,
> > +};
> That enum needs to go into an abi header.

Agree. I came up with something like the change below. Is it the right
thing to mark the enum as stable ABI?

Thanks
--breno

diff --git a/include/linux/vmcore_info.h b/include/linux/vmcore_info.h
index 37e003ae52626..e71518caacdfc 100644
--- a/include/linux/vmcore_info.h
+++ b/include/linux/vmcore_info.h
@@ -5,6 +5,7 @@
 #include <linux/linkage.h>
 #include <linux/elfcore.h>
 #include <linux/elf.h>
+#include <uapi/linux/vmcore.h>

 #define CRASH_CORE_NOTE_HEAD_BYTES ALIGN(sizeof(struct elf_note), 4)
 #define CRASH_CORE_NOTE_NAME_BYTES ALIGN(sizeof(NN_PRSTATUS), 4)
@@ -77,4 +78,11 @@ extern u32 *vmcoreinfo_note;
 Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
                          void *data, size_t data_len);
 void final_note(Elf_Word *buf);
+
+#ifdef CONFIG_VMCORE_INFO
+void hwerr_log_error_type(enum hwerr_error_type src);
+#else
+static inline void hwerr_log_error_type(enum hwerr_error_type src) {};
+#endif
+
 #endif /* LINUX_VMCORE_INFO_H */
diff --git a/include/uapi/linux/vmcore.h b/include/uapi/linux/vmcore.h
index 3e9da91866ffd..2ba89fafa518a 100644
--- a/include/uapi/linux/vmcore.h
+++ b/include/uapi/linux/vmcore.h
@@ -15,4 +15,13 @@ struct vmcoredd_header {
        __u8 dump_name[VMCOREDD_MAX_NAME_BYTES]; /* Device dump's name */
 };

+enum hwerr_error_type {
+       HWERR_RECOV_CPU,
+       HWERR_RECOV_MEMORY,
+       HWERR_RECOV_PCI,
+       HWERR_RECOV_CXL,
+       HWERR_RECOV_OTHERS,
+       HWERR_RECOV_MAX,
+};
+
 #endif /* _UAPI_VMCORE_H */
