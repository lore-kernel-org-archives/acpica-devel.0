Content-Type: multipart/mixed; boundary="===============0871295868823741925=="
MIME-Version: 1.0
From: Sudeep Holla <sudeep.holla at arm.com>
Subject: [Devel] Re: [PATCH v1 2/5] ACPI: bus: Set CPPC _OSC bits for all and
 when CPPC_LIB is supported
Date: Wed, 11 May 2022 15:22:20 +0100
Message-ID: <20220511142220.sjfhikuf6fydnrkb@bogus>
In-Reply-To: 20220511134559.1466925-2-pierre.gondois@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0871295868823741925==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, May 11, 2022 at 03:45:56PM +0200, Pierre Gondois wrote:
> The _OSC method allows the OS and firmware to communicate about
> supported features/capabitlities. It also allows the OS to take
> control of some features.
> =

> In ACPI 6.4, s6.2.11.2 Platform-Wide OSPM Capabilities, the CPPC
> (resp. v2) bit should be set by the OS if it 'supports controlling
> processor performance via the interfaces described in the _CPC
> object'.
> =

> The OS supports CPPC and parses the _CPC object only if
> CONFIG_ACPI_CPPC_LIB is set. Replace the x86 specific
> boot_cpu_has(X86_FEATURE_HWP) dynamic check with an arch
> generic CONFIG_ACPI_CPPC_LIB build-time check.
> =

> Note:
> CONFIG_X86_INTEL_PSTATE selects CONFIG_ACPI_CPPC_LIB.

While this is work as per the spec, by not sure what kind of ACPI firmware =
are
in the wild. So be prepared to relax/constrain to original feature check
for x86, unfortunate but may be needed.

Anyways,

Reviewed-by: Sudeep Holla <sudeep.holla(a)arm.com>

-- =

Regards,
Sudeep
--===============0871295868823741925==--

