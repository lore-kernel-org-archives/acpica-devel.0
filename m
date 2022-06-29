Content-Type: multipart/mixed; boundary="===============6319051151483198496=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH v2] ACPI/processor: Remove unused function
 acpi_processor_get_limit_info()
Date: Wed, 29 Jun 2022 18:56:37 +0200
Message-ID: <CAJZ5v0gAJSfWmEJjawSHWnYB-rsBxcMyUQjAf4F3jpMhnjx+-Q@mail.gmail.com>
In-Reply-To: 87v8szoccp.fsf@stealth
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6319051151483198496==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 17, 2022 at 11:42 AM Punit Agrawal
<punit.agrawal(a)bytedance.com> wrote:
>
> Riwen Lu <luriwen(a)hotmail.com> writes:
>
> > From: Riwen Lu <luriwen(a)kylinos.cn>
> >
> > Commit 22e7551eb6fd ("ACPI / processor: Remove acpi_processor_get_limit=
_info()"),
> > left behind this, remove it.
> >
> > Signed-off-by: Riwen Lu <luriwen(a)kylinos.cn>
> >
> > ---
> > v1 -> v2:
> >  - Make this patch base on ("ACPI: Split out processor thermal register
> >    from ACPI PSS").
>
> For such changes, it is better to send all the related patches as a
> series so it's easy to see the dependencies . In a series the easy /
> obvious fixes should be earlier so it's easier for them to be merged
> while the more significant changes are still being discussed.
>
> Hopefully in this case Rafael too agrees with the dependency patch -
> otherwise, it's just extra churn on the lists.
>
> But don't resend just yet - give some time for others to add their
> feedback.
>
> > ---
> >  include/acpi/processor.h | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> > index ba1e3ed98d3d..9fa49686957a 100644
> > --- a/include/acpi/processor.h
> > +++ b/include/acpi/processor.h
> > @@ -441,7 +441,6 @@ static inline int acpi_processor_hotplug(struct acp=
i_processor *pr)
> >  #endif /* CONFIG_ACPI_PROCESSOR_IDLE */
> >
> >  /* in processor_thermal.c */
> > -int acpi_processor_get_limit_info(struct acpi_processor *pr);
> >  int acpi_processor_thermal_init(struct acpi_processor *pr,
> >                               struct acpi_device *device);
> >  void acpi_processor_thermal_exit(struct acpi_processor *pr,
>
> Fwiw,
>
> Reviewed-by: Punit Agrawal <punit.agrawal(a)bytedance.com>

Applied as 5.20 material with some edits in the subject and changelog.

Thanks!
--===============6319051151483198496==--

