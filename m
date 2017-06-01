Content-Type: multipart/mixed; boundary="===============2602177351585244428=="
MIME-Version: 1.0
From: Sascha Wildner <swildner at gmail.com>
Subject: Re: [Devel] ACPICA version 20170531 released
Date: Thu, 01 Jun 2017 11:32:17 +0200
Message-ID: <CABC13nHQvz28dmvYsKmRQ_C5WdeJdOu9mo1xwBhmJ3QCLGvbAQ@mail.gmail.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E37E5BB0FA@ORSMSX110.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2602177351585244428==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

it looks like the changes.txt file in the tarball (
https://acpica.org/sites/acpica/files/acpica-unix-20170531.tar.gz) does not
list the changes of 20170531.

Sascha


On Wed, May 31, 2017 at 11:50 PM, Moore, Robert <robert.moore(a)intel.com>
wrote:

> 31 May 2017. Summary of changes for version 20170531:
>
> This release is available at https://acpica.org/downloads
>
>
> 0) ACPI 6.2 support:
>
> The ACPI specification version 6.2 has been released and is available at
> http://uefi.org/specifications
>
> This version of ACPICA fully supports the ACPI 6.2 specification. Changes
> are summarized below.
>
> New ACPI tables (Table Compiler/Disassembler/Templates):
>     HMAT (Heterogeneous Memory Attributes Table)
>     WSMT (Windows SMM Security Mitigation Table)
>     PPTT (Processor Properties Topology Table)
>
> New subtables for existing ACPI tables:
>     HEST (New subtable, Arch-deferred machine check)
>     SRAT (New subtable, Arch-specific affinity structure)
>     PCCT (New subtables, Extended PCC subspaces (types 3 and 4))
>
> Simple updates for existing ACPI tables:
>     BGRT (two new flag bits)
>     HEST (New bit defined for several subtables, GHES_ASSIST)
>
> New Resource Descriptors and Resource macros (Compiler/Disassembler):
>     PinConfig()
>     PinFunction()
>     PinGroup()
>     PinGroupConfig()
>     PinGroupFunction()
>     New type for hardware error notification (section 18.3.2.9)
>
> New predefined names/methods (Compiler/Interpreter):
>     _HMA (Heterogeneous Memory Attributes)
>     _LSI (Label Storage Information)
>     _LSR (Label Storage Read)
>     _LSW (Label Storage Write)
>
> ASL grammar/macro changes (Compiler):
>     For() ASL macro, implemented with the AML while operator
>     Extensions to Concatenate operator
>     Support for multiple definition blocks in same ASL file
>     Clarification for Buffer operator
>     Allow executable AML code underneath all scopes (Devices, etc.)
>     Clarification/change for the _OSI return value
>     ASL grammar update for reference operators
>     Allow a zero-length string for AML filename in DefinitionBlock
>
> Miscellaneous:
>     New device object notification value
>     Remove a notify value (0x0C) for graceful shutdown
>     New UUIDs for processor/cache properties and physical package property
>     New _HID, ACPI0014 (Wireless Power Calibration Device)
>
>
> 1) ACPICA kernel-resident subsystem:
>
> Added support to disable ACPI events on hardware-reduced platforms.
> Eliminates error messages of the form "Could not enable fixed event". Lv
> Zheng
>
> Fixed a problem using Device/Thermal objects with the ObjectType and
> DerefOf ASL operators. This support had not been fully/properly implement=
ed.
>
> Fixed a problem where if a Buffer object containing a resource template
> was longer than the actual resource template, an error was generated --
> even though the AML is legal. This case has been seen in the field.
>
> Fixed a problem with the header definition of the MADT PCAT_COMPAT flag.
> The values for DUAL_PIC and MULTIPLE_APIC were reversed.
>
> Added header file changes for the TPM2 ACPI table. Update to new version
> of the TCG specification. Adds a new TPM2 subtable for ARM SMC.
>
> Exported the external interfaces AcpiAcquireMutex and AcpiReleaseMutex.
> These interfaces are intended to be used only in conjunction with the
> predefined _DLM method (Device Lock Method). "This object appears in a
> device scope when AML access to the device must be synchronized with the =
OS
> environment".
>
> Example Code and Data Size: These are the sizes for the OS-independent
> acpica.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The
> debug version of the code includes the debug output trace mechanism and
> has a much larger code and data size.
>
>   Current Release:
>     Non-Debug Version: 143.1K Code, 60.0K Data, 203.1K Total
>     Debug Version:     204.0K Code, 84.3K Data, 288.3K Total
>   Previous Release:
>     Non-Debug Version: 141.7K Code, 58.5K Data, 200.2K Total
>     Debug Version:     207.5K Code, 82.7K Data, 290.2K Total
>
>
> 2) iASL Compiler/Disassembler and Tools:
>
> iASL: Fixed a problem where an External() declaration could not refer to a
> Field Unit. Erik Schmauss.
>
> Disassembler: Improved support for the Switch/Case operators. This feature
> will disassemble AML code back to the original Switch operators when
> possible, instead of an If..Else sequence. David Box
>
> iASL and disassembler: Improved the handling of multiple extraneous
> parentheses for both ASL input and disassembled ASL output.
>
> Improved the behavior of the iASL compiler and disassembler to detect
> improper use of external declarations
>
> Disassembler: Now aborts immediately upon detection of an unknown AML
> opcode. The AML parser has no real way to recover from this, and can resu=
lt
> in the creation of an ill-formed parse tree that causes errors later duri=
ng
> the disassembly.
>
> All tools: Fixed a problem where the Unix application OSL did not handle
> control-c correctly. For example, a control-c could incorrectly wake the
> debugger.
>
> AcpiExec: Improved the Control-C handling and added a handler for
> segmentation faults (SIGSEGV). Supports both Windows and Unix-like
> environments.
>
> Reduced the verbosity of the generic unix makefiles. Previously, each
> compilation displayed the full set of compiler options. This has been
> eliminated as the options are easily inspected within the makefiles. Each
> compilation now results in a single line of output.
>
> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> https://lists.acpica.org/mailman/listinfo/devel
>

