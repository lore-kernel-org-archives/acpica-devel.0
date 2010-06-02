Content-Type: multipart/mixed; boundary="===============6771139186622259025=="
MIME-Version: 1.0
From: Nathan O. <ndowens04 at gmail.com>
Subject: [Devel] Packaging
Date: Wed, 02 Jun 2010 16:18:19 -0500
Message-ID: <4C06CA9B.9030003@gmail.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6771139186622259025==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I started to build the acpiexec, the iASL and AcpiXtract works fine, and =

I get the following:

/build/src/acpica-unix-20100528/tools/acpiexec/aeexec.c:608: undefined =

reference to `AcpiGetStatistics'
aemain.o: In function `main':
/build/src/acpica-unix-20100528/tools/acpiexec/aemain.c:474: undefined =

reference to `AcpiInitializeSubsystem'
/build/src/acpica-unix-20100528/tools/acpiexec/aemain.c:581: undefined =

reference to `AcpiGbl_DbConsoleDebugLevel'
/build/src/acpica-unix-20100528/tools/acpiexec/aemain.c:572: undefined =

reference to `AcpiGbl_DbOpt_stats'
/build/src/acpica-unix-20100528/tools/acpiexec/aemain.c:552: undefined =

reference to `AcpiGbl_DbOpt_tables'
/build/src/acpica-unix-20100528/tools/acpiexec/aemain.c:553: undefined =

reference to `AcpiGbl_DbFilename'
/build/src/acpica-unix-20100528/tools/acpiexec/aemain.c:508: undefined =

reference to `AcpiGbl_DisableMemTracking'
/build/src/acpica-unix-20100528/tools/acpiexec/aemain.c:593: undefined =

reference to `AcpiGbl_DbOpt_ini_methods'
/build/src/acpica-unix-20100528/tools/acpiexec/aemain.c:603: undefined =

reference to `AcpiGbl_DbOpt_tables'
/build/src/acpica-unix-20100528/tools/acpiexec/aemain.c:523: undefined =

reference to `AcpiGbl_DisplayFinalMemStats'
/build/src/acpica-unix-20100528/tools/acpiexec/aemain.c:499: undefined =

reference to `AcpiGbl_DbOpt_ini_methods'
/build/src/acpica-unix-20100528/tools/acpiexec/aemain.c:699: undefined =

reference to `AcpiEnableSubsystem'
/build/src/acpica-unix-20100528/tools/acpiexec/aemain.c:706: undefined =

reference to `AcpiInitializeObjects'
../../debugger/dbcmds.o: In function `AcpiDbSetScope':
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbcmds.c:1468=
: =

undefined reference to `AcpiGbl_DbScopeBuf'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbcmds.c:1492=
: =

undefined reference to `AcpiGbl_DbScopeNode'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbcmds.c:1499=
: =

undefined reference to `AcpiGbl_DbScopeBuf'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbcmds.c:1500=
: =

undefined reference to `AcpiGbl_DbScopeBuf'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbcmds.c:1500=
: =

undefined reference to `AcpiGbl_DbScopeBuf'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbcmds.c:1504=
: =

undefined reference to `AcpiGbl_DbScopeBuf'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbcmds.c:1503=
: =

undefined reference to `AcpiGbl_DbScopeNode'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbcmds.c:1485=
: =

undefined reference to `AcpiGbl_DbScopeBuf'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbcmds.c:1486=
: =

undefined reference to `AcpiGbl_DbScopeBuf'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbcmds.c:1486=
: =

undefined reference to `AcpiGbl_DbScopeBuf'
../../debugger/dbcmds.o: In function `AcpiDbDisplayResources':
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbcmds.c:1718=
: =

undefined reference to `AcpiGbl_DbBuffer'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbcmds.c:1754=
: =

undefined reference to `AcpiGbl_DbBuffer'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbcmds.c:1807=
: =

