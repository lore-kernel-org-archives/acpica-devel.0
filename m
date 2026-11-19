Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795062830;
	b=Ex5711PbLZVXmc3Vy1grDrFfadyCrrCUghsY3d2u2DtuK4uWdRMl7sSfiKwvqpa9uWiP
	 IdUoKuxyDByiEmMl7j1m+Nn8y8ENrs+grWDAsAKZJFWusOxwl9tGQFQBWg0ouhZbLIide
	 vDfoAJ204Ffgon5kql5vbdK7ROHiefGtZvUdhLlJNT7zML5UoBW/MjhsMb/meteKfJLte
	 VRZTUMQV/qEu2ZtlyQJ8Mf69zea0ddJ3Q9+3UvIwjuwKQlMrXQ0LvnzXIu9zky/6ETOJQ
	 k2uJMXnV1RcuEqldrFgkoeZZfwD4hNN9OKCct5TcVmAMQ7SVYqScwaTq/VEXbmt+ufw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795062830;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 MIME-Version:X-Received:Date:X-Google-Appengine-App-Id:
	 X-Google-Appengine-App-Id-Alias:Message-ID:Subject:From:To:
	 Content-Type;
	bh=7TD0Md0mVnFdPLU1Yyiv7w9mu5gUlK6e+evzCk4KI8U=;
	b=V5ZR000Iruy4g0eoFQ+aJIm8w1fpXeo3qFjc3ZV0KzagB2QFJECrXArzq0as6r/0N/8h
	 gehJQs6i81W9euJqTbFFk7gBItRTA+4Acbgs/E6UVeB97rQjFbts76+yWrXHIK8f3dqsg
	 bnwdhWyckJBWtZpaHSnbkaqiVnixP7Ip0yzfMa11LNZaihEs4u3Wt4jTaQxbG/odfKhyQ
	 RjXLcKvLafjqHgJpFR7SyWvXiJsb4fuGLxCFoJeOy+dBYwyBLOyZMz1UFLEiFbSEhe2Pc
	 FC0CmavSU6Qch5/yL9Xf4z/5NhZ6VJ1usyRkoL+ccqOPTN7wE14R9PNhyBwQfWT7ATg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC22606A320
	for <acpica-devel@lists.linux.dev>; Thu, 19 Nov 2026 04:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEC22606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4cc89e86e9eso1904243b6e.3
        for <acpica-devel@lists.linux.dev>; Wed, 18 Nov 2026 20:33:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795062828; x=1795667628;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7TD0Md0mVnFdPLU1Yyiv7w9mu5gUlK6e+evzCk4KI8U=;
        b=e9QjSMwGV49U+S2iTUNyMdPHtHP28QjR2KedPDFmejo3CfhyDyxth1+jqdmyrLYMaO
         HH3aMUKIPAXjY4/4v4exUtXRVU3ha1CqQR9EcKeHyIr6tpHkBJRKVSTHrcDfJduzL91F
         PQAC68p3hD52ASQ4JMZV8qH+3sNwP54hggQYkS5vj8LNaMuvW8rg75+niWmcOXwVtVnp
         8OZji7VJcEtWp9oB3AH2MRP394TAhQzORQDGDNFm3fLxxH8vIWq69KhtwkD6ADhpCPjE
         EKE5i7zeZwQjsT7t5jaJbkIJUL4MAf9e3uczZpkFrwkS7kpaqs5BQkMHsScqs/ZCFCmQ
         OiXA==
X-Gm-Message-State: APuU4Z8VnERiJtIhzy4aUwGbRnHEQLW5HaUi65rxQbYSrBR3idyNglpT
	TY54pMHanpNOoVKZ2SbaelVW01wbpIgpJ6cje8B4f34QxVqzestJ30xcRR2M2dthUCnTrQhuq/8
	AJJAi3tGIP4cOi1KMhrbdMoH66aCbgXqlpCdwyCIIELj42+5BisU+mUPNcys=
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Post: <mailto:acpica-devel@lists.linux.dev>
List-Help: <mailto:acpica-devel+help@lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:acpica-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:bc7:b0:571:9502:8303 with SMTP id
 5614622812f47-5774171cd65mr5660064b6e.50.1795062828749; Wed, 18 Nov 2026
 20:33:48 -0800 (PST)
Date: Wed, 18 Nov 2026 20:33:48 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6afe7c2c.902182b0.170f33.0000.GAE@google.com>
Subject: [syzbot] Monthly acpica report (Nov 2026)
From: syzbot <syzbot+list0ad76eb042dcf70ab97f@syzkaller.appspotmail.com>
To: acpica-devel@lists.linux.dev, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, maciej.wieczor-retman@intel.com, 
	pawel.chmielewski@intel.com, rafael@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello acpica maintainers/developers,

This is a 31-day syzbot report for the acpica subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/acpica

During the period, 0 new issues were detected and 0 were fixed.
In total, 5 issues are still open.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 14      Yes   KASAN: slab-use-after-free Read in acpi_ut_update_object_reference
                  https://syzkaller.appspot.com/bug?extid=c6c92a97a9907f92fa1c
<2> 380     Yes   KASAN: use-after-free Read in acpi_ns_get_attached_object
                  https://syzkaller.appspot.com/bug?extid=5725792ce6a9938d1b24
<3> 2       No    KASAN: slab-use-after-free Read in acpi_ns_check_package
                  https://syzkaller.appspot.com/bug?extid=e1268acad3c273b12120

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