--===============2602177351585244428==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGksPGRpdj48YnI+PC9kaXY+PGRpdj5pdCBsb29rcyBsaWtlIHRoZSBj
aGFuZ2VzLnR4dCBmaWxlIGluIHRoZSB0YXJiYWxsICg8YSBocmVmPSJodHRwczovL2FjcGljYS5v
cmcvc2l0ZXMvYWNwaWNhL2ZpbGVzL2FjcGljYS11bml4LTIwMTcwNTMxLnRhci5neiI+aHR0cHM6
Ly9hY3BpY2Eub3JnL3NpdGVzL2FjcGljYS9maWxlcy9hY3BpY2EtdW5peC0yMDE3MDUzMS50YXIu
Z3o8L2E+KSBkb2VzIG5vdCBsaXN0IHRoZSBjaGFuZ2VzIG9mIDIwMTcwNTMxLjwvZGl2PjxkaXY+
PGJyPjwvZGl2PjxkaXY+U2FzY2hhPC9kaXY+PGRpdj48YnI+PC9kaXY+PC9kaXY+PGRpdiBjbGFz
cz0iZ21haWxfZXh0cmEiPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+T24gV2VkLCBNYXkg
MzEsIDIwMTcgYXQgMTE6NTAgUE0sIE1vb3JlLCBSb2JlcnQgPHNwYW4gZGlyPSJsdHIiPiZsdDs8
YSBocmVmPSJtYWlsdG86cm9iZXJ0Lm1vb3JlQGludGVsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPnJv
YmVydC5tb29yZUBpbnRlbC5jb208L2E+Jmd0Ozwvc3Bhbj4gd3JvdGU6PGJyPjxibG9ja3F1b3Rl
IGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0
OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPjMxIE1heSAyMDE3LiBTdW1tYXJ5IG9m
IGNoYW5nZXMgZm9yIHZlcnNpb24gMjAxNzA1MzE6PGJyPgo8YnI+ClRoaXMgcmVsZWFzZSBpcyBh
dmFpbGFibGUgYXQgPGEgaHJlZj0iaHR0cHM6Ly9hY3BpY2Eub3JnL2Rvd25sb2FkcyIgcmVsPSJu
b3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9hY3BpY2Eub3JnL2Rvd25sb2Fkczwv
YT48YnI+Cjxicj4KPGJyPgowKSBBQ1BJIDYuMiBzdXBwb3J0Ojxicj4KPGJyPgpUaGUgQUNQSSBz
cGVjaWZpY2F0aW9uIHZlcnNpb24gNi4yIGhhcyBiZWVuIHJlbGVhc2VkIGFuZCBpcyBhdmFpbGFi
bGUgYXQ8YnI+CjxhIGhyZWY9Imh0dHA6Ly91ZWZpLm9yZy9zcGVjaWZpY2F0aW9ucyIgcmVsPSJu
b3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cDovL3VlZmkub3JnL3NwZWNpZmljYXRpb25z
PC9hPjxicj4KPGJyPgpUaGlzIHZlcnNpb24gb2YgQUNQSUNBIGZ1bGx5IHN1cHBvcnRzIHRoZSBB
Q1BJIDYuMiBzcGVjaWZpY2F0aW9uLiBDaGFuZ2VzIGFyZSBzdW1tYXJpemVkIGJlbG93Ljxicj4K
PGJyPgpOZXcgQUNQSSB0YWJsZXMgKFRhYmxlIENvbXBpbGVyL0Rpc2Fzc2VtYmxlci88d2JyPlRl
bXBsYXRlcyk6PGJyPgrCoCDCoCBITUFUIChIZXRlcm9nZW5lb3VzIE1lbW9yeSBBdHRyaWJ1dGVz
IFRhYmxlKTxicj4KwqAgwqAgV1NNVCAoV2luZG93cyBTTU0gU2VjdXJpdHkgTWl0aWdhdGlvbiBU
YWJsZSk8YnI+CsKgIMKgIFBQVFQgKFByb2Nlc3NvciBQcm9wZXJ0aWVzIFRvcG9sb2d5IFRhYmxl
KTxicj4KPGJyPgpOZXcgc3VidGFibGVzIGZvciBleGlzdGluZyBBQ1BJIHRhYmxlczo8YnI+CsKg
IMKgIEhFU1QgKE5ldyBzdWJ0YWJsZSwgQXJjaC1kZWZlcnJlZCBtYWNoaW5lIGNoZWNrKTxicj4K
wqAgwqAgU1JBVCAoTmV3IHN1YnRhYmxlLCBBcmNoLXNwZWNpZmljIGFmZmluaXR5IHN0cnVjdHVy
ZSk8YnI+CsKgIMKgIFBDQ1QgKE5ldyBzdWJ0YWJsZXMsIEV4dGVuZGVkIFBDQyBzdWJzcGFjZXMg
KHR5cGVzIDMgYW5kIDQpKTxicj4KPGJyPgpTaW1wbGUgdXBkYXRlcyBmb3IgZXhpc3RpbmcgQUNQ
SSB0YWJsZXM6PGJyPgrCoCDCoCBCR1JUICh0d28gbmV3IGZsYWcgYml0cyk8YnI+CsKgIMKgIEhF
U1QgKE5ldyBiaXQgZGVmaW5lZCBmb3Igc2V2ZXJhbCBzdWJ0YWJsZXMsIEdIRVNfQVNTSVNUKTxi
cj4KPGJyPgpOZXcgUmVzb3VyY2UgRGVzY3JpcHRvcnMgYW5kIFJlc291cmNlIG1hY3JvcyAoQ29t
cGlsZXIvRGlzYXNzZW1ibGVyKTo8YnI+CsKgIMKgIFBpbkNvbmZpZygpPGJyPgrCoCDCoCBQaW5G
dW5jdGlvbigpPGJyPgrCoCDCoCBQaW5Hcm91cCgpPGJyPgrCoCDCoCBQaW5Hcm91cENvbmZpZygp
PGJyPgrCoCDCoCBQaW5Hcm91cEZ1bmN0aW9uKCk8YnI+CsKgIMKgIE5ldyB0eXBlIGZvciBoYXJk
d2FyZSBlcnJvciBub3RpZmljYXRpb24gKHNlY3Rpb24gMTguMy4yLjkpPGJyPgo8YnI+Ck5ldyBw
cmVkZWZpbmVkIG5hbWVzL21ldGhvZHMgKENvbXBpbGVyL0ludGVycHJldGVyKTo8YnI+CsKgIMKg
IF9ITUEgKEhldGVyb2dlbmVvdXMgTWVtb3J5IEF0dHJpYnV0ZXMpPGJyPgrCoCDCoCBfTFNJIChM
YWJlbCBTdG9yYWdlIEluZm9ybWF0aW9uKTxicj4KwqAgwqAgX0xTUiAoTGFiZWwgU3RvcmFnZSBS
ZWFkKTxicj4KwqAgwqAgX0xTVyAoTGFiZWwgU3RvcmFnZSBXcml0ZSk8YnI+Cjxicj4KQVNMIGdy
YW1tYXIvbWFjcm8gY2hhbmdlcyAoQ29tcGlsZXIpOjxicj4KwqAgwqAgRm9yKCkgQVNMIG1hY3Jv
LCBpbXBsZW1lbnRlZCB3aXRoIHRoZSBBTUwgd2hpbGUgb3BlcmF0b3I8YnI+CsKgIMKgIEV4dGVu
c2lvbnMgdG8gQ29uY2F0ZW5hdGUgb3BlcmF0b3I8YnI+CsKgIMKgIFN1cHBvcnQgZm9yIG11bHRp
cGxlIGRlZmluaXRpb24gYmxvY2tzIGluIHNhbWUgQVNMIGZpbGU8YnI+CsKgIMKgIENsYXJpZmlj
YXRpb24gZm9yIEJ1ZmZlciBvcGVyYXRvcjxicj4KwqAgwqAgQWxsb3cgZXhlY3V0YWJsZSBBTUwg
Y29kZSB1bmRlcm5lYXRoIGFsbCBzY29wZXMgKERldmljZXMsIGV0Yy4pPGJyPgrCoCDCoCBDbGFy
aWZpY2F0aW9uL2NoYW5nZSBmb3IgdGhlIF9PU0kgcmV0dXJuIHZhbHVlPGJyPgrCoCDCoCBBU0wg
Z3JhbW1hciB1cGRhdGUgZm9yIHJlZmVyZW5jZSBvcGVyYXRvcnM8YnI+CsKgIMKgIEFsbG93IGEg
emVyby1sZW5ndGggc3RyaW5nIGZvciBBTUwgZmlsZW5hbWUgaW4gRGVmaW5pdGlvbkJsb2NrPGJy
Pgo8YnI+Ck1pc2NlbGxhbmVvdXM6PGJyPgrCoCDCoCBOZXcgZGV2aWNlIG9iamVjdCBub3RpZmlj
YXRpb24gdmFsdWU8YnI+CsKgIMKgIFJlbW92ZSBhIG5vdGlmeSB2YWx1ZSAoMHgwQykgZm9yIGdy
YWNlZnVsIHNodXRkb3duPGJyPgrCoCDCoCBOZXcgVVVJRHMgZm9yIHByb2Nlc3Nvci9jYWNoZSBw
cm9wZXJ0aWVzIGFuZCBwaHlzaWNhbCBwYWNrYWdlIHByb3BlcnR5PGJyPgrCoCDCoCBOZXcgX0hJ
RCwgQUNQSTAwMTQgKFdpcmVsZXNzIFBvd2VyIENhbGlicmF0aW9uIERldmljZSk8YnI+Cjxicj4K
PGJyPgoxKSBBQ1BJQ0Ega2VybmVsLXJlc2lkZW50IHN1YnN5c3RlbTo8YnI+Cjxicj4KQWRkZWQg
c3VwcG9ydCB0byBkaXNhYmxlIEFDUEkgZXZlbnRzIG9uIGhhcmR3YXJlLXJlZHVjZWQgcGxhdGZv
cm1zLiBFbGltaW5hdGVzIGVycm9yIG1lc3NhZ2VzIG9mIHRoZSBmb3JtICZxdW90O0NvdWxkIG5v
dCBlbmFibGUgZml4ZWQgZXZlbnQmcXVvdDsuIEx2IFpoZW5nPGJyPgo8YnI+CkZpeGVkIGEgcHJv
YmxlbSB1c2luZyBEZXZpY2UvVGhlcm1hbCBvYmplY3RzIHdpdGggdGhlIE9iamVjdFR5cGUgYW5k
IERlcmVmT2YgQVNMIG9wZXJhdG9ycy4gVGhpcyBzdXBwb3J0IGhhZCBub3QgYmVlbiBmdWxseS9w
cm9wZXJseSBpbXBsZW1lbnRlZC48YnI+Cjxicj4KRml4ZWQgYSBwcm9ibGVtIHdoZXJlIGlmIGEg
QnVmZmVyIG9iamVjdCBjb250YWluaW5nIGEgcmVzb3VyY2UgdGVtcGxhdGUgd2FzIGxvbmdlciB0
aGFuIHRoZSBhY3R1YWwgcmVzb3VyY2UgdGVtcGxhdGUsIGFuIGVycm9yIHdhcyBnZW5lcmF0ZWQg
LS0gZXZlbiB0aG91Z2ggdGhlIEFNTCBpcyBsZWdhbC4gVGhpcyBjYXNlIGhhcyBiZWVuIHNlZW4g
aW4gdGhlIGZpZWxkLjxicj4KPGJyPgpGaXhlZCBhIHByb2JsZW0gd2l0aCB0aGUgaGVhZGVyIGRl
ZmluaXRpb24gb2YgdGhlIE1BRFQgUENBVF9DT01QQVQgZmxhZy4gVGhlIHZhbHVlcyBmb3IgRFVB
TF9QSUMgYW5kIE1VTFRJUExFX0FQSUMgd2VyZSByZXZlcnNlZC48YnI+Cjxicj4KQWRkZWQgaGVh
ZGVyIGZpbGUgY2hhbmdlcyBmb3IgdGhlIFRQTTIgQUNQSSB0YWJsZS4gVXBkYXRlIHRvIG5ldyB2
ZXJzaW9uIG9mIHRoZSBUQ0cgc3BlY2lmaWNhdGlvbi4gQWRkcyBhIG5ldyBUUE0yIHN1YnRhYmxl
IGZvciBBUk0gU01DLjxicj4KPGJyPgpFeHBvcnRlZCB0aGUgZXh0ZXJuYWwgaW50ZXJmYWNlcyBB
Y3BpQWNxdWlyZU11dGV4IGFuZCBBY3BpUmVsZWFzZU11dGV4LiBUaGVzZSBpbnRlcmZhY2VzIGFy
ZSBpbnRlbmRlZCB0byBiZSB1c2VkIG9ubHkgaW4gY29uanVuY3Rpb24gd2l0aCB0aGUgcHJlZGVm
aW5lZCBfRExNIG1ldGhvZCAoRGV2aWNlIExvY2sgTWV0aG9kKS4gJnF1b3Q7VGhpcyBvYmplY3Qg
YXBwZWFycyBpbiBhIGRldmljZSBzY29wZSB3aGVuIEFNTCBhY2Nlc3MgdG8gdGhlIGRldmljZSBt
dXN0IGJlIHN5bmNocm9uaXplZCB3aXRoIHRoZSBPUyBlbnZpcm9ubWVudCZxdW90Oy48YnI+Cjxi
cj4KRXhhbXBsZSBDb2RlIGFuZCBEYXRhIFNpemU6IFRoZXNlIGFyZSB0aGUgc2l6ZXMgZm9yIHRo
ZSBPUy1pbmRlcGVuZGVudDxicj4KYWNwaWNhLmxpYiBwcm9kdWNlZCBieSB0aGUgTWljcm9zb2Z0
IFZpc3VhbCBDKysgOS4wIDMyLWJpdCBjb21waWxlci4gVGhlPGJyPgpkZWJ1ZyB2ZXJzaW9uIG9m
IHRoZSBjb2RlIGluY2x1ZGVzIHRoZSBkZWJ1ZyBvdXRwdXQgdHJhY2UgbWVjaGFuaXNtIGFuZDxi
cj4KaGFzIGEgbXVjaCBsYXJnZXIgY29kZSBhbmQgZGF0YSBzaXplLjxicj4KPGJyPgrCoCBDdXJy
ZW50IFJlbGVhc2U6PGJyPgrCoCDCoCBOb24tRGVidWcgVmVyc2lvbjogMTQzLjFLIENvZGUsIDYw
LjBLIERhdGEsIDIwMy4xSyBUb3RhbDxicj4KwqAgwqAgRGVidWcgVmVyc2lvbjrCoCDCoCDCoDIw
NC4wSyBDb2RlLCA4NC4zSyBEYXRhLCAyODguM0sgVG90YWw8YnI+CsKgIFByZXZpb3VzIFJlbGVh
c2U6PGJyPgrCoCDCoCBOb24tRGVidWcgVmVyc2lvbjogMTQxLjdLIENvZGUsIDU4LjVLIERhdGEs
IDIwMC4ySyBUb3RhbDxicj4KwqAgwqAgRGVidWcgVmVyc2lvbjrCoCDCoCDCoDIwNy41SyBDb2Rl
LCA4Mi43SyBEYXRhLCAyOTAuMksgVG90YWw8YnI+Cjxicj4KPGJyPgoyKSBpQVNMIENvbXBpbGVy
L0Rpc2Fzc2VtYmxlciBhbmQgVG9vbHM6PGJyPgo8YnI+CmlBU0w6IEZpeGVkIGEgcHJvYmxlbSB3
aGVyZSBhbiBFeHRlcm5hbCgpIGRlY2xhcmF0aW9uIGNvdWxkIG5vdCByZWZlciB0byBhIEZpZWxk
IFVuaXQuIEVyaWsgU2NobWF1c3MuPGJyPgo8YnI+CkRpc2Fzc2VtYmxlcjogSW1wcm92ZWQgc3Vw
cG9ydCBmb3IgdGhlIFN3aXRjaC9DYXNlIG9wZXJhdG9ycy4gVGhpcyBmZWF0dXJlIHdpbGwgZGlz
YXNzZW1ibGUgQU1MIGNvZGUgYmFjayB0byB0aGUgb3JpZ2luYWwgU3dpdGNoIG9wZXJhdG9ycyB3
aGVuIHBvc3NpYmxlLCBpbnN0ZWFkIG9mIGFuIElmLi5FbHNlIHNlcXVlbmNlLiBEYXZpZCBCb3g8
YnI+Cjxicj4KaUFTTCBhbmQgZGlzYXNzZW1ibGVyOiBJbXByb3ZlZCB0aGUgaGFuZGxpbmcgb2Yg
bXVsdGlwbGUgZXh0cmFuZW91cyBwYXJlbnRoZXNlcyBmb3IgYm90aCBBU0wgaW5wdXQgYW5kIGRp
c2Fzc2VtYmxlZCBBU0wgb3V0cHV0Ljxicj4KPGJyPgpJbXByb3ZlZCB0aGUgYmVoYXZpb3Igb2Yg
dGhlIGlBU0wgY29tcGlsZXIgYW5kIGRpc2Fzc2VtYmxlciB0byBkZXRlY3QgaW1wcm9wZXIgdXNl
IG9mIGV4dGVybmFsIGRlY2xhcmF0aW9uczxicj4KPGJyPgpEaXNhc3NlbWJsZXI6IE5vdyBhYm9y
dHMgaW1tZWRpYXRlbHkgdXBvbiBkZXRlY3Rpb24gb2YgYW4gdW5rbm93biBBTUwgb3Bjb2RlLiBU
aGUgQU1MIHBhcnNlciBoYXMgbm8gcmVhbCB3YXkgdG8gcmVjb3ZlciBmcm9tIHRoaXMsIGFuZCBj
YW4gcmVzdWx0IGluIHRoZSBjcmVhdGlvbiBvZiBhbiBpbGwtZm9ybWVkIHBhcnNlIHRyZWUgdGhh
dCBjYXVzZXMgZXJyb3JzIGxhdGVyIGR1cmluZyB0aGUgZGlzYXNzZW1ibHkuPGJyPgo8YnI+CkFs
bCB0b29sczogRml4ZWQgYSBwcm9ibGVtIHdoZXJlIHRoZSBVbml4IGFwcGxpY2F0aW9uIE9TTCBk
aWQgbm90IGhhbmRsZSBjb250cm9sLWMgY29ycmVjdGx5LiBGb3IgZXhhbXBsZSwgYSBjb250cm9s
LWMgY291bGQgaW5jb3JyZWN0bHkgd2FrZSB0aGUgZGVidWdnZXIuPGJyPgo8YnI+CkFjcGlFeGVj
OiBJbXByb3ZlZCB0aGUgQ29udHJvbC1DIGhhbmRsaW5nIGFuZCBhZGRlZCBhIGhhbmRsZXIgZm9y
IHNlZ21lbnRhdGlvbiBmYXVsdHMgKFNJR1NFR1YpLiBTdXBwb3J0cyBib3RoIFdpbmRvd3MgYW5k
IFVuaXgtbGlrZSBlbnZpcm9ubWVudHMuPGJyPgo8YnI+ClJlZHVjZWQgdGhlIHZlcmJvc2l0eSBv
ZiB0aGUgZ2VuZXJpYyB1bml4IG1ha2VmaWxlcy4gUHJldmlvdXNseSwgZWFjaCBjb21waWxhdGlv
biBkaXNwbGF5ZWQgdGhlIGZ1bGwgc2V0IG9mIGNvbXBpbGVyIG9wdGlvbnMuIFRoaXMgaGFzIGJl
ZW4gZWxpbWluYXRlZCBhcyB0aGUgb3B0aW9ucyBhcmUgZWFzaWx5IGluc3BlY3RlZCB3aXRoaW4g
dGhlIG1ha2VmaWxlcy4gRWFjaCBjb21waWxhdGlvbiBub3cgcmVzdWx0cyBpbiBhIHNpbmdsZSBs
aW5lIG9mIG91dHB1dC48YnI+Cjxicj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fPHdi
cj5fX19fX19fX19fX19fX19fXzxicj4KRGV2ZWwgbWFpbGluZyBsaXN0PGJyPgo8YSBocmVmPSJt
YWlsdG86RGV2ZWxAYWNwaWNhLm9yZyI+RGV2ZWxAYWNwaWNhLm9yZzwvYT48YnI+CjxhIGhyZWY9
Imh0dHBzOi8vbGlzdHMuYWNwaWNhLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RldmVsIiByZWw9Im5v
cmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL2xpc3RzLmFjcGljYS5vcmcvPHdicj5t
YWlsbWFuL2xpc3RpbmZvL2RldmVsPC9hPjxicj4KPC9ibG9ja3F1b3RlPjwvZGl2Pjxicj48L2Rp
dj4K

--===============2602177351585244428==--