undefined reference to `AcpiGbl_DbBuffer'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbcmds.c:1735=
: =

undefined reference to `AcpiGbl_DbBuffer'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbcmds.c:1769=
: =

undefined reference to `AcpiGbl_DbBuffer'
../../debugger/dbcmds.o:/build/src/acpica-unix-20100528/tools/acpiexec/../.=
./debugger/dbcmds.c:1820: =

more undefined references to `AcpiGbl_DbBuffer' follow
../../debugger/dbexec.o: In function `AcpiDbExecuteMethod':
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbexec.c:183: =

undefined reference to `AcpiGbl_DbOutputToFile'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbexec.c:260: =

undefined reference to `AcpiGbl_DbBuffer'
../../debugger/dbexec.o: In function `AcpiDbExecuteSetup':
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbexec.c:299: =

undefined reference to `AcpiGbl_DbScopeBuf'
../../debugger/dbinput.o: In function `AcpiDbGetLine':
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:504=
: =

undefined reference to `AcpiGbl_DbParsedBuf'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:506=
: =

undefined reference to `AcpiGbl_DbParsedBuf'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:509=
: =

undefined reference to `AcpiGbl_DbArgs'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:509=
: =

undefined reference to `AcpiGbl_DbArgs'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:520=
: =

undefined reference to `AcpiGbl_DbArgs'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:522=
: =

undefined reference to `AcpiGbl_DbArgs'
../../debugger/dbinput.o: In function `AcpiDbCommandDispatch':
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:647=
: =

undefined reference to `AcpiGbl_DbArgs'
../../debugger/dbinput.o:/build/src/acpica-unix-20100528/tools/acpiexec/../=
../debugger/dbinput.c:651: =

more undefined references to `AcpiGbl_DbArgs' follow
../../debugger/dbinput.o: In function `AcpiDbCommandDispatch':
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:664=
: =

undefined reference to `AcpiDbCloseDebugFile'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:668=
: =

undefined reference to `AcpiGbl_DbArgs'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:668=
: =

undefined reference to `AcpiGbl_DbArgs'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:672=
: =

undefined reference to `AcpiGbl_DbArgs'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:676=
: =

undefined reference to `AcpiGbl_DbArgs'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:676=
: =

undefined reference to `AcpiGbl_DbArgs'
../../debugger/dbinput.o:/build/src/acpica-unix-20100528/tools/acpiexec/../=
../debugger/dbinput.c:693: =

more undefined references to `AcpiGbl_DbArgs' follow
../../debugger/dbinput.o: In function `AcpiDbCommandDispatch':
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:820=
: =

undefined reference to `AcpiDbOpenDebugFile'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:824=
: =

undefined reference to `AcpiGbl_DbArgs'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:824=
: =

undefined reference to `AcpiGbl_DbArgs'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:778=
: =

undefined reference to `AcpiGbl_DbArgs'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:777=
: =

undefined reference to `AcpiGbl_DbDebugLevel'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:778=
: =

undefined reference to `AcpiGbl_DbDebugLevel'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:786=
: =

undefined reference to `AcpiGbl_DbArgs'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:790=
: =

undefined reference to `AcpiGbl_DbArgs'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:908=
: =

undefined reference to `AcpiGbl_DbOutputToFile'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:913=
: =

undefined reference to `AcpiDbCloseDebugFile'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:769=
: =

undefined reference to `AcpiGbl_DbArgs'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:768=
: =

undefined reference to `AcpiGbl_DbConsoleDebugLevel'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:769=
: =

undefined reference to `AcpiGbl_DbConsoleDebugLevel'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:761=
: =

undefined reference to `AcpiGbl_DbDebugLevel'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:763=
: =

undefined reference to `AcpiGbl_DbConsoleDebugLevel'
../../debugger/dbinput.o: In function `AcpiDbExecuteThread':
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:967=
: =

undefined reference to `AcpiGbl_DbLineBuf'
../../debugger/dbinput.o: In function `AcpiDbUserCommands':
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:104=
6: =

