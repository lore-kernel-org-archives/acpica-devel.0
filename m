Content-Type: multipart/mixed; boundary="===============8271786751765771759=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH v3 3/3] x86/acpi,
 x86/boot: Add multiprocessor wake-up support
Date: Mon, 10 May 2021 19:23:02 +0200
Message-ID: <CAJZ5v0jMo9+ohUJ_=KHL_QwEo5GmAn_fMkng==Zmy-AJ=MPRog@mail.gmail.com>
In-Reply-To: 4fa40e7a-bcb2-db0f-8dc5-28728b14377d@linux.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8271786751765771759==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, May 10, 2021 at 7:10 PM Kuppuswamy, Sathyanarayanan
<sathyanarayanan.kuppuswamy(a)linux.intel.com> wrote:
>
>
>
> On 5/10/21 9:55 AM, Rafael J. Wysocki wrote:
> > I'm not sure how my comment regarding the fact that for a given CPU
> > this function is only usable once has been addressed.
> >
> > While it may not be a practical concern in the use case that you are
> > after (TDX), this is a generic mechanism and it needs to cover other
> > possible usage scenarios.
>
> For the same CPU, if we try to use mailbox again, firmware will not
> respond to it.

Well, theoretically, but what if it checks the mailbox every time for
all CPUs?  Or similar?

> So the command will timeout and return error.

If the firmware behaves as expected, but what if it doesn't?
--===============8271786751765771759==--

