# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils flag-o-matic autotools

DESCRIPTION="Freescale IMX gstreamer plugin"
HOMEPAGE=""
SRC_URI="${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~arm"
IUSE=""

DEPEND="media-libs/fsl-mm-codeclib
	sys-libs/imx-lib
	sys-kernel/firmware-imx
	media-libs/gstreamer
	media-libs/gst-plugins-base"
RDEPEND="${DEPEND}"

src_prepare() {
	# A quick fix for a bug which breaks the -DUSE_X11 gcc option!
	sed -i '/FBHEADER_PATH/d' ${S}/src/misc/v4l_sink/src/Makefile.am
	eautoreconf
}

src_configure() {
	# We should implement this somewhere common, eclass?
	append-flags "-I${ROOT}/usr/src/linux/include"

	econf PLATFORM=MX51 || die 'econf failed.'
}

src_install() {
	emake DESTDIR=${D} install || die 'emake install failed.'
}
