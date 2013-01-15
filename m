Content-Type: multipart/mixed; boundary="===============0950512175337357800=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH 2/2] Update MSVC project/workspace files.
Date: Tue, 15 Jan 2013 19:46:26 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E357E4D56C@ORSMSX101.amr.corp.intel.com>
In-Reply-To: 454a9183e51786f989f92c7736e86528e255d7f8.1358122823.git.lv.zheng@intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0950512175337357800==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Lv,

The files under generate/msvc were used for MS VC 6.0, and are now "fully" =
deprecated (and probably should now be deleted, since we don't want to supp=
ort them.)

Use generate/msvc9

Bob


> -----Original Message-----
> From: Zheng, Lv
> Sent: Sunday, January 13, 2013 4:36 PM
> To: Moore, Robert
> Cc: Rafael J Wysocki; Brown, Len; Huang, Ying; devel(a)acpica.org; Zheng,=
 Lv
> Subject: [PATCH 2/2] Update MSVC project/workspace files.
> =

> This patch updates MSVC build files to make windows build working.
> Following fixes have been done to the MSVC files:
> 1. Add missing .c files into .dsp.
> 2. Convert abstract paths in .dsp into relative paths.
> 3. Add AcpiCA.dsw to collect non-Linux projects.
> 4. Update .dsp, compiling .y/.l using standard GNU flex/bison.
> 5. Fix link issues in .y.
> =

> Signed-off-by: Lv Zheng <lv.zheng(a)intel.com>
> ---
>  generate/msvc/AcpiBin.dsp       |   32 ++--
>  generate/msvc/AcpiCA.dsw        |  101 +++++++++++
>  generate/msvc/AcpiExec.dsp      |  116 ++++++++++++-
>  generate/msvc/AcpiNames.dsp     |   52 +++++-
>  generate/msvc/AcpiSrc.dsp       |   20 +--
>  generate/msvc/AcpiSrc_Linux.dsp |   13 +-
>  generate/msvc/AcpiSubsystem.dsp |   45 ++++-
>  generate/msvc/AcpiXtract.dsp    |   32 +++-
>  generate/msvc/AslCompiler.dsp   |  360 ++++++++++++++++++++++++++++++----
> -----
>  source/compiler/aslcompiler.y   |    1 -
>  source/compiler/dtparser.y      |    7 +
>  source/compiler/prparser.y      |    7 +
>  12 files changed, 652 insertions(+), 134 deletions(-)
>  create mode 100644 generate/msvc/AcpiCA.dsw
> =

> diff --git a/generate/msvc/AcpiBin.dsp b/generate/msvc/AcpiBin.dsp
> index cbbb5c5..4cb4770 100755
> --- a/generate/msvc/AcpiBin.dsp
> +++ b/generate/msvc/AcpiBin.dsp
> @@ -37,12 +37,12 @@ RSC=3Drc.exe
>  # PROP BASE Target_Dir ""
>  # PROP Use_MFC 0
>  # PROP Use_Debug_Libraries 0
> -# PROP Output_Dir "/acpica/generate/msvc/AcpiBin"
> -# PROP Intermediate_Dir "/acpica/generate/msvc/AcpiBin"
> +# PROP Output_Dir "AcpiBin"
> +# PROP Intermediate_Dir "AcpiBin"
>  # PROP Ignore_Export_Lib 0
>  # PROP Target_Dir ""
>  # ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE"
> /D "_MBCS" /YX /FD /c
> -# ADD CPP /nologo /Gr /W4 /O2 /I "..\..\source\include" /D "NDEBUG" /D
> "ACPI_BIN_APP" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /FR /FD /c
> +# ADD CPP /nologo /Gr /W4 /O2 /I "..\..\source\include" /D "NDEBUG" /D
> "WIN32" /D "_CONSOLE" /D "_MBCS" /D "ACPI_BIN_APP" /D "__STDC__" /FR /FD
> /c
>  # SUBTRACT CPP /YX
>  # ADD BASE RSC /l 0x409 /d "NDEBUG"
>  # ADD RSC /l 0x409 /d "NDEBUG"
> @@ -51,12 +51,12 @@ BSC32=3Dbscmake.exe
>  # ADD BSC32 /nologo
>  LINK32=3Dlink.exe
>  # ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib
> comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib
> odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386
> -# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib
> shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib
> /nologo /subsystem:console /machine:I386 /nodefaultlib:"advapi32.lib"
> +# ADD LINK32 kernel32.lib /nologo /subsystem:console /machine:I386
> /nodefaultlib:"advapi32.lib"
>  # SUBTRACT LINK32 /pdb:none
>  # Begin Special Build Tool
>  SOURCE=3D"$(InputPath)"
>  PostBuild_Desc=3DCopy AcpiBin.exe to libraries
> -PostBuild_Cmds=3Dcopy acpibin\acpibin.exe ..\..\libraries	dir
> ..\..\libraries\acpibin.exe
> +PostBuild_Cmds=3Dcopy acpibin\acpibin.exe ..\..\libraries
>  # End Special Build Tool
> =

>  !ELSEIF  "$(CFG)" =3D=3D "AcpiBin - Win32 Debug"
> @@ -68,12 +68,12 @@ PostBuild_Cmds=3Dcopy acpibin\acpibin.exe
> ..\..\libraries	dir ..\..\libraries\acpi
>  # PROP BASE Target_Dir ""
>  # PROP Use_MFC 0
>  # PROP Use_Debug_Libraries 1
> -# PROP Output_Dir "/acpica/generate/msvc/AcpiBinDebug"
> -# PROP Intermediate_Dir "/acpica/generate/msvc/AcpiBinDebug"
> +# PROP Output_Dir "AcpiBinDebug"
> +# PROP Intermediate_Dir "AcpiBinDebug"
>  # PROP Ignore_Export_Lib 0
>  # PROP Target_Dir ""
>  # ADD BASE CPP /nologo /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D
> "_CONSOLE" /D "_MBCS" /YX /FD /GZ /c
> -# ADD CPP /nologo /Gr /W4 /Zi /Od /Gf /I "..\..\source\include" /D
> "_DEBUG" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "ACPI_BIN_APP" /FR /FD /GZ
> /c
> +# ADD CPP /nologo /Gr /W4 /Zi /Od /Gf /I "..\..\source\include" /D
> "_DEBUG" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "ACPI_BIN_APP" /D
> "__STDC__" /FR /FD /GZ /c
>  # ADD BASE RSC /l 0x409 /d "_DEBUG"
>  # ADD RSC /l 0x409 /d "_DEBUG"
>  BSC32=3Dbscmake.exe
> @@ -81,12 +81,12 @@ BSC32=3Dbscmake.exe
>  # ADD BSC32 /nologo /o"/acpica/generate/msvc/AcpiBinDebug/AcpiBin.bsc"
>  LINK32=3Dlink.exe
>  # ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib
> comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib
> odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386
> /pdbtype:sept
> -# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib
> shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib
> /nologo /subsystem:console /incremental:no /map /debug /machine:I386
> /pdbtype:sept /out:"/acpica/generate/msvc/AcpiBinDebug/AcpiBin.exe"
> +# ADD LINK32 kernel32.lib /nologo /subsystem:console /incremental:no /map
> /debug /machine:I386 /pdbtype:sept
>  # SUBTRACT LINK32 /pdb:none
>  # Begin Special Build Tool
>  SOURCE=3D"$(InputPath)"
>  PostBuild_Desc=3DCopy AcpiBinDebug.exe to libraries
> -PostBuild_Cmds=3Dcopy acpibindebug\acpibin.exe
> ..\..\libraries\AcpiBinDebug.exe	dir ..\..\libraries\acpibindebug.exe
> +PostBuild_Cmds=3Dcopy acpibindebug\acpibin.exe
> ..\..\libraries\AcpiBinDebug.exe
>  # End Special Build Tool
> =

>  !ENDIF
> @@ -139,6 +139,14 @@ SOURCE=3D..\..\source\components\utilities\utdebug.c
>  # End Source File
>  # Begin Source File
> =

> +SOURCE=3D..\..\source\components\utilities\utdecode.c
> +# End Source File
> +# Begin Source File
> +
> +SOURCE=3D..\..\source\components\utilities\utexcep.c
> +# End Source File
> +# Begin Source File
> +
>  SOURCE=3D..\..\source\components\utilities\utglobal.c
>  # End Source File
>  # Begin Source File
> @@ -163,6 +171,10 @@ SOURCE=3D..\..\source\components\utilities\utstate.c
>  # End Source File
>  # Begin Source File
> =

