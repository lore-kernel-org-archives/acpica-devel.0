Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB0A241F4
	for <acpica-devel@lists.linux.dev>; Thu,  4 Jan 2024 15:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/JKNvfA"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bba0ac2e88so633392b6e.0
        for <acpica-devel@lists.linux.dev>; Thu, 04 Jan 2024 07:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704382947; x=1704987747; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=5oMiGZMowUzqMWGwhCBfkbKcvKR9HrULZLN+Y7bf4S0=;
        b=j/JKNvfAk4LtDjTZG0XWTShlMWqaedgA9Ke7zxG50zQABGKPpkvkwodWmg0Ws2agg/
         aTfCvbyWegcHD0vJMGNFgD4KRrr0gufm26aji8dFMRoI2QgP0uQ2fGP8W94IEjG5+2N5
         KRpQhpoU1a0ckVmEnU1nKIzd6cCaGtYGijmB5uttLqXoNIBZFoDY6MPH3IPikuOyoK6v
         Fs+tzk144YtLVjZAtqRopGUShL+IK/bUDeK5s2SbbSBiXW6zRgHIW/bc6OhwMCUZzQBC
         rIYL7OYcbFgHnlN3cKTa4Vao1efPRkVjdROeSIIg8dhp2PyATsLnZzOqSwVp8ZkQKI+f
         PR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704382947; x=1704987747;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5oMiGZMowUzqMWGwhCBfkbKcvKR9HrULZLN+Y7bf4S0=;
        b=qWJnI/32u2jlMj1TdMs4ERdSHEN+ZFzkn2IlYyFazjO5ljZ2Dwhc/7STccTVZVpqzA
         prscsogxuwDv4SWMagl8U1RN6qdpwQa6moJ2h7Z4WkzWoPX/TIr3QTns8ztVIg/VNE0k
         T52oR6PCjvfCRAYGIo2hOohRcFKSO2NjsUhUeLy2MYsmHFmLt8ust7rBCWMrPdQbJIY7
         RuWDl33jjxjQAp4Uhlb20fikzKWWjMfWpGrlV2/OUsE2Ph3485adok0z17CYBwT8NyFg
         rvwzN7W/tnNG66dbckD0aem2cWF5PbZLSuNHWq8lSJYP/KjBarHL9voHUpCIRHqSeO39
         rx4Q==
X-Gm-Message-State: AOJu0Yx9bOqM0eDD3SY5rSOIXywj8lnT6sN09eD1lM9/HY7/wp6n+d8P
	3iMuiAo5VmqZfUVkzHSrzg==
X-Google-Smtp-Source: AGHT+IGBVcQOehWgZgtVkqUEVkpT4ymFf47CPxuZ3r/zwB3M65lL8wGjFXR+faDYn1CyfX3tGNuADA==
X-Received: by 2002:a05:6808:1401:b0:3bc:23ca:b8f8 with SMTP id w1-20020a056808140100b003bc23cab8f8mr293904oiv.27.1704382947589;
        Thu, 04 Jan 2024 07:42:27 -0800 (PST)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id ct6-20020a056808360600b003bbcc7ad593sm2208336oib.34.2024.01.04.07.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 07:42:27 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from mail.minyard.net (unknown [IPv6:2001:470:b8f6:1b:8b39:45b4:3a91:698e])
	by serve.minyard.net (Postfix) with ESMTPSA id 754301800BC;
	Thu,  4 Jan 2024 15:42:26 +0000 (UTC)
Date: Thu, 4 Jan 2024 09:42:25 -0600
From: Corey Minyard <minyard@acm.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>, jdelvare@suse.com,
	linux@roeck-us.net, Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v3 1/2] ACPI: IPMI: Add helper to wait for when SMI is
 selected
Message-ID: <ZZbR4X6z9wkSESzD@mail.minyard.net>
Reply-To: minyard@acm.org
References: <20240104024819.848979-1-kai.heng.feng@canonical.com>
 <CAJZ5v0gNa7XvUo3B1srXaWBrWx+Bx=w=D7ddi-mqda8xBdWwCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gNa7XvUo3B1srXaWBrWx+Bx=w=D7ddi-mqda8xBdWwCQ@mail.gmail.com>

