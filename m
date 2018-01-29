Content-Type: multipart/mixed; boundary="===============8731050721376487883=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [PATCH v3 5/5] ACPICA: Remove calling of _STA from
 acpi_get_object_info
Date: Mon, 29 Jan 2018 04:07:30 +0100
Message-ID: <CAJZ5v0gDLrDtgFKo5mUBuGWfAmv_3n1HEUTjnE3J8DSrRUbTCQ@mail.gmail.com>
In-Reply-To: 08f2a8aa-1510-3b78-4fa7-bf0ae194ccb0@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8731050721376487883==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 27, 2018 at 3:02 PM, Hans de Goede <hdegoede(a)redhat.com> wrot=
e:
> Hi,
>
> On 26-01-18 21:42, Moore, Robert wrote:
>>
>> For ACPICA, this is a change to a published public interface. A change to
>> this will potentially affect many operating systems, so we would be very
>> hesitant to change it in the core ACPICA code.
>
>
> From the acpi_get_object_info() documentation in
> drivers/acpi/acpica/nsxfname.c:
>
>  * Note: This interface is intended to be used during the initial device
>  * discovery namespace traversal. Therefore, no complex methods can be
>  * executed, especially those that access operation regions.
>
> Since _STA can call Opregions, IMHO it does not belong in
> acpi_get_object_info()
> and as Erik mentioned _STA can have side-effects then that seems like
> another
> reason to NOT call it from acpi_get_object_info().
>
> But I can understand that you don't want to outright change the behavior =
of
> acpi_get_object_info() to call _STA since it has always done this, still
> calling _STA can be a problem in some cases.
>
> Perhaps we can give acpi_get_object_info() a flags argument, or if you wa=
nt
> to
> preserve the current interface ad a new acpi_get_object_info_no_sta() call
> (and
> use flags under the hood so that we still have only 1 implementation) ?

Let's first get the [1-4/5] from this series in (as the last patch
depends on them AFAICS) and then we'll see.

Thanks,
Rafael

--===============8731050721376487883==--

