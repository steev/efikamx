# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
XORG_EAUTORECONF="yes"
inherit xorg-2

DESCRIPTION="xf86 imx driver"
HOMEPAGE=""
SRC_URI="http://ubersekret.com/distfiles/xserver-xorg-video-imx-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm"
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

S="${WORKDIR}/xserver-xorg-video-imx-${PV}"

PATCHES=( "${FILESDIR}/${PN}-10.05.02-xorg-abi-fix.patch"
	"${FILESDIR}/${PN}-10.05.02-remove-Symbols.patch"
	"${FILESDIR}/${PN}-10.05.02-unbundle-exa.patch"
	"${FILESDIR}/${PN}-10.07.11-missing-exa-symbol.patch"
	"${FILESDIR}/${PN}-10.05.02-use-dixChangeGC.patch"
	"${FILESDIR}/${PN}-10.07.11-use-dixLookupResourceByType.diff"
	"${FILESDIR}/${PN}-0.1.0-fix-macro-dir.patch" )

# And we override the xorg2 eclass to make the m4 directory that doesn't exist.
src_prepare() {
	mkdir -p ${S}/m4
	xorg-2_patch_source
	xorg-2_reconf_source
}
