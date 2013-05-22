Content-Type: multipart/mixed; boundary="===============4005334547907234065=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] -D <symbol> Preprocessor Option Doesn't Work
Date: Wed, 22 May 2013 13:51:06 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E36FE77E2A@ORSMSX103.amr.corp.intel.com>
In-Reply-To: 20E136AF98049A48A90A7417B4343D5E32BC716F11@BUNGLE.Emea.Arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4005334547907234065==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It should, but I will check out your code.


From: Alexei Fedorov [mailto:Alexei.Fedorov(a)arm.com]
Sent: Wednesday, May 22, 2013 5:46 AM
To: Moore, Robert
Cc: devel(a)acpica.org
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

--===============4005334547907234065==
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
CnNwYW4uRW1haWxTdHlsZTIxCgl7bXNvLXN0eWxlLXR5cGU6cGVyc29uYWwtcmVwbHk7Cglmb250
LWZhbWlseToiQ2FsaWJyaSIsInNhbnMtc2VyaWYiOwoJY29sb3I6IzFGNDk3RDt9Ci5Nc29DaHBE
ZWZhdWx0Cgl7bXNvLXN0eWxlLXR5cGU6ZXhwb3J0LW9ubHk7Cglmb250LXNpemU6MTAuMHB0O30K
QHBhZ2UgV29yZFNlY3Rpb24xCgl7c2l6ZTo4LjVpbiAxMS4waW47CgltYXJnaW46MS4waW4gMS4w
aW4gMS4waW4gMS4waW47fQpkaXYuV29yZFNlY3Rpb24xCgl7cGFnZTpXb3JkU2VjdGlvbjE7fQot
LT48L3N0eWxlPjwhLS1baWYgZ3RlIG1zbyA5XT48eG1sPgo8bzpzaGFwZWRlZmF1bHRzIHY6ZXh0
PSJlZGl0IiBzcGlkbWF4PSIxMDI2IiAvPgo8L3htbD48IVtlbmRpZl0tLT48IS0tW2lmIGd0ZSBt
c28gOV0+PHhtbD4KPG86c2hhcGVsYXlvdXQgdjpleHQ9ImVkaXQiPgo8bzppZG1hcCB2OmV4dD0i
ZWRpdCIgZGF0YT0iMSIgLz4KPC9vOnNoYXBlbGF5b3V0PjwveG1sPjwhW2VuZGlmXS0tPgo8L2hl
YWQ+Cjxib2R5IGxhbmc9IkVOLVVTIiBsaW5rPSJibHVlIiB2bGluaz0icHVycGxlIj4KPGRpdiBj
bGFzcz0iV29yZFNlY3Rpb24xIj4KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNv
bG9yOiMxRjQ5N0QiPkl0IHNob3VsZCwgYnV0IEkgd2lsbCBjaGVjayBvdXQgeW91ciBjb2RlLjxv
OnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNv
bG9yOiMxRjQ5N0QiPjxvOnA+Jm5ic3A7PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb05v
cm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxRjQ5N0QiPjxvOnA+Jm5ic3A7PC9vOnA+PC9zcGFu
PjwvcD4KPGRpdiBzdHlsZT0iYm9yZGVyOm5vbmU7Ym9yZGVyLWxlZnQ6c29saWQgYmx1ZSAxLjVw
dDtwYWRkaW5nOjBpbiAwaW4gMGluIDQuMHB0Ij4KPGRpdj4KPGRpdiBzdHlsZT0iYm9yZGVyOm5v
bmU7Ym9yZGVyLXRvcDpzb2xpZCAjQjVDNERGIDEuMHB0O3BhZGRpbmc6My4wcHQgMGluIDBpbiAw
aW4iPgo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0ibWFyZ2luOjBpbjttYXJnaW4tYm90dG9t
Oi4wMDAxcHQiPjxiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTAuMHB0O2ZvbnQtZmFtaWx5OiZx
dW90O1RhaG9tYSZxdW90OywmcXVvdDtzYW5zLXNlcmlmJnF1b3Q7Ij5Gcm9tOjwvc3Bhbj48L2I+
PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMC4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7VGFob21hJnF1
b3Q7LCZxdW90O3NhbnMtc2VyaWYmcXVvdDsiPiBBbGV4ZWkgRmVkb3JvdiBbbWFpbHRvOkFsZXhl
aS5GZWRvcm92QGFybS5jb21dCjxicj4KPGI+U2VudDo8L2I+IFdlZG5lc2RheSwgTWF5IDIyLCAy
MDEzIDU6NDYgQU08YnI+CjxiPlRvOjwvYj4gTW9vcmUsIFJvYmVydDxicj4KPGI+Q2M6PC9iPiBk
ZXZlbEBhY3BpY2Eub3JnPGJyPgo8Yj5TdWJqZWN0OjwvYj4gUkU6IC1EICZsdDtzeW1ib2wmZ3Q7
IFByZXByb2Nlc3NvciBPcHRpb24gRG9lc24ndCBXb3JrPG86cD48L286cD48L3NwYW4+PC9wPgo8
L2Rpdj4KPC9kaXY+CjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxvOnA+Jm5ic3A7PC9vOnA+PC9wPgo8
cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+SGkgUm9iZXJ0LDxvOnA+
PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4t
R0IiPjxvOnA+Jm5ic3A7PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+
PHNwYW4gbGFuZz0iRU4tR0IiPkRvZXMgcHJlLXByb2Nlc3NvciBzdXBwb3J0IHRoZSBuZXN0ZWQg
I2lmICNlbHNlICNlbmRpZiBzdGF0ZW1lbnRzPzxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xh
c3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPjxvOnA+Jm5ic3A7PC9vOnA+PC9z
cGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPlRoaXMg
Y29kZTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4g
bGFuZz0iRU4tR0IiPjxvOnA+Jm5ic3A7PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1Bs
YWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPkRlZmluaXRpb25CbG9jaygmcXVvdDtEU0RULkFN
TCZxdW90OywgJnF1b3Q7RFNEVCZxdW90OywgMHgwMSwgJnF1b3Q7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7ICZxdW90OywgJnF1b3Q7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZxdW90OywgMykgezxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9
Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPjxvOnA+Jm5ic3A7PC9vOnA+PC9zcGFu
PjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZuYnNwOyAv
LzxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFu
Zz0iRU4tR0IiPiZuYnNwOyAvLyZuYnNwOyBTeXN0ZW0gQnVzPG86cD48L286cD48L3NwYW4+PC9w
Pgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jm5ic3A7IC8vPG86
cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJF
Ti1HQiI+Jm5ic3A7IFNjb3BlKF9TQikgezxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9
Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZuYnNwOyZuYnNwOyZuYnNwOyAvLyBD
UFVzPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBs
YW5nPSJFTi1HQiI+Jm5ic3A7Jm5ic3A7Jm5ic3A7IERldmljZShDUFUwKSB7PG86cD48L286cD48
L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IE5hbWUoX0hJRCwgJnF1b3Q7QUNQSTAwMDcmcXVv
dDspPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBs
YW5nPSJFTi1HQiI+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IE5hbWUoX1VJRCwgWmVy
byk8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxh
bmc9IkVOLUdCIj4mbmJzcDsmbmJzcDsmbmJzcDsgfTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAg
Y2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPjxvOnA+Jm5ic3A7PC9vOnA+
PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiNp
ZmRlZiBDUFVfMTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+
PHNwYW4gbGFuZz0iRU4tR0IiPiZuYnNwOyZuYnNwOyZuYnNwOyBEZXZpY2UoQ1BVMSkgezxvOnA+
PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4t
R0IiPiZuYnNwOyZuYnNwOyZuYnNwOyAmbmJzcDsgTmFtZShfSElELCAmcXVvdDtBQ1BJMDAwNyZx
dW90Oyk8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFu
IGxhbmc9IkVOLUdCIj4mbmJzcDsmbmJzcDsmbmJzcDsgJm5ic3A7IE5hbWUoX1VJRCwgT25lKTxv
OnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0i
RU4tR0IiPiZuYnNwOyZuYnNwOyZuYnNwOyB9PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFz
cz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+I2Vsc2U8bzpwPjwvbzpwPjwvc3Bh
bj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4jaWZkZWYg
Q1BVXzI8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFu
IGxhbmc9IkVOLUdCIj4mbmJzcDsmbmJzcDsmbmJzcDsgRGV2aWNlKENQVTIpIHs8bzpwPjwvbzpw
Pjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4m
bmJzcDsmbmJzcDsmbmJzcDsgJm5ic3A7IE5hbWUoX0hJRCwgJnF1b3Q7QUNQSTAwMDcmcXVvdDsp
PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5n
PSJFTi1HQiI+Jm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyBOYW1lKF9VSUQsIDIpPG86cD48L286
cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+
Jm5ic3A7Jm5ic3A7Jm5ic3A7IH08bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29Q
bGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4jZW5kaWY8bzpwPjwvbzpwPjwvc3Bhbj48L3A+
CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4jZW5kaWY8bzpwPjwv
bzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdC
Ij4mbmJzcDsmbmJzcDsgPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5U
ZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jm5ic3A7Jm5ic3A7fSAvLyBfU0I8bzpwPjwvbzpwPjwv
c3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj59PG86
cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJF
Ti1HQiI+V2hlbiBjb21wbGllZCB3aXRoPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0i
TXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+aWFzbC5leGUgLWwgLUQgQ1BVXzEgRHNk
dC5hc2w8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFu
IGxhbmc9IkVOLUdCIj5jYXVzZXMgdGhlIGVycm9ycyBiZWxvdzo8bzpwPjwvbzpwPjwvc3Bhbj48
L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj5JbnRlbCBBQ1BJ
IENvbXBvbmVudCBBcmNoaXRlY3R1cmU8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJN
c29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj5BU0wgT3B0aW1pemluZyBDb21waWxlciB2
ZXJzaW9uIDIwMTMwNTE3LTMyIFtNYXkgMTcgMjAxM108bzpwPjwvbzpwPjwvc3Bhbj48L3A+Cjxw
IGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj5Db3B5cmlnaHQgKGMpIDIw
MDAgLSAyMDEzIEludGVsIENvcnBvcmF0aW9uPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFz
cz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+PG86cD4mbmJzcDs8L286cD48L3Nw
YW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+RHNkdC5h
c2wmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgMzc6IC8vPG86cD48L286cD48L3NwYW4+PC9wPgo8
cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+RXJyb3ImbmJzcDsmbmJz
cDsmbmJzcDsgNjEyNiAtXiBzeW50YXggZXJyb3IsIHVuZXhwZWN0ZWQgJGVuZCwgZXhwZWN0aW5n
IFBBUlNFT1BfREVGSU5JVElPTkJMT0NLPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0i
TXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+PG86cD4mbmJzcDs8L286cD48L3NwYW4+
PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+RHNkdC5hc2wm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgMzE6ICNlbmRpZjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4K
PHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPkVycm9yJm5ic3A7Jm5i
c3A7Jm5ic3A7IDYxNDIgLSZuYnNwOyBeIE1pc21hdGNoZWQgI2VuZGlmIChQcmVwcm9jZXNzb3Ip
PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5n
PSJFTi1HQiI+PG86cD4mbmJzcDs8L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5U
ZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+QVNMIElucHV0OiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyBEc2R0LmFzbCAtIDM4IGxpbmVzLCAwIGJ5dGVzLCAwIGtleXdvcmRzPG86cD48L286cD48L3Nw
YW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+TGlzdGlu
ZyBGaWxlOiZuYnNwOyBEc2R0LmxzdCAtIDE5OSBieXRlczxvOnA+PC9vOnA+PC9zcGFuPjwvcD4K
PHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPjxvOnA+Jm5ic3A7PC9v
OnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0Ii
PkNvbXBpbGF0aW9uIGNvbXBsZXRlLiAyIEVycm9ycywgMCBXYXJuaW5ncywgMCBSZW1hcmtzLCAw
IE9wdGltaXphdGlvbnM8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRl
eHQiPjxzcGFuIGxhbmc9IkVOLUdCIj5Ec2R0LmkgKFByZXByb2Nlc3NvciBPdXRwdXQgZmlsZSkg
Q291bGQgbm90IGRlbGV0ZTogUGVybWlzc2lvbiBkZW5pZWQ8bzpwPjwvbzpwPjwvc3Bhbj48L3A+
CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj5Ec2R0LnNyYyAoU291
cmNlIE91dHB1dCBmaWxlKSBDb3VsZCBub3QgZGVsZXRlOiBQZXJtaXNzaW9uIGRlbmllZDxvOnA+
PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+LS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS08YnI+CkZyb206IE1vb3JlLCBSb2JlcnQgWzxhIGhyZWY9Im1haWx0bzpyb2Jl
cnQubW9vcmVAaW50ZWwuY29tIj5tYWlsdG86cm9iZXJ0Lm1vb3JlQGludGVsLmNvbTwvYT5dCjxi
cj4KU2VudDogMTcgTWF5IDIwMTMgMjI6MDg8YnI+ClRvOiBBbGV4ZWkgRmVkb3Jvdjxicj4KU3Vi
amVjdDogUkU6IC1EICZsdDtzeW1ib2wmZ3Q7IFByZXByb2Nlc3NvciBPcHRpb24gRG9lc24ndCBX
b3JrPHNwYW4gbGFuZz0iRU4tR0IiPjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1z
b1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPjxvOnA+Jm5ic3A7PC9vOnA+PC9zcGFuPjwv
cD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPldlIGRpZCBhIG5l
dyByZWxlYXNlIHRvZGF5LCBzbyB5b3UgY2FuIGp1c3QgZ3JhYiB0aGUgd2luZG93cyBiaW5hcnkg
ZnJvbSB0aGUgd2Vic2l0ZS48bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFp
blRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj5UaGUgZml4IGZvciAtRCBpcyBpbiB0aGUgcmVsZWFz
ZS48bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxh
bmc9IkVOLUdCIj48bzpwPiZuYnNwOzwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFp
blRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj5Cb2I8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNs
YXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj48bzpwPiZuYnNwOzwvbzpwPjwv
c3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj48bzpw
PiZuYnNwOzwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxh
bmc9IkVOLUdCIj4mZ3Q7IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tPG86cD48L286cD48L3Nw
YW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBG
cm9tOiA8YSBocmVmPSJtYWlsdG86ZGV2ZWwtYm91bmNlc0BhY3BpY2Eub3JnIj4KPHNwYW4gc3R5
bGU9ImNvbG9yOndpbmRvd3RleHQ7dGV4dC1kZWNvcmF0aW9uOm5vbmUiPmRldmVsLWJvdW5jZXNA
YWNwaWNhLm9yZzwvc3Bhbj48L2E+IFs8YSBocmVmPSJtYWlsdG86ZGV2ZWwtYm91bmNlc0BhY3Bp
Y2Eub3JnIj48c3BhbiBzdHlsZT0iY29sb3I6d2luZG93dGV4dDt0ZXh0LWRlY29yYXRpb246bm9u
ZSI+bWFpbHRvOmRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZzwvc3Bhbj48L2E+XSBPbiBCZWhhbGY8
bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9
IkVOLUdCIj4mZ3Q7IE9mIEFsZXhlaSBGZWRvcm92PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBj
bGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBTZW50OiBGcmlkYXks
IE1heSAxNywgMjAxMyAzOjE2IEFNPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNv
UGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBUbzogPGEgaHJlZj0ibWFpbHRvOmRl
dmVsQGFjcGljYS5vcmciPgo8c3BhbiBzdHlsZT0iY29sb3I6d2luZG93dGV4dDt0ZXh0LWRlY29y
YXRpb246bm9uZSI+ZGV2ZWxAYWNwaWNhLm9yZzwvc3Bhbj48L2E+PG86cD48L286cD48L3NwYW4+
PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBTdWJq
ZWN0OiBSZTogW0RldmVsXSAtRCAmbHQ7c3ltYm9sJmd0OyBQcmVwcm9jZXNzb3IgT3B0aW9uIERv
ZXNuJ3QgV29yazxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+
PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0i
TXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyAmZ3Q7WWVzLCBpdCBsb29rcyBs
aWtlIGl0IGhhcyBiZWVuIHRoZXJlIGEgd2hpbGUuPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBj
bGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyAmZ3Q7WW91IGNhbiBj
aGVja291dCB0aGUgcGF0Y2gsIG9yIEkgY2FuIHNlbmQgeW91IGFuIHVwZGF0ZWQgd2luZG93cyBi
aW5hcnkuPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3Bh
biBsYW5nPSJFTi1HQiI+Jmd0OyBIaSBSb2JlcnQsPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBj
bGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBQbGVhc2Ugc2VuZCBt
ZSBhbiB1cGRhdGVkIGJpbmFyeS48bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29Q
bGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IFRoYW5rcy48bzpwPjwvbzpwPjwvc3Bh
bj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0i
TXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBGcm9tOiA8YSBocmVmPSJtYWls
dG86ZGV2ZWwtYm91bmNlc0BhY3BpY2Eub3JnIj4KPHNwYW4gc3R5bGU9ImNvbG9yOndpbmRvd3Rl
eHQ7dGV4dC1kZWNvcmF0aW9uOm5vbmUiPmRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZzwvc3Bhbj48
L2E+IFs8YSBocmVmPSJtYWlsdG86ZGV2ZWwtYm91bmNlc0BhY3BpY2Eub3JnIj48c3BhbiBzdHls
ZT0iY29sb3I6d2luZG93dGV4dDt0ZXh0LWRlY29yYXRpb246bm9uZSI+bWFpbHRvOmRldmVsLWJv
dW5jZXNAYWNwaWNhLm9yZzwvc3Bhbj48L2E+XSBPbiBCZWhhbGY8bzpwPjwvbzpwPjwvc3Bhbj48
L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IE9mIDxh
IGhyZWY9Im1haWx0bzpkZXZlbC1yZXF1ZXN0QGFjcGljYS5vcmciPgo8c3BhbiBzdHlsZT0iY29s
b3I6d2luZG93dGV4dDt0ZXh0LWRlY29yYXRpb246bm9uZSI+ZGV2ZWwtcmVxdWVzdEBhY3BpY2Eu
b3JnPC9zcGFuPjwvYT48bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRl
eHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IFNlbnQ6IDE2IE1heSAyMDEzIDE4OjA5PG86cD48
L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1H
QiI+Jmd0OyBUbzogPGEgaHJlZj0ibWFpbHRvOmRldmVsQGFjcGljYS5vcmciPgo8c3BhbiBzdHls
ZT0iY29sb3I6d2luZG93dGV4dDt0ZXh0LWRlY29yYXRpb246bm9uZSI+ZGV2ZWxAYWNwaWNhLm9y
Zzwvc3Bhbj48L2E+PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0
Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBTdWJqZWN0OiBEZXZlbCBEaWdlc3QsIFZvbCAzOCwg
SXNzdWUgNTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNw
YW4gbGFuZz0iRU4tR0IiPiZndDsgPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNv
UGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBTZW5kIERldmVsIG1haWxpbmcgbGlz
dCBzdWJtaXNzaW9ucyB0bzxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWlu
VGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsgPGEgaHJlZj0ibWFpbHRvOmRldmVsQGFjcGljYS5vcmciPgo8
c3BhbiBzdHlsZT0iY29sb3I6d2luZG93dGV4dDt0ZXh0LWRlY29yYXRpb246bm9uZSI+ZGV2ZWxA
YWNwaWNhLm9yZzwvc3Bhbj48L2E+PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNv
UGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyA8bzpwPjwvbzpwPjwvc3Bhbj48L3A+
CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IFRvIHN1YnNj
cmliZSBvciB1bnN1YnNjcmliZSB2aWEgdGhlIFdvcmxkIFdpZGUgV2ViLCB2aXNpdDxvOnA+PC9v
OnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0Ii
PiZndDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgPGEg
aHJlZj0iaHR0cHM6Ly9saXN0cy5hY3BpY2Eub3JnL21haWxtYW4vbGlzdGluZm8vZGV2ZWwiPgo8
c3BhbiBzdHlsZT0iY29sb3I6d2luZG93dGV4dDt0ZXh0LWRlY29yYXRpb246bm9uZSI+aHR0cHM6
Ly9saXN0cy5hY3BpY2Eub3JnL21haWxtYW4vbGlzdGluZm8vZGV2ZWw8L3NwYW4+PC9hPjxvOnA+
PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4t
R0IiPiZndDsgb3IsIHZpYSBlbWFpbCwgc2VuZCBhIG1lc3NhZ2Ugd2l0aCBzdWJqZWN0IG9yIGJv
ZHkgJ2hlbHAnIHRvPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0
Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyA8YSBocmVmPSJtYWlsdG86ZGV2ZWwtcmVxdWVzdEBhY3BpY2Eub3Jn
Ij4KPHNwYW4gc3R5bGU9ImNvbG9yOndpbmRvd3RleHQ7dGV4dC1kZWNvcmF0aW9uOm5vbmUiPmRl
dmVsLXJlcXVlc3RAYWNwaWNhLm9yZzwvc3Bhbj48L2E+PG86cD48L286cD48L3NwYW4+PC9wPgo8
cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyA8bzpwPjwvbzpw
Pjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4m
Z3Q7IFlvdSBjYW4gcmVhY2ggdGhlIHBlcnNvbiBtYW5hZ2luZyB0aGUgbGlzdCBhdDxvOnA+PC9v
OnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0Ii
PiZndDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgPGEg
aHJlZj0ibWFpbHRvOmRldmVsLW93bmVyQGFjcGljYS5vcmciPgo8c3BhbiBzdHlsZT0iY29sb3I6
d2luZG93dGV4dDt0ZXh0LWRlY29yYXRpb246bm9uZSI+ZGV2ZWwtb3duZXJAYWNwaWNhLm9yZzwv
c3Bhbj48L2E+PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48
c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyA8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJN
c29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IFdoZW4gcmVwbHlpbmcsIHBsZWFz
ZSBlZGl0IHlvdXIgU3ViamVjdCBsaW5lIHNvIGl0IGlzIG1vcmUgc3BlY2lmaWMgdGhhbjxvOnA+
PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4t
R0IiPiZndDsgJnF1b3Q7UmU6IENvbnRlbnRzIG9mIERldmVsIGRpZ2VzdC4uLiZxdW90OzxvOnA+
PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4t
R0IiPiZndDsgPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48
c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyA8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJN
c29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IFRvZGF5J3MgVG9waWNzOjxvOnA+
PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4t
R0IiPiZndDsgPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48
c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyZuYnNwOyZuYnNwOyZuYnNwOyAxLiBSZTogLUQgJmx0O3N5
bWJvbCZndDsgUHJlcHJvY2Vzc29yIE9wdGlvbiBEb2Vzbid0IFdvcmsgKE1vb3JlLCBSb2JlcnQp
PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5n
PSJFTi1HQiI+Jmd0OyZuYnNwOyZuYnNwOyZuYnNwOyAyLiBSZTogLUQgJmx0O3N5bWJvbCZndDsg
UHJlcHJvY2Vzc29yIE9wdGlvbiBEb2Vzbid0IFdvcmsgKE1vb3JlLCBSb2JlcnQpPG86cD48L286
cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+
Jmd0OyA8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFu
IGxhbmc9IkVOLUdCIj4mZ3Q7IDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1Bs
YWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTxvOnA+PC9vOnA+
PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZn
dDsgPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBs
YW5nPSJFTi1HQiI+Jmd0OyBNZXNzYWdlOiAxPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFz
cz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBEYXRlOiBUaHUsIDE2IE1h
eSAyMDEzIDE1OjU5OjE3ICYjNDM7MDAwMDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9
Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgRnJvbTogJnF1b3Q7TW9vcmUs
IFJvYmVydCZxdW90OyAmbHQ7PGEgaHJlZj0ibWFpbHRvOnJvYmVydC5tb29yZUBpbnRlbC5jb20i
PjxzcGFuIHN0eWxlPSJjb2xvcjp3aW5kb3d0ZXh0O3RleHQtZGVjb3JhdGlvbjpub25lIj5yb2Jl
cnQubW9vcmVAaW50ZWwuY29tPC9zcGFuPjwvYT4mZ3Q7PG86cD48L286cD48L3NwYW4+PC9wPgo8
cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBUbzogQWxleGVp
IEZlZG9yb3YgJmx0OzxhIGhyZWY9Im1haWx0bzpBbGV4ZWkuRmVkb3JvdkBhcm0uY29tIj48c3Bh
biBzdHlsZT0iY29sb3I6d2luZG93dGV4dDt0ZXh0LWRlY29yYXRpb246bm9uZSI+QWxleGVpLkZl
ZG9yb3ZAYXJtLmNvbTwvc3Bhbj48L2E+Jmd0OywgJnF1b3Q7PGEgaHJlZj0ibWFpbHRvOmRldmVs
QGFjcGljYS5vcmciPjxzcGFuIHN0eWxlPSJjb2xvcjp3aW5kb3d0ZXh0O3RleHQtZGVjb3JhdGlv
bjpub25lIj5kZXZlbEBhY3BpY2Eub3JnPC9zcGFuPjwvYT4mcXVvdDs8bzpwPjwvbzpwPjwvc3Bh
bj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICZsdDs8YSBocmVm
PSJtYWlsdG86ZGV2ZWxAYWNwaWNhLm9yZyI+PHNwYW4gc3R5bGU9ImNvbG9yOndpbmRvd3RleHQ7
dGV4dC1kZWNvcmF0aW9uOm5vbmUiPmRldmVsQGFjcGljYS5vcmc8L3NwYW4+PC9hPiZndDs8bzpw
PjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVO
LUdCIj4mZ3Q7IFN1YmplY3Q6IFJlOiBbRGV2ZWxdIC1EICZsdDtzeW1ib2wmZ3Q7IFByZXByb2Nl
c3NvciBPcHRpb24gRG9lc24ndCBXb3JrPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0i
TXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBNZXNzYWdlLUlEOjxvOnA+PC9v
OnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0Ii
PiZndDsgPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3Bh
biBsYW5nPSJFTi1HQiI+Jmd0OyAmbHQ7PGEgaHJlZj0ibWFpbHRvOjk0RjJGQkFCNDQzMkI1NEU4
QUFDQzdERkRFNkM5MkUzNkZFNkMzMjFAT1JTTVNYMTAzLmFtci5jb3JwLmludGVsLmNvbSI+PHNw
YW4gc3R5bGU9ImNvbG9yOndpbmRvd3RleHQ7dGV4dC1kZWNvcmF0aW9uOm5vbmUiPjk0RjJGQkFC
NDQzMkI1NEU4QUFDQzdERkRFNkM5MkUzNkZFNkMzMjFAT1JTTVNYMTAzLmFtci5jb3JwLmludGVs
LmNvbTwvc3Bhbj48L2E+Jmd0OzxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1Bs
YWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgPG86cD48L286cD48L3NwYW4+PC9wPgo8
cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBDb250ZW50LVR5
cGU6IHRleHQvcGxhaW47IGNoYXJzZXQ9JnF1b3Q7dXMtYXNjaWkmcXVvdDs8bzpwPjwvbzpwPjwv
c3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7
IDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFu
Zz0iRU4tR0IiPiZndDsgVGhlIGZpeCBmb3IgdGhpcyBpcyBjaGVja2VkIGludG8gb3VyIGdpdCB0
cmVlLjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4g
bGFuZz0iRU4tR0IiPiZndDsgQm9iPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNv
UGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBGcm9tOiA8YSBocmVmPSJtYWlsdG86
ZGV2ZWwtYm91bmNlc0BhY3BpY2Eub3JnIj4KPHNwYW4gc3R5bGU9ImNvbG9yOndpbmRvd3RleHQ7
dGV4dC1kZWNvcmF0aW9uOm5vbmUiPmRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZzwvc3Bhbj48L2E+
IFs8YSBocmVmPSJtYWlsdG86ZGV2ZWwtYm91bmNlc0BhY3BpY2Eub3JnIj48c3BhbiBzdHlsZT0i
Y29sb3I6d2luZG93dGV4dDt0ZXh0LWRlY29yYXRpb246bm9uZSI+bWFpbHRvOmRldmVsLWJvdW5j
ZXNAYWNwaWNhLm9yZzwvc3Bhbj48L2E+XSBPbiBCZWhhbGY8bzpwPjwvbzpwPjwvc3Bhbj48L3A+
CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IE9mIE1vb3Jl
LCBSb2JlcnQ8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxz
cGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IFNlbnQ6IFdlZG5lc2RheSwgTWF5IDE1LCAyMDEzIDEwOjMz
IEFNPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBs
YW5nPSJFTi1HQiI+Jmd0OyBUbzogQWxleGVpIEZlZG9yb3Y7IDxhIGhyZWY9Im1haWx0bzpkZXZl
bEBhY3BpY2Eub3JnIj4KPHNwYW4gc3R5bGU9ImNvbG9yOndpbmRvd3RleHQ7dGV4dC1kZWNvcmF0
aW9uOm5vbmUiPmRldmVsQGFjcGljYS5vcmc8L3NwYW4+PC9hPjxvOnA+PC9vOnA+PC9zcGFuPjwv
cD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgU3ViamVj
dDogUmU6IFtEZXZlbF0gLUQgJmx0O3N5bWJvbCZndDsgUHJlcHJvY2Vzc29yIE9wdGlvbiBEb2Vz
bid0IFdvcms8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxz
cGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1z
b1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgU29ycnksIHdlIGRpZCBzb21lIGNv
ZGUgcmVzdHJ1Y3R1cmluZyBhbmQgYnJva2UgdGhpcy4gWW91IGNhbiBnbyBiYWNrIHRvPG86cD48
L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1H
QiI+Jmd0OyBhbiBlYXJsaWVyIHZlcnNpb24gb2YgdGhlIGNvbXBpbGVyLCBvciB3YWl0IHVudGls
IGxhdGVyIHRoaXMgd2VlayB3aGVuPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNv
UGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyB0aGVyZSB3aWxsIGJlIGEgbmV3IHZl
cnNpb24uPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3Bh
biBsYW5nPSJFTi1HQiI+Jmd0OyBCb2I8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJN
c29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IEZyb206IDxhIGhyZWY9Im1haWx0
bzpkZXZlbC1ib3VuY2VzQGFjcGljYS5vcmclM2NtYWlsdG86ZGV2ZWwtYm91bmNlc0BhY3BpY2Eu
b3JnIj4KPHNwYW4gc3R5bGU9ImNvbG9yOndpbmRvd3RleHQ7dGV4dC1kZWNvcmF0aW9uOm5vbmUi
PmRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZyZsdDttYWlsdG86ZGV2ZWwtYm91bmNlc0BhY3BpY2Eu
b3JnPC9zcGFuPjwvYT4mZ3Q7PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxh
aW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBbPGEgaHJlZj0ibWFpbHRvOmRldmVsLWJv
dW5jZXNAYWNwaWNhLm9yZyI+PHNwYW4gc3R5bGU9ImNvbG9yOndpbmRvd3RleHQ7dGV4dC1kZWNv
cmF0aW9uOm5vbmUiPm1haWx0bzpkZXZlbC1ib3VuY2VzQGFjcGljYS5vcmc8L3NwYW4+PC9hPl0g
T24gQmVoYWxmIE9mIE1vb3JlLCBSb2JlcnQ8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNz
PSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IFNlbnQ6IFdlZG5lc2RheSwg
TWF5IDE1LCAyMDEzIDg6NDMgQU08bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29Q
bGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IFRvOiBBbGV4ZWkgRmVkb3JvdjsgPGEg
aHJlZj0ibWFpbHRvOmRldmVsQGFjcGljYS5vcmclM2NtYWlsdG86ZGV2ZWxAYWNwaWNhLm9yZyI+
CjxzcGFuIHN0eWxlPSJjb2xvcjp3aW5kb3d0ZXh0O3RleHQtZGVjb3JhdGlvbjpub25lIj5kZXZl
bEBhY3BpY2Eub3JnJmx0O21haWx0bzpkZXZlbEBhY3BpY2Eub3JnPC9zcGFuPjwvYT4mZ3Q7PG86
cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJF
Ti1HQiI+Jmd0OyBTdWJqZWN0OiBSZTogW0RldmVsXSAtRCAmbHQ7c3ltYm9sJmd0OyBQcmVwcm9j
ZXNzb3IgT3B0aW9uIERvZXNuJ3QgV29yazxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9
Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgPG86cD48L286cD48L3NwYW4+
PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBXZSB3
aWxsIGNoZWNrIGl0IG91dC48bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFp
blRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IFRoYW5rcyw8bzpwPjwvbzpwPjwvc3Bhbj48
L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IEJvYjxv
OnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0i
RU4tR0IiPiZndDsgRnJvbTogPGEgaHJlZj0ibWFpbHRvOmRldmVsLWJvdW5jZXNAYWNwaWNhLm9y
ZyUzY21haWx0bzpkZXZlbC1ib3VuY2VzQGFjcGljYS5vcmciPgo8c3BhbiBzdHlsZT0iY29sb3I6
d2luZG93dGV4dDt0ZXh0LWRlY29yYXRpb246bm9uZSI+ZGV2ZWwtYm91bmNlc0BhY3BpY2Eub3Jn
Jmx0O21haWx0bzpkZXZlbC1ib3VuY2VzQGFjcGljYS5vcmc8L3NwYW4+PC9hPiZndDs8bzpwPjwv
bzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdC
Ij4mZ3Q7IFs8YSBocmVmPSJtYWlsdG86ZGV2ZWwtYm91bmNlc0BhY3BpY2Eub3JnIj48c3BhbiBz
dHlsZT0iY29sb3I6d2luZG93dGV4dDt0ZXh0LWRlY29yYXRpb246bm9uZSI+bWFpbHRvOmRldmVs
LWJvdW5jZXNAYWNwaWNhLm9yZzwvc3Bhbj48L2E+XSBPbiBCZWhhbGYgT2YgQWxleGVpIEZlZG9y
b3Y8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxh
bmc9IkVOLUdCIj4mZ3Q7IFNlbnQ6IFR1ZXNkYXksIE1heSAxNCwgMjAxMyA1OjI3IEFNPG86cD48
L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1H
QiI+Jmd0OyBUbzogPGEgaHJlZj0ibWFpbHRvOmRldmVsQGFjcGljYS5vcmclM2NtYWlsdG86ZGV2
ZWxAYWNwaWNhLm9yZyI+CjxzcGFuIHN0eWxlPSJjb2xvcjp3aW5kb3d0ZXh0O3RleHQtZGVjb3Jh
dGlvbjpub25lIj5kZXZlbEBhY3BpY2Eub3JnJmx0O21haWx0bzpkZXZlbEBhY3BpY2Eub3JnPC9z
cGFuPjwvYT4mZ3Q7PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0
Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBTdWJqZWN0OiBbRGV2ZWxdIC1EICZsdDtzeW1ib2wm
Z3Q7IFByZXByb2Nlc3NvciBPcHRpb24gRG9lc24ndCBXb3JrPG86cD48L286cD48L3NwYW4+PC9w
Pgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyA8bzpwPjwv
bzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdC
Ij4mZ3Q7IEhpLDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+
PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0i
TXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBBU0wgVXNlciBHdWlkZSBzdGF0
ZXMgdGhhdCAjaWZkZWYgc3RhdGVtZW50cyBhcmUgcmVjb2duaXplZCB3aGVuIGEgc3ltYm9sPG86
cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJF
Ti1HQiI+Jmd0OyBpcyBkZWZpbmVkIGluIHRoZSBjb21tYW5kIGxpbmU6PG86cD48L286cD48L3Nw
YW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyA8
bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9
IkVOLUdCIj4mZ3Q7ICZxdW90OzMuMy4yLjIgI2lmZGVmPG86cD48L286cD48L3NwYW4+PC9wPgo8
cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBVc2FnZTo8bzpw
PjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVO
LUdCIj4mZ3Q7ICNpZmRlZiBzeW1ib2w8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJN
c29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IENvbmRpdGlvbmFsbHkgY29tcGls
ZSBhIGJsb2NrIG9mIHRleHQuIFRoZSBibG9jayBpcyBpbmNsdWRlZCBpbiB0aGU8bzpwPjwvbzpw
Pjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4m
Z3Q7IGNvbXBpbGF0aW9uIGlmIHRoZSBzeW1ib2wgaXMgZGVmaW5lZCwgZWl0aGVyIGZyb20gYSAj
ZGVmaW5lIG9yIGZyb20gdGhlIC08bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29Q
bGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IEQgY29tbWFuZCBsaW5lIG9wdGlvbiZx
dW90OzxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4g
bGFuZz0iRU4tR0IiPiZndDsgPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxh
aW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBidXQgSSBjYW5ub3QgbWFrZSBBU0wgQ29t
cGlsZXIgdG8gcmVjb2duaXplIHRoZSBmb2xsb3dpbmcgb3B0aW9uPG86cD48L286cD48L3NwYW4+
PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyZuYnNw
OyZuYnNwOyAtRCAmbHQ7c3ltYm9sJmd0OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyBEZWZpbmUgc3ltYm9sIGZvciBwcmVwcm9jZXNzb3IgdXNlPG86cD48L286cD48L3NwYW4+
PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyA8bzpw
PjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVO
LUdCIj4mZ3Q7IEluIHRoZSBleGFtcGxlIGJlbG93PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBj
bGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyA8bzpwPjwvbzpwPjwv
c3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7
IERlZmluaXRpb25CbG9jaygmcXVvdDtEU0RULkFNTCZxdW90OywgJnF1b3Q7RFNEVCZxdW90Oywg
MHgwMSwgJnF1b3Q7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICZxdW90OywgJnF1b3Q7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICZxdW90OywgMykgezxv
OnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0i
RU4tR0IiPiZndDsmbmJzcDsmbmJzcDsgU2NvcGUoX1NCKSB7PG86cD48L286cD48L3NwYW4+PC9w
Pgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyBEZXZpY2UoQ1BVMCkgezxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAg
Y2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgTmFtZShfSElELCAmcXVvdDtBQ1BJMDAwNyZxdW90Oyk8
bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9
IkVOLUdCIj4mZ3Q7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IE5hbWUoX1VJ
RCwgWmVybyk8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxz
cGFuIGxhbmc9IkVOLUdCIj4mZ3Q7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IH08bzpwPjwvbzpw
Pjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4m
Z3Q7ICNpZmRlZiBDUFVfMTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWlu
VGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgRGV2
aWNlKENQVTEpIHs8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQi
PjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IE5hbWUo
X0hJRCwgJnF1b3Q7QUNQSTAwMDcmcXVvdDspPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFz
cz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyBOYW1lKF9VSUQsIE9uZSk8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNz
PSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7IH08bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxz
cGFuIGxhbmc9IkVOLUdCIj4mZ3Q7ICNlbmRpZjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xh
c3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsmbmJzcDsmbmJzcDsgfTxv
OnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0i
RU4tR0IiPiZndDsgfTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4
dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFz
cz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBUaGUgc2VjdGlvbiBiZXR3
ZWVuICNpZmRlZiBDUFVfMSAuLi4gI2VuZGlmIGlzIG5vdCBiZWluZyBjb21waWxlZCB3aGVuIEFT
TDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFu
Zz0iRU4tR0IiPiZndDsgaXMgaW52b2tlZCBhczo8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNs
YXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IGlhc2wuZXhlIC1sIC1E
IENQVV8xIERzZHQuYXNsPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5U
ZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBDaGVja2VkIHdpdGggdGhlIGxhdGVzdCB2ZXJz
aW9uIDIwMTMwNDE4LTMyIFtBcHIgMTggMjAxM10uPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBj
bGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyA8bzpwPjwvbzpwPjwv
c3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7
IEFueSB0aG91Z2h0cyBvbiB3aGF0IG1pZ2h0IGJlIGdvaW5nIHdyb25nIGhlcmU/PG86cD48L286
cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+
Jmd0OyBUaGFua3MuPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0
Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyA8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNz
PSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IDxvOnA+PC9vOnA+PC9zcGFu
PjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgPG86
cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJF
Ti1HQiI+Jmd0OyAtLSBJTVBPUlRBTlQgTk9USUNFOiBUaGUgY29udGVudHMgb2YgdGhpcyBlbWFp
bCBhbmQgYW55IGF0dGFjaG1lbnRzIGFyZTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9
Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgY29uZmlkZW50aWFsIGFuZCBt
YXkgYWxzbyBiZSBwcml2aWxlZ2VkLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQ8bzpwPjwv
bzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdC
Ij4mZ3Q7IHJlY2lwaWVudCwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGFu
ZCBkbyBub3QgZGlzY2xvc2UgdGhlPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNv
UGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBjb250ZW50cyB0byBhbnkgb3RoZXIg
cGVyc29uLCB1c2UgaXQgZm9yIGFueSBwdXJwb3NlLCBvciBzdG9yZSBvciBjb3B5IHRoZTxvOnA+
PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4t
R0IiPiZndDsgaW5mb3JtYXRpb24gaW4gYW55IG1lZGl1bS4gVGhhbmsgeW91LjxvOnA+PC9vOnA+
PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZn
dDsgLS0tLS0tLS0tLS0tLS0gbmV4dCBwYXJ0IC0tLS0tLS0tLS0tLS0tPG86cD48L286cD48L3Nw
YW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBB
biBIVE1MIGF0dGFjaG1lbnQgd2FzIHNjcnViYmVkLi4uPG86cD48L286cD48L3NwYW4+PC9wPgo8
cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBVUkw6PG86cD48
L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1H
QiI+Jmd0OyAmbHQ7aHR0cDovL2xpc3RzLmFjcGljYS5vcmcvcGlwZXJtYWlsL2RldmVsL2F0dGFj
aG1lbnRzLzIwMTMwNTE2LzZjYzY0OGNiL2F0dDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xh
c3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgYWNobWVudC0wMDAxLmh0
bWwmZ3Q7PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3Bh
biBsYW5nPSJFTi1HQiI+Jmd0OyA8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29Q
bGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNw
YW4gbGFuZz0iRU4tR0IiPiZndDsgPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNv
UGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBNZXNzYWdlOiAyPG86cD48L286cD48
L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0
OyBEYXRlOiBUaHUsIDE2IE1heSAyMDEzIDE3OjEyOjQ0ICYjNDM7MDAwMDxvOnA+PC9vOnA+PC9z
cGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsg
RnJvbTogJnF1b3Q7TW9vcmUsIFJvYmVydCZxdW90OyAmbHQ7PGEgaHJlZj0ibWFpbHRvOnJvYmVy
dC5tb29yZUBpbnRlbC5jb20iPjxzcGFuIHN0eWxlPSJjb2xvcjp3aW5kb3d0ZXh0O3RleHQtZGVj
b3JhdGlvbjpub25lIj5yb2JlcnQubW9vcmVAaW50ZWwuY29tPC9zcGFuPjwvYT4mZ3Q7PG86cD48
L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1H
QiI+Jmd0OyBUbzogQWxleGVpIEZlZG9yb3YgJmx0OzxhIGhyZWY9Im1haWx0bzpBbGV4ZWkuRmVk
b3JvdkBhcm0uY29tIj48c3BhbiBzdHlsZT0iY29sb3I6d2luZG93dGV4dDt0ZXh0LWRlY29yYXRp
b246bm9uZSI+QWxleGVpLkZlZG9yb3ZAYXJtLmNvbTwvc3Bhbj48L2E+Jmd0OywgJnF1b3Q7PGEg
aHJlZj0ibWFpbHRvOmRldmVsQGFjcGljYS5vcmciPjxzcGFuIHN0eWxlPSJjb2xvcjp3aW5kb3d0
ZXh0O3RleHQtZGVjb3JhdGlvbjpub25lIj5kZXZlbEBhY3BpY2Eub3JnPC9zcGFuPjwvYT4mcXVv
dDs8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxh
bmc9IkVOLUdCIj4mZ3Q7Jm5ic3A7Jm5ic3A7ICZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZsdDs8YSBocmVmPSJtYWlsdG86ZGV2ZWxAYWNwaWNhLm9yZyI+PHNwYW4gc3R5bGU9
ImNvbG9yOndpbmRvd3RleHQ7dGV4dC1kZWNvcmF0aW9uOm5vbmUiPmRldmVsQGFjcGljYS5vcmc8
L3NwYW4+PC9hPiZndDs8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRl
eHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IFN1YmplY3Q6IFJlOiBbRGV2ZWxdIC1EICZsdDtz
eW1ib2wmZ3Q7IFByZXByb2Nlc3NvciBPcHRpb24gRG9lc24ndCBXb3JrPG86cD48L286cD48L3Nw
YW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBN
ZXNzYWdlLUlEOjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+
PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0i
TXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyAmbHQ7PGEgaHJlZj0ibWFpbHRv
Ojk0RjJGQkFCNDQzMkI1NEU4QUFDQzdERkRFNkM5MkUzNkZFNkMzQjVAT1JTTVNYMTAzLmFtci5j
b3JwLmludGVsLmNvbSI+PHNwYW4gc3R5bGU9ImNvbG9yOndpbmRvd3RleHQ7dGV4dC1kZWNvcmF0
aW9uOm5vbmUiPjk0RjJGQkFCNDQzMkI1NEU4QUFDQzdERkRFNkM5MkUzNkZFNkMzQjVAT1JTTVNY
MTAzLmFtci5jb3JwLmludGVsLmNvbTwvc3Bhbj48L2E+Jmd0OzxvOnA+PC9vOnA+PC9zcGFuPjwv
cD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgPG86cD48
L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1H
QiI+Jmd0OyBDb250ZW50LVR5cGU6IHRleHQvcGxhaW47IGNoYXJzZXQ9JnF1b3Q7dXMtYXNjaWkm
cXVvdDs8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFu
IGxhbmc9IkVOLUdCIj4mZ3Q7IDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1Bs
YWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgWWVzLCBpdCBsb29rcyBsaWtlIGl0IGhh
cyBiZWVuIHRoZXJlIGEgd2hpbGUuPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNv
UGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBZb3UgY2FuIGNoZWNrb3V0IHRoZSBw
YXRjaCwgb3IgSSBjYW4gc2VuZCB5b3UgYW4gdXBkYXRlZCB3aW5kb3dzIGJpbmFyeS48bzpwPjwv
bzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdC
Ij4mZ3Q7IDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNw
YW4gbGFuZz0iRU4tR0IiPiZndDsgPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNv
UGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBGcm9tOiBBbGV4ZWkgRmVkb3JvdiBb
PGEgaHJlZj0ibWFpbHRvOkFsZXhlaS5GZWRvcm92QGFybS5jb20iPjxzcGFuIHN0eWxlPSJjb2xv
cjp3aW5kb3d0ZXh0O3RleHQtZGVjb3JhdGlvbjpub25lIj5tYWlsdG86QWxleGVpLkZlZG9yb3ZA
YXJtLmNvbTwvc3Bhbj48L2E+XTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1Bs
YWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgU2VudDogVGh1cnNkYXksIE1heSAxNiwg
MjAxMyAzOjE3IEFNPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0
Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBUbzogTW9vcmUsIFJvYmVydDsgPGEgaHJlZj0ibWFp
bHRvOmRldmVsQGFjcGljYS5vcmciPgo8c3BhbiBzdHlsZT0iY29sb3I6d2luZG93dGV4dDt0ZXh0
LWRlY29yYXRpb246bm9uZSI+ZGV2ZWxAYWNwaWNhLm9yZzwvc3Bhbj48L2E+PG86cD48L286cD48
L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0
OyBTdWJqZWN0OiBSRTogLUQgJmx0O3N5bWJvbCZndDsgUHJlcHJvY2Vzc29yIE9wdGlvbiBEb2Vz
bid0IFdvcms8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxz
cGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1z
b1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgSGkgUm9iZXJ0LDxvOnA+PC9vOnA+
PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZn
dDsgSSB0cmllZCB0aGF0IHdpdGggNCBwcmV2aW91cyB2ZXJzaW9ucyBvZiBjb21waWxlciAmYW1w
OyBzdGlsbCBnb3QgdGhlIHNhbWU8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29Q
bGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IGlzc3VlLjxvOnA+PC9vOnA+PC9zcGFu
PjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgUmVn
YXJkcy48bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFu
IGxhbmc9IkVOLUdCIj4mZ3Q7IEFsZXhlaS48bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNz
PSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IDxvOnA+PC9vOnA+PC9zcGFu
PjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgRnJv
bTogTW9vcmUsIFJvYmVydCBbPGEgaHJlZj0ibWFpbHRvOnJvYmVydC5tb29yZUBpbnRlbC5jb20i
PjxzcGFuIHN0eWxlPSJjb2xvcjp3aW5kb3d0ZXh0O3RleHQtZGVjb3JhdGlvbjpub25lIj5tYWls
dG86cm9iZXJ0Lm1vb3JlQGludGVsLmNvbTwvc3Bhbj48L2E+XTxvOnA+PC9vOnA+PC9zcGFuPjwv
cD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgU2VudDog
MTUgTWF5IDIwMTMgMTg6MzM8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFp
blRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IFRvOiBBbGV4ZWkgRmVkb3JvdjsgPGEgaHJl
Zj0ibWFpbHRvOmRldmVsQGFjcGljYS5vcmclM2NtYWlsdG86ZGV2ZWxAYWNwaWNhLm9yZyI+Cjxz
cGFuIHN0eWxlPSJjb2xvcjp3aW5kb3d0ZXh0O3RleHQtZGVjb3JhdGlvbjpub25lIj5kZXZlbEBh
Y3BpY2Eub3JnJmx0O21haWx0bzpkZXZlbEBhY3BpY2Eub3JnPC9zcGFuPjwvYT4mZ3Q7PG86cD48
L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1H
QiI+Jmd0OyBTdWJqZWN0OiBSRTogLUQgJmx0O3N5bWJvbCZndDsgUHJlcHJvY2Vzc29yIE9wdGlv
biBEb2Vzbid0IFdvcms8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRl
eHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xh
c3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgU29ycnksIHdlIGRpZCBz
b21lIGNvZGUgcmVzdHJ1Y3R1cmluZyBhbmQgYnJva2UgdGhpcy4gWW91IGNhbiBnbyBiYWNrIHRv
PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5n
PSJFTi1HQiI+Jmd0OyBhbiBlYXJsaWVyIHZlcnNpb24gb2YgdGhlIGNvbXBpbGVyLCBvciB3YWl0
IHVudGlsIGxhdGVyIHRoaXMgd2VlayB3aGVuPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFz
cz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyB0aGVyZSB3aWxsIGJlIGEg
bmV3IHZlcnNpb24uPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0
Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBCb2I8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNs
YXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IEZyb206IDxhIGhyZWY9
Im1haWx0bzpkZXZlbC1ib3VuY2VzQGFjcGljYS5vcmclM2NtYWlsdG86ZGV2ZWwtYm91bmNlc0Bh
Y3BpY2Eub3JnIj4KPHNwYW4gc3R5bGU9ImNvbG9yOndpbmRvd3RleHQ7dGV4dC1kZWNvcmF0aW9u
Om5vbmUiPmRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZyZsdDttYWlsdG86ZGV2ZWwtYm91bmNlc0Bh
Y3BpY2Eub3JnPC9zcGFuPjwvYT4mZ3Q7PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0i
TXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBbPGEgaHJlZj0ibWFpbHRvOmRl
dmVsLWJvdW5jZXNAYWNwaWNhLm9yZyI+PHNwYW4gc3R5bGU9ImNvbG9yOndpbmRvd3RleHQ7dGV4
dC1kZWNvcmF0aW9uOm5vbmUiPm1haWx0bzpkZXZlbC1ib3VuY2VzQGFjcGljYS5vcmc8L3NwYW4+
PC9hPl0gT24gQmVoYWxmIE9mIE1vb3JlLCBSb2JlcnQ8bzpwPjwvbzpwPjwvc3Bhbj48L3A+Cjxw
IGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IFNlbnQ6IFdlZG5l
c2RheSwgTWF5IDE1LCAyMDEzIDg6NDMgQU08bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNz
PSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IFRvOiBBbGV4ZWkgRmVkb3Jv
djsgPGEgaHJlZj0ibWFpbHRvOmRldmVsQGFjcGljYS5vcmclM2NtYWlsdG86ZGV2ZWxAYWNwaWNh
Lm9yZyI+CjxzcGFuIHN0eWxlPSJjb2xvcjp3aW5kb3d0ZXh0O3RleHQtZGVjb3JhdGlvbjpub25l
Ij5kZXZlbEBhY3BpY2Eub3JnJmx0O21haWx0bzpkZXZlbEBhY3BpY2Eub3JnPC9zcGFuPjwvYT4m
Z3Q7PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBs
YW5nPSJFTi1HQiI+Jmd0OyBTdWJqZWN0OiBSZTogW0RldmVsXSAtRCAmbHQ7c3ltYm9sJmd0OyBQ
cmVwcm9jZXNzb3IgT3B0aW9uIERvZXNuJ3QgV29yazxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAg
Y2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgPG86cD48L286cD48
L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0
OyBXZSB3aWxsIGNoZWNrIGl0IG91dC48bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJN
c29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IFRoYW5rcyw8bzpwPjwvbzpwPjwv
c3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7
IEJvYjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4g
bGFuZz0iRU4tR0IiPiZndDsgRnJvbTogPGEgaHJlZj0ibWFpbHRvOmRldmVsLWJvdW5jZXNAYWNw
aWNhLm9yZyUzY21haWx0bzpkZXZlbC1ib3VuY2VzQGFjcGljYS5vcmciPgo8c3BhbiBzdHlsZT0i
Y29sb3I6d2luZG93dGV4dDt0ZXh0LWRlY29yYXRpb246bm9uZSI+ZGV2ZWwtYm91bmNlc0BhY3Bp
Y2Eub3JnJmx0O21haWx0bzpkZXZlbC1ib3VuY2VzQGFjcGljYS5vcmc8L3NwYW4+PC9hPiZndDs8
bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9
IkVOLUdCIj4mZ3Q7IFs8YSBocmVmPSJtYWlsdG86ZGV2ZWwtYm91bmNlc0BhY3BpY2Eub3JnIj48
c3BhbiBzdHlsZT0iY29sb3I6d2luZG93dGV4dDt0ZXh0LWRlY29yYXRpb246bm9uZSI+bWFpbHRv
OmRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZzwvc3Bhbj48L2E+XSBPbiBCZWhhbGYgT2YgQWxleGVp
IEZlZG9yb3Y8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxz
cGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IFNlbnQ6IFR1ZXNkYXksIE1heSAxNCwgMjAxMyA1OjI3IEFN
PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5n
PSJFTi1HQiI+Jmd0OyBUbzogPGEgaHJlZj0ibWFpbHRvOmRldmVsQGFjcGljYS5vcmclM2NtYWls
dG86ZGV2ZWxAYWNwaWNhLm9yZyI+CjxzcGFuIHN0eWxlPSJjb2xvcjp3aW5kb3d0ZXh0O3RleHQt
ZGVjb3JhdGlvbjpub25lIj5kZXZlbEBhY3BpY2Eub3JnJmx0O21haWx0bzpkZXZlbEBhY3BpY2Eu
b3JnPC9zcGFuPjwvYT4mZ3Q7PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxh
aW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBTdWJqZWN0OiBbRGV2ZWxdIC1EICZsdDtz
eW1ib2wmZ3Q7IFByZXByb2Nlc3NvciBPcHRpb24gRG9lc24ndCBXb3JrPG86cD48L286cD48L3Nw
YW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyA8
bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9
IkVOLUdCIj4mZ3Q7IEhpLDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWlu
VGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBj
bGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBBU0wgVXNlciBHdWlk
ZSBzdGF0ZXMgdGhhdCAjaWZkZWYgc3RhdGVtZW50cyBhcmUgcmVjb2duaXplZCB3aGVuIGEgc3lt
Ym9sPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBs
YW5nPSJFTi1HQiI+Jmd0OyBpcyBkZWZpbmVkIGluIHRoZSBjb21tYW5kIGxpbmU6PG86cD48L286
cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+
Jmd0OyA8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFu
IGxhbmc9IkVOLUdCIj4mZ3Q7ICZxdW90OzMuMy4yLjIgI2lmZGVmPG86cD48L286cD48L3NwYW4+
PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBVc2Fn
ZTo8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxh
bmc9IkVOLUdCIj4mZ3Q7ICNpZmRlZiBzeW1ib2w8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNs
YXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IENvbmRpdGlvbmFsbHkg
Y29tcGlsZSBhIGJsb2NrIG9mIHRleHQuIFRoZSBibG9jayBpcyBpbmNsdWRlZCBpbiB0aGU8bzpw
PjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVO
LUdCIj4mZ3Q7IGNvbXBpbGF0aW9uIGlmIHRoZSBzeW1ib2wgaXMgZGVmaW5lZCwgZWl0aGVyIGZy
b20gYSAjZGVmaW5lIG9yIGZyb20gdGhlIC08bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNz
PSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IEQgY29tbWFuZCBsaW5lIG9w
dGlvbiZxdW90OzxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+
PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0i
TXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBidXQgSSBjYW5ub3QgbWFrZSBB
U0wgQ29tcGlsZXIgdG8gcmVjb2duaXplIHRoZSBmb2xsb3dpbmcgb3B0aW9uPG86cD48L286cD48
L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0
OyZuYnNwOyZuYnNwOyAtRCAmbHQ7c3ltYm9sJmd0OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyBEZWZpbmUgc3ltYm9sIGZvciBwcmVwcm9jZXNzb3IgdXNlPG86cD48L286cD48
L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0
OyA8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxh
bmc9IkVOLUdCIj4mZ3Q7IEluIHRoZSBleGFtcGxlIGJlbG93PG86cD48L286cD48L3NwYW4+PC9w
Pgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyA8bzpwPjwv
bzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdC
Ij4mZ3Q7IERlZmluaXRpb25CbG9jaygmcXVvdDtEU0RULkFNTCZxdW90OywgJnF1b3Q7RFNEVCZx
dW90OywgMHgwMSwgJnF1b3Q7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICZxdW90Oywg
JnF1b3Q7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICZxdW90Oywg
MykgezxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4g
bGFuZz0iRU4tR0IiPiZndDsmbmJzcDsmbmJzcDsgU2NvcGUoX1NCKSB7PG86cD48L286cD48L3Nw
YW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBEZXZpY2UoQ1BVMCkgezxvOnA+PC9vOnA+PC9zcGFuPjwv
cD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgTmFtZShfSElELCAmcXVvdDtBQ1BJMDAwNyZx
dW90Oyk8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFu
IGxhbmc9IkVOLUdCIj4mZ3Q7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IE5h
bWUoX1VJRCwgWmVybyk8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRl
eHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IH08bzpw
PjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVO
LUdCIj4mZ3Q7ICNpZmRlZiBDUFVfMTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1z
b1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsgRGV2aWNlKENQVTEpIHs8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFp
blRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
IE5hbWUoX0hJRCwgJnF1b3Q7QUNQSTAwMDcmcXVvdDspPG86cD48L286cD48L3NwYW4+PC9wPgo8
cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyBOYW1lKF9VSUQsIE9uZSk8bzpwPjwvbzpwPjwvc3Bhbj48L3A+Cjxw
IGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7IH08bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRl
eHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7ICNlbmRpZjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4K
PHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsmbmJzcDsmbmJz
cDsgfTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4g
bGFuZz0iRU4tR0IiPiZndDsgfTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1Bs
YWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgPG86cD48L286cD48L3NwYW4+PC9wPgo8
cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBUaGUgc2VjdGlv
biBiZXR3ZWVuICNpZmRlZiBDUFVfMSAuLi4gI2VuZGlmIGlzIG5vdCBiZWluZyBjb21waWxlZCB3
aGVuIEFTTDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNw
YW4gbGFuZz0iRU4tR0IiPiZndDsgaXMgaW52b2tlZCBhczo8bzpwPjwvbzpwPjwvc3Bhbj48L3A+
CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IGlhc2wuZXhl
IC1sIC1EIENQVV8xIERzZHQuYXNsPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNv
UGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBDaGVja2VkIHdpdGggdGhlIGxhdGVz
dCB2ZXJzaW9uIDIwMTMwNDE4LTMyIFtBcHIgMTggMjAxM10uPG86cD48L286cD48L3NwYW4+PC9w
Pgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyA8bzpwPjwv
bzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdC
Ij4mZ3Q7IEFueSB0aG91Z2h0cyBvbiB3aGF0IG1pZ2h0IGJlIGdvaW5nIHdyb25nIGhlcmU/PG86
cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJF
Ti1HQiI+Jmd0OyBUaGFua3MuPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxh
aW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyA8bzpwPjwvbzpwPjwvc3Bhbj48L3A+Cjxw
IGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IDxvOnA+PC9vOnA+
PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZn
dDsgPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBs
YW5nPSJFTi1HQiI+Jmd0OyAtLSBJTVBPUlRBTlQgTk9USUNFOiBUaGUgY29udGVudHMgb2YgdGhp
cyBlbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIGFyZTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAg
Y2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgY29uZmlkZW50aWFs
IGFuZCBtYXkgYWxzbyBiZSBwcml2aWxlZ2VkLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQ8
bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9
IkVOLUdCIj4mZ3Q7IHJlY2lwaWVudCwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0
ZWx5IGFuZCBkbyBub3QgZGlzY2xvc2UgdGhlPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFz
cz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBjb250ZW50cyB0byBhbnkg
b3RoZXIgcGVyc29uLCB1c2UgaXQgZm9yIGFueSBwdXJwb3NlLCBvciBzdG9yZSBvciBjb3B5IHRo
ZTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFu
Zz0iRU4tR0IiPiZndDsgaW5mb3JtYXRpb24gaW4gYW55IG1lZGl1bS4gVGhhbmsgeW91LjxvOnA+
PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4t
R0IiPiZndDsgPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48
c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyAtLSBJTVBPUlRBTlQgTk9USUNFOiBUaGUgY29udGVudHMg
b2YgdGhpcyBlbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIGFyZTxvOnA+PC9vOnA+PC9zcGFuPjwv
cD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgY29uZmlk
ZW50aWFsIGFuZCBtYXkgYWxzbyBiZSBwcml2aWxlZ2VkLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50
ZW5kZWQ8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFu
IGxhbmc9IkVOLUdCIj4mZ3Q7IHJlY2lwaWVudCwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGlt
bWVkaWF0ZWx5IGFuZCBkbyBub3QgZGlzY2xvc2UgdGhlPG86cD48L286cD48L3NwYW4+PC9wPgo8
cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBjb250ZW50cyB0
byBhbnkgb3RoZXIgcGVyc29uLCB1c2UgaXQgZm9yIGFueSBwdXJwb3NlLCBvciBzdG9yZSBvciBj
b3B5IHRoZTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNw
YW4gbGFuZz0iRU4tR0IiPiZndDsgaW5mb3JtYXRpb24gaW4gYW55IG1lZGl1bS4gVGhhbmsgeW91
LjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFu
Zz0iRU4tR0IiPiZndDsgLS0tLS0tLS0tLS0tLS0gbmV4dCBwYXJ0IC0tLS0tLS0tLS0tLS0tPG86
cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJF
Ti1HQiI+Jmd0OyBBbiBIVE1MIGF0dGFjaG1lbnQgd2FzIHNjcnViYmVkLi4uPG86cD48L286cD48
L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0
OyBVUkw6PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3Bh
biBsYW5nPSJFTi1HQiI+Jmd0OyAmbHQ7aHR0cDovL2xpc3RzLmFjcGljYS5vcmcvcGlwZXJtYWls
L2RldmVsL2F0dGFjaG1lbnRzLzIwMTMwNTE2L2ViOGE0OTZhL2F0dDxvOnA+PC9vOnA+PC9zcGFu
PjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgYWNo
bWVudC5odG1sJmd0OzxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4
dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFz
cz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyAtLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS08bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRl
eHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xh
c3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX188bzpwPjwvbzpwPjwvc3Bhbj48L3A+Cjxw
IGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IERldmVsIG1haWxp
bmcgbGlzdDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNw
YW4gbGFuZz0iRU4tR0IiPiZndDsgPGEgaHJlZj0ibWFpbHRvOkRldmVsQGFjcGljYS5vcmciPjxz
cGFuIHN0eWxlPSJjb2xvcjp3aW5kb3d0ZXh0O3RleHQtZGVjb3JhdGlvbjpub25lIj5EZXZlbEBh
Y3BpY2Eub3JnPC9zcGFuPjwvYT48bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29Q
bGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IDxhIGhyZWY9Imh0dHBzOi8vbGlzdHMu
YWNwaWNhLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RldmVsIj4KPHNwYW4gc3R5bGU9ImNvbG9yOndp
bmRvd3RleHQ7dGV4dC1kZWNvcmF0aW9uOm5vbmUiPmh0dHBzOi8vbGlzdHMuYWNwaWNhLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2RldmVsPC9zcGFuPjwvYT48bzpwPjwvbzpwPjwvc3Bhbj48L3A+Cjxw
IGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IDxvOnA+PC9vOnA+
PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZn
dDsgRW5kIG9mIERldmVsIERpZ2VzdCwgVm9sIDM4LCBJc3N1ZSA1PG86cD48L286cD48L3NwYW4+
PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyAqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKio8bzpwPjwvbzpwPjwvc3Bhbj48L3A+Cjxw
IGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IDxvOnA+PC9vOnA+
PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZn
dDsgPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBs
YW5nPSJFTi1HQiI+Jmd0OyAtLSBJTVBPUlRBTlQgTk9USUNFOiBUaGUgY29udGVudHMgb2YgdGhp
cyBlbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIGFyZTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAg
Y2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgY29uZmlkZW50aWFs
IGFuZCBtYXkgYWxzbyBiZSBwcml2aWxlZ2VkLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQ8
bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9
IkVOLUdCIj4mZ3Q7IHJlY2lwaWVudCwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0
ZWx5IGFuZCBkbyBub3QgZGlzY2xvc2UgdGhlPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFz
cz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBjb250ZW50cyB0byBhbnkg
b3RoZXIgcGVyc29uLCB1c2UgaXQgZm9yIGFueSBwdXJwb3NlLCBvciBzdG9yZSBvciBjb3B5IHRo
ZTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFu
Zz0iRU4tR0IiPiZndDsgaW5mb3JtYXRpb24gaW4gYW55IG1lZGl1bS4mbmJzcDsgVGhhbmsgeW91
LjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFu
Zz0iRU4tR0IiPiZndDsgPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5U
ZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXzxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1Bs
YWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgRGV2ZWwgbWFpbGluZyBsaXN0PG86cD48
L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1H
QiI+Jmd0OyA8YSBocmVmPSJtYWlsdG86RGV2ZWxAYWNwaWNhLm9yZyI+PHNwYW4gc3R5bGU9ImNv
bG9yOndpbmRvd3RleHQ7dGV4dC1kZWNvcmF0aW9uOm5vbmUiPkRldmVsQGFjcGljYS5vcmc8L3Nw
YW4+PC9hPjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNw
YW4gbGFuZz0iRU4tR0IiPiZndDsgPGEgaHJlZj0iaHR0cHM6Ly9saXN0cy5hY3BpY2Eub3JnL21h
aWxtYW4vbGlzdGluZm8vZGV2ZWwiPgo8c3BhbiBzdHlsZT0iY29sb3I6d2luZG93dGV4dDt0ZXh0
LWRlY29yYXRpb246bm9uZSI+aHR0cHM6Ly9saXN0cy5hY3BpY2Eub3JnL21haWxtYW4vbGlzdGlu
Zm8vZGV2ZWw8L3NwYW4+PC9hPjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1Bs
YWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPjxvOnA+Jm5ic3A7PC9vOnA+PC9zcGFuPjwvcD4K
PHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1hcmdpbjowaW47bWFyZ2luLWJvdHRvbTouMDAw
MXB0Ij48c3BhbiBsYW5nPSJFTi1HQiIgc3R5bGU9ImZvbnQtc2l6ZToxMi4wcHQ7Zm9udC1mYW1p
bHk6JnF1b3Q7VGltZXMgTmV3IFJvbWFuJnF1b3Q7LCZxdW90O3NlcmlmJnF1b3Q7Ij48YnI+Cjwv
c3Bhbj48c3BhbiBsYW5nPSJFTi1HQiIgc3R5bGU9ImZvbnQtc2l6ZToxMC4wcHQ7Zm9udC1mYW1p
bHk6JnF1b3Q7QXJpYWwmcXVvdDssJnF1b3Q7c2Fucy1zZXJpZiZxdW90Oztjb2xvcjpibGFjayI+
LS0gSU1QT1JUQU5UIE5PVElDRTogVGhlIGNvbnRlbnRzIG9mIHRoaXMgZW1haWwgYW5kIGFueSBh
dHRhY2htZW50cyBhcmUgY29uZmlkZW50aWFsIGFuZCBtYXkgYWxzbyBiZSBwcml2aWxlZ2VkLiBJ
ZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2Ugbm90aWZ5CiB0aGUg
c2VuZGVyIGltbWVkaWF0ZWx5IGFuZCBkbyBub3QgZGlzY2xvc2UgdGhlIGNvbnRlbnRzIHRvIGFu
eSBvdGhlciBwZXJzb24sIHVzZSBpdCBmb3IgYW55IHB1cnBvc2UsIG9yIHN0b3JlIG9yIGNvcHkg
dGhlIGluZm9ybWF0aW9uIGluIGFueSBtZWRpdW0uIFRoYW5rIHlvdS48L3NwYW4+PHNwYW4gbGFu
Zz0iRU4tR0IiIHN0eWxlPSJmb250LXNpemU6MTIuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O1RpbWVz
IE5ldyBSb21hbiZxdW90OywmcXVvdDtzZXJpZiZxdW90OyI+PG86cD48L286cD48L3NwYW4+PC9w
Pgo8L2Rpdj4KPC9kaXY+CjwvYm9keT4KPC9odG1sPgo=

--===============4005334547907234065==--

