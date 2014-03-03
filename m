Content-Type: multipart/mixed; boundary="===============5164102355400737801=="
MIME-Version: 1.0
From: Thomas Renninger <trenn at suse.de>
Subject: Re: [Devel] [PATCH 2/4] ACPICA: Introduce new
 acpi_os_physical_table_add OS callback
Date: Mon, 03 Mar 2014 12:41:24 +0000
Message-ID: <2330411.KHkNc5Vvtq@skinner>
In-Reply-To: 1AE640813FDE7649BE1B193DEA596E88024BB021@SHSMSX101.ccr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5164102355400737801==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lv,

On Monday, March 03, 2014 01:20:31 AM Zheng, Lv wrote:
> Hi, Thomas
> =

> I have a patch series that can cleanup the ACPICA table manager, and chan=
ge
> the acpi_load_table into the following style:

Ok. I suggest that:
1) If Thomas (Gleixner) or whoever wants to try out or needs it urgently, he
   can (must) use a recent kernel with my patches applied.
2) You continue to get your changes into ACPICA.
   Eventually or best would be if you add whatever is needed to
   allow adding of tables as well (which will be there automatically if
   I understood the description of your changes correctly).
3) Either you give it a try yourself or give me short description for =

   what I have to look out for and I can re-post the Linux patches
   based on your ACPICA changes, once they show up in the Linux kernel.
   Best give me a ping as soon as I should look at it.

Thanks!

  Thomas

PS: You might want to add the BGRT definition in ACPICA already, the
    tiny one line-liner...

--===============5164102355400737801==--

