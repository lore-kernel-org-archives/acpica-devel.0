Content-Type: multipart/mixed; boundary="===============3380633919059208595=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] Can a userspace tool to read the Embedded Controller
 get	added to acpica sources?
Date: Fri, 27 Aug 2010 14:47:55 -0700
Message-ID: <4911F71203A09E4D9981D27F9D830858AED630B1@orsmsx503.amr.corp.intel.com>
In-Reply-To: 201008271531.21589.trenn@suse.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3380633919059208595==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Seems like it will have lots of very EC-specific stuff, so sure, we can add=
 to ACPICA. Make sure any OS-dependent stuff is modularized.



>-----Original Message-----
>From: Moore, Robert
>Sent: Friday, August 27, 2010 2:36 PM
>To: 'Thomas Renninger'
>Subject: RE: [Devel] Can a userspace tool to read the Embedded Controller
>get added to acpica sources?
>
>OK, we'll take a look
>
>
>>-----Original Message-----
>>From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] On B=
ehalf
>>Of Thomas Renninger
>>Sent: Friday, August 27, 2010 6:31 AM
>>To: devel(a)acpica.org
>>Subject: [Devel] Can a userspace tool to read the Embedded Controller get
>>added to acpica sources?
>>
>>Hi,
>>
>>next kernel will have EC read/write support.
>>A userspace tool is needed to make use of the interface.
>>
>>As the Embedded Controller is tightly bound to ACPI
>>(devel/debugging/testing), the best package this tool would fit in is
>>acpica.
>>A new package is not worth it, if not accepted I'd still package
>>this together with acpica.rpm. But if it gets included, there is some
>>guarantee that this binary shows up in the same way on different
>>distros.
>>
>>Thus it would be great if this code:
>>ftp://ftp.suse.com/pub/people/trenn/sources/ec/ec_access.c
>>Could get integrated into the acpica repository.
>>
>>Not sure where this best could fit into if accepted, possibly:
>>acpica/source/os_specific/ec_access
>>or
>>acpica/source/os_specific/tools/ec_access
>>?
>>
>>Thanks,
>>
>>     Thomas
>>_______________________________________________
>>Devel mailing list
>>Devel(a)acpica.org
>>http://lists.acpica.org/listinfo/devel

--===============3380633919059208595==--

