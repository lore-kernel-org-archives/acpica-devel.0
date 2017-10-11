Content-Type: multipart/mixed; boundary="===============8354070091378762566=="
MIME-Version: 1.0
From: George Cherian <gcherian at caviumnetworks.com>
Subject: Re: [Devel] [PATCH v4 2/2] ACPI / CPPC: Make cppc acpi driver aware
 of pcc subspace ids
Date: Wed, 11 Oct 2017 14:26:42 +0530
Message-ID: <d9fef65a-527b-11cc-aed7-706b99846083@caviumnetworks.com>
In-Reply-To: 54c0a799-0cf6-3ba3-c137-7a5c35012654@codeaurora.org
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8354070091378762566==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Thanks Prakash for the clarifications.
I have updated the patch set incorporating your comments and posted v5.

Regards
-George

On 10/07/2017 02:40 AM, Prakash, Prashanth wrote:
> =

> On 10/3/2017 5:01 AM, George Cherian wrote:
>> Hi Prakash,
>>
>> On 09/29/2017 04:49 AM, Prakash, Prashanth wrote:
>>> Hi George,
>>>
>>> On 9/19/2017 11:24 PM, George Cherian wrote:
>>>> Based on ACPI 6.2 Section 8.4.7.1.9 If the PCC register space is used,
>>>> all PCC registers, for all processors in the same performance
>>>> domain (as defined by _PSD), must be defined to be in the same subspac=
e.
>>>> Based on Section 14.1 of ACPI specification, it is possible to have a
>>>> maximum of 256 PCC subspace ids. Add support of multiple PCC subspace =
id
>>>> instead of using a single global pcc_data structure.
>>>>
>>>> While at that fix the time_delta check in send_pcc_cmd() so that last_=
mpar_reset
>>>> and mpar_count is initialized properly.
>>>>
>>>> Signed-off-by: George Cherian <george.cherian(a)cavium.com>
>>>> ---
>>>>  =C2=A0 drivers/acpi/cppc_acpi.c | 243 +++++++++++++++++++++++++++++--=
----------------
>>>>  =C2=A0 1 file changed, 153 insertions(+), 90 deletions(-)
>>>>
>>>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>>>> index e5b47f0..3ae79ef 100644
>>>> --- a/drivers/acpi/cppc_acpi.c
>>>> +++ b/drivers/acpi/cppc_acpi.c
>>>> @@ -75,13 +75,16 @@ struct cppc_pcc_data {
>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Wait queue for CPUs whose re=
quests were batched */
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wait_queue_head_t pcc_write_wait_q;
>>>> +=C2=A0=C2=A0=C2=A0 ktime_t last_cmd_cmpl_time;
>>>> +=C2=A0=C2=A0=C2=A0 ktime_t last_mpar_reset;
>>>> +=C2=A0=C2=A0=C2=A0 int mpar_count;
>>>> +=C2=A0=C2=A0=C2=A0 int refcount;
>>>>  =C2=A0 };
>>>>  =C2=A0 -/* Structure to represent the single PCC channel */
>>>> -static struct cppc_pcc_data pcc_data =3D {
>>>> -=C2=A0=C2=A0=C2=A0 .pcc_subspace_idx =3D -1,
>>>> -=C2=A0=C2=A0=C2=A0 .platform_owns_pcc =3D true,
>>>> -};
>>>> +/* Array=C2=A0 to represent the PCC channel per subspace id */
>>>> +static struct cppc_pcc_data *pcc_data[MAX_PCC_SUBSPACES];
>>>> +/* The cpu_pcc_subspace_idx containsper CPU subspace id */
>>>> +static DEFINE_PER_CPU(int, cpu_pcc_subspace_idx);
>>>>  =C2=A0 =C2=A0 /*
>>>>  =C2=A0=C2=A0 * The cpc_desc structure contains the ACPI register deta=
ils
>>>> @@ -93,7 +96,8 @@ static struct cppc_pcc_data pcc_data =3D {
>>>>  =C2=A0 static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
>>>>  =C2=A0 =C2=A0 /* pcc mapped address + header size + offset within PCC=
 subspace */
>>>> -#define GET_PCC_VADDR(offs) (pcc_data.pcc_comm_addr + 0x8 + (offs))
>>>> +#define GET_PCC_VADDR(offs, pcc_ss_id) (pcc_data[pcc_ss_id]->pcc_comm=
_addr + \
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x8 +=
 (offs))
