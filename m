Content-Type: multipart/mixed; boundary="===============6636772780011332969=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH] ACPI: APEI: Fix num_ghes to unsigned int
Date: Wed, 05 Oct 2022 17:49:40 +0200
Message-ID: <CAJZ5v0jM8WrE1u1x5K26Lj0kEvRfQB=nk4vOXYEnoG-zeuywRw@mail.gmail.com>
In-Reply-To: 20221005154105.454809-1-Ashish.Kalra@amd.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6636772780011332969==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 5, 2022 at 5:41 PM Ashish Kalra <Ashish.Kalra(a)amd.com> wrote:
>
> Yes, on one of our AMD EPYC processors, num_ghes is 32776 and we get the =
following call trace due to vmalloc() failure beacuse of the overflow:

But int should be more than sufficient to accommodate that number.

I think that the overflow takes place during the execution of this statemen=
t:

len +=3D (num_ghes * GHES_ESOURCE_PREALLOC_MAX_SIZE);

because the right-hand side of it is of type int, because both
multiplication operands are int.

You should say that in the changelog.
--===============6636772780011332969==--

