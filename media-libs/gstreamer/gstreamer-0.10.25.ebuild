# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gstreamer/gstreamer-0.10.30.ebuild,v 1.1 2010/07/21 17:59:43 ford_prefect Exp $

EAPI=2

inherit eutils multilib versionator

# Create a major/minor combo for our SLOT and executables suffix
PV_MAJ_MIN=$(get_version_component_range '1-2')

DESCRIPTION="Streaming media framework"
HOMEPAGE="http://gstreamer.sourceforge.net"
SRC_URI="http://${PN}.freedesktop.org/src/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT=${PV_MAJ_MIN}
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="+introspection nls test"

RDEPEND=">=dev-libs/glib-2.20:2
	dev-libs/libxml2
	introspection? ( >=dev-libs/gobject-introspection-0.6.3 )
	!<media-libs/gst-plugins-base-0.10.25"
	# ^^ queue2 move, mustn't have both libgstcoreleements.so and libgstqueue2.so at runtime providing the element at once
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_prepare() {
	epatch "${FILESDIR}/01_multiqueue-iterate-internal-links.patch"
	epatch "${FILESDIR}/fsl_001_gstreamer0.10-25_gstmfwbuffer.patch"
	epatch "${FILESDIR}/fsl_002_gstreamer0.10-25_gstmfwbuffer_subbuffer.patch"
}

src_configure() {
	# Disable static archives, dependency tracking and examples
	# to speed up build time
	econf \
		--disable-static \
		--disable-dependency-tracking \
		$(use_enable nls) \
		--disable-valgrind \
		--disable-examples \
		--enable-check \
		$(use_enable introspection)
		$(use_enable test tests) \
		--with-package-name="GStreamer ebuild for Gentoo" \
		--with-package-origin="http://packages.gentoo.org/package/media-libs/gstreamer"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS MAINTAINERS README RELEASE

	# Remove unversioned binaries to allow SLOT installations in future
	cd "${D}"/usr/bin
	local gst_bins
	for gst_bins in $(ls *-${PV_MAJ_MIN}); do
		rm -f ${gst_bins/-${PV_MAJ_MIN}/}
	done
}
