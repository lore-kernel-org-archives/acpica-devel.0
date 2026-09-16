Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410104B1CF8
	for <acpica-devel@lists.linux.dev>; Wed, 16 Sep 2026 23:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602477; cv=none; b=ojxhzH25QyOk8xL1aVaKfD1ZRiCJ6kM4gbT9kC0Q0Q6Y+c/3rcSQmtQ3K3cd0w6vvugnVlfbbfdAz/oMZtP8xVLzE+7D1qCo3A1sMJjL8PmrryaAfwsjk1LQMFSuGUTHbE6QccE7OJjSRBAKx7tqWPTeB89FvQB+p/IkqBLHm1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602477; c=relaxed/simple;
	bh=8ZZmEzmRY5l1Bk+XRrbRnE93cR7GfxYZTezIz2U6scs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GQw1mkxqnpPXAm8Um2vEoMCi9feDKQJ1GjltnvttmuBjk3p8gUvCegOFMhqY72FVqCQ3Ij4DIDvaBbunqbY6+uajfz1F6mf/2ePsXWAudqvxGzy7VqafLjTmNjOHhamPUDU9mHSZlSLr8aT1mScwbmP+P1ButuQTlsEK0ybjjz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=kyybwByb; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="kyybwByb"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccafb752so208454a91.0
        for <acpica-devel@lists.linux.dev>; Wed, 16 Sep 2026 16:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1789602475; x=1790207275; darn=lists.linux.dev;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8ZZmEzmRY5l1Bk+XRrbRnE93cR7GfxYZTezIz2U6scs=;
        b=kyybwByb8bkSmj7bY7JVDxEJc5dzqdK66sjbvE5mcjCfypeUFG4pyHHAfX7gQxtVqO
         dfh9LIFUbcxV5tDYKvIkVtxz+76/sHRbfnmptMRPvCMXCazIWxGvXWERoKJ67ea61BwP
         Zksl6uiySJnlWoGx9cYoECV5XEyFrJoIvrbmFJXiPlqnpgxcdLLyA7f1+fLmqu1b24rN
         GLEenj/vbKb25iE1Tau5KFbdFalT19wSYi6G1LXC1eU0BZvMutSnTzc5k33kMscIseQO
         j8DaqWG8iZPxwfY1OrZZoWgJLeOeqqdYWoF+SxGho6G3WqlWHxXygrz72AeFV6CehjmT
         m3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789602475; x=1790207275;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8ZZmEzmRY5l1Bk+XRrbRnE93cR7GfxYZTezIz2U6scs=;
        b=kkyO3tcN1l0L/zA21hiBnxQLEZ7qEwYdktlJXApvCdit0VsOw48YaLWBmKtLd2FhbN
         Fb+Y5tEJAwvzD/6NDzZOJPk7KsbigTF3ShKn2OI6uFRasQ6qYjvvJPpvEuO3A0N4tQHf
         QmUCLDMSBsCDr+fN1IPnk/+r+T0tfDxSjHo51Y5CZ5kfG9BGerlFxgVD5WE6gkDMa09Y
         PXxpC0q2uB5Evy7sy0rAiV1LAcFTlwunPaVGl2AuFwFmnriViDvR0ObKgtYrMqFTukc7
         7msNzHLBW6v9rs/wpLftghzpYY2GERzFB98OSdx4kel9UW3zJ4LQJVbYBRxBxIZ9y4/E
         VQMg==
X-Forwarded-Encrypted: i=1; AKwUvBwjX+FgEtceLOIZNBf2Pj8ss8CBsQgsd5Q1/+dgPs5MqP8w9orc6Q2kG41wKlSP1v0xtXCNRMBkAdYyKJk=@lists.linux.dev
X-Gm-Message-State: AFuF++nylEGTo4kEGtfrJg6FTEKpb00EII8Pz1Oj0V3R1GIH2fGkTWWl
	Uy4wkOCd4WTDT5ULUeZu0iPOwr5eC9C/CE6+RrfwVXEFK+5ajDCcoyH8Sdc9G0FN1g==
X-Gm-Gg: AYBFou12haVt3zxTr3HiHb49xw0TiY3VyHt8PdbbaiTBQkdVJRnnMWypNdzOtNTiUI1
	PwTLpqNPj7+gtD/9ioil72sPzeNEusO07EKE7eb5e1qnyPLeeLBjzMwqd8bUihjBiz20wA7Tzwz
	I6mLFs2LTFt8FpUxXlTQcsZI8v7WsAHrXnddTe6bEF/URa5EcSv13JCdY5KIQ0ybOQpa1Q65WEN
	wZcCgLvo9Y1DS27Pwc9gklVu2tVPEiu51+xH/v/rofp2zb6JBPzlePNaFX9d8xp+xOhi+qWNKL5
	AUVXhp7BjD+nI10Iq534dRhWbWirUo7/Ykusu5oF1ncpash1konhxfMDnkTrEQmi5q7NUzFKOxl
	2EGsTW5iKwk9WqWBP4mZ89tqPXUZZLHl3sIeLeH8TrhNRuCTz5tCsvJYF0WMBguCBLXvlo8bJEJ
	n4C9rERdVg4sb8X4d86epBghlGftMtbOhIHHUz3Cx1ON2C9OGTACboIb3JrApJdNoVy2JOR4i8m
	zu65yH155qMmZ5I41IkzTWHjzIZMROnWEg=
X-Received: by 2002:a17:90b:5624:b0:39e:b7:cbef with SMTP id 98e67ed59e1d1-39e1e5612d3mr14829775a91.25.1789602475478;
        Wed, 16 Sep 2026 16:47:55 -0700 (PDT)
Received: from p1 (209-147-138-4.nat.asu.edu. [209.147.138.4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14395d5d0f3sm9085370c88.12.2026.09.16.16.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 16:47:55 -0700 (PDT)
Date: Wed, 16 Sep 2026 16:47:53 -0700
From: Xiang Mei <xmei5@asu.edu>
To: stable@vger.kernel.org
Cc: rafael@kernel.org, maciej.wieczor-retman@intel.com, 
	pawel.chmielewski@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, bestswngs@gmail.com
Subject: [STABLE REQUEST] ACPICA: Fix NULL pointer dereference in
 acpi_ns_custom_package()
Message-ID: <ztqdpwmbpfusfens334indnsykgejamscwhv6dylk6xckr5uyg@scsb6egwneel>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi stable team,

Could you please consider backporting upstream commit

f8d14b7bb0063bbbd86c0e4d73edb8cea7b362bc
("ACPICA: Fix NULL pointer dereference in acpi_ns_custom_package()")

for 6.18.y, 6.12.y, 6.6.y, 6.1.y, 5.15.y, and 5.10.y.

It prevents a NULL pointer dereference when firmware supplies a _BIX
package containing an unresolvable first element.

The fix has been in mainline since May 27 but is still absent from the
longterm branches.

The upstream commit applies cleanly to all of these branches.

Thanks,
Xiang
