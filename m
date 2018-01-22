Content-Type: multipart/mixed; boundary="===============4612597763387112506=="
MIME-Version: 1.0
From: James Morse <james.morse at arm.com>
Subject: Re: [Devel] [PATCH v8 7/7] arm64: kvm: handle SError Interrupt by
 categorization
Date: Mon, 22 Jan 2018 19:32:12 +0000
Message-ID: <5A663C3C.7040904@arm.com>
In-Reply-To: CAMj-D2C5Bz3r-w9v3QasZKK-W2JBY7Mx9W=yCDBnPYyk99gGzA@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4612597763387112506==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi gengdongjiu,

On 21/01/18 02:45, gengdongjiu wrote:
> For the ESR_ELx_AET_UER, this exception is precise, closing the VM may
> be better[1].
> But if you think panic is better until we support kernel-first, it is
> also OK to me.

I'm not convinced SError while a guest was running means only guest memory =
could
be affected. Mechanisms like KSM means the error could affect multiple gues=
ts.

Both firmware-fist and kernel-first will give us the address, with which we=
 can
know which processes are affected, isolated the memory and signal affected
processes.

Until we have one of these panic() is the only way we have to contain an er=
ror,
but its an interim fix.
Not panic()ing the host for an error that should be contained to the guest =
is a
fudge, we don't actually know its safe (KSM, page-table etc). I want to imp=
rove
on this with {firmware, kernel}-first support (or both!), I don't want to e=
xpose
that this is happening to user-space, as once we have one of {firmware,
kernel}-first, it shouldn't happen.


>> This is inventing something new for RAS errors not claimed by firmware-f=
irst.
>> If we have kernel-first too, this will never happen. (unless your system=
 is
>> losing the error description).

> In fact, if we have kernel-first, I think we still need to judge the
> error type by ESR, right?

The kernel-first mechanism should consider the ESR/FAR, yes, but once the e=
rror
has been claimed and handled, KVM shouldn't care about any of these values.
(maybe we'll sanity check for uncontained errors, just in case the error es=
caped
to the RAS code...)

My point here was exposing 'unhandled' (ignored) RAS errors to user-space
creates an ABI: someone will complain once we start handling the error, and=
 they
no longer get a notification via this 'unhandled' interface. Code written t=
o use
this interface becomes useless/untested.


> If the handle_guest_sei() , may be the system does not support firmware-f=
irst,
> so we judge the ESR value,

...and panic()/ignore as appropriate.

I agree not all systems will support firmware-first, (big-endian is the obv=
ious
example), but if we get kernel-first support this ESR guessing can disappea=
r,
I'm against exposing it to user-space in the meantime.


Thanks,

James

--===============4612597763387112506==--

