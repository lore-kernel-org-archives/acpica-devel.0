Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0693143637C
	for <acpica-devel@lists.linux.dev>; Tue, 30 Jun 2026 14:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782830981; cv=pass; b=XMac5E5cHbhigY45ClIbJSB+9o7T2cDfRYs7RwzvuZMO1sICv2tUssZpYT6OScAx7v+DBt6OW7W1IeuN594H48+XtW/ioFR61oVtRSUC9DND855CLO9lQcl9gK8dc3Cyb65yF8LuU0Bk0kM+cywcDirA+kXEgABh8+9qgkWIfnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782830981; c=relaxed/simple;
	bh=R2RLlWKV31uw1vmm0eE8g4HAQBST/y2tQNtzmoB595w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IDIxP2O9WTSuKRC6lvhBA6HBUUUPTNwFjDo6S5y5sBknZtPFy4c2GIHdKWpS5pW3Gf655Tr80BjUZW9wZs6U9ZuAk1UTHBdXF54EprFGMtCExdfHl+UGVEBbRU6Y6wH/h3qd4JI5ahQBVOrS9HX8BfqiT+31aP3r05h/KVLXhK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbuNXaZL; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbuNXaZL"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-39b03d41976so25111201fa.3
        for <acpica-devel@lists.linux.dev>; Tue, 30 Jun 2026 07:49:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782830978; cv=none;
        d=google.com; s=arc-20260327;
        b=G8+bd8WiI4CcnyZjC/X2VRgg0iw2/6qxo6XF/+RkuzXiqpEReUnDl0msNMmuPYYElO
         6AV5to3k1DUZAtY/ZZaJydzIRADQmt0xKHJHxP4CFitkSOcIO1GFQbDetLH/8RXUGTbB
         mKZg/qcr0ZOIQL3eKOvm2/3AdfFBgN22s+2rc1kBda6DrhTE5m3T1VUgKOVZAclvRukO
         IfuSlm8L9OrMJwV2x6gORiOyMNhmuOzfWJGkX3a1XdFuVNtwOH4MkE0s/pGN2J08MJtL
         VUxa5h564gHCS8XJzvcesAdbiFuSXNga5ZHgwsMMqW8pFqXD04nODIqZyq0UHbnMvLxz
         IwhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BAHFXtMiFS3SQCPXfcc6nAkzBIK1JQ7gQg2BRXU7Bfc=;
        fh=/BEEOMBPdPZFR3AVUqgKy0gdmI14vOZEWlk/HI2kUjI=;
        b=HPSgwD/HWunoZgS/FabX43aKYF6jYr0nEoKl7bpi/UnPY+FxLMXzUYkF+gsisYTxUN
         emkIQ1KYmrPSsex5NS1ywMvtI+z9E4TMzuQKK0nHfhafiUhEjvZf2Mhqiju1hCllpimM
         z4JIHD0TX71IdWssnG2cGhfZ3oXLnPA2QYItOPfR0hMW/FIIxVQ/+BInXTqfni6KjWaN
         bgYJHbHviHFVfZgUjrd4QKsiOe/Z6SPf9SD8lL7t7zfcWjlB4JolSpzddmY9XFCc+e8h
         fdbVN9hODHF0QLNlCNOMehRJwB6jcmF1NDIVcTLQSJ5Prh583gZUc67wWApBSdCfkk6z
         knZw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782830978; x=1783435778; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BAHFXtMiFS3SQCPXfcc6nAkzBIK1JQ7gQg2BRXU7Bfc=;
        b=PbuNXaZLYfxScYmU/7K+VbO7eSljV3wo/ADfCF7HImQP3mLGTdH/mKmSVc7y4Kpq2S
         EfOdCIy3nuDUk8wFPYAyKCZ2EXF4JE3WrQcTWdySfUGeqWJ10txU5DAIkKc7I6RGnZpQ
         nX7SNvSlscBgwt+tmD1f79lyAFVJilT05/jf5o5Dd8xdY3jmn4ki8sCUf8h+e6Th0rPe
         nkbdZwHCTR+Y/Hj33+rMP0Ox0KjY9o88Rz9z60+/yQytNqWqpRaX3TFNAZ4UWKpf6T2L
         9sXgpVAFlhwJ0f4NM5Q+5gh5Xa36wWnJOwPbAUzB8P0qFyuk6Nx1uPnBRNMmd4lRyEC+
         h35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782830978; x=1783435778;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BAHFXtMiFS3SQCPXfcc6nAkzBIK1JQ7gQg2BRXU7Bfc=;
        b=KxJ6Eo2rtOCwpJrawNQZF10dGMLkCh8KAyZcJ0IFGCTFBxW4l1jNkdoxzRaGK7Ly+t
         KDryJ9ymivtu272oMQEOfjFvgh+DaOxidvch6ec/Tc6uVbujNgobJIGMvKOQBHIrBuPx
         vB4kfmtOi4K38Z9dE7WsNiMxtkg5eGtgZlYbkS48ErXRTVdStiTjy/N+ubeQQKGQpNHj
         laqMMm8/mgpq4DCsYHc0Z1mlXbHZ9mAOZ6kAyv77kCoSbkUXWdF+wVcj4ZvMQXYl0sWk
         +ueJPmgkdsuV3UbLsrDMlojn8mYMV7R1ku3rAk8fSPsSZHfWwTbOjb3GM6mDcJk84QX5
         UmNQ==
