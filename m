Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D495235F07
	for <acpica-devel@lists.linux.dev>; Tue, 14 Nov 2023 20:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YKN3kG6k"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5af6c445e9eso70428837b3.0
        for <acpica-devel@lists.linux.dev>; Tue, 14 Nov 2023 12:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699993225; x=1700598025; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LgIMZhFr5ANe/opk6rHwzR0Wea+pDhCr2RohibRDeJI=;
        b=YKN3kG6kDd8VQn00hXchanfAhsW7Rx4YKizUL5zDYRQCfW/niF4fjhB3+HvGJVPZct
         6hOlngtmjatHe28MdiTRCk3h4nuqKs/nls1vzkriNe4A6PChN0zjcHO9jnOwJ9yf61IA
         hxR/bw8CxYLFJByKVefaxxhTbOklETpqjeu9Jmf35ft5P0onI2ylhocnWR/St5Ik2+mJ
         pF8yexqTte8cn/qJEuqC6b6APnFO3GIQ1E4j0ot/jGo71/0KCG7TPdn8sCem9IC3psPJ
         70w1XeqtTDp1Z82QtexbqTCDXxsICLnU10jq4SxrgYC51Q8vZtzX1kDEIF5cWUx0XTVb
         2peg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699993226; x=1700598026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LgIMZhFr5ANe/opk6rHwzR0Wea+pDhCr2RohibRDeJI=;
        b=aVzeQPVHAmed2QIR0jghrH3aHEQwUpdhNQygQJu+8E3rshKgcG33dF34RT7OrEj9oN
         s7sIHQIP167LVkLZe8ucT04pkso8M2vPMXdav3ZQYz+NHWBf+RJWjRod2BT8pie/6wVx
         3EJpJ2dJVvzLLq3/4ol+aGW14haf04UBzKmpyNv8pQcgnOKZf2Yotv/RxTUg4dCbh6lo
         2MSf954tEBfPMRtLRI0XteCLkblRC5vGVgyjKkllHlRd9Xg6WF9Ymbz8A/UdNt6EK6ci
         ISnmZXb54Itf/eJ3MJF27RX/ziclWnZFe9G2BGS/Qv7AVHHUqbiuMTxnwsucyXv7HtnX
         MbfA==
X-Gm-Message-State: AOJu0Yx/DNlwUa2DCgwEgoqxx4/mA3CnTLC71fKTw8eO/97+gNbtA7mA
	X8Qpoll/UGMBkpqT8/Ox9KKQYMT/zjLqiZy2pt5E5Q==
X-Google-Smtp-Source: AGHT+IHDLBa3i08U+nLN0OG3yu/iiLd302obDuxMCccsocWSzYdESyvlcJkxV2yuKipJLTHkRfWr3hMnsJhJHv5hRTQ=
X-Received: by 2002:a0d:c505:0:b0:5a7:ba00:6dd8 with SMTP id
 h5-20020a0dc505000000b005a7ba006dd8mr9813769ywd.8.1699993225750; Tue, 14 Nov
 2023 12:20:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231114-arm-build-bug-v1-1-458745fe32a4@linaro.org> <b2354c21-3a1a-c446-fee0-db0c78d05c71@gmail.com>
In-Reply-To: <b2354c21-3a1a-c446-fee0-db0c78d05c71@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 14 Nov 2023 21:20:14 +0100
Message-ID: <CACRpkdYUzYxV+NY=mymXP59mt9msTUvSXM__f+4qRM+_xjX0Nw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: acenv: Permit compilation from within the kernel
To: Sam Edwards <cfsworks@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams <dan.j.williams@intel.com>, 
	Hanjun Guo <guohanjun@huawei.com>, Arnd Bergmann <arnd@arndb.de>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 7:09=E2=80=AFPM Sam Edwards <cfsworks@gmail.com> wr=
ote:

> I am not an ACPI subsystem maintainer, but my understanding is that the
> files in include/acpi/ are copied verbatim from ACPICA, so any change to
> those files will have to be sent to the ACPICA project and wouldn't be
> accepted here.
>
> More likely, we'd want to do something about the circular-include
> situation between linux/fw_table.h<->linux/acpi.h.

I agree but I have no idea how to fix that really, should I just send
a revert instead so the authors can get some time to figure it out?

Yours,
Linus Walleij
