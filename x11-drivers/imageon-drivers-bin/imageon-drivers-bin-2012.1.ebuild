# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit multilib

DESCRIPTION="Closed source imageon OpenGL/OpenVG driver"
HOMEPAGE=""
SRC_URI="http://localhost/${P}.tar.xz"

LICENSE="EULA"
SLOT="0"
KEYWORDS="~arm"
IUSE=""

DEPEND=">=app-admin/eselect-opengl-1.2.6"
RDEPEND="${DEPEND}
		x11-libs/libX11
		x11-libs/libXrender
		x11-libs/libXext
"

RESTRICT="test"


src_install() {
	local opengl_imp="imageon"
	local opengl_dir="/usr/$(get_libdir)/opengl/${opengl_imp}"
	dodir "$opengl_dir"/lib  "$opengl_dir"/include
	local x

	touch "${ED}"/${opengl_dir}/.gles-only

	for x in usr/lib/lib{EGL,GL*,OpenVG}.{la,a,so*}; do
		if [ -f ${x} -o -L ${x} ]; then
			mv "${x}" "${ED}"/${opengl_dir}/lib \
				|| die "Failed to move ${x}"
		fi
	done
	mv usr/include/{EGL,GLES*,VG,KHR}/  \
		"${ED}"/${opengl_dir}/include || die "Failed to move headers"
	insinto /usr
	doins -r usr/include
	dolib usr/lib/*
}

pkg_postinst() {
	eselect opengl set --use-old ${opengl_imp}
}
