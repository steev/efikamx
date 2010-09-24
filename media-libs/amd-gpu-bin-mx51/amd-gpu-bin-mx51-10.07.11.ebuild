# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Kernel modules and binary libraries for the imx-gpu"
HOMEPAGE=""
SRC_URI="http://localhost/${P}.tar.gz"

LICENSE="Freescale"
SLOT="0"
KEYWORDS="~arm"
IUSE=""

DEPEND=""
RDEPEND=""

src_install () {
	# kernel module
	cp -a "${S}/lib" ${D}
	# libraries
	insinto /usr
	doins -r "${S}/usr/lib"
	doins -r "${S}/usr/include"
}
