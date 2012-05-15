# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
CLUTTER_LA_PUNT="yes"

# Inherit gnome2 after clutter to download sources from gnome.org
inherit clutter gnome2 virtualx

DESCRIPTION="A library for using 3D graphics hardware to draw pretty pictures"
HOMEPAGE="http://www.clutter-project.org/"

LICENSE="LGPL-2.1"
SLOT="1.0"
IUSE="doc examples opengl gles2 +introspection +pango"
KEYWORDS="~alpha amd64 ~arm ~ppc ppc64 x86"

# XXX: need uprof for optional profiling support
COMMON_DEPEND=">=dev-libs/glib-2.26.0:2
	x11-libs/cairo
	>=x11-libs/gdk-pixbuf-2:2
	x11-libs/libdrm
	x11-libs/libX11
	>=x11-libs/libXcomposite-0.4
	x11-libs/libXdamage
	x11-libs/libXext
	>=x11-libs/libXfixes-3
	virtual/opengl

	introspection? ( >=dev-libs/gobject-introspection-0.9.5 )
	pango? ( >=x11-libs/pango-1.20.0[introspection?] )"
# before clutter-1.7, cogl was part of clutter
RDEPEND="${COMMON_DEPEND}
	!<media-libs/clutter-1.7"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig
	sys-devel/gettext
	doc? ( app-text/docbook-xml-dtd:4.1.2
		>=dev-util/gtk-doc-1.13 )"

# XXX: at least when using nvidia-drivers, tests fail under Xemake/Xvfb, no
# matter whether "eselect opengl" is set to nvidia or xorg-x11.
RESTRICT="test"

pkg_setup() {
	DOCS="NEWS README"
	EXAMPLES="examples/{*.c,*.jpg}"
	# XXX: think about gles, quartz, wayland
	if use arm; then
	myconf="$(use_enable gles2) \
	--disable-gl \
	--disable-wgl \
	--disable-glx \
	--disable-null-egl-platform \
	--disable-gdl-egl-platform \
	--disable-wayland-egl-platform \
	--disable-wayland-egl-server \
	--disable-android-egl-platform \
	--enable-xlib-egl-platform"
	else
	myconf="$(use_enable opengl gl) \
	--enable-glx \
	--enable-xlib-egl-platform"
	fi
	G2CONF="${G2CONF}
		--disable-profile
		--disable-maintainer-flags
		--enable-cairo
		--enable-gdk-pixbuf
		$(use_enable introspection)
		$(use_enable pango cogl-pango)
		${myconf}"
}

src_test() {
	Xemake check
}

src_install() {
	clutter_src_install
}
