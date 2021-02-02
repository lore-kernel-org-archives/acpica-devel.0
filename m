Content-Type: multipart/mixed; boundary="===============0752881003684848427=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH v2 2/7] acpi: utils: Add function to fetch
 dependent acpi_devices
Date: Tue, 02 Feb 2021 15:02:39 +0100
Message-ID: <CAJZ5v0j7U=e+GHLqpivqfvOKCyCZWm4VK3___4tTfcxD==vcHA@mail.gmail.com>
In-Reply-To: d9ec0439-4323-51a2-70e7-c258fe63cd86@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0752881003684848427==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 2, 2021 at 10:58 AM Daniel Scally <djrscally(a)gmail.com> wrote:
>
> Hi Rafael
>
> On 21/01/2021 21:06, Daniel Scally wrote:
> >
> > On 21/01/2021 18:08, Rafael J. Wysocki wrote:
> >> On Thu, Jan 21, 2021 at 5:34 PM Daniel Scally <djrscally(a)gmail.com> =
wrote:
> >>>
> >>> On 21/01/2021 14:39, Rafael J. Wysocki wrote:
> >>>> On Thu, Jan 21, 2021 at 1:04 PM Daniel Scally <djrscally(a)gmail.com=
> wrote:
> >>>>> On 21/01/2021 11:58, Rafael J. Wysocki wrote:
> >>>>>> On Thu, Jan 21, 2021 at 10:47 AM Daniel Scally <djrscally(a)gmail.=
com> wrote:
> >>>>>>> Hi Rafael
> >>>>>>>
> >>>>>>> On 19/01/2021 13:15, Rafael J. Wysocki wrote:
> >>>>>>>> On Mon, Jan 18, 2021 at 9:51 PM Daniel Scally <djrscally(a)gmail=
.com> wrote:
> >>>>>>>>> On 18/01/2021 16:14, Rafael J. Wysocki wrote:
> >>>>>>>>>> On Mon, Jan 18, 2021 at 1:37 AM Daniel Scally <djrscally(a)gma=
il.com> wrote:
> >>>>>>>>>>> In some ACPI tables we encounter, devices use the _DEP method=
 to assert
> >>>>>>>>>>> a dependence on other ACPI devices as opposed to the OpRegion=
s that the
> >>>>>>>>>>> specification intends. We need to be able to find those devic=
es "from"
> >>>>>>>>>>> the dependee, so add a function to parse all ACPI Devices and=
 check if
> >>>>>>>>>>> the include the handle of the dependee device in their _DEP b=
uffer.
> >>>>>>>>>> What exactly do you need this for?
> >>>>>>>>> So, in our DSDT we have devices with _HID INT3472, plus sensors=
 which
> >>>>>>>>> refer to those INT3472's in their _DEP method. The driver binds=
 to the
> >>>>>>>>> INT3472 device, we need to find the sensors dependent on them.
> >>>>>>>>>
> >>>>>>>> Well, this is an interesting concept. :-)
> >>>>>>>>
> >>>>>>>> Why does _DEP need to be used for that?  Isn't there any other w=
ay to
> >>>>>>>> look up the dependent sensors?
> >>>>>>>>
> >>>>>>>>>> Would it be practical to look up the suppliers in acpi_dep_lis=
t instead?
> >>>>>>>>>>
> >>>>>>>>>> Note that supplier drivers may remove entries from there, but =
does
> >>>>>>>>>> that matter for your use case?
> >>>>>>>>> Ah - that may work, yes. Thank you, let me test that.
> >>>>>>>> Even if that doesn't work right away, but it can be made work, I=
 would
