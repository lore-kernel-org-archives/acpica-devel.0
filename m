Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2B85B1EA
	for <acpica-devel@lists.linuxfoundation.org>; Tue, 21 Nov 2023 19:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CE05D8140B
	for <acpica-devel@lists.linuxfoundation.org>; Tue, 21 Nov 2023 19:25:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CE05D8140B
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.398
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wzw3syR-TJ_5
	for <acpica-devel@lists.linuxfoundation.org>;
	Tue, 21 Nov 2023 19:25:32 +0000 (UTC)
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C535D81405
	for <acpica-devel@lists.linuxfoundation.org>; Tue, 21 Nov 2023 19:25:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C535D81405
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1e99ecda011so679241fac.1
        for <acpica-devel@lists.linuxfoundation.org>; Tue, 21 Nov 2023 11:25:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700594732; x=1701199532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZmF7VsRXyf5IAN8XB8CDp7srxIlqRHtK3S2F91eHJ+c=;
        b=up5aRI7WrMmnAOEGnBC0xSC6FhBDsCTC/oUqxOdEsxy3HYD0vOTB/mDzFCRkrC7SHl
         GwlAeU3tU1AmS7mMoWPh75eG/+XMZvEQKZUhpYNqRO1is/m40AAT4LrfPXKNjivK26NP
         HTqiOV0VEClcSSQGTY/O5FOr087rjv8a5uBDKrzPhN/k+usjrHQZhmUIOt/X/rJvqDn8
         C8jnQIDmT3Iwu/u3O9PIG4m/U6/JFRtZmWgN3Gq01WHoTazID7EeQoLWrAFqGqY7Gh6N
         DdD2P3Wnm+ZpaPGqg+MM5ppgEFiwyrHxCbgwoyTsA1LPT0rQh8EasGIOXDOF5FDdlihk
         iflg==
X-Gm-Message-State: AOJu0YypvmgnuMGahIvi27m7knLSw9pd6i1kDcmXB5TCwZFqZYXyeETP
	G+Li0JbMPwSxGcXm+EpUHvIMF3+e3HbaRWgmg7w=
X-Google-Smtp-Source: AGHT+IE2xYxESxcFH8Tibld2HbFOg0GQxx1rnA/r6i4D2ZlbZcUzwCog6c58GO9usT0TzxUdyS5FxqseaZhZuxIluuE=
X-Received: by 2002:a05:6871:53cd:b0:1f9:602e:7b0d with SMTP id
 hz13-20020a05687153cd00b001f9602e7b0dmr342897oac.2.1700594731741; Tue, 21 Nov
 2023 11:25:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231121103829.10027-1-raag.jadav@intel.com> <20231121103829.10027-3-raag.jadav@intel.com>
In-Reply-To: <20231121103829.10027-3-raag.jadav@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 21 Nov 2023 20:25:20 +0100
Message-ID: <CAJZ5v0jmaRQWfO_mM4GZ8mEFftuSNgt36=tJ5vC2Uw7MAcpYJg@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] ACPI: bus: update acpi_dev_uid_match() to support
 multiple types
To: Raag Jadav <raag.jadav@intel.com>
Cc: mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com, 
	rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com, ardb@kernel.org, 
	will@kernel.org, mark.rutland@arm.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, 
	linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 11:38=E2=80=AFAM Raag Jadav <raag.jadav@intel.com> =
wrote:
>
> According to ACPI specification, a _UID object can evaluate to either
> a numeric value or a string. Update acpi_dev_uid_match() helper to
> support _UID matching for both integer and string types.
>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

You need to be careful with using this.  There are some things below
that go beyond what I have suggested.

> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
>  drivers/acpi/utils.c    | 19 -------------------
>  include/acpi/acpi_bus.h | 35 ++++++++++++++++++++++++++++++++++-
>  include/linux/acpi.h    |  8 +++-----
>  3 files changed, 37 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> index 28c75242fca9..fe7e850c6479 100644
> --- a/drivers/acpi/utils.c
> +++ b/drivers/acpi/utils.c
> @@ -824,25 +824,6 @@ bool acpi_check_dsm(acpi_handle handle, const guid_t=
 *guid, u64 rev, u64 funcs)
