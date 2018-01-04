Content-Type: multipart/mixed; boundary="===============6691207639314211125=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [PATCH v12 1/4] battery: Add the battery hooking API
Date: Thu, 04 Jan 2018 13:35:55 +0100
Message-ID: <CAJZ5v0jz1++NKBfULtOrnYEYEkhHD-zZkreCmGy8vchbtLF4AA@mail.gmail.com>
In-Reply-To: 20180104111313.GA12286@thinkpad
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6691207639314211125==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2018 at 12:13 PM, Ognjen Gali=C4=87 <smclt30p(a)gmail.com> w=
rote:
> On Wed, Jan 03, 2018 at 06:40:12PM +0200, Andy Shevchenko wrote:
>> On Wed, Jan 3, 2018 at 4:53 PM, Ognjen Gali=C4=87 <smclt30p(a)gmail.com>=
 wrote:
>> > On Wed, Jan 03, 2018 at 04:25:42PM +0200, Andy Shevchenko wrote:
>> >> On Wed, Jan 3, 2018 at 1:58 PM, Ognjen Galic <smclt30p(a)gmail.com> w=
rote:
>>
>> >> Thanks for an update. I have couple of minors. Otherwise look pretty =
much good!
>> >>
>> >> >  drivers/acpi/battery.h |  11 ----
>> >> >  include/acpi/battery.h |  21 +++++++
>> >>
>> >> There are -M and -C command line parameters to git format-patch.
>>
>> >> They can take an optional argument (percentage) of threshold.
>> >>
>> >> Playing with those numbers you can achieve
>>
>> ^^^^ Pay attention to the above
>>
>> >>
>> >> rename ...
>> >>
>> >> line and see actual diff.
>> >>
>> >> No need to resend because of this. Just an explanation for the future=
 Git work.
>> >
>> > I did use thos options. I used the following command:
>> >
>> > git format-patch -M -C --notes -v12 -o ~/patches/. @^^^^
>> >
>> > I really don't know what you are targeting. :)
>>
>> Please, read what I wrote above and the manual of git-format-patch.
>>
>> >> > +void __battery_hook_unregister(struct acpi_battery_hook *hook, int=
 lock)
>> >> > +{
>> >> > +       struct list_head *position;
>> >> > +       struct acpi_battery *battery;
>> >>
>> >> Missed empty line?
>> >
>> > checkpatch.pl complains if there are NOT empty lines between
>> > declarations and statements.
>>
>> checkpatch some times on one hand complains about something which it
>> should not, on the other didn't take into consideration cases like
>> this one.
>>
>> Your statement started with comment, btw.
>>
>> >> > +       /*
>> >> > +        * In order to remove a hook, we first need to
>> >> > +        * de-register all the batteries that are registered.
>> >> > +        */
>> >> > +       if (lock)
>> >> > +               mutex_lock(&hook_mutex);
>>
>> > I mean, it's not game-breaking, its just minor style stuff. I won't be
>> > sending more revisions because of these small issues, as I think its
>> > uneccessary to flood both Rafael and the mailing lists with patch
>> > revisions that remove or add a few spaces. No offence, it just got old.
>>
>> Yes, his call anyway to apply or ask you for amendments. I'm just
>> helping with review.
>
> Rafael, what do you think? Do you want these style/syntax issues fixed
> or is it good to go?

As long as the code is all correct technically, they are secondary.

That said I still need to look into your patches in detail and I need
more time for that.

Thanks,
Rafael

--===============6691207639314211125==--

