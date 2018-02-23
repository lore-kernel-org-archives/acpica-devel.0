Content-Type: multipart/mixed; boundary="===============2386166883371798514=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] Fix null deref in acpi_ns_check_package_list
Date: Fri, 23 Feb 2018 21:48:17 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B7573B37@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 1519319629-30799-1-git-send-email-benjamin.bales@assrc.us
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2386166883371798514==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: C0deAi [mailto:techsupport(a)mycode.ai]
> Sent: Thursday, February 22, 2018 9:14 AM
> To: Moore, Robert <robert.moore(a)intel.com>; Schmauss, Erik
> <erik.schmauss(a)intel.com>; Wysocki, Rafael J
> <rafael.j.wysocki(a)intel.com>; lenb(a)kernel.org; linux-
> acpi(a)vger.kernel.org; devel(a)acpica.org
> Subject: [PATCH] Fix null deref in acpi_ns_check_package_list
> =

> Hi my name is Benjamin Bales.
> =

> I am the founder and creator of CodeAI,
> the first non-human contributor to your software project. CodeAI finds
> and fixes security defects for you. It fixed 327. It wants to merge a
> fix for a null dereference. To view all 327 fixed issues from the run
> claim your free open source account at mycode.ai and the Dockerfile used
> to build and run your project in CodeAI, here-
> https://drive.google.com/drive/folders/1KB9WQQyWQgYccmiSjy2E1JWJ4vWuoLYd
> .
> It is always free for open source projects.
> =

> If you have any questions about these results or have general inquiries
> about CodeAI, please send an email to techsupport(a)mycode.ai
> =

> Signed-off-by: Benjamin Bales <techsupport(a)mycode.ai>
> ---
>  drivers/acpi/acpica/nsprepkg.c | 2 ++
>  1 file changed, 2 insertions(+)
> =

> diff --git a/drivers/acpi/acpica/nsprepkg.c
> b/drivers/acpi/acpica/nsprepkg.c index 7805d5c..d1bfd86 100644
> --- a/drivers/acpi/acpica/nsprepkg.c
> +++ b/drivers/acpi/acpica/nsprepkg.c
> @@ -437,6 +437,8 @@ acpi_ns_check_package_list(struct acpi_evaluate_info
> *info,
>  	 */
>  	for (i =3D 0; i < count; i++) {
>  		sub_package =3D *elements;
> +		if (sub_package =3D=3D NULL)
> +			break;
>  		sub_elements =3D sub_package->package.elements;
>  		info->parent_package =3D sub_package;
> =


The story here is that the SubPackage pointer is *guaranteed* to be valid a=
t this point in the code. It has already be validated and all NULL elements=
 have been removed.

    /*
     * Validate each subpackage in the parent Package
     *
     * NOTE: assumes list of subpackages contains no NULL elements.
     * Any NULL elements should have been removed by earlier call
     * to AcpiNsRemoveNullElements.
     */
    for (i =3D 0; i < Count; i++)
    {
        SubPackage =3D *Elements;
        SubElements =3D SubPackage->Package.Elements;
        Info->ParentPackage =3D SubPackage;




> --
> 2.7.4


--===============2386166883371798514==--

