Return-Path: <rjwysocki@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 29CD7821F4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DC1D5820C5
MIME-Version: 1.0
References: <20230601131719.300720-1-michal.wilczynski@intel.com>
 <4500594.LvFx2qVVIh@kreacher> <eb5ed997-201a-ffc4-6181-b2f8a6d451a8@intel.com>
In-Reply-To: <eb5ed997-201a-ffc4-6181-b2f8a6d451a8@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 5 Jun 2023 17:17:17 +0200
Message-ID: <CAJZ5v0hWKUbX0vdp09uD2-QNH611S4gZEirnQtj78oXiQ2YJQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Acpica-devel] [PATCH v4 01/35] acpi: Adjust functions
	installing bus event handlers
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
To: "Wilczynski, Michal" <michal.wilczynski@intel.com>
Cc: nvdimm@lists.linux.dev, Jason@zx2c4.com, productdev@system76.com, cascardo@holoscopio.com, coproscefalo@gmail.com, malattia@linux.it, acpica-devel@lists.linuxfoundation.org, ira.weiny@intel.com, dan.j.williams@intel.com, chrome-platform@lists.linux.dev, lars@metafoo.de, dave.jiang@intel.com, yu.c.chen@intel.com, vishal.l.verma@intel.com, robert.moore@intel.com, linux-acpi@vger.kernel.org, rui.zhang@intel.com, herton@canonical.com, linux@roeck-us.net, lenb@kernel.org, jdelvare@suse.com, kenneth.t.chan@gmail.com, acpi4asus-user@lists.sourceforge.net, matan@svgalib.org, markgross@kernel.org, hdegoede@redhat.com, jwoithe@just42.net, jeremy@system76.com, don@syst.com.br, platform-driver-x86@vger.kernel.org, bleung@chromium.org, linux-hwmon@vger.kernel.org, tytso@mit.edu, pali@kernel.org, jprvita@gmail.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-iio@vger.kernel.org, corentin.chary@gmail.com, luzmaximilian@gmail.com, jic23@kernel.org

On Mon, Jun 5, 2023 at 10:44=E2=80=AFAM Wilczynski, Michal
<michal.wilczynski@intel.com> wrote:
>
> On 6/2/2023 8:34 PM, Rafael J. Wysocki wrote:
> > On Thursday, June 1, 2023 3:17:19 PM CEST Michal Wilczynski wrote:
> >> Currently acpi_device_install_notify_handler() and
> >> acpi_device_remove_notify_handler() always install acpi_notify_device(=
)
> >> as a function handler, and only then the real .notify callback gets
> >> called. This is not efficient and doesn't provide any real advantage.
> >>
> >> Introduce new acpi_device_install_event_handler() and
> >> acpi_device_remove_event_handler(). Those functions are replacing old
> >> installers, and after all drivers switch to the new model, old install=
ers
> >> will be removed at the end of the patchset.
> >>
> >> Make new installer/removal function arguments to take function pointer=
 as
> >> an argument instead of using .notify callback. Introduce new variable =
in
> >> struct acpi_device, as fixed events still needs to be handled by an
> >> intermediary that would schedule them for later execution. This is due=
 to
