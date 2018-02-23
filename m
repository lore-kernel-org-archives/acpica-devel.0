Content-Type: multipart/mixed; boundary="===============5400852783612764159=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [PATCH 2/2] acpi: Avoid that acpi_ns_evaluate() triggers
 a soft lockup complaint
Date: Fri, 23 Feb 2018 11:17:07 +0100
Message-ID: <CAJZ5v0j_OKWFSyfiHpm_-pXqxC08eb9M5bdgdpqXBghQZD5PtA@mail.gmail.com>
In-Reply-To: CAJZ5v0i8TZ7BRh0-sxPDd5iCkaDfqZbGSXrKHkj6XUcN0sDQjw@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5400852783612764159==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2018 at 11:08 AM, Rafael J. Wysocki <rafael(a)kernel.org> w=
rote:
> On Fri, Feb 23, 2018 at 1:22 AM, Bart Van Assche <bart.vanassche(a)wdc.co=
m> wrote:
>> This patch avoids that the following is reported during boot with
>> kmemleak and other kernel debugging options enabled:
>
> Again, it would be sort of nice to explain why you want to fix the
> issue this particular way.
>
> We actually can't add cond_resched() to these code paths directly,
> because the code in question comes from an external project, so we
> need to understand the issue and see if it can be fixed differently.

And BTW, the fact that it happens in Linux indicates that it very well
may happen in the other OSes using ACPICA, so ideally we'd need to fix
it in a more general fashion.

--===============5400852783612764159==--

