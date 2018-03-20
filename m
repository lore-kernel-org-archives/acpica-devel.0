Content-Type: multipart/mixed; boundary="===============2806971646482760814=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [PATCH v3] xen/acpi: upload _PSD info for non Dom0 CPUs
 too
Date: Tue, 20 Mar 2018 10:41:49 +0100
Message-ID: <CAJZ5v0ipVHsjEBJuj3Lz6iRSVasv8d2YY0qjz1SFaCK+zDP=Xw@mail.gmail.com>
In-Reply-To: d14d48ab-9ba1-c70c-4d46-cd9c7c862add@oracle.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2806971646482760814==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 16, 2018 at 2:57 PM, Joao Martins <joao.m.martins(a)oracle.com>=
 wrote:
> On 03/15/2018 03:45 PM, Boris Ostrovsky wrote:
>> On 03/15/2018 10:22 AM, Joao Martins wrote:
>>> All uploaded PM data from non-dom0 CPUs takes the info from vCPU 0 and
>>> changing only the acpi_id. For processors which P-state coordination ty=
pe
>>> is HW_ALL (0xFD) it is OK to upload bogus P-state dependency information
>>> (_PSD), because Xen will ignore any cpufreq domains created for past CP=
Us.
>>>
>>> Albeit for platforms which expose coordination types as SW_ANY or SW_AL=
L,
>>> this will have some unintended side effects. Effectively, it will look =
at
>>> the P-state domain existence and *if it already exists* it will skip the
>>> acpi-cpufreq initialization and thus inherit the policy from the first =
CPU
>>> in the cpufreq domain. This will finally lead to the original cpu not
>>> changing target freq to P0 other than the first in the domain. Which wi=
ll
>>> make turbo boost not getting enabled (e.g. for 'performance' governor) =
for
>>> all cpus.
>>>
>>> This patch fixes that, by also evaluating _PSD when we enumerate all AC=
PI
>>> processors and thus always uploading the correct info to Xen. We export
>>> acpi_processor_get_psd() for that this purpose, but change signature
>>> to not assume an existent of acpi_processor given that ACPI isn't creat=
ing
>>> an acpi_processor for non-dom0 CPUs.
>>>
>>> Signed-off-by: Joao Martins <joao.m.martins(a)oracle.com>
>>
>> Reviewed-by: Boris Ostrovsky <boris.ostrovsky(a)oracle.com>
>>
> Thanks!
>
> I suppose what's remaining is review (or ack) from ACPI folks on the inte=
rface
> changes made to acpi_processor_get_psd().

There you go:

Acked-by: Rafael J. Wysocki <rafael.j.wysocki(a)intel.com>

Do you want to route this via Xen?

--===============2806971646482760814==--

