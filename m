Content-Type: multipart/mixed; boundary="===============8575389427804845965=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [BUG] acpica: ltp_acpi test case causes kernel crash at
 acpi_ns_walk_namespace
Date: Wed, 13 Dec 2017 17:52:38 +0100
Message-ID: <CAJZ5v0iKWMBZXqGcpJqhdLLqPTY02yQOFJtn8zuCvsXd902nYQ@mail.gmail.com>
In-Reply-To: 20171213145547.GB6692@localhost.localdomain
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8575389427804845965==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2017 at 3:55 PM, Vadim Lomovtsev
<Vadim.Lomovtsev(a)caviumnetworks.com> wrote:
> On Wed, Dec 13, 2017 at 12:45:50AM +0100, Rafael J. Wysocki wrote:
>> On Tuesday, December 12, 2017 4:59:19 PM CET Vadim Lomovtsev wrote:
>> > Hi guys,
>> >
>> > While running LTP tests I've faced kernel crash caused by ltp_acpi tes=
t case.
>> > I have ACPI support enabled in kernel but kernel is boot with FDT havi=
ng ACPI
>> > disabled. The ltp_acpi test case application is built along with ltp_a=
cpi_cmds
>> > module to run ACPI tests.
>> >
>> > So my question is - should we update acpica implementation at kernel s=
ide by
>> > adding 'acpi_disabled' variable checking to the 'acpi_get_devices' fun=
ction (see
>> > patch next to this email, maybe not a good approach) or this should be=
 fixed at LTP
>> > side so the ltp_acpi_cmds should be updated in order to check if acpi =
is enabled
>> > before running tests ?
>>
>> There should be a check preventing acpi_get_devices() from being called =
in the
>> acpi_disabled case.
>
> In my case I have to update ltp_acpi code then.

RIght.

>>
>> acpi_disabled is Linux-specific and the ACPICA code isn't, so the code c=
alling
>> ACPICA functions should check acpi_disabled when necessary.
>
> Agree. However getting back to LTP tests it looks like such calls were im=
plemented
> intentionally without checking of aspi_disabled value.
>
> Don't we have any self-testing stuff in acpica to prevent such scenarious=
 ?

ACPICA doesn't know anything about acpi_disabled as I said already.

I would argue that testing unsupported use cases in LTP is not very useful.

Thanks,
Rafael

--===============8575389427804845965==--