undefined reference to `AcpiGbl_DbLineBuf'
../../debugger/dbinput.o: In function `AcpiDbSingleThread':
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbinput.c:999=
: =

undefined reference to `AcpiGbl_DbLineBuf'
../../debugger/dbstats.o: In function `AcpiDbEnumerateObject':
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbstats.c:277=
: =

undefined reference to `AcpiGbl_NumObjects'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbstats.c:281=
: =

undefined reference to `AcpiGbl_ObjTypeCountMisc'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbstats.c:277=
: =

undefined reference to `AcpiGbl_NumObjects'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbstats.c:285=
: =

undefined reference to `AcpiGbl_ObjTypeCount'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbstats.c:317=
: =

undefined reference to `AcpiGbl_ObjTypeCount'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbstats.c:311=
: =

undefined reference to `AcpiGbl_ObjTypeCount'
../../debugger/dbstats.o: In function `AcpiDbClassifyOneObject':
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbstats.c:372=
: =

undefined reference to `AcpiGbl_NumNodes'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbstats.c:386=
: =

undefined reference to `AcpiGbl_NodeTypeCount'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbstats.c:382=
: =

undefined reference to `AcpiGbl_NodeTypeCountMisc'
../../debugger/dbstats.o: In function `AcpiDbDisplayStatistics':
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbstats.c:528=
: =

undefined reference to `AcpiGbl_GlobalList'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbstats.c:529=
: =

undefined reference to `AcpiGbl_NsNodeList'
../../debugger/dbstats.o: In function `AcpiDbCountNamespaceObjects':
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbstats.c:438=
: =

undefined reference to `AcpiGbl_NumNodes'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbstats.c:439=
: =

undefined reference to `AcpiGbl_NumObjects'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbstats.c:441=
: =

undefined reference to `AcpiGbl_ObjTypeCountMisc'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbstats.c:444=
: =

undefined reference to `AcpiGbl_ObjTypeCount'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbstats.c:445=
: =

undefined reference to `AcpiGbl_NodeTypeCount'
../../debugger/dbstats.o: In function `AcpiDbDisplayStatistics':
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbstats.c:513=
: =

undefined reference to `AcpiGbl_ObjTypeCount'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbstats.c:513=
: =

undefined reference to `AcpiGbl_NodeTypeCount'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbstats.c:516=
: =

undefined reference to `AcpiGbl_ObjTypeCountMisc'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbstats.c:516=
: =

undefined reference to `AcpiGbl_NodeTypeCountMisc'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbstats.c:519=
: =

undefined reference to `AcpiGbl_NumObjects'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbstats.c:519=
: =

undefined reference to `AcpiGbl_NumNodes'
../../debugger/dbutils.o: In function `AcpiDbSetOutputDestination':
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbutils.c:204=
: =

undefined reference to `AcpiGbl_DbOutputToFile'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbutils.c:210=
: =

undefined reference to `AcpiGbl_DbConsoleDebugLevel'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbutils.c:206=
: =

undefined reference to `AcpiGbl_DbDebugLevel'
../../debugger/dbxface.o: In function `AcpiDbSingleStep':
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbxface.c:311=
: =

undefined reference to `AcpiGbl_DbOutputToFile'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbxface.c:399=
: =

undefined reference to `AcpiGbl_DbOutputToFile'
../../debugger/dbxface.o: In function `AcpiDbStartCommand':
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbxface.c:212=
: =

undefined reference to `AcpiGbl_DbLineBuf'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbxface.c:215=
: =

undefined reference to `AcpiGbl_DbLineBuf'
../../debugger/dbxface.o: In function `AcpiDbInitialize':
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbxface.c:479=
: =

undefined reference to `AcpiGbl_DbBuffer'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbxface.c:480=
: =

undefined reference to `AcpiGbl_DbFilename'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbxface.c:481=
: =

undefined reference to `AcpiGbl_DbOutputToFile'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbxface.c:483=
: =

