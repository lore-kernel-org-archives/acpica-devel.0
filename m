Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.223.95.204
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794916222;
	b=AdIsiFXAQgx2vQHvb50LVKMxf6z2rvBnm/BD/d7TKxkkru80FB9RY3KJi0AKZCCZ2XI1
	 X0cu+k3MAj+nAKapPhOi7QVx03K86MQJZVf3vAkgAexEvNUEAt/xtiKaF8encOL9lkfmx
	 XjQhMkCCTMWTrMPi24dEmj08s4IacgAlkEnPSjgxgjhhlAI2UfcVPyR5GI7NoJsFZ6EW/
	 wEX8i51QXzQgNKjrlp6wKNHsMqU2Io+egshDmSJEaVXz8DpLf5lJjqloKLFc1IvB9LugJ
	 ZOoNbVGWjmePT7YkutCsaGeBKWIQAtosaUbwDYAh8XGvZ5Btckm3PxFuYb5FOBjkxaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794916222;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=EwfpX7pGND05sD8odESGTeZ36nfl99+U15YYrIY2qBE=;
	b=YbvMhV70OUmGR6Inz8Jj+HRPh2tR/2/84x+9S2pXy8KgJbHTdBD+hW/fDyNmfXzYPQ6x
	 cE+1UxY4yAY+umawMeicsF1N/WTrFVp39e62R28ArNUtpuOHJOLlptRUKnbzQ8Xev8JIo
	 BW6ugfPeRKp6NFLQTPZJk/G8xNGhvzxiccZOUmoQ4APRKUO8Yy3DTiQHxe2vUSnQIH9WX
	 hWM0vL33TTjW/D1uvx/3GrjfKQFjPamUEsIShF9P7iWi0EbVsnK9h3jGD/LWHixd8uvMq
	 hflYIVpzA2N2CfFcqiYwJElQR8wZPInML9Qy3aL5NUWGWc+w+DcCU6kCVeseahT8/dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=wunner.de;
	spf=pass smtp.mailfrom=wunner.de;
	arc=none smtp.remote-ip=83.223.95.204
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E88D606A32A
	for <acpica-devel@lists.linux.dev>; Tue, 17 Nov 2026 11:50:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E88D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 145D31A07;
	Tue, 17 Nov 2026 12:50:14 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id F2DAC6039C25; Tue, 17 Nov 2026 12:50:13 +0100 (CET)
Date: Tue, 17 Nov 2026 12:50:13 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@oss.qualcomm.com>,
	James Morse <james.morse@arm.com>, Mark Brown <broonie@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Avadhut Naik <avadhut.naik@amd.com>, Radu Rendec <radu@rendec.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Breno Leitao <leitao@debian.org>,
	Terry Bowman <terry.bowman@amd.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: Re: [PATCH v1 19/19] PCI/ERR: Avoid NULL bridge pointer
Message-ID: <avw_daENKPcY7_04@wunner.de>
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
 <20261117111444.4185512-20-pierre.gondois@arm.com>
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Post: <mailto:acpica-devel@lists.linux.dev>
List-Help: <mailto:acpica-devel+help@lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:acpica-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117111444.4185512-20-pierre.gondois@arm.com>

On Tue, Nov 17, 2026 at 12:10:29PM +0100, Pierre Gondois wrote:
> Return PCI_ERS_RESULT_DISCONNECT when no upstream bridge is available,
> avoiding a NULL pointer dereference in pci_walk_bridge().

How can that happen?  If it can happen (which I doubt), why isn't this
patch tagged for stable?

Why is it at the end of this series?  Does the series somehow make it
possible that there's no upstream bridge?  Which patch does that?
If the preceding patches are not the cause of a potential NULL
pointer deref, why isn't this patch submitted separately from the series?

Thanks,

Lukas
