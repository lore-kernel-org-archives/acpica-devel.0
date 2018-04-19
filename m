Content-Type: multipart/mixed; boundary="===============6987471829963825637=="
MIME-Version: 1.0
From: James Morse <james.morse at arm.com>
Subject: Re: [Devel] [RFC PATCH v2 3/4] acpi: apei: Do not panic() when
 correctable errors are marked as fatal.
Date: Thu, 19 Apr 2018 16:35:52 +0100
Message-ID: <e5e107e7-e18e-725a-8f9b-95e6f033ab45@arm.com>
In-Reply-To: bdc1d19b-3cc1-3f90-d276-414aaacdbd3a@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6987471829963825637==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alex,

(I haven't read through all this yet, just on this one:)

On 04/19/2018 03:57 PM, Alex G. wrote:
 > Maybe it's better move the AER handling to NMI/IRQ context, since
 > ghes_handle_aer() is only scheduling the real AER andler, and is irq
 > safe. I'm scratching my head about why we're messing with IRQ work from
 > NMI context, instead of just scheduling a regular handler to take care
 > of things.

We can't touch schedule_work_on() from NMI context as it takes spinlocks and
disables interrupts. (see __queue_work()) The NMI may have interrupted =

IRQ-context code
that was already holding the same locks.

IRQ-work behaves differently, it uses an llist for the work and an arch =

code hook
to raise a self-IPI.


Thanks,

James

--===============6987471829963825637==--

