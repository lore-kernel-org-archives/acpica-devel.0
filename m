Content-Type: multipart/mixed; boundary="===============5292381099705653006=="
MIME-Version: 1.0
From: =?utf-8?q?R=C3=BCdiger_Ihle_=3Cr=2Eihle_at_s-t=2Ede=3E?=
Subject: [Devel] AcpiOsReadPciConfiguration
Date: Fri, 16 Jul 2010 07:47:09 +0200
Message-ID: <4C3FF25D.3050008@s-t.de>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5292381099705653006==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,


what's the correct prototype for AcpiOsReadPciConfiguration ?

The acpica-reference.pdf says:

AcpiOsReadPciConfiguration (
    ACPI_PCI_ID             *PciId,
    UINT32                  Reg,
    UINT64                  *Value,
    UINT32                  Width);


while acpiosxf.h states:


AcpiOsReadPciConfiguration (
    ACPI_PCI_ID             *PciId,
    UINT32                  Reg,
    void                    *Value,
    UINT32                  Width);



-- =


Mit freundlichem Gruss / Kind regards

Dipl.-Ing. R=C3=BCdiger Ihle

 _____________________________________________________________
 S&T Systemtechnik GmbH           fon: +49 36 77 / 666 777
 Gabelsbergerstr. Nr. 9           fax: +49 36 77 / 666 799
 D-98693 Ilmenau                email: r.ihle(a)s-t.de
                                  web: http://www.s-t.de
 HRB: 302033
 Registergericht: Jena
 Gesch=C3=A4ftsf=C3=BChrer: Steffen Beyer
 _____________________________________________________________



--===============5292381099705653006==--

