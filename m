Content-Type: multipart/mixed; boundary="===============5312490281454317869=="
MIME-Version: 1.0
From: Alex Hung <alex.hung at canonical.com>
Subject: Re: [Devel] Fwd: question about _PTS invocation - mandatory ?
Date: Wed, 02 Jan 2013 16:14:06 +0800
Message-ID: <50E3EC4E.1070908@canonical.com>
In-Reply-To: CAMNNis6OHJQC3qoTO_3tmGamZuGED_D0bLB18zQtf2D1oXeGUw@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5312490281454317869==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I checked ACPI spec 5.0 and it states as below:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
7.3.2 \_PTS (Prepare To Sleep)
The _PTS control method is executed by the OS during the sleep =

transition process for S1, S2, S3, S4, and for orderly S5 shutdown
...
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
So it seems it is mandatory.

On 01/02/2013 03:17 PM, Yaron Weinsberg wrote:
> Hi Guys,
> is it mandatory for the OSPM to invoke _PTS before switching to the S5
> state ?
> I've noticed that during power loss, the BIOS settings sometimes reset.
> E.g. all user settings in the BIOS retrun to their default values.
> Could it be related ?
> what possibly cause the BIOS to reset its settings ? (the battery is new.=
.)
> thanks,
> - Yaron
>
>
>
> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> http://lists.acpica.org/listinfo/devel
>




--===============5312490281454317869==--

