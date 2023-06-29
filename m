Return-Path: <rjwysocki@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5B26160B2E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0F4F360A5F
MIME-Version: 1.0
References: <20230626220525.1654780-1-abmainkar@nvidia.com>
In-Reply-To: <20230626220525.1654780-1-abmainkar@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 29 Jun 2023 10:26:00 +0200
Message-ID: <CAJZ5v0iE4MtjnBWwq0dS7x8B8AsZS0sJFfO6fRwtLJOfUhbEUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Acpica-devel] [Patch] acpica: Add AML_NO_OPERAND_RESOLVE flag
	to Timer
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
To: Abhishek Mainkar <abmainkar@nvidia.com>
Cc: rafael.j.wysocki@intel.com, robert.moore@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, lenb@kernel.org

On Tue, Jun 27, 2023 at 12:10=E2=80=AFAM Abhishek Mainkar <abmainkar@nvidia=
.com> wrote:
>
> According to the ACPI specification 19.6.134, no argument is
> required to be passed for ASL Timer instruction. For taking
> care of no argument, AML_NO_OPERAND_RESOLVE flag is added to
> ASL Timer instruction opcode.
>
> When ASL timer instruction interpreted by ACPI interpreter,
> getting error. After adding AML_NO_OPERAND_RESOLVE flag to
> ASL Timer instruction opcode, issue is not observed.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> UBSAN: array-index-out-of-bounds in acpica/dswexec.c:401:12
> index -1 is out of range for type 'acpi_operand_object *[9]'
> CPU: 37 PID: 1678 Comm: cat Not tainted
> 6.0.0-dev-th500-6.0.y-1+bcf8c46459e407-generic-64k
> HW name: NVIDIA BIOS v1.1.1-d7acbfc-dirty 12/19/2022 Call trace:
>  dump_backtrace+0xe0/0x130
>  show_stack+0x20/0x60
>  dump_stack_lvl+0x68/0x84
>  dump_stack+0x18/0x34
>  ubsan_epilogue+0x10/0x50
>  __ubsan_handle_out_of_bounds+0x80/0x90
>  acpi_ds_exec_end_op+0x1bc/0x6d8
>  acpi_ps_parse_loop+0x57c/0x618
>  acpi_ps_parse_aml+0x1e0/0x4b4
>  acpi_ps_execute_method+0x24c/0x2b8
>  acpi_ns_evaluate+0x3a8/0x4bc
>  acpi_evaluate_object+0x15c/0x37c
>  acpi_evaluate_integer+0x54/0x15c
>  show_power+0x8c/0x12c [acpi_power_meter]
>
> Signed-off-by: Abhishek Mainkar <abmainkar@nvidia.com>

ACPICA changes need to be submitted as pull requests to the upstream
ACPICA project on GitHub.

Once you have submitted an ACPICA pull request, please resend the
corresponding Linux patch with a Link: tag pointing to that pull
request.

Thanks!

> ---
>  drivers/acpi/acpica/psopcode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpica/psopcode.c b/drivers/acpi/acpica/psopcod=
e.c
> index bef69e87a0a2..8c34c0ffb1d9 100644
> --- a/drivers/acpi/acpica/psopcode.c
> +++ b/drivers/acpi/acpica/psopcode.c
> @@ -603,7 +603,7 @@ const struct acpi_opcode_info acpi_gbl_aml_op_info[AM=
L_NUM_OPCODES] =3D {
>
>  /* 7E */ ACPI_OP("Timer", ARGP_TIMER_OP, ARGI_TIMER_OP, ACPI_TYPE_ANY,
>                          AML_CLASS_EXECUTE, AML_TYPE_EXEC_0A_0T_1R,
> -                        AML_FLAGS_EXEC_0A_0T_1R),
> +                        AML_FLAGS_EXEC_0A_0T_1R | AML_NO_OPERAND_RESOLVE=
),
>
>  /* ACPI 5.0 opcodes */
>
> --
> 2.17.1
>
