Content-Type: multipart/mixed; boundary="===============2387838270940903923=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [PATCH v10 2/4] pm: add to_power_supply macro to the API
Date: Sun, 31 Dec 2017 12:17:46 +0100
Message-ID: <CAJZ5v0i4PW9ED4+arww96r6H2X_tr41e+BD-_dDx_bB2Kvq0jQ@mail.gmail.com>
In-Reply-To: CAHp75VewyeTEr7A=HP4nU=DhMvhq9AaHc-VKpz8NzcA2X6BGkg@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2387838270940903923==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 31, 2017 at 10:37 AM, Andy Shevchenko
<andy.shevchenko(a)gmail.com> wrote:
> On Sat, Dec 30, 2017 at 1:49 AM, Ognjen Gali=C4=87 <smclt30p(a)gmail.com>=
 wrote:
>> On =C4=8Cet, 2017-12-28 at 10:19 +0200, Andy Shevchenko wrote:
>>> On Sat, Dec 23, 2017 at 12:53 PM, Ognjen Galic <smclt30p(a)gmail.com>
>>> wrote:
>>> >
>>> > This patch adds the to_power_supply macro to upcast
>>> > a device to a power_supply struct.
>>> >
>>> > This is needed because the same piece of code using
>>> > container_of is used in various other places, so we
>>> > abstract away such low-level operations via a macro.
>>> >
>>> > ---
>>> This is wrong! You have to use *existing* --- line below. Otherwise
>>> all mail parsers will cut this out including your SoB tag.
>>>
>>
>> My bad I guess. Want another patch revision with that fixed or
>> something?
>>
>
> You definitely need to send a new revision with all comments
> addressed. So far you didn't responce to them which I recognize as
> total agreement that they have to be addressed.

I asked for not sending new versions before I have a chance to look at
the current one in detail, but enough time has passed after the last
one, so I agree.  Sending a new version at this point won't hurt. :-)

Thanks,
Rafael

--===============2387838270940903923==--

