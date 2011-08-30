Content-Type: multipart/mixed; boundary="===============4483578545477234877=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH 0/2] Implement overriding of arbitrary ACPI tables
 via initrd
Date: Tue, 30 Aug 2011 14:55:50 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E316E70AA6@ORSMSX101.amr.corp.intel.com>
In-Reply-To: 201108301341.33452.trenn@suse.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4483578545477234877==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Lin Ming is looking at this now and will report soon.
Bob


> -----Original Message-----
> From: Thomas Renninger [mailto:trenn(a)suse.de]
> Sent: Tuesday, August 30, 2011 4:42 AM
> To: lenb(a)kernel.org; hpa(a)zytor.com; Lin, Ming M; Moore, Robert
> Cc: eric.piel(a)tremplin-utc.net; jnelson-suse(a)jamponi.net;
> devel(a)acpica.org; linux-acpi(a)vger.kernel.org; linux-
> kernel(a)vger.kernel.org; x86(a)kernel.org
> Subject: Re: [PATCH 0/2] Implement overriding of arbitrary ACPI tables
> via initrd
> =

> Hi Len, Hi Robert, hi Lin,
> =

> what's your opinion about these patches?
> I just sent a tiny bug fix which slipped in when I did
> last minute cleanups.
> =

> Is the additional acpi_os_phys_table_override() function which
> would be needed in ACPICA sources acceptable?
> =

> I'd appreciate if the acpica adoption can be made by
> acpica people, but if you give green light, I can also
> re-write the first patch against acpica sources.
> =

> As this needs syncing with acpica it would be great if the first
> steps can be made, so that this can show up in 3.2 release.
> =

> Thanks,
> =

>    Thomas
> =

> On Wednesday, August 24, 2011 11:48:08 AM Thomas Renninger wrote:
> > This patch series got some basic testing already (see patch 2
> changelog) and
> > is based on latest 3.1-rc2 Linus kernel.
> >
> > The patches are separated into ACPICA parts (patch 1) and kernel
> parts (patch 2).
> >
> > They are ready for integeration (if now objections should show up in
> a review
> > discussion) and it would be great if they can be added in Len's
> latest acpi-test
> > tree for broader testing.
> >
> > Thanks,
> >
> >    Thomas
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi"
> in
> > the body of a message to majordomo(a)vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >


--===============4483578545477234877==--

