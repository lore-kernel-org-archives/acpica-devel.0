Content-Type: multipart/mixed; boundary="===============6909339895569999983=="
MIME-Version: 1.0
From: Al Stone <ahs3 at redhat.com>
Subject: Re: [Devel] [RFC] proposed patch for some segfaults encountered
Date: Tue, 02 Jun 2015 09:07:22 -0600
Message-ID: <556DC6AA.4000009@redhat.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E37D2F10A4@ORSMSX112.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6909339895569999983==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Interesting.  I'll double check the results from ASLTS but I don't recall
seeing any changes.

On 06/01/2015 03:58 PM, Moore, Robert wrote:
> I think we have taken at least one look at this one. We added checks for =
null pointers, but then the compiler failed our test suite. So, we feel tha=
t the problem is a bit more complex. However, it is on our list of things t=
o do.
> =

> =

>> -----Original Message-----
>> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Al Stone
>> Sent: Monday, June 01, 2015 1:59 PM
>> To: devel(a)acpica.org
>> Subject: [Devel] [RFC] proposed patch for some segfaults encountered
>>
>> It's not clear to me that this is the correct way to handle a segfault
>> that was reported to me via Fedora.
>>
>> Using the ssdt9.dat file attached, a simple "iasl -d ssdt9.dat" will
>> segfault around calls to AcpiDmPromoteTarget -- and it turns out that the
>> Target pointer being passed into that function was sometimes null but not
>> being checked in the calling function, AcpiDmCheckForSymbolicOpcode.  So,
>> this patch adds in some checks for null pointers and can now get through
>> this particular problem.
>>
>> However, I did not study AcpiDmCheckForSymbolicOpcode long enough to
>> determine if the Target pointer in that function should or should not ev=
er
>> be null.  So, this patch fixes this issue, but it may not be the proper
>> long term solution.
>>
>> --
>> ciao,
>> al
>> -----------------------------------
>> Al Stone
>> Software Engineer
>> Red Hat, Inc.
>> ahs3(a)redhat.com
>> -----------------------------------


-- =

ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3(a)redhat.com
-----------------------------------

--===============6909339895569999983==--

