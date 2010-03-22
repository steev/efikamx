# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

# This ebuild is by no means complete or work ready.  Need clarification
# on the LICENSE, as well as the ability to mirror.  Currently the only 
# way to get the tarball is to download the BSP which is 590MB in size.

DESCRIPTION="libz160"
HOMEPAGE=""
SRC_URI="${P}.tar.gz"
RESTRICT="strip mirror"

LICENSE=""
SLOT="0"
KEYWORDS="~arm"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"



src_install() {
	# There is probably an easier way to do this.
	insinto /usr/include
	doins "${S}/usr/include/z160.h"
	insinto /usr/lib
	doins "${S}/usr/lib/libz160-amd.so"
	doins "${S}/usr/lib/libz160-fsl.so"
	dosym /usr/lib/libz160-fsl.so /usr/lib/libz160.so
}
