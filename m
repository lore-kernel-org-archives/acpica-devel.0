Content-Type: multipart/mixed; boundary="===============9075436356072256806=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rjw at rjwysocki.net>
Subject: Re: [Devel] [PATCH 15/18] acpi: use ARRAY_SIZE
Date: Mon, 02 Oct 2017 14:27:52 +0200
Message-ID: <1668017.YFhvic4TWu@aspire.rjw.lan>
In-Reply-To: 20171001193101.8898-16-jeremy.lefaure@lse.epita.fr
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============9075436356072256806==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sunday, October 1, 2017 9:30:53 PM CEST J=C3=A9r=C3=A9my Lefaure wrote:
> Using the ARRAY_SIZE macro improves the readability of the code. It is
> useless to re-invent the ARRAY_SIZE macro so let's use it.
> =

> It is useless to re-invent the ARRAY_SIZE macro so let's use it.

ACPICA is soewhat special code, though and I'm not taking or ACKing patches
for it directly as a rule.

For one, I'm not sure if ACPICA can use ARRAY_SIZE at all.

Thanks,
Rafael


--===============9075436356072256806==--

