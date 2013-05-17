Content-Type: multipart/mixed; boundary="===============6658350970767862103=="
MIME-Version: 1.0
From: Alexei Fedorov <Alexei.Fedorov at arm.com>
Subject: Re: [Devel] -D <symbol> Preprocessor Option Doesn't Work
Date: Fri, 17 May 2013 11:16:12 +0100
Message-ID: <20E136AF98049A48A90A7417B4343D5E32BC64FF05@BUNGLE.Emea.Arm.com>
In-Reply-To: mailman.113.1368724147.2837.devel@acpica.org
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6658350970767862103==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

>Yes, it looks like it has been there a while.
>You can checkout the patch, or I can send you an updated windows binary.
Hi Robert,
Please send me an updated binary.
Thanks.
-----Original Message-----
From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] On Beh=
alf Of devel-request(a)acpica.org
Sent: 16 May 2013 18:09
To: devel(a)acpica.org
Subject: Devel Digest, Vol 38, Issue 5

Send Devel mailing list submissions to
        devel(a)acpica.org

To subscribe or unsubscribe via the World Wide Web, visit
        https://lists.acpica.org/mailman/listinfo/devel
or, via email, send a message with subject or body 'help' to
        devel-request(a)acpica.org

You can reach the person managing the list at
        devel-owner(a)acpica.org

When replying, please edit your Subject line so it is more specific
than "Re: Contents of Devel digest..."


Today's Topics:

   1. Re: -D <symbol> Preprocessor Option Doesn't Work (Moore, Robert)
   2. Re: -D <symbol> Preprocessor Option Doesn't Work (Moore, Robert)


----------------------------------------------------------------------

Message: 1
Date: Thu, 16 May 2013 15:59:17 +0000
From: "Moore, Robert" <robert.moore(a)intel.com>
To: Alexei Fedorov <Alexei.Fedorov(a)arm.com>, "devel(a)acpica.org"
        <devel(a)acpica.org>
Subject: Re: [Devel] -D <symbol> Preprocessor Option Doesn't Work
Message-ID:
        <94F2FBAB4432B54E8AACC7DFDE6C92E36FE6C321(a)ORSMSX103.amr.corp.inte=
l.com>

Content-Type: text/plain; charset=3D"us-ascii"

The fix for this is checked into our git tree.
Bob
From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] On Beh=
alf Of Moore, Robert
Sent: Wednesday, May 15, 2013 10:33 AM
To: Alexei Fedorov; devel(a)acpica.org
Subject: Re: [Devel] -D <symbol> Preprocessor Option Doesn't Work

Sorry, we did some code restructuring and broke this. You can go back to an=
 earlier version of the compiler, or wait until later this week when there =
will be a new version.
Bob
From: devel-bounces(a)acpica.org<mailto:devel-bounces(a)acpica.org> [mailto=
:devel-bounces(a)acpica.org] On Behalf Of Moore, Robert
Sent: Wednesday, May 15, 2013 8:43 AM
To: Alexei Fedorov; devel(a)acpica.org<mailto:devel(a)acpica.org>
Subject: Re: [Devel] -D <symbol> Preprocessor Option Doesn't Work

We will check it out.
Thanks,
Bob
From: devel-bounces(a)acpica.org<mailto:devel-bounces(a)acpica.org> [mailto=
:devel-bounces(a)acpica.org] On Behalf Of Alexei Fedorov
Sent: Tuesday, May 14, 2013 5:27 AM
To: devel(a)acpica.org<mailto:devel(a)acpica.org>
Subject: [Devel] -D <symbol> Preprocessor Option Doesn't Work

Hi,

ASL User Guide states that #ifdef statements are recognized when a symbol i=
s defined in the command line:

"3.3.2.2 #ifdef
Usage:
#ifdef symbol
Conditionally compile a block of text. The block is included in the compila=
tion if the symbol is defined, either from a #define or from the - D comman=
d line option"

but I cannot make ASL Compiler to recognize the following option
  -D <symbol>       Define symbol for preprocessor use

In the example below

DefinitionBlock("DSDT.AML", "DSDT", 0x01, "      ", "        ", 3) {
  Scope(_SB) {
    Device(CPU0) {
      Name(_HID, "ACPI0007")
      Name(_UID, Zero)
    }
#ifdef CPU_1
    Device(CPU1) {
              Name(_HID, "ACPI0007")
              Name(_UID, One)
    }
#endif
  }
}

The section between #ifdef CPU_1 ... #endif is not being compiled when ASL =
is invoked as:
iasl.exe -l -D CPU_1 Dsdt.asl
Checked with the latest version 20130418-32 [Apr 18 2013].

Any thoughts on what might be going wrong here?
Thanks.



-- IMPORTANT NOTICE: The contents of this email and any attachments are con=
fidential and may also be privileged. If you are not the intended recipient=
, please notify the sender immediately and do not disclose the contents to =
any other person, use it for any purpose, or store or copy the information =
in any medium. Thank you.

--===============6658350970767862103==--

