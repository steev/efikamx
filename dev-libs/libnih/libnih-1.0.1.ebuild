# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Small library for C application development"
HOMEPAGE="https://launchpad.net/libnih"
SRC_URI="http://launchpad.net/${PN}/1.0/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	dev-libs/expat
	>=sys-apps/dbus-1.2.16"

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
}
