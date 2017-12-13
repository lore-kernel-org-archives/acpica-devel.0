Content-Type: multipart/mixed; boundary="===============2234274689256829313=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [PATCH] acpi: acpica: add acpi status check prior walking
 through namespace
Date: Wed, 13 Dec 2017 17:48:49 +0100
Message-ID: <CAJZ5v0iTzJ-=8SWcS6Hu1rP4d-EeOHz2yDjTPMAq8BdW8smSPg@mail.gmail.com>
In-Reply-To: 20171213145201.GA6692@localhost.localdomain
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2234274689256829313==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2017 at 3:52 PM, Vadim Lomovtsev
<Vadim.Lomovtsev(a)caviumnetworks.com> wrote:
> On Tue, Dec 12, 2017 at 09:52:21PM +0000, Moore, Robert wrote:
>> Another way to look at this is that the kernel should not be calling ACP=
I interfaces if ACPI is disabled.
>
> Yes, I agree. So in this case the ltp_acpi test case has to be updated wi=
th such checking
> before calling ACPI interfaces. However, it seems that such calls was put=
 there intentionally,
> without ACPI state check, as part of kernel testing strategy.

Not really.

Thanks,
Rafael

--===============2234274689256829313==--