>  }
>  EXPORT_SYMBOL(acpi_check_dsm);
>
> -/**
> - * acpi_dev_uid_match - Match device by supplied UID
> - * @adev: ACPI device to match.
> - * @uid2: Unique ID of the device.
> - *
> - * Matches UID in @adev with given @uid2.
> - *
> - * Returns:
> - *  - %true if matches.
> - *  - %false otherwise.
> - */
> -bool acpi_dev_uid_match(struct acpi_device *adev, const char *uid2)
> -{
> -       const char *uid1 =3D acpi_device_uid(adev);
> -
> -       return uid1 && uid2 && !strcmp(uid1, uid2);
> -}
> -EXPORT_SYMBOL_GPL(acpi_dev_uid_match);
> -
>  /**
>   * acpi_dev_hid_uid_match - Match device by supplied HID and UID
>   * @adev: ACPI device to match.
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index ec6a673dcb95..bcd78939bab4 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -9,6 +9,7 @@
>  #ifndef __ACPI_BUS_H__
>  #define __ACPI_BUS_H__
>
> +#include <linux/compiler.h>
>  #include <linux/device.h>
>  #include <linux/property.h>
>
> @@ -857,10 +858,42 @@ static inline bool acpi_device_can_poweroff(struct =
acpi_device *adev)
>                 adev->power.states[ACPI_STATE_D3_HOT].flags.explicit_set)=
;
>  }
>
> -bool acpi_dev_uid_match(struct acpi_device *adev, const char *uid2);
>  bool acpi_dev_hid_uid_match(struct acpi_device *adev, const char *hid2, =
const char *uid2);
>  int acpi_dev_uid_to_integer(struct acpi_device *adev, u64 *integer);
>
> +static inline bool acpi_str_uid_match(struct acpi_device *adev, const ch=
ar *uid2)
> +{
> +       const char *uid1 =3D acpi_device_uid(adev);
> +
> +       return uid1 && uid2 && !strcmp(uid1, uid2);
> +}
> +
> +static inline bool acpi_int_uid_match(struct acpi_device *adev, u64 uid2=
)
> +{
> +       u64 uid1;
> +
> +       return !acpi_dev_uid_to_integer(adev, &uid1) && uid1 =3D=3D uid2;
> +}
> +

Up to this point it is all fine IMV.

> +/**
> + * acpi_dev_uid_match - Match device by supplied UID
> + * @adev: ACPI device to match.
> + * @uid2: Unique ID of the device.
> + *
> + * Matches UID in @adev with given @uid2.
> + *
> + * Returns: %true if matches, %false otherwise.
> + */
> +
> +/* Treat uid as a string for array and pointer types, treat as an intege=
r otherwise */
> +#define get_uid_type(x) \
> +       (__builtin_choose_expr(is_array_or_pointer_type(x), (const char *=
)0, (u64)0))

But I wouldn't use the above.

It is far more elaborate than needed for this use case and may not
actually work as expected.  For instance, why would a pointer to a
random struct type be a good candidate for a string?

> +
> +#define acpi_dev_uid_match(adev, uid2)                         \
> +       _Generic(get_uid_type(uid2),                            \
> +                const char *: acpi_str_uid_match,              \
> +                u64: acpi_int_uid_match)(adev, uid2)
> +

Personally, I would just do something like the following

#define acpi_dev_uid_match(adev, uid2) \
        _Generic((uid2), \
                const char *: acpi_str_uid_match, \
                char *: acpi_str_uid_match, \
                const void *: acpi_str_uid_match, \
                void *: acpi_str_uid_match, \
                default: acpi_int_uid_match)(adev, uid2)

which doesn't require compiler.h to be fiddled with and is rather
straightforward to follow.

If I'm to apply the patches, this is about the level of complexity you
need to target.

>  void acpi_dev_clear_dependencies(struct acpi_device *supplier);
>  bool acpi_dev_ready_for_enumeration(const struct acpi_device *device);
>  struct acpi_device *acpi_dev_get_next_consumer_dev(struct acpi_device *s=
upplier,
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index b63d7811c728..aae3a459d63c 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -763,6 +763,9 @@ const char *acpi_get_subsystem_id(acpi_handle handle)=
;
>  #define ACPI_HANDLE(dev)               (NULL)
>  #define ACPI_HANDLE_FWNODE(fwnode)     (NULL)
>
> +/* Get rid of the -Wunused-variable for adev */
> +#define acpi_dev_uid_match(adev, uid2)                 (adev && false)
> +
>  #include <acpi/acpi_numa.h>
>
>  struct fwnode_handle;
> @@ -779,11 +782,6 @@ static inline bool acpi_dev_present(const char *hid,=
 const char *uid, s64 hrv)
>
>  struct acpi_device;
>
> -static inline bool acpi_dev_uid_match(struct acpi_device *adev, const ch=
ar *uid2)
> -{
> -       return false;
> -}
> -
>  static inline bool
>  acpi_dev_hid_uid_match(struct acpi_device *adev, const char *hid2, const=
 char *uid2)
>  {
> --
