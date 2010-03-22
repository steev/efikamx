# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="Efika MX system headers from the kernel"
HOMEPAGE=""
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	insinto /usr/include/linux
	doins "${FILESDIR}"/*
}
