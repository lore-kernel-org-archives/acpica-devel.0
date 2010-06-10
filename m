Content-Type: multipart/mixed; boundary="===============6643768321818952249=="
MIME-Version: 1.0
From: Jukka Ruohonen <jruohonen at iki.fi>
Subject: Re: [Devel] AcpiClearGpe() and recent changes
Date: Thu, 10 Jun 2010 23:23:03 +0300
Message-ID: <20100610202303.GA5424@marx.bitnet>
In-Reply-To: 4911F71203A09E4D9981D27F9D83085870DEC8AD@orsmsx503.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6643768321818952249==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 10, 2010 at 01:09:38PM -0700, Moore, Robert wrote:
> I'm not entirely sure at the moment, but we are about to make some
> additional GPE changes since some issues with the reference count
> mechanism have been uncovered.
> =

> Do you have a need to call AcpiClearGpe from interrupt level?

No.

I was mainly after the inconsistency in the API. As AcpiClearGpe() uses
unconditionally the same lock that has been acquired earlier by one of the
dispatching functions, this leads to a panic or other comparable condition,
depending on the implementation.

So perhaps this could be solved at the documentation level by nothing that
AcpiClearGpe() may NOT be used from a GPE handler.

- Jukka.

--===============6643768321818952249==--

