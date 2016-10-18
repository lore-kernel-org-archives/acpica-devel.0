Content-Type: multipart/mixed; boundary="===============4170548343870114043=="
MIME-Version: 1.0
From: Hanjun Guo <hanjun.guo at linaro.org>
Subject: Re: [Devel] [PATCH V3 05/10] acpi: apei: handle SEA notification type
 for ARMv8
Date: Tue, 18 Oct 2016 12:44:49 +0000
Message-ID: <496ddac3-a220-fd42-5ca1-3d0fb0238907@linaro.org>
In-Reply-To: 1475875882-2604-6-git-send-email-tbaicar@codeaurora.org
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4170548343870114043==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tyler,

On 2016/10/8 5:31, Tyler Baicar wrote:
> ARM APEI extension proposal added SEA (Synchrounous External
> Abort) notification type for ARMv8.
> Add a new GHES error source handling function for SEA. If an error
> source's notification type is SEA, then this function can be registered
> into the SEA exception handler. That way GHES will parse and report
> SEA exceptions when they occur.

Does this SEA is replayed by the firmware (firmware first handling)
or directly triggered by the hardware when error is happened?

Thanks
Hanjun

--===============4170548343870114043==--

