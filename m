Return-Path: <rjwysocki@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5CC72607B5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9D103607A3
MIME-Version: 1.0
References: <4464371bc72147e10a392a1873466c8df033039c.1685341309.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <4464371bc72147e10a392a1873466c8df033039c.1685341309.git.christophe.jaillet@wanadoo.fr>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 29 May 2023 16:13:25 +0200
Message-ID: <CAJZ5v0g2=iYThmRzJXofUXSMrVPM-T2Ck8-HxiS=2_cn3Hv52g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Acpica-devel] [PATCH] ACPICA: Slightly simplify an error
	message in acpi_ds_result_push()
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, Len Brown <lenb@kernel.org>

On Mon, May 29, 2023 at 8:31=E2=80=AFAM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> 'object' is known to be NULL at this point. There is little value to log
> it twice in the error message.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

ACPICA changes require (at least) a pull request submitted to the
upstream ACPICA project on GitHub.

If you have submitted one, please resend the Linux patch with a Link
tag pointing to the corresponding upstream ACPICA pull request.

Thanks!

> ---
>  drivers/acpi/acpica/dswstate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/acpica/dswstate.c b/drivers/acpi/acpica/dswstat=
e.c
> index d3841ded3a81..75338a13c802 100644
> --- a/drivers/acpi/acpica/dswstate.c
> +++ b/drivers/acpi/acpica/dswstate.c
> @@ -146,8 +146,8 @@ acpi_ds_result_push(union acpi_operand_object *object=
,
>
>         if (!object) {
>                 ACPI_ERROR((AE_INFO,
> -                           "Null Object! Obj=3D%p State=3D%p Num=3D%u",
> -                           object, walk_state, walk_state->result_count)=
);
> +                           "Null Object! State=3D%p Num=3D%u",
> +                           walk_state, walk_state->result_count));
>                 return (AE_BAD_PARAMETER);
>         }
>
> --
> 2.34.1
>
