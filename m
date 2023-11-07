Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4838D315A6
	for <acpica-devel@lists.linuxfoundation.org>; Tue,  7 Nov 2023 19:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ImXWgPtz"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A8A37415FF
	for <acpica-devel@lists.linuxfoundation.org>; Tue,  7 Nov 2023 19:41:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A8A37415FF
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=ImXWgPtz
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ombT8tmOyAzp
	for <acpica-devel@lists.linuxfoundation.org>;
	Tue,  7 Nov 2023 19:41:21 +0000 (UTC)
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9E895401C7
	for <acpica-devel@lists.linuxfoundation.org>; Tue,  7 Nov 2023 19:41:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9E895401C7
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-7ba8e3107c9so2375672241.1
        for <acpica-devel@lists.linuxfoundation.org>; Tue, 07 Nov 2023 11:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1699386080; x=1699990880; darn=lists.linuxfoundation.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NBDSoZLsqhzBsujquqEneysCLm0iCwNY6IdC2sVlDKA=;
        b=ImXWgPtz8c1AkYoEkuOmk6pEFCVMdMdal2vODAgHGMBgQqXPMEeDkiKtAA2trElX8o
         exKqzmNmhJrv0eKMCRNTGecGDZLd3dWMAiJtLGNyXPBPVFCA1C77Eg2LVUSTYPh/KVuI
         hW1BFSKW5fKuAY04WYfrBc7dHuD9QpYNLuGs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699386080; x=1699990880;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NBDSoZLsqhzBsujquqEneysCLm0iCwNY6IdC2sVlDKA=;
        b=abXaI02E4If8ypqn+RBE4ATvV1AMNpxSEFyKEP2m9jmgmgsA3aj4DcVIgcK1Somjmx
         oRfHKSTLqGhcFtyVLLQpYdu+YrYF0I1cfuz3XfkDAGOo29EYfjIDuLItCNVNpakobCbZ
         Nuu99WDluDjo+eVClDLh3QSXbsKLVkCC2KYl4NkmWew7NDiYdqSLyHScIpbJVDLwKsqG
         txmkzRknWAzWY8H0OA9kSpaL6TiD5YUPZF7TzRfEUWMMI9gNZ+2v2uRXxFunWCNn5+1F
         +pO0u4kaXy0arTXbaFclDTa7pYdek6KLy/Nfc6CQXTb0U9fHxhxDgzgpWoIE5v2t7kTp
         1E0g==
X-Gm-Message-State: AOJu0YxgG5V1nj9anW5tSjqby0xl3N9ErAn5km823tEe+nCF4CLc4Lpe
	UmztZc5TNvrzEYiDn9SCCYoVlxFL+6chELGjmWdjHe6b6jZftEYyB/A=
X-Google-Smtp-Source: AGHT+IGZdnBLRoeGDfLmFl784v3idIfOLMymIPL0jLyHPxCGQ4EY4EA+BG+98jha5o+n1br2A3kcXwzrOLcbtNpprCE=
X-Received: by 2002:a1f:2996:0:b0:4ab:f279:ba33 with SMTP id
 p144-20020a1f2996000000b004abf279ba33mr11849440vkp.16.1699386079761; Tue, 07
 Nov 2023 11:41:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231101-judicious-uakari-of-debate-f5aefc@nitro>
In-Reply-To: <20231101-judicious-uakari-of-debate-f5aefc@nitro>
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Date: Tue, 7 Nov 2023 14:41:09 -0500
Message-ID: <CAMwyc-RtnBTmDjs2QU4fHF8z=4_f9o9WqWQvN+GrkoxL6Nnd7Q@mail.gmail.com>
Subject: Re: PSA: the acpica-devel list is migrating to lists.linux.dev
To: acpica-devel@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Nov 2023 at 17:26, Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
> The mailman-2 system running on lists.linuxfoundation.org is being
> decommissioned, so all lists currently hosted there will be found new homes.
> *On November 7*, The acpica-devel list will be migrated to live on
> lists.linux.dev, but the impact of this move should be minor:

Hello, all:

This work is complete and the list is now migrated to
acpica-devel@lists.linux.dev. The old address will continue to work
for the foreseeable future, so any existing conversations can be
continued without making any changes.

As a reminder, below is the impact of this move:

> 1. The new canonical list address will be acpica-devel@lists.linux.dev.
>
> 2. *The old address will continue to work* for the foreseeable future, so any
>    existing conversations can continue and any new messages sent to the old
>    list address will be properly delivered to all subscribers.
>
> 3. All members will be automatically subscribed to the new list, so no action
>    is required on anyone's part to keep receiving list mail.
>
> 4. The list will be archived on https://lore.kernel.org/acpica-devel/ with all
>    prior archives automatically imported.
>
> 5. The List-ID header will change, regardless to which address the message is
>    sent:
>
>    before: List-Id: <acpica-devel.lists.linuxfoundation.org>
>     after: List-Id: <acpica-devel.lists.linux.dev>
>
>    You will need to update your filtering rules if you filter based on the
>    contents of that header (on or after November 7).
>
> 6. The mailman footer will no longer be added to message bodies and the
>    subject will no longer be modified to insert [acpica-devel] (because this
>    violates DMARC).
>
> 7. Subscribing and unsubscribing will be done using the mlmmj supported
>    commands, documented at https://subspace.kernel.org/subscribing.html

The list is now archived on https://lore.kernel.org/acpica-devel/.

If something isn't working or looking right, please reach out to
helpdesk@kernel.org.

Best regards,
-K
