Content-Type: multipart/mixed; boundary="===============3577477534334800552=="
MIME-Version: 1.0
From: Rudolf Marek <r.marek at assembler.cz>
Subject: Re: [Devel] Linux getting compromised by the execution of ACPI code
Date: Sun, 31 Jul 2016 15:23:12 +0200
Message-ID: <371aa087-be78-c12a-c51c-a3f9f211b939@assembler.cz>
In-Reply-To: CAB=Lj3Qaaxu0NVNm7SzUfO3mAX3bb012wg57saaybJU9a92rtg@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3577477534334800552==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi David,

I checked the ACPI error messages and they are pretty harmless. I don't thi=
nk =

attacker would use the ACPI subsystem to plant the rootkit. I think the roo=
tkit =

might be hidden in the system management mode memory which is inaccessible =
by =

the operating system. Therefore I don't think this is good mailing list to =

discuss it but I hope no one will complain if I give you some hints to try:

1) physically exchange a BIOS chip - use some service which will send you a=
 BIOS =

chip replacement - they can even pre-load it with a factory BIOS

2) If you can't do that, and if the BIOS is socketed then use some external =

programmer to read out the BIOS, then go to the ASUS pages and download the=
 BIOS =

as a CAP file. The file usually has 2KB header which you can strip and then=
 you =

will get the 8MiB image which you can directly flash. Do not expect that th=
e =

backup image will match - BIOS contains some places with a variables/scratc=
h =

space so this won't help.

3) Check your malware detection procedure. I don't have the dropbox account=
 so I =

can't help much. All distributions have a way to check the integrity of =

installed packages, so you can use this mechanism to check if something has=
 been =

changed or not. (maybe the binary changed because of the update?)

4) I personally think that if you wold be a victim of such sophisticated ma=
lware =

which can infect any Linux/BSD then I would also think think that the malwa=
re =

would for sure prevent you to see the modified files.

Thanks all I can say to this, now go and try to find some other more approp=
riate =

mailing list (sorry no idea here), also I don't think I can personally help=
 any =

further

Thanks
Rudolf



--===============3577477534334800552==--