> +SOURCE=3D..\..\source\components\utilities\utstring.c
> +# End Source File
> +# Begin Source File
> +
>  SOURCE=3D..\..\source\components\utilities\utxferror.c
>  # End Source File
>  # End Group
> diff --git a/generate/msvc/AcpiCA.dsw b/generate/msvc/AcpiCA.dsw
> new file mode 100644
> index 0000000..fc6d2d3
> --- /dev/null
> +++ b/generate/msvc/AcpiCA.dsw
> @@ -0,0 +1,101 @@
> +Microsoft Developer Studio Workspace File, Format Version 6.00
> +# WARNING: DO NOT EDIT OR DELETE THIS WORKSPACE FILE!
> +
> +#########################################################################
> ######
> +
> +Project: "AcpiBin"=3D.\AcpiBin.dsp - Package Owner=3D<4>
> +
> +Package=3D<5>
> +{{{
> +}}}
> +
> +Package=3D<4>
> +{{{
> +}}}
> +
> +#########################################################################
> ######
> +
> +Project: "AcpiExec"=3D.\AcpiExec.dsp - Package Owner=3D<4>
> +
> +Package=3D<5>
> +{{{
> +}}}
> +
> +Package=3D<4>
> +{{{
> +}}}
> +
> +#########################################################################
> ######
> +
> +Project: "AcpiNames"=3D.\AcpiNames.dsp - Package Owner=3D<4>
> +
> +Package=3D<5>
> +{{{
> +}}}
> +
> +Package=3D<4>
> +{{{
> +}}}
> +
> +#########################################################################
> ######
> +
> +Project: "AcpiSrc"=3D.\AcpiSrc.dsp - Package Owner=3D<4>
> +
> +Package=3D<5>
> +{{{
> +}}}
> +
> +Package=3D<4>
> +{{{
> +}}}
> +
> +#########################################################################
> ######
> +
> +Project: "AcpiSubsystem"=3D.\AcpiSubsystem.dsp - Package Owner=3D<4>
> +
> +Package=3D<5>
> +{{{
> +}}}
> +
> +Package=3D<4>
> +{{{
> +}}}
> +
> +#########################################################################
> ######
> +
> +Project: "AcpiXtract"=3D.\AcpiXtract.dsp - Package Owner=3D<4>
> +
> +Package=3D<5>
> +{{{
> +}}}
> +
> +Package=3D<4>
> +{{{
> +}}}
> +
> +#########################################################################
> ######
> +
> +Project: "AslCompiler"=3D.\AslCompiler.dsp - Package Owner=3D<4>
> +
> +Package=3D<5>
> +{{{
> +}}}
> +
> +Package=3D<4>
> +{{{
> +}}}
> +
> +#########################################################################
> ######
> +
> +Global:
> +
> +Package=3D<5>
> +{{{
> +}}}
> +
> +Package=3D<3>
> +{{{
> +}}}
> +
> +#########################################################################
> ######
> +
> diff --git a/generate/msvc/AcpiExec.dsp b/generate/msvc/AcpiExec.dsp
> index c306f8d..faa42dc 100755
> --- a/generate/msvc/AcpiExec.dsp
> +++ b/generate/msvc/AcpiExec.dsp
> @@ -37,8 +37,8 @@ RSC=3Drc.exe
>  # PROP BASE Target_Dir ""
>  # PROP Use_MFC 0
>  # PROP Use_Debug_Libraries 0
> -# PROP Output_Dir "/acpica/generate/msvc/AcpiExec"
> -# PROP Intermediate_Dir "/acpica/generate/msvc/AcpiExec"
> +# PROP Output_Dir "AcpiExec"
> +# PROP Intermediate_Dir "AcpiExec"
>  # PROP Ignore_Export_Lib 0
>  # PROP Target_Dir ""
>  # ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE"
> /D "_MBCS" /YX /FD /c
> @@ -51,14 +51,14 @@ BSC32=3Dbscmake.exe
>  # ADD BSC32 /nologo
>  LINK32=3Dlink.exe
>  # ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib
> comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib
> odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib
> comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib
> odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386
> -# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib
> advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib
> odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib
> advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib
> odbccp32.lib /nologo /subsystem:console /map /machine:I386
> +# ADD LINK32 kernel32.lib advapi32.lib /nologo /subsystem:console /map
> /machine:I386
>  # SUBTRACT LINK32 /pdb:none
>  # Begin Special Build Tool
>  SOURCE=3D"$(InputPath)"
>  PreLink_Desc=3DChecking existence of acpi/libraries directory
>  PreLink_Cmds=3Dif NOT EXIST ..\..\libraries mkdir ..\..\libraries
>  PostBuild_Desc=3DCopy acpiexec.exe to libraries
> -PostBuild_Cmds=3Dcopy acpiexec\acpiexec.exe ..\..\libraries	dir
> ..\..\libraries\acpiexec.exe
> +PostBuild_Cmds=3Dcopy acpiexec\acpiexec.exe ..\..\libraries
>  # End Special Build Tool
> =

>  !ELSEIF  "$(CFG)" =3D=3D "AcpiExec - Win32 Debug"
> @@ -70,8 +70,8 @@ PostBuild_Cmds=3Dcopy acpiexec\acpiexec.exe
> ..\..\libraries	dir ..\..\libraries\ac
>  # PROP BASE Target_Dir ""
>  # PROP Use_MFC 0
>  # PROP Use_Debug_Libraries 1
> -# PROP Output_Dir "/acpica/generate/msvc/AcpiExecDebug"
> -# PROP Intermediate_Dir "/acpica/generate/msvc/AcpiExecDebug"
> +# PROP Output_Dir "AcpiExecDebug"
> +# PROP Intermediate_Dir "AcpiExecDebug"
>  # PROP Ignore_Export_Lib 0
>  # PROP Target_Dir ""
>  # ADD BASE CPP /nologo /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D
> "_CONSOLE" /D "_MBCS" /YX /FD /GZ /c
> @@ -83,14 +83,14 @@ BSC32=3Dbscmake.exe
>  # ADD BSC32 /nologo /o"/acpica/generate/msvc/AcpiExecDebug/AcpiExec.bsc"
>  LINK32=3Dlink.exe
>  # ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib
> comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib
> odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib
> comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib
> odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386
> /pdbtype:sept
> -# ADD LINK32 libcmtd.lib kernel32.lib user32.lib gdi32.lib winspool.lib
> comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib
> odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib
> comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib
> odbc32.lib odbccp32.lib /nologo /subsystem:console /incremental:no /map
> /debug /machine:I386 /nodefaultlib:"libcmt.lib" /pdbtype:sept
> /out:"/acpica/generate/msvc/AcpiExecDebug/AcpiExec.exe"
> +# ADD LINK32 libcmtd.lib kernel32.lib advapi32.lib /nologo
> /subsystem:console /incremental:no /map /debug /machine:I386
> /nodefaultlib:"libcmt.lib" /pdbtype:sept
>  # SUBTRACT LINK32 /pdb:none
>  # Begin Special Build Tool
>  SOURCE=3D"$(InputPath)"
>  PreLink_Desc=3DChecking existence of acpi/libraries directory
>  PreLink_Cmds=3Dif NOT EXIST ..\..\libraries mkdir ..\..\libraries
>  PostBuild_Desc=3DCopy acpiexecdebug.exe to libraries
> -PostBuild_Cmds=3Dcopy acpiexecdebug\acpiexec.exe
> ..\..\libraries\acpiexecdebug.exe	dir ..\..\libraries\acpiexecdebug.exe
> +PostBuild_Cmds=3Dcopy acpiexecdebug\acpiexec.exe
> ..\..\libraries\acpiexecdebug.exe
>  # End Special Build Tool
> =

>  !ENDIF
> @@ -107,6 +107,34 @@ PostBuild_Cmds=3Dcopy acpiexecdebug\acpiexec.exe
> ..\..\libraries\acpiexecdebug.exe
>  # PROP Default_Filter ".c"
>  # Begin Source File
> =

> +SOURCE=3D..\..\source\components\debugger\dbconvert.c
> +# End Source File
> +# Begin Source File
> +
> +SOURCE=3D..\..\source\components\events\evhandler.c
> +# End Source File
> +# Begin Source File
> +
> +SOURCE=3D..\..\source\components\namespace\nsprepkg.c
> +# End Source File
> +# Begin Source File
> +
> +SOURCE=3D..\..\source\components\parser\psobject.c
> +# End Source File
> +# Begin Source File
> +
> +SOURCE=3D..\..\source\components\parser\psopinfo.c
> +# End Source File
> +# Begin Source File
> +
> +SOURCE=3D..\..\source\components\resources\rsdumpinfo.c
> +# End Source File
> +# Begin Source File
> +
> +SOURCE=3D..\..\source\components\utilities\utaddress.c
> +# End Source File
> +# Begin Source File
> +
>  SOURCE=3D..\..\source\components\utilities\utalloc.c
>  # End Source File
>  # Begin Source File
> @@ -123,6 +151,10 @@ SOURCE=3D..\..\source\components\utilities\utdebug.c
>  # End Source File
>  # Begin Source File
> =

> +SOURCE=3D..\..\source\components\utilities\utdecode.c
> +# End Source File
> +# Begin Source File
> +
>  SOURCE=3D..\..\source\components\utilities\utdelete.c
>  # End Source File
>  # Begin Source File
> @@ -131,6 +163,10 @@ SOURCE=3D..\..\source\components\utilities\uteval.c
>  # End Source File
>  # Begin Source File
> =

> +SOURCE=3D..\..\source\components\utilities\utexcep.c
> +# End Source File
> +# Begin Source File
> +
>  SOURCE=3D..\..\source\components\utilities\utglobal.c
>  # End Source File
>  # Begin Source File
> @@ -177,6 +213,10 @@ SOURCE=3D..\..\source\components\utilities\utosi.c
>  # End Source File
>  # Begin Source File
> =

> +SOURCE=3D..\..\source\components\utilities\utownerid.c
> +# End Source File
> +# Begin Source File
> +
>  SOURCE=3D..\..\source\components\utilities\utresrc.c
>  # End Source File
>  # Begin Source File
> @@ -185,6 +225,10 @@ SOURCE=3D..\..\source\components\utilities\utstate.c
>  # End Source File
>  # Begin Source File
> =

> +SOURCE=3D..\..\source\components\utilities\utstring.c
> +# End Source File
> +# Begin Source File
> +
>  SOURCE=3D..\..\source\components\utilities\uttrack.c
>  # End Source File
>  # Begin Source File
> @@ -195,6 +239,14 @@ SOURCE=3D..\..\source\components\utilities\utxface.c
> =

>  SOURCE=3D..\..\source\components\utilities\utxferror.c
>  # End Source File
> +# Begin Source File
> +
> +SOURCE=3D..\..\source\components\utilities\utxfinit.c
> +# End Source File
> +# Begin Source File
> +
> +SOURCE=3D..\..\source\components\utilities\utxfmutex.c
> +# End Source File
>  # End Group
>  # Begin Group "Namespace"
> =

> @@ -285,6 +337,10 @@ SOURCE=3D..\..\source\components\hardware\hwacpi.c
>  # End Source File
>  # Begin Source File
> =

> +SOURCE=3D..\..\source\components\hardware\hwesleep.c
> +# End Source File
> +# Begin Source File
> +
>  SOURCE=3D..\..\source\components\hardware\hwgpe.c
>  # End Source File
>  # Begin Source File
> @@ -307,6 +363,10 @@ SOURCE=3D..\..\source\components\hardware\hwvalid.c
> =

>  SOURCE=3D..\..\source\components\hardware\hwxface.c
>  # End Source File
> +# Begin Source File
> +
> +SOURCE=3D..\..\source\components\hardware\hwxfsleep.c
> +# End Source File
>  # End Group
>  # Begin Group "Events"
> =

