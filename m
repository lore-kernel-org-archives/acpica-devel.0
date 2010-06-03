Content-Type: multipart/mixed; boundary="===============9200440417430536911=="
MIME-Version: 1.0
From: Lin Ming <ming.m.lin at intel.com>
Subject: Re: [Devel] Packaging
Date: Thu, 03 Jun 2010 09:06:57 +0800
Message-ID: <1275527217.17004.2.camel@minggr.sh.intel.com>
In-Reply-To: 4C06CA9B.9030003@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============9200440417430536911==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2010-06-03 at 05:18 +0800, Nathan O. wrote:
> I started to build the acpiexec, the iASL and AcpiXtract works fine, and
> I get the following:

Hi,

Need to run "make clean" first.

$cd /build/src/acpica-unix-20100528/tools/acpiexec
$make clean
$make

$cd /build/src/acpica-unix-20100528/compiler
$make clean
$make

Lin Ming

> =

> /build/src/acpica-unix-20100528/tools/acpiexec/aeexec.c:608: undefined
> reference to `AcpiGetStatistics'
> aemain.o: In function `main':
> /build/src/acpica-unix-20100528/tools/acpiexec/aemain.c:474: undefined
> reference to `AcpiInitializeSubsystem'
> /build/src/acpica-unix-20100528/tools/acpiexec/aemain.c:581: undefined
> reference to `AcpiGbl_DbConsoleDebugLevel'
> /build/src/acpica-unix-20100528/tools/acpiexec/aemain.c:572: undefined
> reference to `AcpiGbl_DbOpt_stats'
> /build/src/acpica-unix-20100528/tools/acpiexec/aemain.c:552: undefined
> reference to `AcpiGbl_DbOpt_tables'
> /build/src/acpica-unix-20100528/tools/acpiexec/aemain.c:553: undefined
> reference to `AcpiGbl_DbFilename'
> /build/src/acpica-unix-20100528/tools/acpiexec/aemain.c:508: undefined
> reference to `AcpiGbl_DisableMemTracking'
> /build/src/acpica-unix-20100528/tools/acpiexec/aemain.c:593: undefined
> reference to `AcpiGbl_DbOpt_ini_methods'
> /build/src/acpica-unix-20100528/tools/acpiexec/aemain.c:603: undefined
> reference to `AcpiGbl_DbOpt_tables'
> /build/src/acpica-unix-20100528/tools/acpiexec/aemain.c:523: undefined
> reference to `AcpiGbl_DisplayFinalMemStats'
> /build/src/acpica-unix-20100528/tools/acpiexec/aemain.c:499: undefined
> reference to `AcpiGbl_DbOpt_ini_methods'
> /build/src/acpica-unix-20100528/tools/acpiexec/aemain.c:699: undefined
> reference to `AcpiEnableSubsystem'
> /build/src/acpica-unix-20100528/tools/acpiexec/aemain.c:706: undefined
> reference to `AcpiInitializeObjects'
> ../../debugger/dbcmds.o: In function `AcpiDbSetScope':
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbcmds.c:14=
68:
> undefined reference to `AcpiGbl_DbScopeBuf'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbcmds.c:14=
92:
> undefined reference to `AcpiGbl_DbScopeNode'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbcmds.c:14=
99:
> undefined reference to `AcpiGbl_DbScopeBuf'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbcmds.c:15=
00:
> undefined reference to `AcpiGbl_DbScopeBuf'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbcmds.c:15=
00:
> undefined reference to `AcpiGbl_DbScopeBuf'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbcmds.c:15=
04:
> undefined reference to `AcpiGbl_DbScopeBuf'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbcmds.c:15=
03:
> undefined reference to `AcpiGbl_DbScopeNode'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbcmds.c:14=
85:
> undefined reference to `AcpiGbl_DbScopeBuf'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbcmds.c:14=
86:
> undefined reference to `AcpiGbl_DbScopeBuf'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbcmds.c:14=
86:
> undefined reference to `AcpiGbl_DbScopeBuf'
> ../../debugger/dbcmds.o: In function `AcpiDbDisplayResources':
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbcmds.c:17=
18:
> undefined reference to `AcpiGbl_DbBuffer'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbcmds.c:17=
54:
> undefined reference to `AcpiGbl_DbBuffer'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbcmds.c:18=
07:
> undefined reference to `AcpiGbl_DbBuffer'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbcmds.c:17=
35:
> undefined reference to `AcpiGbl_DbBuffer'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbcmds.c:17=
69:
> undefined reference to `AcpiGbl_DbBuffer'
> ../../debugger/dbcmds.o:/build/src/acpica-unix-20100528/tools/acpiexec/..=
/../debugger/dbcmds.c:1820:
> more undefined references to `AcpiGbl_DbBuffer' follow
> ../../debugger/dbexec.o: In function `AcpiDbExecuteMethod':
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbexec.c:18=
3:
> undefined reference to `AcpiGbl_DbOutputToFile'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbexec.c:26=
0:
> undefined reference to `AcpiGbl_DbBuffer'
> ../../debugger/dbexec.o: In function `AcpiDbExecuteSetup':
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbexec.c:29=
9:
> undefined reference to `AcpiGbl_DbScopeBuf'
> ../../debugger/dbinput.o: In function `AcpiDbGetLine':
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:5=
04:
> undefined reference to `AcpiGbl_DbParsedBuf'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:5=
06:
> undefined reference to `AcpiGbl_DbParsedBuf'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:5=
09:
> undefined reference to `AcpiGbl_DbArgs'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:5=
09:
> undefined reference to `AcpiGbl_DbArgs'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:5=
20:
> undefined reference to `AcpiGbl_DbArgs'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:5=
22:
> undefined reference to `AcpiGbl_DbArgs'
> ../../debugger/dbinput.o: In function `AcpiDbCommandDispatch':
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:6=
47:
> undefined reference to `AcpiGbl_DbArgs'
> ../../debugger/dbinput.o:/build/src/acpica-unix-20100528/tools/acpiexec/.=
./../debugger/dbinput.c:651:
> more undefined references to `AcpiGbl_DbArgs' follow
> ../../debugger/dbinput.o: In function `AcpiDbCommandDispatch':
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:6=
64:
> undefined reference to `AcpiDbCloseDebugFile'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:6=
68:
> undefined reference to `AcpiGbl_DbArgs'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:6=
68:
> undefined reference to `AcpiGbl_DbArgs'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:6=
72:
> undefined reference to `AcpiGbl_DbArgs'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:6=
76:
> undefined reference to `AcpiGbl_DbArgs'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:6=
76:
> undefined reference to `AcpiGbl_DbArgs'
> ../../debugger/dbinput.o:/build/src/acpica-unix-20100528/tools/acpiexec/.=
./../debugger/dbinput.c:693:
> more undefined references to `AcpiGbl_DbArgs' follow
> ../../debugger/dbinput.o: In function `AcpiDbCommandDispatch':
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:8=
20:
> undefined reference to `AcpiDbOpenDebugFile'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:8=
24:
> undefined reference to `AcpiGbl_DbArgs'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:8=
24:
> undefined reference to `AcpiGbl_DbArgs'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:7=
78:
> undefined reference to `AcpiGbl_DbArgs'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:7=
77:
> undefined reference to `AcpiGbl_DbDebugLevel'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:7=
78:
> undefined reference to `AcpiGbl_DbDebugLevel'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:7=
86:
> undefined reference to `AcpiGbl_DbArgs'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:7=
90:
> undefined reference to `AcpiGbl_DbArgs'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:9=
08:
> undefined reference to `AcpiGbl_DbOutputToFile'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:9=
13:
> undefined reference to `AcpiDbCloseDebugFile'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:7=
69:
> undefined reference to `AcpiGbl_DbArgs'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:7=
68:
> undefined reference to `AcpiGbl_DbConsoleDebugLevel'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:7=
69:
> undefined reference to `AcpiGbl_DbConsoleDebugLevel'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:7=
61:
> undefined reference to `AcpiGbl_DbDebugLevel'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:7=
63:
> undefined reference to `AcpiGbl_DbConsoleDebugLevel'
> ../../debugger/dbinput.o: In function `AcpiDbExecuteThread':
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:9=
67:
> undefined reference to `AcpiGbl_DbLineBuf'
> ../../debugger/dbinput.o: In function `AcpiDbUserCommands':
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:1=
046:
> undefined reference to `AcpiGbl_DbLineBuf'
> ../../debugger/dbinput.o: In function `AcpiDbSingleThread':
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:9=
99:
> undefined reference to `AcpiGbl_DbLineBuf'
> ../../debugger/dbstats.o: In function `AcpiDbEnumerateObject':
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbstats.c:2=
77:
> undefined reference to `AcpiGbl_NumObjects'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbstats.c:2=
81:
> undefined reference to `AcpiGbl_ObjTypeCountMisc'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbstats.c:2=
77:
> undefined reference to `AcpiGbl_NumObjects'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbstats.c:2=
85:
> undefined reference to `AcpiGbl_ObjTypeCount'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbstats.c:3=
17:
> undefined reference to `AcpiGbl_ObjTypeCount'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbstats.c:3=
11:
> undefined reference to `AcpiGbl_ObjTypeCount'
> ../../debugger/dbstats.o: In function `AcpiDbClassifyOneObject':
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbstats.c:3=
72:
> undefined reference to `AcpiGbl_NumNodes'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbstats.c:3=
86:
> undefined reference to `AcpiGbl_NodeTypeCount'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbstats.c:3=
82:
> undefined reference to `AcpiGbl_NodeTypeCountMisc'
> ../../debugger/dbstats.o: In function `AcpiDbDisplayStatistics':
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbstats.c:5=
28:
> undefined reference to `AcpiGbl_GlobalList'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbstats.c:5=
29:
> undefined reference to `AcpiGbl_NsNodeList'
> ../../debugger/dbstats.o: In function `AcpiDbCountNamespaceObjects':
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbstats.c:4=
38:
> undefined reference to `AcpiGbl_NumNodes'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbstats.c:4=
39:
> undefined reference to `AcpiGbl_NumObjects'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbstats.c:4=
41:
> undefined reference to `AcpiGbl_ObjTypeCountMisc'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbstats.c:4=
44:
> undefined reference to `AcpiGbl_ObjTypeCount'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbstats.c:4=
45:
> undefined reference to `AcpiGbl_NodeTypeCount'
> ../../debugger/dbstats.o: In function `AcpiDbDisplayStatistics':
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbstats.c:5=
13:
> undefined reference to `AcpiGbl_ObjTypeCount'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbstats.c:5=
13:
> undefined reference to `AcpiGbl_NodeTypeCount'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbstats.c:5=
16:
> undefined reference to `AcpiGbl_ObjTypeCountMisc'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbstats.c:5=
16:
> undefined reference to `AcpiGbl_NodeTypeCountMisc'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbstats.c:5=
19:
> undefined reference to `AcpiGbl_NumObjects'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbstats.c:5=
19:
> undefined reference to `AcpiGbl_NumNodes'
> ../../debugger/dbutils.o: In function `AcpiDbSetOutputDestination':
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbutils.c:2=
04:
> undefined reference to `AcpiGbl_DbOutputToFile'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbutils.c:2=
10:
> undefined reference to `AcpiGbl_DbConsoleDebugLevel'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbutils.c:2=
06:
> undefined reference to `AcpiGbl_DbDebugLevel'
> ../../debugger/dbxface.o: In function `AcpiDbSingleStep':
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbxface.c:3=
11:
> undefined reference to `AcpiGbl_DbOutputToFile'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbxface.c:3=
99:
> undefined reference to `AcpiGbl_DbOutputToFile'
> ../../debugger/dbxface.o: In function `AcpiDbStartCommand':
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbxface.c:2=
12:
> undefined reference to `AcpiGbl_DbLineBuf'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbxface.c:2=
15:
> undefined reference to `AcpiGbl_DbLineBuf'
> ../../debugger/dbxface.o: In function `AcpiDbInitialize':
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbxface.c:4=
79:
> undefined reference to `AcpiGbl_DbBuffer'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbxface.c:4=
80:
> undefined reference to `AcpiGbl_DbFilename'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbxface.c:4=
81:
> undefined reference to `AcpiGbl_DbOutputToFile'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbxface.c:4=
83:
> undefined reference to `AcpiGbl_DbDebugLevel'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbxface.c:4=
84:
> undefined reference to `AcpiGbl_DbConsoleDebugLevel'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbxface.c:4=
87:
> undefined reference to `AcpiGbl_DbOpt_tables'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbxface.c:4=
89:
> undefined reference to `AcpiGbl_DbOpt_stats'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbxface.c:4=
91:
> undefined reference to `AcpiGbl_DbOpt_ini_methods'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbxface.c:4=
93:
> undefined reference to `AcpiGbl_DbBuffer'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbxface.c:5=
02:
> undefined reference to `AcpiGbl_DbScopeBuf'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbxface.c:5=
03:
> undefined reference to `AcpiGbl_DbScopeBuf'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbxface.c:5=
04:
> undefined reference to `AcpiGbl_DbScopeNode'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbxface.c:5=
42:
> undefined reference to `AcpiGbl_DbOpt_stats'
> ../../debugger/dbxface.o: In function `AcpiDbTerminate':
> /build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbxface.c:5=
66:
> undefined reference to `AcpiGbl_DbBuffer'
> ../../disassembler/dmwalk.o: In function `AcpiDmDescendingOp':
> dmwalk.c:(.text+0x73d): undefined reference to `AcpiDmEmitExternals'
> ../../dispatcher/dswload.o: In function `AcpiDsLoad1BeginOp':
> dswload.c:(.text+0x158b): undefined reference to `AcpiDmAddToExternalList'
> ../../utilities/uttrack.o: In function `AcpiUtTrackAllocation':
> /build/src/acpica-unix-20100528/tools/acpiexec/../../utilities/uttrack.c:=
439:
> undefined reference to `AcpiGbl_DisableMemTracking'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../utilities/uttrack.c:=
444:
> undefined reference to `AcpiGbl_GlobalList'
> ../../utilities/uttrack.o: In function `AcpiUtFindAllocation':
> /build/src/acpica-unix-20100528/tools/acpiexec/../../utilities/uttrack.c:=
387:
> undefined reference to `AcpiGbl_GlobalList'
> ../../utilities/uttrack.o: In function `AcpiUtAllocateAndTrack':
> /build/src/acpica-unix-20100528/tools/acpiexec/../../utilities/uttrack.c:=
240:
> undefined reference to `AcpiGbl_GlobalList'
> ../../utilities/uttrack.o: In function `AcpiUtAllocateZeroedAndTrack':
> /build/src/acpica-unix-20100528/tools/acpiexec/../../utilities/uttrack.c:=
297:
> undefined reference to `AcpiGbl_GlobalList'
> ../../utilities/uttrack.o: In function `AcpiUtFreeAndTrack':
> /build/src/acpica-unix-20100528/tools/acpiexec/../../utilities/uttrack.c:=
349:
> undefined reference to `AcpiGbl_GlobalList'
> ../../utilities/uttrack.o: In function `AcpiUtRemoveAllocation':
> /build/src/acpica-unix-20100528/tools/acpiexec/../../utilities/uttrack.c:=
526:
> undefined reference to `AcpiGbl_DisableMemTracking'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../utilities/uttrack.c:=
531:
> undefined reference to `AcpiGbl_GlobalList'
> ../../utilities/uttrack.o: In function `AcpiUtDumpAllocations':
> /build/src/acpica-unix-20100528/tools/acpiexec/../../utilities/uttrack.c:=
663:
> undefined reference to `AcpiGbl_DisableMemTracking'
> /build/src/acpica-unix-20100528/tools/acpiexec/../../utilities/uttrack.c:=
676:
> undefined reference to `AcpiGbl_GlobalList'
> collect2: ld returned 1 exit status
> make: *** [acpiexec] Error 1
> =

> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> http://lists.acpica.org/listinfo/devel


--===============9200440417430536911==--

