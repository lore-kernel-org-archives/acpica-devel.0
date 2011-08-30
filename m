Content-Type: multipart/mixed; boundary="===============0885270325225067496=="
MIME-Version: 1.0
From: Thomas Renninger <trenn at suse.de>
Subject: Re: [Devel] [PATCH 0/2] Implement overriding of arbitrary ACPI tables
 via initrd
Date: Tue, 30 Aug 2011 13:41:33 +0200
Message-ID: <201108301341.33452.trenn@suse.de>
In-Reply-To: 1314179290-31526-1-git-send-email-trenn@suse.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0885270325225067496==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Len, Hi Robert, hi Lin,

what's your opinion about these patches?
I just sent a tiny bug fix which slipped in when I did
last minute cleanups.

Is the additional acpi_os_phys_table_override() function which
would be needed in ACPICA sources acceptable?

I'd appreciate if the acpica adoption can be made by
acpica people, but if you give green light, I can also
re-write the first patch against acpica sources.

As this needs syncing with acpica it would be great if the first
steps can be made, so that this can show up in 3.2 release.

Thanks,

   Thomas

On Wednesday, August 24, 2011 11:48:08 AM Thomas Renninger wrote:
> This patch series got some basic testing already (see patch 2 changelog) =
and
> is based on latest 3.1-rc2 Linus kernel.
> =

> The patches are separated into ACPICA parts (patch 1) and kernel parts (p=
atch 2).
> =

> They are ready for integeration (if now objections should show up in a re=
view
> discussion) and it would be great if they can be added in Len's latest ac=
pi-test
> tree for broader testing.
> =

> Thanks,
> =

>    Thomas
> =

> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo(a)vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> =



--===============0885270325225067496==--