> @@ -317,6 +377,10 @@ SOURCE=3D..\..\source\components\events\evevent.c
>  # End Source File
>  # Begin Source File
> =

> +SOURCE=3D..\..\source\components\events\evglock.c
> +# End Source File
> +# Begin Source File
> +
>  SOURCE=3D..\..\source\COMPONENTS\EVENTS\evgpe.c
>  # End Source File
>  # Begin Source File
> @@ -425,6 +489,14 @@ SOURCE=3D..\..\source\COMPONENTS\DEBUGGER\dbinput.c
>  # End Source File
>  # Begin Source File
> =

> +SOURCE=3D..\..\source\components\debugger\dbmethod.c
> +# End Source File
> +# Begin Source File
> +
> +SOURCE=3D..\..\source\components\debugger\dbnames.c
> +# End Source File
> +# Begin Source File
> +
>  SOURCE=3D..\..\source\COMPONENTS\DEBUGGER\dbstats.c
>  # End Source File
>  # Begin Source File
> @@ -461,6 +533,10 @@ SOURCE=3D..\..\source\components\tables\tbxface.c
>  # End Source File
>  # Begin Source File
> =

> +SOURCE=3D..\..\source\components\tables\tbxfload.c
> +# End Source File
> +# Begin Source File
> +
>  SOURCE=3D..\..\source\components\tables\tbxfroot.c
>  # End Source File
>  # End Group
> @@ -526,6 +602,10 @@ SOURCE=3D..\..\source\components\resources\rsmisc.c
>  # End Source File
>  # Begin Source File
> =

> +SOURCE=3D..\..\source\components\resources\rsserial.c
> +# End Source File
> +# Begin Source File
> +
>  SOURCE=3D..\..\source\components\resources\rsutils.c
>  # End Source File
>  # Begin Source File
> @@ -542,6 +622,10 @@
> SOURCE=3D..\..\source\COMPONENTS\Disassembler\dmbuffer.c
>  # End Source File
>  # Begin Source File
> =

> +SOURCE=3D..\..\source\components\disassembler\dmdeferred.c
> +# End Source File
> +# Begin Source File
> +
>  SOURCE=3D..\..\source\COMPONENTS\Disassembler\dmnames.c
>  # End Source File
>  # Begin Source File
> @@ -562,6 +646,10 @@
> SOURCE=3D..\..\source\COMPONENTS\Disassembler\dmresrcl.c
>  # End Source File
>  # Begin Source File
> =

> +SOURCE=3D..\..\source\components\disassembler\dmresrcl2.c
> +# End Source File
> +# Begin Source File
> +
>  SOURCE=3D..\..\source\COMPONENTS\Disassembler\dmresrcs.c
>  # End Source File
>  # Begin Source File
> @@ -718,6 +806,14 @@ SOURCE=3D..\..\source\components\parser\psxface.c
>  # PROP Default_Filter ".c"
>  # Begin Source File
> =

> +SOURCE=3D..\..\source\components\dispatcher\dsargs.c
> +# End Source File
> +# Begin Source File
> +
> +SOURCE=3D..\..\source\components\dispatcher\dscontrol.c
> +# End Source File
> +# Begin Source File
> +
>  SOURCE=3D..\..\source\components\dispatcher\dsfield.c
>  # End Source File
>  # Begin Source File
> @@ -754,6 +850,10 @@ SOURCE=3D..\..\source\components\dispatcher\dswload.c
>  # End Source File
>  # Begin Source File
> =

> +SOURCE=3D..\..\source\components\dispatcher\dswload2.c
> +# End Source File
> +# Begin Source File
> +
>  SOURCE=3D..\..\source\components\dispatcher\dswscope.c
>  # End Source File
>  # Begin Source File
> diff --git a/generate/msvc/AcpiNames.dsp b/generate/msvc/AcpiNames.dsp
> index 3fa41de..1a8d630 100755
> --- a/generate/msvc/AcpiNames.dsp
> +++ b/generate/msvc/AcpiNames.dsp
> @@ -37,8 +37,8 @@ RSC=3Drc.exe
>  # PROP BASE Target_Dir ""
>  # PROP Use_MFC 0
>  # PROP Use_Debug_Libraries 0
> -# PROP Output_Dir "/acpica/generate/msvc/AcpiNames"
> -# PROP Intermediate_Dir "/acpica/generate/msvc/AcpiNames"
> +# PROP Output_Dir "AcpiNames"
> +# PROP Intermediate_Dir "AcpiNames"
>  # PROP Ignore_Export_Lib 0
>  # PROP Target_Dir ""
>  # ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE"
> /D "_MBCS" /YX /FD /c
> @@ -51,7 +51,7 @@ BSC32=3Dbscmake.exe
>  # ADD BSC32 /nologo
>  LINK32=3Dlink.exe
>  # ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib
> comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib
> odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib
> comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib
> odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386
> -# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib
> advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib
> odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib
> advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib
> odbccp32.lib /nologo /subsystem:console /machine:I386
> +# ADD LINK32 kernel32.lib advapi32.lib /nologo /subsystem:console
> /machine:I386
>  # Begin Special Build Tool
>  SOURCE=3D"$(InputPath)"
>  PostBuild_Cmds=3Dcopy AcpiNames\AcpiNames.exe ..\..\libraries
> @@ -66,8 +66,8 @@ PostBuild_Cmds=3Dcopy AcpiNames\AcpiNames.exe
> ..\..\libraries
>  # PROP BASE Target_Dir ""
>  # PROP Use_MFC 0
>  # PROP Use_Debug_Libraries 1
> -# PROP Output_Dir "/acpica/generate/msvc/AcpiNamesDebug"
> -# PROP Intermediate_Dir "/acpica/generate/msvc/AcpiNamesDebug"
> +# PROP Output_Dir "AcpiNamesDebug"
> +# PROP Intermediate_Dir "AcpiNamesDebug"
>  # PROP Target_Dir ""
>  # ADD BASE CPP /nologo /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D
> "_CONSOLE" /D "_MBCS" /YX /FD /GZ /c
>  # ADD CPP /nologo /Gr /Za /W4 /Gm /Gi /GX /ZI /Od /I
> "..\..\source\Include" /D "_DEBUG" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D
> "ACPI_APPLICATION" /D "ACPI_SINGLE_THREADED" /D "ACPI_DEBUGGER" /FR /FD
> /GZ /c
> @@ -79,7 +79,7 @@ BSC32=3Dbscmake.exe
>  # ADD BSC32 /nologo
>  LINK32=3Dlink.exe
>  # ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib
> comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib
> odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib
> comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib
> odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386
> /pdbtype:sept
> -# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib
> advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib
> odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib
> advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib
> odbccp32.lib /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept
> +# ADD LINK32 kernel32.lib advapi32.lib /nologo /subsystem:console /debug
> /machine:I386 /pdbtype:sept
>  # Begin Special Build Tool
>  SOURCE=3D"$(InputPath)"
>  PostBuild_Cmds=3Dcopy AcpiNamesdebug\AcpiNames.exe
> ..\..\libraries\AcpiNamesdebug.exe
> @@ -112,6 +112,10 @@
> SOURCE=3D..\..\source\os_specific\service_layers\oswinxf.c
>  # PROP Default_Filter ""
>  # Begin Source File
> =

> +SOURCE=3D..\..\source\components\utilities\utaddress.c
> +# End Source File
> +# Begin Source File
> +
>  SOURCE=3D..\..\source\components\utilities\utalloc.c
>  # End Source File
>  # Begin Source File
> @@ -120,10 +124,18 @@ SOURCE=3D..\..\source\components\utilities\utcache.c
>  # End Source File
>  # Begin Source File
> =

> +SOURCE=3D..\..\source\components\utilities\utdecode.c
> +# End Source File
> +# Begin Source File
> +
>  SOURCE=3D..\..\source\components\utilities\utdelete.c
>  # End Source File
>  # Begin Source File
> =

> +SOURCE=3D..\..\source\components\utilities\utexcep.c
> +# End Source File
> +# Begin Source File
> +
>  SOURCE=3D..\..\source\components\utilities\utglobal.c
>  # End Source File
>  # Begin Source File
> @@ -172,6 +184,10 @@ SOURCE=3D..\..\source\components\utilities\utxface.c
> =

>  SOURCE=3D..\..\source\components\utilities\utxferror.c
>  # End Source File
> +# Begin Source File
> +
> +SOURCE=3D..\..\source\components\utilities\utxfinit.c
> +# End Source File
>  # End Group
>  # Begin Group "Tables"
> =

> @@ -198,6 +214,10 @@ SOURCE=3D..\..\source\components\tables\tbxface.c
>  # End Source File
>  # Begin Source File
> =

> +SOURCE=3D..\..\source\components\tables\tbxfload.c
> +# End Source File
> +# Begin Source File
> +
>  SOURCE=3D..\..\source\components\tables\tbxfroot.c
>  # End Source File
>  # End Group
> @@ -334,6 +354,10 @@ SOURCE=3D..\..\source\components\dispatcher\dswload.c
>  # End Source File
>  # Begin Source File
> =

> +SOURCE=3D..\..\source\components\dispatcher\dswload2.c
> +# End Source File
> +# Begin Source File
> +
>  SOURCE=3D..\..\source\components\dispatcher\dswscope.c
>  # End Source File
>  # Begin Source File
> @@ -377,6 +401,22 @@ SOURCE=3D..\..\source\tools\AcpiNames\anstubs.c
> =

>  SOURCE=3D..\..\source\tools\AcpiNames\antables.c
>  # End Source File
> +# Begin Source File
> +
> +SOURCE=3D..\..\source\components\parser\psobject.c
> +# End Source File
> +# Begin Source File
> +
> +SOURCE=3D..\..\source\components\parser\psopinfo.c
> +# End Source File
> +# Begin Source File
> +
> +SOURCE=3D..\..\source\components\utilities\utownerid.c
> +# End Source File
> +# Begin Source File
> +
> +SOURCE=3D..\..\source\components\utilities\utstring.c
> +# End Source File
>  # End Group
>  # Begin Group "Header Files"
> =

