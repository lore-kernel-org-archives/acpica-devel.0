Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5269025776
	for <acpica-devel@lists.linux.dev>; Fri, 26 Dec 2025 00:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766708410; cv=none; b=M1oN96u4UzuZ2OGQzO0g6ajeIKrean+sihCkw/0UPOMDIHwN0MdqqBTklPJhjIUXgmzlVKxYQ2xajR2MevMoHYOFziqFiigjhwQtUe+eerTgM2yRgzbOETlFl1AigFm4LJLicUeAD5cp9zNc9/hbu8wLF6LaKbO/C69mY5B2MLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766708410; c=relaxed/simple;
	bh=nGwM+PQuL1rzxPZ5jagDG0kFkA7NFWyXrk61vQ0HbjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtAJywgOc9qGimR3Abm/soInWDYqNFS7+UC4+bri+UbeOP2rU9wEIj/Ewo/1Uply3UB60NzgkznkESCSVJkouUt0MqkAGSDWRBsKvps9gb2V8sg8eowjtYKg8REkh91LpRZ0hGtdjk6Yc44IEwebdREJc85q7lhfVl0WXTYQcL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6wK5sjQ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6wK5sjQ"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-29f1bc40b35so115211845ad.2
        for <acpica-devel@lists.linux.dev>; Thu, 25 Dec 2025 16:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766708408; x=1767313208; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+DhWhE7XYlLnVX4zCn90QgLygN3HeTxBI4v2gs7tTiQ=;
        b=b6wK5sjQ2zCDp/ZD7dKbishvG9kefK/x2oWYr6m4NSnFipoIHfba/brmCUvaYWc0/K
         0CT1WMt86Cph/RfZIGKVL7Cb/5gckDqPmhK346xALXavRMgFVsCYWc/vARofD0xxH2DZ
         8XSFIEqGfD8+yQaRiRotnMXI0p3zMf16N6mvC4WJdyl0B3xCkbKg6TyQFHbPleTkUt5O
         WQZ84ezLJlqYYe2QCLLFGVEwyljyakJjIrhqwQQIIvo1Zi82ktUCcJAbtj1IZD6HdkYW
         k80UdRkfMDcku9HTOTG7/rFOx8Z6tIwiIiYhRuw4yh8+rGmYNQ3BvVhGFRdlXAMgfpME
         alqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766708408; x=1767313208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+DhWhE7XYlLnVX4zCn90QgLygN3HeTxBI4v2gs7tTiQ=;
        b=CRNYvjQEUfIpNBkFVIeUeDDxsGbd/ibgLhG4KQxe0ikosOY1gzx1xNY9uTFyv5H0BB
         uw5oF8THvna7DiuuNdFs/vVKxTlZ1H9HsxirFX3webCS3k+6tIMBEa/+hHuhl1N4lgj8
         bjXl2nX7rKMjO3tti29iuCqmDCzZfBcbJZUTXBmoJrbIoISbt33pEt6UB5xXqJQHhEEE
         9d8b8Bqu4tti+1+wWxL/qmUm+sjs/jx0cj8I0S4lDyrLfuY8JGny94j8rFEMMXd9OBo0
         ccEDg2pYWiZQ9ONdwkn+j6Oo/Awr7P8k0DAbxEwyZsVAzyLbkeuK+vJqR/xAbUCqVLiA
         TIZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUe1tzv08IqeKGioocE/2cEWNAX/qxa9LkzwpzqZ1GSwqSTyPU3AvX2ORTUji1a2RNv4tbgWn6LUS1732Q=@lists.linux.dev
X-Gm-Message-State: AOJu0YxRDULVBE4S9C7T01cWVjY5KrofYABwc4TXiJl/maKd/WpMmG5Z
	F8CPUL5m0Sm6CY8SwtA1gGH4/BwHu2EH0xM9RMMJoDEcspJ8YBVy3u2Q
