Content-Type: multipart/mixed; boundary="===============0374170806697039942=="
MIME-Version: 1.0
From: Vit Kabele <vit at kabele.me>
Subject: [Devel] [PATCH 0/3 RESEND] platform/x86,
 apcica: Sanitize EBDA pointer from memory
Date: Thu, 17 Mar 2022 19:44:19 +0100
Message-ID: <YjOBg4Oys3qV1dbe@czspare1-lap.sysgo.cz>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0374170806697039942==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

[Resend because I messed up the mailing list addresses]

When testing custom virtualization platform, we noticed that in cases
where the memory is initialized with random pattern, the Linux guest
tends to crash on EPT violation.

It turns out that (at least two) codepaths during boot do not check the
validity of EBDA pointer retrieved from BDA memory at address 0x40e.
In case that the returned address is over 640K, the kernel happily
touches the VGA memory (which was not present in our setup, hence the
EPT violation).

This may be problematic in other virtualized environment too, but it can
probably also happen on bare metal when booted with legacy free (e.g.
UEFI without CSM) firmware, because the BDA may not be initialized and
the VGA range might not be properly decoded.

The third patch of the series adds workaround for the situation where
EBDA is smaller than 1KiB and the ACPI code scanning for RSDP table
bumps to the VGA memory.

The two acpcia patches can eventually be squashed together, it's up to you.

I tested these patches on my lenovo laptop (and in QEMU if that counts).

Vit Kabele (3):
  platform/x86: Check validity of EBDA pointer in mpparse.c
  acpica: Check that the EBDA pointer is in valid range
  acpica: Do not touch VGA memory when EBDA < 1KiB

 arch/x86/include/asm/bios_ebda.h |  3 +++
 arch/x86/kernel/ebda.c           |  3 ---
 arch/x86/kernel/mpparse.c        | 12 +++++++++++-
 drivers/acpi/acpica/tbxfroot.c   | 25 ++++++++++++++++++-------
 4 files changed, 32 insertions(+), 11 deletions(-)

-- =

2.30.2

--===============0374170806697039942==--

