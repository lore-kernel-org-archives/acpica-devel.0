Content-Type: multipart/mixed; boundary="===============2123792750555498477=="
MIME-Version: 1.0
From: Al Stone <ahs3 at redhat.com>
Subject: Re: [Devel] [PATCH] ACPICA: acpidump -- provide initial
 implementation for Linux
Date: Sun, 02 Jun 2013 14:04:18 -0600
Message-ID: <51ABA542.3020907@redhat.com>
In-Reply-To: 51A976F6.7060706@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2123792750555498477==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 05/31/2013 10:22 PM, Al Stone wrote:
> On 05/31/2013 06:46 PM, Moore, Robert wrote:
>> Al,
>>
>> We've just completed and checked in a full implementation for Linux.
>>
>> You might want to inspect the code and see if there is anything that
>> can be or should be merged. The code is at (or near) the head of our
>> git tree.
>>
>> Thanks,
>> Bob
>
> Ah, interesting; I did a pull this afternoon and had
> not seen any such changes.  I'll take a look and see
> what can be merged.

After looking at the two patches, there's not much that
they share in common; I don't think there's anything that
would make sense to merge -- the approaches are very
different.

I do have a couple of concerns with the implementation,
though:

1) While mmap() of /dev/mem makes sense, I suspect there
    are cases where one can attempt to mmap() the wrong
    address and lock up the system.  I have not seen a good
    way to avoid this just yet without a priori being able
    to establish the proper physical addresses for the tables
    but that may require a kernel patch to provide the addresses
    via /sys.  At a minimum, we should warn folks that this
    could happen.  This was the only reason I did not include
    an implementation of AcpiOsGetTableByAddress().

2) I've seen at least a few systems with more than one UEFI
    table instance.  Whether allowed or not, it looks like
    the acpidump code will only allow this for SSDTs.

Thanks for checking the code in.  Now that I know an acpidump
will be there, I can fix up the distro packages to handle this
new version of the command properly, too.

-- =

ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3(a)redhat.com
-----------------------------------

--===============2123792750555498477==--