> diff --git a/generate/msvc/AcpiSrc.dsp b/generate/msvc/AcpiSrc.dsp
> index a1976b5..7ff619f 100755
> --- a/generate/msvc/AcpiSrc.dsp
> +++ b/generate/msvc/AcpiSrc.dsp
> @@ -37,12 +37,12 @@ RSC=3Drc.exe
>  # PROP BASE Target_Dir ""
>  # PROP Use_MFC 0
>  # PROP Use_Debug_Libraries 0
> -# PROP Output_Dir "/acpica/generate/msvc/AcpiSrc"
> -# PROP Intermediate_Dir "/acpica/generate/msvc/AcpiSrc"
> +# PROP Output_Dir "AcpiSrc"
> +# PROP Intermediate_Dir "AcpiSrc"
>  # PROP Ignore_Export_Lib 0
>  # PROP Target_Dir ""
>  # ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE"
> /D "_MBCS" /Yu"stdafx.h" /FD /c
> -# ADD CPP /nologo /Gr /W4 /O2 /I "..\..\source\Include" /D "NDEBUG" /D
> "WIN32" /D "_CONSOLE" /D "ACPI_DEBUG" /D "ACPI_APPLICATION" /D "_IA32" /FR
> /FD /c
> +# ADD CPP /nologo /Gr /W4 /O2 /I "..\..\source\Include" /D "NDEBUG" /D
> "WIN32" /D "_CONSOLE" /D "ACPI_DEBUG" /D "ACPI_APPLICATION" /D "_IA32" /D
> "__STDC__" /FR /FD /c
>  # SUBTRACT CPP /YX /Yc /Yu
>  # ADD BASE RSC /l 0x409 /d "NDEBUG"
>  # ADD RSC /l 0x409 /d "NDEBUG"
> @@ -51,14 +51,14 @@ BSC32=3Dbscmake.exe
>  # ADD BSC32 /nologo
>  LINK32=3Dlink.exe
>  # ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib
> comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib
> odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib
> comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib
> odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386
> -# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib
> advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib
> odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib
> advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib
> odbccp32.lib /nologo /subsystem:console /machine:I386
> +# ADD LINK32 kernel32.lib advapi32.lib /nologo /subsystem:console
> /machine:I386
>  # SUBTRACT LINK32 /pdb:none
>  # Begin Special Build Tool
>  SOURCE=3D"$(InputPath)"
>  PreLink_Desc=3DChecking existence of acpi/libraries directory
>  PreLink_Cmds=3Dif NOT EXIST ..\..\libraries mkdir ..\..\libraries
>  PostBuild_Desc=3DCopy acpisrc.exe to libraries
> -PostBuild_Cmds=3Dcopy acpisrc\acpisrc.exe ..\..\libraries	dir
> ..\..\libraries\acpisrc.exe
> +PostBuild_Cmds=3Dcopy acpisrc\acpisrc.exe ..\..\libraries
>  # End Special Build Tool
> =

>  !ELSEIF  "$(CFG)" =3D=3D "AcpiSrc - Win32 Debug"
> @@ -70,12 +70,12 @@ PostBuild_Cmds=3Dcopy acpisrc\acpisrc.exe
> ..\..\libraries	dir ..\..\libraries\acpi
>  # PROP BASE Target_Dir ""
>  # PROP Use_MFC 0
>  # PROP Use_Debug_Libraries 1
> -# PROP Output_Dir "/acpica/generate/msvc/AcpiSrcDebug"
> -# PROP Intermediate_Dir "/acpica/generate/msvc/AcpiSrcDebug"
> +# PROP Output_Dir "AcpiSrcDebug"
> +# PROP Intermediate_Dir "AcpiSrcDebug"
>  # PROP Ignore_Export_Lib 0
>  # PROP Target_Dir ""
>  # ADD BASE CPP /nologo /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D
> "_CONSOLE" /D "_MBCS" /Yu"stdafx.h" /FD /GZ /c
> -# ADD CPP /nologo /Gr /W4 /Zi /Od /Gf /I "..\..\source\Include" /D
> "_DEBUG" /D "WIN32" /D "_CONSOLE" /D "ACPI_DEBUG" /D "ACPI_APPLICATION" /D
> "_IA32" /FR /FD /GZ /c
> +# ADD CPP /nologo /Gr /W4 /Zi /Od /Gf /I "..\..\source\Include" /D
> "_DEBUG" /D "WIN32" /D "_CONSOLE" /D "ACPI_DEBUG" /D "ACPI_APPLICATION" /D
> "_IA32" /D "__STDC__" /FR /FD /GZ /c
>  # ADD BASE RSC /l 0x409 /d "_DEBUG"
>  # ADD RSC /l 0x409 /d "_DEBUG"
>  BSC32=3Dbscmake.exe
> @@ -83,14 +83,14 @@ BSC32=3Dbscmake.exe
>  # ADD BSC32 /nologo /o"/acpica/generate/msvc/AcpiSrcDebug/AcpiSrc.bsc"
>  LINK32=3Dlink.exe
>  # ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib
> comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib
> odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib
> comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib
> odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386
> /pdbtype:sept
> -# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib
> advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib
> odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib
> advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib
> odbccp32.lib /nologo /subsystem:console /incremental:no /map /debug
> /machine:I386 /pdbtype:sept
> /out:"/acpica/generate/msvc/AcpiSrcDebug/AcpiSrc.exe"
> +# ADD LINK32 kernel32.lib advapi32.lib /nologo /subsystem:console
> /incremental:no /map /debug /machine:I386 /pdbtype:sept
>  # SUBTRACT LINK32 /pdb:none
>  # Begin Special Build Tool
>  SOURCE=3D"$(InputPath)"
>  PreLink_Desc=3DChecking existence of acpi/components/libraries directory
>  PreLink_Cmds=3Dif NOT EXIST ..\..\libraries mkdir ..\..\libraries
>  PostBuild_Desc=3DCopy acpisrcdebug.exe to libraries
> -PostBuild_Cmds=3Dcopy acpisrcdebug\acpisrc.exe
> ..\..\libraries\acpisrcdebug.exe	dir ..\..\libraries\acpisrcdebug.exe
> +PostBuild_Cmds=3Dcopy acpisrcdebug\acpisrc.exe
> ..\..\libraries\acpisrcdebug.exe
>  # End Special Build Tool
> =

