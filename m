Content-Type: multipart/mixed; boundary="===============2856808320926687098=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] -D <symbol> Preprocessor Option Doesn't Work
Date: Wed, 22 May 2013 14:54:17 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E36FE77E5A@ORSMSX103.amr.corp.intel.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E36FE77E2A@ORSMSX103.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2856808320926687098==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There does seem to be a problem. I will investigate further and get back to=
 you.
Bob
From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] On Beh=
alf Of Moore, Robert
Sent: Wednesday, May 22, 2013 6:51 AM
To: Alexei Fedorov
Cc: devel(a)acpica.org
Subject: Re: [Devel] -D <symbol> Preprocessor Option Doesn't Work

It should, but I will check out your code.


From: Alexei Fedorov [mailto:Alexei.Fedorov(a)arm.com]
Sent: Wednesday, May 22, 2013 5:46 AM
To: Moore, Robert
Cc: devel(a)acpica.org<mailto:devel(a)acpica.org>
Subject: RE: -D <symbol> Preprocessor Option Doesn't Work


Hi Robert,



Does pre-processor support the nested #if #else #endif statements?



This code



DefinitionBlock("DSDT.AML", "DSDT", 0x01, "      ", "        ", 3) {



  //

  //  System Bus

  //

  Scope(_SB) {

    // CPUs

    Device(CPU0) {

      Name(_HID, "ACPI0007")

      Name(_UID, Zero)

    }



#ifdef CPU_1

    Device(CPU1) {

      Name(_HID, "ACPI0007")

      Name(_UID, One)

    }

#else

#ifdef CPU_2

    Device(CPU2) {

      Name(_HID, "ACPI0007")

      Name(_UID, 2)

    }

#endif

#endif



  } // _SB

}

When complied with

iasl.exe -l -D CPU_1 Dsdt.asl

causes the errors below:

Intel ACPI Component Architecture

ASL Optimizing Compiler version 20130517-32 [May 17 2013]

Copyright (c) 2000 - 2013 Intel Corporation



Dsdt.asl     37: //

Error    6126 -^ syntax error, unexpected $end, expecting PARSEOP_DEFINITIO=
NBLOCK



Dsdt.asl     31: #endif

Error    6142 -  ^ Mismatched #endif (Preprocessor)



ASL Input:     Dsdt.asl - 38 lines, 0 bytes, 0 keywords

Listing File:  Dsdt.lst - 199 bytes



Compilation complete. 2 Errors, 0 Warnings, 0 Remarks, 0 Optimizations

Dsdt.i (Preprocessor Output file) Could not delete: Permission denied

Dsdt.src (Source Output file) Could not delete: Permission denied

-----Original Message-----
From: Moore, Robert [mailto:robert.moore(a)intel.com]
Sent: 17 May 2013 22:08
To: Alexei Fedorov
Subject: RE: -D <symbol> Preprocessor Option Doesn't Work



We did a new release today, so you can just grab the windows binary from th=
e website.

The fix for -D is in the release.



Bob





> -----Original Message-----

> From: devel-bounces(a)acpica.org<mailto:devel-bounces(a)acpica.org> [mail=
to:devel-bounces(a)acpica.org] On Behalf

> Of Alexei Fedorov

> Sent: Friday, May 17, 2013 3:16 AM

> To: devel(a)acpica.org<mailto:devel(a)acpica.org>

> Subject: Re: [Devel] -D <symbol> Preprocessor Option Doesn't Work

>

> >Yes, it looks like it has been there a while.

> >You can checkout the patch, or I can send you an updated windows binary.

> Hi Robert,

> Please send me an updated binary.

> Thanks.

> -----Original Message-----

> From: devel-bounces(a)acpica.org<mailto:devel-bounces(a)acpica.org> [mail=
to:devel-bounces(a)acpica.org] On Behalf

> Of devel-request(a)acpica.org<mailto:devel-request(a)acpica.org>

> Sent: 16 May 2013 18:09

> To: devel(a)acpica.org<mailto:devel(a)acpica.org>

> Subject: Devel Digest, Vol 38, Issue 5

>

> Send Devel mailing list submissions to

>         devel(a)acpica.org<mailto:devel(a)acpica.org>

>

> To subscribe or unsubscribe via the World Wide Web, visit

>         https://lists.acpica.org/mailman/listinfo/devel

> or, via email, send a message with subject or body 'help' to

>         devel-request(a)acpica.org<mailto:devel-request(a)acpica.org>

>

> You can reach the person managing the list at

>         devel-owner(a)acpica.org<mailto:devel-owner(a)acpica.org>

>

> When replying, please edit your Subject line so it is more specific than

> "Re: Contents of Devel digest..."

>

>

> Today's Topics:

>

>    1. Re: -D <symbol> Preprocessor Option Doesn't Work (Moore, Robert)

>    2. Re: -D <symbol> Preprocessor Option Doesn't Work (Moore, Robert)

>

>

> ----------------------------------------------------------------------

>

> Message: 1

> Date: Thu, 16 May 2013 15:59:17 +0000

> From: "Moore, Robert" <robert.moore(a)intel.com<mailto:robert.moore(a)int=
el.com>>

> To: Alexei Fedorov <Alexei.Fedorov(a)arm.com<mailto:Alexei.Fedorov(a)arm.=
com>>, "devel(a)acpica.org<mailto:devel(a)acpica.org>"

>         <devel(a)acpica.org<mailto:devel(a)acpica.org>>

> Subject: Re: [Devel] -D <symbol> Preprocessor Option Doesn't Work

> Message-ID:

>

> <94F2FBAB4432B54E8AACC7DFDE6C92E36FE6C321(a)ORSMSX103.amr.corp.intel.com<=
mailto:94F2FBAB4432B54E8AACC7DFDE6C92E36FE6C321(a)ORSMSX103.amr.corp.intel.=
com>>

>

> Content-Type: text/plain; charset=3D"us-ascii"

>

> The fix for this is checked into our git tree.

> Bob

> From: devel-bounces(a)acpica.org<mailto:devel-bounces(a)acpica.org> [mail=
to:devel-bounces(a)acpica.org] On Behalf

> Of Moore, Robert

> Sent: Wednesday, May 15, 2013 10:33 AM

> To: Alexei Fedorov; devel(a)acpica.org<mailto:devel(a)acpica.org>

> Subject: Re: [Devel] -D <symbol> Preprocessor Option Doesn't Work

>

> Sorry, we did some code restructuring and broke this. You can go back to

> an earlier version of the compiler, or wait until later this week when

> there will be a new version.

> Bob

> From: devel-bounces(a)acpica.org<mailto:devel-bounces(a)acpica.org<mailto=
:devel-bounces(a)acpica.org%3cmailto:devel-bounces(a)acpica.org>>

> [mailto:devel-bounces(a)acpica.org] On Behalf Of Moore, Robert

> Sent: Wednesday, May 15, 2013 8:43 AM

> To: Alexei Fedorov; devel(a)acpica.org<mailto:devel(a)acpica.org<mailto:d=
evel(a)acpica.org%3cmailto:devel(a)acpica.org>>

> Subject: Re: [Devel] -D <symbol> Preprocessor Option Doesn't Work

>

> We will check it out.

> Thanks,

> Bob

> From: devel-bounces(a)acpica.org<mailto:devel-bounces(a)acpica.org<mailto=
:devel-bounces(a)acpica.org%3cmailto:devel-bounces(a)acpica.org>>

> [mailto:devel-bounces(a)acpica.org] On Behalf Of Alexei Fedorov

> Sent: Tuesday, May 14, 2013 5:27 AM

> To: devel(a)acpica.org<mailto:devel(a)acpica.org<mailto:devel(a)acpica.or=
g%3cmailto:devel(a)acpica.org>>

> Subject: [Devel] -D <symbol> Preprocessor Option Doesn't Work

>

> Hi,

>

> ASL User Guide states that #ifdef statements are recognized when a symbol

> is defined in the command line:

>

> "3.3.2.2 #ifdef

> Usage:

> #ifdef symbol

> Conditionally compile a block of text. The block is included in the

> compilation if the symbol is defined, either from a #define or from the -

> D command line option"

>

> but I cannot make ASL Compiler to recognize the following option

>   -D <symbol>       Define symbol for preprocessor use

>

> In the example below

>

> DefinitionBlock("DSDT.AML", "DSDT", 0x01, "      ", "        ", 3) {

>   Scope(_SB) {

>     Device(CPU0) {

>       Name(_HID, "ACPI0007")

>       Name(_UID, Zero)

>     }

> #ifdef CPU_1

>     Device(CPU1) {

>               Name(_HID, "ACPI0007")

>               Name(_UID, One)

>     }

> #endif

>   }

> }

>

> The section between #ifdef CPU_1 ... #endif is not being compiled when ASL

> is invoked as:

> iasl.exe -l -D CPU_1 Dsdt.asl

> Checked with the latest version 20130418-32 [Apr 18 2013].

>

> Any thoughts on what might be going wrong here?

> Thanks.

>

>

>

> -- IMPORTANT NOTICE: The contents of this email and any attachments are

> confidential and may also be privileged. If you are not the intended

> recipient, please notify the sender immediately and do not disclose the

> contents to any other person, use it for any purpose, or store or copy the

> information in any medium. Thank you.

> -------------- next part --------------

> An HTML attachment was scrubbed...

> URL:

> <http://lists.acpica.org/pipermail/devel/attachments/20130516/6cc648cb/att

> achment-0001.html>

>

> ------------------------------

>

> Message: 2

> Date: Thu, 16 May 2013 17:12:44 +0000

> From: "Moore, Robert" <robert.moore(a)intel.com<mailto:robert.moore(a)int=
el.com>>

> To: Alexei Fedorov <Alexei.Fedorov(a)arm.com<mailto:Alexei.Fedorov(a)arm.=
com>>, "devel(a)acpica.org<mailto:devel(a)acpica.org>"

>         <devel(a)acpica.org<mailto:devel(a)acpica.org>>

> Subject: Re: [Devel] -D <symbol> Preprocessor Option Doesn't Work

> Message-ID:

>

> <94F2FBAB4432B54E8AACC7DFDE6C92E36FE6C3B5(a)ORSMSX103.amr.corp.intel.com<=
mailto:94F2FBAB4432B54E8AACC7DFDE6C92E36FE6C3B5(a)ORSMSX103.amr.corp.intel.=
com>>

>

> Content-Type: text/plain; charset=3D"us-ascii"

>

> Yes, it looks like it has been there a while.

> You can checkout the patch, or I can send you an updated windows binary.

>

>

> From: Alexei Fedorov [mailto:Alexei.Fedorov(a)arm.com]

> Sent: Thursday, May 16, 2013 3:17 AM

> To: Moore, Robert; devel(a)acpica.org<mailto:devel(a)acpica.org>

> Subject: RE: -D <symbol> Preprocessor Option Doesn't Work

>

> Hi Robert,

> I tried that with 4 previous versions of compiler & still got the same

> issue.

> Regards.

> Alexei.

>

> From: Moore, Robert [mailto:robert.moore(a)intel.com]

> Sent: 15 May 2013 18:33

> To: Alexei Fedorov; devel(a)acpica.org<mailto:devel(a)acpica.org<mailto:d=
evel(a)acpica.org%3cmailto:devel(a)acpica.org>>

> Subject: RE: -D <symbol> Preprocessor Option Doesn't Work

>

> Sorry, we did some code restructuring and broke this. You can go back to

> an earlier version of the compiler, or wait until later this week when

> there will be a new version.

> Bob

> From: devel-bounces(a)acpica.org<mailto:devel-bounces(a)acpica.org<mailto=
:devel-bounces(a)acpica.org%3cmailto:devel-bounces(a)acpica.org>>

> [mailto:devel-bounces(a)acpica.org] On Behalf Of Moore, Robert

> Sent: Wednesday, May 15, 2013 8:43 AM

