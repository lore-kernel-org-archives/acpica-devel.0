Content-Type: multipart/mixed; boundary="===============2231389881208886572=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] Correct ACPI setup sequence
Date: Fri, 04 Sep 2009 13:23:30 -0700
Message-ID: <4911F71203A09E4D9981D27F9D8308583748B99D@orsmsx503.amr.corp.intel.com>
In-Reply-To: 20090904201106.GA5266@britannica.bec.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2231389881208886572==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



>-----Original Message-----
>From: Joerg Sonnenberger [mailto:joerg(a)britannica.bec.de]
>Sent: Friday, September 04, 2009 1:11 PM
>To: Moore, Robert
>Cc: devel(a)acpica.org
>Subject: Re: [Devel] Correct ACPI setup sequence
>
>On Fri, Sep 04, 2009 at 12:58:26PM -0700, Moore, Robert wrote:
>> I'm not sure that I fully understand your question, but things like
>> the MADT and ECDT are typically parsed and consumed by the host OS
>> *before* the ACPICA subsystem is initialized. This is why the ACPICA
>> Table Manager is available at early boot time, before ACPICA is
>> initialized, and even before dynamic memory is available.
>
>OK, I think that answers the question indirectly. Just to make sure:
>- I can parse the MADT before anything else.


Yes.



>- If the MADT exists and contains IOAPICs, I can expect \_PIC to be
>  successful.


I don't know the answer to this.


>
>The second is important for the case of Interrupt Overrides for the SCI,
>which is the problem here.
>
>Joerg
>
>PS: ACPI 4.0 has a bad cross-reference in 5.2.12.4, 5.2.10.8 no longer
>exists. Who is the right person for that?


I just forwarded this to the ACPI 4.0 editor. Thanks. You can send any such=
 errors directly to me. We own the ACPI specification here.

Bob


--===============2231389881208886572==--