>  !ENDIF
> diff --git a/generate/msvc/AcpiSrc_Linux.dsp
> b/generate/msvc/AcpiSrc_Linux.dsp
> index cb0a657..74658f4 100755
> --- a/generate/msvc/AcpiSrc_Linux.dsp
> +++ b/generate/msvc/AcpiSrc_Linux.dsp
> @@ -37,8 +37,8 @@ RSC=3Drc.exe
>  # PROP BASE Target_Dir ""
>  # PROP Use_MFC 0
>  # PROP Use_Debug_Libraries 0
> -# PROP Output_Dir "/acpica/generate/msvc/AcpiSrcLinux"
> -# PROP Intermediate_Dir "/acpica/generate/msvc/AcpiSrcLinux"
> +# PROP Output_Dir "AcpiSrcLinux"
> +# PROP Intermediate_Dir "AcpiSrcLinux"
>  # PROP Ignore_Export_Lib 0
>  # PROP Target_Dir ""
>  # ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE"
> /D "_MBCS" /Yu"stdafx.h" /FD /c
> @@ -51,7 +51,7 @@ BSC32=3Dbscmake.exe
>  # ADD BSC32 /nologo
> /o"/acpica/generate/msvc/AcpiSrcLinux/AcpiSrcLinux.bsc"
>  LINK32=3Dlink.exe
>  # ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib
> comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib
> odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib
> comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib
> odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386
> -# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib
> advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib
> odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib
> advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib
> odbccp32.lib /nologo /subsystem:console /machine:I386
> +# ADD LINK32 kernel32.lib advapi32.lib /nologo /subsystem:console
> /machine:I386
>  # Begin Special Build Tool
>  SOURCE=3D"$(InputPath)"
>  PreLink_Desc=3DChecking existence of acpi/libraries directory
> @@ -69,8 +69,8 @@ PostBuild_Cmds=3Dcopy AcpiSrcLinux\AcpiSrcLinux.exe
> ..\..\libraries	dir ..\..\libr
>  # PROP BASE Target_Dir ""
>  # PROP Use_MFC 0
>  # PROP Use_Debug_Libraries 1
> -# PROP Output_Dir "/acpica/generate/msvc/AcpiSrcLinuxDebug"
> -# PROP Intermediate_Dir "/acpica/generate/msvc/AcpiSrcLinuxDebug"
> +# PROP Output_Dir "AcpiSrcLinuxDebug"
> +# PROP Intermediate_Dir "AcpiSrcLinuxDebug"
>  # PROP Ignore_Export_Lib 0
>  # PROP Target_Dir ""
>  # ADD BASE CPP /nologo /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D
> "_CONSOLE" /D "_MBCS" /Yu"stdafx.h" /FD /GZ /c
> @@ -83,7 +83,8 @@ BSC32=3Dbscmake.exe
>  # ADD BSC32 /nologo
> /o"/acpica/generate/msvc/AcpiSrcLinuxDebug/AcpiSrc_LinuxDebug.bsc"
> /o"/acpica/generate/msvc/AcpiSrcLinuxDebug/AcpiSrcLinux.bsc"
>  LINK32=3Dlink.exe
>  # ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib
> comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib
> odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib
> comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib
> odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386
> /pdbtype:sept
> -# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib
> advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib
> odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib
> advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib
> odbccp32.lib /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept
> /out:"/acpica/generate/msvc/AcpiSrcLinuxDebug/AcpiSrc_LinuxDebug.exe"
> /out:"/acpica/generate/msvc/AcpiSrcLinuxDebug\AcpiSrcLinuxDebug.exe"
> +# ADD LINK32 kernel32.lib advapi32.lib /nologo /subsystem:console /debug
> /machine:I386 /pdbtype:sept
> /out:"/acpica/generate/msvc/AcpiSrcLinuxDebug/AcpiSrc_LinuxDebug.exe"
> +# SUBTRACT LINK32 /pdb:none
>  # Begin Special Build Tool
>  SOURCE=3D"$(InputPath)"
>  PreLink_Desc=3DChecking existence of acpi/components/libraries directory
> diff --git a/generate/msvc/AcpiSubsystem.dsp
> b/generate/msvc/AcpiSubsystem.dsp
> index 4b574d4..e440056 100755
> --- a/generate/msvc/AcpiSubsystem.dsp
> +++ b/generate/msvc/AcpiSubsystem.dsp
> @@ -37,8 +37,8 @@ RSC=3Drc.exe
>  # PROP BASE Target_Dir ""
>  # PROP Use_MFC 0
>  # PROP Use_Debug_Libraries 0
> -# PROP Output_Dir "/acpica/generate/msvc/AcpiSubsystem"
> -# PROP Intermediate_Dir "/acpica/generate/msvc/AcpiSubsystem"
> +# PROP Output_Dir "AcpiSubsystem"
> +# PROP Intermediate_Dir "AcpiSubsystem"
>  # PROP Target_Dir ""
>  # ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_MBCS" /D
> "_LIB" /YX /FD /c
>  # ADD CPP /nologo /Gr /MT /Za /W4 /O1 /I "..\..\source\Include" /D
> "ACPI_LIBRARY" /D "NDEBUG" /D "_GEN" /D "DRIVER" /D "_WINDOWS" /D
> PROCESSOR_ARCHITECTURE=3Dx86 /D "WIN32" /FR /FD /c
> @@ -50,7 +50,6 @@ BSC32=3Dbscmake.exe
>  # ADD BSC32 /nologo
>  LIB32=3Dlink.exe -lib
>  # ADD BASE LIB32 /nologo
> -# ADD LIB32 /out:"/acpica/generate/msvc/AcpiSubsystem\AcpiSubsystem.lib"
>  # Begin Special Build Tool
>  SOURCE=3D"$(InputPath)"
>  PreLink_Desc=3DChecking existence of acpi/libraries directory
> @@ -68,8 +67,8 @@ PostBuild_Cmds=3Dcopy AcpiSubsystem\acpisubsystem.lib
> ..\..\libraries\acpica.lib	d
>  # PROP BASE Target_Dir ""
>  # PROP Use_MFC 0
>  # PROP Use_Debug_Libraries 1
> -# PROP Output_Dir "/acpica/generate/msvc/AcpiSubsystemDebug"
> -# PROP Intermediate_Dir "/acpica/generate/msvc/AcpiSubsystemDebug"
> +# PROP Output_Dir "AcpiSubsystemDebug"
> +# PROP Intermediate_Dir "AcpiSubsystemDebug"
>  # PROP Target_Dir ""
>  # ADD BASE CPP /nologo /W3 /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_MBCS"
> /D "_LIB" /YX /FD /GZ /c
>  # ADD CPP /nologo /Gr /MTd /Za /W4 /Zi /Oa /Og /Os /Oy /Gf /I
> "..\..\source\Include" /D "ACPI_LIBRARY" /D "ACPI_FULL_DEBUG" /D
> "_WINDOWS" /D PROCESSOR_ARCHITECTURE=3Dx86 /D "WIN32" /FR /FD /c
> @@ -80,13 +79,13 @@ BSC32=3Dbscmake.exe
>  # ADD BSC32 /nologo
> /o"/acpica/generate/msvc/AcpiSubsystemDebug/AcpiSubsystem.bsc"
>  LIB32=3Dlink.exe -lib
>  # ADD BASE LIB32 /nologo
> -# ADD LIB32 /nologo
> /out:"/acpica/generate/msvc/AcpiSubsystemDebug\AcpiSubsystem.lib"
> +# ADD LIB32 /nologo
>  # Begin Special Build Tool
>  SOURCE=3D"$(InputPath)"
>  PreLink_Desc=3DChecking existence of acpi/libraries directory
>  PreLink_Cmds=3Dif NOT EXIST ..\..\libraries mkdir ..\..\libraries
>  PostBuild_Desc=3DCopy library to libraries
> -PostBuild_Cmds=3Dcopy AcpiSubsystemDebug\acpisubsystem.lib
> ..\..\libraries\acpica_dbg.lib	dir ..\..\libraries\acpica_dbg.lib
> +PostBuild_Cmds=3Dcopy AcpiSubsystemDebug\acpisubsystem.lib
> ..\..\libraries\acpica_dbg.lib
>  # End Special Build Tool
> =

>  !ENDIF
> @@ -103,6 +102,30 @@ PostBuild_Cmds=3Dcopy
> AcpiSubsystemDebug\acpisubsystem.lib ..\..\libraries\acpica_
>  # PROP Default_Filter ".c"
>  # Begin Source File
> =

> +SOURCE=3D..\..\source\components\debugger\dbconvert.c
> +# End Source File
> +# Begin Source File
> +
> +SOURCE=3D..\..\source\components\events\evhandler.c
> +# End Source File
> +# Begin Source File
> +
> +SOURCE=3D..\..\source\components\namespace\nsprepkg.c
> +# End Source File
> +# Begin Source File
> +
> +SOURCE=3D..\..\source\components\parser\psobject.c
> +# End Source File
> +# Begin Source File
> +
> +SOURCE=3D..\..\source\components\parser\psopinfo.c
> +# End Source File
> +# Begin Source File
> +
> +SOURCE=3D..\..\source\components\resources\rsdumpinfo.c
> +# End Source File
> +# Begin Source File
> +
>  SOURCE=3D..\..\source\components\utilities\utalloc.c
>  # End Source File
>  # Begin Source File
> @@ -168,6 +191,10 @@ SOURCE=3D..\..\source\components\utilities\utosi.c
>  # End Source File
>  # Begin Source File
> =

> +SOURCE=3D..\..\source\components\utilities\utownerid.c
> +# End Source File
> +# Begin Source File
> +
>  SOURCE=3D..\..\source\components\utilities\utresrc.c
>  # End Source File
>  # Begin Source File
> @@ -176,6 +203,10 @@ SOURCE=3D..\..\source\components\utilities\utstate.c
>  # End Source File
>  # Begin Source File
> =

> +SOURCE=3D..\..\source\components\utilities\utstring.c
> +# End Source File
> +# Begin Source File
> +
>  SOURCE=3D..\..\source\components\utilities\utxface.c
>  # End Source File
>  # Begin Source File
> diff --git a/generate/msvc/AcpiXtract.dsp b/generate/msvc/AcpiXtract.dsp
> index 305b881..cebefd7 100755
> --- a/generate/msvc/AcpiXtract.dsp
> +++ b/generate/msvc/AcpiXtract.dsp
> @@ -37,12 +37,12 @@ RSC=3Drc.exe
>  # PROP BASE Target_Dir ""
>  # PROP Use_MFC 0
>  # PROP Use_Debug_Libraries 0
> -# PROP Output_Dir "/acpica/generate/msvc/AcpiXtract"
> -# PROP Intermediate_Dir "/acpica/generate/msvc/AcpiXtract"
> +# PROP Output_Dir "AcpiXtract"
> +# PROP Intermediate_Dir "AcpiXtract"
>  # PROP Ignore_Export_Lib 0
>  # PROP Target_Dir ""
>  # ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE"
> /D "_MBCS" /YX /FD /c
> -# ADD CPP /nologo /Za /W4 /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D
> "_MBCS" /FR /FD /c
> +# ADD CPP /nologo /Za /W4 /O2 /I "../../source/include" /D "WIN32" /D
> "NDEBUG" /D "_CONSOLE" /D "_MBCS" /FR /FD /c
>  # SUBTRACT CPP /YX
>  # ADD BASE RSC /l 0x409 /d "NDEBUG"
>  # ADD RSC /l 0x409 /d "NDEBUG"
> @@ -51,7 +51,7 @@ BSC32=3Dbscmake.exe
>  # ADD BSC32 /nologo
>  LINK32=3Dlink.exe
>  # ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib
> comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib
> odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib
> comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib
> odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386
> -# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib
> advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib
> odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib
> advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib
> odbccp32.lib /nologo /subsystem:console /map /machine:I386
> +# ADD LINK32 kernel32.lib advapi32.lib /nologo /subsystem:console /map
> /machine:I386
>  # SUBTRACT LINK32 /pdb:none
>  # Begin Special Build Tool
>  SOURCE=3D"$(InputPath)"
> @@ -68,12 +68,12 @@ PostBuild_Cmds=3Dcopy AcpiXtract\AcpiXtract.exe
> ..\..\libraries
>  # PROP BASE Target_Dir ""
>  # PROP Use_MFC 0
>  # PROP Use_Debug_Libraries 1
> -# PROP Output_Dir "/acpica/generate/msvc/AcpiXtractDebug"
> -# PROP Intermediate_Dir "/acpica/generate/msvc/AcpiXtractDebug"
> +# PROP Output_Dir "AcpiXtractDebug"
> +# PROP Intermediate_Dir "AcpiXtractDebug"
>  # PROP Ignore_Export_Lib 0
>  # PROP Target_Dir ""
>  # ADD BASE CPP /nologo /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D
> "_CONSOLE" /D "_MBCS" /YX /FD /GZ /c
> -# ADD CPP /nologo /Za /W4 /Zi /Od /Gf /D "WIN32" /D "_DEBUG" /D
> "_CONSOLE" /D "_MBCS" /FR /FD /GZ /c
> +# ADD CPP /nologo /Za /W4 /Zi /Od /Gf /I "../../source/include" /D
> "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /FR /FD /GZ /c
>  # ADD BASE RSC /l 0x409 /d "_DEBUG"
>  # ADD RSC /l 0x409 /d "_DEBUG"
>  BSC32=3Dbscmake.exe
> @@ -81,7 +81,7 @@ BSC32=3Dbscmake.exe
>  # ADD BSC32 /nologo
> /o"/acpica/generate/msvc/AcpiXtractDebug/AcpiXtract.bsc"
>  LINK32=3Dlink.exe
>  # ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib
> comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib
> odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib
> comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib
> odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386
> /pdbtype:sept
> -# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib
> advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib
> odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib
> advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib
> odbccp32.lib /nologo /subsystem:console /incremental:no /map /debug
> /machine:I386 /pdbtype:sept
> /out:"/acpica/generate/msvc/AcpiXtractDebug/AcpiXtract.exe"
> +# ADD LINK32 kernel32.lib advapi32.lib /nologo /subsystem:console
> /incremental:no /map /debug /machine:I386 /pdbtype:sept
>  # SUBTRACT LINK32 /pdb:none
>  # Begin Special Build Tool
>  SOURCE=3D"$(InputPath)"
> @@ -98,6 +98,9 @@ PostBuild_Cmds=3Dcopy AcpiXtractDebug\AcpiXtract.exe
> ..\..\libraries\AcpiXtractDeb
>  # Begin Group "Source Files"
> =

