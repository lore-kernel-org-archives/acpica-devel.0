Content-Type: multipart/mixed; boundary="===============7905933170691249735=="
MIME-Version: 1.0
From: Al Stone <ahs3 at redhat.com>
Subject: [Devel] [PATCH] ASLTS: provide proper PATH for acpibin in tests
Date: Wed, 27 Sep 2017 15:20:00 -0600
Message-ID: <0f7e87e5-a968-de12-6264-a41eca0eb8f9@redhat.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7905933170691249735==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Recent versions of ASLTS now use the acpibin utility, much like they
use acpiexec.  However, when use of acpibin was added, it was not
treated like acpiexec and was assumed to exist in whatever PATH a user
had set when running the tests.  When trying to use ASLTS in a very
pristine environment (i.e., no previous version of ACPICA user space
tools is available), portions of the test suite will produce false
failures because acpibin cannot be found and run.

This patch fixes ASLTS so that the use of acpibin is treated exactly
the same as acpiexec -- an environment variable must be defined (in
this case, $acpibin) with the location of the executable, aslts.sh
makes sure a value for the variable is set, Do uses $acpibin (instead
of assuming acpibin exists in a user's PATH), and the various bits
of documentation are updated to note the new environment variable.

Signed-off-by: Al Stone <ahs3(a)redhat.com>
---
 tests/aslts.sh             | 10 ++++++++--
 tests/aslts/HOW_TO_INSTALL |  6 +++++-
 tests/aslts/HOW_TO_USE     |  4 ++++
 tests/aslts/bin/Do         | 11 +++++++++--
 4 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/tests/aslts.sh b/tests/aslts.sh
index 8df422fbc..d8b364be4 100755
--- a/tests/aslts.sh
+++ b/tests/aslts.sh
@@ -7,6 +7,7 @@
 postfix=3D`date +%H%M%S`
 tmp_iasl=3D/tmp/iasl-$postfix
 tmp_acpiexec=3D/tmp/acpiexec-$postfix
+tmp_acpibin=3D/tmp/acpibin-$postfix

 TEST_CASES=3D
 TEST_MODES=3D
@@ -65,6 +66,7 @@ setup_environment() {

 	export ASL=3D$tmp_iasl
 	export acpiexec=3D$tmp_acpiexec		=

+	export acpibin=3D$tmp_acpibin
 	export ASLTSDIR=3D$aslts_dir
 	export PATH=3D$ASLTSDIR/bin:$PATH
 }
@@ -75,7 +77,7 @@ build_acpi_tools() {

 	restore_dir=3D$PWD
 	cd ${generation_dir}
-	rm -f $tmp_iasl $tmp_acpiexec
+	rm -f $tmp_iasl $tmp_acpiexec $tmp_acpibin

 	# Build native-width iASL compiler and acpiexec
 	if [ ! -e bin/iasl -o ! -e bin/acpiexec ]; then
@@ -91,6 +93,7 @@ build_acpi_tools() {
 		echo "Installing ACPICA tools"
 		cp bin/iasl $tmp_iasl
 		cp bin/acpiexec $tmp_acpiexec
+		cp bin/acpibin $tmp_acpibin
 	else
 		echo "Could not find iASL/acpiexec tools"
 		exit
@@ -103,6 +106,9 @@ build_acpi_tools() {
 	elif [ ! -f $tmp_acpiexec ] ; then
 		echo "acpiexec utility not found"
 		exit
+	elif [ ! -f $tmp_acpibin ] ; then
+		echo "acpibin utility not found"
+		exit
 	fi

 	cd $restore_dir
@@ -140,7 +146,7 @@ run_aslts() {
 		echo "ASL Test Suite Finished: `date`"
 		echo "                Started: $start_time"

-		rm -f $tmp_iasl $tmp_acpiexec
+		rm -f $tmp_iasl $tmp_acpiexec $tmp_acpibin
 	fi;
 }

diff --git a/tests/aslts/HOW_TO_INSTALL b/tests/aslts/HOW_TO_INSTALL
index 44648e2fe..300a86310 100644
--- a/tests/aslts/HOW_TO_INSTALL
+++ b/tests/aslts/HOW_TO_INSTALL
@@ -49,12 +49,16 @@ ENVIRONMENT
             > export ASL=3D"c:/acpica/libraries/iasl.exe"


-   For test execution, two additional variables are required:
+   For test execution, three additional variables are required:

         acpiexec - path to acpiexec utility: (example)

             > export acpiexec=3D"c:/acpica/libraries/acpiexec.exe"

+        acpibin - path to acpibin utility: (example)
+
+            > export acpibin=3D"c:/acpica/libraries/acpibin.exe"
+
         ASLTSDIR - path to the aslts directory: (example)

             > export ASLTSDIR=3D"c:/acpica/tests/aslts"
diff --git a/tests/aslts/HOW_TO_USE b/tests/aslts/HOW_TO_USE
index 233fdbb03..d60945802 100644
--- a/tests/aslts/HOW_TO_USE
+++ b/tests/aslts/HOW_TO_USE
@@ -32,6 +32,10 @@ How to execute the run-time tests

             > export acpiexec=3D"c:/acpica/libraries/acpiexec.exe"

+        acpibin - path to acpibin utility: (example)
+
+            > export acpibin=3D"c:/acpica/libraries/acpibin.exe"
+
         ASLTSDIR - path to the aslts directory: (example)

             > export ASLTSDIR=3D"c:/acpica/tests/aslts"
diff --git a/tests/aslts/bin/Do b/tests/aslts/bin/Do
index d034072d4..f4742eda1 100755
--- a/tests/aslts/bin/Do
+++ b/tests/aslts/bin/Do
@@ -20,12 +20,13 @@
 #
 #     ASL      - iASL compiler
 #     acpiexec - AcpiExec utility
+#     acpibin  - AcpiBin utility
 #     ASLTSDIR - pathname of root directory of aslts test suite
 #
 # External definitions required for particular command:
 #
 #     0 - ASLTSDIR, ASL
-#     1 - ASLTSDIR, acpiexec
+#     1 - ASLTSDIR, acpiexec, acpibin
 #     2 - ASLTSDIR
 #     3 - none
 #     4 - ASLTSDIR
@@ -346,7 +347,7 @@ binary_compare()
                 if [ ! -f "$normal_compile_dir/$filename" ]; then
 			echo "  binary compare $mode the following file does not exist:
$normal_compile_dir/$filename"
 		else
-			acpibin -a "$f" "$normal_compile_dir/$filename" > /dev/null
+			$acpibin -a "$f" "$normal_compile_dir/$filename" > /dev/null
 			if [ $? -ne 0 ]; then
 				echo " [[ Error: $mode Binary compare for $filename failed ]]"
 			else
@@ -809,6 +810,12 @@ elif [ $CMD =3D=3D $RUNTESTS ]; then
 		do_exit 1 "Undefined acpiexec variable! Set it to pathname of AcpiExec u=
tility."
 	fi

+	# Check access to AcpiBin utility
+
+	if [ ! -f "$acpibin" ]; then
+		do_exit 1 "Undefined acpibin variable! Set it to pathname of AcpiBin uti=
lity."
+	fi
+
 	shift 1
 	ASLTSRUN_PARAMS=3D

-- =

2.13.5


--===============7905933170691249735==--

