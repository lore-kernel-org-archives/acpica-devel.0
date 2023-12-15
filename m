Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242C14184F
	for <acpica-devel@lists.linuxfoundation.org>; Fri, 15 Dec 2023 19:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CdG5taBA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AkWe3gTm"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9A8F861042
	for <acpica-devel@lists.linuxfoundation.org>; Fri, 15 Dec 2023 19:49:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9A8F861042
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=CdG5taBA;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=AkWe3gTm
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.4
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6BeTDV_3IqH2
	for <acpica-devel@lists.linuxfoundation.org>;
	Fri, 15 Dec 2023 19:49:27 +0000 (UTC)
X-Greylist: delayed 536 seconds by postgrey-1.37 at util1.osuosl.org; Fri, 15 Dec 2023 19:49:26 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DA20561037
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DA20561037
	for <acpica-devel@lists.linuxfoundation.org>; Fri, 15 Dec 2023 19:49:26 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702669228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=py2PeKKW0Gg3Y7O2QlrezYfuYNsNwRB8EFj8qodJKBQ=;
	b=CdG5taBAB6NTGzrM1rVvHjEwlby6utivd6CtHCQ/SbU/I0bckLsyLiBKkgFxHtVPownMHz
	5T8olK/qGeNpaRlM7L5jERG1xMONRGfJKovMfz/HsRMtryBgfVSSBp146avw0XqPAvs+hd
	1VajQ9M8qfvAEi+x7fpa/LbJRNsPoTBneTU2l0pCSv/fG28o4g74Ia0roq11PfKpJym18J
	2CJ1VF0FxfTwZppVnajmd6+9Q20FqIdDBs9Zk7N2tnUgdmEbq2b4x4ujKF+vDauHDKUNx2
	ktWw7oS5G8SIUH6h9kxMTknyF6WlsYPA+KTBwbzdtkMoMD0gpOTMeFvPV0swhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702669228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=py2PeKKW0Gg3Y7O2QlrezYfuYNsNwRB8EFj8qodJKBQ=;
	b=AkWe3gTm8O5beIsABX3PYEheunlmtyOLR3tMy+HnIHu9N4zr8/Q64ZQBWBzRCznskC2rHp
	BwvqYKEXsjJzgQAQ==
To: Russell King <rmk+kernel@armlinux.org.uk>, linux-pm@vger.kernel.org,
 loongarch@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 kvmarm@lists.linux.dev, x86@kernel.org,
 acpica-devel@lists.linuxfoundation.org, linux-csky@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-parisc@vger.kernel.org
Cc: Salil Mehta <salil.mehta@huawei.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>, jianyong.wu@arm.com, justin.he@arm.com, James
 Morse <james.morse@arm.com>
Subject: Re: [PATCH RFC v3 21/21] cpumask: Add enabled cpumask for present
 CPUs that can be brought online
In-Reply-To: <E1rDOhX-00Dvlg-Ci@rmk-PC.armlinux.org.uk>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
 <E1rDOhX-00Dvlg-Ci@rmk-PC.armlinux.org.uk>
Date: Fri, 15 Dec 2023 20:40:28 +0100
Message-ID: <87le9vmez7.ffs@tglx>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Dec 13 2023 at 12:50, Russell King (Oracle) wrote:
> From: James Morse <james.morse@arm.com>
>
> The 'offline' file in sysfs shows all offline CPUs, including those
> that aren't present. User-space is expected to remove not-present CPUs
> from this list to learn which CPUs could be brought online.
>
> CPUs can be present but not-enabled. These CPUs can't be brought online
> until the firmware policy changes, which comes with an ACPI notification
> that will register the CPUs.
>
> With only the offline and present files, user-space is unable to
> determine which CPUs it can try to bring online. Add a new CPU mask
> that shows this based on all the registered CPUs.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Tested-by: Jianyong Wu <jianyong.wu@arm.com>

Acked-by: Thomas Gleixner <tglx@linutronix.de>