>  # PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
> +# Begin Group "AcpiXtract"
> +
> +# PROP Default_Filter ""
>  # Begin Source File
> =

>  SOURCE=3D..\..\source\tools\AcpiXtract\acpixtract.c
> @@ -113,6 +116,19 @@ SOURCE=3D..\..\source\tools\AcpiXtract\acpixtract.c
>  !ENDIF
> =

>  # End Source File
> +# Begin Source File
> +
> +SOURCE=3D..\..\source\tools\acpixtract\axmain.c
> +# End Source File
> +# End Group
> +# Begin Group "Common"
> +
> +# PROP Default_Filter ""
> +# Begin Source File
> +
> +SOURCE=3D..\..\source\common\getopt.c
> +# End Source File
> +# End Group
>  # End Group
>  # Begin Group "Header Files"
> =

> diff --git a/generate/msvc/AslCompiler.dsp b/generate/msvc/AslCompiler.dsp
> index c4d074c..0756517 100755
> --- a/generate/msvc/AslCompiler.dsp
> +++ b/generate/msvc/AslCompiler.dsp
> @@ -38,12 +38,12 @@ RSC=3Drc.exe
>  # PROP BASE Target_Dir ""
>  # PROP Use_MFC 0
>  # PROP Use_Debug_Libraries 0
> -# PROP Output_Dir "/acpica/generate/msvc/AslCompiler"
> -# PROP Intermediate_Dir "/acpica/generate/msvc/AslCompiler"
> +# PROP Output_Dir "AslCompiler"
> +# PROP Intermediate_Dir "AslCompiler"
>  # PROP Ignore_Export_Lib 0
>  # PROP Target_Dir ""
>  # ADD BASE CPP /nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D
> "_WINDOWS" /D "_AFXDLL" /YX /FD /c
> -# ADD CPP /nologo /Za /W4 /O2 /I "$(OutDir)..\\" /I
> "..\..\source\Include" /I "$(OutDir)" /I "..\..\source\compiler" /D
> "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "YY_NEVER_INTERACTIVE" /D
> "ACPI_ASL_COMPILER" /FR /FD /c
> +# ADD CPP /nologo /MT /Za /W4 /O2 /I "..\..\source\Include" /I
> "..\..\source\compiler" /I "." /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D
> "_MBCS" /D "YY_NEVER_INTERACTIVE" /D "ACPI_ASL_COMPILER" /FR /FD /c
>  # SUBTRACT CPP /X /YX
>  # ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
>  # ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
> @@ -54,12 +54,12 @@ BSC32=3Dbscmake.exe
>  # ADD BSC32 /nologo /o"/acpica/generate/msvc/AslCompiler/AslCompiler.bsc"
>  LINK32=3Dlink.exe
>  # ADD BASE LINK32 /nologo /subsystem:windows /machine:I386
> -# ADD LINK32 ..\..\tools_3rd_party\BisonFlex\libflex.lib kernel32.lib
> user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib
> ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo
> /machine:I386 /pdb:"/acpica/generate/msvc/AslCompiler/AslCompiler.pdb"
> /out:"/acpica/generate/msvc/AslCompiler/AslCompiler.exe"
> /pdb:"/acpica/generate/msvc/AslCompiler/AslCompiler.pdb"
> +# ADD LINK32 kernel32.lib advapi32.lib /nologo /machine:I386
> /pdb:"/acpica/generate/msvc/AslCompiler/AslCompiler.pdb"
> /out:"/acpica/generate/msvc/AslCompiler/AslCompiler.exe"
> /pdb:"/acpica/generate/msvc/AslCompiler/AslCompiler.pdb"
>  # Begin Special Build Tool
>  SOURCE=3D"$(InputPath)"
>  PreLink_Cmds=3Dif NOT EXIST ..\..\libraries mkdir ..\..\libraries
>  PostBuild_Desc=3DCopy iasl.exe to libraries directory
> -PostBuild_Cmds=3Dcopy AslCompiler\aslcompiler.exe
> \acpica\Libraries\iasl.exe	dir \acpica\libraries\iasl.exe
> +PostBuild_Cmds=3Dcopy AslCompiler\aslcompiler.exe ..\..\libraries\iasl.e=
xe
>  # End Special Build Tool
> =

>  !ELSEIF  "$(CFG)" =3D=3D "AslCompiler - Win32 Debug"
> @@ -71,12 +71,12 @@ PostBuild_Cmds=3Dcopy AslCompiler\aslcompiler.exe
> \acpica\Libraries\iasl.exe	dir \
>  # PROP BASE Target_Dir ""
>  # PROP Use_MFC 0
>  # PROP Use_Debug_Libraries 1
> -# PROP Output_Dir "/acpica/generate/msvc/AslCompilerDebug"
> -# PROP Intermediate_Dir "/acpica/generate/msvc/AslCompilerDebug"
> +# PROP Output_Dir "AslCompilerDebug"
> +# PROP Intermediate_Dir "AslCompilerDebug"
>  # PROP Ignore_Export_Lib 0
>  # PROP Target_Dir ""
>  # ADD BASE CPP /nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D
> "_WINDOWS" /D "_AFXDLL" /YX /FD /GZ /c
> -# ADD CPP /nologo /Za /W4 /Gi /Zi /Ot /Oa /Oy /Gf /I "$(OutDir)..\\" /I
> "..\..\source\Include" /I "$(OutDir)" /I "..\..\source\compiler" /D
> "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "YY_NEVER_INTERACTIVE" /D
> "ACPI_ASL_COMPILER" /FR /FD /GZ /c
> +# ADD CPP /nologo /MTd /Za /W4 /Gi /Zi /Ot /Oa /Oy /Gf /I
> "..\..\source\Include" /I "..\..\source\compiler" /I "." /D "_DEBUG" /D
> "WIN32" /D "_WINDOWS" /D "_MBCS" /D "YY_NEVER_INTERACTIVE" /D
> "ACPI_ASL_COMPILER" /FR /FD /GZ /c
>  # ADD BASE MTL /nologo /D "_DEBUG" /mktyplib203 /win32
>  # ADD MTL /nologo /D "_DEBUG" /mktyplib203 /win32
>  # ADD BASE RSC /l 0x409 /d "_DEBUG" /d "_AFXDLL"
> @@ -86,12 +86,12 @@ BSC32=3Dbscmake.exe
>  # ADD BSC32 /nologo
> /o"/acpica/generate/msvc/AslCompilerDebug/AslCompiler.bsc"
>  LINK32=3Dlink.exe
>  # ADD BASE LINK32 /nologo /subsystem:windows /debug /machine:I386
> /pdbtype:sept
> -# ADD LINK32 ..\..\tools_3rd_party\BisonFlex\libflex.lib kernel32.lib
> user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib
> ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo
> /incremental:no /debug /machine:I386 /nodefaultlib:"libcmt.lib"
> /pdbtype:sept
> /pdb:"/acpica/generate/msvc/AslCompilerDebug/AslCompiler.pdb"
> /out:"/acpica/generate/msvc/AslCompilerDebug/AslCompiler.exe"
> /pdb:"/acpica/generate/msvc/AslCompilerDebug/AslCompiler.pdb"
> /map:"/acpica/generate/msvc/AslCompilerDebug/AslCompiler.map"
> +# ADD LINK32 kernel32.lib advapi32.lib /nologo /pdb:none /debug
> /machine:I386 /nodefaultlib:"libcmt.lib"
> /pdb:"/acpica/generate/msvc/AslCompilerDebug/AslCompiler.pdb"
>  # Begin Special Build Tool
>  SOURCE=3D"$(InputPath)"
>  PreLink_Cmds=3Dif NOT EXIST ..\..\libraries mkdir ..\..\libraries
>  PostBuild_Desc=3DCopy iasldebug.exe to libraries directory
> -PostBuild_Cmds=3Dcopy AslCompilerDebug\aslcompiler.exe
> \acpica\Libraries\iasldebug.exe	dir \acpica\libraries\iasldebug.exe
> +PostBuild_Cmds=3Dcopy AslCompilerDebug\aslcompiler.exe
> ..\..\\libraries\iasldebug.exe
>  # End Special Build Tool
> =

>  !ENDIF
> @@ -108,6 +108,10 @@ PostBuild_Cmds=3Dcopy AslCompilerDebug\aslcompiler.e=
xe
> \acpica\Libraries\iasldebug
>  # PROP Default_Filter ".c"
>  # Begin Source File
> =

> +SOURCE=3D..\..\source\components\utilities\utaddress.c
> +# End Source File
> +# Begin Source File
> +
>  SOURCE=3D..\..\source\components\utilities\utalloc.c
>  # End Source File
>  # Begin Source File
> @@ -124,10 +128,18 @@ SOURCE=3D..\..\source\components\utilities\utdebug.c
>  # End Source File
>  # Begin Source File
> =

> +SOURCE=3D..\..\source\components\utilities\utdecode.c
> +# End Source File
> +# Begin Source File
> +
>  SOURCE=3D..\..\source\components\utilities\utdelete.c
>  # End Source File
>  # Begin Source File
> =

> +SOURCE=3D..\..\source\components\utilities\utexcep.c
> +# End Source File
> +# Begin Source File
> +
>  SOURCE=3D..\..\source\components\utilities\utglobal.c
>  # End Source File
>  # Begin Source File
> @@ -156,6 +168,10 @@ SOURCE=3D..\..\source\components\utilities\utobject.c
>  # End Source File
>  # Begin Source File
> =

> +SOURCE=3D..\..\source\components\utilities\utownerid.c
> +# End Source File
> +# Begin Source File
> +
>  SOURCE=3D..\..\source\components\utilities\utresrc.c
>  # End Source File
>  # Begin Source File
> @@ -164,6 +180,10 @@ SOURCE=3D..\..\source\components\utilities\utstate.c
>  # End Source File
>  # Begin Source File
> =