> >>>>>>>> very much prefer that to the driver parsing _DEP for every devic=
e in
> >>>>>>>> the namespace by itself.
> >>>>>>> This does work; do you prefer it in scan.c, or in utils.c (in whi=
ch case
> >>>>>>> with acpi_dep_list declared as external var in internal.h)?
> >>>>>> Let's put it in scan.c for now, because there is the lock protecti=
ng
> >>>>>> the list in there too.
> >>>>>>
> >>>>>> How do you want to implement this?  Something like "walk the list =
and
> >>>>>> run a callback for the matching entries" or do you have something =
else
> >>>>>> in mind?
> >>>>> Something like this (though with a mutex_lock()). It could be simpl=
ified
> >>>>> by dropping the prev stuff, but we have seen INT3472 devices with
> >>>>> multiple sensors declaring themselves dependent on the same device
> >>>>>
> >>>>>
> >>>>> struct acpi_device *
> >>>>> acpi_dev_get_next_dependent_dev(struct acpi_device *supplier,
> >>>>>                 struct acpi_device *prev)
> >>>>> {
> >>>>>     struct acpi_dep_data *dep;
> >>>>>     struct acpi_device *adev;
> >>>>>     int ret;
> >>>>>
> >>>>>     if (!supplier)
> >>>>>         return ERR_PTR(-EINVAL);
> >>>>>
> >>>>>     if (prev) {
> >>>>>         /*
> >>>>>          * We need to find the previous device in the list, so we k=
now
> >>>>>          * where to start iterating from.
> >>>>>          */
> >>>>>         list_for_each_entry(dep, &acpi_dep_list, node)
> >>>>>             if (dep->consumer =3D=3D prev->handle &&
> >>>>>                 dep->supplier =3D=3D supplier->handle)
> >>>>>                 break;
> >>>>>
> >>>>>         dep =3D list_next_entry(dep, node);
> >>>>>     } else {
> >>>>>         dep =3D list_first_entry(&acpi_dep_list, struct acpi_dep_da=
ta,
> >>>>>                        node);
> >>>>>     }
> >>>>>
> >>>>>
> >>>>>     list_for_each_entry_from(dep, &acpi_dep_list, node) {
> >>>>>         if (dep->supplier =3D=3D supplier->handle) {
> >>>>>             ret =3D acpi_bus_get_device(dep->consumer, &adev);
> >>>>>             if (ret)
> >>>>>                 return ERR_PTR(ret);
> >>>>>
> >>>>>             return adev;
> >>>>>         }
> >>>>>     }
> >>>>>
> >>>>>     return NULL;
> >>>>> }
> >>>> That would work I think, but would it be practical to modify
> >>>> acpi_walk_dep_device_list() so that it runs a callback for every
> >>>> consumer found instead of or in addition to the "delete from the list
> >>>> and free the entry" operation?
> >>>
> >>> I think that this would work fine, if that's the way you want to go.
> >>> We'd just need to move everything inside the if (dep->supplier =3D=3D
> >>> handle) block to a new callback, and for my purposes I think also add=
 a
> >>> way to stop parsing the list from the callback (so like have the
> >>> callbacks return int and stop parsing on a non-zero return). Do you w=
ant
> >>> to expose that ability to pass a callback outside of ACPI?
> >> Yes.
> >>
> >>> Or just export helpers to call each of the callbacks (one to fetch th=
e next
> >>> dependent device, one to decrement the unmet dependencies counter)
> >> If you can run a callback for every matching entry, you don't really
> >> need to have a callback to return the next matching entry.  You can do
> >> stuff for all of them in one go
> >
> > Well it my case it's more to return a pointer to the dep->consumer's
> > acpi_device for a matching entry, so my idea was where there's multiple
> > dependents you could use this as an iterator...but it could just be
> > extended to that if needed later; I don't actually need to do it right =
now.
> >
> >
> >> note that it probably is not a good
> >> idea to run the callback under the lock, so the for loop currently in
> >> there is not really suitable for that
> >
> > No problem;  I'll tweak that then
>
> Slightly walking back my "No problem" here; as I understand this there's
> kinda two options:
>
> 1. Walk over the (locked) list, when a match is found unlock, run the
> callback and re-lock.

That's what I was thinking about.

> The problem with that idea is unless I'm mistaken there's no guarantee
> that the .next pointer is still valid then (even using the *_safe()
> methods) because either the next or the next + 1 entry could have been
> removed whilst the list was unlocked and the callback was being ran, so
> this seems a little unsafe.

This can be addressed by rotating the list while walking it, but that
becomes problematic if there are concurrent walkers.

OK, I guess running the callback under the lock is not really a big
deal (and for the deletion case this is actually necessary), so let's
do that.
--===============0752881003684848427==--

