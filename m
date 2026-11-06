Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977131;
	b=PH1x/M09eUOoZRPYQoeXXx1WZAP7xmaFdGmfbAmeoED0LarN03uX2WyHWqqa6mnYRfAA
	 dV12oePmgg/Z9KyoW/CKAId1z7wI0kiw2V7pGV5blP6itSQZTkq8NxmUuU1tomiS3INON
	 BAZnfzJoc8d1GdQVoPDZI2SifyIR6Lwwj5It9p0H+amF8pcJlkgATI7eTYEpzUg3haxpE
	 h0Vcj26QghQDrDofVUIod0zSKKzvvQvqxKJwzfsmrrGD/B0vdVGRMEgvjAH9zSZ50EUv/
	 lWkLmt6971DXquJUDeVjKgEI3ObN3IfbrKznqWBspLe5PCLbT0m/RGJ3xsJKCl9aQIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977131;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=XEalOsXN3Dev0rHb+5Zu8ZzbpTD7rK6WayG4C7CI4C4=;
	b=om9gcy/L/aPZ2smsXCPo98yo4UeH5MeY0zFuKYhCNr3lYYNL9BGxWhDSX2lLH/JHNYx1
	 kNagz8qREqlJ1j9hK+MqW/a7i/scFlAUSry+c9GGet0Jxx2PWyNfZBth1nSe30iFyRzxU
	 +JaeCLrryyIjkFZNr4f8wdIeedLj5NStq0U98FvhKEWRJKWhcYnrJ3Tbz/SilpTlUnYuR
	 L0mWNNkQskRfq5Ba6IVoUZFh+S+ELVrLrYr3WH8IaYBwqXEeqokj8YHbfZl3iLCxG5XWO
	 Jh8pF5JcoXT1pRZLCt/ECmMxy+xDRsviiqAOKHKGVKDWZ9SKjXYyx/u3f/mNCCo2TEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UN1zk4Up;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8100606A32D
	for <acpica-devel@lists.linux.dev>; Fri,  6 Nov 2026 14:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UN1zk4Up
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 545CC1F008A5
	for <acpica-devel@lists.linux.dev>; Fri,  6 Nov 2026 14:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793977130;
	bh=XEalOsXN3Dev0rHb+5Zu8ZzbpTD7rK6WayG4C7CI4C4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=UN1zk4Uphe5CdaTHvBnATH/qAbECMB+wDcg5c7jQfY83OidxuC6MXhLoNJ/DwDtWS
	 oLZXPFZx2caD+67L5pPpp5DATkI5kTxdVgAKIgKQ3GD7PLkfIGhQw5Tc8uDjl/JgIY
	 W4i2iI2rCfl8zo7EHzy/sq2Ii5loj74rKah/JNf8nIF4vH0UtnVuf47eQ0bFFDgMDv
	 WVGIxhCAXIkmlMTcJnMIyOLGqxmuy/qsIeQElbHwp2V8r/4lGwB9qzrR0U2QmYPsuA
	 knyAEytypGzLhPULxb5+wPBpWMYrEmeCCwdkieEaKm/rR8j8bIDKXGASOQRJm4ThRo
	 m5qgqdTDsuftQ==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b56221d361so805789a12.3
        for <acpica-devel@lists.linux.dev>; Fri, 06 Nov 2026 06:58:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEh+XVmHg1ZQaxBWRqJQr+3oNi0a3Psqljj8nad9IWJiFJD/dBdRvapRffWeWp5wKQ6kDiwRP4oEeUDtMU=@lists.linux.dev
X-Gm-Message-State: APuU4Z/XZOaeJV/e6A/xd5vPMNFvpE9+fVRQb8l6G0iiY/2ZF0jjUVZ2
	0HCWHSHs8CP/JzyM4+pXHkYUPmt46lfM7YkxwopZy9Fm5PEKsP1nW7KQAqj0RSYrKsn40mm/iTa
	wn4qtb5NzLF9mlY2rxV1OrxIcXA8Eijs=
X-Received: by 2002:aa7:d34e:0:b0:6b5:8cf6:18aa with SMTP id
 4fb4d7f45d1cf-6b597816c51mr1300269a12.45.1793977128939; Fri, 06 Nov 2026
 06:58:48 -0800 (PST)
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Post: <mailto:acpica-devel@lists.linux.dev>
List-Help: <mailto:acpica-devel+help@lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:acpica-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20260922121058.972734-2-maobibo@loongson.cn> <10bd45f8-2d37-42f0-b7d2-a4a84933c9b3@loongson.cn>
 <CAAhV-H7Vq2ayLJNLRSo5RRiWOcmF2BXT_QOhEDg_jWOzYteqWw@mail.gmail.com>
 <6f8a9203-6fb1-268a-8d37-37e69fbf2ee9@loongson.cn> <CAAhV-H5k8EJrAuqPH44y_+1gcXGCjCoozzK5ii9cLtiLDj5eog@mail.gmail.com>
 <66b9d482-d577-748c-729d-0fba70701d3d@loongson.cn> <CAAhV-H6PL6RLM3KA4BLQEt804FnsDE4CtKeB0KaW7Gj8rm2PMw@mail.gmail.com>
 <843a9418-2017-c2c6-45c5-38628e7e0bdb@loongson.cn>