X-Gm-Gg: AY/fxX7DFZTZiKQnLXJ2oBdqcP+GJv50EeLXdNRwjyRMmyMEHSH2aQKiJeeVa6x+ndn
	ZFeZSY9NnkUGWiCRZ8mWL9U2xeRhyYjoo5lTAbj2JSSorZvM0FqLz4ZbQAWIFZHHN76peo42pyn
	LTRXIJBA9Ocrzy/QcKFfP62nOf72oRQm/t43X4ibeMqS7wUeiOCVHj1jZi0xnignhw7WWfGVA1w
	FOTN2cq9iOWwA0NybQhhM/74WIavhj10IVyrWWkCWDYwcDFK0AjSiC4Z30ypHalFTdLBFtNcgvI
	zG2CUgMijFKiiBAzcnLNj2zM8URmNk2vVpZ1O30W7+2ZpdDEGt8yFAkft0E4FxxxaoNBnsBi9Lz
	5gTuL83FxGLnwpZmm1d+G80zvNn+Fi6rOl9sDeZLIhrcLzn3pbns02m7zy2ceQJz9ochIIAJ2vm
	46tNZVQ6pKmC0=
X-Google-Smtp-Source: AGHT+IGLMBqAzBAWo4yb7tpIYsnetp2fYl5pljocfiHOuE5aX2wPJYCLp8EgyaUT6wEF75bnJiiidQ==
X-Received: by 2002:a17:903:ac4:b0:298:2afa:796d with SMTP id d9443c01a7336-2a2f2a56707mr203430055ad.61.1766708408379;
        Thu, 25 Dec 2025 16:20:08 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d5d1b8sm191462195ad.68.2025.12.25.16.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 16:20:07 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 1E93540A3327; Fri, 26 Dec 2025 07:20:03 +0700 (WIB)
Date: Fri, 26 Dec 2025 07:20:03 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
	viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
	corbet@lwn.net, pierre.gondois@arm.com, zhenglifeng1@huawei.com,
	rdunlap@infradead.org, ray.huang@amd.com, gautham.shenoy@amd.com,
	mario.limonciello@amd.com, perry.yuan@amd.com,
	ionela.voinescu@arm.com, zhanjie9@hisilicon.com,
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
	vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
	nhartman@nvidia.com, bbasu@nvidia.com
Subject: Re: [PATCH v5 07/11] cpufreq: CPPC: Add sysfs for min/max_perf and
 perf_limited
Message-ID: <aU3Us1NzlpVQcyii@archie.me>
References: <20251223121307.711773-1-sumitg@nvidia.com>
 <20251223121307.711773-8-sumitg@nvidia.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t+JMDWcZpMsJclIY"
Content-Disposition: inline
In-Reply-To: <20251223121307.711773-8-sumitg@nvidia.com>


--t+JMDWcZpMsJclIY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 05:43:03PM +0530, Sumit Gupta wrote:
> +		Write the bitmask of bits to clear:
> +		  1 =3D clear bit 0 (desired performance excursion)
> +		  2 =3D clear bit 1 (minimum performance excursion)
> +		  3 =3D clear both bits
> +		The platform sets these bits; OSPM can only clear them.

Sphinx reports htmldocs warning:

Documentation/ABI/testing/sysfs-devices-system-cpu:356: WARNING: Definition=
 list ends without a blank line; unexpected unindent. [docutils]

I have to fix up the bitmask list:

---- >8 ----
diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documenta=
tion/ABI/testing/sysfs-devices-system-cpu
index b022cbf46adcfe..8cda698019922b 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -363,9 +363,11 @@ Description:	Performance Limited
 		requested level. A non-zero value indicates throttling occurred.
=20
 		Write the bitmask of bits to clear:
-		  1 =3D clear bit 0 (desired performance excursion)
-		  2 =3D clear bit 1 (minimum performance excursion)
-		  3 =3D clear both bits
+
+		- 1 =3D clear bit 0 (desired performance excursion)
+		- 2 =3D clear bit 1 (minimum performance excursion)
+		- 3 =3D clear both bits
+
 		The platform sets these bits; OSPM can only clear them.
=20
 		This file is only present if the cppc-cpufreq driver is in use.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--t+JMDWcZpMsJclIY
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaU3UrwAKCRD2uYlJVVFO
o4kvAQDTEVNeFeX7ckTchAsnDcqX6/lgn/RtWuqlH3bGU25fFwD/ZEKQGJS37yff
aP5cML3xRpih8KZ3CuP+1ul/2sh1TAI=
=OMhn
-----END PGP SIGNATURE-----

--t+JMDWcZpMsJclIY--
