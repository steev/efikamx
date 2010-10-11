# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit git autotools

DESCRIPTION="GStreamer plug-in that allows communication with OpenMAX IL
components"
HOMEPAGE="http://freedesktop.org/wiki/GstOpenMAX"
EGIT_REPO_URI="git://anongit.freedesktop.org/gstreamer/gst-openmax"

LICENSE="LGPL"
SLOT="0"
KEYWORDS="~arm"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
}

src_install() {
	emake DESTDIR=${D} install || die 'emake install failed.'
}
