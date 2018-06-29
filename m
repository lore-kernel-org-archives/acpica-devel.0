Content-Type: multipart/mixed; boundary="===============6483877890619625475=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20180629 released
Date: Fri, 29 Jun 2018 15:42:55 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B94BCE45@ORSMSX110.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6483877890619625475==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

29 June 2018. Summary of changes for version 20180629:

This release is available at https://acpica.org/downloads


1) iASL Compiler/Disassembler and Tools:

iASL: Fixed a regression related to the use of the ASL External statement. =
Error checking for the use of the External() statement has been relaxed. Pr=
eviously, a restriction on the use of External meant that the referenced na=
med object was required to be defined in a different table (an SSDT). Thus =
it would be an error to declare an object as an external and then define th=
e same named object in the same table. For example:
    DefinitionBlock (...)
    {
        External (DEV1)
        Device (DEV1){...} // This was an error
    }
However, this behavior has caused regressions in some existing ASL code, be=
cause there is code that depends on named objects and externals (with the s=
ame name) being declared in the same table. This change will allow the ASL =
code above to compile without errors or warnings.

iASL: Implemented ASL language extensions for four operators to make some o=
f their arguments optional instead of required:
    1) Field (RegionName, AccessType, LockRule, UpdateRule)
    2) BankField (RegionName, BankName, BankValue,
                AccessType, LockRule, UpdateRule)
    3) IndexField (IndexName, DataName,
                AccessType, LockRule, UpdateRule)
For the Field operators above, the AccessType, LockRule, and UpdateRule are=
 now optional arguments. The default values are:
        AccessType: AnyAcc
        LockRule:   NoLock
        UpdateRule: Preserve
    4) Mutex (MutexName, SyncLevel)
For this operator, the SyncLevel argument is now optional. This argument is=
 rarely used in any meaningful way by ASL code, and thus it makes sense to =
make it optional. The default value is:
        SyncLevel:  0

iASL: Attempted use of the ASL Unload() operator now results in the followi=
ng warning:
    "Unload is not supported by all operating systems"
This is in fact very true, and the Unload operator may be completely deprec=
ated in the near future.

AcpiExec: Fixed a regression for the -fi option (Namespace initialization f=
ile. Recent changes in the ACPICA module-level code support altered the tab=
le load/initialization sequence . This means that the table load has become=
 a large method execution of the table itself. If Operation Region Fields a=
re used within any module-level code and the -fi option was specified, the =
initialization values were populated only after the table had completely fi=
nished loading (and thus the module-level code had already been executed). =
This change moves the initialization of objects listed in the initializatio=
n file to before the table is executed as a method. Field unit values are n=
ow initialized before the table execution is performed.


--===============6483877890619625475==--

