Content-Type: multipart/mixed; boundary="===============0180625186002618995=="
MIME-Version: 1.0
From: David Renz <efficient_language_learning at yahoo.com>
Subject: [Devel] ACPI tables of Lenovo G710
Date: Sun, 26 Jun 2016 12:42:07 +0000
Message-ID: <2003649968.2606620.1466944927207.JavaMail.yahoo@mail.yahoo.com>
In-Reply-To: 2003649968.2606620.1466944927207.JavaMail.yahoo.ref@mail.yahoo.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0180625186002618995==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

I'm the owner of a Lenovo G710, and after I saw a huge number of ACPI relat=
ed error messages in the Linux dmesg log, whose were also confirmed by runn=
ing Firmware Test Suite Live, I decided to do some research on this, which =
gave me a really strong impression:
I extracted the ACPI tables using Read&Write Everything (Windows) and submi=
tted them to malwar.com for getting them analyzed. Here you can see what th=
e running of the ACPI code on the malwr.com sandbox (Windows environment) d=
id, and which one normally wouldn't expect as I guess:


File changes:

https://malwr.com/analysis/ZmEyZTNhNzg1ZTg3NDBhM2I2OWEwYTFjM2FiYmVmOTM/#sum=
mary_files

Registry keys changed:
https://malwr.com/analysis/ZmEyZTNhNzg1ZTg3NDBhM2I2OWEwYTFjM2FiYmVmOTM/#sum=
mary_keys

Mutexes:
https://malwr.com/analysis/ZmEyZTNhNzg1ZTg3NDBhM2I2OWEwYTFjM2FiYmVmOTM/#sum=
mary_mutexes

Behaviorial analysis (particularly interesting):
https://malwr.com/analysis/ZmEyZTNhNzg1ZTg3NDBhM2I2OWEwYTFjM2FiYmVmOTM/#beh=
avior


What is even more unsettling is the fact that I found several sites related=
 to malware, when I searched for the registry keys, files or mutexes change=
d/created by that ACPI code:
http://www.lavasoft.com/mylavasoft/malware-descriptions/blog/BackdoorWin32F=
arflie1368ba67c
https://isc.sans.edu/forums/diary/Suspect+Sendori+software/16466/
https://isc.sans.edu/diary.html?date=3D2013-08-29


You can download the extracted ACPI tables from malwr.com after registering=
 there, but I also uploaded it on Google Drive and gave shared access to it:
https://drive.google.com/open?id=3D0B62Y5Qk_rdbWRFg1aDZPcEs4bTA


Now I would assume that those are not genuine ACPI tables by Lenovo. I have=
 a few questions in this regard:
1) Obviously I didn't flash my BIOS' ACPI tables with malicious code - So h=
ow can those be modified? Would it be possible that the computer's network =
adapter enters a so-called 'maintenance mode' by receiving packages contain=
ing certain 'magic numbers'? At least I've read in various sources that gen=
erally it would be possible to do that.
2) I'm not an expert about ACPI code at all (just knowing x86 assembly stuf=
f), but when looking at the disassembled ACPI tables (which I did using ias=
l under Linux) I could find no hint at all pointing to all those code actio=
ns which are being performed. I know that ACPI code is very obscure littera=
lly speaking, but is it possible to hide all this?
3) I downloaded a BIOS image using a secure method, flashed the BIOS while =
being offline and installed an OS right after rebooting - With no effect at=
 all, the ACPI code was still the same. Shouldn't the ACPI tables be overwr=
itten by flashing the BIOS? If that's not possible, then is it in fact impo=
ssible to get rid of this by any means?


Those are the GERM scan results, which don't look nice as well:
http://pastebin.com/A5J3pmpF

Like, "SSDT  ZwAcceptConnectPort  fffff80003135d20 \SystemRoot\system32\xNt=
Krnl.exe" sounds rather suspicious.


I guess that there is no chance to find out where those connections lead to=
, since my system seems to be modified on such a deep level - There's nothi=
ng suspicious being visible in Wireshark and Comodo doesn't give any alert =
as well. But still I'm deeply interested in what the origin of all this mig=
ht be - And since it seems like it all started with the ACPI code modifying=
 the OS, this information must logically be stored in the ACPI code as well=
. Would there be any chance to find out some information on this?


I would highly appreciate any thoughts, comments and advices. Maybe someone=
 having a Lenovo G710, too, could extract his ACPI tables, so that a compar=
ison could give some hints about what has been modified.



Finally, I also did some information gathering using the Volatility Tools u=
nder Linux, and it seems like this code might affect Linux as well, but I s=
till have to conduct further analysis in this regard to be sure that this i=
s not just a false alert. In any case I have the strong impression that thi=
s code demonstrates very high technical skills.


Kind regards and thanks in advance

David

--===============0180625186002618995==--

