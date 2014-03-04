Content-Type: multipart/mixed; boundary="===============6478452621876652832=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH 2/4] ACPICA: Introduce new
 acpi_os_physical_table_add OS callback
Date: Tue, 04 Mar 2014 00:31:47 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88024BD46F@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 2330411.KHkNc5Vvtq@skinner
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6478452621876652832==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,  Thomas

> From: Thomas Renninger [mailto:trenn(a)suse.de]
> Sent: Monday, March 03, 2014 8:42 PM
> =

> Hi Lv,
> =

> On Monday, March 03, 2014 01:20:31 AM Zheng, Lv wrote:
> > Hi, Thomas
> >
> > I have a patch series that can cleanup the ACPICA table manager, and ch=
ange
> > the acpi_load_table into the following style:
> =

> Ok. I suggest that:
> 1) If Thomas (Gleixner) or whoever wants to try out or needs it urgently,=
 he
>    can (must) use a recent kernel with my patches applied.
> 2) You continue to get your changes into ACPICA.
>    Eventually or best would be if you add whatever is needed to
>    allow adding of tables as well (which will be there automatically if
>    I understood the description of your changes correctly).
> 3) Either you give it a try yourself or give me short description for
>    what I have to look out for and I can re-post the Linux patches
>    based on your ACPICA changes, once they show up in the Linux kernel.
>    Best give me a ping as soon as I should look at it.

That sounds good.

Or it can be more efficient for productions:
Linux can merge your patches and ACPICA just stop to take them.
This will leave us divergences.
After the table manager cleanups are tested and shipped in the ACPICA repo,=
 the new facilities will automatically be rolled into Linux branches.
Then I can help to reduce the divergences using the new ACPICA facilities.
At that time I may ask whoever that can test to offer help to review the cl=
eanup patch.

Thanks and best regards
-Lv

--===============6478452621876652832==--

