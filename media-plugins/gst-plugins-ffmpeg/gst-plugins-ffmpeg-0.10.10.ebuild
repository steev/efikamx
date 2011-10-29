# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-ffmpeg/gst-plugins-ffmpeg-0.10.9.ebuild,v 1.2 2009/11/17 06:02:17 mr_bones_ Exp $

inherit flag-o-matic eutils base toolchain-funcs autotools

PD=${FILESDIR}/${PV}
MY_PN=${PN/-plugins}
MY_P=${MY_PN}-${PV}

# Create a major/minor combo for SLOT
PVP=(${PV//[-\._]/ })
SLOT=${PVP[0]}.${PVP[1]}
#SLOT=0.10

DESCRIPTION="FFmpeg based gstreamer plugin"
HOMEPAGE="http://gstreamer.freedesktop.org/modules/gst-ffmpeg.html"
SRC_URI="http://gstreamer.freedesktop.org/src/${MY_PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

S=${WORKDIR}/${MY_P}

RDEPEND=">=media-libs/gstreamer-0.10.25
	>=media-libs/gst-plugins-base-0.10.25
	>=dev-libs/liboil-0.3.6"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}"/0.10.9/increase-demux-rank.patch
	epatch "${FILESDIR}"/0.10.10/build-ffmpeg-seperately.patch
	epatch "${FILESDIR}"/0.10.10/enable-ftree-vectorize.patch
	eautoreconf
}

src_compile() {
	append-flags -fno-strict-aliasing

	for i in $(get-flag march) $(get-flag mcpu) $(get-flag mtune) ; do
		[ "${i}" = "native" ] && i="host" # bug #273421
		myconf="${myconf} --cpu=$i"
		break
	done

	# cross compile support
	if tc-is-cross-compiler ; then
		myconf="${myconf} --enable-cross-compile --arch=$(tc-arch-kernel) --cross-prefix=${CHOST}-"
		case ${CHOST} in
			*freebsd*)
				myconf="${myconf} --target-os=freebsd"
				;;
			mingw32*)
				myconf="${myconf} --target-os=mingw32"
				;;
			*linux*)
				myconf="${myconf} --target-os=linux"
				;;
		esac
	fi

	cd ${S}/gst-libs/ext/ffmpeg
	#econf \
	#	--extra-cflags="${CFLAGS}"|| die "emake failed."
	./configure \
		--prefix=/usr \
		--libdir=/usr/$(get_libdir) \
		--shlibdir=/usr/$(get_libdir) \
		--mandir=/usr/share/man \
		--enable-static --enable-shared \
		--cc="$(tc-getCC)" \
		--extra-cflags="${CFLAGS}" \
		--enable-gpl \
		--enable-postproc \
		${myconf} || die "configure failed"
	emake || die "emake failed."

	cd ${S}
	econf \
		--with-ffmpeg-extra-configure="${myconf} --extra-cflags=-mfpu=neon"
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README TODO
}