In-Reply-To: <843a9418-2017-c2c6-45c5-38628e7e0bdb@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 6 Nov 2026 22:58:38 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4O07hKyPJ8rTMo=vD=t+qFM7UAJOPDGZDVJ0Ti-gOdEQ@mail.gmail.com>
X-Gm-Features: AclHuK_AEHK_XvIpwEC7N5JxRM5P9YdQztWX0TP-7vlsuAjfx-iuC3kJWfywbDw
Message-ID: <CAAhV-H4O07hKyPJ8rTMo=vD=t+qFM7UAJOPDGZDVJ0Ti-gOdEQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] ACPICA: actbl2.h: Add bit constants of the Flags
 field in the IOVT IOMMU structure
To: Bibo Mao <maobibo@loongson.cn>
Cc: rafael@kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, lenb@kernel.org, linux-kernel@vger.kernel.org, 
	lixianglai@loongson.cn, loongarch@lists.linux.dev, 
	maciej.wieczor-retman@intel.com, pawel.chmielewski@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 7:22=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrote=
:
>
>
>
> On 2026/11/5 =E4=B8=8B=E5=8D=886:31, Huacai Chen wrote:
> > On Thu, Nov 5, 2026 at 5:49=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> w=
rote:
> >>
> >>
> >>
> >> On 2026/11/5 =E4=B8=8B=E5=8D=885:31, Huacai Chen wrote:
> >>> On Thu, Nov 5, 2026 at 5:14=E2=80=AFPM Bibo Mao <maobibo@loongson.cn>=
 wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 2026/10/23 =E4=B8=8B=E5=8D=883:59, Huacai Chen wrote:
> >>>>> Bibo,
> >>>>>
> >>>>> Now I have applied this series but with some modifications, please
> >>>>> double check and test the code.
> >>>>>
> >>>>> https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-lo=
ongson.git/log/?h=3Dloongarch-next
> >>>> In my v4 submit, it is:
> >>>> +               case ACPI_IOVT_DEVICE_ENTRY_START:
> >>>> +                       is_start =3D true;
> >>>> +                       start_devid =3D ep->device_id;
> >>>> +                       break;
> >>>> however in rc1, it is modified as:
> >>>>                    case ACPI_IOVT_DEVICE_ENTRY_START:
> >>>>                            is_start =3D true;
> >>>>                            entry->start_devid =3D ep->device_id;
> >>>>                            break;
> >>>> Here entry is not allocated and NULL pointer, it is allocated in
> >>>> ACPI_IOVT_DEVICE_ENTRY_END switch case.
> >>>>
> >>>> I really do not know what is aid to modify it and let others to test=
.
> >>> Sorry, it's my fault.
> >>>
> >>> In theory I should point out the modification (eliminating the local
> >>> variable start_devid) and refresh a new version. But we have no time
> >>> to do this because when the first patch is merged into the ACPI repo
> >>> it is near the merge window.
> >> Maybe our work style is different, I do not care much for the coding s=
tyle.
> >>>
> >>> If you agree, I will submit such modifications to fix it.
> >> fix is welcome.
> >>>
> >>> diff --git a/drivers/acpi/loongarch/iovt.c b/drivers/acpi/loongarch/i=
ovt.c
> >>> index 87cee4f0fc80..4cdac28a1fd0 100644
> >>> --- a/drivers/acpi/loongarch/iovt.c
> >>> +++ b/drivers/acpi/loongarch/iovt.c
> >>> @@ -115,6 +115,10 @@ static int __init iovt_add_iommu(struct
> >>> acpi_iovt_iommu *iommu)
> >>>           for (i =3D 0; i < iommu->device_entry_num; i++) {
> >>>                   switch (ep->type) {
> >>>                   case ACPI_IOVT_DEVICE_ENTRY_START:
> >>> +                       entry =3D kzalloc_obj(struct iovt_device_entr=
y,
> >>> GFP_ATOMIC);
> >> There will be memory leak problem if there are START/START/END in the =
table.
> > That means a broken table? I think we don't need to consider broken
> > tables, because there may be kinds of broken pattern rather than just
> > a START/START/END.
> yes, START/END/START, START/START/END, START/SINGLE/END. what is the
> relationship between "don't need to consider" and kinds of broken pattern=
?
>
> what is the policy from your side with such BIOS table? let memory leak
> and continue?
The driver can only work with a good table or no table, but not with a
broken table.

Take START1/START2/END as an example of broken table: in your original
code, the END entry will be pairing with START2. But for a broken
table who can ensure they are the correct pair? If the real correct
pair is START1 and END, then (entry->start_devid, entry->end_devid)
will be a wrong device range. Such mistakes are much worse than a
memery leak.

If you want to say "I don't care about correct pairing, memory leak is
bad in any case.", OK, we can do it like this:

diff --git a/drivers/acpi/loongarch/iovt.c b/drivers/acpi/loongarch/iovt.c
index 87cee4f0fc80..ebd11e22c9be 100644
--- a/drivers/acpi/loongarch/iovt.c
+++ b/drivers/acpi/loongarch/iovt.c
@@ -115,6 +115,13 @@ static int __init iovt_add_iommu(struct
acpi_iovt_iommu *iommu)
        for (i =3D 0; i < iommu->device_entry_num; i++) {
                switch (ep->type) {
                case ACPI_IOVT_DEVICE_ENTRY_START:
+                       if (is_start)
+                               break;
+
+                       entry =3D kzalloc_obj(struct iovt_device_entry,
GFP_ATOMIC);
+                       if (!entry)
+                               return -ENOMEM;
+
                        is_start =3D true;
                        entry->start_devid =3D ep->device_id;
                        break;
@@ -122,10 +129,6 @@ static int __init iovt_add_iommu(struct
acpi_iovt_iommu *iommu)
                        if (!is_start)
                                break;

-                       entry =3D kzalloc_obj(struct iovt_device_entry,
GFP_ATOMIC);
-                       if (!entry)
-                               return -ENOMEM;
-
                        is_start =3D false;
                        entry->end_devid =3D ep->device_id;
                        list_add_tail(&entry->list, &np->ep_list);

Huacai

>
> >
> > Huacai
> >
> >>
> >> Regards
> >> Bibo Mao
> >>> +                       if (!entry)
> >>> +                               return -ENOMEM;
> >>> +
> >>>                           is_start =3D true;
> >>>                           entry->start_devid =3D ep->device_id;
> >>>                           break;
> >>> @@ -122,10 +126,6 @@ static int __init iovt_add_iommu(struct
> >>> acpi_iovt_iommu *iommu)
> >>>                           if (!is_start)
> >>>                                   break;
> >>>
> >>> -                       entry =3D kzalloc_obj(struct iovt_device_entr=
y,
> >>> GFP_ATOMIC);
> >>> -                       if (!entry)
> >>> -                               return -ENOMEM;
> >>> -
> >>>                           is_start =3D false;
> >>>                           entry->end_devid =3D ep->device_id;
> >>>                           list_add_tail(&entry->list, &np->ep_list);
> >>>
> >>> Huacai
> >>>
> >>>>
> >>>>>
> >>>>> Huacai
> >>>>>
> >>>>> On Mon, Oct 12, 2026 at 3:16=E2=80=AFPM Bibo Mao <maobibo@loongson.=
cn> wrote:
> >>>>>>
> >>>>>> This change is already merged in acpica tree.
> >>>>>>
> >>>>>> slightly ping.
> >>>>>>
> >>>>>> On Tue, Sep 22, 2026 at 08:10:55PM +0800, Bibo Mao wrote:
> >>>>>>     > According to the IOVT specification, define macros for each =
bit of the
> >>>>>>     > Flags field in the IOVT IOMMU structure.
> >>>>>>     >
> >>>>>>     > Link: https://github.com/open-acpica/acpica/commit/352f750e4=
cc0
> >>>>>>     > Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> >>>>>>     > ---
> >>>>>>     >  include/acpi/actbl2.h | 7 +++++++
> >>>>>>     >  1 file changed, 7 insertions(+)
> >>>>>>     >
> >>>>>>     > diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> >>>>>>     > index baef525367b5..76e4a5bc79b4 100644
> >>>>>>     > --- a/include/acpi/actbl2.h
> >>>>>>     > +++ b/include/acpi/actbl2.h
> >>>>>>     > @@ -919,6 +919,13 @@ struct acpi_iovt_iommu {
> >>>>>>     >       u32 device_entry_offset;
> >>>>>>     >  };
> >>>>>>     >
> >>>>>>     > +/* Masks for Flags field above */
> >>>>>>     > +#define ACPI_IOVT_IOMMU_PCI_DEVICE           (1<<0)
> >>>>>>     > +#define ACPI_IOVT_IOMMU_PXM_VALID            (1<<1)
> >>>>>>     > +#define ACPI_IOVT_IOMMU_MAGAGE_BY_SEGMENT    (1<<2)
> >>>>>>     > +#define ACPI_IOVT_IOMMU_HW_CAP_SUPPORT               (1<<3)
> >>>>>>     > +#define ACPI_IOVT_IOMMU_MSI_INT_BYPASS               (1<<4)
> >>>>>>     > +
> >>>>>>     >  struct acpi_iovt_device_entry {
> >>>>>>     >       u8 type;
> >>>>>>     >       u8 length;
> >>>>>>     > --
> >>>>>>     > 2.39.3
> >>>>>>     >
> >>>>>>
> >>>>
> >>>>
> >>
>
>