> To: Alexei Fedorov; devel(a)acpica.org<mailto:devel(a)acpica.org<mailto:d=
evel(a)acpica.org%3cmailto:devel(a)acpica.org>>

> Subject: Re: [Devel] -D <symbol> Preprocessor Option Doesn't Work

>

> We will check it out.

> Thanks,

> Bob

> From: devel-bounces(a)acpica.org<mailto:devel-bounces(a)acpica.org<mailto=
:devel-bounces(a)acpica.org%3cmailto:devel-bounces(a)acpica.org>>

> [mailto:devel-bounces(a)acpica.org] On Behalf Of Alexei Fedorov

> Sent: Tuesday, May 14, 2013 5:27 AM

> To: devel(a)acpica.org<mailto:devel(a)acpica.org<mailto:devel(a)acpica.or=
g%3cmailto:devel(a)acpica.org>>

> Subject: [Devel] -D <symbol> Preprocessor Option Doesn't Work

>

> Hi,

>

> ASL User Guide states that #ifdef statements are recognized when a symbol

> is defined in the command line:

>

> "3.3.2.2 #ifdef

> Usage:

> #ifdef symbol

> Conditionally compile a block of text. The block is included in the

> compilation if the symbol is defined, either from a #define or from the -

> D command line option"

>

> but I cannot make ASL Compiler to recognize the following option

>   -D <symbol>       Define symbol for preprocessor use

>

> In the example below

>

> DefinitionBlock("DSDT.AML", "DSDT", 0x01, "      ", "        ", 3) {

>   Scope(_SB) {

>     Device(CPU0) {

>       Name(_HID, "ACPI0007")

>       Name(_UID, Zero)

>     }

> #ifdef CPU_1

>     Device(CPU1) {

>               Name(_HID, "ACPI0007")

>               Name(_UID, One)

>     }

> #endif

>   }

> }

>

> The section between #ifdef CPU_1 ... #endif is not being compiled when ASL

> is invoked as:

> iasl.exe -l -D CPU_1 Dsdt.asl

> Checked with the latest version 20130418-32 [Apr 18 2013].

>

> Any thoughts on what might be going wrong here?

> Thanks.

>

>

>

> -- IMPORTANT NOTICE: The contents of this email and any attachments are

> confidential and may also be privileged. If you are not the intended

> recipient, please notify the sender immediately and do not disclose the

> contents to any other person, use it for any purpose, or store or copy the

> information in any medium. Thank you.

>

> -- IMPORTANT NOTICE: The contents of this email and any attachments are

> confidential and may also be privileged. If you are not the intended

> recipient, please notify the sender immediately and do not disclose the

> contents to any other person, use it for any purpose, or store or copy the

> information in any medium. Thank you.

> -------------- next part --------------

> An HTML attachment was scrubbed...

> URL:

> <http://lists.acpica.org/pipermail/devel/attachments/20130516/eb8a496a/att

> achment.html>

>

> ------------------------------

>

> _______________________________________________

> Devel mailing list

> Devel(a)acpica.org<mailto:Devel(a)acpica.org>

> https://lists.acpica.org/mailman/listinfo/devel

>

> End of Devel Digest, Vol 38, Issue 5

> ************************************

>

>

> -- IMPORTANT NOTICE: The contents of this email and any attachments are

> confidential and may also be privileged. If you are not the intended

> recipient, please notify the sender immediately and do not disclose the

> contents to any other person, use it for any purpose, or store or copy the

> information in any medium.  Thank you.

>

> _______________________________________________

> Devel mailing list

> Devel(a)acpica.org<mailto:Devel(a)acpica.org>

> https://lists.acpica.org/mailman/listinfo/devel



-- IMPORTANT NOTICE: The contents of this email and any attachments are con=
fidential and may also be privileged. If you are not the intended recipient=
, please notify the sender immediately and do not disclose the contents to =
any other person, use it for any purpose, or store or copy the information =
in any medium. Thank you.

