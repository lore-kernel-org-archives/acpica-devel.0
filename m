Content-Type: multipart/mixed; boundary="===============4650584840226517007=="
MIME-Version: 1.0
From: Sudeep Holla <sudeep.holla at arm.com>
Subject: [Devel] Re: [PATCH] ACPICA: add missing macro ACPI_FUNCTION_TRACE()
 for ns_repair_HID()
Date: Tue, 25 Oct 2022 13:38:46 +0100
Message-ID: <20221025123846.o6ufodigshvyqhqj@bogus>
In-Reply-To: 20221025113643.79743-1-wangxiongfeng2@huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4650584840226517007==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Xiongfeng,

On Tue, Oct 25, 2022 at 07:36:43PM +0800, Xiongfeng Wang wrote:
> The following commit add function tracing macros for the namespace repair
> mechanism.
> =

>   commit 0766efdf9a9d24eaefe260c787f49af225018b16
>   ACPICA: Add function trace macros to improve debugging
> =

> But it missed the trace macro for the entry of ns_repair_HID(). Let's
> add it.
>

Generally all ACPICA changes need to be submitted to the upstream project
via GitHub at https://github.com/acpica/acpica. It will be imported to the
Linux project from there.

-- =

Regards,
Sudeep
--===============4650584840226517007==--

