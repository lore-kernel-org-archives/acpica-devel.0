Content-Type: multipart/mixed; boundary="===============6525797789589184847=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] Re: PROBLEM: Calling ObjectType on buffer field reports type
 integer
Date: Fri, 22 Nov 2019 22:07:26 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B96B1A77@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E3B96B196C@ORSMSX110.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6525797789589184847==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I'm not seeing this problem. For example:
    Method (DS01)
    {
        Name(BUFZ, Buffer(48){})
        CreateField(BUFZ, 192, 69, DST0)
        Store (ObjectType (DST0), Debug)
    }

Acpiexec dsdt.aml
Eval DS01
Evaluating \DS01
ACPI Debug:  0x000000000000000E

0x0E is in fact type "buffer field".


-----Original Message-----
From: Moore, Robert <robert.moore(a)intel.com> =

Sent: Friday, November 22, 2019 9:12 AM
To: Maximilian Luz <luzmaximilian(a)gmail.com>; Schmauss, Erik <erik.schmau=
ss(a)intel.com>; Wysocki, Rafael J <rafael.j.wysocki(a)intel.com>
Cc: linux-acpi(a)vger.kernel.org; devel(a)acpica.org
Subject: [Devel] Re: PROBLEM: Calling ObjectType on buffer field reports ty=
pe integer

We will probably make this change, depending on what Windows does.
Bob


-----Original Message-----
From: Maximilian Luz <luzmaximilian(a)gmail.com> =

Sent: Sunday, November 10, 2019 1:30 PM
To: Schmauss, Erik <erik.schmauss(a)intel.com>; Moore, Robert <robert.moore=
(a)intel.com>; Wysocki, Rafael J <rafael.j.wysocki(a)intel.com>
Cc: linux-acpi(a)vger.kernel.org; devel(a)acpica.org
Subject: Re: PROBLEM: Calling ObjectType on buffer field reports type integ=
er


On 7/23/19 1:01 AM, Schmauss, Erik wrote:
> Sorry about the late response. This slipped through the cracks.
> I've sent them an email just now and I'll keep you informed

Hi again,

is there any update on this?

Regards,

Maximilian
_______________________________________________
Devel mailing list -- devel(a)acpica.org
To unsubscribe send an email to devel-leave(a)acpica.org
%(web_page_url)slistinfo%(cgiext)s/%(_internal_name)s
--===============6525797789589184847==--

