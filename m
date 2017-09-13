Content-Type: multipart/mixed; boundary="===============1213767701168913554=="
MIME-Version: 1.0
From: gengdongjiu <gengdongjiu at huawei.com>
Subject: Re: [Devel] [PATCH v11 6/6] target-arm: kvm64: Handle SError
 interrupt for the guest OS
Date: Wed, 13 Sep 2017 19:51:56 +0800
Message-ID: <c105c670-6aec-32cd-d32b-30642819323e@huawei.com>
In-Reply-To: CAFEAcA_zO_-kDYb0MkW=p5oY6tQPk4PpCqZoG0_01pn=sa3upw@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1213767701168913554==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 2017/9/13 18:52, Peter Maydell wrote:
> This question seems to be not really related to the review
> comment that it is responding to.
> =

> (1) If the host does not support notifying us about
> errors, then there is clearly nothing to do in this
> code, because we will never get a notification.
> =

> (2) If the host does support notifying us about errors,
> but we choose not to expose RAS to the guest, then
> there's not much to do either. We probably just want
> to take whatever the default behaviour is for any
> application when it touches memory that's bad.
> We definitely don't want to tell the guest anything.
> =

> (3) If the host supports notification, and we choose
> to expose RAS to the guest, then we need to do
> whatever we have to do to notify the guest.
> =

> If we're in this signal handler and also
> arm_feature(env, ARM_FEATURE_RAS) is false then that
> is case (2), and my point is that doing anything with
> the guest 'syndrome' value looks like the wrong thing.

Peter,
  your explanation is clear. OK, understand, thanks.


--===============1213767701168913554==--

