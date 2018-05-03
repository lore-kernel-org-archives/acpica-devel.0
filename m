Content-Type: multipart/mixed; boundary="===============2745610809550642883=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] Tools: remove missing options in acpibin tool
Date: Thu, 03 May 2018 21:15:58 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B75E0A8B@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 1525326567-30528-1-git-send-email-alex.hung@canonical.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2745610809550642883==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Got it, thanks.
Bob


> -----Original Message-----
> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Alex Hung
> Sent: Wednesday, May 2, 2018 10:49 PM
> To: devel(a)acpica.org; alex.hung(a)canonical.com
> Subject: [Devel] [PATCH] Tools: remove missing options in acpibin tool
> =

> The -e option is no longer avaiable in acpibin tool.
> =

> Signed-off-by: Alex Hung <alex.hung(a)canonical.com>
> ---
>  source/tools/acpibin/abmain.c | 1 -
>  1 file changed, 1 deletion(-)
> =

> diff --git a/source/tools/acpibin/abmain.c
> b/source/tools/acpibin/abmain.c index 35e533c..1cf18c6 100644
> --- a/source/tools/acpibin/abmain.c
> +++ b/source/tools/acpibin/abmain.c
> @@ -186,7 +186,6 @@ AbDisplayUsage (
>      ACPI_OPTION ("-a <File1> <File2>",      "Compare two binary AML
> files, dump all mismatches");
>      ACPI_OPTION ("-c <File1> <File2>",      "Compare two binary AML
> files, dump first 100 mismatches");
>      ACPI_OPTION ("-d <In> <Out>",           "Dump AML binary to text
> file");
> -    ACPI_OPTION ("-e <Sig> <In> <Out>",     "Extract binary AML table
> from acpidump file");
>      ACPI_OPTION ("-o <Value>",              "Start comparison at this
> offset into second file");
>      ACPI_OPTION ("-h <File>",               "Display table header for
> binary AML file");
>      ACPI_OPTION ("-s <File>",               "Update checksum for binary
> AML file");
> --
> 2.7.4
> =

> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> https://lists.acpica.org/mailman/listinfo/devel

--===============2745610809550642883==--