--===============2856808320926687098==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWwgeG1sbnM6dj0idXJuOnNjaGVtYXMtbWljcm9zb2Z0LWNvbTp2bWwiIHhtbG5zOm89InVy
bjpzY2hlbWFzLW1pY3Jvc29mdC1jb206b2ZmaWNlOm9mZmljZSIgeG1sbnM6dz0idXJuOnNjaGVt
YXMtbWljcm9zb2Z0LWNvbTpvZmZpY2U6d29yZCIgeG1sbnM6bT0iaHR0cDovL3NjaGVtYXMubWlj
cm9zb2Z0LmNvbS9vZmZpY2UvMjAwNC8xMi9vbW1sIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcv
VFIvUkVDLWh0bWw0MCI+CjxoZWFkPgo8bWV0YSBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiIGNv
bnRlbnQ9InRleHQvaHRtbDsgY2hhcnNldD11cy1hc2NpaSI+CjxtZXRhIG5hbWU9IkdlbmVyYXRv
ciIgY29udGVudD0iTWljcm9zb2Z0IFdvcmQgMTQgKGZpbHRlcmVkIG1lZGl1bSkiPgo8c3R5bGU+
PCEtLQovKiBGb250IERlZmluaXRpb25zICovCkBmb250LWZhY2UKCXtmb250LWZhbWlseTpDYWxp
YnJpOwoJcGFub3NlLTE6MiAxNSA1IDIgMiAyIDQgMyAyIDQ7fQpAZm9udC1mYWNlCgl7Zm9udC1m
YW1pbHk6VGFob21hOwoJcGFub3NlLTE6MiAxMSA2IDQgMyA1IDQgNCAyIDQ7fQpAZm9udC1mYWNl
Cgl7Zm9udC1mYW1pbHk6Q29uc29sYXM7CglwYW5vc2UtMToyIDExIDYgOSAyIDIgNCAzIDIgNDt9
Ci8qIFN0eWxlIERlZmluaXRpb25zICovCnAuTXNvTm9ybWFsLCBsaS5Nc29Ob3JtYWwsIGRpdi5N
c29Ob3JtYWwKCXttc28tbWFyZ2luLXRvcC1hbHQ6YXV0bzsKCW1hcmdpbi1yaWdodDowaW47Cglt
c28tbWFyZ2luLWJvdHRvbS1hbHQ6YXV0bzsKCW1hcmdpbi1sZWZ0OjBpbjsKCWZvbnQtc2l6ZTox
MS4wcHQ7Cglmb250LWZhbWlseToiQ2FsaWJyaSIsInNhbnMtc2VyaWYiO30KYTpsaW5rLCBzcGFu
Lk1zb0h5cGVybGluawoJe21zby1zdHlsZS1wcmlvcml0eTo5OTsKCWNvbG9yOmJsdWU7Cgl0ZXh0
LWRlY29yYXRpb246dW5kZXJsaW5lO30KYTp2aXNpdGVkLCBzcGFuLk1zb0h5cGVybGlua0ZvbGxv
d2VkCgl7bXNvLXN0eWxlLXByaW9yaXR5Ojk5OwoJY29sb3I6cHVycGxlOwoJdGV4dC1kZWNvcmF0
aW9uOnVuZGVybGluZTt9CnAuTXNvUGxhaW5UZXh0LCBsaS5Nc29QbGFpblRleHQsIGRpdi5Nc29Q
bGFpblRleHQKCXttc28tc3R5bGUtcHJpb3JpdHk6OTk7Cgltc28tc3R5bGUtbGluazoiUGxhaW4g
VGV4dCBDaGFyIjsKCW1zby1tYXJnaW4tdG9wLWFsdDphdXRvOwoJbWFyZ2luLXJpZ2h0OjBpbjsK
CW1zby1tYXJnaW4tYm90dG9tLWFsdDphdXRvOwoJbWFyZ2luLWxlZnQ6MGluOwoJZm9udC1zaXpl
OjEwLjVwdDsKCWZvbnQtZmFtaWx5OkNvbnNvbGFzO30KcC5Nc29BY2V0YXRlLCBsaS5Nc29BY2V0
YXRlLCBkaXYuTXNvQWNldGF0ZQoJe21zby1zdHlsZS1wcmlvcml0eTo5OTsKCW1zby1zdHlsZS1s
aW5rOiJCYWxsb29uIFRleHQgQ2hhciI7Cgltc28tbWFyZ2luLXRvcC1hbHQ6YXV0bzsKCW1hcmdp
bi1yaWdodDowaW47Cgltc28tbWFyZ2luLWJvdHRvbS1hbHQ6YXV0bzsKCW1hcmdpbi1sZWZ0OjBp
bjsKCWZvbnQtc2l6ZTo4LjBwdDsKCWZvbnQtZmFtaWx5OiJUYWhvbWEiLCJzYW5zLXNlcmlmIjt9
CnNwYW4uUGxhaW5UZXh0Q2hhcgoJe21zby1zdHlsZS1uYW1lOiJQbGFpbiBUZXh0IENoYXIiOwoJ
bXNvLXN0eWxlLXByaW9yaXR5Ojk5OwoJbXNvLXN0eWxlLWxpbms6IlBsYWluIFRleHQiOwoJZm9u
dC1mYW1pbHk6Q29uc29sYXM7fQpzcGFuLkJhbGxvb25UZXh0Q2hhcgoJe21zby1zdHlsZS1uYW1l
OiJCYWxsb29uIFRleHQgQ2hhciI7Cgltc28tc3R5bGUtcHJpb3JpdHk6OTk7Cgltc28tc3R5bGUt
bGluazoiQmFsbG9vbiBUZXh0IjsKCWZvbnQtZmFtaWx5OiJUYWhvbWEiLCJzYW5zLXNlcmlmIjt9
CnNwYW4uRW1haWxTdHlsZTIxCgl7bXNvLXN0eWxlLXR5cGU6cGVyc29uYWw7Cglmb250LWZhbWls
eToiQ2FsaWJyaSIsInNhbnMtc2VyaWYiOwoJY29sb3I6IzFGNDk3RDt9CnNwYW4uRW1haWxTdHls
ZTIyCgl7bXNvLXN0eWxlLXR5cGU6cGVyc29uYWwtcmVwbHk7Cglmb250LWZhbWlseToiQ2FsaWJy
aSIsInNhbnMtc2VyaWYiOwoJY29sb3I6IzFGNDk3RDt9Ci5Nc29DaHBEZWZhdWx0Cgl7bXNvLXN0
eWxlLXR5cGU6ZXhwb3J0LW9ubHk7Cglmb250LXNpemU6MTAuMHB0O30KQHBhZ2UgV29yZFNlY3Rp
b24xCgl7c2l6ZTo4LjVpbiAxMS4waW47CgltYXJnaW46MS4waW4gMS4waW4gMS4waW4gMS4waW47
fQpkaXYuV29yZFNlY3Rpb24xCgl7cGFnZTpXb3JkU2VjdGlvbjE7fQotLT48L3N0eWxlPjwhLS1b
aWYgZ3RlIG1zbyA5XT48eG1sPgo8bzpzaGFwZWRlZmF1bHRzIHY6ZXh0PSJlZGl0IiBzcGlkbWF4
PSIxMDI2IiAvPgo8L3htbD48IVtlbmRpZl0tLT48IS0tW2lmIGd0ZSBtc28gOV0+PHhtbD4KPG86
c2hhcGVsYXlvdXQgdjpleHQ9ImVkaXQiPgo8bzppZG1hcCB2OmV4dD0iZWRpdCIgZGF0YT0iMSIg
Lz4KPC9vOnNoYXBlbGF5b3V0PjwveG1sPjwhW2VuZGlmXS0tPgo8L2hlYWQ+Cjxib2R5IGxhbmc9
IkVOLVVTIiBsaW5rPSJibHVlIiB2bGluaz0icHVycGxlIj4KPGRpdiBjbGFzcz0iV29yZFNlY3Rp
b24xIj4KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxRjQ5N0QiPlRo
ZXJlIGRvZXMgc2VlbSB0byBiZSBhIHByb2JsZW0uIEkgd2lsbCBpbnZlc3RpZ2F0ZSBmdXJ0aGVy
IGFuZCBnZXQgYmFjayB0byB5b3UuPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNv
Tm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6IzFGNDk3RCI+Qm9iPG86cD48L286cD48L3NwYW4+
PC9wPgo8ZGl2IHN0eWxlPSJib3JkZXI6bm9uZTtib3JkZXItbGVmdDpzb2xpZCBibHVlIDEuNXB0
O3BhZGRpbmc6MGluIDBpbiAwaW4gNC4wcHQiPgo8ZGl2Pgo8ZGl2IHN0eWxlPSJib3JkZXI6bm9u
ZTtib3JkZXItdG9wOnNvbGlkICNCNUM0REYgMS4wcHQ7cGFkZGluZzozLjBwdCAwaW4gMGluIDBp
biI+CjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJtYXJnaW46MGluO21hcmdpbi1ib3R0b206
LjAwMDFwdCI+PGI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMC4wcHQ7Zm9udC1mYW1pbHk6JnF1
b3Q7VGFob21hJnF1b3Q7LCZxdW90O3NhbnMtc2VyaWYmcXVvdDsiPkZyb206PC9zcGFuPjwvYj48
c3BhbiBzdHlsZT0iZm9udC1zaXplOjEwLjBwdDtmb250LWZhbWlseTomcXVvdDtUYWhvbWEmcXVv
dDssJnF1b3Q7c2Fucy1zZXJpZiZxdW90OyI+IGRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZyBbbWFp
bHRvOmRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZ10KPGI+T24gQmVoYWxmIE9mIDwvYj5Nb29yZSwg
Um9iZXJ0PGJyPgo8Yj5TZW50OjwvYj4gV2VkbmVzZGF5LCBNYXkgMjIsIDIwMTMgNjo1MSBBTTxi
cj4KPGI+VG86PC9iPiBBbGV4ZWkgRmVkb3Jvdjxicj4KPGI+Q2M6PC9iPiBkZXZlbEBhY3BpY2Eu
b3JnPGJyPgo8Yj5TdWJqZWN0OjwvYj4gUmU6IFtEZXZlbF0gLUQgJmx0O3N5bWJvbCZndDsgUHJl
cHJvY2Vzc29yIE9wdGlvbiBEb2Vzbid0IFdvcms8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjwvZGl2
Pgo8L2Rpdj4KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PG86cD4mbmJzcDs8L286cD48L3A+CjxwIGNs
YXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjojMUY0OTdEIj5JdCBzaG91bGQsIGJ1
dCBJIHdpbGwgY2hlY2sgb3V0IHlvdXIgY29kZS48bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNs
YXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjojMUY0OTdEIj48bzpwPiZuYnNwOzwv
bzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjoj
MUY0OTdEIj48bzpwPiZuYnNwOzwvbzpwPjwvc3Bhbj48L3A+CjxkaXYgc3R5bGU9ImJvcmRlcjpu
b25lO2JvcmRlci1sZWZ0OnNvbGlkIGJsdWUgMS41cHQ7cGFkZGluZzowaW4gMGluIDBpbiA0LjBw
dCI+CjxkaXY+CjxkaXYgc3R5bGU9ImJvcmRlcjpub25lO2JvcmRlci10b3A6c29saWQgI0I1QzRE
RiAxLjBwdDtwYWRkaW5nOjMuMHB0IDBpbiAwaW4gMGluIj4KPHAgY2xhc3M9Ik1zb05vcm1hbCIg
c3R5bGU9Im1hcmdpbjowaW47bWFyZ2luLWJvdHRvbTouMDAwMXB0Ij48Yj48c3BhbiBzdHlsZT0i
Zm9udC1zaXplOjEwLjBwdDtmb250LWZhbWlseTomcXVvdDtUYWhvbWEmcXVvdDssJnF1b3Q7c2Fu
cy1zZXJpZiZxdW90OyI+RnJvbTo8L3NwYW4+PC9iPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTAu
MHB0O2ZvbnQtZmFtaWx5OiZxdW90O1RhaG9tYSZxdW90OywmcXVvdDtzYW5zLXNlcmlmJnF1b3Q7
Ij4gQWxleGVpIEZlZG9yb3YgWzxhIGhyZWY9Im1haWx0bzpBbGV4ZWkuRmVkb3JvdkBhcm0uY29t
Ij5tYWlsdG86QWxleGVpLkZlZG9yb3ZAYXJtLmNvbTwvYT5dCjxicj4KPGI+U2VudDo8L2I+IFdl
ZG5lc2RheSwgTWF5IDIyLCAyMDEzIDU6NDYgQU08YnI+CjxiPlRvOjwvYj4gTW9vcmUsIFJvYmVy
dDxicj4KPGI+Q2M6PC9iPiA8YSBocmVmPSJtYWlsdG86ZGV2ZWxAYWNwaWNhLm9yZyI+ZGV2ZWxA
YWNwaWNhLm9yZzwvYT48YnI+CjxiPlN1YmplY3Q6PC9iPiBSRTogLUQgJmx0O3N5bWJvbCZndDsg
UHJlcHJvY2Vzc29yIE9wdGlvbiBEb2Vzbid0IFdvcms8bzpwPjwvbzpwPjwvc3Bhbj48L3A+Cjwv
ZGl2Pgo8L2Rpdj4KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PG86cD4mbmJzcDs8L286cD48L3A+Cjxw
IGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj5IaSBSb2JlcnQsPG86cD48
L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1H
QiI+PG86cD4mbmJzcDs8L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48
c3BhbiBsYW5nPSJFTi1HQiI+RG9lcyBwcmUtcHJvY2Vzc29yIHN1cHBvcnQgdGhlIG5lc3RlZCAj
aWYgI2Vsc2UgI2VuZGlmIHN0YXRlbWVudHM/PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFz
cz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+PG86cD4mbmJzcDs8L286cD48L3Nw
YW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+VGhpcyBj
b2RlPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBs
YW5nPSJFTi1HQiI+PG86cD4mbmJzcDs8L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxh
aW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+RGVmaW5pdGlvbkJsb2NrKCZxdW90O0RTRFQuQU1M
JnF1b3Q7LCAmcXVvdDtEU0RUJnF1b3Q7LCAweDAxLCAmcXVvdDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsgJnF1b3Q7LCAmcXVvdDsmbmJzcDsmbmJzcDsmbmJzcDsgJm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7JnF1b3Q7LCAzKSB7PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0i
TXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+PG86cD4mbmJzcDs8L286cD48L3NwYW4+
PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jm5ic3A7IC8v
PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5n
PSJFTi1HQiI+Jm5ic3A7IC8vJm5ic3A7IFN5c3RlbSBCdXM8bzpwPjwvbzpwPjwvc3Bhbj48L3A+
CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mbmJzcDsgLy88bzpw
PjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVO
LUdCIj4mbmJzcDsgU2NvcGUoX1NCKSB7PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0i
TXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jm5ic3A7Jm5ic3A7Jm5ic3A7IC8vIENQ
VXM8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxh
bmc9IkVOLUdCIj4mbmJzcDsmbmJzcDsmbmJzcDsgRGV2aWNlKENQVTApIHs8bzpwPjwvbzpwPjwv
c3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgTmFtZShfSElELCAmcXVvdDtBQ1BJMDAwNyZxdW90
Oyk8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxh
bmc9IkVOLUdCIj4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgTmFtZShfVUlELCBaZXJv
KTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFu
Zz0iRU4tR0IiPiZuYnNwOyZuYnNwOyZuYnNwOyB9PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBj
bGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+PG86cD4mbmJzcDs8L286cD48
L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+I2lm
ZGVmIENQVV8xPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48
c3BhbiBsYW5nPSJFTi1HQiI+Jm5ic3A7Jm5ic3A7Jm5ic3A7IERldmljZShDUFUxKSB7PG86cD48
L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1H
QiI+Jm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyBOYW1lKF9ISUQsICZxdW90O0FDUEkwMDA3JnF1
b3Q7KTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4g
bGFuZz0iRU4tR0IiPiZuYnNwOyZuYnNwOyZuYnNwOyAmbmJzcDsgTmFtZShfVUlELCBPbmUpPG86
cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJF
Ti1HQiI+Jm5ic3A7Jm5ic3A7Jm5ic3A7IH08bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNz
PSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4jZWxzZTxvOnA+PC9vOnA+PC9zcGFu
PjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiNpZmRlZiBD
UFVfMjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4g
bGFuZz0iRU4tR0IiPiZuYnNwOyZuYnNwOyZuYnNwOyBEZXZpY2UoQ1BVMikgezxvOnA+PC9vOnA+
PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZu
YnNwOyZuYnNwOyZuYnNwOyAmbmJzcDsgTmFtZShfSElELCAmcXVvdDtBQ1BJMDAwNyZxdW90Oyk8
bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9
IkVOLUdCIj4mbmJzcDsmbmJzcDsmbmJzcDsgJm5ic3A7IE5hbWUoX1VJRCwgMik8bzpwPjwvbzpw
Pjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4m
bmJzcDsmbmJzcDsmbmJzcDsgfTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1Bs
YWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiNlbmRpZjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4K
PHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiNlbmRpZjxvOnA+PC9v
OnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0Ii
PiZuYnNwOyZuYnNwOyA8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRl
eHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mbmJzcDsmbmJzcDt9IC8vIF9TQjxvOnA+PC9vOnA+PC9z
cGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPn08bzpw
PjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVO
LUdCIj5XaGVuIGNvbXBsaWVkIHdpdGg8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJN
c29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj5pYXNsLmV4ZSAtbCAtRCBDUFVfMSBEc2R0
LmFzbDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4g
bGFuZz0iRU4tR0IiPmNhdXNlcyB0aGUgZXJyb3JzIGJlbG93OjxvOnA+PC9vOnA+PC9zcGFuPjwv
cD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPkludGVsIEFDUEkg
Q29tcG9uZW50IEFyY2hpdGVjdHVyZTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1z
b1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPkFTTCBPcHRpbWl6aW5nIENvbXBpbGVyIHZl
cnNpb24gMjAxMzA1MTctMzIgW01heSAxNyAyMDEzXTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAg
Y2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPkNvcHlyaWdodCAoYykgMjAw
MCAtIDIwMTMgSW50ZWwgQ29ycG9yYXRpb248bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNz
PSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj48bzpwPiZuYnNwOzwvbzpwPjwvc3Bh
bj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj5Ec2R0LmFz
bCZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAzNzogLy88bzpwPjwvbzpwPjwvc3Bhbj48L3A+Cjxw
IGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj5FcnJvciZuYnNwOyZuYnNw
OyZuYnNwOyA2MTI2IC1eIHN5bnRheCBlcnJvciwgdW5leHBlY3RlZCAkZW5kLCBleHBlY3Rpbmcg
UEFSU0VPUF9ERUZJTklUSU9OQkxPQ0s8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJN
c29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj48bzpwPiZuYnNwOzwvbzpwPjwvc3Bhbj48
L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj5Ec2R0LmFzbCZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAzMTogI2VuZGlmPG86cD48L286cD48L3NwYW4+PC9wPgo8
cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+RXJyb3ImbmJzcDsmbmJz
cDsmbmJzcDsgNjE0MiAtJm5ic3A7IF4gTWlzbWF0Y2hlZCAjZW5kaWYgKFByZXByb2Nlc3Nvcik8
bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9
IkVOLUdCIj48bzpwPiZuYnNwOzwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRl
eHQiPjxzcGFuIGxhbmc9IkVOLUdCIj5BU0wgSW5wdXQ6Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
IERzZHQuYXNsIC0gMzggbGluZXMsIDAgYnl0ZXMsIDAga2V5d29yZHM8bzpwPjwvbzpwPjwvc3Bh
bj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj5MaXN0aW5n
IEZpbGU6Jm5ic3A7IERzZHQubHN0IC0gMTk5IGJ5dGVzPG86cD48L286cD48L3NwYW4+PC9wPgo8
cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+PG86cD4mbmJzcDs8L286
cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+
Q29tcGlsYXRpb24gY29tcGxldGUuIDIgRXJyb3JzLCAwIFdhcm5pbmdzLCAwIFJlbWFya3MsIDAg
T3B0aW1pemF0aW9uczxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4
dCI+PHNwYW4gbGFuZz0iRU4tR0IiPkRzZHQuaSAoUHJlcHJvY2Vzc29yIE91dHB1dCBmaWxlKSBD
b3VsZCBub3QgZGVsZXRlOiBQZXJtaXNzaW9uIGRlbmllZDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4K
PHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPkRzZHQuc3JjIChTb3Vy
Y2UgT3V0cHV0IGZpbGUpIENvdWxkIG5vdCBkZWxldGU6IFBlcm1pc3Npb24gZGVuaWVkPG86cD48
L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4tLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLTxicj4KRnJvbTogTW9vcmUsIFJvYmVydCBbPGEgaHJlZj0ibWFpbHRvOnJvYmVy
dC5tb29yZUBpbnRlbC5jb20iPm1haWx0bzpyb2JlcnQubW9vcmVAaW50ZWwuY29tPC9hPl0KPGJy
PgpTZW50OiAxNyBNYXkgMjAxMyAyMjowODxicj4KVG86IEFsZXhlaSBGZWRvcm92PGJyPgpTdWJq
ZWN0OiBSRTogLUQgJmx0O3N5bWJvbCZndDsgUHJlcHJvY2Vzc29yIE9wdGlvbiBEb2Vzbid0IFdv
cms8c3BhbiBsYW5nPSJFTi1HQiI+PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNv
UGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+PG86cD4mbmJzcDs8L286cD48L3NwYW4+PC9w
Pgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+V2UgZGlkIGEgbmV3
IHJlbGVhc2UgdG9kYXksIHNvIHlvdSBjYW4ganVzdCBncmFiIHRoZSB3aW5kb3dzIGJpbmFyeSBm
cm9tIHRoZSB3ZWJzaXRlLjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWlu
VGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPlRoZSBmaXggZm9yIC1EIGlzIGluIHRoZSByZWxlYXNl
LjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFu
Zz0iRU4tR0IiPjxvOnA+Jm5ic3A7PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWlu
VGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPkJvYjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xh
c3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPjxvOnA+Jm5ic3A7PC9vOnA+PC9z
cGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPjxvOnA+
Jm5ic3A7PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFu
Zz0iRU4tR0IiPiZndDsgLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS08bzpwPjwvbzpwPjwvc3Bh
bj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IEZy
b206IDxhIGhyZWY9Im1haWx0bzpkZXZlbC1ib3VuY2VzQGFjcGljYS5vcmciPgo8c3BhbiBzdHls
ZT0iY29sb3I6d2luZG93dGV4dDt0ZXh0LWRlY29yYXRpb246bm9uZSI+ZGV2ZWwtYm91bmNlc0Bh
Y3BpY2Eub3JnPC9zcGFuPjwvYT4gWzxhIGhyZWY9Im1haWx0bzpkZXZlbC1ib3VuY2VzQGFjcGlj
YS5vcmciPjxzcGFuIHN0eWxlPSJjb2xvcjp3aW5kb3d0ZXh0O3RleHQtZGVjb3JhdGlvbjpub25l
Ij5tYWlsdG86ZGV2ZWwtYm91bmNlc0BhY3BpY2Eub3JnPC9zcGFuPjwvYT5dIE9uIEJlaGFsZjxv
OnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0i
RU4tR0IiPiZndDsgT2YgQWxleGVpIEZlZG9yb3Y8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNs
YXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IFNlbnQ6IEZyaWRheSwg
TWF5IDE3LCAyMDEzIDM6MTYgQU08bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29Q
bGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IFRvOiA8YSBocmVmPSJtYWlsdG86ZGV2
ZWxAYWNwaWNhLm9yZyI+CjxzcGFuIHN0eWxlPSJjb2xvcjp3aW5kb3d0ZXh0O3RleHQtZGVjb3Jh
dGlvbjpub25lIj5kZXZlbEBhY3BpY2Eub3JnPC9zcGFuPjwvYT48bzpwPjwvbzpwPjwvc3Bhbj48
L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IFN1Ympl
Y3Q6IFJlOiBbRGV2ZWxdIC1EICZsdDtzeW1ib2wmZ3Q7IFByZXByb2Nlc3NvciBPcHRpb24gRG9l
c24ndCBXb3JrPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48
c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyA8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJN
c29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7ICZndDtZZXMsIGl0IGxvb2tzIGxp
a2UgaXQgaGFzIGJlZW4gdGhlcmUgYSB3aGlsZS48bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNs
YXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7ICZndDtZb3UgY2FuIGNo
ZWNrb3V0IHRoZSBwYXRjaCwgb3IgSSBjYW4gc2VuZCB5b3UgYW4gdXBkYXRlZCB3aW5kb3dzIGJp
bmFyeS48bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFu
IGxhbmc9IkVOLUdCIj4mZ3Q7IEhpIFJvYmVydCw8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNs
YXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IFBsZWFzZSBzZW5kIG1l
IGFuIHVwZGF0ZWQgYmluYXJ5LjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1Bs
YWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgVGhhbmtzLjxvOnA+PC9vOnA+PC9zcGFu
PjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS08bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJN
c29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IEZyb206IDxhIGhyZWY9Im1haWx0
bzpkZXZlbC1ib3VuY2VzQGFjcGljYS5vcmciPgo8c3BhbiBzdHlsZT0iY29sb3I6d2luZG93dGV4
dDt0ZXh0LWRlY29yYXRpb246bm9uZSI+ZGV2ZWwtYm91bmNlc0BhY3BpY2Eub3JnPC9zcGFuPjwv
YT4gWzxhIGhyZWY9Im1haWx0bzpkZXZlbC1ib3VuY2VzQGFjcGljYS5vcmciPjxzcGFuIHN0eWxl
PSJjb2xvcjp3aW5kb3d0ZXh0O3RleHQtZGVjb3JhdGlvbjpub25lIj5tYWlsdG86ZGV2ZWwtYm91
bmNlc0BhY3BpY2Eub3JnPC9zcGFuPjwvYT5dIE9uIEJlaGFsZjxvOnA+PC9vOnA+PC9zcGFuPjwv
cD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgT2YgPGEg
aHJlZj0ibWFpbHRvOmRldmVsLXJlcXVlc3RAYWNwaWNhLm9yZyI+CjxzcGFuIHN0eWxlPSJjb2xv
cjp3aW5kb3d0ZXh0O3RleHQtZGVjb3JhdGlvbjpub25lIj5kZXZlbC1yZXF1ZXN0QGFjcGljYS5v
cmc8L3NwYW4+PC9hPjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4
dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgU2VudDogMTYgTWF5IDIwMTMgMTg6MDk8bzpwPjwv
bzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdC
Ij4mZ3Q7IFRvOiA8YSBocmVmPSJtYWlsdG86ZGV2ZWxAYWNwaWNhLm9yZyI+CjxzcGFuIHN0eWxl
PSJjb2xvcjp3aW5kb3d0ZXh0O3RleHQtZGVjb3JhdGlvbjpub25lIj5kZXZlbEBhY3BpY2Eub3Jn
PC9zcGFuPjwvYT48bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQi
PjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IFN1YmplY3Q6IERldmVsIERpZ2VzdCwgVm9sIDM4LCBJ
c3N1ZSA1PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3Bh
biBsYW5nPSJFTi1HQiI+Jmd0OyA8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29Q
bGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IFNlbmQgRGV2ZWwgbWFpbGluZyBsaXN0
IHN1Ym1pc3Npb25zIHRvPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5U
ZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyA8YSBocmVmPSJtYWlsdG86ZGV2ZWxAYWNwaWNhLm9yZyI+Cjxz
cGFuIHN0eWxlPSJjb2xvcjp3aW5kb3d0ZXh0O3RleHQtZGVjb3JhdGlvbjpub25lIj5kZXZlbEBh
Y3BpY2Eub3JnPC9zcGFuPjwvYT48bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29Q
bGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4K
PHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgVG8gc3Vic2Ny
aWJlIG9yIHVuc3Vic2NyaWJlIHZpYSB0aGUgV29ybGQgV2lkZSBXZWIsIHZpc2l0PG86cD48L286
cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+
Jmd0OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyA8YSBo
cmVmPSJodHRwczovL2xpc3RzLmFjcGljYS5vcmcvbWFpbG1hbi9saXN0aW5mby9kZXZlbCI+Cjxz
cGFuIHN0eWxlPSJjb2xvcjp3aW5kb3d0ZXh0O3RleHQtZGVjb3JhdGlvbjpub25lIj5odHRwczov
L2xpc3RzLmFjcGljYS5vcmcvbWFpbG1hbi9saXN0aW5mby9kZXZlbDwvc3Bhbj48L2E+PG86cD48
L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1H
QiI+Jmd0OyBvciwgdmlhIGVtYWlsLCBzZW5kIGEgbWVzc2FnZSB3aXRoIHN1YmplY3Qgb3IgYm9k
eSAnaGVscCcgdG88bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQi
PjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7IDxhIGhyZWY9Im1haWx0bzpkZXZlbC1yZXF1ZXN0QGFjcGljYS5vcmci
Pgo8c3BhbiBzdHlsZT0iY29sb3I6d2luZG93dGV4dDt0ZXh0LWRlY29yYXRpb246bm9uZSI+ZGV2
ZWwtcmVxdWVzdEBhY3BpY2Eub3JnPC9zcGFuPjwvYT48bzpwPjwvbzpwPjwvc3Bhbj48L3A+Cjxw
IGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IDxvOnA+PC9vOnA+
PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZn
dDsgWW91IGNhbiByZWFjaCB0aGUgcGVyc29uIG1hbmFnaW5nIHRoZSBsaXN0IGF0PG86cD48L286
cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+
Jmd0OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyA8YSBo
cmVmPSJtYWlsdG86ZGV2ZWwtb3duZXJAYWNwaWNhLm9yZyI+CjxzcGFuIHN0eWxlPSJjb2xvcjp3
aW5kb3d0ZXh0O3RleHQtZGVjb3JhdGlvbjpub25lIj5kZXZlbC1vd25lckBhY3BpY2Eub3JnPC9z
cGFuPjwvYT48bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxz
cGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1z
b1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgV2hlbiByZXBseWluZywgcGxlYXNl
IGVkaXQgeW91ciBTdWJqZWN0IGxpbmUgc28gaXQgaXMgbW9yZSBzcGVjaWZpYyB0aGFuPG86cD48
L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1H
QiI+Jmd0OyAmcXVvdDtSZTogQ29udGVudHMgb2YgRGV2ZWwgZGlnZXN0Li4uJnF1b3Q7PG86cD48
L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1H
QiI+Jmd0OyA8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxz
cGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1z
b1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgVG9kYXkncyBUb3BpY3M6PG86cD48
L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1H
QiI+Jmd0OyA8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxz
cGFuIGxhbmc9IkVOLUdCIj4mZ3Q7Jm5ic3A7Jm5ic3A7Jm5ic3A7IDEuIFJlOiAtRCAmbHQ7c3lt
Ym9sJmd0OyBQcmVwcm9jZXNzb3IgT3B0aW9uIERvZXNuJ3QgV29yayAoTW9vcmUsIFJvYmVydCk8
bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9
IkVOLUdCIj4mZ3Q7Jm5ic3A7Jm5ic3A7Jm5ic3A7IDIuIFJlOiAtRCAmbHQ7c3ltYm9sJmd0OyBQ
cmVwcm9jZXNzb3IgT3B0aW9uIERvZXNuJ3QgV29yayAoTW9vcmUsIFJvYmVydCk8bzpwPjwvbzpw
Pjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4m
Z3Q7IDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4g
bGFuZz0iRU4tR0IiPiZndDsgPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxh
aW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPG86cD48L286cD48
L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0
OyA8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxh
bmc9IkVOLUdCIj4mZ3Q7IE1lc3NhZ2U6IDE8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNz
PSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IERhdGU6IFRodSwgMTYgTWF5
IDIwMTMgMTU6NTk6MTcgJiM0MzswMDAwPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0i
TXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBGcm9tOiAmcXVvdDtNb29yZSwg
Um9iZXJ0JnF1b3Q7ICZsdDs8YSBocmVmPSJtYWlsdG86cm9iZXJ0Lm1vb3JlQGludGVsLmNvbSI+
PHNwYW4gc3R5bGU9ImNvbG9yOndpbmRvd3RleHQ7dGV4dC1kZWNvcmF0aW9uOm5vbmUiPnJvYmVy
dC5tb29yZUBpbnRlbC5jb208L3NwYW4+PC9hPiZndDs8bzpwPjwvbzpwPjwvc3Bhbj48L3A+Cjxw
IGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IFRvOiBBbGV4ZWkg
RmVkb3JvdiAmbHQ7PGEgaHJlZj0ibWFpbHRvOkFsZXhlaS5GZWRvcm92QGFybS5jb20iPjxzcGFu
IHN0eWxlPSJjb2xvcjp3aW5kb3d0ZXh0O3RleHQtZGVjb3JhdGlvbjpub25lIj5BbGV4ZWkuRmVk
b3JvdkBhcm0uY29tPC9zcGFuPjwvYT4mZ3Q7LCAmcXVvdDs8YSBocmVmPSJtYWlsdG86ZGV2ZWxA
YWNwaWNhLm9yZyI+PHNwYW4gc3R5bGU9ImNvbG9yOndpbmRvd3RleHQ7dGV4dC1kZWNvcmF0aW9u
Om5vbmUiPmRldmVsQGFjcGljYS5vcmc8L3NwYW4+PC9hPiZxdW90OzxvOnA+PC9vOnA+PC9zcGFu
PjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgJmx0OzxhIGhyZWY9
Im1haWx0bzpkZXZlbEBhY3BpY2Eub3JnIj48c3BhbiBzdHlsZT0iY29sb3I6d2luZG93dGV4dDt0
ZXh0LWRlY29yYXRpb246bm9uZSI+ZGV2ZWxAYWNwaWNhLm9yZzwvc3Bhbj48L2E+Jmd0OzxvOnA+
PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4t
R0IiPiZndDsgU3ViamVjdDogUmU6IFtEZXZlbF0gLUQgJmx0O3N5bWJvbCZndDsgUHJlcHJvY2Vz
c29yIE9wdGlvbiBEb2Vzbid0IFdvcms8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJN
c29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IE1lc3NhZ2UtSUQ6PG86cD48L286
cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+
Jmd0OyA8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFu
IGxhbmc9IkVOLUdCIj4mZ3Q7ICZsdDs8YSBocmVmPSJtYWlsdG86OTRGMkZCQUI0NDMyQjU0RThB
QUNDN0RGREU2QzkyRTM2RkU2QzMyMUBPUlNNU1gxMDMuYW1yLmNvcnAuaW50ZWwuY29tIj48c3Bh
biBzdHlsZT0iY29sb3I6d2luZG93dGV4dDt0ZXh0LWRlY29yYXRpb246bm9uZSI+OTRGMkZCQUI0
NDMyQjU0RThBQUNDN0RGREU2QzkyRTM2RkU2QzMyMUBPUlNNU1gxMDMuYW1yLmNvcnAuaW50ZWwu
Y29tPC9zcGFuPjwvYT4mZ3Q7PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxh
aW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyA8bzpwPjwvbzpwPjwvc3Bhbj48L3A+Cjxw
IGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IENvbnRlbnQtVHlw
ZTogdGV4dC9wbGFpbjsgY2hhcnNldD0mcXVvdDt1cy1hc2NpaSZxdW90OzxvOnA+PC9vOnA+PC9z
cGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsg
PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5n
PSJFTi1HQiI+Jmd0OyBUaGUgZml4IGZvciB0aGlzIGlzIGNoZWNrZWQgaW50byBvdXIgZ2l0IHRy
ZWUuPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBs
YW5nPSJFTi1HQiI+Jmd0OyBCb2I8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29Q
bGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IEZyb206IDxhIGhyZWY9Im1haWx0bzpk
ZXZlbC1ib3VuY2VzQGFjcGljYS5vcmciPgo8c3BhbiBzdHlsZT0iY29sb3I6d2luZG93dGV4dDt0
ZXh0LWRlY29yYXRpb246bm9uZSI+ZGV2ZWwtYm91bmNlc0BhY3BpY2Eub3JnPC9zcGFuPjwvYT4g
WzxhIGhyZWY9Im1haWx0bzpkZXZlbC1ib3VuY2VzQGFjcGljYS5vcmciPjxzcGFuIHN0eWxlPSJj
b2xvcjp3aW5kb3d0ZXh0O3RleHQtZGVjb3JhdGlvbjpub25lIj5tYWlsdG86ZGV2ZWwtYm91bmNl
c0BhY3BpY2Eub3JnPC9zcGFuPjwvYT5dIE9uIEJlaGFsZjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4K
PHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgT2YgTW9vcmUs
IFJvYmVydDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNw
YW4gbGFuZz0iRU4tR0IiPiZndDsgU2VudDogV2VkbmVzZGF5LCBNYXkgMTUsIDIwMTMgMTA6MzMg
QU08bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxh
bmc9IkVOLUdCIj4mZ3Q7IFRvOiBBbGV4ZWkgRmVkb3JvdjsgPGEgaHJlZj0ibWFpbHRvOmRldmVs
QGFjcGljYS5vcmciPgo8c3BhbiBzdHlsZT0iY29sb3I6d2luZG93dGV4dDt0ZXh0LWRlY29yYXRp
b246bm9uZSI+ZGV2ZWxAYWNwaWNhLm9yZzwvc3Bhbj48L2E+PG86cD48L286cD48L3NwYW4+PC9w
Pgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBTdWJqZWN0
OiBSZTogW0RldmVsXSAtRCAmbHQ7c3ltYm9sJmd0OyBQcmVwcm9jZXNzb3IgT3B0aW9uIERvZXNu
J3QgV29yazxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNw
YW4gbGFuZz0iRU4tR0IiPiZndDsgPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNv
UGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBTb3JyeSwgd2UgZGlkIHNvbWUgY29k
ZSByZXN0cnVjdHVyaW5nIGFuZCBicm9rZSB0aGlzLiBZb3UgY2FuIGdvIGJhY2sgdG88bzpwPjwv
bzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdC
Ij4mZ3Q7IGFuIGVhcmxpZXIgdmVyc2lvbiBvZiB0aGUgY29tcGlsZXIsIG9yIHdhaXQgdW50aWwg
bGF0ZXIgdGhpcyB3ZWVrIHdoZW48bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29Q
bGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IHRoZXJlIHdpbGwgYmUgYSBuZXcgdmVy
c2lvbi48bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFu
IGxhbmc9IkVOLUdCIj4mZ3Q7IEJvYjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1z
b1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgRnJvbTogPGEgaHJlZj0ibWFpbHRv
OmRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZyUzY21haWx0bzpkZXZlbC1ib3VuY2VzQGFjcGljYS5v
cmciPgo8c3BhbiBzdHlsZT0iY29sb3I6d2luZG93dGV4dDt0ZXh0LWRlY29yYXRpb246bm9uZSI+
ZGV2ZWwtYm91bmNlc0BhY3BpY2Eub3JnJmx0O21haWx0bzpkZXZlbC1ib3VuY2VzQGFjcGljYS5v
cmc8L3NwYW4+PC9hPiZndDs8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFp
blRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IFs8YSBocmVmPSJtYWlsdG86ZGV2ZWwtYm91
bmNlc0BhY3BpY2Eub3JnIj48c3BhbiBzdHlsZT0iY29sb3I6d2luZG93dGV4dDt0ZXh0LWRlY29y
YXRpb246bm9uZSI+bWFpbHRvOmRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZzwvc3Bhbj48L2E+XSBP
biBCZWhhbGYgT2YgTW9vcmUsIFJvYmVydDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9
Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgU2VudDogV2VkbmVzZGF5LCBN
YXkgMTUsIDIwMTMgODo0MyBBTTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1Bs
YWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgVG86IEFsZXhlaSBGZWRvcm92OyA8YSBo
cmVmPSJtYWlsdG86ZGV2ZWxAYWNwaWNhLm9yZyUzY21haWx0bzpkZXZlbEBhY3BpY2Eub3JnIj4K
PHNwYW4gc3R5bGU9ImNvbG9yOndpbmRvd3RleHQ7dGV4dC1kZWNvcmF0aW9uOm5vbmUiPmRldmVs
QGFjcGljYS5vcmcmbHQ7bWFpbHRvOmRldmVsQGFjcGljYS5vcmc8L3NwYW4+PC9hPiZndDs8bzpw
PjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVO
LUdCIj4mZ3Q7IFN1YmplY3Q6IFJlOiBbRGV2ZWxdIC1EICZsdDtzeW1ib2wmZ3Q7IFByZXByb2Nl
c3NvciBPcHRpb24gRG9lc24ndCBXb3JrPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0i
TXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyA8bzpwPjwvbzpwPjwvc3Bhbj48
L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IFdlIHdp
bGwgY2hlY2sgaXQgb3V0LjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWlu
VGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgVGhhbmtzLDxvOnA+PC9vOnA+PC9zcGFuPjwv
cD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgQm9iPG86
cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJF
Ti1HQiI+Jmd0OyBGcm9tOiA8YSBocmVmPSJtYWlsdG86ZGV2ZWwtYm91bmNlc0BhY3BpY2Eub3Jn
JTNjbWFpbHRvOmRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZyI+CjxzcGFuIHN0eWxlPSJjb2xvcjp3
aW5kb3d0ZXh0O3RleHQtZGVjb3JhdGlvbjpub25lIj5kZXZlbC1ib3VuY2VzQGFjcGljYS5vcmcm
bHQ7bWFpbHRvOmRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZzwvc3Bhbj48L2E+Jmd0OzxvOnA+PC9v
OnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0Ii
PiZndDsgWzxhIGhyZWY9Im1haWx0bzpkZXZlbC1ib3VuY2VzQGFjcGljYS5vcmciPjxzcGFuIHN0
eWxlPSJjb2xvcjp3aW5kb3d0ZXh0O3RleHQtZGVjb3JhdGlvbjpub25lIj5tYWlsdG86ZGV2ZWwt
Ym91bmNlc0BhY3BpY2Eub3JnPC9zcGFuPjwvYT5dIE9uIEJlaGFsZiBPZiBBbGV4ZWkgRmVkb3Jv
djxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFu
Zz0iRU4tR0IiPiZndDsgU2VudDogVHVlc2RheSwgTWF5IDE0LCAyMDEzIDU6MjcgQU08bzpwPjwv
bzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdC
Ij4mZ3Q7IFRvOiA8YSBocmVmPSJtYWlsdG86ZGV2ZWxAYWNwaWNhLm9yZyUzY21haWx0bzpkZXZl
bEBhY3BpY2Eub3JnIj4KPHNwYW4gc3R5bGU9ImNvbG9yOndpbmRvd3RleHQ7dGV4dC1kZWNvcmF0
aW9uOm5vbmUiPmRldmVsQGFjcGljYS5vcmcmbHQ7bWFpbHRvOmRldmVsQGFjcGljYS5vcmc8L3Nw
YW4+PC9hPiZndDs8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQi
PjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IFN1YmplY3Q6IFtEZXZlbF0gLUQgJmx0O3N5bWJvbCZn
dDsgUHJlcHJvY2Vzc29yIE9wdGlvbiBEb2Vzbid0IFdvcms8bzpwPjwvbzpwPjwvc3Bhbj48L3A+
CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IDxvOnA+PC9v
OnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0Ii
PiZndDsgSGksPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48
c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyA8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJN
c29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IEFTTCBVc2VyIEd1aWRlIHN0YXRl
cyB0aGF0ICNpZmRlZiBzdGF0ZW1lbnRzIGFyZSByZWNvZ25pemVkIHdoZW4gYSBzeW1ib2w8bzpw
PjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVO
LUdCIj4mZ3Q7IGlzIGRlZmluZWQgaW4gdGhlIGNvbW1hbmQgbGluZTo8bzpwPjwvbzpwPjwvc3Bh
bj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IDxv
OnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0i
RU4tR0IiPiZndDsgJnF1b3Q7My4zLjIuMiAjaWZkZWY8bzpwPjwvbzpwPjwvc3Bhbj48L3A+Cjxw
IGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IFVzYWdlOjxvOnA+
PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4t
R0IiPiZndDsgI2lmZGVmIHN5bWJvbDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1z
b1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgQ29uZGl0aW9uYWxseSBjb21waWxl
IGEgYmxvY2sgb2YgdGV4dC4gVGhlIGJsb2NrIGlzIGluY2x1ZGVkIGluIHRoZTxvOnA+PC9vOnA+
PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZn
dDsgY29tcGlsYXRpb24gaWYgdGhlIHN5bWJvbCBpcyBkZWZpbmVkLCBlaXRoZXIgZnJvbSBhICNk
ZWZpbmUgb3IgZnJvbSB0aGUgLTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1Bs
YWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgRCBjb21tYW5kIGxpbmUgb3B0aW9uJnF1
b3Q7PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBs
YW5nPSJFTi1HQiI+Jmd0OyA8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFp
blRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IGJ1dCBJIGNhbm5vdCBtYWtlIEFTTCBDb21w
aWxlciB0byByZWNvZ25pemUgdGhlIGZvbGxvd2luZyBvcHRpb248bzpwPjwvbzpwPjwvc3Bhbj48
L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7Jm5ic3A7
Jm5ic3A7IC1EICZsdDtzeW1ib2wmZ3Q7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7IERlZmluZSBzeW1ib2wgZm9yIHByZXByb2Nlc3NvciB1c2U8bzpwPjwvbzpwPjwvc3Bhbj48
L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IDxvOnA+
PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4t
R0IiPiZndDsgSW4gdGhlIGV4YW1wbGUgYmVsb3c8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNs
YXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IDxvOnA+PC9vOnA+PC9z
cGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsg
RGVmaW5pdGlvbkJsb2NrKCZxdW90O0RTRFQuQU1MJnF1b3Q7LCAmcXVvdDtEU0RUJnF1b3Q7LCAw
eDAxLCAmcXVvdDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgJnF1b3Q7LCAmcXVvdDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgJnF1b3Q7LCAzKSB7PG86
cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJF
Ti1HQiI+Jmd0OyZuYnNwOyZuYnNwOyBTY29wZShfU0IpIHs8bzpwPjwvbzpwPjwvc3Bhbj48L3A+
CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7IERldmljZShDUFUwKSB7PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBj
bGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBOYW1lKF9ISUQsICZxdW90O0FDUEkwMDA3JnF1b3Q7KTxv
OnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0i
RU4tR0IiPiZndDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgTmFtZShfVUlE
LCBaZXJvKTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNw
YW4gbGFuZz0iRU4tR0IiPiZndDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgfTxvOnA+PC9vOnA+
PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZn
dDsgI2lmZGVmIENQVV8xPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5U
ZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBEZXZp
Y2UoQ1BVMSkgezxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+
PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgTmFtZShf
SElELCAmcXVvdDtBQ1BJMDAwNyZxdW90Oyk8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNz
PSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7IE5hbWUoX1VJRCwgT25lKTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9
Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsgfTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNw
YW4gbGFuZz0iRU4tR0IiPiZndDsgI2VuZGlmPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFz
cz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyZuYnNwOyZuYnNwOyB9PG86
cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJF
Ti1HQiI+Jmd0OyB9PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0
Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyA8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNz
PSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IFRoZSBzZWN0aW9uIGJldHdl
ZW4gI2lmZGVmIENQVV8xIC4uLiAjZW5kaWYgaXMgbm90IGJlaW5nIGNvbXBpbGVkIHdoZW4gQVNM
PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5n
PSJFTi1HQiI+Jmd0OyBpcyBpbnZva2VkIGFzOjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xh
c3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgaWFzbC5leGUgLWwgLUQg
Q1BVXzEgRHNkdC5hc2w8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRl
eHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IENoZWNrZWQgd2l0aCB0aGUgbGF0ZXN0IHZlcnNp
b24gMjAxMzA0MTgtMzIgW0FwciAxOCAyMDEzXS48bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNs
YXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IDxvOnA+PC9vOnA+PC9z
cGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsg
QW55IHRob3VnaHRzIG9uIHdoYXQgbWlnaHQgYmUgZ29pbmcgd3JvbmcgaGVyZT88bzpwPjwvbzpw
Pjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4m
Z3Q7IFRoYW5rcy48bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQi
PjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9
Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgPG86cD48L286cD48L3NwYW4+
PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyA8bzpw
PjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVO
LUdCIj4mZ3Q7IC0tIElNUE9SVEFOVCBOT1RJQ0U6IFRoZSBjb250ZW50cyBvZiB0aGlzIGVtYWls
IGFuZCBhbnkgYXR0YWNobWVudHMgYXJlPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0i
TXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBjb25maWRlbnRpYWwgYW5kIG1h
eSBhbHNvIGJlIHByaXZpbGVnZWQuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZDxvOnA+PC9v
OnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0Ii
PiZndDsgcmVjaXBpZW50LCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgYW5k
IGRvIG5vdCBkaXNjbG9zZSB0aGU8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29Q
bGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IGNvbnRlbnRzIHRvIGFueSBvdGhlciBw
ZXJzb24sIHVzZSBpdCBmb3IgYW55IHB1cnBvc2UsIG9yIHN0b3JlIG9yIGNvcHkgdGhlPG86cD48
L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1H
QiI+Jmd0OyBpbmZvcm1hdGlvbiBpbiBhbnkgbWVkaXVtLiBUaGFuayB5b3UuPG86cD48L286cD48
L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0
OyAtLS0tLS0tLS0tLS0tLSBuZXh0IHBhcnQgLS0tLS0tLS0tLS0tLS08bzpwPjwvbzpwPjwvc3Bh
bj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IEFu
IEhUTUwgYXR0YWNobWVudCB3YXMgc2NydWJiZWQuLi48bzpwPjwvbzpwPjwvc3Bhbj48L3A+Cjxw
IGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IFVSTDo8bzpwPjwv
bzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdC
Ij4mZ3Q7ICZsdDtodHRwOi8vbGlzdHMuYWNwaWNhLm9yZy9waXBlcm1haWwvZGV2ZWwvYXR0YWNo
bWVudHMvMjAxMzA1MTYvNmNjNjQ4Y2IvYXR0PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFz
cz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBhY2htZW50LTAwMDEuaHRt
bCZndDs8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFu
IGxhbmc9IkVOLUdCIj4mZ3Q7IDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1Bs
YWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3Bh
biBsYW5nPSJFTi1HQiI+Jmd0OyA8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29Q
bGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IE1lc3NhZ2U6IDI8bzpwPjwvbzpwPjwv
c3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7
IERhdGU6IFRodSwgMTYgTWF5IDIwMTMgMTc6MTI6NDQgJiM0MzswMDAwPG86cD48L286cD48L3Nw
YW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBG
cm9tOiAmcXVvdDtNb29yZSwgUm9iZXJ0JnF1b3Q7ICZsdDs8YSBocmVmPSJtYWlsdG86cm9iZXJ0
Lm1vb3JlQGludGVsLmNvbSI+PHNwYW4gc3R5bGU9ImNvbG9yOndpbmRvd3RleHQ7dGV4dC1kZWNv
cmF0aW9uOm5vbmUiPnJvYmVydC5tb29yZUBpbnRlbC5jb208L3NwYW4+PC9hPiZndDs8bzpwPjwv
bzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdC
Ij4mZ3Q7IFRvOiBBbGV4ZWkgRmVkb3JvdiAmbHQ7PGEgaHJlZj0ibWFpbHRvOkFsZXhlaS5GZWRv
cm92QGFybS5jb20iPjxzcGFuIHN0eWxlPSJjb2xvcjp3aW5kb3d0ZXh0O3RleHQtZGVjb3JhdGlv
bjpub25lIj5BbGV4ZWkuRmVkb3JvdkBhcm0uY29tPC9zcGFuPjwvYT4mZ3Q7LCAmcXVvdDs8YSBo
cmVmPSJtYWlsdG86ZGV2ZWxAYWNwaWNhLm9yZyI+PHNwYW4gc3R5bGU9ImNvbG9yOndpbmRvd3Rl
eHQ7dGV4dC1kZWNvcmF0aW9uOm5vbmUiPmRldmVsQGFjcGljYS5vcmc8L3NwYW4+PC9hPiZxdW90
OzxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFu
Zz0iRU4tR0IiPiZndDsmbmJzcDsmbmJzcDsgJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jmx0OzxhIGhyZWY9Im1haWx0bzpkZXZlbEBhY3BpY2Eub3JnIj48c3BhbiBzdHlsZT0i
Y29sb3I6d2luZG93dGV4dDt0ZXh0LWRlY29yYXRpb246bm9uZSI+ZGV2ZWxAYWNwaWNhLm9yZzwv
c3Bhbj48L2E+Jmd0OzxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4
dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgU3ViamVjdDogUmU6IFtEZXZlbF0gLUQgJmx0O3N5
bWJvbCZndDsgUHJlcHJvY2Vzc29yIE9wdGlvbiBEb2Vzbid0IFdvcms8bzpwPjwvbzpwPjwvc3Bh
bj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IE1l
c3NhZ2UtSUQ6PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48
c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyA8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJN
c29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7ICZsdDs8YSBocmVmPSJtYWlsdG86
OTRGMkZCQUI0NDMyQjU0RThBQUNDN0RGREU2QzkyRTM2RkU2QzNCNUBPUlNNU1gxMDMuYW1yLmNv
cnAuaW50ZWwuY29tIj48c3BhbiBzdHlsZT0iY29sb3I6d2luZG93dGV4dDt0ZXh0LWRlY29yYXRp
b246bm9uZSI+OTRGMkZCQUI0NDMyQjU0RThBQUNDN0RGREU2QzkyRTM2RkU2QzNCNUBPUlNNU1gx
MDMuYW1yLmNvcnAuaW50ZWwuY29tPC9zcGFuPjwvYT4mZ3Q7PG86cD48L286cD48L3NwYW4+PC9w
Pgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyA8bzpwPjwv
bzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdC
Ij4mZ3Q7IENvbnRlbnQtVHlwZTogdGV4dC9wbGFpbjsgY2hhcnNldD0mcXVvdDt1cy1hc2NpaSZx
dW90OzxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4g
bGFuZz0iRU4tR0IiPiZndDsgPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxh
aW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBZZXMsIGl0IGxvb2tzIGxpa2UgaXQgaGFz
IGJlZW4gdGhlcmUgYSB3aGlsZS48bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29Q
bGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IFlvdSBjYW4gY2hlY2tvdXQgdGhlIHBh
dGNoLCBvciBJIGNhbiBzZW5kIHlvdSBhbiB1cGRhdGVkIHdpbmRvd3MgYmluYXJ5LjxvOnA+PC9v
OnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0Ii
PiZndDsgPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3Bh
biBsYW5nPSJFTi1HQiI+Jmd0OyA8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29Q
bGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IEZyb206IEFsZXhlaSBGZWRvcm92IFs8
YSBocmVmPSJtYWlsdG86QWxleGVpLkZlZG9yb3ZAYXJtLmNvbSI+PHNwYW4gc3R5bGU9ImNvbG9y
OndpbmRvd3RleHQ7dGV4dC1kZWNvcmF0aW9uOm5vbmUiPm1haWx0bzpBbGV4ZWkuRmVkb3JvdkBh
cm0uY29tPC9zcGFuPjwvYT5dPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxh
aW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBTZW50OiBUaHVyc2RheSwgTWF5IDE2LCAy
MDEzIDM6MTcgQU08bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQi
PjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IFRvOiBNb29yZSwgUm9iZXJ0OyA8YSBocmVmPSJtYWls
dG86ZGV2ZWxAYWNwaWNhLm9yZyI+CjxzcGFuIHN0eWxlPSJjb2xvcjp3aW5kb3d0ZXh0O3RleHQt
ZGVjb3JhdGlvbjpub25lIj5kZXZlbEBhY3BpY2Eub3JnPC9zcGFuPjwvYT48bzpwPjwvbzpwPjwv
c3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7
IFN1YmplY3Q6IFJFOiAtRCAmbHQ7c3ltYm9sJmd0OyBQcmVwcm9jZXNzb3IgT3B0aW9uIERvZXNu
J3QgV29yazxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNw
YW4gbGFuZz0iRU4tR0IiPiZndDsgPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNv
UGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBIaSBSb2JlcnQsPG86cD48L286cD48
L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0
OyBJIHRyaWVkIHRoYXQgd2l0aCA0IHByZXZpb3VzIHZlcnNpb25zIG9mIGNvbXBpbGVyICZhbXA7
IHN0aWxsIGdvdCB0aGUgc2FtZTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1Bs
YWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgaXNzdWUuPG86cD48L286cD48L3NwYW4+
PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBSZWdh
cmRzLjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4g
bGFuZz0iRU4tR0IiPiZndDsgQWxleGVpLjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9
Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgPG86cD48L286cD48L3NwYW4+
PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBGcm9t
OiBNb29yZSwgUm9iZXJ0IFs8YSBocmVmPSJtYWlsdG86cm9iZXJ0Lm1vb3JlQGludGVsLmNvbSI+
PHNwYW4gc3R5bGU9ImNvbG9yOndpbmRvd3RleHQ7dGV4dC1kZWNvcmF0aW9uOm5vbmUiPm1haWx0
bzpyb2JlcnQubW9vcmVAaW50ZWwuY29tPC9zcGFuPjwvYT5dPG86cD48L286cD48L3NwYW4+PC9w
Pgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBTZW50OiAx
NSBNYXkgMjAxMyAxODozMzxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWlu
VGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgVG86IEFsZXhlaSBGZWRvcm92OyA8YSBocmVm
PSJtYWlsdG86ZGV2ZWxAYWNwaWNhLm9yZyUzY21haWx0bzpkZXZlbEBhY3BpY2Eub3JnIj4KPHNw
YW4gc3R5bGU9ImNvbG9yOndpbmRvd3RleHQ7dGV4dC1kZWNvcmF0aW9uOm5vbmUiPmRldmVsQGFj
cGljYS5vcmcmbHQ7bWFpbHRvOmRldmVsQGFjcGljYS5vcmc8L3NwYW4+PC9hPiZndDs8bzpwPjwv
bzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdC
Ij4mZ3Q7IFN1YmplY3Q6IFJFOiAtRCAmbHQ7c3ltYm9sJmd0OyBQcmVwcm9jZXNzb3IgT3B0aW9u
IERvZXNuJ3QgV29yazxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4
dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFz
cz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBTb3JyeSwgd2UgZGlkIHNv
bWUgY29kZSByZXN0cnVjdHVyaW5nIGFuZCBicm9rZSB0aGlzLiBZb3UgY2FuIGdvIGJhY2sgdG88
bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9
IkVOLUdCIj4mZ3Q7IGFuIGVhcmxpZXIgdmVyc2lvbiBvZiB0aGUgY29tcGlsZXIsIG9yIHdhaXQg
dW50aWwgbGF0ZXIgdGhpcyB3ZWVrIHdoZW48bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNz
PSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IHRoZXJlIHdpbGwgYmUgYSBu
ZXcgdmVyc2lvbi48bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQi
PjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IEJvYjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xh
c3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgRnJvbTogPGEgaHJlZj0i
bWFpbHRvOmRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZyUzY21haWx0bzpkZXZlbC1ib3VuY2VzQGFj
cGljYS5vcmciPgo8c3BhbiBzdHlsZT0iY29sb3I6d2luZG93dGV4dDt0ZXh0LWRlY29yYXRpb246
bm9uZSI+ZGV2ZWwtYm91bmNlc0BhY3BpY2Eub3JnJmx0O21haWx0bzpkZXZlbC1ib3VuY2VzQGFj
cGljYS5vcmc8L3NwYW4+PC9hPiZndDs8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJN
c29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IFs8YSBocmVmPSJtYWlsdG86ZGV2
ZWwtYm91bmNlc0BhY3BpY2Eub3JnIj48c3BhbiBzdHlsZT0iY29sb3I6d2luZG93dGV4dDt0ZXh0
LWRlY29yYXRpb246bm9uZSI+bWFpbHRvOmRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZzwvc3Bhbj48
L2E+XSBPbiBCZWhhbGYgT2YgTW9vcmUsIFJvYmVydDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAg
Y2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgU2VudDogV2VkbmVz
ZGF5LCBNYXkgMTUsIDIwMTMgODo0MyBBTTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9
Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgVG86IEFsZXhlaSBGZWRvcm92
OyA8YSBocmVmPSJtYWlsdG86ZGV2ZWxAYWNwaWNhLm9yZyUzY21haWx0bzpkZXZlbEBhY3BpY2Eu
b3JnIj4KPHNwYW4gc3R5bGU9ImNvbG9yOndpbmRvd3RleHQ7dGV4dC1kZWNvcmF0aW9uOm5vbmUi
PmRldmVsQGFjcGljYS5vcmcmbHQ7bWFpbHRvOmRldmVsQGFjcGljYS5vcmc8L3NwYW4+PC9hPiZn
dDs8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxh
bmc9IkVOLUdCIj4mZ3Q7IFN1YmplY3Q6IFJlOiBbRGV2ZWxdIC1EICZsdDtzeW1ib2wmZ3Q7IFBy
ZXByb2Nlc3NvciBPcHRpb24gRG9lc24ndCBXb3JrPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBj
bGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyA8bzpwPjwvbzpwPjwv
c3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7
IFdlIHdpbGwgY2hlY2sgaXQgb3V0LjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1z
b1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgVGhhbmtzLDxvOnA+PC9vOnA+PC9z
cGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsg
Qm9iPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBs
YW5nPSJFTi1HQiI+Jmd0OyBGcm9tOiA8YSBocmVmPSJtYWlsdG86ZGV2ZWwtYm91bmNlc0BhY3Bp
Y2Eub3JnJTNjbWFpbHRvOmRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZyI+CjxzcGFuIHN0eWxlPSJj
b2xvcjp3aW5kb3d0ZXh0O3RleHQtZGVjb3JhdGlvbjpub25lIj5kZXZlbC1ib3VuY2VzQGFjcGlj
YS5vcmcmbHQ7bWFpbHRvOmRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZzwvc3Bhbj48L2E+Jmd0Ozxv
OnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0i
RU4tR0IiPiZndDsgWzxhIGhyZWY9Im1haWx0bzpkZXZlbC1ib3VuY2VzQGFjcGljYS5vcmciPjxz
cGFuIHN0eWxlPSJjb2xvcjp3aW5kb3d0ZXh0O3RleHQtZGVjb3JhdGlvbjpub25lIj5tYWlsdG86
ZGV2ZWwtYm91bmNlc0BhY3BpY2Eub3JnPC9zcGFuPjwvYT5dIE9uIEJlaGFsZiBPZiBBbGV4ZWkg
RmVkb3JvdjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNw
YW4gbGFuZz0iRU4tR0IiPiZndDsgU2VudDogVHVlc2RheSwgTWF5IDE0LCAyMDEzIDU6MjcgQU08
bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9
IkVOLUdCIj4mZ3Q7IFRvOiA8YSBocmVmPSJtYWlsdG86ZGV2ZWxAYWNwaWNhLm9yZyUzY21haWx0
bzpkZXZlbEBhY3BpY2Eub3JnIj4KPHNwYW4gc3R5bGU9ImNvbG9yOndpbmRvd3RleHQ7dGV4dC1k
ZWNvcmF0aW9uOm5vbmUiPmRldmVsQGFjcGljYS5vcmcmbHQ7bWFpbHRvOmRldmVsQGFjcGljYS5v
cmc8L3NwYW4+PC9hPiZndDs8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFp
blRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IFN1YmplY3Q6IFtEZXZlbF0gLUQgJmx0O3N5
bWJvbCZndDsgUHJlcHJvY2Vzc29yIE9wdGlvbiBEb2Vzbid0IFdvcms8bzpwPjwvbzpwPjwvc3Bh
bj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IDxv
OnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0i
RU4tR0IiPiZndDsgSGksPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5U
ZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyA8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNs
YXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IEFTTCBVc2VyIEd1aWRl
IHN0YXRlcyB0aGF0ICNpZmRlZiBzdGF0ZW1lbnRzIGFyZSByZWNvZ25pemVkIHdoZW4gYSBzeW1i
b2w8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxh
bmc9IkVOLUdCIj4mZ3Q7IGlzIGRlZmluZWQgaW4gdGhlIGNvbW1hbmQgbGluZTo8bzpwPjwvbzpw
Pjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4m
Z3Q7IDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4g
bGFuZz0iRU4tR0IiPiZndDsgJnF1b3Q7My4zLjIuMiAjaWZkZWY8bzpwPjwvbzpwPjwvc3Bhbj48
L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IFVzYWdl
OjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFu
Zz0iRU4tR0IiPiZndDsgI2lmZGVmIHN5bWJvbDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xh
c3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgQ29uZGl0aW9uYWxseSBj
b21waWxlIGEgYmxvY2sgb2YgdGV4dC4gVGhlIGJsb2NrIGlzIGluY2x1ZGVkIGluIHRoZTxvOnA+
PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4t
R0IiPiZndDsgY29tcGlsYXRpb24gaWYgdGhlIHN5bWJvbCBpcyBkZWZpbmVkLCBlaXRoZXIgZnJv
bSBhICNkZWZpbmUgb3IgZnJvbSB0aGUgLTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9
Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgRCBjb21tYW5kIGxpbmUgb3B0
aW9uJnF1b3Q7PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48
c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyA8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJN
c29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IGJ1dCBJIGNhbm5vdCBtYWtlIEFT
TCBDb21waWxlciB0byByZWNvZ25pemUgdGhlIGZvbGxvd2luZyBvcHRpb248bzpwPjwvbzpwPjwv
c3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7
Jm5ic3A7Jm5ic3A7IC1EICZsdDtzeW1ib2wmZ3Q7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7IERlZmluZSBzeW1ib2wgZm9yIHByZXByb2Nlc3NvciB1c2U8bzpwPjwvbzpwPjwv
c3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7
IDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFu
Zz0iRU4tR0IiPiZndDsgSW4gdGhlIGV4YW1wbGUgYmVsb3c8bzpwPjwvbzpwPjwvc3Bhbj48L3A+
CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IDxvOnA+PC9v
OnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0Ii
PiZndDsgRGVmaW5pdGlvbkJsb2NrKCZxdW90O0RTRFQuQU1MJnF1b3Q7LCAmcXVvdDtEU0RUJnF1
b3Q7LCAweDAxLCAmcXVvdDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgJnF1b3Q7LCAm
cXVvdDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgJnF1b3Q7LCAz
KSB7PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBs
YW5nPSJFTi1HQiI+Jmd0OyZuYnNwOyZuYnNwOyBTY29wZShfU0IpIHs8bzpwPjwvbzpwPjwvc3Bh
bj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IERldmljZShDUFUwKSB7PG86cD48L286cD48L3NwYW4+PC9w
Pgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBOYW1lKF9ISUQsICZxdW90O0FDUEkwMDA3JnF1
b3Q7KTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4g
bGFuZz0iRU4tR0IiPiZndDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgTmFt
ZShfVUlELCBaZXJvKTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4
dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgfTxvOnA+
PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4t
R0IiPiZndDsgI2lmZGVmIENQVV8xPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNv
UGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyBEZXZpY2UoQ1BVMSkgezxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWlu
VGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsg
TmFtZShfSElELCAmcXVvdDtBQ1BJMDAwNyZxdW90Oyk8bzpwPjwvbzpwPjwvc3Bhbj48L3A+Cjxw
IGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7IE5hbWUoX1VJRCwgT25lKTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAg
Y2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsgfTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4
dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgI2VuZGlmPG86cD48L286cD48L3NwYW4+PC9wPgo8
cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyZuYnNwOyZuYnNw
OyB9PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBs
YW5nPSJFTi1HQiI+Jmd0OyB9PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxh
aW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyA8bzpwPjwvbzpwPjwvc3Bhbj48L3A+Cjxw
IGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IFRoZSBzZWN0aW9u
IGJldHdlZW4gI2lmZGVmIENQVV8xIC4uLiAjZW5kaWYgaXMgbm90IGJlaW5nIGNvbXBpbGVkIHdo
ZW4gQVNMPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3Bh
biBsYW5nPSJFTi1HQiI+Jmd0OyBpcyBpbnZva2VkIGFzOjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4K
PHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgaWFzbC5leGUg
LWwgLUQgQ1BVXzEgRHNkdC5hc2w8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29Q
bGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IENoZWNrZWQgd2l0aCB0aGUgbGF0ZXN0
IHZlcnNpb24gMjAxMzA0MTgtMzIgW0FwciAxOCAyMDEzXS48bzpwPjwvbzpwPjwvc3Bhbj48L3A+
CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IDxvOnA+PC9v
OnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0Ii
PiZndDsgQW55IHRob3VnaHRzIG9uIHdoYXQgbWlnaHQgYmUgZ29pbmcgd3JvbmcgaGVyZT88bzpw
PjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVO
LUdCIj4mZ3Q7IFRoYW5rcy48bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFp
blRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAg
Y2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgPG86cD48L286cD48
L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0
OyA8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxh
bmc9IkVOLUdCIj4mZ3Q7IC0tIElNUE9SVEFOVCBOT1RJQ0U6IFRoZSBjb250ZW50cyBvZiB0aGlz
IGVtYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgYXJlPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBj
bGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBjb25maWRlbnRpYWwg
YW5kIG1heSBhbHNvIGJlIHByaXZpbGVnZWQuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZDxv
OnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0i
RU4tR0IiPiZndDsgcmVjaXBpZW50LCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRl
bHkgYW5kIGRvIG5vdCBkaXNjbG9zZSB0aGU8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNz
PSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IGNvbnRlbnRzIHRvIGFueSBv
dGhlciBwZXJzb24sIHVzZSBpdCBmb3IgYW55IHB1cnBvc2UsIG9yIHN0b3JlIG9yIGNvcHkgdGhl
PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5n
PSJFTi1HQiI+Jmd0OyBpbmZvcm1hdGlvbiBpbiBhbnkgbWVkaXVtLiBUaGFuayB5b3UuPG86cD48
L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1H
QiI+Jmd0OyA8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxz
cGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IC0tIElNUE9SVEFOVCBOT1RJQ0U6IFRoZSBjb250ZW50cyBv
ZiB0aGlzIGVtYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgYXJlPG86cD48L286cD48L3NwYW4+PC9w
Pgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBjb25maWRl
bnRpYWwgYW5kIG1heSBhbHNvIGJlIHByaXZpbGVnZWQuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRl
bmRlZDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4g
bGFuZz0iRU4tR0IiPiZndDsgcmVjaXBpZW50LCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1t
ZWRpYXRlbHkgYW5kIGRvIG5vdCBkaXNjbG9zZSB0aGU8bzpwPjwvbzpwPjwvc3Bhbj48L3A+Cjxw
IGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IGNvbnRlbnRzIHRv
IGFueSBvdGhlciBwZXJzb24sIHVzZSBpdCBmb3IgYW55IHB1cnBvc2UsIG9yIHN0b3JlIG9yIGNv
cHkgdGhlPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3Bh
biBsYW5nPSJFTi1HQiI+Jmd0OyBpbmZvcm1hdGlvbiBpbiBhbnkgbWVkaXVtLiBUaGFuayB5b3Uu
PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5n
PSJFTi1HQiI+Jmd0OyAtLS0tLS0tLS0tLS0tLSBuZXh0IHBhcnQgLS0tLS0tLS0tLS0tLS08bzpw
PjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVO
LUdCIj4mZ3Q7IEFuIEhUTUwgYXR0YWNobWVudCB3YXMgc2NydWJiZWQuLi48bzpwPjwvbzpwPjwv
c3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7
IFVSTDo8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFu
IGxhbmc9IkVOLUdCIj4mZ3Q7ICZsdDtodHRwOi8vbGlzdHMuYWNwaWNhLm9yZy9waXBlcm1haWwv
ZGV2ZWwvYXR0YWNobWVudHMvMjAxMzA1MTYvZWI4YTQ5NmEvYXR0PG86cD48L286cD48L3NwYW4+
PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBhY2ht
ZW50Lmh0bWwmZ3Q7PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0
Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyA8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNz
PSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4
dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFz
cz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXzxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAg
Y2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgRGV2ZWwgbWFpbGlu
ZyBsaXN0PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3Bh
biBsYW5nPSJFTi1HQiI+Jmd0OyA8YSBocmVmPSJtYWlsdG86RGV2ZWxAYWNwaWNhLm9yZyI+PHNw
YW4gc3R5bGU9ImNvbG9yOndpbmRvd3RleHQ7dGV4dC1kZWNvcmF0aW9uOm5vbmUiPkRldmVsQGFj
cGljYS5vcmc8L3NwYW4+PC9hPjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1Bs
YWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgPGEgaHJlZj0iaHR0cHM6Ly9saXN0cy5h
Y3BpY2Eub3JnL21haWxtYW4vbGlzdGluZm8vZGV2ZWwiPgo8c3BhbiBzdHlsZT0iY29sb3I6d2lu
ZG93dGV4dDt0ZXh0LWRlY29yYXRpb246bm9uZSI+aHR0cHM6Ly9saXN0cy5hY3BpY2Eub3JnL21h
aWxtYW4vbGlzdGluZm8vZGV2ZWw8L3NwYW4+PC9hPjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAg
Y2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgPG86cD48L286cD48
L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0
OyBFbmQgb2YgRGV2ZWwgRGlnZXN0LCBWb2wgMzgsIElzc3VlIDU8bzpwPjwvbzpwPjwvc3Bhbj48
L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7ICoqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAg
Y2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgPG86cD48L286cD48
L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0
OyA8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxh
bmc9IkVOLUdCIj4mZ3Q7IC0tIElNUE9SVEFOVCBOT1RJQ0U6IFRoZSBjb250ZW50cyBvZiB0aGlz
IGVtYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgYXJlPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBj
bGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBjb25maWRlbnRpYWwg
YW5kIG1heSBhbHNvIGJlIHByaXZpbGVnZWQuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZDxv
OnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0i
RU4tR0IiPiZndDsgcmVjaXBpZW50LCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRl
bHkgYW5kIGRvIG5vdCBkaXNjbG9zZSB0aGU8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNz
PSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IGNvbnRlbnRzIHRvIGFueSBv
dGhlciBwZXJzb24sIHVzZSBpdCBmb3IgYW55IHB1cnBvc2UsIG9yIHN0b3JlIG9yIGNvcHkgdGhl
PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5n
PSJFTi1HQiI+Jmd0OyBpbmZvcm1hdGlvbiBpbiBhbnkgbWVkaXVtLiZuYnNwOyBUaGFuayB5b3Uu
PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5n
PSJFTi1HQiI+Jmd0OyA8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRl
eHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxh
aW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBEZXZlbCBtYWlsaW5nIGxpc3Q8bzpwPjwv
bzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdC
Ij4mZ3Q7IDxhIGhyZWY9Im1haWx0bzpEZXZlbEBhY3BpY2Eub3JnIj48c3BhbiBzdHlsZT0iY29s
b3I6d2luZG93dGV4dDt0ZXh0LWRlY29yYXRpb246bm9uZSI+RGV2ZWxAYWNwaWNhLm9yZzwvc3Bh
bj48L2E+PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3Bh
biBsYW5nPSJFTi1HQiI+Jmd0OyA8YSBocmVmPSJodHRwczovL2xpc3RzLmFjcGljYS5vcmcvbWFp
bG1hbi9saXN0aW5mby9kZXZlbCI+CjxzcGFuIHN0eWxlPSJjb2xvcjp3aW5kb3d0ZXh0O3RleHQt
ZGVjb3JhdGlvbjpub25lIj5odHRwczovL2xpc3RzLmFjcGljYS5vcmcvbWFpbG1hbi9saXN0aW5m
by9kZXZlbDwvc3Bhbj48L2E+PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxh
aW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+PG86cD4mbmJzcDs8L286cD48L3NwYW4+PC9wPgo8
cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0ibWFyZ2luOjBpbjttYXJnaW4tYm90dG9tOi4wMDAx
cHQiPjxzcGFuIGxhbmc9IkVOLUdCIiBzdHlsZT0iZm9udC1zaXplOjEyLjBwdDtmb250LWZhbWls
eTomcXVvdDtUaW1lcyBOZXcgUm9tYW4mcXVvdDssJnF1b3Q7c2VyaWYmcXVvdDsiPjxicj4KPC9z
cGFuPjxzcGFuIGxhbmc9IkVOLUdCIiBzdHlsZT0iZm9udC1zaXplOjEwLjBwdDtmb250LWZhbWls
eTomcXVvdDtBcmlhbCZxdW90OywmcXVvdDtzYW5zLXNlcmlmJnF1b3Q7O2NvbG9yOmJsYWNrIj4t
LSBJTVBPUlRBTlQgTk9USUNFOiBUaGUgY29udGVudHMgb2YgdGhpcyBlbWFpbCBhbmQgYW55IGF0
dGFjaG1lbnRzIGFyZSBjb25maWRlbnRpYWwgYW5kIG1heSBhbHNvIGJlIHByaXZpbGVnZWQuIElm
IHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHBsZWFzZSBub3RpZnkKIHRoZSBz
ZW5kZXIgaW1tZWRpYXRlbHkgYW5kIGRvIG5vdCBkaXNjbG9zZSB0aGUgY29udGVudHMgdG8gYW55
IG90aGVyIHBlcnNvbiwgdXNlIGl0IGZvciBhbnkgcHVycG9zZSwgb3Igc3RvcmUgb3IgY29weSB0
aGUgaW5mb3JtYXRpb24gaW4gYW55IG1lZGl1bS4gVGhhbmsgeW91Ljwvc3Bhbj48c3BhbiBsYW5n
PSJFTi1HQiIgc3R5bGU9ImZvbnQtc2l6ZToxMi4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7VGltZXMg
TmV3IFJvbWFuJnF1b3Q7LCZxdW90O3NlcmlmJnF1b3Q7Ij48bzpwPjwvbzpwPjwvc3Bhbj48L3A+
CjwvZGl2Pgo8L2Rpdj4KPC9kaXY+CjwvYm9keT4KPC9odG1sPgo=

--===============2856808320926687098==--