X-Forwarded-Encrypted: i=1; AHgh+RpTsvRYdqPOlAO42241hD+R8edUkfuLERXK9MGCZBM0XuZ+UJBs1/nfY/XATQdBmJmBZylvsgjbRYekcSA=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5scsuVuSVXTpGW2Pw43qke+eW2Q/v2o9rXJWWI+aVpduWKWq+
	8tuPY/S1CL5HCtrpciRhGwpO+ZgolLUPtb31se9KsSJj4K/bwSaQefqpU7eR/yxrDvBXltdkZ6k
	3igLq8cIMGZQ5byDPCvOxmkAl2Fdyzk8=
X-Gm-Gg: AfdE7cnFgA1VeiFeLmnaEzGSSHHH683nTwC5XSZ7sZ7mRpStnGim3JMPTac+ob3ahsK
	xXKrCgPhIe9I3hpVzvF/1lQbWBmQk7A4DukU9JR3+NtRhmvtMQGvZHGW7Pxd7PKdzTi0yCLOnhP
	H1EIKG1VY7lS8aPzdURc2bYhdUV/b0WH5n6mIzfOKouoh8PhGb4hI+aG3sEUcO/PlCPi0VZ76YG
	qCnsUWAN+0eiLkuqLcTvp1VvhoFf/R2H5cY55qH7VmKMaSF7Ww7kJB/w9F11RjyRgojKbR3wQrE
	J2skRqL2c555lj+QZQwTAbf9qqU3gD4EddWiuBxOhZ0xrr5AZPqYRF7do0vhkyDZPH3DwXt+GDr
	+fuW9kCn/KrwoJYmlg5ac
X-Received: by 2002:a05:6512:640e:b0:5ae:b6cf:2869 with SMTP id
 2adb3069b0e04-5aebdb9485emr981524e87.23.1782830977995; Tue, 30 Jun 2026
 07:49:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <aj5KJEIsTl6IK0nX@gmail.com>
In-Reply-To: <aj5KJEIsTl6IK0nX@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 30 Jun 2026 22:49:00 +0800
X-Gm-Features: AVVi8CeNolHc0bWFWi94se6V_El3cArCALeJfgf0e7sVp8JXgJSa3XDzBUrtcNM
Message-ID: <CAL+tcoA6=_paEdqWaY7-VHdBeAxEFeMCfTECAEGv3C6ZqFUNSw@mail.gmail.com>
Subject: Re: [ANNOUNCEMENT] LPC 2026: System Monitoring and Observability Microconference
To: Breno Leitao <leitao@debian.org>
Cc: linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel-team@meta.com, 
	linux-mm@kvack.org, iipeace5@gmail.com, gavinguo@igalia.com, 
	linux@jordanrome.com, amscanne@meta.com, sj@kernel.org, gpiccoli@igalia.com, 
	Daniel Gomez <da.gomez@kernel.org>, mfo@igalia.com, platform-driver-x86@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 5:56=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> We are pleased to announce the Call for Proposals (CFP) for another
> edition of  System Monitoring and Observability Microconference, this
> time at the 2026 Linux Plumbers Conference (LPC), taking place in
> Prague, Czechia, from Oct 5-7, 2026.
>
>   https://lpc.events/event/20/sessions/262/
>
> This microconference provides a valuable forum for key engineering areas
> such as:
>
>    - Kernel Health and Runtime Monitoring
>    - Hardware Integration and Error Detection
>    - Correlation of Issues (crashes, stalls, bugs)
>    - Virtualization Stack Monitoring
>    - Memory Management Monitoring and Observability
>    - Anomaly Detection Algorithms for System Behavior
>    - Automated Analysis, Remediation and post mortem analyzes
>
> The purpose of each talk is to share challenges and discuss potential
> improvements. Sessions will last 20 to 30 minutes and aim to encourage
> brainstorming and open dialogue about ongoing issues rather than
> delivering immediate solutions.
>
> The conference acts as both a knowledge-sharing platform and a strategic
> venue for guiding the future of kernel technologies to better meet the
> demands of large-scale infrastructure.
>
> We invite you to submit your proposals here:
>         https://lpc.events/event/20/abstracts/
>
> Please select track "Linux System Monitoring and Observability MC"

A kind reminder: at the bottom of the page [1], please click the
'Submit new abstract' button so that you will be able to quickly
submit a new proposal. (Admittedly, it's a bit easy to miss the entry
especially for the newcomers)

If you have any questions/suggestions/problems, please do not hesitate
to contact Breno or me.

Again, proposals are greatly appreciated :)

[1]: https://lpc.events/event/20/abstracts/

Thanks,
Jason
