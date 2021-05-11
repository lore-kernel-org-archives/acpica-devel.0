Content-Type: multipart/mixed; boundary="===============0207458103000207030=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH 1/1] ACPICA: Add SVKL table headers
Date: Tue, 11 May 2021 12:26:10 +0200
Message-ID: <CAJZ5v0jFhX6Jy_Ws14BO3g35yCKnKncp5gBWCADTCdppbHQ55A@mail.gmail.com>
In-Reply-To: MWHPR11MB1599AD69C50EE40EF625C837F0539@MWHPR11MB1599.namprd11.prod.outlook.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0207458103000207030==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, May 11, 2021 at 2:17 AM Kaneda, Erik <erik.kaneda(a)intel.com> wrot=
e:
>
>
>
> > -----Original Message-----
> > From: Rafael J. Wysocki <rafael(a)kernel.org>
> > Sent: Monday, May 10, 2021 9:58 AM
> > To: Kuppuswamy Sathyanarayanan
> > <sathyanarayanan.kuppuswamy(a)linux.intel.com>; Kaneda, Erik
> > <erik.kaneda(a)intel.com>
> > Cc: Rafael J Wysocki <rjw(a)rjwysocki.net>; Len Brown <lenb(a)kernel.or=
g>;
> > Moore, Robert <robert.moore(a)intel.com>; ACPI Devel Maling List <linux-
> > acpi(a)vger.kernel.org>; open list:ACPI COMPONENT ARCHITECTURE
> > (ACPICA) <devel(a)acpica.org>; Linux Kernel Mailing List <linux-
> > kernel(a)vger.kernel.org>; Wysocki, Rafael J <rafael.j.wysocki(a)intel.=
com>
> > Subject: Re: [PATCH 1/1] ACPICA: Add SVKL table headers
> >
> > On Thu, Apr 22, 2021 at 9:29 PM Kuppuswamy Sathyanarayanan
> > <sathyanarayanan.kuppuswamy(a)linux.intel.com> wrote:
> > >
> > > ACPICA commit b5e6bcf69dbb9877481992d5ce86008cfb94f5b8
> > >
> > > SVKL (Storage Volume Key Location Table) is used by BIOS/Firmware
> > > to share storage volume encryption key's with OS. It will be used
> > > by userspace to decrypt and mount encrypted drives.
> > >
> > > So add SVKL table signature and add it to known signatures array
> > > support SVKL.
> > >
> > > You can find details about the SVKL table in TDX specfication
> > > titled "Guest-Host-Communication Interface (GHCI) for Intel
> > > Trust Domain Extensions (Intel=C2=AE TDX)", sec 4.4 and in ACPI
> > > specification r6.4, sec 5.2.6.
> > >
> > >
> > https://software.intel.com/content/dam/develop/external/us/en/documen
> > ts/intel-tdx-guest-hypervisor-communication-interface.pdf
> > >
> > > Cc: Robert Moore <robert.moore(a)intel.com>
> > > Cc: Erik Kaneda <erik.kaneda(a)intel.com>
> > > Cc: Rafael J. Wysocki <rafael.j.wysocki(a)intel.com>
> > >
> > > Link: https://github.com/acpica/acpica/commit/b5e6bcf6
> > > Signed-off-by: Kuppuswamy Sathyanarayanan
> > <sathyanarayanan.kuppuswamy(a)linux.intel.com>
> > > Signed-off-by: Bob Moore <robert.moore(a)intel.com>
> > > Signed-off-by: Erik Kaneda <erik.kaneda(a)intel.com>
> >
> > Erik, what's the plan regarding this patch and the other ACPICA change
> > requisite for this series?
> >
> > Are they going to be part of the next ACPICA release and am I going to
> > receive them the usual way?
>
> Yes, we'll do this the usual way

OK, thanks!
--===============0207458103000207030==--

