# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_P=${PN}-${PV}-20110310
DESCRIPTION="Kernel modules and binary libraries for the imx-gpu"
HOMEPAGE=""
SRC_URI="http://ubersekret.com/distfiles/${MY_P}.tar.bz2"

LICENSE="Freescale"
SLOT="0"
KEYWORDS="~arm"

DEPEND=""
RDEPEND="!media-libs/amd-gpu-x11-bin-mx51
		 x11-libs/libXrender
		 x11-libs/libxcb
		 x11-libs/libX11
		 x11-libs/libXext
		 x11-libs/libXdmcp
		 x11-libs/libXau"
S="${WORKDIR}/${MY_P}"
src_install () {
	# We do it this way because just recursively adding everything makes it an
	# non-symlink.
	insinto /usr
	cp -dpR "${S}/usr/lib" "${D}/usr/lib"
	insinto /usr
	doins -r "${S}/usr/include"
}