> >> fixed hardware event handlers being executed in interrupt context.
> >>
> >> Make acpi_device_install_event_handler() and
> >> acpi_device_remove_event_handler() non-static, and export symbols. Thi=
s
> >> will allow the drivers to call them directly, instead of relying on
> >> .notify callback.
> >>
> >> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> >> ---
> >>  drivers/acpi/bus.c      | 59 ++++++++++++++++++++++++++++++++++++++++=
-
> >>  include/acpi/acpi_bus.h |  7 +++++
> >>  2 files changed, 65 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> >> index d161ff707de4..cf2c2bfe29a0 100644
> >> --- a/drivers/acpi/bus.c
> >> +++ b/drivers/acpi/bus.c
> >> @@ -535,7 +535,7 @@ static void acpi_notify_device_fixed(void *data)
> >>      struct acpi_device *device =3D data;
> >>
> >>      /* Fixed hardware devices have no handles */
> >> -    acpi_notify_device(NULL, ACPI_FIXED_HARDWARE_EVENT, device);
> >> +    device->fixed_event_notify(NULL, ACPI_FIXED_HARDWARE_EVENT, devic=
e);
> >>  }
> >>
> >>  static u32 acpi_device_fixed_event(void *data)
> >> @@ -550,11 +550,13 @@ static int acpi_device_install_notify_handler(st=
ruct acpi_device *device,
> >>      acpi_status status;
> >>
> >>      if (device->device_type =3D=3D ACPI_BUS_TYPE_POWER_BUTTON) {
> >> +            device->fixed_event_notify =3D acpi_notify_device;
> >>              status =3D
> >>                  acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUT=
TON,
> >>                                                   acpi_device_fixed_ev=
ent,
> >>                                                   device);
> >>      } else if (device->device_type =3D=3D ACPI_BUS_TYPE_SLEEP_BUTTON)=
 {
> >> +            device->fixed_event_notify =3D acpi_notify_device;
> >>              status =3D
> >>                  acpi_install_fixed_event_handler(ACPI_EVENT_SLEEP_BUT=
TON,
> >>                                                   acpi_device_fixed_ev=
ent,
> >> @@ -579,9 +581,11 @@ static void acpi_device_remove_notify_handler(str=
uct acpi_device *device,
> >>      if (device->device_type =3D=3D ACPI_BUS_TYPE_POWER_BUTTON) {
> >>              acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
> >>                                              acpi_device_fixed_event);
> >> +            device->fixed_event_notify =3D NULL;
> >>      } else if (device->device_type =3D=3D ACPI_BUS_TYPE_SLEEP_BUTTON)=
 {
> >>              acpi_remove_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
> >>                                              acpi_device_fixed_event);
> >> +            device->fixed_event_notify =3D NULL;
> >>      } else {
> >>              u32 type =3D acpi_drv->flags & ACPI_DRIVER_ALL_NOTIFY_EVE=
NTS ?
> >>                              ACPI_ALL_NOTIFY : ACPI_DEVICE_NOTIFY;
> >> @@ -592,6 +596,59 @@ static void acpi_device_remove_notify_handler(str=
uct acpi_device *device,
> >>      acpi_os_wait_events_complete();
> >>  }
> >>
> >> +int acpi_device_install_event_handler(struct acpi_device *device,
> >> +                                  u32 type,
> >> +                                  void (*notify)(acpi_handle, u32, vo=
id*))
> >> +{
> >> +    acpi_status status;
> >> +
> >> +    if (!notify)
> >> +            return -EINVAL;
> >> +
> >> +    if (device->device_type =3D=3D ACPI_BUS_TYPE_POWER_BUTTON) {
> >> +            device->fixed_event_notify =3D notify;
> >> +            status =3D
> >> +                acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUT=
TON,
> >> +                                                 acpi_device_fixed_ev=
ent,
> >> +                                                 device);
> >> +    } else if (device->device_type =3D=3D ACPI_BUS_TYPE_SLEEP_BUTTON)=
 {
> >> +            device->fixed_event_notify =3D notify;
> >> +            status =3D
> >> +                acpi_install_fixed_event_handler(ACPI_EVENT_SLEEP_BUT=
TON,
> >> +                                                 acpi_device_fixed_ev=
ent,
> >> +                                                 device);
> >> +    } else {
> >> +            status =3D acpi_install_notify_handler(device->handle, ty=
pe,
> >> +                                                 notify,
> >> +                                                 device);
> >> +    }
> >> +
> >> +    if (ACPI_FAILURE(status))
> >> +            return -EINVAL;
> >> +    return 0;
> >> +}
> >> +EXPORT_SYMBOL(acpi_device_install_event_handler);
> >> +
> >> +void acpi_device_remove_event_handler(struct acpi_device *device,
> >> +                                  u32 type,
> >> +                                  void (*notify)(acpi_handle, u32, vo=
id*))
> >> +{
> >> +    if (device->device_type =3D=3D ACPI_BUS_TYPE_POWER_BUTTON) {
> >> +            acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
> >> +                                            acpi_device_fixed_event);
> >> +            device->fixed_event_notify =3D NULL;
> >> +    } else if (device->device_type =3D=3D ACPI_BUS_TYPE_SLEEP_BUTTON)=
 {
> >> +            acpi_remove_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
> >> +                                            acpi_device_fixed_event);
> >> +            device->fixed_event_notify =3D NULL;
> >> +    } else {
> >> +            acpi_remove_notify_handler(device->handle, type,
> >> +                                       notify);
> >> +    }
> >> +    acpi_os_wait_events_complete();
> >> +}
> >> +EXPORT_SYMBOL(acpi_device_remove_event_handler);
> >> +
> >>  /* Handle events targeting \_SB device (at present only graceful shut=
down) */
> >>
> >>  #define ACPI_SB_NOTIFY_SHUTDOWN_REQUEST 0x81
> >> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> >> index a6affc0550b0..7fb411438b6f 100644
> >> --- a/include/acpi/acpi_bus.h
> >> +++ b/include/acpi/acpi_bus.h
> >> @@ -387,6 +387,7 @@ struct acpi_device {
> >>      struct list_head physical_node_list;
> >>      struct mutex physical_node_lock;
> >>      void (*remove)(struct acpi_device *);
> >> +    void (*fixed_event_notify)(acpi_handle handle, u32 type, void *da=
ta);
>
>
> Hi,
> Thank for you review,
>
> > This is a rather confusing change, because ->remove() above is not a dr=
iver
> > callback, whereas the new one would be.
> >
> > Moreover, it is rather wasteful, because the only devices needing it ar=
e
> > buttons, so for all of the other ACPI device objects the new callback p=
ointer
> > would always be NULL.
> >
> > Finally, it is not necessary even.
>
> I was thinking about resolving this somehow in compile-time, but I guess =
was a bit
> afraid of refactoring too much code - didn't want to break anything.
>
> >
> > The key observation here is that there are only 2 drivers handling powe=
r and
> > sleep buttons that use ACPI fixed events: the ACPI button driver (butto=
n.c in
> > drivers/acpi) and the "tiny power button" driver (tiny-power-button.c i=
n
> > drivers/acpi).  All of the other drivers don't need the "fixed event no=
tify"
> > thing and these two can be modified to take care of all of it by themse=
lves.
> >
> > So if something like the below is done prior to the rest of your series=
, the
> > rest will be about acpi_install/remove_notify_handler() only and you wo=
n't
> > even need the wrapper routines any more: driver may just be switched ov=
er
> > to using the ACPICA functions directly.
>
> Sure, will get your patch, apply it before my series and fix individual d=
rivers to use acpica
> functions directly.

I have posted this series which replaces it  in the meantime:
https://lore.kernel.org/linux-acpi/1847933.atdPhlSkOF@kreacher

Moreover, I think that there's still a reason to use the wrappers.

Namely, the unregistration part needs to call
acpi_os_wait_events_complete() after the notify handler has been
unregistered and it's better to avoid code duplication related to
that.

Also the registration wrapper can be something like:

int acpi_dev_install_notify_handler(struct acpi_device *adev,
acpi_notify_handler handler, u32 handler_type)
{
    if (ACPI_FAILURE(acpi_install_notify_handler(adev->handle,
handler_type, handler, adev)))
        return -ENODEV;

    return 0;
}

which would be simpler to use than the "raw"
acpi_install_notify_handler() and using it would avoid a tiny bit of
code duplication IMV.
