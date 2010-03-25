# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
AM_OPTS="--foreign"
AT_NOELIBTOOLIZE="yes"
inherit xorg-2

DESCRIPTION="xf86 imx driver"
HOMEPAGE=""
SRC_URI="http://ubersekret.com/distfiles/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="x11-base/xorg-server
	>=x11-libs/libz160-bin-09.12.01"
DEPEND="${RDEPEND}
	x11-proto/fontsproto
	x11-proto/randrproto
	x11-proto/renderproto
	x11-proto/videoproto
	x11-proto/xproto
	>=sys-libs/imx-lib-09.12.01"

PATCHES=( "${FILESDIR}/${P}-xorg-abi-fix.patch"
	"${FILESDIR}/${P}-remove-Symbols.patch"
	"${FILESDIR}/${P}-update-exa-2.4-2.5.patch" )

# Need to autoreconf due to the exa update (it touches Makefile.am)
# And libtoolize bombs from eautoreconf so need to override xorg-2's
# handling of it.
src_prepare() {
	xorg-2_src_unpack
	xorg-2_patch_source
	eautoconf
	eaclocal
	elibtoolize --shallow
	eaclocal
	eautoheader
	eautomake
	elibtoolize --shallow
}
