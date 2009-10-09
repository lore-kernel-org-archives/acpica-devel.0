Content-Type: multipart/mixed; boundary="===============7289827941174417822=="
MIME-Version: 1.0
From: Da He <da.he at c-lab.de>
Subject: Re: [Devel] acpica for other architecture
Date: Fri, 09 Oct 2009 11:50:47 +0200
Message-ID: <4ACF0777.7000408@c-lab.de>
In-Reply-To: d3f22a0910081807x5eca5c88y3d81e683577ff77b@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7289827941174417822==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Liu Ming,

Thanks for your reply. I was thinking about using ACPI concept in
embedded systems to manage cpu and device power consumption. I know that
there is lack of hardware ACPI supports, but as far as I understand, the
core of ACPI is various ACPI tables which describe hardware device
resources and define control methods. Just one very simple example, if I
have one device or periphery attached on a bus that can be operated in
different power saving states, maybe I could describe this device in the
DSDT so that the OS could configure and govern it at runtime. Besides, I
think there are also many embedded processors which supports DVFS. As I
would like to try this on a FPGA based development platform, I could add
some additional hardware supports by myself if needed.

These are only some thoughts, but I am not sure if it is feasible. I
would be very grateful if you could give me some advice. Thanks in advance.

Best regards
Da He

Lin Ming wrote:
> On Wed, Oct 7, 2009 at 10:26 PM, Da He <da.he(a)c-lab.de> wrote:
>   =

>> Hello all,
>>
>> I am a beginner in using ACPICA. I am wondering if I can use acpica for
>> a non-x86 platform (e.g. PowerPC or ARM). As far as I understand, there
>> is an integrated AML interpreter. If I cross compile acpica for other
>> architecture, will that interpreter still work? Thanks in advance.
>>     =

>
> Yes.
>
> But PowerPC or ARM does not have hardware support for ACPI at all.
> What are you going to do of using acpica for a non-x86 platform?
>
> Lin Ming
>
>   =

>> Best regards
>> Da He
>> _______________________________________________
>> Devel mailing list
>> Devel(a)acpica.org
>> http://lists.acpica.org/listinfo/devel
>>
>>     =


-- =

Dipl.-Inform. Da He
Univ. Paderborn/c-lab
Fuerstenallee 11
D-33102 Paderborn
Tel:  +49 5251 60 6128
Fax:  +49 5251 60 6065
http://www.c-lab.de/


--===============7289827941174417822==--