undefined reference to `AcpiGbl_DbDebugLevel'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbxface.c:484=
: =

undefined reference to `AcpiGbl_DbConsoleDebugLevel'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbxface.c:487=
: =

undefined reference to `AcpiGbl_DbOpt_tables'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbxface.c:489=
: =

undefined reference to `AcpiGbl_DbOpt_stats'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbxface.c:491=
: =

undefined reference to `AcpiGbl_DbOpt_ini_methods'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbxface.c:493=
: =

undefined reference to `AcpiGbl_DbBuffer'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbxface.c:502=
: =

undefined reference to `AcpiGbl_DbScopeBuf'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbxface.c:503=
: =

undefined reference to `AcpiGbl_DbScopeBuf'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbxface.c:504=
: =

undefined reference to `AcpiGbl_DbScopeNode'
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbxface.c:542=
: =

undefined reference to `AcpiGbl_DbOpt_stats'
../../debugger/dbxface.o: In function `AcpiDbTerminate':
/build/src/acpica-unix-20100528/tools/acpiexec/../../debugger/dbxface.c:566=
: =

undefined reference to `AcpiGbl_DbBuffer'
../../disassembler/dmwalk.o: In function `AcpiDmDescendingOp':
dmwalk.c:(.text+0x73d): undefined reference to `AcpiDmEmitExternals'
../../dispatcher/dswload.o: In function `AcpiDsLoad1BeginOp':
dswload.c:(.text+0x158b): undefined reference to `AcpiDmAddToExternalList'
../../utilities/uttrack.o: In function `AcpiUtTrackAllocation':
/build/src/acpica-unix-20100528/tools/acpiexec/../../utilities/uttrack.c:43=
9: =

undefined reference to `AcpiGbl_DisableMemTracking'
/build/src/acpica-unix-20100528/tools/acpiexec/../../utilities/uttrack.c:44=
4: =

undefined reference to `AcpiGbl_GlobalList'
../../utilities/uttrack.o: In function `AcpiUtFindAllocation':
/build/src/acpica-unix-20100528/tools/acpiexec/../../utilities/uttrack.c:38=
7: =

undefined reference to `AcpiGbl_GlobalList'
../../utilities/uttrack.o: In function `AcpiUtAllocateAndTrack':
/build/src/acpica-unix-20100528/tools/acpiexec/../../utilities/uttrack.c:24=
0: =

undefined reference to `AcpiGbl_GlobalList'
../../utilities/uttrack.o: In function `AcpiUtAllocateZeroedAndTrack':
/build/src/acpica-unix-20100528/tools/acpiexec/../../utilities/uttrack.c:29=
7: =

undefined reference to `AcpiGbl_GlobalList'
../../utilities/uttrack.o: In function `AcpiUtFreeAndTrack':
/build/src/acpica-unix-20100528/tools/acpiexec/../../utilities/uttrack.c:34=
9: =

undefined reference to `AcpiGbl_GlobalList'
../../utilities/uttrack.o: In function `AcpiUtRemoveAllocation':
/build/src/acpica-unix-20100528/tools/acpiexec/../../utilities/uttrack.c:52=
6: =

undefined reference to `AcpiGbl_DisableMemTracking'
/build/src/acpica-unix-20100528/tools/acpiexec/../../utilities/uttrack.c:53=
1: =

undefined reference to `AcpiGbl_GlobalList'
../../utilities/uttrack.o: In function `AcpiUtDumpAllocations':
/build/src/acpica-unix-20100528/tools/acpiexec/../../utilities/uttrack.c:66=
3: =

undefined reference to `AcpiGbl_DisableMemTracking'
/build/src/acpica-unix-20100528/tools/acpiexec/../../utilities/uttrack.c:67=
6: =

undefined reference to `AcpiGbl_GlobalList'
collect2: ld returned 1 exit status
make: *** [acpiexec] Error 1


--===============6771139186622259025==--

