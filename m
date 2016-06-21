Content-Type: multipart/mixed; boundary="===============6645476106344746604=="
MIME-Version: 1.0
From: Jo <j.o.l at live.com>
Subject: [Devel] Suspend to RAM when not supported by BIOS?
Date: Tue, 21 Jun 2016 22:51:46 +0200
Message-ID: <BAY405-EAS16572C097033C68C788C93CA2B0@phx.gbl>
In-Reply-To: BAY405-EAS29574ADAD627D87553A9CC3CA280@phx.gbl
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6645476106344746604==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,
not sure whether this is the best place to ask the question, feel free to
provide any pointer you consider adequate.
I am using two Dell T20, one with Windows Server 2008 R2, the other with
Linux (I tried both CentOS 7.x and Ubuntu 16.04). According to the technical
manual, the Dell T20 does not officially support Suspend-To-RAM. However the
initial installation of the Windows Server was performed on a different
system that was able to suspend and then I moved the entire installation to
the T20, and it continues to suspend properly despite the technical manual.
And I really like suspend as the system is up within seconds when needed.
And in more than a year I never experienced any crash or incident that I
would associate with the "hack".
I tried both clean installs of Windows and Linux on the other T20, but
always the installations claim suspend is not supported - in line with the
official support statement. Now I am wondering how I can trick Linux into
supporting suspend despite the BIOS telling it is not supported. Is there a
configuration option to override the information the BIOS provides? I read
about OSDT, however I have no clue about how to leverage that with Linux. =

And for sure I understand this is on my own risk..
Thanks & Best Regards, Joachim


--===============6645476106344746604==--

