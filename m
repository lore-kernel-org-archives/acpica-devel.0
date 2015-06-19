Content-Type: multipart/mixed; boundary="===============3533063723371976730=="
MIME-Version: 1.0
From: Dean Nelson <dnelson at redhat.com>
Subject: Re: [Devel] ACPICA version 20150619 released
Date: Fri, 19 Jun 2015 09:30:18 -0500
Message-ID: <5584277A.7030509@redhat.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E37D3037D9@ORSMSX112.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3533063723371976730==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 06/19/2015 09:15 AM, Moore, Robert wrote:
> 19 June 2015. Summary of changes for version 20150619:
>
> This release is available at https://acpica.org/downloads

Please excuse my ignorance, but why are the download files named
*.tar_0.gz ? Why the '_0' ?

Also I noticed that the git-repo with the latest commit being...

   commit d7a940bb308d001b5d2b196174fee36c7daa61d6
   Author:     Robert Moore <Robert.Moore(a)intel.com>
   AuthorDate: Thu Jun 18 08:13:39 2015 -0700
   Commit:     Robert Moore <Robert.Moore(a)intel.com>
   CommitDate: Thu Jun 18 08:13:39 2015 -0700
       Update version to 20150619.

differs from the two source code tarballs with regard to
source/compiler/asllookup.c by the git-diff file that I've
attached. But I don't see that patch mentioned in the git-repo.
So where did those changes come from? And do they really belong
in the tarballs? And if yes, why aren't they in the git-repo?

Thanks,
Dean


>
> Two regressions in version 20150616 have been addressed:
>
> Fixes some problems/issues with the C library macro removal (ACPI_STRLEN,=
 etc.)
> This update changes ACPICA to only use the standard headers for functions=
, or
> (optionally) the local prototypes for the local versions of the C library=
 functions.
> Across the source code, this required some additional casts for some Clib=
 invocations
> for portability. Moved all local prototypes to a new file, acclib.h
>
> Fixes several problems with recent changes to the handling of the FACS ta=
ble that
> could cause some systems not to boot.
>
>
> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> https://lists.acpica.org/mailman/listinfo/devel
>


--===============3533063723371976730==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="difference.patch"

ZGlmZiAtLWdpdCBhL3NvdXJjZS9jb21waWxlci9hc2xsb29rdXAuYyBiL3NvdXJjZS9jb21waWxl
ci9hc2xsb29rdXAuYwppbmRleCA0YTc1MzlhLi45YzYwZDAzIDEwMDY0NAotLS0gYS9zb3VyY2Uv
Y29tcGlsZXIvYXNsbG9va3VwLmMKKysrIGIvc291cmNlL2NvbXBpbGVyL2FzbGxvb2t1cC5jCkBA
IC0xODEsNiArMTgxLDEzIEBAIExrRmluZFVucmVmZXJlbmNlZE9iamVjdHMgKAogICogICAgICAg
ICAgICAgIGlmIHRoZXkgYXJlIG5vdCByZWZlcmVuY2VkLgogICoKICAqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKiovCit0eXBlZGVmIHN0cnVjdCBhc2xfbWV0aG9kX2xvY2FsCit7CisgICAgVUlOVDMyICAg
ICAgICAgICAgICAgICAgRmxhZ3M7CisgICAgQUNQSV9QQVJTRV9PQkpFQ1QgICAgICAgKk9wOwor
Cit9IEFTTF9NRVRIT0RfTE9DQUw7CisKIAogc3RhdGljIEFDUElfU1RBVFVTCiBMa0lzT2JqZWN0
VXNlZCAoCkBAIC0xOTEsNiArMTk4LDggQEAgTGtJc09iamVjdFVzZWQgKAogewogICAgIEFDUElf
TkFNRVNQQUNFX05PREUgICAgICpOb2RlID0gQUNQSV9DQVNUX1BUUiAoQUNQSV9OQU1FU1BBQ0Vf
Tk9ERSwgT2JqSGFuZGxlKTsKICAgICBBQ1BJX05BTUVTUEFDRV9OT0RFICAgICAqTmV4dDsKKyAg
ICBBU0xfTUVUSE9EX0xPQ0FMICAgICAgICAqTWV0aG9kTG9jYWxzOworICAgIFVJTlQzMiAgICAg
ICAgICAgICAgICAgIGk7CiAKIAogICAgIC8qIFJlZmVyZW5jZWQgZmxhZyBpcyBzZXQgZHVyaW5n
IHRoZSBuYW1lc3BhY2UgeHJlZiAqLwpAQCAtMjE3LDYgKzIyNiwyNCBAQCBMa0lzT2JqZWN0VXNl
ZCAoCiAKICAgICAgICAgcmV0dXJuIChBRV9PSyk7CiAKKyAgICBjYXNlIEFDUElfVFlQRV9NRVRI
T0Q6CisKKyAgICAgICAgLyogQ2hlY2sgZm9yIExvY2FscyB0aGF0IGFyZSBzZXQgYnV0IG5ldmVy
IHVzZWQgKi8KKworICAgICAgICBNZXRob2RMb2NhbHMgPSAoQVNMX01FVEhPRF9MT0NBTCAqKSBO
b2RlLT5PYmplY3Q7CisgICAgICAgIGZvciAoaSA9IDA7IGkgPCBBQ1BJX01FVEhPRF9OVU1fTE9D
QUxTOyBpKyspCisgICAgICAgIHsKKyAgICAgICAgICAgIGlmIChNZXRob2RMb2NhbHNbaV0uRmxh
Z3MgJiBBTk9CSl9JU19SRUZFUkVOQ0VEKQorICAgICAgICAgICAgeworICAgICAgICAgICAgICAg
IHNwcmludGYgKE1zZ0J1ZmZlciwgIkxvY2FsJXUiLAorICAgICAgICAgICAgICAgICAgICBpKTsK
KworICAgICAgICAgICAgICAgIEFzbEVycm9yIChBU0xfUkVNQVJLLCBBU0xfTVNHX0xPQ0FMX05P
VF9VU0VELAorICAgICAgICAgICAgICAgICAgICBNZXRob2RMb2NhbHNbaV0uT3AsIE1zZ0J1ZmZl
cik7CisgICAgICAgICAgICB9CisgICAgICAgIH0KKyAgICAgICAgYnJlYWs7CisKICAgICBkZWZh
dWx0OgogCiAgICAgICAgIGJyZWFrOwo=

--===============3533063723371976730==--

