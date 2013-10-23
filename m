Content-Type: multipart/mixed; boundary="===============3179932752029869585=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] ACPICA: Resource Mgr: Prevent infinite loops in	resource
 walks
Date: Wed, 23 Oct 2013 06:06:46 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E8802478147@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E37C78AA21@ORSMSX103.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3179932752029869585==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The last resource should always be ACPI_RESOURCE_TYPE_END_TAG and we have n=
srepair mechanism to ensure that this entry is always there for resource ba=
sed properties (there are still 2 kinds of properties haven't been fixed ye=
t).
If we do not want to rely on this logic, then we may need to use buffer->le=
ngth and pass this one to the acpi_rs_get_aml_length to avoid potential inf=
inite loop.
I'll draft an ACPICA patch to achieve the latter.

Thanks and best regards
-Lv

> -----Original Message-----
> From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] On B=
ehalf Of Moore, Robert
> Sent: Wednesday, October 23, 2013 5:36 AM
> To: Dan Carpenter
> Cc: linux-acpi(a)vger.kernel.org; devel(a)acpica.org
> Subject: Re: [Devel] ACPICA: Resource Mgr: Prevent infinite loops in reso=
urce walks
> =

> We'll take a look.
> Thanks,
> Bob
> =

> =

> > -----Original Message-----
> > From: Dan Carpenter [mailto:dan.carpenter(a)oracle.com]
> > Sent: Thursday, October 17, 2013 5:29 AM
> > To: Moore, Robert
> > Cc: linux-acpi(a)vger.kernel.org; devel(a)acpica.org
> > Subject: re: ACPICA: Resource Mgr: Prevent infinite loops in resource
> > walks
> >
> > Hello Bob Moore,
> >
> > The patch c13085e519e8: "ACPICA: Resource Mgr: Prevent infinite loops in
> > resource walks" from Mar 8, 2013 is not beautiful.  My static checker
> > complains about the loop because:
> > "drivers/acpi/acpica/rscalc.c:197 acpi_rs_get_aml_length()
> > 	 warn: 'resource' can't be NULL."
> >
> > drivers/acpi/acpica/rscalc.c
> >    195          /* Traverse entire list of internal resource descriptors
> > */
> >    196
> >    197          while (resource) {
> >                        ^^^^^^^^
> >
> > My static checker is wrong because we use the -fno-strict-overflow to
> > prevent GCC from optimizing this check away.  But we are looping over a
> > list of pointers until our pointer wraps to NULL.  In other words we lo=
op
> > over all the 2**64 - 1 addresses until we wrap to NULL or we find
> > something with an invalid type or something with ->length zero.
> >
> > I assume the last element in the list always has length zero?  If so th=
en
> > we could replace "while (resource)" with "while (resource->length)"
> >
> >    198
> >    199                  /* Validate the descriptor type */
> >    200
> >    201                  if (resource->type > ACPI_RESOURCE_TYPE_MAX) {
> >    202
> > return_ACPI_STATUS(AE_AML_INVALID_RESOURCE_TYPE);
> >    203                  }
> >    204
> >    205                  /* Sanity check the length. It must not be zero,
> > or we loop forever */
> >    206
> >    207                  if (!resource->length) {
> >    208
> > return_ACPI_STATUS(AE_AML_BAD_RESOURCE_LENGTH);
> >    209                  }
> >    210
> >    211                  /* Get the base size of the (external stream)
> > resource descriptor */
> >    212
> >
> > regards,
> > dan carpenter
> =

> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> https://lists.acpica.org/mailman/listinfo/devel

--===============3179932752029869585==--

