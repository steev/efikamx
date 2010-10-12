# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit toolchain-funcs

DESCRIPTION="IMX{31,51} System library"
HOMEPAGE=""
SRC_URI="http://ubersekret.com/distfiles/${P}.tar.gz"

LICENSE="Freescale GPL-2"
SLOT="0"
KEYWORDS="~arm"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	emake -j1 CC=$(tc-getCC) CXX=$(tc-getCXX) \
		INCLUDE="-I${ROOT}/usr/src/linux/include \
				 -I${ROOT}/usr/src/linux/drivers/mxc/security/rng/include \
				 -I${ROOT}/usr/src/linux/drivers/mxc/security/sahara2/include" \
		PLATFORM="IMX51" all || die "emake failed."
}

src_install() {
	# Their Makefile doesn't support DESTDIR, they call it DEST_DIR.
	emake DEST_DIR="${D}" install || die "emake install failed."
}
