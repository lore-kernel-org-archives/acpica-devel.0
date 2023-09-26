Return-Path: <xueshuai@linux.alibaba.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EFD8641E4B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 96BAB41E33
Message-ID: <b3e8777d-7621-3842-53b0-2b43ffc25d34@linux.alibaba.com>
MIME-Version: 1.0
Content-Language: en-US
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20230919022127.69732-2-xueshuai@linux.alibaba.com>
 <CVS2TK6J4193.2X0455FSP2MLQ@suppilovahvero>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <CVS2TK6J4193.2X0455FSP2MLQ@suppilovahvero>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Acpica-devel] [RESEND PATCH v8 1/2] ACPI: APEI: set memory
 failure flags as MF_ACTION_REQUIRED on synchronous events
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Tue, 26 Sep 2023 06:23:55 -0000
To: Jarkko Sakkinen <jarkko@kernel.org>, rafael@kernel.org, wangkefeng.wang@huawei.com, tanxiaofei@huawei.com, mawupeng1@huawei.com, tony.luck@intel.com, linmiaohe@huawei.com, naoya.horiguchi@nec.com, james.morse@arm.com, gregkh@linuxfoundation.org, will@kernel.org
Cc: dave.hansen@linux.intel.com, linux-mm@kvack.org, hpa@zytor.com, acpica-devel@lists.linuxfoundation.org, ardb@kernel.org, justin.he@arm.com, x86@kernel.org, robert.moore@intel.com, linux-acpi@vger.kernel.org, mingo@redhat.com, zhuo.song@linux.alibaba.com, ying.huang@intel.com, lenb@kernel.org, ashish.kalra@amd.com, xiexiuqi@huawei.com, bp@alien8.de, baolin.wang@linux.alibaba.com, tglx@linutronix.de, linux-edac@vger.kernel.org, lvying6@huawei.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org, akpm@linux-foundation.org



On 2023/9/25 22:43, Jarkko Sakkinen wrote:
> On Tue Sep 19, 2023 at 5:21 AM EEST, Shuai Xue wrote:
>> There are two major types of uncorrected recoverable (UCR) errors :
>>
>> - Action Required (AR): The error is detected and the processor already
>>   consumes the memory. OS requires to take action (for example, offline
>>   failure page/kill failure thread) to recover this uncorrectable error.
>>
>> - Action Optional (AO): The error is detected out of processor execution
>>   context. Some data in the memory are corrupted. But the data have not
>>   been consumed. OS is optional to take action to recover this
>>   uncorrectable error.
>>
>> The essential difference between AR and AO errors is that AR is a
>> synchronous event, while AO is an asynchronous event. The hardware will
>> signal a synchronous exception (Machine Check Exception on X86 and
>> Synchronous External Abort on Arm64) when an error is detected and the
>> memory access has been architecturally executed.
>>
>> When APEI firmware first is enabled, a platform may describe one error
>> source for the handling of synchronous errors (e.g. MCE or SEA notification
>> ), or for handling asynchronous errors (e.g. SCI or External Interrupt
>> notification). In other words, we can distinguish synchronous errors by
>> APEI notification. For AR errors, kernel will kill current process
>> accessing the poisoned page by sending SIGBUS with BUS_MCEERR_AR. In
>> addition, for AO errors, kernel will notify the process who owns the
>> poisoned page by sending SIGBUS with BUS_MCEERR_AO in early kill mode.
>> However, the GHES driver always sets mf_flags to 0 so that all UCR errors
>> are handled as AO errors in memory failure.
>>
>> To this end, set memory failure flags as MF_ACTION_REQUIRED on synchronous
>> events.
>>
>> Fixes: ba61ca4aab47 ("ACPI, APEI, GHES: Add hardware memory error recovery support")'
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> Tested-by: Ma Wupeng <mawupeng1@huawei.com>
>> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> Reviewed-by: Xiaofei Tan <tanxiaofei@huawei.com>
>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>  drivers/acpi/apei/ghes.c | 29 +++++++++++++++++++++++------
>>  1 file changed, 23 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index ef59d6ea16da..88178aa6222d 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -101,6 +101,20 @@ static inline bool is_hest_type_generic_v2(struct ghes *ghes)
>>  	return ghes->generic->header.type == ACPI_HEST_TYPE_GENERIC_ERROR_V2;
>>  }
>>  
>> +/*
>> + * A platform may describe one error source for the handling of synchronous
>> + * errors (e.g. MCE or SEA), or for handling asynchronous errors (e.g. SCI
>> + * or External Interrupt). On x86, the HEST notifications are always
>> + * asynchronous, so only SEA on ARM is delivered as a synchronous
>> + * notification.
>> + */
>> +static inline bool is_hest_sync_notify(struct ghes *ghes)
>> +{
>> +	u8 notify_type = ghes->generic->notify.type;
>> +
>> +	return notify_type == ACPI_HEST_NOTIFY_SEA;
>> +}
>> +
>>  /*
>>   * This driver isn't really modular, however for the time being,
>>   * continuing to use module_param is the easiest way to remain
>> @@ -475,7 +489,7 @@ static bool ghes_do_memory_failure(u64 physical_addr, int flags)
>>  }
>>  
>>  static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
>> -				       int sev)
>> +				       int sev, bool sync)
>>  {
>>  	int flags = -1;
>>  	int sec_sev = ghes_severity(gdata->error_severity);
>> @@ -489,7 +503,7 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
>>  	    (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED))
>>  		flags = MF_SOFT_OFFLINE;
>>  	if (sev == GHES_SEV_RECOVERABLE && sec_sev == GHES_SEV_RECOVERABLE)
>> -		flags = 0;
>> +		flags = sync ? MF_ACTION_REQUIRED : 0;
> 
> Not my territory but this branching looks a bit weird to my
> eyes so just in case putting a comment.
> 
> What *if* the previous condition sets MF_SOFT_OFFLINE and
> this condition overwrites the value?
> 
> I know that earlier it could have been overwritten by zero.
> 
> Neither the function comment has any explanation why it is
> ok overwrite like this.
> 
> Or if these cannot happen simultaenously why there is not
> immediate return after settting MF_SOFT_OFFLINE?
> 
> For someone like me the functions logic is tediously hard
> to understand tbh.
> 
> BR, Jarkko

Hi, Jarkko,

I hope the original source code can help to understand:

	/* iff following two events can be handled properly by now */
	if (sec_sev == GHES_SEV_CORRECTED &&
	    (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED))
		flags = MF_SOFT_OFFLINE;
	if (sev == GHES_SEV_RECOVERABLE && sec_sev == GHES_SEV_RECOVERABLE)
		flags = 0;

	if (flags != -1)
		return ghes_do_memory_failure(mem_err->physical_addr, flags);

The sec_sev of gdata is either GHES_SEV_CORRECTED or GHES_SEV_RECOVERABLE.
So the two if-conditions are independent of each other and these cannot
happen simultaneously. ghes_do_memory_failure() then handle the two events
with a proper seted flags.

Thanks.

Best Regards,
Shuai
