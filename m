Content-Type: multipart/mixed; boundary="===============2033370504308802324=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH] tools: Delete the initialization value
Date: Thu, 25 Aug 2022 13:22:41 +0200
Message-ID: <CAJZ5v0jVpCiwscgVQqS3yEwGaHUCPzR9pNDjt6qY6U4jJubt_A@mail.gmail.com>
In-Reply-To: 20220825090347.30555-1-junming@nfschina.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2033370504308802324==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 25, 2022 at 11:04 AM shijm <junming(a)nfschina.com> wrote:
>
> From: Shi junming <junming(a)nfschina.com>
>
> From the perspective of commpier,delete the initialization value

I'm not sure what this means.

The initialization is unnecessary, because the variable in question is
always assigned a new value before reading it.  Is that what you
wanted to say?

> Signed-off-by: Shi junming <junming(a)nfschina.com>
> ---
>  tools/power/acpi/tools/pfrut/pfrut.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/power/acpi/tools/pfrut/pfrut.c b/tools/power/acpi/tool=
s/pfrut/pfrut.c
> index d79c335594b2..52aa0351533c 100644
> --- a/tools/power/acpi/tools/pfrut/pfrut.c
> +++ b/tools/power/acpi/tools/pfrut/pfrut.c
> @@ -190,7 +190,7 @@ int main(int argc, char *argv[])
>         void *addr_map_capsule;
>         struct stat st;
>         char *log_buf;
> -       int ret =3D 0;
> +       int ret;
>
>         if (getuid() !=3D 0) {
>                 printf("Please run the tool as root - Exiting.\n");
> --
> 2.18.2
>
--===============2033370504308802324==--

