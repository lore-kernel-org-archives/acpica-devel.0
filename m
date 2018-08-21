Content-Type: multipart/mixed; boundary="===============3091404800624980763=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] Regression: 18996f2db918 ("ACPICA: Events: Stop
 unconditionally clearing ACPI IRQs during suspend/resume" breaks resume from
 suspend
Date: Tue, 21 Aug 2018 08:50:36 +0200
Message-ID: <CAJZ5v0hMZ_bmCy7vQBfzu6RNVkCX0V9qRtqYVNmFOefc1TnGCA@mail.gmail.com>
In-Reply-To: 20180820182906.48f7743f@kitsune.suse.cz
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3091404800624980763==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 20, 2018 at 6:29 PM Michal Such=C3=A1nek <msuchanek(a)suse.de> =
wrote:
>
> Hello,
>
> after commit 18996f2db918 ("ACPICA: Events: Stop unconditionally
> clearing ACPI IRQs during suspend/resume") I am no longer able to
> resume from suspend.
>
> Reported in bugzilla https://bugzilla.kernel.org/show_bug.cgi?id=3D200841
>
> Reverting this on top of 4.18 fixes the issue. acpidump output is
> attaches in the bugzilla.
>
> Is there anything else that can be done to diagnose the issue?

Can you please test the patch at
https://patchwork.kernel.org/patch/10563631/ to start with?

It's already queued up for inclusion.

Thanks,
Rafael

--===============3091404800624980763==--