> +SOURCE=3D..\..\source\components\utilities\utstring.c
> +# End Source File
> +# Begin Source File
> +
>  SOURCE=3D..\..\source\components\utilities\utxface.c
>  # End Source File
>  # Begin Source File
> @@ -224,6 +244,10 @@ SOURCE=3D..\..\source\compiler\aslanalyze.c
>  # End Source File
>  # Begin Source File
> =

> +SOURCE=3D..\..\source\compiler\aslbtypes.c
> +# End Source File
> +# Begin Source File
> +
>  SOURCE=3D..\..\source\compiler\aslcodegen.c
>  # End Source File
>  # Begin Source File
> @@ -236,6 +260,10 @@ SOURCE=3D..\..\source\compiler\aslerror.c
>  # End Source File
>  # Begin Source File
> =

> +SOURCE=3D..\..\source\compiler\aslfileio.c
> +# End Source File
> +# Begin Source File
> +
>  SOURCE=3D..\..\source\compiler\aslfiles.c
>  # End Source File
>  # Begin Source File
> @@ -244,6 +272,10 @@ SOURCE=3D..\..\source\compiler\aslfold.c
>  # End Source File
>  # Begin Source File
> =

> +SOURCE=3D..\..\source\compiler\aslhex.c
> +# End Source File
> +# Begin Source File
> +
>  SOURCE=3D..\..\source\compiler\asllength.c
>  # End Source File
>  # Begin Source File
> @@ -268,6 +300,14 @@ SOURCE=3D..\..\source\compiler\aslmap.c
>  # End Source File
>  # Begin Source File
> =

> +SOURCE=3D..\..\source\compiler\aslmethod.c
> +# End Source File
> +# Begin Source File
> +
> +SOURCE=3D..\..\source\compiler\aslnamesp.c
> +# End Source File
> +# Begin Source File
> +
>  SOURCE=3D..\..\source\compiler\aslopcodes.c
>  # End Source File
>  # Begin Source File
> @@ -312,6 +352,10 @@ SOURCE=3D..\..\source\compiler\aslrestype2q.c
>  # End Source File
>  # Begin Source File
> =

> +SOURCE=3D..\..\source\compiler\aslrestype2s.c
> +# End Source File
> +# Begin Source File
> +
>  SOURCE=3D..\..\source\compiler\aslrestype2w.c
>  # End Source File
>  # Begin Source File
> @@ -334,6 +378,38 @@ SOURCE=3D..\..\source\compiler\asltree.c
> =

>  SOURCE=3D..\..\source\compiler\aslutils.c
>  # End Source File
> +# Begin Source File
> +
> +SOURCE=3D..\..\source\compiler\asluuid.c
> +# End Source File
> +# Begin Source File
> +
> +SOURCE=3D..\..\source\compiler\aslwalks.c
> +# End Source File
> +# Begin Source File
> +
> +SOURCE=3D..\..\source\compiler\aslxref.c
> +# End Source File
> +# Begin Source File
> +
> +SOURCE=3D..\..\source\compiler\dtexpress.c
> +# End Source File
> +# Begin Source File
> +
> +SOURCE=3D..\..\source\compiler\prexpress.c
> +# End Source File
> +# Begin Source File
> +
> +SOURCE=3D..\..\source\compiler\prmacros.c
> +# End Source File
> +# Begin Source File
> +
> +SOURCE=3D..\..\source\compiler\prscan.c
> +# End Source File
> +# Begin Source File
> +
> +SOURCE=3D..\..\source\compiler\prutils.c
> +# End Source File
>  # End Group
>  # Begin Group "Common"
> =

> @@ -352,6 +428,10 @@ SOURCE=3D..\..\source\common\adwalk.c
>  # End Source File
>  # Begin Source File
> =

> +SOURCE=3D..\..\source\common\ahpredef.c
> +# End Source File
> +# Begin Source File
> +
>  SOURCE=3D..\..\source\common\dmextern.c
>  # End Source File
>  # Begin Source File
> @@ -394,67 +474,27 @@
> SOURCE=3D..\..\source\os_specific\service_layers\oswinxf.c
>  # PROP Default_Filter "*.c, *.h"
>  # Begin Source File
> =

> -SOURCE=3D.\AslCompiler\AslCompiler.l.c
> -
> -!IF  "$(CFG)" =3D=3D "AslCompiler - Win32 Release"
> -
> -# ADD CPP /W3
> -
> -!ELSEIF  "$(CFG)" =3D=3D "AslCompiler - Win32 Debug"
> -
> -# PROP Exclude_From_Build 1
> -# ADD CPP /W3
> -
> -!ENDIF
> -
> +SOURCE=3D.\aslcompiler.l.c
>  # End Source File
>  # Begin Source File
> =

> -SOURCE=3D.\AslCompiler\AslCompiler.y.c
> -
> -!IF  "$(CFG)" =3D=3D "AslCompiler - Win32 Release"
> -
> -# ADD CPP /W3
> -
> -!ELSEIF  "$(CFG)" =3D=3D "AslCompiler - Win32 Debug"
> -
> -# PROP Exclude_From_Build 1
> -# ADD CPP /W3
> -
> -!ENDIF
> -
> +SOURCE=3D.\aslcompiler.y.c
>  # End Source File
>  # Begin Source File
> =

> -SOURCE=3D.\AslCompilerDebug\AslCompilerDebug.l.c
> -
> -!IF  "$(CFG)" =3D=3D "AslCompiler - Win32 Release"
> -
> -# PROP Exclude_From_Build 1
> -# ADD CPP /W3
> -
> -!ELSEIF  "$(CFG)" =3D=3D "AslCompiler - Win32 Debug"
> -
> -# ADD CPP /W3
> -
> -!ENDIF
> -
> +SOURCE=3D.\dtparser.l.c
>  # End Source File
>  # Begin Source File
> =

> -SOURCE=3D.\AslCompilerDebug\AslCompilerDebug.y.c
> -
> -!IF  "$(CFG)" =3D=3D "AslCompiler - Win32 Release"
> -
> -# PROP Exclude_From_Build 1
> -# ADD CPP /W3
> -
> -!ELSEIF  "$(CFG)" =3D=3D "AslCompiler - Win32 Debug"
> -
> -# ADD CPP /W3
> +SOURCE=3D.\dtparser.y.c
> +# End Source File
> +# Begin Source File
> =

> -!ENDIF
> +SOURCE=3D.\prparser.l.c
> +# End Source File
> +# Begin Source File
> =

> +SOURCE=3D.\prparser.y.c
>  # End Source File
>  # End Group
>  # Begin Group "Disassembler"
> @@ -470,6 +510,10 @@
> SOURCE=3D..\..\source\COMPONENTS\disassembler\dmbuffer.c
>  # End Source File
>  # Begin Source File
> =

> +SOURCE=3D..\..\source\components\disassembler\dmdeferred.c
> +# End Source File
> +# Begin Source File
> +
>  SOURCE=3D..\..\source\COMPONENTS\disassembler\dmnames.c
>  # End Source File
>  # Begin Source File
> @@ -490,6 +534,10 @@
> SOURCE=3D..\..\source\COMPONENTS\disassembler\dmresrcl.c
>  # End Source File
>  # Begin Source File
> =

> +SOURCE=3D..\..\source\components\disassembler\dmresrcl2.c
> +# End Source File
> +# Begin Source File
> +
>  SOURCE=3D..\..\source\COMPONENTS\disassembler\dmresrcs.c
>  # End Source File
>  # Begin Source File
> @@ -618,10 +666,18 @@ SOURCE=3D..\..\source\components\parser\psloop.c
>  # End Source File
>  # Begin Source File
> =

> +SOURCE=3D..\..\source\components\parser\psobject.c
> +# End Source File
> +# Begin Source File
> +
>  SOURCE=3D..\..\source\components\parser\psopcode.c
>  # End Source File
>  # Begin Source File
> =

> +SOURCE=3D..\..\source\components\parser\psopinfo.c
> +# End Source File
> +# Begin Source File
> +
>  SOURCE=3D..\..\source\components\parser\psparse.c
>  # End Source File
>  # Begin Source File
> @@ -646,6 +702,14 @@ SOURCE=3D..\..\source\components\parser\pswalk.c
>  # PROP Default_Filter ""
>  # Begin Source File
> =

> +SOURCE=3D..\..\source\components\dispatcher\dsargs.c
> +# End Source File
> +# Begin Source File
> +
> +SOURCE=3D..\..\source\components\dispatcher\dscontrol.c
> +# End Source File
> +# Begin Source File
> +
>  SOURCE=3D..\..\source\components\dispatcher\dsfield.c
>  # End Source File
>  # Begin Source File
> @@ -670,6 +734,10 @@ SOURCE=3D..\..\source\components\dispatcher\dswload.c
>  # End Source File
>  # Begin Source File
> =

> +SOURCE=3D..\..\source\components\dispatcher\dswload2.c
> +# End Source File
> +# Begin Source File
> +
>  SOURCE=3D..\..\source\components\dispatcher\dswscope.c
>  # End Source File
>  # Begin Source File
> @@ -753,25 +821,24 @@ SOURCE=3D../../source/compiler/aslcompiler.l
>  !IF  "$(CFG)" =3D=3D "AslCompiler - Win32 Release"
> =

>  # PROP Ignore_Default_Tool 1
> -# Begin Custom Build - Building iASL Lexer  from $(InputPath) to
> AslCompiler/$(InputName).l.c
> -ProjDir=3D.
> +# Begin Custom Build - Lexing $(InputPath)...
>  InputPath=3D../../source/compiler/aslcompiler.l
>  InputName=3Daslcompiler
> =

> -"AslCompiler/$(InputName).l.c" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
> -	..\..\Tools_3rd_party\BisonFlex\flex.exe -PAslCompiler -i -s -
> o$(ProjDir)/AslCompiler/$(InputName).l.c $(InputPath)
> +"$(InputName).l.c" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
> +	flex -PAslCompiler -o$(InputName).l.c $(InputPath)
> =

>  # End Custom Build
> =

