Content-Type: multipart/mixed; boundary="===============1989264496139595053=="
MIME-Version: 1.0
From: Thomas Renninger <trenn at suse.de>
Subject: Re: [Devel] False positive iasl compiler error on resource object?
Date: Fri, 10 Sep 2010 22:19:23 +0200
Message-ID: <201009102219.23520.trenn@suse.de>
In-Reply-To: 4911F71203A09E4D9981D27F9D830858AF0CA981@orsmsx503.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1989264496139595053==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Friday 10 September 2010 17:04:34 Moore, Robert wrote:
> We've provided the -cr option to disable the resource descriptor error
> checking.
AFAIK, these zeroed resources that get filled up dynamically later are a =

rather common construct. If below additional checks cannot be added
this (these?) specific resource checks should better get disabled.

> This is an interesting problem. On one hand, we would like to provide
> static (compile time) error checking as much as possible. On the other
> hand, the resource descriptors (as well as most any other ASL/AML
> object) can be dynamically changed.
> =

> We've seen many ACPI tables with invalid resource descriptors (at both
> compile time and runtime), and that is the reason the resource
> descriptor validation was added to the compiler in the first place.
> =

> I don't want to just remove this validation, but yes, perhaps iASL
> should be able to recognize that this descriptor may be modified at
> runtime and therefore a static validation cannot be performed.
> =

> There are at least a few indicators:
> =

> 1) The descriptor is basically all zeroes
> 2) There is a CreateXxxField reference to the descriptor
> 3) There is a Store to the created field
> =

> So, perhaps we could detect the above conditions and then disable
> validation for this particular descriptor. Note, conditions (2) and
> (3) may be difficult to detect.
> =

> I'm open to suggestions.
Not sure whether runtime checks for this exist already.
Bjorn has done some great work there in the past.
If not, that should be by far easier, the so called "low hanging =

fruit"...

    Thomas

--===============1989264496139595053==--

