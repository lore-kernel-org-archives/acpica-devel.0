Content-Type: multipart/mixed; boundary="===============8671599508201464744=="
MIME-Version: 1.0
From: Lv Zheng <lv.zheng at intel.com>
Subject: [Devel] [PATCH 0/2] Fix issues breaking the MSVC build.
Date: Mon, 14 Jan 2013 08:35:42 +0800
Message-ID: <cover.1358122823.git.lv.zheng@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8671599508201464744==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Enhanced ACPI_DEBUG_PRINT macro will break ACPICA compilation on
platforms using compilers other than GCC.
This patch set fixes this build breakage issue along with a
cleanup that updates the MSVC project / workspace files to make
a build working in MSVC.


Lv Zheng (2):
  Fix build breakage issue with ACPI_DEBUG_PRINT macro.
  Update MSVC project/workspace files.

 generate/msvc/AcpiBin.dsp       |   32 ++--
 generate/msvc/AcpiCA.dsw        |  101 +++++++++++
 generate/msvc/AcpiExec.dsp      |  116 ++++++++++++-
 generate/msvc/AcpiNames.dsp     |   52 +++++-
 generate/msvc/AcpiSrc.dsp       |   20 +--
 generate/msvc/AcpiSrc_Linux.dsp |   13 +-
 generate/msvc/AcpiSubsystem.dsp |   45 ++++-
 generate/msvc/AcpiXtract.dsp    |   32 +++-
 generate/msvc/AslCompiler.dsp   |  360 ++++++++++++++++++++++++++++++-----=
----
 source/compiler/aslcompiler.y   |    1 -
 source/compiler/dtparser.y      |    7 +
 source/compiler/prparser.y      |    7 +
 source/include/acoutput.h       |   17 +-
 source/include/platform/acgcc.h |    5 +
 14 files changed, 670 insertions(+), 138 deletions(-)
 create mode 100644 generate/msvc/AcpiCA.dsw

-- =

1.7.10


--===============8671599508201464744==--

