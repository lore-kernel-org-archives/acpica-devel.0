Content-Type: multipart/mixed; boundary="===============3820560527444532807=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH 1/5] ACPICA: Add acpi_dev_present
Date: Mon, 23 Nov 2015 22:22:56 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D998D0C@ORSMSX112.amr.corp.intel.com>
In-Reply-To: 2726545.001oM5V9lv@vostro.rjw.lan
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3820560527444532807==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

>>acpi_dev_present

Do you really want to be walking the ACPICA namespace for every call?

> -----Original Message-----
> From: Rafael J. Wysocki [mailto:rjw(a)rjwysocki.net]
> Sent: Monday, November 23, 2015 2:35 PM
> To: Lukas Wunner
> Cc: linux-acpi(a)vger.kernel.org; devel(a)acpica.org; platform-driver-
> x86(a)vger.kernel.org; Darren Hart; Corentin Chary; Lee, Chun-Yi; alsa-
> devel(a)alsa-project.org; Takashi Iwai; Hui Wang; Mark Brown; Zheng, Lv;
> Moore, Robert; David Box
> Subject: Re: [PATCH 1/5] ACPICA: Add acpi_dev_present
> =

> On Monday, November 23, 2015 03:34:55 PM Lukas Wunner wrote:
> > There are 7 drivers which call acpi_get_devices to check for the
> > presence of a particular ACPI HID, each defining its own copy of a
> > mostly identical callback.
> >
> > Add acpi_dev_present, the ACPI equivalent to pci_dev_present, allowing
> > us to deduplicate all that boilerplate in the drivers.
> >
> > Signed-off-by: Lukas Wunner <lukas(a)wunner.de>
> =

> We have a general rule for ACPICA patches that they go in through upstream
> ACPICA.
> =

> So if you really want this changes in ACPICA, this is the way to handle
> it.
> =

> Now, of course, for that to happen, you should have CCed the ACPICA
> maintainers too (now done).
> =

> Thanks,
> Rafael
> =

> =

> > ---
> >  drivers/acpi/acpica/nsxfeval.c | 46
> ++++++++++++++++++++++++++++++++++++++++++
> >  include/acpi/acpixf.h          |  7 +++++++
> >  2 files changed, 53 insertions(+)
> >
> > diff --git a/drivers/acpi/acpica/nsxfeval.c
> > b/drivers/acpi/acpica/nsxfeval.c index 6ee1e52..19293fa 100644
> > --- a/drivers/acpi/acpica/nsxfeval.c
> > +++ b/drivers/acpi/acpica/nsxfeval.c
> > @@ -828,6 +828,52 @@ ACPI_EXPORT_SYMBOL(acpi_get_devices)
> >
> >
> /*************************************************************************
> ******
> >   *
> > + * FUNCTION:    acpi_ns_dev_present_callback
> > + *
> > + * PARAMETERS:  Callback from acpi_get_devices
> > + *
> > + * RETURN:      Status
> > + *
> > + * DESCRIPTION: Minimal callback to be passed to acpi_get_devices which
> > + *              performs no further filtering and terminates the search
> > + *              immediately.
> > + *
> > +
> > +*********************************************************************
> > +*********/ static acpi_status
> > +acpi_ns_dev_present_callback(acpi_handle handle, u32 level,
> > +						void *context, void **retval)
> > +{
> > +	*(bool *)context =3D true;
> > +	return AE_CTRL_TERMINATE;
> > +}
> > +
> > +/********************************************************************
> > +***********
> > + *
> > + * FUNCTION:    acpi_dev_present
> > + *
> > + * PARAMETERS:  HID                 - HID to search for.
> > + *
> > + * RETURNS      True if a matching object of type Device was found.
> > + *
> > + * DESCRIPTION: Performs a walk of the namespace tree. When a matching
> object
> > + *              of type Device is found, the search is terminated
> immediately.
> > + *
> > +
> > +*********************************************************************
> > +*********/
> > +
> > +bool
> > +acpi_dev_present(const char *HID)
> > +{
> > +	acpi_status status;
> > +	bool found =3D false;
> > +
> > +	status =3D acpi_get_devices(HID, acpi_ns_dev_present_callback, &found,
> > +				  NULL);
> > +	return ACPI_SUCCESS(status) && found; }
> > +
> > +ACPI_EXPORT_SYMBOL(acpi_dev_present)
> > +
> > +/********************************************************************
> > +***********
> > + *
> >   * FUNCTION:    acpi_attach_data
> >   *
> >   * PARAMETERS:  obj_handle          - Namespace node
> > diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h index
> > 3aaaa86..f299347 100644
> > --- a/include/acpi/acpixf.h
> > +++ b/include/acpi/acpixf.h
> > @@ -115,6 +115,11 @@
> >  	prototype;
> >  #endif
> >
> > +#ifndef ACPI_EXTERNAL_RETURN_BOOL
> > +#define ACPI_EXTERNAL_RETURN_BOOL(prototype) \
> > +	prototype;
> > +#endif
> > +
> >
> /*************************************************************************
> ****
> >   *
> >   * Public globals and runtime configuration options @@ -483,6 +488,8
> > @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status
> >  					      acpi_walk_callback user_function,
> >  					      void *context,
> >  					      void **return_value))
> > +ACPI_EXTERNAL_RETURN_BOOL(bool
> > +			     acpi_dev_present(const char *HID))
> >  ACPI_EXTERNAL_RETURN_STATUS(acpi_status
> >  			     acpi_get_name(acpi_handle object, u32 name_type,
> >  					   struct acpi_buffer *ret_path_ptr))
> >


--===============3820560527444532807==--

