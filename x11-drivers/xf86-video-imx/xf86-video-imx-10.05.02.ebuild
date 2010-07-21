# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
XORG_EAUTORECONF="yes"
inherit xorg-2

DESCRIPTION="xf86 imx driver"
HOMEPAGE=""
SRC_URI="http://ubersekret.com/distfiles/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="x11-base/xorg-server
	>=x11-libs/libz160-bin-${PV}"
DEPEND="${RDEPEND}
	x11-proto/fontsproto
	x11-proto/randrproto
	x11-proto/renderproto
	x11-proto/videoproto
	x11-proto/xproto
	>=sys-libs/imx-lib-${PV}"

PATCHES=( "${FILESDIR}/${P}-xorg-abi-fix.patch"
	"${FILESDIR}/${P}-remove-Symbols.patch"
	"${FILESDIR}/${P}-update-exa-2.4-2.5.patch"
	"${FILESDIR}/${P}-fix-macro-dir.patch" )

# And we override the xorg2 eclass to make the m4 directory that doesn't exist.
src_prepare() {
	xorg-2_src_unpack
	mkdir -p ${S}/m4
	xorg-2_patch_source
	xorg-2_reconf_source
}
