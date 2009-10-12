Content-Type: multipart/mixed; boundary="===============6444458745370428761=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] acpica for other architecture
Date: Mon, 12 Oct 2009 09:06:43 -0700
Message-ID: <4911F71203A09E4D9981D27F9D8308583B2932A0@orsmsx503.amr.corp.intel.com>
In-Reply-To: 4ACF0777.7000408@c-lab.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6444458745370428761==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Most ACPI tables are directly consumed by the host OS and do not require an=
 AML interpreter (such as MADT, SRAT, SLIT, etc.)

Only the DSDT and any SSDTs contain AML byte code that must be interpreted.

If you only wish to create the non-AML tables, the Table Manager component =
of ACPICA can be used standalone to discover and extract them.

I suggest that you read the ACPI specification and the ACPICA programmer re=
ference.

ACPI spec available at acpi.info
ACPICA reference available at http://www.acpica.org/documentation/


Bob


>-----Original Message-----
>From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] On Be=
half
>Of Da He
>Sent: Friday, October 09, 2009 2:51 AM
>To: Lin Ming
>Cc: Devel(a)acpica.org
>Subject: Re: [Devel] acpica for other architecture
>
>Hello Liu Ming,
>
>Thanks for your reply. I was thinking about using ACPI concept in
>embedded systems to manage cpu and device power consumption. I know that
>there is lack of hardware ACPI supports, but as far as I understand, the
>core of ACPI is various ACPI tables which describe hardware device
>resources and define control methods. Just one very simple example, if I
>have one device or periphery attached on a bus that can be operated in
>different power saving states, maybe I could describe this device in the
>DSDT so that the OS could configure and govern it at runtime. Besides, I
>think there are also many embedded processors which supports DVFS. As I
>would like to try this on a FPGA based development platform, I could add
>some additional hardware supports by myself if needed.
>
>These are only some thoughts, but I am not sure if it is feasible. I
>would be very grateful if you could give me some advice. Thanks in advance.
>
>Best regards
>Da He
>
>Lin Ming wrote:
>> On Wed, Oct 7, 2009 at 10:26 PM, Da He <da.he(a)c-lab.de> wrote:
>>
>>> Hello all,
>>>
>>> I am a beginner in using ACPICA. I am wondering if I can use acpica for
>>> a non-x86 platform (e.g. PowerPC or ARM). As far as I understand, there
>>> is an integrated AML interpreter. If I cross compile acpica for other
>>> architecture, will that interpreter still work? Thanks in advance.
>>>
>>
>> Yes.
>>
>> But PowerPC or ARM does not have hardware support for ACPI at all.
>> What are you going to do of using acpica for a non-x86 platform?
>>
>> Lin Ming
>>
>>
>>> Best regards
>>> Da He
>>> _______________________________________________
>>> Devel mailing list
>>> Devel(a)acpica.org
>>> http://lists.acpica.org/listinfo/devel
>>>
>>>
>
>--
>Dipl.-Inform. Da He
>Univ. Paderborn/c-lab
>Fuerstenallee 11
>D-33102 Paderborn
>Tel:  +49 5251 60 6128
>Fax:  +49 5251 60 6065
>http://www.c-lab.de/
>
>_______________________________________________
>Devel mailing list
>Devel(a)acpica.org
>http://lists.acpica.org/listinfo/devel

--===============6444458745370428761==--

