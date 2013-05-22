Content-Type: multipart/mixed; boundary="===============3439713502676562018=="
MIME-Version: 1.0
From: Alexei Fedorov <Alexei.Fedorov at arm.com>
Subject: Re: [Devel] -D <symbol> Preprocessor Option Doesn't Work
Date: Wed, 22 May 2013 13:46:01 +0100
Message-ID: <20E136AF98049A48A90A7417B4343D5E32BC716F11@BUNGLE.Emea.Arm.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E36FE6CE4E@ORSMSX103.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3439713502676562018==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

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

--===============3439713502676562018==
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
ciIgY29udGVudD0iTWljcm9zb2Z0IFdvcmQgMTIgKGZpbHRlcmVkIG1lZGl1bSkiPgo8c3R5bGU+
PCEtLQovKiBGb250IERlZmluaXRpb25zICovCkBmb250LWZhY2UKCXtmb250LWZhbWlseToiQ2Ft
YnJpYSBNYXRoIjsKCXBhbm9zZS0xOjIgNCA1IDMgNSA0IDYgMyAyIDQ7fQpAZm9udC1mYWNlCgl7
Zm9udC1mYW1pbHk6Q2FsaWJyaTsKCXBhbm9zZS0xOjIgMTUgNSAyIDIgMiA0IDMgMiA0O30KQGZv
bnQtZmFjZQoJe2ZvbnQtZmFtaWx5OlRhaG9tYTsKCXBhbm9zZS0xOjIgMTEgNiA0IDMgNSA0IDQg
MiA0O30KQGZvbnQtZmFjZQoJe2ZvbnQtZmFtaWx5OkNvbnNvbGFzOwoJcGFub3NlLTE6MiAxMSA2
IDkgMiAyIDQgMyAyIDQ7fQovKiBTdHlsZSBEZWZpbml0aW9ucyAqLwpwLk1zb05vcm1hbCwgbGku
TXNvTm9ybWFsLCBkaXYuTXNvTm9ybWFsCgl7bXNvLW1hcmdpbi10b3AtYWx0OmF1dG87CgltYXJn
aW4tcmlnaHQ6MGNtOwoJbXNvLW1hcmdpbi1ib3R0b20tYWx0OmF1dG87CgltYXJnaW4tbGVmdDow
Y207Cglmb250LXNpemU6MTEuMHB0OwoJZm9udC1mYW1pbHk6IkNhbGlicmkiLCJzYW5zLXNlcmlm
Ijt9CmE6bGluaywgc3Bhbi5Nc29IeXBlcmxpbmsKCXttc28tc3R5bGUtcHJpb3JpdHk6OTk7Cglj
b2xvcjpibHVlOwoJdGV4dC1kZWNvcmF0aW9uOnVuZGVybGluZTt9CmE6dmlzaXRlZCwgc3Bhbi5N
c29IeXBlcmxpbmtGb2xsb3dlZAoJe21zby1zdHlsZS1wcmlvcml0eTo5OTsKCWNvbG9yOnB1cnBs
ZTsKCXRleHQtZGVjb3JhdGlvbjp1bmRlcmxpbmU7fQpwLk1zb1BsYWluVGV4dCwgbGkuTXNvUGxh
aW5UZXh0LCBkaXYuTXNvUGxhaW5UZXh0Cgl7bXNvLXN0eWxlLXByaW9yaXR5Ojk5OwoJbXNvLXN0
eWxlLWxpbms6IlBsYWluIFRleHQgQ2hhciI7Cgltc28tbWFyZ2luLXRvcC1hbHQ6YXV0bzsKCW1h
cmdpbi1yaWdodDowY207Cgltc28tbWFyZ2luLWJvdHRvbS1hbHQ6YXV0bzsKCW1hcmdpbi1sZWZ0
OjBjbTsKCWZvbnQtc2l6ZToxMC41cHQ7Cglmb250LWZhbWlseTpDb25zb2xhczt9CnAuTXNvQWNl
dGF0ZSwgbGkuTXNvQWNldGF0ZSwgZGl2Lk1zb0FjZXRhdGUKCXttc28tc3R5bGUtcHJpb3JpdHk6
OTk7Cgltc28tc3R5bGUtbGluazoiQmFsbG9vbiBUZXh0IENoYXIiOwoJbXNvLW1hcmdpbi10b3At
YWx0OmF1dG87CgltYXJnaW4tcmlnaHQ6MGNtOwoJbXNvLW1hcmdpbi1ib3R0b20tYWx0OmF1dG87
CgltYXJnaW4tbGVmdDowY207Cglmb250LXNpemU6OC4wcHQ7Cglmb250LWZhbWlseToiVGFob21h
Iiwic2Fucy1zZXJpZiI7fQpzcGFuLlBsYWluVGV4dENoYXIKCXttc28tc3R5bGUtbmFtZToiUGxh
aW4gVGV4dCBDaGFyIjsKCW1zby1zdHlsZS1wcmlvcml0eTo5OTsKCW1zby1zdHlsZS1saW5rOiJQ
bGFpbiBUZXh0IjsKCWZvbnQtZmFtaWx5OkNvbnNvbGFzO30Kc3Bhbi5CYWxsb29uVGV4dENoYXIK
CXttc28tc3R5bGUtbmFtZToiQmFsbG9vbiBUZXh0IENoYXIiOwoJbXNvLXN0eWxlLXByaW9yaXR5
Ojk5OwoJbXNvLXN0eWxlLWxpbms6IkJhbGxvb24gVGV4dCI7Cglmb250LWZhbWlseToiVGFob21h
Iiwic2Fucy1zZXJpZiI7fQouTXNvQ2hwRGVmYXVsdAoJe21zby1zdHlsZS10eXBlOmV4cG9ydC1v
bmx5O30KLk1zb1BhcERlZmF1bHQKCXttc28tc3R5bGUtdHlwZTpleHBvcnQtb25seTsKCW1zby1t
YXJnaW4tdG9wLWFsdDphdXRvOwoJbXNvLW1hcmdpbi1ib3R0b20tYWx0OmF1dG87fQpAcGFnZSBX
b3JkU2VjdGlvbjEKCXtzaXplOjYxMi4wcHQgNzkyLjBwdDsKCW1hcmdpbjo3Mi4wcHQgNzIuMHB0
IDcyLjBwdCA3Mi4wcHQ7fQpkaXYuV29yZFNlY3Rpb24xCgl7cGFnZTpXb3JkU2VjdGlvbjE7fQot
LT48L3N0eWxlPjwhLS1baWYgZ3RlIG1zbyA5XT48eG1sPgo8bzpzaGFwZWRlZmF1bHRzIHY6ZXh0
PSJlZGl0IiBzcGlkbWF4PSIxMDI2IiAvPgo8L3htbD48IVtlbmRpZl0tLT48IS0tW2lmIGd0ZSBt
c28gOV0+PHhtbD4KPG86c2hhcGVsYXlvdXQgdjpleHQ9ImVkaXQiPgo8bzppZG1hcCB2OmV4dD0i
ZWRpdCIgZGF0YT0iMSIgLz4KPC9vOnNoYXBlbGF5b3V0PjwveG1sPjwhW2VuZGlmXS0tPgo8L2hl
YWQ+Cjxib2R5IGxhbmc9IkVOLUdCIiBsaW5rPSJibHVlIiB2bGluaz0icHVycGxlIj4KPGRpdiBj
bGFzcz0iV29yZFNlY3Rpb24xIj4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+SGkgUm9iZXJ0LDxv
OnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48bzpwPiZuYnNwOzwvbzpwPjwv
cD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+RG9lcyBwcmUtcHJvY2Vzc29yIHN1cHBvcnQgdGhl
IG5lc3RlZCAjaWYgI2Vsc2UgI2VuZGlmIHN0YXRlbWVudHM/PG86cD48L286cD48L3A+CjxwIGNs
YXNzPSJNc29QbGFpblRleHQiPjxvOnA+Jm5ic3A7PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxh
aW5UZXh0Ij5UaGlzIGNvZGU8bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+
PG86cD4mbmJzcDs8L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPkRlZmluaXRpb25C
bG9jaygmcXVvdDtEU0RULkFNTCZxdW90OywgJnF1b3Q7RFNEVCZxdW90OywgMHgwMSwgJnF1b3Q7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICZxdW90OywgJnF1b3Q7Jm5ic3A7Jm5ic3A7
Jm5ic3A7ICZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZxdW90OywgMykgezxvOnA+PC9vOnA+PC9w
Pgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48bzpwPiZuYnNwOzwvbzpwPjwvcD4KPHAgY2xhc3M9
Ik1zb1BsYWluVGV4dCI+Jm5ic3A7IC8vPG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFp
blRleHQiPiZuYnNwOyAvLyZuYnNwOyBTeXN0ZW0gQnVzPG86cD48L286cD48L3A+CjxwIGNsYXNz
PSJNc29QbGFpblRleHQiPiZuYnNwOyAvLzxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxh
aW5UZXh0Ij4mbmJzcDsgU2NvcGUoX1NCKSB7PG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29Q
bGFpblRleHQiPiZuYnNwOyZuYnNwOyZuYnNwOyAvLyBDUFVzPG86cD48L286cD48L3A+CjxwIGNs
YXNzPSJNc29QbGFpblRleHQiPiZuYnNwOyZuYnNwOyZuYnNwOyBEZXZpY2UoQ1BVMCkgezxvOnA+
PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4mbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsgTmFtZShfSElELCAmcXVvdDtBQ1BJMDAwNyZxdW90Oyk8bzpwPjwvbzpwPjwvcD4K
PHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IE5h
bWUoX1VJRCwgWmVybyk8bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jm5i
c3A7Jm5ic3A7Jm5ic3A7IH08bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+
PG86cD4mbmJzcDs8L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiNpZmRlZiBDUFVf
MTxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4mbmJzcDsmbmJzcDsmbmJz
cDsgRGV2aWNlKENQVTEpIHs8bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+
Jm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyBOYW1lKF9ISUQsICZxdW90O0FDUEkwMDA3JnF1b3Q7
KTxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4mbmJzcDsmbmJzcDsmbmJz
cDsgJm5ic3A7IE5hbWUoX1VJRCwgT25lKTxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxh
aW5UZXh0Ij4mbmJzcDsmbmJzcDsmbmJzcDsgfTxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNv
UGxhaW5UZXh0Ij4jZWxzZTxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4j
aWZkZWYgQ1BVXzI8bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jm5ic3A7
Jm5ic3A7Jm5ic3A7IERldmljZShDUFUyKSB7PG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29Q
bGFpblRleHQiPiZuYnNwOyZuYnNwOyZuYnNwOyAmbmJzcDsgTmFtZShfSElELCAmcXVvdDtBQ1BJ
MDAwNyZxdW90Oyk8bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jm5ic3A7
Jm5ic3A7Jm5ic3A7ICZuYnNwOyBOYW1lKF9VSUQsIDIpPG86cD48L286cD48L3A+CjxwIGNsYXNz
PSJNc29QbGFpblRleHQiPiZuYnNwOyZuYnNwOyZuYnNwOyB9PG86cD48L286cD48L3A+CjxwIGNs
YXNzPSJNc29QbGFpblRleHQiPiNlbmRpZjxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxh
aW5UZXh0Ij4jZW5kaWY8bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jm5i
c3A7Jm5ic3A7IDxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4mbmJzcDsm
bmJzcDt9IC8vIF9TQjxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij59PG86
cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPldoZW4gY29tcGxpZWQgd2l0aDxv
OnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij5pYXNsLmV4ZSAtbCAtRCBDUFVf
MSBEc2R0LmFzbDxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij5jYXVzZXMg
dGhlIGVycm9ycyBiZWxvdzo8bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+
SW50ZWwgQUNQSSBDb21wb25lbnQgQXJjaGl0ZWN0dXJlPG86cD48L286cD48L3A+CjxwIGNsYXNz
PSJNc29QbGFpblRleHQiPkFTTCBPcHRpbWl6aW5nIENvbXBpbGVyIHZlcnNpb24gMjAxMzA1MTct
MzIgW01heSAxNyAyMDEzXTxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij5D
b3B5cmlnaHQgKGMpIDIwMDAgLSAyMDEzIEludGVsIENvcnBvcmF0aW9uPG86cD48L286cD48L3A+
CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxvOnA+Jm5ic3A7PC9vOnA+PC9wPgo8cCBjbGFzcz0i
TXNvUGxhaW5UZXh0Ij5Ec2R0LmFzbCZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAzNzogLy88bzpw
PjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+RXJyb3ImbmJzcDsmbmJzcDsmbmJz
cDsgNjEyNiAtXiBzeW50YXggZXJyb3IsIHVuZXhwZWN0ZWQgJGVuZCwgZXhwZWN0aW5nIFBBUlNF
T1BfREVGSU5JVElPTkJMT0NLPG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQi
PjxvOnA+Jm5ic3A7PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij5Ec2R0LmFzbCZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAzMTogI2VuZGlmPG86cD48L286cD48L3A+CjxwIGNsYXNz
PSJNc29QbGFpblRleHQiPkVycm9yJm5ic3A7Jm5ic3A7Jm5ic3A7IDYxNDIgLSZuYnNwOyBeIE1p
c21hdGNoZWQgI2VuZGlmIChQcmVwcm9jZXNzb3IpPG86cD48L286cD48L3A+CjxwIGNsYXNzPSJN
c29QbGFpblRleHQiPjxvOnA+Jm5ic3A7PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0
Ij5BU0wgSW5wdXQ6Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IERzZHQuYXNsIC0gMzggbGluZXMs
IDAgYnl0ZXMsIDAga2V5d29yZHM8bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4
dCI+TGlzdGluZyBGaWxlOiZuYnNwOyBEc2R0LmxzdCAtIDE5OSBieXRlczxvOnA+PC9vOnA+PC9w
Pgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48bzpwPiZuYnNwOzwvbzpwPjwvcD4KPHAgY2xhc3M9
Ik1zb1BsYWluVGV4dCI+Q29tcGlsYXRpb24gY29tcGxldGUuIDIgRXJyb3JzLCAwIFdhcm5pbmdz
LCAwIFJlbWFya3MsIDAgT3B0aW1pemF0aW9uczxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNv
UGxhaW5UZXh0Ij5Ec2R0LmkgKFByZXByb2Nlc3NvciBPdXRwdXQgZmlsZSkgQ291bGQgbm90IGRl
bGV0ZTogUGVybWlzc2lvbiBkZW5pZWQ8bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWlu
VGV4dCI+RHNkdC5zcmMgKFNvdXJjZSBPdXRwdXQgZmlsZSkgQ291bGQgbm90IGRlbGV0ZTogUGVy
bWlzc2lvbiBkZW5pZWQ8bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PHNw
YW4gbGFuZz0iRU4tVVMiPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tPGJyPgpGcm9tOiBNb29y
ZSwgUm9iZXJ0IFttYWlsdG86cm9iZXJ0Lm1vb3JlQGludGVsLmNvbV0gPGJyPgpTZW50OiAxNyBN
YXkgMjAxMyAyMjowODxicj4KVG86IEFsZXhlaSBGZWRvcm92PGJyPgpTdWJqZWN0OiBSRTogLUQg
Jmx0O3N5bWJvbCZndDsgUHJlcHJvY2Vzc29yIE9wdGlvbiBEb2Vzbid0IFdvcms8L3NwYW4+PG86
cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxvOnA+Jm5ic3A7PC9vOnA+PC9w
Pgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij5XZSBkaWQgYSBuZXcgcmVsZWFzZSB0b2RheSwgc28g
eW91IGNhbiBqdXN0IGdyYWIgdGhlIHdpbmRvd3MgYmluYXJ5IGZyb20gdGhlIHdlYnNpdGUuPG86
cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPlRoZSBmaXggZm9yIC1EIGlzIGlu
IHRoZSByZWxlYXNlLjxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij48bzpw
PiZuYnNwOzwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Qm9iPG86cD48L286cD48
L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPjxvOnA+Jm5ic3A7PC9vOnA+PC9wPgo8cCBjbGFz
cz0iTXNvUGxhaW5UZXh0Ij48bzpwPiZuYnNwOzwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWlu
VGV4dCI+Jmd0OyAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLTxvOnA+PC9vOnA+PC9wPgo8cCBj
bGFzcz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7IEZyb206IDxhIGhyZWY9Im1haWx0bzpkZXZlbC1ib3Vu
Y2VzQGFjcGljYS5vcmciPjxzcGFuIHN0eWxlPSJjb2xvcjp3aW5kb3d0ZXh0O3RleHQtZGVjb3Jh
dGlvbjpub25lIj5kZXZlbC1ib3VuY2VzQGFjcGljYS5vcmc8L3NwYW4+PC9hPiBbPGEgaHJlZj0i
bWFpbHRvOmRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZyI+PHNwYW4gc3R5bGU9ImNvbG9yOndpbmRv
d3RleHQ7dGV4dC1kZWNvcmF0aW9uOm5vbmUiPm1haWx0bzpkZXZlbC1ib3VuY2VzQGFjcGljYS5v
cmc8L3NwYW4+PC9hPl0KIE9uIEJlaGFsZjxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxh
aW5UZXh0Ij4mZ3Q7IE9mIEFsZXhlaSBGZWRvcm92PG86cD48L286cD48L3A+CjxwIGNsYXNzPSJN
c29QbGFpblRleHQiPiZndDsgU2VudDogRnJpZGF5LCBNYXkgMTcsIDIwMTMgMzoxNiBBTTxvOnA+
PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7IFRvOiA8YSBocmVmPSJtYWls
dG86ZGV2ZWxAYWNwaWNhLm9yZyI+PHNwYW4gc3R5bGU9ImNvbG9yOndpbmRvd3RleHQ7dGV4dC1k
ZWNvcmF0aW9uOm5vbmUiPmRldmVsQGFjcGljYS5vcmc8L3NwYW4+PC9hPjxvOnA+PC9vOnA+PC9w
Pgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7IFN1YmplY3Q6IFJlOiBbRGV2ZWxdIC1EICZs
dDtzeW1ib2wmZ3Q7IFByZXByb2Nlc3NvciBPcHRpb24gRG9lc24ndCBXb3JrPG86cD48L286cD48
L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsgPG86cD48L286cD48L3A+CjxwIGNsYXNz
PSJNc29QbGFpblRleHQiPiZndDsgJmd0O1llcywgaXQgbG9va3MgbGlrZSBpdCBoYXMgYmVlbiB0
aGVyZSBhIHdoaWxlLjxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7
ICZndDtZb3UgY2FuIGNoZWNrb3V0IHRoZSBwYXRjaCwgb3IgSSBjYW4gc2VuZCB5b3UgYW4gdXBk
YXRlZCB3aW5kb3dzIGJpbmFyeS48bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4
dCI+Jmd0OyBIaSBSb2JlcnQsPG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQi
PiZndDsgUGxlYXNlIHNlbmQgbWUgYW4gdXBkYXRlZCBiaW5hcnkuPG86cD48L286cD48L3A+Cjxw
IGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsgVGhhbmtzLjxvOnA+PC9vOnA+PC9wPgo8cCBjbGFz
cz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tPG86cD48L286
cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsgRnJvbTogPGEgaHJlZj0ibWFpbHRv
OmRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZyI+PHNwYW4gc3R5bGU9ImNvbG9yOndpbmRvd3RleHQ7
dGV4dC1kZWNvcmF0aW9uOm5vbmUiPmRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZzwvc3Bhbj48L2E+
IFs8YSBocmVmPSJtYWlsdG86ZGV2ZWwtYm91bmNlc0BhY3BpY2Eub3JnIj48c3BhbiBzdHlsZT0i
Y29sb3I6d2luZG93dGV4dDt0ZXh0LWRlY29yYXRpb246bm9uZSI+bWFpbHRvOmRldmVsLWJvdW5j
ZXNAYWNwaWNhLm9yZzwvc3Bhbj48L2E+XQogT24gQmVoYWxmPG86cD48L286cD48L3A+CjxwIGNs
YXNzPSJNc29QbGFpblRleHQiPiZndDsgT2YgPGEgaHJlZj0ibWFpbHRvOmRldmVsLXJlcXVlc3RA
YWNwaWNhLm9yZyI+PHNwYW4gc3R5bGU9ImNvbG9yOndpbmRvd3RleHQ7dGV4dC1kZWNvcmF0aW9u
Om5vbmUiPmRldmVsLXJlcXVlc3RAYWNwaWNhLm9yZzwvc3Bhbj48L2E+PG86cD48L286cD48L3A+
CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsgU2VudDogMTYgTWF5IDIwMTMgMTg6MDk8bzpw
PjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyBUbzogPGEgaHJlZj0ibWFp
bHRvOmRldmVsQGFjcGljYS5vcmciPjxzcGFuIHN0eWxlPSJjb2xvcjp3aW5kb3d0ZXh0O3RleHQt
ZGVjb3JhdGlvbjpub25lIj5kZXZlbEBhY3BpY2Eub3JnPC9zcGFuPjwvYT48bzpwPjwvbzpwPjwv
cD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyBTdWJqZWN0OiBEZXZlbCBEaWdlc3QsIFZv
bCAzOCwgSXNzdWUgNTxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7
IDxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7IFNlbmQgRGV2ZWwg
bWFpbGluZyBsaXN0IHN1Ym1pc3Npb25zIHRvPG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29Q
bGFpblRleHQiPiZndDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsgPGEgaHJlZj0ibWFpbHRvOmRldmVsQGFjcGljYS5vcmciPjxzcGFuIHN0eWxlPSJjb2xv
cjp3aW5kb3d0ZXh0O3RleHQtZGVjb3JhdGlvbjpub25lIj5kZXZlbEBhY3BpY2Eub3JnPC9zcGFu
PjwvYT48bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyA8bzpwPjwv
bzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyBUbyBzdWJzY3JpYmUgb3IgdW5z
dWJzY3JpYmUgdmlhIHRoZSBXb3JsZCBXaWRlIFdlYiwgdmlzaXQ8bzpwPjwvbzpwPjwvcD4KPHAg
Y2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyA8YSBocmVmPSJodHRwczovL2xpc3RzLmFjcGljYS5vcmcvbWFpbG1h
bi9saXN0aW5mby9kZXZlbCI+CjxzcGFuIHN0eWxlPSJjb2xvcjp3aW5kb3d0ZXh0O3RleHQtZGVj
b3JhdGlvbjpub25lIj5odHRwczovL2xpc3RzLmFjcGljYS5vcmcvbWFpbG1hbi9saXN0aW5mby9k
ZXZlbDwvc3Bhbj48L2E+PG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZn
dDsgb3IsIHZpYSBlbWFpbCwgc2VuZCBhIG1lc3NhZ2Ugd2l0aCBzdWJqZWN0IG9yIGJvZHkgJ2hl
bHAnIHRvPG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgPGEgaHJlZj0ibWFpbHRv
OmRldmVsLXJlcXVlc3RAYWNwaWNhLm9yZyI+PHNwYW4gc3R5bGU9ImNvbG9yOndpbmRvd3RleHQ7
dGV4dC1kZWNvcmF0aW9uOm5vbmUiPmRldmVsLXJlcXVlc3RAYWNwaWNhLm9yZzwvc3Bhbj48L2E+
PG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsgPG86cD48L286cD48
L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsgWW91IGNhbiByZWFjaCB0aGUgcGVyc29u
IG1hbmFnaW5nIHRoZSBsaXN0IGF0PG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRl
eHQiPiZndDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsg
PGEgaHJlZj0ibWFpbHRvOmRldmVsLW93bmVyQGFjcGljYS5vcmciPjxzcGFuIHN0eWxlPSJjb2xv
cjp3aW5kb3d0ZXh0O3RleHQtZGVjb3JhdGlvbjpub25lIj5kZXZlbC1vd25lckBhY3BpY2Eub3Jn
PC9zcGFuPjwvYT48bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyA8
bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyBXaGVuIHJlcGx5aW5n
LCBwbGVhc2UgZWRpdCB5b3VyIFN1YmplY3QgbGluZSBzbyBpdCBpcyBtb3JlIHNwZWNpZmljIHRo
YW48bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyAmcXVvdDtSZTog
Q29udGVudHMgb2YgRGV2ZWwgZGlnZXN0Li4uJnF1b3Q7PG86cD48L286cD48L3A+CjxwIGNsYXNz
PSJNc29QbGFpblRleHQiPiZndDsgPG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRl
eHQiPiZndDsgPG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsgVG9k
YXkncyBUb3BpY3M6PG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsg
PG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsmbmJzcDsmbmJzcDsm
bmJzcDsgMS4gUmU6IC1EICZsdDtzeW1ib2wmZ3Q7IFByZXByb2Nlc3NvciBPcHRpb24gRG9lc24n
dCBXb3JrIChNb29yZSwgUm9iZXJ0KTxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5U
ZXh0Ij4mZ3Q7Jm5ic3A7Jm5ic3A7Jm5ic3A7IDIuIFJlOiAtRCAmbHQ7c3ltYm9sJmd0OyBQcmVw
cm9jZXNzb3IgT3B0aW9uIERvZXNuJ3QgV29yayAoTW9vcmUsIFJvYmVydCk8bzpwPjwvbzpwPjwv
cD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyA8bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9
Ik1zb1BsYWluVGV4dCI+Jmd0OyA8bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4
dCI+Jmd0OyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tPG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRl
eHQiPiZndDsgPG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsgTWVz
c2FnZTogMTxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7IERhdGU6
IFRodSwgMTYgTWF5IDIwMTMgMTU6NTk6MTcgJiM0MzswMDAwPG86cD48L286cD48L3A+CjxwIGNs
YXNzPSJNc29QbGFpblRleHQiPiZndDsgRnJvbTogJnF1b3Q7TW9vcmUsIFJvYmVydCZxdW90OyAm
bHQ7PGEgaHJlZj0ibWFpbHRvOnJvYmVydC5tb29yZUBpbnRlbC5jb20iPjxzcGFuIHN0eWxlPSJj
b2xvcjp3aW5kb3d0ZXh0O3RleHQtZGVjb3JhdGlvbjpub25lIj5yb2JlcnQubW9vcmVAaW50ZWwu
Y29tPC9zcGFuPjwvYT4mZ3Q7PG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQi
PiZndDsgVG86IEFsZXhlaSBGZWRvcm92ICZsdDs8YSBocmVmPSJtYWlsdG86QWxleGVpLkZlZG9y
b3ZAYXJtLmNvbSI+PHNwYW4gc3R5bGU9ImNvbG9yOndpbmRvd3RleHQ7dGV4dC1kZWNvcmF0aW9u
Om5vbmUiPkFsZXhlaS5GZWRvcm92QGFybS5jb208L3NwYW4+PC9hPiZndDssICZxdW90OzxhIGhy
ZWY9Im1haWx0bzpkZXZlbEBhY3BpY2Eub3JnIj48c3BhbiBzdHlsZT0iY29sb3I6d2luZG93dGV4
dDt0ZXh0LWRlY29yYXRpb246bm9uZSI+ZGV2ZWxAYWNwaWNhLm9yZzwvc3Bhbj48L2E+JnF1b3Q7
PG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgJmx0OzxhIGhyZWY9Im1haWx0bzpk
ZXZlbEBhY3BpY2Eub3JnIj48c3BhbiBzdHlsZT0iY29sb3I6d2luZG93dGV4dDt0ZXh0LWRlY29y
YXRpb246bm9uZSI+ZGV2ZWxAYWNwaWNhLm9yZzwvc3Bhbj48L2E+Jmd0OzxvOnA+PC9vOnA+PC9w
Pgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7IFN1YmplY3Q6IFJlOiBbRGV2ZWxdIC1EICZs
dDtzeW1ib2wmZ3Q7IFByZXByb2Nlc3NvciBPcHRpb24gRG9lc24ndCBXb3JrPG86cD48L286cD48
L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsgTWVzc2FnZS1JRDo8bzpwPjwvbzpwPjwv
cD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyA8bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9
Ik1zb1BsYWluVGV4dCI+Jmd0OyAmbHQ7PGEgaHJlZj0ibWFpbHRvOjk0RjJGQkFCNDQzMkI1NEU4
QUFDQzdERkRFNkM5MkUzNkZFNkMzMjFAT1JTTVNYMTAzLmFtci5jb3JwLmludGVsLmNvbSI+PHNw
YW4gc3R5bGU9ImNvbG9yOndpbmRvd3RleHQ7dGV4dC1kZWNvcmF0aW9uOm5vbmUiPjk0RjJGQkFC
NDQzMkI1NEU4QUFDQzdERkRFNkM5MkUzNkZFNkMzMjFAT1JTTVNYMTAzLmFtci5jb3JwLmludGVs
LmNvbTwvc3Bhbj48L2E+Jmd0OzxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0
Ij4mZ3Q7IDxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7IENvbnRl
bnQtVHlwZTogdGV4dC9wbGFpbjsgY2hhcnNldD0mcXVvdDt1cy1hc2NpaSZxdW90OzxvOnA+PC9v
OnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7IDxvOnA+PC9vOnA+PC9wPgo8cCBj
bGFzcz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7IFRoZSBmaXggZm9yIHRoaXMgaXMgY2hlY2tlZCBpbnRv
IG91ciBnaXQgdHJlZS48bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0
OyBCb2I8bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyBGcm9tOiA8
YSBocmVmPSJtYWlsdG86ZGV2ZWwtYm91bmNlc0BhY3BpY2Eub3JnIj48c3BhbiBzdHlsZT0iY29s
b3I6d2luZG93dGV4dDt0ZXh0LWRlY29yYXRpb246bm9uZSI+ZGV2ZWwtYm91bmNlc0BhY3BpY2Eu
b3JnPC9zcGFuPjwvYT4gWzxhIGhyZWY9Im1haWx0bzpkZXZlbC1ib3VuY2VzQGFjcGljYS5vcmci
PjxzcGFuIHN0eWxlPSJjb2xvcjp3aW5kb3d0ZXh0O3RleHQtZGVjb3JhdGlvbjpub25lIj5tYWls
dG86ZGV2ZWwtYm91bmNlc0BhY3BpY2Eub3JnPC9zcGFuPjwvYT5dCiBPbiBCZWhhbGY8bzpwPjwv
bzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyBPZiBNb29yZSwgUm9iZXJ0PG86
cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsgU2VudDogV2VkbmVzZGF5
LCBNYXkgMTUsIDIwMTMgMTA6MzMgQU08bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWlu
VGV4dCI+Jmd0OyBUbzogQWxleGVpIEZlZG9yb3Y7IDxhIGhyZWY9Im1haWx0bzpkZXZlbEBhY3Bp
Y2Eub3JnIj48c3BhbiBzdHlsZT0iY29sb3I6d2luZG93dGV4dDt0ZXh0LWRlY29yYXRpb246bm9u
ZSI+ZGV2ZWxAYWNwaWNhLm9yZzwvc3Bhbj48L2E+PG86cD48L286cD48L3A+CjxwIGNsYXNzPSJN
c29QbGFpblRleHQiPiZndDsgU3ViamVjdDogUmU6IFtEZXZlbF0gLUQgJmx0O3N5bWJvbCZndDsg
UHJlcHJvY2Vzc29yIE9wdGlvbiBEb2Vzbid0IFdvcms8bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9
Ik1zb1BsYWluVGV4dCI+Jmd0OyA8bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4
dCI+Jmd0OyBTb3JyeSwgd2UgZGlkIHNvbWUgY29kZSByZXN0cnVjdHVyaW5nIGFuZCBicm9rZSB0
aGlzLiBZb3UgY2FuIGdvIGJhY2sgdG88bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWlu
VGV4dCI+Jmd0OyBhbiBlYXJsaWVyIHZlcnNpb24gb2YgdGhlIGNvbXBpbGVyLCBvciB3YWl0IHVu
dGlsIGxhdGVyIHRoaXMgd2VlayB3aGVuPG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFp
blRleHQiPiZndDsgdGhlcmUgd2lsbCBiZSBhIG5ldyB2ZXJzaW9uLjxvOnA+PC9vOnA+PC9wPgo8
cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7IEJvYjxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0i
TXNvUGxhaW5UZXh0Ij4mZ3Q7IEZyb206IDxhIGhyZWY9Im1haWx0bzpkZXZlbC1ib3VuY2VzQGFj
cGljYS5vcmclM2NtYWlsdG86ZGV2ZWwtYm91bmNlc0BhY3BpY2Eub3JnIj4KPHNwYW4gc3R5bGU9
ImNvbG9yOndpbmRvd3RleHQ7dGV4dC1kZWNvcmF0aW9uOm5vbmUiPmRldmVsLWJvdW5jZXNAYWNw
aWNhLm9yZyZsdDttYWlsdG86ZGV2ZWwtYm91bmNlc0BhY3BpY2Eub3JnPC9zcGFuPjwvYT4mZ3Q7
PG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsgWzxhIGhyZWY9Im1h
aWx0bzpkZXZlbC1ib3VuY2VzQGFjcGljYS5vcmciPjxzcGFuIHN0eWxlPSJjb2xvcjp3aW5kb3d0
ZXh0O3RleHQtZGVjb3JhdGlvbjpub25lIj5tYWlsdG86ZGV2ZWwtYm91bmNlc0BhY3BpY2Eub3Jn
PC9zcGFuPjwvYT5dIE9uIEJlaGFsZiBPZiBNb29yZSwgUm9iZXJ0PG86cD48L286cD48L3A+Cjxw
IGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsgU2VudDogV2VkbmVzZGF5LCBNYXkgMTUsIDIwMTMg
ODo0MyBBTTxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7IFRvOiBB
bGV4ZWkgRmVkb3JvdjsgPGEgaHJlZj0ibWFpbHRvOmRldmVsQGFjcGljYS5vcmclM2NtYWlsdG86
ZGV2ZWxAYWNwaWNhLm9yZyI+CjxzcGFuIHN0eWxlPSJjb2xvcjp3aW5kb3d0ZXh0O3RleHQtZGVj
b3JhdGlvbjpub25lIj5kZXZlbEBhY3BpY2Eub3JnJmx0O21haWx0bzpkZXZlbEBhY3BpY2Eub3Jn
PC9zcGFuPjwvYT4mZ3Q7PG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZn
dDsgU3ViamVjdDogUmU6IFtEZXZlbF0gLUQgJmx0O3N5bWJvbCZndDsgUHJlcHJvY2Vzc29yIE9w
dGlvbiBEb2Vzbid0IFdvcms8bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+
Jmd0OyA8bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyBXZSB3aWxs
IGNoZWNrIGl0IG91dC48bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0
OyBUaGFua3MsPG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsgQm9i
PG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsgRnJvbTogPGEgaHJl
Zj0ibWFpbHRvOmRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZyUzY21haWx0bzpkZXZlbC1ib3VuY2Vz
QGFjcGljYS5vcmciPgo8c3BhbiBzdHlsZT0iY29sb3I6d2luZG93dGV4dDt0ZXh0LWRlY29yYXRp
b246bm9uZSI+ZGV2ZWwtYm91bmNlc0BhY3BpY2Eub3JnJmx0O21haWx0bzpkZXZlbC1ib3VuY2Vz
QGFjcGljYS5vcmc8L3NwYW4+PC9hPiZndDs8bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1Bs
YWluVGV4dCI+Jmd0OyBbPGEgaHJlZj0ibWFpbHRvOmRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZyI+
PHNwYW4gc3R5bGU9ImNvbG9yOndpbmRvd3RleHQ7dGV4dC1kZWNvcmF0aW9uOm5vbmUiPm1haWx0
bzpkZXZlbC1ib3VuY2VzQGFjcGljYS5vcmc8L3NwYW4+PC9hPl0gT24gQmVoYWxmIE9mIEFsZXhl
aSBGZWRvcm92PG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsgU2Vu
dDogVHVlc2RheSwgTWF5IDE0LCAyMDEzIDU6MjcgQU08bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9
Ik1zb1BsYWluVGV4dCI+Jmd0OyBUbzogPGEgaHJlZj0ibWFpbHRvOmRldmVsQGFjcGljYS5vcmcl
M2NtYWlsdG86ZGV2ZWxAYWNwaWNhLm9yZyI+CjxzcGFuIHN0eWxlPSJjb2xvcjp3aW5kb3d0ZXh0
O3RleHQtZGVjb3JhdGlvbjpub25lIj5kZXZlbEBhY3BpY2Eub3JnJmx0O21haWx0bzpkZXZlbEBh
Y3BpY2Eub3JnPC9zcGFuPjwvYT4mZ3Q7PG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFp
blRleHQiPiZndDsgU3ViamVjdDogW0RldmVsXSAtRCAmbHQ7c3ltYm9sJmd0OyBQcmVwcm9jZXNz
b3IgT3B0aW9uIERvZXNuJ3QgV29yazxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5U
ZXh0Ij4mZ3Q7IDxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7IEhp
LDxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7IDxvOnA+PC9vOnA+
PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7IEFTTCBVc2VyIEd1aWRlIHN0YXRlcyB0
aGF0ICNpZmRlZiBzdGF0ZW1lbnRzIGFyZSByZWNvZ25pemVkIHdoZW4gYSBzeW1ib2w8bzpwPjwv
bzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyBpcyBkZWZpbmVkIGluIHRoZSBj
b21tYW5kIGxpbmU6PG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsg
PG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsgJnF1b3Q7My4zLjIu
MiAjaWZkZWY8bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyBVc2Fn
ZTo8bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyAjaWZkZWYgc3lt
Ym9sPG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsgQ29uZGl0aW9u
YWxseSBjb21waWxlIGEgYmxvY2sgb2YgdGV4dC4gVGhlIGJsb2NrIGlzIGluY2x1ZGVkIGluIHRo
ZTxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7IGNvbXBpbGF0aW9u
IGlmIHRoZSBzeW1ib2wgaXMgZGVmaW5lZCwgZWl0aGVyIGZyb20gYSAjZGVmaW5lIG9yIGZyb20g
dGhlIC08bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyBEIGNvbW1h
bmQgbGluZSBvcHRpb24mcXVvdDs8bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4
dCI+Jmd0OyA8bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyBidXQg
SSBjYW5ub3QgbWFrZSBBU0wgQ29tcGlsZXIgdG8gcmVjb2duaXplIHRoZSBmb2xsb3dpbmcgb3B0
aW9uPG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsmbmJzcDsmbmJz
cDsgLUQgJmx0O3N5bWJvbCZndDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsg
RGVmaW5lIHN5bWJvbCBmb3IgcHJlcHJvY2Vzc29yIHVzZTxvOnA+PC9vOnA+PC9wPgo8cCBjbGFz
cz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7IDxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5U
ZXh0Ij4mZ3Q7IEluIHRoZSBleGFtcGxlIGJlbG93PG86cD48L286cD48L3A+CjxwIGNsYXNzPSJN
c29QbGFpblRleHQiPiZndDsgPG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQi
PiZndDsgRGVmaW5pdGlvbkJsb2NrKCZxdW90O0RTRFQuQU1MJnF1b3Q7LCAmcXVvdDtEU0RUJnF1
b3Q7LCAweDAxLCAmcXVvdDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgJnF1b3Q7LCAm
cXVvdDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgJnF1b3Q7LCAz
KSB7PG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsmbmJzcDsmbmJz
cDsgU2NvcGUoX1NCKSB7PG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZn
dDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgRGV2aWNlKENQVTApIHs8bzpwPjwvbzpwPjwvcD4K
PHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyBOYW1lKF9ISUQsICZxdW90O0FDUEkwMDA3JnF1b3Q7KTxvOnA+PC9vOnA+PC9wPgo8
cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7IE5hbWUoX1VJRCwgWmVybyk8bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWlu
VGV4dCI+Jmd0OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB9PG86cD48L286cD48L3A+CjxwIGNs
YXNzPSJNc29QbGFpblRleHQiPiZndDsgI2lmZGVmIENQVV8xPG86cD48L286cD48L3A+CjxwIGNs
YXNzPSJNc29QbGFpblRleHQiPiZndDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgRGV2aWNlKENQ
VTEpIHs8bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyBOYW1lKF9ISUQsICZxdW90O0FDUEkwMDA3JnF1b3Q7KTxvOnA+
PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7IE5hbWUoX1VJRCwgT25lKTxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxh
aW5UZXh0Ij4mZ3Q7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IH08bzpwPjwvbzpwPjwvcD4KPHAg
Y2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyAjZW5kaWY8bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9
Ik1zb1BsYWluVGV4dCI+Jmd0OyZuYnNwOyZuYnNwOyB9PG86cD48L286cD48L3A+CjxwIGNsYXNz
PSJNc29QbGFpblRleHQiPiZndDsgfTxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5U
ZXh0Ij4mZ3Q7IDxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7IFRo
ZSBzZWN0aW9uIGJldHdlZW4gI2lmZGVmIENQVV8xIC4uLiAjZW5kaWYgaXMgbm90IGJlaW5nIGNv
bXBpbGVkIHdoZW4gQVNMPG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZn
dDsgaXMgaW52b2tlZCBhczo8bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+
Jmd0OyBpYXNsLmV4ZSAtbCAtRCBDUFVfMSBEc2R0LmFzbDxvOnA+PC9vOnA+PC9wPgo8cCBjbGFz
cz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7IENoZWNrZWQgd2l0aCB0aGUgbGF0ZXN0IHZlcnNpb24gMjAx
MzA0MTgtMzIgW0FwciAxOCAyMDEzXS48bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWlu
VGV4dCI+Jmd0OyA8bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyBB
bnkgdGhvdWdodHMgb24gd2hhdCBtaWdodCBiZSBnb2luZyB3cm9uZyBoZXJlPzxvOnA+PC9vOnA+
PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7IFRoYW5rcy48bzpwPjwvbzpwPjwvcD4K
PHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyA8bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1z
b1BsYWluVGV4dCI+Jmd0OyA8bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+
Jmd0OyA8bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyAtLSBJTVBP
UlRBTlQgTk9USUNFOiBUaGUgY29udGVudHMgb2YgdGhpcyBlbWFpbCBhbmQgYW55IGF0dGFjaG1l
bnRzIGFyZTxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7IGNvbmZp
ZGVudGlhbCBhbmQgbWF5IGFsc28gYmUgcHJpdmlsZWdlZC4gSWYgeW91IGFyZSBub3QgdGhlIGlu
dGVuZGVkPG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsgcmVjaXBp
ZW50LCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgYW5kIGRvIG5vdCBkaXNj
bG9zZSB0aGU8bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyBjb250
ZW50cyB0byBhbnkgb3RoZXIgcGVyc29uLCB1c2UgaXQgZm9yIGFueSBwdXJwb3NlLCBvciBzdG9y
ZSBvciBjb3B5IHRoZTxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7
IGluZm9ybWF0aW9uIGluIGFueSBtZWRpdW0uIFRoYW5rIHlvdS48bzpwPjwvbzpwPjwvcD4KPHAg
Y2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyAtLS0tLS0tLS0tLS0tLSBuZXh0IHBhcnQgLS0tLS0t
LS0tLS0tLS08bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyBBbiBI
VE1MIGF0dGFjaG1lbnQgd2FzIHNjcnViYmVkLi4uPG86cD48L286cD48L3A+CjxwIGNsYXNzPSJN
c29QbGFpblRleHQiPiZndDsgVVJMOjxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5U
ZXh0Ij4mZ3Q7ICZsdDtodHRwOi8vbGlzdHMuYWNwaWNhLm9yZy9waXBlcm1haWwvZGV2ZWwvYXR0
YWNobWVudHMvMjAxMzA1MTYvNmNjNjQ4Y2IvYXR0PG86cD48L286cD48L3A+CjxwIGNsYXNzPSJN
c29QbGFpblRleHQiPiZndDsgYWNobWVudC0wMDAxLmh0bWwmZ3Q7PG86cD48L286cD48L3A+Cjxw
IGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsgPG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29Q
bGFpblRleHQiPiZndDsgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPG86cD48L286cD48
L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsgPG86cD48L286cD48L3A+CjxwIGNsYXNz
PSJNc29QbGFpblRleHQiPiZndDsgTWVzc2FnZTogMjxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0i
TXNvUGxhaW5UZXh0Ij4mZ3Q7IERhdGU6IFRodSwgMTYgTWF5IDIwMTMgMTc6MTI6NDQgJiM0Mzsw
MDAwPG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsgRnJvbTogJnF1
b3Q7TW9vcmUsIFJvYmVydCZxdW90OyAmbHQ7PGEgaHJlZj0ibWFpbHRvOnJvYmVydC5tb29yZUBp
bnRlbC5jb20iPjxzcGFuIHN0eWxlPSJjb2xvcjp3aW5kb3d0ZXh0O3RleHQtZGVjb3JhdGlvbjpu
b25lIj5yb2JlcnQubW9vcmVAaW50ZWwuY29tPC9zcGFuPjwvYT4mZ3Q7PG86cD48L286cD48L3A+
CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsgVG86IEFsZXhlaSBGZWRvcm92ICZsdDs8YSBo
cmVmPSJtYWlsdG86QWxleGVpLkZlZG9yb3ZAYXJtLmNvbSI+PHNwYW4gc3R5bGU9ImNvbG9yOndp
bmRvd3RleHQ7dGV4dC1kZWNvcmF0aW9uOm5vbmUiPkFsZXhlaS5GZWRvcm92QGFybS5jb208L3Nw
YW4+PC9hPiZndDssICZxdW90OzxhIGhyZWY9Im1haWx0bzpkZXZlbEBhY3BpY2Eub3JnIj48c3Bh
biBzdHlsZT0iY29sb3I6d2luZG93dGV4dDt0ZXh0LWRlY29yYXRpb246bm9uZSI+ZGV2ZWxAYWNw
aWNhLm9yZzwvc3Bhbj48L2E+JnF1b3Q7PG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFp
blRleHQiPiZndDsmbmJzcDsmbmJzcDsgJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jmx0OzxhIGhyZWY9Im1haWx0bzpkZXZlbEBhY3BpY2Eub3JnIj48c3BhbiBzdHlsZT0iY29s
b3I6d2luZG93dGV4dDt0ZXh0LWRlY29yYXRpb246bm9uZSI+ZGV2ZWxAYWNwaWNhLm9yZzwvc3Bh
bj48L2E+Jmd0OzxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7IFN1
YmplY3Q6IFJlOiBbRGV2ZWxdIC1EICZsdDtzeW1ib2wmZ3Q7IFByZXByb2Nlc3NvciBPcHRpb24g
RG9lc24ndCBXb3JrPG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsg
TWVzc2FnZS1JRDo8bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyA8
bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyAmbHQ7PGEgaHJlZj0i
bWFpbHRvOjk0RjJGQkFCNDQzMkI1NEU4QUFDQzdERkRFNkM5MkUzNkZFNkMzQjVAT1JTTVNYMTAz
LmFtci5jb3JwLmludGVsLmNvbSI+PHNwYW4gc3R5bGU9ImNvbG9yOndpbmRvd3RleHQ7dGV4dC1k
ZWNvcmF0aW9uOm5vbmUiPjk0RjJGQkFCNDQzMkI1NEU4QUFDQzdERkRFNkM5MkUzNkZFNkMzQjVA
T1JTTVNYMTAzLmFtci5jb3JwLmludGVsLmNvbTwvc3Bhbj48L2E+Jmd0OzxvOnA+PC9vOnA+PC9w
Pgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7IDxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0i
TXNvUGxhaW5UZXh0Ij4mZ3Q7IENvbnRlbnQtVHlwZTogdGV4dC9wbGFpbjsgY2hhcnNldD0mcXVv
dDt1cy1hc2NpaSZxdW90OzxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4m
Z3Q7IDxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7IFllcywgaXQg
bG9va3MgbGlrZSBpdCBoYXMgYmVlbiB0aGVyZSBhIHdoaWxlLjxvOnA+PC9vOnA+PC9wPgo8cCBj
bGFzcz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7IFlvdSBjYW4gY2hlY2tvdXQgdGhlIHBhdGNoLCBvciBJ
IGNhbiBzZW5kIHlvdSBhbiB1cGRhdGVkIHdpbmRvd3MgYmluYXJ5LjxvOnA+PC9vOnA+PC9wPgo8
cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7IDxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNv
UGxhaW5UZXh0Ij4mZ3Q7IDxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4m
Z3Q7IEZyb206IEFsZXhlaSBGZWRvcm92IFs8YSBocmVmPSJtYWlsdG86QWxleGVpLkZlZG9yb3ZA
YXJtLmNvbSI+PHNwYW4gc3R5bGU9ImNvbG9yOndpbmRvd3RleHQ7dGV4dC1kZWNvcmF0aW9uOm5v
bmUiPm1haWx0bzpBbGV4ZWkuRmVkb3JvdkBhcm0uY29tPC9zcGFuPjwvYT5dPG86cD48L286cD48
L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsgU2VudDogVGh1cnNkYXksIE1heSAxNiwg
MjAxMyAzOjE3IEFNPG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsg
VG86IE1vb3JlLCBSb2JlcnQ7IDxhIGhyZWY9Im1haWx0bzpkZXZlbEBhY3BpY2Eub3JnIj48c3Bh
biBzdHlsZT0iY29sb3I6d2luZG93dGV4dDt0ZXh0LWRlY29yYXRpb246bm9uZSI+ZGV2ZWxAYWNw
aWNhLm9yZzwvc3Bhbj48L2E+PG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQi
PiZndDsgU3ViamVjdDogUkU6IC1EICZsdDtzeW1ib2wmZ3Q7IFByZXByb2Nlc3NvciBPcHRpb24g
RG9lc24ndCBXb3JrPG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsg
PG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsgSGkgUm9iZXJ0LDxv
OnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7IEkgdHJpZWQgdGhhdCB3
aXRoIDQgcHJldmlvdXMgdmVyc2lvbnMgb2YgY29tcGlsZXIgJmFtcDsgc3RpbGwgZ290IHRoZSBz
YW1lPG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsgaXNzdWUuPG86
cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsgUmVnYXJkcy48bzpwPjwv
bzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyBBbGV4ZWkuPG86cD48L286cD48
L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsgPG86cD48L286cD48L3A+CjxwIGNsYXNz
PSJNc29QbGFpblRleHQiPiZndDsgRnJvbTogTW9vcmUsIFJvYmVydCBbPGEgaHJlZj0ibWFpbHRv
OnJvYmVydC5tb29yZUBpbnRlbC5jb20iPjxzcGFuIHN0eWxlPSJjb2xvcjp3aW5kb3d0ZXh0O3Rl
eHQtZGVjb3JhdGlvbjpub25lIj5tYWlsdG86cm9iZXJ0Lm1vb3JlQGludGVsLmNvbTwvc3Bhbj48
L2E+XTxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7IFNlbnQ6IDE1
IE1heSAyMDEzIDE4OjMzPG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZn
dDsgVG86IEFsZXhlaSBGZWRvcm92OyA8YSBocmVmPSJtYWlsdG86ZGV2ZWxAYWNwaWNhLm9yZyUz
Y21haWx0bzpkZXZlbEBhY3BpY2Eub3JnIj4KPHNwYW4gc3R5bGU9ImNvbG9yOndpbmRvd3RleHQ7
dGV4dC1kZWNvcmF0aW9uOm5vbmUiPmRldmVsQGFjcGljYS5vcmcmbHQ7bWFpbHRvOmRldmVsQGFj
cGljYS5vcmc8L3NwYW4+PC9hPiZndDs8bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWlu
VGV4dCI+Jmd0OyBTdWJqZWN0OiBSRTogLUQgJmx0O3N5bWJvbCZndDsgUHJlcHJvY2Vzc29yIE9w
dGlvbiBEb2Vzbid0IFdvcms8bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+
Jmd0OyA8bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyBTb3JyeSwg
d2UgZGlkIHNvbWUgY29kZSByZXN0cnVjdHVyaW5nIGFuZCBicm9rZSB0aGlzLiBZb3UgY2FuIGdv
IGJhY2sgdG88bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyBhbiBl
YXJsaWVyIHZlcnNpb24gb2YgdGhlIGNvbXBpbGVyLCBvciB3YWl0IHVudGlsIGxhdGVyIHRoaXMg
d2VlayB3aGVuPG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsgdGhl
cmUgd2lsbCBiZSBhIG5ldyB2ZXJzaW9uLjxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxh
aW5UZXh0Ij4mZ3Q7IEJvYjxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4m
Z3Q7IEZyb206IDxhIGhyZWY9Im1haWx0bzpkZXZlbC1ib3VuY2VzQGFjcGljYS5vcmclM2NtYWls
dG86ZGV2ZWwtYm91bmNlc0BhY3BpY2Eub3JnIj4KPHNwYW4gc3R5bGU9ImNvbG9yOndpbmRvd3Rl
eHQ7dGV4dC1kZWNvcmF0aW9uOm5vbmUiPmRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZyZsdDttYWls
dG86ZGV2ZWwtYm91bmNlc0BhY3BpY2Eub3JnPC9zcGFuPjwvYT4mZ3Q7PG86cD48L286cD48L3A+
CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsgWzxhIGhyZWY9Im1haWx0bzpkZXZlbC1ib3Vu
Y2VzQGFjcGljYS5vcmciPjxzcGFuIHN0eWxlPSJjb2xvcjp3aW5kb3d0ZXh0O3RleHQtZGVjb3Jh
dGlvbjpub25lIj5tYWlsdG86ZGV2ZWwtYm91bmNlc0BhY3BpY2Eub3JnPC9zcGFuPjwvYT5dIE9u
IEJlaGFsZiBPZiBNb29yZSwgUm9iZXJ0PG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFp
blRleHQiPiZndDsgU2VudDogV2VkbmVzZGF5LCBNYXkgMTUsIDIwMTMgODo0MyBBTTxvOnA+PC9v
OnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7IFRvOiBBbGV4ZWkgRmVkb3Jvdjsg
PGEgaHJlZj0ibWFpbHRvOmRldmVsQGFjcGljYS5vcmclM2NtYWlsdG86ZGV2ZWxAYWNwaWNhLm9y
ZyI+CjxzcGFuIHN0eWxlPSJjb2xvcjp3aW5kb3d0ZXh0O3RleHQtZGVjb3JhdGlvbjpub25lIj5k
ZXZlbEBhY3BpY2Eub3JnJmx0O21haWx0bzpkZXZlbEBhY3BpY2Eub3JnPC9zcGFuPjwvYT4mZ3Q7
PG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsgU3ViamVjdDogUmU6
IFtEZXZlbF0gLUQgJmx0O3N5bWJvbCZndDsgUHJlcHJvY2Vzc29yIE9wdGlvbiBEb2Vzbid0IFdv
cms8bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyA8bzpwPjwvbzpw
PjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyBXZSB3aWxsIGNoZWNrIGl0IG91dC48
bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyBUaGFua3MsPG86cD48
L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsgQm9iPG86cD48L286cD48L3A+
CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsgRnJvbTogPGEgaHJlZj0ibWFpbHRvOmRldmVs
LWJvdW5jZXNAYWNwaWNhLm9yZyUzY21haWx0bzpkZXZlbC1ib3VuY2VzQGFjcGljYS5vcmciPgo8
c3BhbiBzdHlsZT0iY29sb3I6d2luZG93dGV4dDt0ZXh0LWRlY29yYXRpb246bm9uZSI+ZGV2ZWwt
Ym91bmNlc0BhY3BpY2Eub3JnJmx0O21haWx0bzpkZXZlbC1ib3VuY2VzQGFjcGljYS5vcmc8L3Nw
YW4+PC9hPiZndDs8bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyBb
PGEgaHJlZj0ibWFpbHRvOmRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZyI+PHNwYW4gc3R5bGU9ImNv
bG9yOndpbmRvd3RleHQ7dGV4dC1kZWNvcmF0aW9uOm5vbmUiPm1haWx0bzpkZXZlbC1ib3VuY2Vz
QGFjcGljYS5vcmc8L3NwYW4+PC9hPl0gT24gQmVoYWxmIE9mIEFsZXhlaSBGZWRvcm92PG86cD48
L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsgU2VudDogVHVlc2RheSwgTWF5
IDE0LCAyMDEzIDU6MjcgQU08bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+
Jmd0OyBUbzogPGEgaHJlZj0ibWFpbHRvOmRldmVsQGFjcGljYS5vcmclM2NtYWlsdG86ZGV2ZWxA
YWNwaWNhLm9yZyI+CjxzcGFuIHN0eWxlPSJjb2xvcjp3aW5kb3d0ZXh0O3RleHQtZGVjb3JhdGlv
bjpub25lIj5kZXZlbEBhY3BpY2Eub3JnJmx0O21haWx0bzpkZXZlbEBhY3BpY2Eub3JnPC9zcGFu
PjwvYT4mZ3Q7PG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsgU3Vi
amVjdDogW0RldmVsXSAtRCAmbHQ7c3ltYm9sJmd0OyBQcmVwcm9jZXNzb3IgT3B0aW9uIERvZXNu
J3QgV29yazxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7IDxvOnA+
PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7IEhpLDxvOnA+PC9vOnA+PC9w
Pgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7IDxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0i
TXNvUGxhaW5UZXh0Ij4mZ3Q7IEFTTCBVc2VyIEd1aWRlIHN0YXRlcyB0aGF0ICNpZmRlZiBzdGF0
ZW1lbnRzIGFyZSByZWNvZ25pemVkIHdoZW4gYSBzeW1ib2w8bzpwPjwvbzpwPjwvcD4KPHAgY2xh
c3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyBpcyBkZWZpbmVkIGluIHRoZSBjb21tYW5kIGxpbmU6PG86
cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsgPG86cD48L286cD48L3A+
CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsgJnF1b3Q7My4zLjIuMiAjaWZkZWY8bzpwPjwv
bzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyBVc2FnZTo8bzpwPjwvbzpwPjwv
cD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyAjaWZkZWYgc3ltYm9sPG86cD48L286cD48
L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsgQ29uZGl0aW9uYWxseSBjb21waWxlIGEg
YmxvY2sgb2YgdGV4dC4gVGhlIGJsb2NrIGlzIGluY2x1ZGVkIGluIHRoZTxvOnA+PC9vOnA+PC9w
Pgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7IGNvbXBpbGF0aW9uIGlmIHRoZSBzeW1ib2wg
aXMgZGVmaW5lZCwgZWl0aGVyIGZyb20gYSAjZGVmaW5lIG9yIGZyb20gdGhlIC08bzpwPjwvbzpw
PjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyBEIGNvbW1hbmQgbGluZSBvcHRpb24m
cXVvdDs8bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyA8bzpwPjwv
bzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyBidXQgSSBjYW5ub3QgbWFrZSBB
U0wgQ29tcGlsZXIgdG8gcmVjb2duaXplIHRoZSBmb2xsb3dpbmcgb3B0aW9uPG86cD48L286cD48
L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsmbmJzcDsmbmJzcDsgLUQgJmx0O3N5bWJv
bCZndDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgRGVmaW5lIHN5bWJvbCBm
b3IgcHJlcHJvY2Vzc29yIHVzZTxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0
Ij4mZ3Q7IDxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7IEluIHRo
ZSBleGFtcGxlIGJlbG93PG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZn
dDsgPG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsgRGVmaW5pdGlv
bkJsb2NrKCZxdW90O0RTRFQuQU1MJnF1b3Q7LCAmcXVvdDtEU0RUJnF1b3Q7LCAweDAxLCAmcXVv
dDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgJnF1b3Q7LCAmcXVvdDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgJnF1b3Q7LCAzKSB7PG86cD48L286cD48
L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsmbmJzcDsmbmJzcDsgU2NvcGUoX1NCKSB7
PG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsgRGV2aWNlKENQVTApIHs8bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1Bs
YWluVGV4dCI+Jmd0OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBOYW1lKF9I
SUQsICZxdW90O0FDUEkwMDA3JnF1b3Q7KTxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxh
aW5UZXh0Ij4mZ3Q7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IE5hbWUoX1VJ
RCwgWmVybyk8bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyB9PG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRl
eHQiPiZndDsgI2lmZGVmIENQVV8xPG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRl
eHQiPiZndDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgRGV2aWNlKENQVTEpIHs8bzpwPjwvbzpw
PjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyBOYW1lKF9ISUQsICZxdW90O0FDUEkwMDA3JnF1b3Q7KTxvOnA+PC9vOnA+PC9wPgo8cCBj
bGFzcz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IE5hbWUo
X1VJRCwgT25lKTxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IH08bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWlu
VGV4dCI+Jmd0OyAjZW5kaWY8bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+
Jmd0OyZuYnNwOyZuYnNwOyB9PG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQi
PiZndDsgfTxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7IDxvOnA+
PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7IFRoZSBzZWN0aW9uIGJldHdl
ZW4gI2lmZGVmIENQVV8xIC4uLiAjZW5kaWYgaXMgbm90IGJlaW5nIGNvbXBpbGVkIHdoZW4gQVNM
PG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsgaXMgaW52b2tlZCBh
czo8bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyBpYXNsLmV4ZSAt
bCAtRCBDUFVfMSBEc2R0LmFzbDxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0
Ij4mZ3Q7IENoZWNrZWQgd2l0aCB0aGUgbGF0ZXN0IHZlcnNpb24gMjAxMzA0MTgtMzIgW0FwciAx
OCAyMDEzXS48bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyA8bzpw
PjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyBBbnkgdGhvdWdodHMgb24g
d2hhdCBtaWdodCBiZSBnb2luZyB3cm9uZyBoZXJlPzxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0i
TXNvUGxhaW5UZXh0Ij4mZ3Q7IFRoYW5rcy48bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1Bs
YWluVGV4dCI+Jmd0OyA8bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0
OyA8bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyA8bzpwPjwvbzpw
PjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyAtLSBJTVBPUlRBTlQgTk9USUNFOiBU
aGUgY29udGVudHMgb2YgdGhpcyBlbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIGFyZTxvOnA+PC9v
OnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7IGNvbmZpZGVudGlhbCBhbmQgbWF5
IGFsc28gYmUgcHJpdmlsZWdlZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkPG86cD48L286
cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsgcmVjaXBpZW50LCBwbGVhc2Ugbm90
aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgYW5kIGRvIG5vdCBkaXNjbG9zZSB0aGU8bzpwPjwv
bzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyBjb250ZW50cyB0byBhbnkgb3Ro
ZXIgcGVyc29uLCB1c2UgaXQgZm9yIGFueSBwdXJwb3NlLCBvciBzdG9yZSBvciBjb3B5IHRoZTxv
OnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7IGluZm9ybWF0aW9uIGlu
IGFueSBtZWRpdW0uIFRoYW5rIHlvdS48bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWlu
VGV4dCI+Jmd0OyA8bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyAt
LSBJTVBPUlRBTlQgTk9USUNFOiBUaGUgY29udGVudHMgb2YgdGhpcyBlbWFpbCBhbmQgYW55IGF0
dGFjaG1lbnRzIGFyZTxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7
IGNvbmZpZGVudGlhbCBhbmQgbWF5IGFsc28gYmUgcHJpdmlsZWdlZC4gSWYgeW91IGFyZSBub3Qg
dGhlIGludGVuZGVkPG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsg
cmVjaXBpZW50LCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgYW5kIGRvIG5v
dCBkaXNjbG9zZSB0aGU8bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0
OyBjb250ZW50cyB0byBhbnkgb3RoZXIgcGVyc29uLCB1c2UgaXQgZm9yIGFueSBwdXJwb3NlLCBv
ciBzdG9yZSBvciBjb3B5IHRoZTxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0
Ij4mZ3Q7IGluZm9ybWF0aW9uIGluIGFueSBtZWRpdW0uIFRoYW5rIHlvdS48bzpwPjwvbzpwPjwv
cD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyAtLS0tLS0tLS0tLS0tLSBuZXh0IHBhcnQg
LS0tLS0tLS0tLS0tLS08bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0
OyBBbiBIVE1MIGF0dGFjaG1lbnQgd2FzIHNjcnViYmVkLi4uPG86cD48L286cD48L3A+CjxwIGNs
YXNzPSJNc29QbGFpblRleHQiPiZndDsgVVJMOjxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNv
UGxhaW5UZXh0Ij4mZ3Q7ICZsdDtodHRwOi8vbGlzdHMuYWNwaWNhLm9yZy9waXBlcm1haWwvZGV2
ZWwvYXR0YWNobWVudHMvMjAxMzA1MTYvZWI4YTQ5NmEvYXR0PG86cD48L286cD48L3A+CjxwIGNs
YXNzPSJNc29QbGFpblRleHQiPiZndDsgYWNobWVudC5odG1sJmd0OzxvOnA+PC9vOnA+PC9wPgo8
cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7IDxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNv
UGxhaW5UZXh0Ij4mZ3Q7IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTxvOnA+PC9vOnA+
PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7IDxvOnA+PC9vOnA+PC9wPgo8cCBjbGFz
cz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fPG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsg
RGV2ZWwgbWFpbGluZyBsaXN0PG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQi
PiZndDsgPGEgaHJlZj0ibWFpbHRvOkRldmVsQGFjcGljYS5vcmciPjxzcGFuIHN0eWxlPSJjb2xv
cjp3aW5kb3d0ZXh0O3RleHQtZGVjb3JhdGlvbjpub25lIj5EZXZlbEBhY3BpY2Eub3JnPC9zcGFu
PjwvYT48bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyA8YSBocmVm
PSJodHRwczovL2xpc3RzLmFjcGljYS5vcmcvbWFpbG1hbi9saXN0aW5mby9kZXZlbCI+CjxzcGFu
IHN0eWxlPSJjb2xvcjp3aW5kb3d0ZXh0O3RleHQtZGVjb3JhdGlvbjpub25lIj5odHRwczovL2xp
c3RzLmFjcGljYS5vcmcvbWFpbG1hbi9saXN0aW5mby9kZXZlbDwvc3Bhbj48L2E+PG86cD48L286
cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsgPG86cD48L286cD48L3A+CjxwIGNs
YXNzPSJNc29QbGFpblRleHQiPiZndDsgRW5kIG9mIERldmVsIERpZ2VzdCwgVm9sIDM4LCBJc3N1
ZSA1PG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsgKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqPG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29Q
bGFpblRleHQiPiZndDsgPG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZn
dDsgPG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsgLS0gSU1QT1JU
QU5UIE5PVElDRTogVGhlIGNvbnRlbnRzIG9mIHRoaXMgZW1haWwgYW5kIGFueSBhdHRhY2htZW50
cyBhcmU8bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyBjb25maWRl
bnRpYWwgYW5kIG1heSBhbHNvIGJlIHByaXZpbGVnZWQuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRl
bmRlZDxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7IHJlY2lwaWVu
dCwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGFuZCBkbyBub3QgZGlzY2xv
c2UgdGhlPG86cD48L286cD48L3A+CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsgY29udGVu
dHMgdG8gYW55IG90aGVyIHBlcnNvbiwgdXNlIGl0IGZvciBhbnkgcHVycG9zZSwgb3Igc3RvcmUg
b3IgY29weSB0aGU8bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyBp
bmZvcm1hdGlvbiBpbiBhbnkgbWVkaXVtLiZuYnNwOyBUaGFuayB5b3UuPG86cD48L286cD48L3A+
CjxwIGNsYXNzPSJNc29QbGFpblRleHQiPiZndDsgPG86cD48L286cD48L3A+CjxwIGNsYXNzPSJN
c29QbGFpblRleHQiPiZndDsgX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX188bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0OyBEZXZl
bCBtYWlsaW5nIGxpc3Q8bzpwPjwvbzpwPjwvcD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+Jmd0
OyA8YSBocmVmPSJtYWlsdG86RGV2ZWxAYWNwaWNhLm9yZyI+PHNwYW4gc3R5bGU9ImNvbG9yOndp
bmRvd3RleHQ7dGV4dC1kZWNvcmF0aW9uOm5vbmUiPkRldmVsQGFjcGljYS5vcmc8L3NwYW4+PC9h
PjxvOnA+PC9vOnA+PC9wPgo8cCBjbGFzcz0iTXNvUGxhaW5UZXh0Ij4mZ3Q7IDxhIGhyZWY9Imh0
dHBzOi8vbGlzdHMuYWNwaWNhLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RldmVsIj4KPHNwYW4gc3R5
bGU9ImNvbG9yOndpbmRvd3RleHQ7dGV4dC1kZWNvcmF0aW9uOm5vbmUiPmh0dHBzOi8vbGlzdHMu
YWNwaWNhLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RldmVsPC9zcGFuPjwvYT48bzpwPjwvbzpwPjwv
cD4KPHAgY2xhc3M9Ik1zb1BsYWluVGV4dCI+PG86cD4mbmJzcDs8L286cD48L3A+CjwvZGl2Pgo8
YnI+Cjxmb250IGZhY2U9IkFyaWFsIiBjb2xvcj0iQmxhY2siIHNpemU9IjIiPi0tIElNUE9SVEFO
VCBOT1RJQ0U6IFRoZSBjb250ZW50cyBvZiB0aGlzIGVtYWlsIGFuZCBhbnkgYXR0YWNobWVudHMg
YXJlIGNvbmZpZGVudGlhbCBhbmQgbWF5IGFsc28gYmUgcHJpdmlsZWdlZC4gSWYgeW91IGFyZSBu
b3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVk
aWF0ZWx5IGFuZCBkbyBub3QgZGlzY2xvc2UgdGhlIGNvbnRlbnRzCiB0byBhbnkgb3RoZXIgcGVy
c29uLCB1c2UgaXQgZm9yIGFueSBwdXJwb3NlLCBvciBzdG9yZSBvciBjb3B5IHRoZSBpbmZvcm1h
dGlvbiBpbiBhbnkgbWVkaXVtLiBUaGFuayB5b3UuPGJyPgo8L2ZvbnQ+CjwvYm9keT4KPC9odG1s
Pg==
--===============3439713502676562018==--

