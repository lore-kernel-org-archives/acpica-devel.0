Return-Path: <rjwysocki@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 197244264B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 04E8B42599
MIME-Version: 1.0
References: <20230523161815.3083-1-wyes.karny@amd.com>
 <168563860014.2889935.9236369807138013890.b4-ty@chromium.org>
In-Reply-To: <168563860014.2889935.9236369807138013890.b4-ty@chromium.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 1 Jun 2023 20:21:36 +0200
Message-ID: <CAJZ5v0jpZQ-kMikEPUvuESxX+OMVyx97zDxavs9WhTiyu7ZA1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Acpica-devel] [PATCH] acpi: Replace struct acpi_table_slit
	1-element array with flex-array
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, robert.moore@intel.com, linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, wyes.karny@amd.com, lenb@kernel.org

On Thu, Jun 1, 2023 at 6:57=E2=80=AFPM Kees Cook <keescook@chromium.org> wr=
ote:
>
> On Tue, 23 May 2023 16:18:15 +0000, Wyes Karny wrote:
> > struct acpi_table_slit is used for copying System Locality Information
> > Table data from ACPI tables. Here `entry` is a flex array but it was
> > using ancient 1-element fake flexible array, which has been deprecated.
> > Replace it with a C99 flexible array.
> >
> >
>
> Since this is a fix for -fstrict-flex-arrays=3D3, I can carry this in the
> hardening tree until it shows up in upstream ACPICA.
>
> Applied to for-next/hardening, thanks!
>
> [1/1] acpi: Replace struct acpi_table_slit 1-element array with flex-arra=
y
>       https://git.kernel.org/kees/c/0233ca593eba

Works for me, thanks!
