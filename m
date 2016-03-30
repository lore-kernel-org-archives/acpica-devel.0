Content-Type: multipart/mixed; boundary="===============5349463641172337611=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: fix Thunderbolt hotplug
Date: Wed, 30 Mar 2016 21:10:22 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E456D1F@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 1459291086-8634-1-git-send-email-prarit@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5349463641172337611==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch looks familiar, we may have it fixed already.

Lv should know.
Bob

> =

> Cc: Robert Moore <robert.moore(a)intel.com>
> Cc: Lv Zheng <lv.zheng(a)intel.com>
> Signed-off-by: Prarit Bhargava <prarit(a)redhat.com>
> ---
>  source/components/dispatcher/dsmethod.c |    3 +++
>  1 file changed, 3 insertions(+)
> =

> diff --git a/source/components/dispatcher/dsmethod.c
> b/source/components/dispatcher/dsmethod.c
> index a861838..ceb6c75 100644
> --- a/source/components/dispatcher/dsmethod.c
> +++ b/source/components/dispatcher/dsmethod.c
> @@ -532,6 +532,9 @@ AcpiDsBeginMethodExecution (
>              {
>                  ObjDesc->Method.Mutex->Mutex.OriginalSyncLevel =3D
>                      ObjDesc->Method.Mutex->Mutex.SyncLevel;
> +
> +                ObjDesc->Method.Mutex->Mutex.ThreadId =3D
> +                    AcpiOsGetThreadId();
>              }
>          }
> =

> --
> 1.7.9.3


--===============5349463641172337611==--

