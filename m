Content-Type: multipart/mixed; boundary="===============0397964950187177146=="
MIME-Version: 1.0
From: gengdongjiu <gengdongjiu at huawei.com>
Subject: Re: [Devel] [PATCH v5 1/2] acpi: apei: remove the unused dead-code
 for SEA/NMI notification type
Date: Wed, 18 Oct 2017 20:27:00 +0800
Message-ID: <577d79ad-9357-ea40-63eb-1d2988642710@huawei.com>
In-Reply-To: 20171018101722.kce2tcvpd7xdpo46@pd.tnic
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0397964950187177146==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On 2017/10/18 18:17, Borislav Petkov wrote:
> On Wed, Oct 18, 2017 at 11:04:28AM +0800, gengdongjiu wrote:
>> ARM does not have ACPI_HEST_NOTIFY_NMI notification, which should only
>> used by x86. In the code, I see those guards are never used.
> Yeah, I see it now.

Borislav/Rafael,
  For this patch(the first one), whether it can be firstly applied?
This patch is code clean and not related with the second one.
For the second, I may discuss more with James.
Thanks so much in advance.

> =

> Thx.
> =

> -- =



--===============0397964950187177146==--

