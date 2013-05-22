Content-Type: multipart/mixed; boundary="===============7959582771375234818=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] -D <symbol> Preprocessor Option Doesn't Work
Date: Wed, 22 May 2013 15:01:37 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E36FE77E7A@ORSMSX103.amr.corp.intel.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E36FE77E5A@ORSMSX103.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7959582771375234818==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Oddly enough, if you rename the preprocessor output file (such as dsdt.i) t=
o something like dsdt.tmp, it will compile correctly.
This may be a quick workaround for you until the problem is fixed.
Bob


From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] On Beh=
alf Of Moore, Robert
Sent: Wednesday, May 22, 2013 7:54 AM
To: Alexei Fedorov
Cc: devel(a)acpica.org
Subject: Re: [Devel] -D <symbol> Preprocessor Option Doesn't Work

There does seem to be a problem. I will investigate further and get back to=
 you.
Bob
From: devel-bounces(a)acpica.org<mailto:devel-bounces(a)acpica.org> [mailto=
:devel-bounces(a)acpica.org] On Behalf Of Moore, Robert
Sent: Wednesday, May 22, 2013 6:51 AM
To: Alexei Fedorov
Cc: devel(a)acpica.org<mailto:devel(a)acpica.org>
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

--===============7959582771375234818==
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
ZTIyCgl7bXNvLXN0eWxlLXR5cGU6cGVyc29uYWw7Cglmb250LWZhbWlseToiQ2FsaWJyaSIsInNh
bnMtc2VyaWYiOwoJY29sb3I6IzFGNDk3RDt9CnNwYW4uRW1haWxTdHlsZTIzCgl7bXNvLXN0eWxl
LXR5cGU6cGVyc29uYWwtcmVwbHk7Cglmb250LWZhbWlseToiQ2FsaWJyaSIsInNhbnMtc2VyaWYi
OwoJY29sb3I6IzFGNDk3RDt9Ci5Nc29DaHBEZWZhdWx0Cgl7bXNvLXN0eWxlLXR5cGU6ZXhwb3J0
LW9ubHk7Cglmb250LXNpemU6MTAuMHB0O30KQHBhZ2UgV29yZFNlY3Rpb24xCgl7c2l6ZTo4LjVp
biAxMS4waW47CgltYXJnaW46MS4waW4gMS4waW4gMS4waW4gMS4waW47fQpkaXYuV29yZFNlY3Rp
b24xCgl7cGFnZTpXb3JkU2VjdGlvbjE7fQotLT48L3N0eWxlPjwhLS1baWYgZ3RlIG1zbyA5XT48
eG1sPgo8bzpzaGFwZWRlZmF1bHRzIHY6ZXh0PSJlZGl0IiBzcGlkbWF4PSIxMDI2IiAvPgo8L3ht
bD48IVtlbmRpZl0tLT48IS0tW2lmIGd0ZSBtc28gOV0+PHhtbD4KPG86c2hhcGVsYXlvdXQgdjpl
eHQ9ImVkaXQiPgo8bzppZG1hcCB2OmV4dD0iZWRpdCIgZGF0YT0iMSIgLz4KPC9vOnNoYXBlbGF5
b3V0PjwveG1sPjwhW2VuZGlmXS0tPgo8L2hlYWQ+Cjxib2R5IGxhbmc9IkVOLVVTIiBsaW5rPSJi
bHVlIiB2bGluaz0icHVycGxlIj4KPGRpdiBjbGFzcz0iV29yZFNlY3Rpb24xIj4KPHAgY2xhc3M9
Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxRjQ5N0QiPk9kZGx5IGVub3VnaCwgaWYg
eW91IHJlbmFtZSB0aGUgcHJlcHJvY2Vzc29yIG91dHB1dCBmaWxlIChzdWNoIGFzIGRzZHQuaSkg
dG8gc29tZXRoaW5nIGxpa2UgZHNkdC50bXAsIGl0IHdpbGwgY29tcGlsZSBjb3JyZWN0bHkuPG86
cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29s
b3I6IzFGNDk3RCI+VGhpcyBtYXkgYmUgYSBxdWljayB3b3JrYXJvdW5kIGZvciB5b3UgdW50aWwg
dGhlIHByb2JsZW0gaXMgZml4ZWQuPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNv
Tm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6IzFGNDk3RCI+Qm9iPG86cD48L286cD48L3NwYW4+
PC9wPgo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6IzFGNDk3RCI+PG86
cD4mbmJzcDs8L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHls
ZT0iY29sb3I6IzFGNDk3RCI+PG86cD4mbmJzcDs8L286cD48L3NwYW4+PC9wPgo8ZGl2IHN0eWxl
PSJib3JkZXI6bm9uZTtib3JkZXItbGVmdDpzb2xpZCBibHVlIDEuNXB0O3BhZGRpbmc6MGluIDBp
biAwaW4gNC4wcHQiPgo8ZGl2Pgo8ZGl2IHN0eWxlPSJib3JkZXI6bm9uZTtib3JkZXItdG9wOnNv
bGlkICNCNUM0REYgMS4wcHQ7cGFkZGluZzozLjBwdCAwaW4gMGluIDBpbiI+CjxwIGNsYXNzPSJN
c29Ob3JtYWwiIHN0eWxlPSJtYXJnaW46MGluO21hcmdpbi1ib3R0b206LjAwMDFwdCI+PGI+PHNw
YW4gc3R5bGU9ImZvbnQtc2l6ZToxMC4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7VGFob21hJnF1b3Q7
LCZxdW90O3NhbnMtc2VyaWYmcXVvdDsiPkZyb206PC9zcGFuPjwvYj48c3BhbiBzdHlsZT0iZm9u
dC1zaXplOjEwLjBwdDtmb250LWZhbWlseTomcXVvdDtUYWhvbWEmcXVvdDssJnF1b3Q7c2Fucy1z
ZXJpZiZxdW90OyI+IGRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZyBbbWFpbHRvOmRldmVsLWJvdW5j
ZXNAYWNwaWNhLm9yZ10KPGI+T24gQmVoYWxmIE9mIDwvYj5Nb29yZSwgUm9iZXJ0PGJyPgo8Yj5T
ZW50OjwvYj4gV2VkbmVzZGF5LCBNYXkgMjIsIDIwMTMgNzo1NCBBTTxicj4KPGI+VG86PC9iPiBB
bGV4ZWkgRmVkb3Jvdjxicj4KPGI+Q2M6PC9iPiBkZXZlbEBhY3BpY2Eub3JnPGJyPgo8Yj5TdWJq
ZWN0OjwvYj4gUmU6IFtEZXZlbF0gLUQgJmx0O3N5bWJvbCZndDsgUHJlcHJvY2Vzc29yIE9wdGlv
biBEb2Vzbid0IFdvcms8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjwvZGl2Pgo8L2Rpdj4KPHAgY2xh
c3M9Ik1zb05vcm1hbCI+PG86cD4mbmJzcDs8L286cD48L3A+CjxwIGNsYXNzPSJNc29Ob3JtYWwi
PjxzcGFuIHN0eWxlPSJjb2xvcjojMUY0OTdEIj5UaGVyZSBkb2VzIHNlZW0gdG8gYmUgYSBwcm9i
bGVtLiBJIHdpbGwgaW52ZXN0aWdhdGUgZnVydGhlciBhbmQgZ2V0IGJhY2sgdG8geW91LjxvOnA+
PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9y
OiMxRjQ5N0QiPkJvYjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPGRpdiBzdHlsZT0iYm9yZGVyOm5v
bmU7Ym9yZGVyLWxlZnQ6c29saWQgYmx1ZSAxLjVwdDtwYWRkaW5nOjBpbiAwaW4gMGluIDQuMHB0
Ij4KPGRpdj4KPGRpdiBzdHlsZT0iYm9yZGVyOm5vbmU7Ym9yZGVyLXRvcDpzb2xpZCAjQjVDNERG
IDEuMHB0O3BhZGRpbmc6My4wcHQgMGluIDBpbiAwaW4iPgo8cCBjbGFzcz0iTXNvTm9ybWFsIiBz
dHlsZT0ibWFyZ2luOjBpbjttYXJnaW4tYm90dG9tOi4wMDAxcHQiPjxiPjxzcGFuIHN0eWxlPSJm
b250LXNpemU6MTAuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O1RhaG9tYSZxdW90OywmcXVvdDtzYW5z
LXNlcmlmJnF1b3Q7Ij5Gcm9tOjwvc3Bhbj48L2I+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMC4w
cHQ7Zm9udC1mYW1pbHk6JnF1b3Q7VGFob21hJnF1b3Q7LCZxdW90O3NhbnMtc2VyaWYmcXVvdDsi
Pgo8YSBocmVmPSJtYWlsdG86ZGV2ZWwtYm91bmNlc0BhY3BpY2Eub3JnIj5kZXZlbC1ib3VuY2Vz
QGFjcGljYS5vcmc8L2E+IFs8YSBocmVmPSJtYWlsdG86ZGV2ZWwtYm91bmNlc0BhY3BpY2Eub3Jn
Ij5tYWlsdG86ZGV2ZWwtYm91bmNlc0BhY3BpY2Eub3JnPC9hPl0KPGI+T24gQmVoYWxmIE9mIDwv
Yj5Nb29yZSwgUm9iZXJ0PGJyPgo8Yj5TZW50OjwvYj4gV2VkbmVzZGF5LCBNYXkgMjIsIDIwMTMg
Njo1MSBBTTxicj4KPGI+VG86PC9iPiBBbGV4ZWkgRmVkb3Jvdjxicj4KPGI+Q2M6PC9iPiA8YSBo
cmVmPSJtYWlsdG86ZGV2ZWxAYWNwaWNhLm9yZyI+ZGV2ZWxAYWNwaWNhLm9yZzwvYT48YnI+Cjxi
PlN1YmplY3Q6PC9iPiBSZTogW0RldmVsXSAtRCAmbHQ7c3ltYm9sJmd0OyBQcmVwcm9jZXNzb3Ig
T3B0aW9uIERvZXNuJ3QgV29yazxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPC9kaXY+CjwvZGl2Pgo8
cCBjbGFzcz0iTXNvTm9ybWFsIj48bzpwPiZuYnNwOzwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb05v
cm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxRjQ5N0QiPkl0IHNob3VsZCwgYnV0IEkgd2lsbCBj
aGVjayBvdXQgeW91ciBjb2RlLjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb05v
cm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxRjQ5N0QiPjxvOnA+Jm5ic3A7PC9vOnA+PC9zcGFu
PjwvcD4KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxRjQ5N0QiPjxv
OnA+Jm5ic3A7PC9vOnA+PC9zcGFuPjwvcD4KPGRpdiBzdHlsZT0iYm9yZGVyOm5vbmU7Ym9yZGVy
LWxlZnQ6c29saWQgYmx1ZSAxLjVwdDtwYWRkaW5nOjBpbiAwaW4gMGluIDQuMHB0Ij4KPGRpdj4K
PGRpdiBzdHlsZT0iYm9yZGVyOm5vbmU7Ym9yZGVyLXRvcDpzb2xpZCAjQjVDNERGIDEuMHB0O3Bh
ZGRpbmc6My4wcHQgMGluIDBpbiAwaW4iPgo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0ibWFy
Z2luOjBpbjttYXJnaW4tYm90dG9tOi4wMDAxcHQiPjxiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6
MTAuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O1RhaG9tYSZxdW90OywmcXVvdDtzYW5zLXNlcmlmJnF1
b3Q7Ij5Gcm9tOjwvc3Bhbj48L2I+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMC4wcHQ7Zm9udC1m
YW1pbHk6JnF1b3Q7VGFob21hJnF1b3Q7LCZxdW90O3NhbnMtc2VyaWYmcXVvdDsiPiBBbGV4ZWkg
RmVkb3JvdiBbPGEgaHJlZj0ibWFpbHRvOkFsZXhlaS5GZWRvcm92QGFybS5jb20iPm1haWx0bzpB
bGV4ZWkuRmVkb3JvdkBhcm0uY29tPC9hPl0KPGJyPgo8Yj5TZW50OjwvYj4gV2VkbmVzZGF5LCBN
YXkgMjIsIDIwMTMgNTo0NiBBTTxicj4KPGI+VG86PC9iPiBNb29yZSwgUm9iZXJ0PGJyPgo8Yj5D
Yzo8L2I+IDxhIGhyZWY9Im1haWx0bzpkZXZlbEBhY3BpY2Eub3JnIj5kZXZlbEBhY3BpY2Eub3Jn
PC9hPjxicj4KPGI+U3ViamVjdDo8L2I+IFJFOiAtRCAmbHQ7c3ltYm9sJmd0OyBQcmVwcm9jZXNz
b3IgT3B0aW9uIERvZXNuJ3QgV29yazxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPC9kaXY+CjwvZGl2
Pgo8cCBjbGFzcz0iTXNvTm9ybWFsIj48bzpwPiZuYnNwOzwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1z
b1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPkhpIFJvYmVydCw8bzpwPjwvbzpwPjwvc3Bh
bj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj48bzpwPiZu
YnNwOzwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9
IkVOLUdCIj5Eb2VzIHByZS1wcm9jZXNzb3Igc3VwcG9ydCB0aGUgbmVzdGVkICNpZiAjZWxzZSAj
ZW5kaWYgc3RhdGVtZW50cz88bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFp
blRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj48bzpwPiZuYnNwOzwvbzpwPjwvc3Bhbj48L3A+Cjxw
IGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj5UaGlzIGNvZGU8bzpwPjwv
bzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdC
Ij48bzpwPiZuYnNwOzwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxz
cGFuIGxhbmc9IkVOLUdCIj5EZWZpbml0aW9uQmxvY2soJnF1b3Q7RFNEVC5BTUwmcXVvdDssICZx
dW90O0RTRFQmcXVvdDssIDB4MDEsICZxdW90OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyAmcXVvdDssICZxdW90OyZuYnNwOyZuYnNwOyZuYnNwOyAmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmcXVvdDssIDMpIHs8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRl
eHQiPjxzcGFuIGxhbmc9IkVOLUdCIj48bzpwPiZuYnNwOzwvbzpwPjwvc3Bhbj48L3A+CjxwIGNs
YXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mbmJzcDsgLy88bzpwPjwvbzpw
Pjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4m
bmJzcDsgLy8mbmJzcDsgU3lzdGVtIEJ1czxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9
Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZuYnNwOyAvLzxvOnA+PC9vOnA+PC9z
cGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZuYnNw
OyBTY29wZShfU0IpIHs8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRl
eHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mbmJzcDsmbmJzcDsmbmJzcDsgLy8gQ1BVczxvOnA+PC9v
OnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0Ii
PiZuYnNwOyZuYnNwOyZuYnNwOyBEZXZpY2UoQ1BVMCkgezxvOnA+PC9vOnA+PC9zcGFuPjwvcD4K
PHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyBOYW1lKF9ISUQsICZxdW90O0FDUEkwMDA3JnF1b3Q7KTxvOnA+PC9v
OnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0Ii
PiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBOYW1lKF9VSUQsIFplcm8pPG86cD48L286
cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+
Jm5ic3A7Jm5ic3A7Jm5ic3A7IH08bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29Q
bGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj48bzpwPiZuYnNwOzwvbzpwPjwvc3Bhbj48L3A+
CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4jaWZkZWYgQ1BVXzE8
bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9
IkVOLUdCIj4mbmJzcDsmbmJzcDsmbmJzcDsgRGV2aWNlKENQVTEpIHs8bzpwPjwvbzpwPjwvc3Bh
bj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mbmJzcDsm
bmJzcDsmbmJzcDsgJm5ic3A7IE5hbWUoX0hJRCwgJnF1b3Q7QUNQSTAwMDcmcXVvdDspPG86cD48
L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1H
QiI+Jm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyBOYW1lKF9VSUQsIE9uZSk8bzpwPjwvbzpwPjwv
c3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mbmJz
cDsmbmJzcDsmbmJzcDsgfTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWlu
VGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiNlbHNlPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBj
bGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+I2lmZGVmIENQVV8yPG86cD48
L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1H
QiI+Jm5ic3A7Jm5ic3A7Jm5ic3A7IERldmljZShDUFUyKSB7PG86cD48L286cD48L3NwYW4+PC9w
Pgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jm5ic3A7Jm5ic3A7
Jm5ic3A7ICZuYnNwOyBOYW1lKF9ISUQsICZxdW90O0FDUEkwMDA3JnF1b3Q7KTxvOnA+PC9vOnA+
PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZu
YnNwOyZuYnNwOyZuYnNwOyAmbmJzcDsgTmFtZShfVUlELCAyKTxvOnA+PC9vOnA+PC9zcGFuPjwv
cD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZuYnNwOyZuYnNw
OyZuYnNwOyB9PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48
c3BhbiBsYW5nPSJFTi1HQiI+I2VuZGlmPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0i
TXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+I2VuZGlmPG86cD48L286cD48L3NwYW4+
PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jm5ic3A7Jm5i
c3A7IDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4g
bGFuZz0iRU4tR0IiPiZuYnNwOyZuYnNwO30gLy8gX1NCPG86cD48L286cD48L3NwYW4+PC9wPgo8
cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+fTxvOnA+PC9vOnA+PC9z
cGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPldoZW4g
Y29tcGxpZWQgd2l0aDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4
dCI+PHNwYW4gbGFuZz0iRU4tR0IiPmlhc2wuZXhlIC1sIC1EIENQVV8xIERzZHQuYXNsPG86cD48
L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1H
QiI+Y2F1c2VzIHRoZSBlcnJvcnMgYmVsb3c6PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFz
cz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+SW50ZWwgQUNQSSBDb21wb25lbnQg
QXJjaGl0ZWN0dXJlPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0
Ij48c3BhbiBsYW5nPSJFTi1HQiI+QVNMIE9wdGltaXppbmcgQ29tcGlsZXIgdmVyc2lvbiAyMDEz
MDUxNy0zMiBbTWF5IDE3IDIwMTNdPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNv
UGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Q29weXJpZ2h0IChjKSAyMDAwIC0gMjAxMyBJ
bnRlbCBDb3Jwb3JhdGlvbjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWlu
VGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPjxvOnA+Jm5ic3A7PC9vOnA+PC9zcGFuPjwvcD4KPHAg
Y2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPkRzZHQuYXNsJm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7IDM3OiAvLzxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1z
b1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPkVycm9yJm5ic3A7Jm5ic3A7Jm5ic3A7IDYx
MjYgLV4gc3ludGF4IGVycm9yLCB1bmV4cGVjdGVkICRlbmQsIGV4cGVjdGluZyBQQVJTRU9QX0RF
RklOSVRJT05CTE9DSzxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4
dCI+PHNwYW4gbGFuZz0iRU4tR0IiPjxvOnA+Jm5ic3A7PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xh
c3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPkRzZHQuYXNsJm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7IDMxOiAjZW5kaWY8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJN
c29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj5FcnJvciZuYnNwOyZuYnNwOyZuYnNwOyA2
MTQyIC0mbmJzcDsgXiBNaXNtYXRjaGVkICNlbmRpZiAoUHJlcHJvY2Vzc29yKTxvOnA+PC9vOnA+
PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPjxv
OnA+Jm5ic3A7PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4g
bGFuZz0iRU4tR0IiPkFTTCBJbnB1dDombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgRHNkdC5hc2wg
LSAzOCBsaW5lcywgMCBieXRlcywgMCBrZXl3b3JkczxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAg
Y2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPkxpc3RpbmcgRmlsZTombmJz
cDsgRHNkdC5sc3QgLSAxOTkgYnl0ZXM8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJN
c29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj48bzpwPiZuYnNwOzwvbzpwPjwvc3Bhbj48
L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj5Db21waWxhdGlv
biBjb21wbGV0ZS4gMiBFcnJvcnMsIDAgV2FybmluZ3MsIDAgUmVtYXJrcywgMCBPcHRpbWl6YXRp
b25zPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBs
YW5nPSJFTi1HQiI+RHNkdC5pIChQcmVwcm9jZXNzb3IgT3V0cHV0IGZpbGUpIENvdWxkIG5vdCBk
ZWxldGU6IFBlcm1pc3Npb24gZGVuaWVkPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0i
TXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+RHNkdC5zcmMgKFNvdXJjZSBPdXRwdXQg
ZmlsZSkgQ291bGQgbm90IGRlbGV0ZTogUGVybWlzc2lvbiBkZW5pZWQ8bzpwPjwvbzpwPjwvc3Bh
bj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
PGJyPgpGcm9tOiBNb29yZSwgUm9iZXJ0IFs8YSBocmVmPSJtYWlsdG86cm9iZXJ0Lm1vb3JlQGlu
dGVsLmNvbSI+bWFpbHRvOnJvYmVydC5tb29yZUBpbnRlbC5jb208L2E+XQo8YnI+ClNlbnQ6IDE3
IE1heSAyMDEzIDIyOjA4PGJyPgpUbzogQWxleGVpIEZlZG9yb3Y8YnI+ClN1YmplY3Q6IFJFOiAt
RCAmbHQ7c3ltYm9sJmd0OyBQcmVwcm9jZXNzb3IgT3B0aW9uIERvZXNuJ3QgV29yazxzcGFuIGxh
bmc9IkVOLUdCIj48bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQi
PjxzcGFuIGxhbmc9IkVOLUdCIj48bzpwPiZuYnNwOzwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNz
PSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj5XZSBkaWQgYSBuZXcgcmVsZWFzZSB0
b2RheSwgc28geW91IGNhbiBqdXN0IGdyYWIgdGhlIHdpbmRvd3MgYmluYXJ5IGZyb20gdGhlIHdl
YnNpdGUuPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3Bh
biBsYW5nPSJFTi1HQiI+VGhlIGZpeCBmb3IgLUQgaXMgaW4gdGhlIHJlbGVhc2UuPG86cD48L286
cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+
PG86cD4mbmJzcDs8L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3Bh
biBsYW5nPSJFTi1HQiI+Qm9iPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxh
aW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+PG86cD4mbmJzcDs8L286cD48L3NwYW4+PC9wPgo8
cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+PG86cD4mbmJzcDs8L286
cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+
Jmd0OyAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAg
Y2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgRnJvbTogPGEgaHJl
Zj0ibWFpbHRvOmRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZyI+CjxzcGFuIHN0eWxlPSJjb2xvcjp3
aW5kb3d0ZXh0O3RleHQtZGVjb3JhdGlvbjpub25lIj5kZXZlbC1ib3VuY2VzQGFjcGljYS5vcmc8
L3NwYW4+PC9hPiBbPGEgaHJlZj0ibWFpbHRvOmRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZyI+PHNw
YW4gc3R5bGU9ImNvbG9yOndpbmRvd3RleHQ7dGV4dC1kZWNvcmF0aW9uOm5vbmUiPm1haWx0bzpk
ZXZlbC1ib3VuY2VzQGFjcGljYS5vcmc8L3NwYW4+PC9hPl0gT24gQmVoYWxmPG86cD48L286cD48
L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0
OyBPZiBBbGV4ZWkgRmVkb3JvdjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1Bs
YWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgU2VudDogRnJpZGF5LCBNYXkgMTcsIDIw
MTMgMzoxNiBBTTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+
PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgVG86IDxhIGhyZWY9Im1haWx0bzpkZXZlbEBhY3BpY2Eu
b3JnIj4KPHNwYW4gc3R5bGU9ImNvbG9yOndpbmRvd3RleHQ7dGV4dC1kZWNvcmF0aW9uOm5vbmUi
PmRldmVsQGFjcGljYS5vcmc8L3NwYW4+PC9hPjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xh
c3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgU3ViamVjdDogUmU6IFtE
ZXZlbF0gLUQgJmx0O3N5bWJvbCZndDsgUHJlcHJvY2Vzc29yIE9wdGlvbiBEb2Vzbid0IFdvcms8
bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9
IkVOLUdCIj4mZ3Q7IDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4
dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgJmd0O1llcywgaXQgbG9va3MgbGlrZSBpdCBoYXMg
YmVlbiB0aGVyZSBhIHdoaWxlLjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1Bs
YWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgJmd0O1lvdSBjYW4gY2hlY2tvdXQgdGhl
IHBhdGNoLCBvciBJIGNhbiBzZW5kIHlvdSBhbiB1cGRhdGVkIHdpbmRvd3MgYmluYXJ5LjxvOnA+
PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4t
R0IiPiZndDsgSGkgUm9iZXJ0LDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1Bs
YWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgUGxlYXNlIHNlbmQgbWUgYW4gdXBkYXRl
ZCBiaW5hcnkuPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48
c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBUaGFua3MuPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBj
bGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4
dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgRnJvbTogPGEgaHJlZj0ibWFpbHRvOmRldmVsLWJv
dW5jZXNAYWNwaWNhLm9yZyI+CjxzcGFuIHN0eWxlPSJjb2xvcjp3aW5kb3d0ZXh0O3RleHQtZGVj
b3JhdGlvbjpub25lIj5kZXZlbC1ib3VuY2VzQGFjcGljYS5vcmc8L3NwYW4+PC9hPiBbPGEgaHJl
Zj0ibWFpbHRvOmRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZyI+PHNwYW4gc3R5bGU9ImNvbG9yOndp
bmRvd3RleHQ7dGV4dC1kZWNvcmF0aW9uOm5vbmUiPm1haWx0bzpkZXZlbC1ib3VuY2VzQGFjcGlj
YS5vcmc8L3NwYW4+PC9hPl0gT24gQmVoYWxmPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFz
cz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBPZiA8YSBocmVmPSJtYWls
dG86ZGV2ZWwtcmVxdWVzdEBhY3BpY2Eub3JnIj4KPHNwYW4gc3R5bGU9ImNvbG9yOndpbmRvd3Rl
eHQ7dGV4dC1kZWNvcmF0aW9uOm5vbmUiPmRldmVsLXJlcXVlc3RAYWNwaWNhLm9yZzwvc3Bhbj48
L2E+PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBs
YW5nPSJFTi1HQiI+Jmd0OyBTZW50OiAxNiBNYXkgMjAxMyAxODowOTxvOnA+PC9vOnA+PC9zcGFu
PjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgVG86
IDxhIGhyZWY9Im1haWx0bzpkZXZlbEBhY3BpY2Eub3JnIj4KPHNwYW4gc3R5bGU9ImNvbG9yOndp
bmRvd3RleHQ7dGV4dC1kZWNvcmF0aW9uOm5vbmUiPmRldmVsQGFjcGljYS5vcmc8L3NwYW4+PC9h
PjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFu
Zz0iRU4tR0IiPiZndDsgU3ViamVjdDogRGV2ZWwgRGlnZXN0LCBWb2wgMzgsIElzc3VlIDU8bzpw
PjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVO
LUdCIj4mZ3Q7IDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+
PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgU2VuZCBEZXZlbCBtYWlsaW5nIGxpc3Qgc3VibWlzc2lv
bnMgdG88bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFu
IGxhbmc9IkVOLUdCIj4mZ3Q7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7IDxhIGhyZWY9Im1haWx0bzpkZXZlbEBhY3BpY2Eub3JnIj4KPHNwYW4gc3R5bGU9
ImNvbG9yOndpbmRvd3RleHQ7dGV4dC1kZWNvcmF0aW9uOm5vbmUiPmRldmVsQGFjcGljYS5vcmc8
L3NwYW4+PC9hPjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+
PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0i
TXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBUbyBzdWJzY3JpYmUgb3IgdW5z
dWJzY3JpYmUgdmlhIHRoZSBXb3JsZCBXaWRlIFdlYiwgdmlzaXQ8bzpwPjwvbzpwPjwvc3Bhbj48
L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IDxhIGhyZWY9Imh0dHBz
Oi8vbGlzdHMuYWNwaWNhLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RldmVsIj4KPHNwYW4gc3R5bGU9
ImNvbG9yOndpbmRvd3RleHQ7dGV4dC1kZWNvcmF0aW9uOm5vbmUiPmh0dHBzOi8vbGlzdHMuYWNw
aWNhLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RldmVsPC9zcGFuPjwvYT48bzpwPjwvbzpwPjwvc3Bh
bj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IG9y
LCB2aWEgZW1haWwsIHNlbmQgYSBtZXNzYWdlIHdpdGggc3ViamVjdCBvciBib2R5ICdoZWxwJyB0
bzxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFu
Zz0iRU4tR0IiPiZndDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsgPGEgaHJlZj0ibWFpbHRvOmRldmVsLXJlcXVlc3RAYWNwaWNhLm9yZyI+CjxzcGFuIHN0
eWxlPSJjb2xvcjp3aW5kb3d0ZXh0O3RleHQtZGVjb3JhdGlvbjpub25lIj5kZXZlbC1yZXF1ZXN0
QGFjcGljYS5vcmc8L3NwYW4+PC9hPjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1z
b1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgPG86cD48L286cD48L3NwYW4+PC9w
Pgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBZb3UgY2Fu
IHJlYWNoIHRoZSBwZXJzb24gbWFuYWdpbmcgdGhlIGxpc3QgYXQ8bzpwPjwvbzpwPjwvc3Bhbj48
L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IDxhIGhyZWY9Im1haWx0
bzpkZXZlbC1vd25lckBhY3BpY2Eub3JnIj4KPHNwYW4gc3R5bGU9ImNvbG9yOndpbmRvd3RleHQ7
dGV4dC1kZWNvcmF0aW9uOm5vbmUiPmRldmVsLW93bmVyQGFjcGljYS5vcmc8L3NwYW4+PC9hPjxv
OnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0i
RU4tR0IiPiZndDsgPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0
Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBXaGVuIHJlcGx5aW5nLCBwbGVhc2UgZWRpdCB5b3Vy
IFN1YmplY3QgbGluZSBzbyBpdCBpcyBtb3JlIHNwZWNpZmljIHRoYW48bzpwPjwvbzpwPjwvc3Bh
bj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7ICZx
dW90O1JlOiBDb250ZW50cyBvZiBEZXZlbCBkaWdlc3QuLi4mcXVvdDs8bzpwPjwvbzpwPjwvc3Bh
bj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IDxv
OnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0i
RU4tR0IiPiZndDsgPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0
Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBUb2RheSdzIFRvcGljczo8bzpwPjwvbzpwPjwvc3Bh
bj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IDxv
OnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0i
RU4tR0IiPiZndDsmbmJzcDsmbmJzcDsmbmJzcDsgMS4gUmU6IC1EICZsdDtzeW1ib2wmZ3Q7IFBy
ZXByb2Nlc3NvciBPcHRpb24gRG9lc24ndCBXb3JrIChNb29yZSwgUm9iZXJ0KTxvOnA+PC9vOnA+
PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZn
dDsmbmJzcDsmbmJzcDsmbmJzcDsgMi4gUmU6IC1EICZsdDtzeW1ib2wmZ3Q7IFByZXByb2Nlc3Nv
ciBPcHRpb24gRG9lc24ndCBXb3JrIChNb29yZSwgUm9iZXJ0KTxvOnA+PC9vOnA+PC9zcGFuPjwv
cD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgPG86cD48
L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1H
QiI+Jmd0OyA8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxz
cGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08bzpwPjwvbzpwPjwvc3Bhbj48L3A+
CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IDxvOnA+PC9v
OnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0Ii
PiZndDsgTWVzc2FnZTogMTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWlu
VGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgRGF0ZTogVGh1LCAxNiBNYXkgMjAxMyAxNTo1
OToxNyAmIzQzOzAwMDA8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRl
eHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IEZyb206ICZxdW90O01vb3JlLCBSb2JlcnQmcXVv
dDsgJmx0OzxhIGhyZWY9Im1haWx0bzpyb2JlcnQubW9vcmVAaW50ZWwuY29tIj48c3BhbiBzdHls
ZT0iY29sb3I6d2luZG93dGV4dDt0ZXh0LWRlY29yYXRpb246bm9uZSI+cm9iZXJ0Lm1vb3JlQGlu
dGVsLmNvbTwvc3Bhbj48L2E+Jmd0OzxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1z
b1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgVG86IEFsZXhlaSBGZWRvcm92ICZs
dDs8YSBocmVmPSJtYWlsdG86QWxleGVpLkZlZG9yb3ZAYXJtLmNvbSI+PHNwYW4gc3R5bGU9ImNv
bG9yOndpbmRvd3RleHQ7dGV4dC1kZWNvcmF0aW9uOm5vbmUiPkFsZXhlaS5GZWRvcm92QGFybS5j
b208L3NwYW4+PC9hPiZndDssICZxdW90OzxhIGhyZWY9Im1haWx0bzpkZXZlbEBhY3BpY2Eub3Jn
Ij48c3BhbiBzdHlsZT0iY29sb3I6d2luZG93dGV4dDt0ZXh0LWRlY29yYXRpb246bm9uZSI+ZGV2
ZWxAYWNwaWNhLm9yZzwvc3Bhbj48L2E+JnF1b3Q7PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBj
bGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAmbHQ7PGEgaHJlZj0ibWFpbHRvOmRl
dmVsQGFjcGljYS5vcmciPjxzcGFuIHN0eWxlPSJjb2xvcjp3aW5kb3d0ZXh0O3RleHQtZGVjb3Jh
dGlvbjpub25lIj5kZXZlbEBhY3BpY2Eub3JnPC9zcGFuPjwvYT4mZ3Q7PG86cD48L286cD48L3Nw
YW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBT
dWJqZWN0OiBSZTogW0RldmVsXSAtRCAmbHQ7c3ltYm9sJmd0OyBQcmVwcm9jZXNzb3IgT3B0aW9u
IERvZXNuJ3QgV29yazxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4
dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgTWVzc2FnZS1JRDo8bzpwPjwvbzpwPjwvc3Bhbj48
L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IDxvOnA+
PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4t
R0IiPiZndDsgJmx0OzxhIGhyZWY9Im1haWx0bzo5NEYyRkJBQjQ0MzJCNTRFOEFBQ0M3REZERTZD
OTJFMzZGRTZDMzIxQE9SU01TWDEwMy5hbXIuY29ycC5pbnRlbC5jb20iPjxzcGFuIHN0eWxlPSJj
b2xvcjp3aW5kb3d0ZXh0O3RleHQtZGVjb3JhdGlvbjpub25lIj45NEYyRkJBQjQ0MzJCNTRFOEFB
Q0M3REZERTZDOTJFMzZGRTZDMzIxQE9SU01TWDEwMy5hbXIuY29ycC5pbnRlbC5jb208L3NwYW4+
PC9hPiZndDs8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxz
cGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1z
b1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgQ29udGVudC1UeXBlOiB0ZXh0L3Bs
YWluOyBjaGFyc2V0PSZxdW90O3VzLWFzY2lpJnF1b3Q7PG86cD48L286cD48L3NwYW4+PC9wPgo8
cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyA8bzpwPjwvbzpw
Pjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4m
Z3Q7IFRoZSBmaXggZm9yIHRoaXMgaXMgY2hlY2tlZCBpbnRvIG91ciBnaXQgdHJlZS48bzpwPjwv
bzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdC
Ij4mZ3Q7IEJvYjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+
PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgRnJvbTogPGEgaHJlZj0ibWFpbHRvOmRldmVsLWJvdW5j
ZXNAYWNwaWNhLm9yZyI+CjxzcGFuIHN0eWxlPSJjb2xvcjp3aW5kb3d0ZXh0O3RleHQtZGVjb3Jh
dGlvbjpub25lIj5kZXZlbC1ib3VuY2VzQGFjcGljYS5vcmc8L3NwYW4+PC9hPiBbPGEgaHJlZj0i
bWFpbHRvOmRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZyI+PHNwYW4gc3R5bGU9ImNvbG9yOndpbmRv
d3RleHQ7dGV4dC1kZWNvcmF0aW9uOm5vbmUiPm1haWx0bzpkZXZlbC1ib3VuY2VzQGFjcGljYS5v
cmc8L3NwYW4+PC9hPl0gT24gQmVoYWxmPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0i
TXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBPZiBNb29yZSwgUm9iZXJ0PG86
cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJF
Ti1HQiI+Jmd0OyBTZW50OiBXZWRuZXNkYXksIE1heSAxNSwgMjAxMyAxMDozMyBBTTxvOnA+PC9v
OnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0Ii
PiZndDsgVG86IEFsZXhlaSBGZWRvcm92OyA8YSBocmVmPSJtYWlsdG86ZGV2ZWxAYWNwaWNhLm9y
ZyI+CjxzcGFuIHN0eWxlPSJjb2xvcjp3aW5kb3d0ZXh0O3RleHQtZGVjb3JhdGlvbjpub25lIj5k
ZXZlbEBhY3BpY2Eub3JnPC9zcGFuPjwvYT48bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNz
PSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IFN1YmplY3Q6IFJlOiBbRGV2
ZWxdIC1EICZsdDtzeW1ib2wmZ3Q7IFByZXByb2Nlc3NvciBPcHRpb24gRG9lc24ndCBXb3JrPG86
cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJF
Ti1HQiI+Jmd0OyA8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQi
PjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IFNvcnJ5LCB3ZSBkaWQgc29tZSBjb2RlIHJlc3RydWN0
dXJpbmcgYW5kIGJyb2tlIHRoaXMuIFlvdSBjYW4gZ28gYmFjayB0bzxvOnA+PC9vOnA+PC9zcGFu
PjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgYW4g
ZWFybGllciB2ZXJzaW9uIG9mIHRoZSBjb21waWxlciwgb3Igd2FpdCB1bnRpbCBsYXRlciB0aGlz
IHdlZWsgd2hlbjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+
PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgdGhlcmUgd2lsbCBiZSBhIG5ldyB2ZXJzaW9uLjxvOnA+
PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4t
R0IiPiZndDsgQm9iPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0
Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBGcm9tOiA8YSBocmVmPSJtYWlsdG86ZGV2ZWwtYm91
bmNlc0BhY3BpY2Eub3JnJTNjbWFpbHRvOmRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZyI+CjxzcGFu
IHN0eWxlPSJjb2xvcjp3aW5kb3d0ZXh0O3RleHQtZGVjb3JhdGlvbjpub25lIj5kZXZlbC1ib3Vu
Y2VzQGFjcGljYS5vcmcmbHQ7bWFpbHRvOmRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZzwvc3Bhbj48
L2E+Jmd0OzxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNw
YW4gbGFuZz0iRU4tR0IiPiZndDsgWzxhIGhyZWY9Im1haWx0bzpkZXZlbC1ib3VuY2VzQGFjcGlj
YS5vcmciPjxzcGFuIHN0eWxlPSJjb2xvcjp3aW5kb3d0ZXh0O3RleHQtZGVjb3JhdGlvbjpub25l
Ij5tYWlsdG86ZGV2ZWwtYm91bmNlc0BhY3BpY2Eub3JnPC9zcGFuPjwvYT5dIE9uIEJlaGFsZiBP
ZiBNb29yZSwgUm9iZXJ0PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5U
ZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBTZW50OiBXZWRuZXNkYXksIE1heSAxNSwgMjAx
MyA4OjQzIEFNPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48
c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBUbzogQWxleGVpIEZlZG9yb3Y7IDxhIGhyZWY9Im1haWx0
bzpkZXZlbEBhY3BpY2Eub3JnJTNjbWFpbHRvOmRldmVsQGFjcGljYS5vcmciPgo8c3BhbiBzdHls
ZT0iY29sb3I6d2luZG93dGV4dDt0ZXh0LWRlY29yYXRpb246bm9uZSI+ZGV2ZWxAYWNwaWNhLm9y
ZyZsdDttYWlsdG86ZGV2ZWxAYWNwaWNhLm9yZzwvc3Bhbj48L2E+Jmd0OzxvOnA+PC9vOnA+PC9z
cGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsg
U3ViamVjdDogUmU6IFtEZXZlbF0gLUQgJmx0O3N5bWJvbCZndDsgUHJlcHJvY2Vzc29yIE9wdGlv
biBEb2Vzbid0IFdvcms8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRl
eHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xh
c3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgV2Ugd2lsbCBjaGVjayBp
dCBvdXQuPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3Bh
biBsYW5nPSJFTi1HQiI+Jmd0OyBUaGFua3MsPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFz
cz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBCb2I8bzpwPjwvbzpwPjwv
c3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7
IEZyb206IDxhIGhyZWY9Im1haWx0bzpkZXZlbC1ib3VuY2VzQGFjcGljYS5vcmclM2NtYWlsdG86
ZGV2ZWwtYm91bmNlc0BhY3BpY2Eub3JnIj4KPHNwYW4gc3R5bGU9ImNvbG9yOndpbmRvd3RleHQ7
dGV4dC1kZWNvcmF0aW9uOm5vbmUiPmRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZyZsdDttYWlsdG86
ZGV2ZWwtYm91bmNlc0BhY3BpY2Eub3JnPC9zcGFuPjwvYT4mZ3Q7PG86cD48L286cD48L3NwYW4+
PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBbPGEg
aHJlZj0ibWFpbHRvOmRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZyI+PHNwYW4gc3R5bGU9ImNvbG9y
OndpbmRvd3RleHQ7dGV4dC1kZWNvcmF0aW9uOm5vbmUiPm1haWx0bzpkZXZlbC1ib3VuY2VzQGFj
cGljYS5vcmc8L3NwYW4+PC9hPl0gT24gQmVoYWxmIE9mIEFsZXhlaSBGZWRvcm92PG86cD48L286
cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+
Jmd0OyBTZW50OiBUdWVzZGF5LCBNYXkgMTQsIDIwMTMgNToyNyBBTTxvOnA+PC9vOnA+PC9zcGFu
PjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgVG86
IDxhIGhyZWY9Im1haWx0bzpkZXZlbEBhY3BpY2Eub3JnJTNjbWFpbHRvOmRldmVsQGFjcGljYS5v
cmciPgo8c3BhbiBzdHlsZT0iY29sb3I6d2luZG93dGV4dDt0ZXh0LWRlY29yYXRpb246bm9uZSI+
ZGV2ZWxAYWNwaWNhLm9yZyZsdDttYWlsdG86ZGV2ZWxAYWNwaWNhLm9yZzwvc3Bhbj48L2E+Jmd0
OzxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFu
Zz0iRU4tR0IiPiZndDsgU3ViamVjdDogW0RldmVsXSAtRCAmbHQ7c3ltYm9sJmd0OyBQcmVwcm9j
ZXNzb3IgT3B0aW9uIERvZXNuJ3QgV29yazxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9
Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgPG86cD48L286cD48L3NwYW4+
PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBIaSw8
bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9
IkVOLUdCIj4mZ3Q7IDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4
dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgQVNMIFVzZXIgR3VpZGUgc3RhdGVzIHRoYXQgI2lm
ZGVmIHN0YXRlbWVudHMgYXJlIHJlY29nbml6ZWQgd2hlbiBhIHN5bWJvbDxvOnA+PC9vOnA+PC9z
cGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsg
aXMgZGVmaW5lZCBpbiB0aGUgY29tbWFuZCBsaW5lOjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAg
Y2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgPG86cD48L286cD48
L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0
OyAmcXVvdDszLjMuMi4yICNpZmRlZjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1z
b1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgVXNhZ2U6PG86cD48L286cD48L3Nw
YW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyAj
aWZkZWYgc3ltYm9sPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0
Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBDb25kaXRpb25hbGx5IGNvbXBpbGUgYSBibG9jayBv
ZiB0ZXh0LiBUaGUgYmxvY2sgaXMgaW5jbHVkZWQgaW4gdGhlPG86cD48L286cD48L3NwYW4+PC9w
Pgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBjb21waWxh
dGlvbiBpZiB0aGUgc3ltYm9sIGlzIGRlZmluZWQsIGVpdGhlciBmcm9tIGEgI2RlZmluZSBvciBm
cm9tIHRoZSAtPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48
c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBEIGNvbW1hbmQgbGluZSBvcHRpb24mcXVvdDs8bzpwPjwv
bzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdC
Ij4mZ3Q7IDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNw
YW4gbGFuZz0iRU4tR0IiPiZndDsgYnV0IEkgY2Fubm90IG1ha2UgQVNMIENvbXBpbGVyIHRvIHJl
Y29nbml6ZSB0aGUgZm9sbG93aW5nIG9wdGlvbjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xh
c3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsmbmJzcDsmbmJzcDsgLUQg
Jmx0O3N5bWJvbCZndDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgRGVmaW5l
IHN5bWJvbCBmb3IgcHJlcHJvY2Vzc29yIHVzZTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xh
c3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgPG86cD48L286cD48L3Nw
YW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBJ
biB0aGUgZXhhbXBsZSBiZWxvdzxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1Bs
YWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgPG86cD48L286cD48L3NwYW4+PC9wPgo8
cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBEZWZpbml0aW9u
QmxvY2soJnF1b3Q7RFNEVC5BTUwmcXVvdDssICZxdW90O0RTRFQmcXVvdDssIDB4MDEsICZxdW90
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAmcXVvdDssICZxdW90OyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAmcXVvdDssIDMpIHs8bzpwPjwvbzpwPjwv
c3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7
Jm5ic3A7Jm5ic3A7IFNjb3BlKF9TQikgezxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9
Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsgRGV2aWNlKENQVTApIHs8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29Q
bGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7IE5hbWUoX0hJRCwgJnF1b3Q7QUNQSTAwMDcmcXVvdDspPG86cD48L286cD48
L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBOYW1lKF9VSUQsIFplcm8pPG86
cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJF
Ti1HQiI+Jmd0OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB9PG86cD48L286cD48L3NwYW4+PC9w
Pgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyAjaWZkZWYg
Q1BVXzE8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFu
IGxhbmc9IkVOLUdCIj4mZ3Q7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IERldmljZShDUFUxKSB7
PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5n
PSJFTi1HQiI+Jmd0OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBOYW1lKF9ISUQsICZxdW90
O0FDUEkwMDA3JnF1b3Q7KTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWlu
VGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsg
TmFtZShfVUlELCBPbmUpPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5U
ZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB9PG86
cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJF
Ti1HQiI+Jmd0OyAjZW5kaWY8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFp
blRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7Jm5ic3A7Jm5ic3A7IH08bzpwPjwvbzpwPjwv
c3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7
IH08bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxh
bmc9IkVOLUdCIj4mZ3Q7IDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWlu
VGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgVGhlIHNlY3Rpb24gYmV0d2VlbiAjaWZkZWYg
Q1BVXzEgLi4uICNlbmRpZiBpcyBub3QgYmVpbmcgY29tcGlsZWQgd2hlbiBBU0w8bzpwPjwvbzpw
Pjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4m
Z3Q7IGlzIGludm9rZWQgYXM6PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxh
aW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBpYXNsLmV4ZSAtbCAtRCBDUFVfMSBEc2R0
LmFzbDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4g
bGFuZz0iRU4tR0IiPiZndDsgQ2hlY2tlZCB3aXRoIHRoZSBsYXRlc3QgdmVyc2lvbiAyMDEzMDQx
OC0zMiBbQXByIDE4IDIwMTNdLjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1Bs
YWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgPG86cD48L286cD48L3NwYW4+PC9wPgo8
cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBBbnkgdGhvdWdo
dHMgb24gd2hhdCBtaWdodCBiZSBnb2luZyB3cm9uZyBoZXJlPzxvOnA+PC9vOnA+PC9zcGFuPjwv
cD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgVGhhbmtz
LjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFu
Zz0iRU4tR0IiPiZndDsgPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5U
ZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyA8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNs
YXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IDxvOnA+PC9vOnA+PC9z
cGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsg
LS0gSU1QT1JUQU5UIE5PVElDRTogVGhlIGNvbnRlbnRzIG9mIHRoaXMgZW1haWwgYW5kIGFueSBh
dHRhY2htZW50cyBhcmU8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRl
eHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IGNvbmZpZGVudGlhbCBhbmQgbWF5IGFsc28gYmUg
cHJpdmlsZWdlZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkPG86cD48L286cD48L3NwYW4+
PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyByZWNp
cGllbnQsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVseSBhbmQgZG8gbm90IGRp
c2Nsb3NlIHRoZTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+
PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgY29udGVudHMgdG8gYW55IG90aGVyIHBlcnNvbiwgdXNl
IGl0IGZvciBhbnkgcHVycG9zZSwgb3Igc3RvcmUgb3IgY29weSB0aGU8bzpwPjwvbzpwPjwvc3Bh
bj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IGlu
Zm9ybWF0aW9uIGluIGFueSBtZWRpdW0uIFRoYW5rIHlvdS48bzpwPjwvbzpwPjwvc3Bhbj48L3A+
CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IC0tLS0tLS0t
LS0tLS0tIG5leHQgcGFydCAtLS0tLS0tLS0tLS0tLTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAg
Y2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgQW4gSFRNTCBhdHRh
Y2htZW50IHdhcyBzY3J1YmJlZC4uLjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1z
b1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgVVJMOjxvOnA+PC9vOnA+PC9zcGFu
PjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgJmx0
O2h0dHA6Ly9saXN0cy5hY3BpY2Eub3JnL3BpcGVybWFpbC9kZXZlbC9hdHRhY2htZW50cy8yMDEz
MDUxNi82Y2M2NDhjYi9hdHQ8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFp
blRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IGFjaG1lbnQtMDAwMS5odG1sJmd0OzxvOnA+
PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4t
R0IiPiZndDsgPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48
c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08bzpw
PjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVO
LUdCIj4mZ3Q7IDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+
PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgTWVzc2FnZTogMjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4K
PHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgRGF0ZTogVGh1
LCAxNiBNYXkgMjAxMyAxNzoxMjo0NCAmIzQzOzAwMDA8bzpwPjwvbzpwPjwvc3Bhbj48L3A+Cjxw
IGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IEZyb206ICZxdW90
O01vb3JlLCBSb2JlcnQmcXVvdDsgJmx0OzxhIGhyZWY9Im1haWx0bzpyb2JlcnQubW9vcmVAaW50
ZWwuY29tIj48c3BhbiBzdHlsZT0iY29sb3I6d2luZG93dGV4dDt0ZXh0LWRlY29yYXRpb246bm9u
ZSI+cm9iZXJ0Lm1vb3JlQGludGVsLmNvbTwvc3Bhbj48L2E+Jmd0OzxvOnA+PC9vOnA+PC9zcGFu
PjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgVG86
IEFsZXhlaSBGZWRvcm92ICZsdDs8YSBocmVmPSJtYWlsdG86QWxleGVpLkZlZG9yb3ZAYXJtLmNv
bSI+PHNwYW4gc3R5bGU9ImNvbG9yOndpbmRvd3RleHQ7dGV4dC1kZWNvcmF0aW9uOm5vbmUiPkFs
ZXhlaS5GZWRvcm92QGFybS5jb208L3NwYW4+PC9hPiZndDssICZxdW90OzxhIGhyZWY9Im1haWx0
bzpkZXZlbEBhY3BpY2Eub3JnIj48c3BhbiBzdHlsZT0iY29sb3I6d2luZG93dGV4dDt0ZXh0LWRl
Y29yYXRpb246bm9uZSI+ZGV2ZWxAYWNwaWNhLm9yZzwvc3Bhbj48L2E+JnF1b3Q7PG86cD48L286
cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+
Jmd0OyZuYnNwOyZuYnNwOyAmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbHQ7
PGEgaHJlZj0ibWFpbHRvOmRldmVsQGFjcGljYS5vcmciPjxzcGFuIHN0eWxlPSJjb2xvcjp3aW5k
b3d0ZXh0O3RleHQtZGVjb3JhdGlvbjpub25lIj5kZXZlbEBhY3BpY2Eub3JnPC9zcGFuPjwvYT4m
Z3Q7PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBs
YW5nPSJFTi1HQiI+Jmd0OyBTdWJqZWN0OiBSZTogW0RldmVsXSAtRCAmbHQ7c3ltYm9sJmd0OyBQ
cmVwcm9jZXNzb3IgT3B0aW9uIERvZXNuJ3QgV29yazxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAg
Y2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgTWVzc2FnZS1JRDo8
bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9
IkVOLUdCIj4mZ3Q7IDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4
dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgJmx0OzxhIGhyZWY9Im1haWx0bzo5NEYyRkJBQjQ0
MzJCNTRFOEFBQ0M3REZERTZDOTJFMzZGRTZDM0I1QE9SU01TWDEwMy5hbXIuY29ycC5pbnRlbC5j
b20iPjxzcGFuIHN0eWxlPSJjb2xvcjp3aW5kb3d0ZXh0O3RleHQtZGVjb3JhdGlvbjpub25lIj45
NEYyRkJBQjQ0MzJCNTRFOEFBQ0M3REZERTZDOTJFMzZGRTZDM0I1QE9SU01TWDEwMy5hbXIuY29y
cC5pbnRlbC5jb208L3NwYW4+PC9hPiZndDs8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNz
PSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IDxvOnA+PC9vOnA+PC9zcGFu
PjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgQ29u
dGVudC1UeXBlOiB0ZXh0L3BsYWluOyBjaGFyc2V0PSZxdW90O3VzLWFzY2lpJnF1b3Q7PG86cD48
L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1H
QiI+Jmd0OyA8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxz
cGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IFllcywgaXQgbG9va3MgbGlrZSBpdCBoYXMgYmVlbiB0aGVy
ZSBhIHdoaWxlLjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+
PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgWW91IGNhbiBjaGVja291dCB0aGUgcGF0Y2gsIG9yIEkg
Y2FuIHNlbmQgeW91IGFuIHVwZGF0ZWQgd2luZG93cyBiaW5hcnkuPG86cD48L286cD48L3NwYW4+
PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyA8bzpw
PjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVO
LUdCIj4mZ3Q7IDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+
PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgRnJvbTogQWxleGVpIEZlZG9yb3YgWzxhIGhyZWY9Im1h
aWx0bzpBbGV4ZWkuRmVkb3JvdkBhcm0uY29tIj48c3BhbiBzdHlsZT0iY29sb3I6d2luZG93dGV4
dDt0ZXh0LWRlY29yYXRpb246bm9uZSI+bWFpbHRvOkFsZXhlaS5GZWRvcm92QGFybS5jb208L3Nw
YW4+PC9hPl08bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxz
cGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IFNlbnQ6IFRodXJzZGF5LCBNYXkgMTYsIDIwMTMgMzoxNyBB
TTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFu
Zz0iRU4tR0IiPiZndDsgVG86IE1vb3JlLCBSb2JlcnQ7IDxhIGhyZWY9Im1haWx0bzpkZXZlbEBh
Y3BpY2Eub3JnIj4KPHNwYW4gc3R5bGU9ImNvbG9yOndpbmRvd3RleHQ7dGV4dC1kZWNvcmF0aW9u
Om5vbmUiPmRldmVsQGFjcGljYS5vcmc8L3NwYW4+PC9hPjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4K
PHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgU3ViamVjdDog
UkU6IC1EICZsdDtzeW1ib2wmZ3Q7IFByZXByb2Nlc3NvciBPcHRpb24gRG9lc24ndCBXb3JrPG86
cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJF
Ti1HQiI+Jmd0OyA8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQi
PjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IEhpIFJvYmVydCw8bzpwPjwvbzpwPjwvc3Bhbj48L3A+
CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IEkgdHJpZWQg
dGhhdCB3aXRoIDQgcHJldmlvdXMgdmVyc2lvbnMgb2YgY29tcGlsZXIgJmFtcDsgc3RpbGwgZ290
IHRoZSBzYW1lPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48
c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBpc3N1ZS48bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNs
YXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IFJlZ2FyZHMuPG86cD48
L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1H
QiI+Jmd0OyBBbGV4ZWkuPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5U
ZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyA8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNs
YXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IEZyb206IE1vb3JlLCBS
b2JlcnQgWzxhIGhyZWY9Im1haWx0bzpyb2JlcnQubW9vcmVAaW50ZWwuY29tIj48c3BhbiBzdHls
ZT0iY29sb3I6d2luZG93dGV4dDt0ZXh0LWRlY29yYXRpb246bm9uZSI+bWFpbHRvOnJvYmVydC5t
b29yZUBpbnRlbC5jb208L3NwYW4+PC9hPl08bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNz
PSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IFNlbnQ6IDE1IE1heSAyMDEz
IDE4OjMzPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3Bh
biBsYW5nPSJFTi1HQiI+Jmd0OyBUbzogQWxleGVpIEZlZG9yb3Y7IDxhIGhyZWY9Im1haWx0bzpk
ZXZlbEBhY3BpY2Eub3JnJTNjbWFpbHRvOmRldmVsQGFjcGljYS5vcmciPgo8c3BhbiBzdHlsZT0i
Y29sb3I6d2luZG93dGV4dDt0ZXh0LWRlY29yYXRpb246bm9uZSI+ZGV2ZWxAYWNwaWNhLm9yZyZs
dDttYWlsdG86ZGV2ZWxAYWNwaWNhLm9yZzwvc3Bhbj48L2E+Jmd0OzxvOnA+PC9vOnA+PC9zcGFu
PjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgU3Vi
amVjdDogUkU6IC1EICZsdDtzeW1ib2wmZ3Q7IFByZXByb2Nlc3NvciBPcHRpb24gRG9lc24ndCBX
b3JrPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBs
YW5nPSJFTi1HQiI+Jmd0OyA8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFp
blRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IFNvcnJ5LCB3ZSBkaWQgc29tZSBjb2RlIHJl
c3RydWN0dXJpbmcgYW5kIGJyb2tlIHRoaXMuIFlvdSBjYW4gZ28gYmFjayB0bzxvOnA+PC9vOnA+
PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZn
dDsgYW4gZWFybGllciB2ZXJzaW9uIG9mIHRoZSBjb21waWxlciwgb3Igd2FpdCB1bnRpbCBsYXRl
ciB0aGlzIHdlZWsgd2hlbjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWlu
VGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgdGhlcmUgd2lsbCBiZSBhIG5ldyB2ZXJzaW9u
LjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFu
Zz0iRU4tR0IiPiZndDsgQm9iPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxh
aW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBGcm9tOiA8YSBocmVmPSJtYWlsdG86ZGV2
ZWwtYm91bmNlc0BhY3BpY2Eub3JnJTNjbWFpbHRvOmRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZyI+
CjxzcGFuIHN0eWxlPSJjb2xvcjp3aW5kb3d0ZXh0O3RleHQtZGVjb3JhdGlvbjpub25lIj5kZXZl
bC1ib3VuY2VzQGFjcGljYS5vcmcmbHQ7bWFpbHRvOmRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZzwv
c3Bhbj48L2E+Jmd0OzxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4
dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgWzxhIGhyZWY9Im1haWx0bzpkZXZlbC1ib3VuY2Vz
QGFjcGljYS5vcmciPjxzcGFuIHN0eWxlPSJjb2xvcjp3aW5kb3d0ZXh0O3RleHQtZGVjb3JhdGlv
bjpub25lIj5tYWlsdG86ZGV2ZWwtYm91bmNlc0BhY3BpY2Eub3JnPC9zcGFuPjwvYT5dIE9uIEJl
aGFsZiBPZiBNb29yZSwgUm9iZXJ0PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNv
UGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBTZW50OiBXZWRuZXNkYXksIE1heSAx
NSwgMjAxMyA4OjQzIEFNPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5U
ZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBUbzogQWxleGVpIEZlZG9yb3Y7IDxhIGhyZWY9
Im1haWx0bzpkZXZlbEBhY3BpY2Eub3JnJTNjbWFpbHRvOmRldmVsQGFjcGljYS5vcmciPgo8c3Bh
biBzdHlsZT0iY29sb3I6d2luZG93dGV4dDt0ZXh0LWRlY29yYXRpb246bm9uZSI+ZGV2ZWxAYWNw
aWNhLm9yZyZsdDttYWlsdG86ZGV2ZWxAYWNwaWNhLm9yZzwvc3Bhbj48L2E+Jmd0OzxvOnA+PC9v
OnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0Ii
PiZndDsgU3ViamVjdDogUmU6IFtEZXZlbF0gLUQgJmx0O3N5bWJvbCZndDsgUHJlcHJvY2Vzc29y
IE9wdGlvbiBEb2Vzbid0IFdvcms8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29Q
bGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4K
PHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgV2Ugd2lsbCBj
aGVjayBpdCBvdXQuPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0
Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBUaGFua3MsPG86cD48L286cD48L3NwYW4+PC9wPgo8
cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBCb2I8bzpwPjwv
bzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdC
Ij4mZ3Q7IEZyb206IDxhIGhyZWY9Im1haWx0bzpkZXZlbC1ib3VuY2VzQGFjcGljYS5vcmclM2Nt
YWlsdG86ZGV2ZWwtYm91bmNlc0BhY3BpY2Eub3JnIj4KPHNwYW4gc3R5bGU9ImNvbG9yOndpbmRv
d3RleHQ7dGV4dC1kZWNvcmF0aW9uOm5vbmUiPmRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZyZsdDtt
YWlsdG86ZGV2ZWwtYm91bmNlc0BhY3BpY2Eub3JnPC9zcGFuPjwvYT4mZ3Q7PG86cD48L286cD48
L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0
OyBbPGEgaHJlZj0ibWFpbHRvOmRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZyI+PHNwYW4gc3R5bGU9
ImNvbG9yOndpbmRvd3RleHQ7dGV4dC1kZWNvcmF0aW9uOm5vbmUiPm1haWx0bzpkZXZlbC1ib3Vu
Y2VzQGFjcGljYS5vcmc8L3NwYW4+PC9hPl0gT24gQmVoYWxmIE9mIEFsZXhlaSBGZWRvcm92PG86
cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJF
Ti1HQiI+Jmd0OyBTZW50OiBUdWVzZGF5LCBNYXkgMTQsIDIwMTMgNToyNyBBTTxvOnA+PC9vOnA+
PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZn
dDsgVG86IDxhIGhyZWY9Im1haWx0bzpkZXZlbEBhY3BpY2Eub3JnJTNjbWFpbHRvOmRldmVsQGFj
cGljYS5vcmciPgo8c3BhbiBzdHlsZT0iY29sb3I6d2luZG93dGV4dDt0ZXh0LWRlY29yYXRpb246
bm9uZSI+ZGV2ZWxAYWNwaWNhLm9yZyZsdDttYWlsdG86ZGV2ZWxAYWNwaWNhLm9yZzwvc3Bhbj48
L2E+Jmd0OzxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNw
YW4gbGFuZz0iRU4tR0IiPiZndDsgU3ViamVjdDogW0RldmVsXSAtRCAmbHQ7c3ltYm9sJmd0OyBQ
cmVwcm9jZXNzb3IgT3B0aW9uIERvZXNuJ3QgV29yazxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAg
Y2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgPG86cD48L286cD48
L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0
OyBIaSw8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFu
IGxhbmc9IkVOLUdCIj4mZ3Q7IDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1Bs
YWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgQVNMIFVzZXIgR3VpZGUgc3RhdGVzIHRo
YXQgI2lmZGVmIHN0YXRlbWVudHMgYXJlIHJlY29nbml6ZWQgd2hlbiBhIHN5bWJvbDxvOnA+PC9v
OnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0Ii
PiZndDsgaXMgZGVmaW5lZCBpbiB0aGUgY29tbWFuZCBsaW5lOjxvOnA+PC9vOnA+PC9zcGFuPjwv
cD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgPG86cD48
L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1H
QiI+Jmd0OyAmcXVvdDszLjMuMi4yICNpZmRlZjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xh
c3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgVXNhZ2U6PG86cD48L286
cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+
Jmd0OyAjaWZkZWYgc3ltYm9sPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxh
aW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBDb25kaXRpb25hbGx5IGNvbXBpbGUgYSBi
bG9jayBvZiB0ZXh0LiBUaGUgYmxvY2sgaXMgaW5jbHVkZWQgaW4gdGhlPG86cD48L286cD48L3Nw
YW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBj
b21waWxhdGlvbiBpZiB0aGUgc3ltYm9sIGlzIGRlZmluZWQsIGVpdGhlciBmcm9tIGEgI2RlZmlu
ZSBvciBmcm9tIHRoZSAtPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5U
ZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBEIGNvbW1hbmQgbGluZSBvcHRpb24mcXVvdDs8
bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9
IkVOLUdCIj4mZ3Q7IDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4
dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgYnV0IEkgY2Fubm90IG1ha2UgQVNMIENvbXBpbGVy
IHRvIHJlY29nbml6ZSB0aGUgZm9sbG93aW5nIG9wdGlvbjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4K
PHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsmbmJzcDsmbmJz
cDsgLUQgJmx0O3N5bWJvbCZndDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsg
RGVmaW5lIHN5bWJvbCBmb3IgcHJlcHJvY2Vzc29yIHVzZTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4K
PHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgPG86cD48L286
cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+
Jmd0OyBJbiB0aGUgZXhhbXBsZSBiZWxvdzxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9
Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgPG86cD48L286cD48L3NwYW4+
PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBEZWZp
bml0aW9uQmxvY2soJnF1b3Q7RFNEVC5BTUwmcXVvdDssICZxdW90O0RTRFQmcXVvdDssIDB4MDEs
ICZxdW90OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAmcXVvdDssICZxdW90OyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAmcXVvdDssIDMpIHs8bzpwPjwv
bzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdC
Ij4mZ3Q7Jm5ic3A7Jm5ic3A7IFNjb3BlKF9TQikgezxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAg
Y2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsgRGV2aWNlKENQVTApIHs8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNz
PSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7IE5hbWUoX0hJRCwgJnF1b3Q7QUNQSTAwMDcmcXVvdDspPG86cD48
L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1H
QiI+Jmd0OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBOYW1lKF9VSUQsIFpl
cm8pPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBs
YW5nPSJFTi1HQiI+Jmd0OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB9PG86cD48L286cD48L3Nw
YW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyAj
aWZkZWYgQ1BVXzE8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQi
PjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IERldmljZShD
UFUxKSB7PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3Bh
biBsYW5nPSJFTi1HQiI+Jmd0OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBOYW1lKF9ISUQs
ICZxdW90O0FDUEkwMDA3JnF1b3Q7KTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1z
b1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsgTmFtZShfVUlELCBPbmUpPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNv
UGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyB9PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBs
YW5nPSJFTi1HQiI+Jmd0OyAjZW5kaWY8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJN
c29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7Jm5ic3A7Jm5ic3A7IH08bzpwPjwv
bzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdC
Ij4mZ3Q7IH08bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxz
cGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1z
b1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgVGhlIHNlY3Rpb24gYmV0d2VlbiAj
aWZkZWYgQ1BVXzEgLi4uICNlbmRpZiBpcyBub3QgYmVpbmcgY29tcGlsZWQgd2hlbiBBU0w8bzpw
PjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVO
LUdCIj4mZ3Q7IGlzIGludm9rZWQgYXM6PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0i
TXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBpYXNsLmV4ZSAtbCAtRCBDUFVf
MSBEc2R0LmFzbDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+
PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgQ2hlY2tlZCB3aXRoIHRoZSBsYXRlc3QgdmVyc2lvbiAy
MDEzMDQxOC0zMiBbQXByIDE4IDIwMTNdLjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9
Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgPG86cD48L286cD48L3NwYW4+
PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBBbnkg
dGhvdWdodHMgb24gd2hhdCBtaWdodCBiZSBnb2luZyB3cm9uZyBoZXJlPzxvOnA+PC9vOnA+PC9z
cGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsg
VGhhbmtzLjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNw
YW4gbGFuZz0iRU4tR0IiPiZndDsgPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNv
UGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyA8bzpwPjwvbzpwPjwvc3Bhbj48L3A+
CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IDxvOnA+PC9v
OnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0Ii
PiZndDsgLS0gSU1QT1JUQU5UIE5PVElDRTogVGhlIGNvbnRlbnRzIG9mIHRoaXMgZW1haWwgYW5k
IGFueSBhdHRhY2htZW50cyBhcmU8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29Q
bGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IGNvbmZpZGVudGlhbCBhbmQgbWF5IGFs
c28gYmUgcHJpdmlsZWdlZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkPG86cD48L286cD48
L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0
OyByZWNpcGllbnQsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVseSBhbmQgZG8g
bm90IGRpc2Nsb3NlIHRoZTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWlu
VGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgY29udGVudHMgdG8gYW55IG90aGVyIHBlcnNv
biwgdXNlIGl0IGZvciBhbnkgcHVycG9zZSwgb3Igc3RvcmUgb3IgY29weSB0aGU8bzpwPjwvbzpw
Pjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4m
Z3Q7IGluZm9ybWF0aW9uIGluIGFueSBtZWRpdW0uIFRoYW5rIHlvdS48bzpwPjwvbzpwPjwvc3Bh
bj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IDxv
OnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0i
RU4tR0IiPiZndDsgLS0gSU1QT1JUQU5UIE5PVElDRTogVGhlIGNvbnRlbnRzIG9mIHRoaXMgZW1h
aWwgYW5kIGFueSBhdHRhY2htZW50cyBhcmU8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNz
PSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IGNvbmZpZGVudGlhbCBhbmQg
bWF5IGFsc28gYmUgcHJpdmlsZWdlZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkPG86cD48
L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1H
QiI+Jmd0OyByZWNpcGllbnQsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVseSBh
bmQgZG8gbm90IGRpc2Nsb3NlIHRoZTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1z
b1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgY29udGVudHMgdG8gYW55IG90aGVy
IHBlcnNvbiwgdXNlIGl0IGZvciBhbnkgcHVycG9zZSwgb3Igc3RvcmUgb3IgY29weSB0aGU8bzpw
PjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVO
LUdCIj4mZ3Q7IGluZm9ybWF0aW9uIGluIGFueSBtZWRpdW0uIFRoYW5rIHlvdS48bzpwPjwvbzpw
Pjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4m
Z3Q7IC0tLS0tLS0tLS0tLS0tIG5leHQgcGFydCAtLS0tLS0tLS0tLS0tLTxvOnA+PC9vOnA+PC9z
cGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsg
QW4gSFRNTCBhdHRhY2htZW50IHdhcyBzY3J1YmJlZC4uLjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4K
PHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgVVJMOjxvOnA+
PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4t
R0IiPiZndDsgJmx0O2h0dHA6Ly9saXN0cy5hY3BpY2Eub3JnL3BpcGVybWFpbC9kZXZlbC9hdHRh
Y2htZW50cy8yMDEzMDUxNi9lYjhhNDk2YS9hdHQ8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNs
YXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IGFjaG1lbnQuaHRtbCZn
dDs8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxh
bmc9IkVOLUdCIj4mZ3Q7IDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWlu
VGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBs
YW5nPSJFTi1HQiI+Jmd0OyA8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFp
blRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IF9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNv
UGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyBEZXZlbCBtYWlsaW5nIGxpc3Q8bzpw
PjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVO
LUdCIj4mZ3Q7IDxhIGhyZWY9Im1haWx0bzpEZXZlbEBhY3BpY2Eub3JnIj48c3BhbiBzdHlsZT0i
Y29sb3I6d2luZG93dGV4dDt0ZXh0LWRlY29yYXRpb246bm9uZSI+RGV2ZWxAYWNwaWNhLm9yZzwv
c3Bhbj48L2E+PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48
c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyA8YSBocmVmPSJodHRwczovL2xpc3RzLmFjcGljYS5vcmcv
bWFpbG1hbi9saXN0aW5mby9kZXZlbCI+CjxzcGFuIHN0eWxlPSJjb2xvcjp3aW5kb3d0ZXh0O3Rl
eHQtZGVjb3JhdGlvbjpub25lIj5odHRwczovL2xpc3RzLmFjcGljYS5vcmcvbWFpbG1hbi9saXN0
aW5mby9kZXZlbDwvc3Bhbj48L2E+PG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNv
UGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyA8bzpwPjwvbzpwPjwvc3Bhbj48L3A+
CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IEVuZCBvZiBE
ZXZlbCBEaWdlc3QsIFZvbCAzOCwgSXNzdWUgNTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xh
c3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqPG86cD48L286cD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNv
UGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0OyA8bzpwPjwvbzpwPjwvc3Bhbj48L3A+
CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IDxvOnA+PC9v
OnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0Ii
PiZndDsgLS0gSU1QT1JUQU5UIE5PVElDRTogVGhlIGNvbnRlbnRzIG9mIHRoaXMgZW1haWwgYW5k
IGFueSBhdHRhY2htZW50cyBhcmU8bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29Q
bGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IGNvbmZpZGVudGlhbCBhbmQgbWF5IGFs
c28gYmUgcHJpdmlsZWdlZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkPG86cD48L286cD48
L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48c3BhbiBsYW5nPSJFTi1HQiI+Jmd0
OyByZWNpcGllbnQsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVseSBhbmQgZG8g
bm90IGRpc2Nsb3NlIHRoZTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWlu
VGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgY29udGVudHMgdG8gYW55IG90aGVyIHBlcnNv
biwgdXNlIGl0IGZvciBhbnkgcHVycG9zZSwgb3Igc3RvcmUgb3IgY29weSB0aGU8bzpwPjwvbzpw
Pjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4m
Z3Q7IGluZm9ybWF0aW9uIGluIGFueSBtZWRpdW0uJm5ic3A7IFRoYW5rIHlvdS48bzpwPjwvbzpw
Pjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVOLUdCIj4m
Z3Q7IDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4g
bGFuZz0iRU4tR0IiPiZndDsgX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX188bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxz
cGFuIGxhbmc9IkVOLUdCIj4mZ3Q7IERldmVsIG1haWxpbmcgbGlzdDxvOnA+PC9vOnA+PC9zcGFu
PjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNwYW4gbGFuZz0iRU4tR0IiPiZndDsgPGEg
aHJlZj0ibWFpbHRvOkRldmVsQGFjcGljYS5vcmciPjxzcGFuIHN0eWxlPSJjb2xvcjp3aW5kb3d0
ZXh0O3RleHQtZGVjb3JhdGlvbjpub25lIj5EZXZlbEBhY3BpY2Eub3JnPC9zcGFuPjwvYT48bzpw
PjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxzcGFuIGxhbmc9IkVO
LUdCIj4mZ3Q7IDxhIGhyZWY9Imh0dHBzOi8vbGlzdHMuYWNwaWNhLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2RldmVsIj4KPHNwYW4gc3R5bGU9ImNvbG9yOndpbmRvd3RleHQ7dGV4dC1kZWNvcmF0aW9u
Om5vbmUiPmh0dHBzOi8vbGlzdHMuYWNwaWNhLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RldmVsPC9z
cGFuPjwvYT48bzpwPjwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxz
cGFuIGxhbmc9IkVOLUdCIj48bzpwPiZuYnNwOzwvbzpwPjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJN
c29Ob3JtYWwiIHN0eWxlPSJtYXJnaW46MGluO21hcmdpbi1ib3R0b206LjAwMDFwdCI+PHNwYW4g
bGFuZz0iRU4tR0IiIHN0eWxlPSJmb250LXNpemU6MTIuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O1Rp
bWVzIE5ldyBSb21hbiZxdW90OywmcXVvdDtzZXJpZiZxdW90OyI+PGJyPgo8L3NwYW4+PHNwYW4g
bGFuZz0iRU4tR0IiIHN0eWxlPSJmb250LXNpemU6MTAuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0Fy
aWFsJnF1b3Q7LCZxdW90O3NhbnMtc2VyaWYmcXVvdDs7Y29sb3I6YmxhY2siPi0tIElNUE9SVEFO
VCBOT1RJQ0U6IFRoZSBjb250ZW50cyBvZiB0aGlzIGVtYWlsIGFuZCBhbnkgYXR0YWNobWVudHMg
YXJlIGNvbmZpZGVudGlhbCBhbmQgbWF5IGFsc28gYmUgcHJpdmlsZWdlZC4gSWYgeW91IGFyZSBu
b3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIG5vdGlmeQogdGhlIHNlbmRlciBpbW1l
ZGlhdGVseSBhbmQgZG8gbm90IGRpc2Nsb3NlIHRoZSBjb250ZW50cyB0byBhbnkgb3RoZXIgcGVy
c29uLCB1c2UgaXQgZm9yIGFueSBwdXJwb3NlLCBvciBzdG9yZSBvciBjb3B5IHRoZSBpbmZvcm1h
dGlvbiBpbiBhbnkgbWVkaXVtLiBUaGFuayB5b3UuPC9zcGFuPjxzcGFuIGxhbmc9IkVOLUdCIiBz
dHlsZT0iZm9udC1zaXplOjEyLjBwdDtmb250LWZhbWlseTomcXVvdDtUaW1lcyBOZXcgUm9tYW4m
cXVvdDssJnF1b3Q7c2VyaWYmcXVvdDsiPjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KPC9kaXY+Cjwv
ZGl2Pgo8L2Rpdj4KPC9kaXY+CjwvYm9keT4KPC9odG1sPgo=

--===============7959582771375234818==--

