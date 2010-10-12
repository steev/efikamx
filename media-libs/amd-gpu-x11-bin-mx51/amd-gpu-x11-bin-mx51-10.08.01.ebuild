# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Kernel modules and binary libraries for the imx-gpu"
HOMEPAGE=""
SRC_URI="http://ubersekret.com/distfiles/${P}.tar.gz"
#http://ubersekret.com/distfiles/amd-gpu-x11-bin-mx51-10.08.01.tar.gz
RESTRICT="fetch"

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

src_install () {
	# kernel module
	cp -a "${S}/lib" ${D}
	# libraries
	insinto /usr
	doins -r "${S}/usr/lib"
	doins -r "${S}/usr/include"
}
