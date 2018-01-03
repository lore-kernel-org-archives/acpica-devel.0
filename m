Content-Type: multipart/mixed; boundary="===============0490266685749670145=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: Re: [Devel] [PATCH v12 1/4] battery: Add the battery hooking API
Date: Wed, 03 Jan 2018 18:40:12 +0200
Message-ID: <CAHp75VceXVb2N7hyjoDhAq_M+=2VcDcPc+Jt-FSsWuW7D7eFww@mail.gmail.com>
In-Reply-To: 20180103145307.GA17694@thinkpad
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0490266685749670145==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2018 at 4:53 PM, Ognjen Gali=C4=87 <smclt30p(a)gmail.com> wr=
ote:
> On Wed, Jan 03, 2018 at 04:25:42PM +0200, Andy Shevchenko wrote:
>> On Wed, Jan 3, 2018 at 1:58 PM, Ognjen Galic <smclt30p(a)gmail.com> wrot=
e:

>> Thanks for an update. I have couple of minors. Otherwise look pretty muc=
h good!
>>
>> >  drivers/acpi/battery.h |  11 ----
>> >  include/acpi/battery.h |  21 +++++++
>>
>> There are -M and -C command line parameters to git format-patch.

>> They can take an optional argument (percentage) of threshold.
>>
>> Playing with those numbers you can achieve

^^^^ Pay attention to the above

>>
>> rename ...
>>
>> line and see actual diff.
>>
>> No need to resend because of this. Just an explanation for the future Gi=
t work.
>
> I did use thos options. I used the following command:
>
> git format-patch -M -C --notes -v12 -o ~/patches/. @^^^^
>
> I really don't know what you are targeting. :)

Please, read what I wrote above and the manual of git-format-patch.

>> > +void __battery_hook_unregister(struct acpi_battery_hook *hook, int lo=
ck)
>> > +{
>> > +       struct list_head *position;
>> > +       struct acpi_battery *battery;
>>
>> Missed empty line?
>
> checkpatch.pl complains if there are NOT empty lines between
> declarations and statements.

checkpatch some times on one hand complains about something which it
should not, on the other didn't take into consideration cases like
this one.

Your statement started with comment, btw.

>> > +       /*
>> > +        * In order to remove a hook, we first need to
>> > +        * de-register all the batteries that are registered.
>> > +        */
>> > +       if (lock)
>> > +               mutex_lock(&hook_mutex);

> I mean, it's not game-breaking, its just minor style stuff. I won't be
> sending more revisions because of these small issues, as I think its
> uneccessary to flood both Rafael and the mailing lists with patch
> revisions that remove or add a few spaces. No offence, it just got old.

Yes, his call anyway to apply or ask you for amendments. I'm just
helping with review.

>> > +static void __exit battery_hook_exit(void)
>> > +{
>> > +       struct acpi_battery_hook *hook;
>> > +       struct acpi_battery_hook *ptr;
>>
>> Missed empty line?
>
> See above about the checkpatch.pl stuff.

See above the answer.


-- =

With Best Regards,
Andy Shevchenko

--===============0490266685749670145==--

