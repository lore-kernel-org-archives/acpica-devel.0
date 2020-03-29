Content-Type: multipart/mixed; boundary="===============5014075728009623503=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rjw at rjwysocki.net>
Subject: [Devel] Re: [pm:bleeding-edge] BUILD REGRESSION
 b50a778aa5b714166355ef7f4a1992e4073393fc
Date: Sun, 29 Mar 2020 16:08:04 +0200
Message-ID: <3863805.FxIobF6Dnx@kreacher>
In-Reply-To: 5e7fb83b.mzs1XRDjQiEqx806%lkp@intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5014075728009623503==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Saturday, March 28, 2020 9:48:59 PM CEST kbuild test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux=
-pm.git  bleeding-edge
> branch HEAD: b50a778aa5b714166355ef7f4a1992e4073393fc  Merge branch 'acpi=
ca-next' into bleeding-edge
> =

> Regressions in current branch:
> =

> drivers/acpi/acpica/dswload2.c:476:3: warning: syntax error [syntaxError]
> =

> Error ids grouped by kconfigs:
> =

> recent_errors
> `-- x86_64-allyesconfig
>     `-- drivers-acpi-acpica-dswload2.c:warning:syntax-error-syntaxError

This looks like a script went south.

It should be fixed in my tree now.



--===============5014075728009623503==--

