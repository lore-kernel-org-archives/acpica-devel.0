Content-Type: multipart/mixed; boundary="===============8346783673414398002=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] Query about the ACPI
Date: Mon, 18 Jan 2010 08:31:45 -0800
Message-ID: <4911F71203A09E4D9981D27F9D83085850150DDB@orsmsx503.amr.corp.intel.com>
In-Reply-To: F3559959283BB949B69FE4146615117C67A5442674@GVW1161EXB.americas.hpqcorp.net
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8346783673414398002==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Also, ACPICA includes a 'simulator' that executes the AML interpreter, etc.=
 in user space (acpiexec). It does not touch the actual hardware however. A=
cpiexec is portable and runs on windows.


>-----Original Message-----
>From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] On Be=
half
>Of Hsu, Edward (ETD)
>Sent: Monday, January 18, 2010 2:22 AM
>To: Lin, Ming M
>Cc: devel(a)acpica.org
>Subject: Re: [Devel] Query about the ACPI
>
>Hello Ming,
>
> Thanks a lot for your explanations.
>
>
>Best Regards,
>
>Edward Hsu
>
>
>
>-----Original Message-----
>From: Lin, Ming M [mailto:ming.m.lin(a)intel.com]
>Sent: Monday, January 18, 2010 10:21 AM
>To: Hsu, Edward (ETD)
>Cc: devel(a)acpica.org
>Subject: RE: [Devel] Query about the ACPI
>
>As I know, ACPICA is used in nearly every OS (Linux/FreeBSD/Solars/Apple
>etc), except Windows.
>It's the driver interface, so it can't be used in applications.
>See http://www.acpica.org/documentation/ for the programmer reference.
>
>Lin Ming
>
>>-----Original Message-----
>>From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] On B=
ehalf
>Of
>>Hsu, Edward (ETD)
>>Sent: Monday, January 18, 2010 10:13 AM
>>To: Lin Ming
>>Cc: devel(a)acpica.org
>>Subject: Re: [Devel] Query about the ACPI
>>
>>Hi Ming,
>>
>>May I ask your ACPICA(indicated on http://www.acpica.org/,) is used under
>which
>>circumstances, such as developing in which enviroment, ...,etc?  Thank you
>very
>>much.
>>
>>
>>
>>Best Regards,
>>
>>Edward Hsu
>>
>>
>>
>>-----Original Message-----
>>From: Lin Ming [mailto:lin(a)minggr.cn]
>>Sent: Monday, January 18, 2010 10:02 AM
>>To: Hsu, Edward (ETD)
>>Cc: Moore, Robert; devel(a)acpica.org
>>Subject: Re: [Devel] Query about the ACPI
>>
>>On Mon, Jan 18, 2010 at 9:40 AM, Hsu, Edward (ETD) <ehsu(a)hp.com> wrote:
>>>
>>> Hi Bob,
>>>
>>> As programing the applications in Windows,=C2=A0 I was wondering if the
>>applications are able to invoke the ACPI driver/AML Interpreter, ask for
>the
>>data from ACPI registers/ACPI BIOS/ACPI Tables as below. Thank you.
>>
>>Windows has its own ACPI driver/AML Interpreter. The interface is
>>different with ACPICA.
>>Applications can't access the register directly.
>>You need to write a driver in Windows to access the register.
>>
>>Some info at http://msdn.microsoft.com/en-us/library/ms789240.aspx
>>
>>Lin Ming
>>
>>>
>>>
>>> Best Regards,
>>>
>>> Edward Hsu
>>>
>>>
>>>
>>> -----Original Message-----
>>> From: Moore, Robert [mailto:robert.moore(a)intel.com]
>>> Sent: Friday, January 15, 2010 9:45 PM
>>> To: Hsu, Edward (ETD); devel(a)acpica.org
>>> Subject: RE: Query about the ACPI
>>>
>>>
>>>
>>> >-----Original Message-----
>>> >From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] On
>Behalf
>>> >Of Hsu, Edward (ETD)
>>> >Sent: Thursday, January 14, 2010 9:59 PM
>>> >To: devel(a)acpica.org
>>> >Subject: [Devel] Query about the ACPI
>>> >
>>> >To whom it may concern,
>>> >
>>> >Hello, I've gone through the ACPI website, http://www.acpica.org/, and
>I
>>> >was wondering if the all Intel-related developmet tools would work for
>AMD
>>> >platform as well.
>>> >
>>>
>>> Yes. ACPI is not processor specific.
>>>
>>>
>>> >Besides, can it be merged into a Microsoft Windows application program?
>>>
>>> Please explain the question further.
>>>
>>> Bob
>>>
>>>
>>> >
>>> >Thank you very much.
>>> >
>>> >
>>> >Best Regards,
>>> >
>>> >Edward Hsu
>>> >_______________________________________________
>>> >Devel mailing list
>>> >Devel(a)acpica.org
>>> >http://lists.acpica.org/listinfo/devel
>>>
>>> _______________________________________________
>>> Devel mailing list
>>> Devel(a)acpica.org
>>> http://lists.acpica.org/listinfo/devel
>>_______________________________________________
>>Devel mailing list
>>Devel(a)acpica.org
>>http://lists.acpica.org/listinfo/devel
>_______________________________________________
>Devel mailing list
>Devel(a)acpica.org
>http://lists.acpica.org/listinfo/devel

--===============8346783673414398002==--