>>>>  =C2=A0 =C2=A0 /* Check if a CPC register is in PCC */
>>>>  =C2=A0 #define CPC_IN_PCC(cpc) ((cpc)->type =3D=3D ACPI_TYPE_BUFFER &=
&=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>>>> @@ -188,13 +192,16 @@ static struct kobj_type cppc_ktype =3D {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .default_attrs =3D cppc_attrs,
>>>>  =C2=A0 };
>>>>  =C2=A0 -static int check_pcc_chan(bool chk_err_bit)
>>>> +static int check_pcc_chan(int pcc_ss_id, bool chk_err_bit)
>>>>  =C2=A0 {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D -EIO, status =3D 0;
>>>> -=C2=A0=C2=A0=C2=A0 struct acpi_pcct_shared_memory __iomem *generic_co=
mm_base =3D pcc_data.pcc_comm_addr;
>>>> -=C2=A0=C2=A0=C2=A0 ktime_t next_deadline =3D ktime_add(ktime_get(), p=
cc_data.deadline);
>>>> +=C2=A0=C2=A0=C2=A0 struct cppc_pcc_data *pcc_ss_data =3D pcc_data[pcc=
_ss_id];
>>>> +=C2=A0=C2=A0=C2=A0 struct acpi_pcct_shared_memory __iomem *generic_co=
mm_base =3D
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcc_ss_data->pcc_comm_addr;
>>>> +=C2=A0=C2=A0=C2=A0 ktime_t next_deadline =3D ktime_add(ktime_get(),
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcc_ss_data->dead=
line);
>>>>  =C2=A0 -=C2=A0=C2=A0=C2=A0 if (!pcc_data.platform_owns_pcc)
>>>> +=C2=A0=C2=A0=C2=A0 if (!pcc_ss_data->platform_owns_pcc)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Retry in case the remote pro=
cessor was too slow to catch up. */
>>>> @@ -219,7 +226,7 @@ static int check_pcc_chan(bool chk_err_bit)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (likely(!ret))
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcc_data.platform_owns_pcc=
 =3D false;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcc_ss_data->platform_owns=
_pcc =3D false;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_err("PCC ch=
eck channel failed. Status=3D%x\n", status);
>>>>  =C2=A0 @@ -230,13 +237,12 @@ static int check_pcc_chan(bool chk_err_b=
it)
>>>>  =C2=A0=C2=A0 * This function transfers the ownership of the PCC to th=
e platform
>>>>  =C2=A0=C2=A0 * So it must be called while holding write_lock(pcc_lock)
>>>>  =C2=A0=C2=A0 */
>>>> -static int send_pcc_cmd(u16 cmd)
>>>> +static int send_pcc_cmd(int pcc_ss_id, u16 cmd)
>>>>  =C2=A0 {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D -EIO, i;
>>>> +=C2=A0=C2=A0=C2=A0 struct cppc_pcc_data *pcc_ss_data =3D pcc_data[pcc=
_ss_id];
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct acpi_pcct_shared_memory *generi=
c_comm_base =3D
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (struct acpi_pcct_shared_m=
emory *) pcc_data.pcc_comm_addr;
>>>> -=C2=A0=C2=A0=C2=A0 static ktime_t last_cmd_cmpl_time, last_mpar_reset;
>>>> -=C2=A0=C2=A0=C2=A0 static int mpar_count;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (struct acpi_pcct_shared_m=
emory *)pcc_ss_data->pcc_comm_addr;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int time_delta;
>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>> @@ -249,24 +255,25 @@ static int send_pcc_cmd(u16 cmd)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * before=
 write completion, so first send a WRITE command to
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * platfo=
rm
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pcc_data.pending_pcc_w=
rite_cmd)
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 se=
nd_pcc_cmd(CMD_WRITE);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pcc_ss_data->pending_p=
cc_write_cmd)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 se=
nd_pcc_cmd(pcc_ss_id, CMD_WRITE);
>>>>  =C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D check_pcc_=
chan(false);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D check_pcc_chan(pcc=
_ss_id, false);
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 goto end;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else /* CMD_WRITE */
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcc_data.pending_pcc_write=
_cmd =3D FALSE;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcc_ss_data->pending_pcc_w=
rite_cmd =3D FALSE;
>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Handle the Minimum Request Tur=
naround Time(MRTT)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * "The minimum amount of time th=
at OSPM must wait after the completion
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * of a command before issuing th=
e next command, in microseconds"
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> -=C2=A0=C2=A0=C2=A0 if (pcc_data.pcc_mrtt) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 time_delta =3D ktime_us_de=
lta(ktime_get(), last_cmd_cmpl_time);
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pcc_data.pcc_mrtt > ti=
me_delta)
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ud=
elay(pcc_data.pcc_mrtt - time_delta);
>>>> +=C2=A0=C2=A0=C2=A0 if (pcc_ss_data->pcc_mrtt) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 time_delta =3D ktime_us_de=
lta(ktime_get(),
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcc_s=
s_data->last_cmd_cmpl_time);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pcc_ss_data->pcc_mrtt =
> time_delta)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ud=
elay(pcc_ss_data->pcc_mrtt - time_delta);
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>> @@ -280,18 +287,19 @@ static int send_pcc_cmd(u16 cmd)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * not send the request to the pl=
atform after hitting the MPAR limit in
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * any 60s window
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> -=C2=A0=C2=A0=C2=A0 if (pcc_data.pcc_mpar) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mpar_count =3D=3D 0) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ti=
me_delta =3D ktime_ms_delta(ktime_get(), last_mpar_reset);
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (time_delta < 60 * MSEC_PER_SEC) {
>>>> +=C2=A0=C2=A0=C2=A0 if (pcc_ss_data->pcc_mpar) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pcc_ss_data->mpar_coun=
t =3D=3D 0) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ti=
me_delta =3D ktime_ms_delta(ktime_get(),
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 pcc_ss_data->last_mpar_reset);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 ((time_delta < 60 * MSEC_PER_SEC) && pcc_ss_data->last_mpar_reset) {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_debug("PCC cmd not sent due to MPAR li=
mit");
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EIO;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto end;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 }
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 la=
st_mpar_reset =3D ktime_get();
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mp=
ar_count =3D pcc_data.pcc_mpar;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pc=
c_ss_data->last_mpar_reset =3D ktime_get();
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pc=
c_ss_data->mpar_count =3D pcc_ss_data->pcc_mpar;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mpar_count--;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcc_ss_data->mpar_count--;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Write to the shared comm reg=
ion. */
>>>> @@ -300,10 +308,10 @@ static int send_pcc_cmd(u16 cmd)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Flip CMD COMPLETE bit */
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 writew_relaxed(0, &generic_comm_base->=
status);
>>>>  =C2=A0 -=C2=A0=C2=A0=C2=A0 pcc_data.platform_owns_pcc =3D true;
>>>> +=C2=A0=C2=A0=C2=A0 pcc_ss_data->platform_owns_pcc =3D true;
>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Ring doorbell */
>>>> -=C2=A0=C2=A0=C2=A0 ret =3D mbox_send_message(pcc_data.pcc_channel, &c=
md);
>>>> +=C2=A0=C2=A0=C2=A0 ret =3D mbox_send_message(pcc_ss_data->pcc_channel=
, &cmd);
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_err("Err se=
nding PCC mbox message. cmd:%d, ret:%d\n",
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cmd, ret);
>>>> @@ -311,15 +319,15 @@ static int send_pcc_cmd(u16 cmd)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* wait for completion and chec=
k for PCC errro bit */
>>>> -=C2=A0=C2=A0=C2=A0 ret =3D check_pcc_chan(true);
>>>> +=C2=A0=C2=A0=C2=A0 ret =3D check_pcc_chan(pcc_ss_id, true);
>>>>  =C2=A0 -=C2=A0=C2=A0=C2=A0 if (pcc_data.pcc_mrtt)
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 last_cmd_cmpl_time =3D kti=
me_get();
>>>> +=C2=A0=C2=A0=C2=A0 if (pcc_ss_data->pcc_mrtt)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcc_ss_data->last_cmd_cmpl=
_time =3D ktime_get();
>>>>  =C2=A0 -=C2=A0=C2=A0=C2=A0 if (pcc_data.pcc_channel->mbox->txdone_irq)
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mbox_chan_txdone(pcc_data.=
pcc_channel, ret);
>>>> +=C2=A0=C2=A0=C2=A0 if (pcc_ss_data->pcc_channel->mbox->txdone_irq)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mbox_chan_txdone(pcc_ss_da=
ta->pcc_channel, ret);
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mbox_client_txdone(pcc_dat=
a.pcc_channel, ret);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mbox_client_txdone(pcc_ss_=
data->pcc_channel, ret);
>>>>  =C2=A0 =C2=A0 end:
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cmd =3D=3D CMD_WRITE) {
>>>> @@ -329,12 +337,12 @@ static int send_pcc_cmd(u16 cmd)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!desc)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue;
>>>>  =C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (desc->write_cmd_id =3D=3D pcc_data.pcc_w=
rite_cnt)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (desc->write_cmd_id =3D=3D pcc_ss_data->pcc_write_=
cnt)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 desc->write_cmd_s=
tatus =3D ret;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 }
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcc_data.pcc_write_cnt++;
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wake_up_all(&pcc_data.pcc_=
write_wait_q);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcc_ss_data->pcc_write_cnt=
++;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wake_up_all(&pcc_ss_data->=
pcc_write_wait_q);
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>>> @@ -536,16 +544,16 @@ int acpi_get_psd_map(struct cppc_cpudata **all_c=
pu_data)
>>>>  =C2=A0 }
>>>>  =C2=A0 EXPORT_SYMBOL_GPL(acpi_get_psd_map);
>>>>  =C2=A0 -static int register_pcc_channel(int pcc_subspace_idx)
>>>> +static int register_pcc_channel(int pcc_ss_idx)
>>>>  =C2=A0 {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct acpi_pcct_hw_reduced *cppc_ss;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 usecs_lat;
>>>>  =C2=A0 -=C2=A0=C2=A0=C2=A0 if (pcc_subspace_idx >=3D 0) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcc_data.pcc_channel =3D p=
cc_mbox_request_channel(&cppc_mbox_cl,
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 pcc_subspace_idx);
>>>> +=C2=A0=C2=A0=C2=A0 if (pcc_ss_idx >=3D 0) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcc_data[pcc_ss_idx]->pcc_=
channel =3D
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pc=
c_mbox_request_channel(&cppc_mbox_cl,=C2=A0=C2=A0=C2=A0 pcc_ss_idx);
>>>>  =C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(pcc_dat=
a.pcc_channel)) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(pcc_data[pcc_ss=
_idx]->pcc_channel)) {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 pr_err("Failed to find PCC communication channel\n");
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return -ENODEV;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> @@ -556,7 +564,7 @@ static int register_pcc_channel(int pcc_subspace_i=
dx)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * PCC ch=
annels) and stored pointers to the
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * subspa=
ce communication region in con_priv.
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cppc_ss =3D (pcc_data.pcc_=
channel)->con_priv;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cppc_ss =3D (pcc_data[pcc_=
ss_idx]->pcc_channel)->con_priv;
>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!cp=
pc_ss) {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 pr_err("No PCC subspace found for CPPC\n");
>>>> @@ -569,19 +577,20 @@ static int register_pcc_channel(int pcc_subspace=
_idx)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * So add=
 an arbitrary amount of wait on top of Nominal.
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 usecs_lat =3D =
NUM_RETRIES * cppc_ss->latency;
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcc_data.deadline =3D ns_t=
o_ktime(usecs_lat * NSEC_PER_USEC);
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcc_data.pcc_mrtt =3D cppc=
_ss->min_turnaround_time;
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcc_data.pcc_mpar =3D cppc=
_ss->max_access_rate;
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcc_data.pcc_nominal =3D c=
ppc_ss->latency;
>>>> -
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcc_data.pcc_comm_addr =3D=
 acpi_os_ioremap(cppc_ss->base_address, cppc_ss->length);
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!pcc_data.pcc_comm_add=
r) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcc_data[pcc_ss_idx]->dead=
line =3D ns_to_ktime(usecs_lat * NSEC_PER_USEC);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcc_data[pcc_ss_idx]->pcc_=
mrtt =3D cppc_ss->min_turnaround_time;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcc_data[pcc_ss_idx]->pcc_=
mpar =3D cppc_ss->max_access_rate;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcc_data[pcc_ss_idx]->pcc_=
nominal =3D cppc_ss->latency;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcc_data[pcc_ss_idx]->pcc_=
comm_addr =3D
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ac=
pi_os_ioremap(cppc_ss->base_address, cppc_ss->length);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!pcc_data[pcc_ss_idx]-=
>pcc_comm_addr) {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 pr_err("Failed to ioremap PCC comm region mem\n");
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return -ENOMEM;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Set =
flag so that we dont come here for each CPU. */
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcc_data.pcc_channel_acqui=
red =3D true;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcc_data[pcc_ss_idx]->pcc_=
channel_acquired =3D true;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>> @@ -600,6 +609,39 @@ bool __weak cpc_ffh_supported(void)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>>>>  =C2=A0 }
>>>>  =C2=A0 +
>>>> +/**
>>>> + * pcc_data_alloc() - Allocate the pcc_data memory for pcc subspace
>>>> + *
>>>> + * Check and allocate the cppc_pcc_data memory.
>>>> + * In some processor configurations it is possible that same subspace
>>>> + * is shared between multiple CPU's. This is seen especially in CPU's
>>>> + * with hardware multi-threading support.
>>>> + *
>>>> + * Return: 0 for success, errno for failure
>>>> + */
>>>> +int pcc_data_alloc(int pcc_ss_id)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 int loop;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 if (pcc_ss_id < 0)
>>> Above should be (pcc_ss_id < 0 || pcc_ss_id >=3D MAX_PCC_SUBSPACES)
>> Yes we can have this additional check.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 for (loop =3D 0; pcc_data[loop] !=3D NULL; loop++)=
 {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pcc_data[loop]->pcc_su=
bspace_idx =3D=3D pcc_ss_id) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pc=
c_data[loop]->refcount++;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn 0;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0 }
>>> Why do we need the above for loop? can't it be direct array lookup?
>>> if (pcc_data[pcc_ss_id]) {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 //increment ref_count and return
>>> }
>> Yes, we could get rid of the loop and increment the reference directly i=
f already allocated.
>>
>>>
>>> Also, we should remove the pcc_subspace_idx from cppc_pcc_data structur=
e,
>>> it is no longer useful and probably adds to confusion.
>> Please see below
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 pcc_data[pcc_ss_id] =3D kzalloc(sizeof(struct cppc=
_pcc_data), GFP_KERNEL);
>>>> +=C2=A0=C2=A0=C2=A0 if (!pcc_data[pcc_ss_id])
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>>>> +=C2=A0=C2=A0=C2=A0 pcc_data[pcc_ss_id]->pcc_subspace_idx =3D pcc_ss_i=
d;
>>>> +=C2=A0=C2=A0=C2=A0 pcc_data[pcc_ss_id]->refcount++;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>>> +}
>>>>  =C2=A0 /*
>>>>  =C2=A0=C2=A0 * An example CPC table looks like the following.
>>>>  =C2=A0=C2=A0 *
>>>> @@ -661,6 +703,7 @@ int acpi_cppc_processor_probe(struct acpi_processo=
r *pr)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device *cpu_dev;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 acpi_handle handle =3D pr->handle;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int num_ent, i, cpc_rev;
>>>> +=C2=A0=C2=A0=C2=A0 int pcc_subspace_id =3D -1;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 acpi_status status;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D -EFAULT;
>>>>  =C2=A0 @@ -733,12 +776,9 @@ int acpi_cppc_processor_probe(struct acpi=
_processor *pr)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 * so extract it only once.
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 */
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 if (gas_t->space_id =3D=3D ACPI_ADR_SPACE_PLATFORM_COMM) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (pcc_data.pcc_subspace_idx < 0)
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcc_data.pcc_subspace_idx =3D=
 gas_t->access_width;
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 else if (pcc_data.pcc_subspace_idx !=3D gas_t->access=
_width) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_debug("Mismatched PCC ids.=
\n");
>>> We need to retain the above checks to make sure all PCC registers
>>> within a _CPC package is under same subspace. The Spec still requires:
>>> "If the PCC register space is used, all PCC registers, for all processo=
rs in
>>> the same performance domain (as defined by _PSD), must be defined
>>> to be in the same subspace."
>>
>> So that means we need to maintain the pcc_subspace_idx in cppc_pcc_data.
>> If so, then I can move the check inside pcc_data_alloc().
> We need the pcc_subspace_idx for checking only withing the context of this
> function, so tracking that data in a local variable will be sufficient.
>>>
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 pcc_subspace_id =3D gas_t->access_width;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (pcc_data_alloc(pcc_subspace_id))
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_free;
>>> We need to call pcc_data_alloc(to increment the reference) only once pe=
r CPU,
>>> otherwise acpi_cppc_processor_exit( ) will never free the memory alloca=
ted in
>>> pcc_data.
>>
>> It is infact called only once per CPU, The refcounting was added in case=
 if multiple CPU's share the same domain for eg:
>> In instances, where CPU have hardware multi-threading support.
>> or in cases where all CPU's are controlled using single subspace (as ear=
lier).
> No, it is getting called for every PCC registers within a _CPC package, i=
nstead it
> needs to be called only once per _CPC package irrespective of number of P=
CC
> registers within the_CPC=C2=A0 package.
>>
>> Do you see any issue with acpi_cppc_processor_exit() in the earlier case=
s, where refcount remains > 0 and the memory not getting freed-up?
>>>
>>>
>>> -- =

>>> Thanks,
>>> Prashanth
>>>
>=20

--===============8354070091378762566==--

