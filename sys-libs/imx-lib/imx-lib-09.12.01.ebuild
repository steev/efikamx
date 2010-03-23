# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="IMX{31,51} System library"
HOMEPAGE=""
SRC_URI="http://ubersekret.com/distfiles/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~arm"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	emake INCLUDE="-I/usr/src/linux/include \
	-I/usr/src/linux/drivers/mxc/security/rng/include \
	-I/usr/src/linux/drivers/mxc/security/sahara2/include" \
	PLATFORM="IMX51" all || die "emake failed"
}

src_install() {
	emake DEST_DIR="${D}" install || die "emake failed"
}