>  !ELSEIF  "$(CFG)" =3D=3D "AslCompiler - Win32 Debug"
> =

>  # PROP Ignore_Default_Tool 1
> -# Begin Custom Build - Building iASL Lexer  from $(InputPath) to
> AslCompilerDebug/$(InputName)Debug.l.c
> +# Begin Custom Build - Lexing $(InputPath)...
>  InputPath=3D../../source/compiler/aslcompiler.l
>  InputName=3Daslcompiler
> =

> -"AslCompilerDebug/$(InputName)Debug.l.c" : $(SOURCE) "$(INTDIR)"
> "$(OUTDIR)"
> -	..\..\Tools_3rd_party\BisonFlex\flex.exe -PAslCompiler -i -s -
> oAslCompilerDebug/$(InputName)Debug.l.c $(InputPath)
> +"$(InputName).l.c" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
> +	flex -PAslCompiler -o$(InputName).l.c $(InputPath)
> =

>  # End Custom Build
> =

> @@ -785,37 +852,174 @@ SOURCE=3D../../source/compiler/aslcompiler.y
>  !IF  "$(CFG)" =3D=3D "AslCompiler - Win32 Release"
> =

>  # PROP Ignore_Default_Tool 1
> -# Begin Custom Build - Building iASL Parser from $(InputPath) to
> AslCompiler/$(InputName).y.c
> -ProjDir=3D.
> +# Begin Custom Build - Yaccing $(InputPath)...
>  InputPath=3D../../source/compiler/aslcompiler.y
>  InputName=3Daslcompiler
> =

>  BuildCmds=3D \
> -	..\..\Tools_3rd_party\BisonFlex\bison_custom.exe -pAslCompiler -t -d
> -v -o$(ProjDir)/AslCompiler/$(InputName).y.c $(InputPath)
> +	bison -d -pAslCompiler -v $(InputPath) -vd -o$(InputName).y.c
> =

> -"AslCompiler/$(InputName).y.c" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
> +"$(InputName).y.c" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
>     $(BuildCmds)
> =

> -"AslCompiler/$(InputName).y.h" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
> +"$(InputName).y.h" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
>     $(BuildCmds)
>  # End Custom Build
> =

>  !ELSEIF  "$(CFG)" =3D=3D "AslCompiler - Win32 Debug"
> =

>  # PROP Ignore_Default_Tool 1
> -# Begin Custom Build - Building iASL Parser from $(InputPath) to
> AslCompilerDebug/$(InputName)Debug.y.c
> +# Begin Custom Build - Yaccing $(InputPath)...
>  InputPath=3D../../source/compiler/aslcompiler.y
>  InputName=3Daslcompiler
> =

>  BuildCmds=3D \
> -	..\..\Tools_3rd_party\BisonFlex\bison_custom.exe -pAslCompiler -t -d
> -v -oAslCompilerDebug/$(InputName).y.c $(InputPath) \
> -	move AslCompilerDebug\$(InputName).y.c
> AslCompilerDebug\$(InputName)Debug.y.c \
> -
> +	bison -d -pAslCompiler -v $(InputPath) -vd -o$(InputName).y.c
> +
> +"$(InputName).y.c" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
> +   $(BuildCmds)
> +
> +"$(InputName).y.h" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
> +   $(BuildCmds)
> +# End Custom Build
> +
> +!ENDIF
> +
> +# End Source File
> +# Begin Source File
> +
> +SOURCE=3D..\..\source\compiler\dtparser.l
> +
> +!IF  "$(CFG)" =3D=3D "AslCompiler - Win32 Release"
> +
> +# Begin Custom Build - Lexing $(InputPath)...
> +InputPath=3D..\..\source\compiler\dtparser.l
> +InputName=3Ddtparser
> +
> +"$(InputName).l.c" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
> +	flex -PDtParser -o$(InputName).l.c $(InputPath)
> +
> +# End Custom Build
> +
> +!ELSEIF  "$(CFG)" =3D=3D "AslCompiler - Win32 Debug"
> +
> +# PROP Ignore_Default_Tool 1
> +# Begin Custom Build - Lexing $(InputPath)...
> +InputPath=3D..\..\source\compiler\dtparser.l
> +InputName=3Ddtparser
> +
> +"$(InputName).l.c" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
> +	flex -PDtParser -o$(InputName).l.c $(InputPath)
> +
> +# End Custom Build
> +
> +!ENDIF
> +
> +# End Source File
> +# Begin Source File
> +
> +SOURCE=3D..\..\source\compiler\dtparser.y
> +
> +!IF  "$(CFG)" =3D=3D "AslCompiler - Win32 Release"
> +
> +# Begin Custom Build - Yaccing $(InputPath)...
> +InputPath=3D..\..\source\compiler\dtparser.y
> +InputName=3Ddtparser
> +
> +BuildCmds=3D \
> +	bison -d -pDtParser -v $(InputPath) -vd -o$(InputName).y.c
> +
> +"$(InputName).y.c" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
> +   $(BuildCmds)
> +
> +"$(InputName).y.h" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
> +   $(BuildCmds)
> +# End Custom Build
> +
> +!ELSEIF  "$(CFG)" =3D=3D "AslCompiler - Win32 Debug"
> +
> +# PROP Ignore_Default_Tool 1
> +# Begin Custom Build - Yaccing $(InputPath)...
> +InputPath=3D..\..\source\compiler\dtparser.y
> +InputName=3Ddtparser
> +
> +BuildCmds=3D \
> +	bison -d -pDtParser -v $(InputPath) -vd -o$(InputName).y.c
> +
> +"$(InputName).y.c" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
> +   $(BuildCmds)
> +
> +"$(InputName).y.h" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
> +   $(BuildCmds)
> +# End Custom Build
> +
> +!ENDIF
> +
> +# End Source File
> +# Begin Source File
> +
> +SOURCE=3D..\..\source\compiler\prparser.l
> +
> +!IF  "$(CFG)" =3D=3D "AslCompiler - Win32 Release"
> +
> +# Begin Custom Build - Lexing $(InputPath)...
> +InputPath=3D..\..\source\compiler\prparser.l
> +InputName=3Dprparser
> +
> +"$(InputName).l.c" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
> +	flex -PPrParser -o$(InputName).l.c $(InputPath)
> +
> +# End Custom Build
> +
> +!ELSEIF  "$(CFG)" =3D=3D "AslCompiler - Win32 Debug"
> +
> +# PROP Ignore_Default_Tool 1
> +# Begin Custom Build - Lexing $(InputPath)...
> +InputPath=3D..\..\source\compiler\prparser.l
> +InputName=3Dprparser
> +
> +"$(InputName).l.c" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
> +	flex -PPrParser -o$(InputName).l.c $(InputPath)
> +
> +# End Custom Build
> +
> +!ENDIF
> +
> +# End Source File
> +# Begin Source File
> +
> +SOURCE=3D..\..\source\compiler\prparser.y
> +
> +!IF  "$(CFG)" =3D=3D "AslCompiler - Win32 Release"
> +
> +# Begin Custom Build - Yaccing $(InputPath)...
> +InputPath=3D..\..\source\compiler\prparser.y
> +InputName=3Dprparser
> +
> +BuildCmds=3D \
> +	bison -d -pPrParser -v $(InputPath) -vd -o$(InputName).y.c
> +
> +"$(InputName).y.c" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
> +   $(BuildCmds)
> +
> +"$(InputName).y.h" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
> +   $(BuildCmds)
> +# End Custom Build
> +
> +!ELSEIF  "$(CFG)" =3D=3D "AslCompiler - Win32 Debug"
> +
> +# PROP Ignore_Default_Tool 1
> +# Begin Custom Build - Yaccing $(InputPath)...
> +InputPath=3D..\..\source\compiler\prparser.y
> +InputName=3Dprparser
> +
> +BuildCmds=3D \
> +	bison -d -pPrParser -v $(InputPath) -vd -o$(InputName).y.c
> =

> -"AslCompilerDebug/$(InputName)Debug.y.c" : $(SOURCE) "$(INTDIR)"
> "$(OUTDIR)"
> +"$(InputName).y.c" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
>     $(BuildCmds)
> =

> -"AslCompilerDebug/$(InputName).y.h" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
> +"$(InputName).y.h" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
>     $(BuildCmds)
>  # End Custom Build
> =

> diff --git a/source/compiler/aslcompiler.y b/source/compiler/aslcompiler.y
> index 7191e85..2ed10c1 100644
> --- a/source/compiler/aslcompiler.y
> +++ b/source/compiler/aslcompiler.y
> @@ -141,7 +141,6 @@ void *                      AslLocalAllocate (unsigned
> int Size);
> =

>  /* Bison/yacc configuration */
> =

> -#define static
>  #undef alloca
>  #define alloca              AslLocalAllocate
>  #define yytname             AslCompilername
> diff --git a/source/compiler/dtparser.y b/source/compiler/dtparser.y
> index c400549..46ef7b2 100644
> --- a/source/compiler/dtparser.y
> +++ b/source/compiler/dtparser.y
> @@ -120,6 +120,13 @@
>  #define _COMPONENT          DT_COMPILER
>          ACPI_MODULE_NAME    ("dtparser")
> =

> +void *                      AslLocalAllocate (unsigned int Size);
> +
> +/* Bison/yacc configuration */
> +
> +#undef alloca
> +#define alloca              AslLocalAllocate
> +
>  int                         DtParserlex (void);
>  int                         DtParserparse (void);
>  void                        DtParsererror (char const *msg);
> diff --git a/source/compiler/prparser.y b/source/compiler/prparser.y
> index 2b19713..c2f2150 100644
> --- a/source/compiler/prparser.y
> +++ b/source/compiler/prparser.y
> @@ -120,6 +120,13 @@
>  #define _COMPONENT          ASL_PREPROCESSOR
>          ACPI_MODULE_NAME    ("prparser")
> =

> +void *                      AslLocalAllocate (unsigned int Size);
> +
> +/* Bison/yacc configuration */
> +
> +#undef alloca
> +#define alloca              AslLocalAllocate
> +
>  int                         PrParserlex (void);
>  int                         PrParserparse (void);
>  void                        PrParsererror (char const *msg);
> --
> 1.7.10


--===============0950512175337357800==--

