# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

# This ebuild is by no means complete or work ready.  Need clarification
# on the LICENSE, as well as the ability to mirror.  Currently the only
# way to get the tarball is to download the BSP which is 590MB in size.
# Initial indications are that I can't host this tarball - They want a
# clickthrough wrapper.  I've put in a request about this however, if adding it
# to the EULA license group would be good enough.

DESCRIPTION="libz160"
HOMEPAGE=""
SRC_URI="http://ubersekret.com/distfiles/${P}.tar.gz"
RESTRICT="strip mirror"

LICENSE="Freescale"
SLOT="0"
KEYWORDS="~arm"
IUSE=""

RDEPEND=""
DEPEND=""



src_install() {
	# There is probably an easier way to do this.
	insinto /usr/include
	doins "${S}/usr/include/z160.h"
	insinto /usr/lib
	doins "${S}/usr/lib/libz160-amd.so"
	doins "${S}/usr/lib/libz160-fsl.so"
	dosym libz160-fsl.so /usr/lib/libz160.so
}