On Thu, Jan 04, 2024 at 02:34:52PM +0100, Rafael J. Wysocki wrote:
> On Thu, Jan 4, 2024 at 3:48 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> >
> > The function of acpi_power_meter module on Dell system requires IPMI
> > handler is installed and SMI is selected.
> 
> Does the firmware use _DEP to let the OS know about this dependency?
> 
> > So add a helper to let acpi_power_meter know when IPMI handler and SMI
> > are ready.
> >
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> > v3:
> >  - New patch.
> >
> >  drivers/acpi/acpi_ipmi.c | 17 ++++++++++++++++-
> >  include/acpi/acpi_bus.h  |  5 +++++
> >  2 files changed, 21 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
> > index 0555f68c2dfd..54862cab7171 100644
> > --- a/drivers/acpi/acpi_ipmi.c
> > +++ b/drivers/acpi/acpi_ipmi.c
> > @@ -23,6 +23,8 @@ MODULE_LICENSE("GPL");
> >  #define IPMI_TIMEOUT                   (5000)
> >  #define ACPI_IPMI_MAX_MSG_LENGTH       64
> >
> > +static struct completion smi_selected;
> > +
> >  struct acpi_ipmi_device {
> >         /* the device list attached to driver_data.ipmi_devices */
> >         struct list_head head;
> > @@ -463,8 +465,10 @@ static void ipmi_register_bmc(int iface, struct device *dev)
> >                 if (temp->handle == handle)
> >                         goto err_lock;
> >         }
> > -       if (!driver_data.selected_smi)
> > +       if (!driver_data.selected_smi) {
> >                 driver_data.selected_smi = ipmi_device;
> > +               complete(&smi_selected);
> > +       }
> >         list_add_tail(&ipmi_device->head, &driver_data.ipmi_devices);
> >         mutex_unlock(&driver_data.ipmi_lock);
> >
> > @@ -578,10 +582,21 @@ acpi_ipmi_space_handler(u32 function, acpi_physical_address address,
> >         return status;
> >  }
> >
> > +int acpi_wait_for_acpi_ipmi(void)
> > +{
> > +       long ret;
> > +
> > +       ret = wait_for_completion_interruptible_timeout(&smi_selected, 2 * HZ);
> > +
> > +       return ret > 0 ? 0 : -ETIMEDOUT;
> 
> What will happen if the IPMI driver is unloaded after this has returned 0?

The IPMI driver can't be unloaded if it has a user.

I've been following this, but I know little about ACPI.  Beyond this
solution, the only other solution I could come up with was to start the
IPMI driver earlier.  But then you are in a chicken-and-egg situation
(https://dictionary.cambridge.org/dictionary/english/chicken-and-egg-situation).
Which was the reason for the SPMI table, but that's really kind of
useless for this, even if the SPMI table existed.

-corey

> 
> > +}
> > +EXPORT_SYMBOL_GPL(acpi_wait_for_acpi_ipmi);
> > +
> >  static int __init acpi_ipmi_init(void)
> >  {
> >         int result;
> >         acpi_status status;
> > +       init_completion(&smi_selected);
> >
> >         if (acpi_disabled)
> >                 return 0;
> > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> > index 1216d72c650f..afa6e4d4bf46 100644
> > --- a/include/acpi/acpi_bus.h
> > +++ b/include/acpi/acpi_bus.h
> > @@ -821,11 +821,16 @@ static inline void acpi_put_acpi_dev(struct acpi_device *adev)
> >  {
> >         acpi_dev_put(adev);
> >  }
> > +
> > +int acpi_wait_for_acpi_ipmi(void);
> > +
> >  #else  /* CONFIG_ACPI */
> >
> >  static inline int register_acpi_bus_type(void *bus) { return 0; }
> >  static inline int unregister_acpi_bus_type(void *bus) { return 0; }
> >
> > +static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
> > +
> >  #endif                         /* CONFIG_ACPI */
> >
> >  #endif /*__ACPI_BUS_H__*/
> > --
> 
