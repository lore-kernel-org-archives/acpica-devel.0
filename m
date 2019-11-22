Content-Type: multipart/mixed; boundary="===============4731410414944312904=="
MIME-Version: 1.0
From: Schmauss, Erik <erik.schmauss at intel.com>
Subject: [Devel] Re: PROBLEM: Calling ObjectType on buffer field reports type
 integer
Date: Fri, 22 Nov 2019 23:29:01 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53C68481C@ORSMSX122.amr.corp.intel.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E3B96B1A77@ORSMSX110.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4731410414944312904==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Bob and I started debugging this and we found the issue:

Let's say that we have this code:

Name (BUF1, Buffer (0x10) {})
Method (M001)
{
    CreateField (BUF1, 1, 72, FLD0)
    local0 =3D FLD0 // BUG: store operator (aka =3D)  converts FLD0 into an=
 integer
    return (ObjectType (local0)) // Integer is returned
}

Although FLD0's value is small enough to fit in an integer, the bit length =
of FLD0 exceeds 64 bits so local0 should actually be a Buffer type.

This is likely an issue in the implicit object conversion rules implemented=
 in the store operator. I'll take a look at this next week or the week afte=
r...

Thanks for your patience,
Erik

> -----Original Message-----
> From: Moore, Robert <robert.moore(a)intel.com>
> Sent: Friday, November 22, 2019 2:07 PM
> To: Moore, Robert <robert.moore(a)intel.com>; Maximilian Luz
> <luzmaximilian(a)gmail.com>; Schmauss, Erik <erik.schmauss(a)intel.com>;
> Wysocki, Rafael J <rafael.j.wysocki(a)intel.com>
> Cc: linux-acpi(a)vger.kernel.org; devel(a)acpica.org
> Subject: RE: PROBLEM: Calling ObjectType on buffer field reports type int=
eger
> =

> I'm not seeing this problem. For example:
>     Method (DS01)
>     {
>         Name(BUFZ, Buffer(48){})
>         CreateField(BUFZ, 192, 69, DST0)
>         Store (ObjectType (DST0), Debug)
>     }
> =

> Acpiexec dsdt.aml
> Eval DS01
> Evaluating \DS01
> ACPI Debug:  0x000000000000000E
> =

> 0x0E is in fact type "buffer field".
> =

> =

> -----Original Message-----
> From: Moore, Robert <robert.moore(a)intel.com>
> Sent: Friday, November 22, 2019 9:12 AM
> To: Maximilian Luz <luzmaximilian(a)gmail.com>; Schmauss, Erik
> <erik.schmauss(a)intel.com>; Wysocki, Rafael J <rafael.j.wysocki(a)intel.=
com>
> Cc: linux-acpi(a)vger.kernel.org; devel(a)acpica.org
> Subject: [Devel] Re: PROBLEM: Calling ObjectType on buffer field reports =
type
> integer
> =

> We will probably make this change, depending on what Windows does.
> Bob
> =

> =

> -----Original Message-----
> From: Maximilian Luz <luzmaximilian(a)gmail.com>
> Sent: Sunday, November 10, 2019 1:30 PM
> To: Schmauss, Erik <erik.schmauss(a)intel.com>; Moore, Robert
> <robert.moore(a)intel.com>; Wysocki, Rafael J <rafael.j.wysocki(a)intel.c=
om>
> Cc: linux-acpi(a)vger.kernel.org; devel(a)acpica.org
> Subject: Re: PROBLEM: Calling ObjectType on buffer field reports type int=
eger
> =

> =

> On 7/23/19 1:01 AM, Schmauss, Erik wrote:
> > Sorry about the late response. This slipped through the cracks.
> > I've sent them an email just now and I'll keep you informed
> =

> Hi again,
> =

> is there any update on this?
> =

> Regards,
> =

> Maximilian
> _______________________________________________
> Devel mailing list -- devel(a)acpica.org
> To unsubscribe send an email to devel-leave(a)acpica.org
> %(web_page_url)slistinfo%(cgiext)s/%(_internal_name)s
--===============4731410414944312904==--

