# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
inherit xorg-2 multilib versionator

EGIT_REPO_URI="git://anongit.freedesktop.org/git/xorg/xserver"

OPENGL_DIR="xorg-x11"

DESCRIPTION="X.Org X servers"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"

IUSE_SERVERS="dmx kdrive xorg"
IUSE="${IUSE_SERVERS} tslib ipv6 minimal nptl sdl udev"
RDEPEND=">=app-admin/eselect-opengl-1.0.8
	dev-libs/openssl
	media-libs/freetype
	>=x11-apps/iceauth-1.0.2
	>=x11-apps/rgb-1.0.3
	>=x11-apps/xauth-1.0.3
	>=x11-apps/xinit-1.0.8-r3
	x11-apps/xkbcomp
	>=x11-libs/libpciaccess-0.10.3
	>=x11-libs/libXau-1.0.4
	>=x11-libs/libXdmcp-1.0.2
	>=x11-libs/libXfont-1.3.3
	>=x11-libs/libxkbfile-1.0.4
	>=x11-libs/libxkbui-1.0.2
	>=x11-libs/pixman-0.15.20
	>=x11-libs/xtrans-1.2.2
	>=x11-misc/xbitmaps-1.0.1
	>=x11-misc/xkeyboard-config-1.4
	dmx? (
		x11-libs/libXt
		>=x11-libs/libdmx-1.0.99.1
		>=x11-libs/libX11-1.1.5
		>=x11-libs/libXaw-1.0.4
		>=x11-libs/libXext-1.0.5
		>=x11-libs/libXfixes-4.0.3
		>=x11-libs/libXi-1.2.99.1
		>=x11-libs/libXmu-1.0.3
		>=x11-libs/libXtst-1.0.3
	)
	kdrive? (
		>=x11-libs/libXext-1.0.5
		sdl? ( media-libs/libsdl )
	)
	!minimal? (
		>=x11-libs/libX11-1.1.5
		>=x11-libs/libXext-1.0.5
		>=x11-libs/libXres-1.0.3
		>=media-libs/mesa-7.8_rc[nptl=]
	)
	tslib? ( >=x11-libs/tslib-1.0 x11-proto/xcalibrateproto )
	udev? ( sys-fs/udev[extras] )"
	# Xres is dmx-dependent
	# Xaw is dmx-dependent
	# Xpm is dmx-dependent, pulls in Xt
	# xkbcomp is launched at startup but not checked by ./configure

## Deps that don't have a version in configure.ac but do here:
# x11-proto/resourceproto
# x11-proto/fontsproto
# x11-libs/libXau
# x11-libs/libXfont
# x11-libs/libXdmcp
# x11-libs/libXext
# x11-libs/libX11
# x11-libs/libXrender
# x11-libs/libXmu
# x11-libs/libXfixes
# x11-libs/libXtst
# x11-proto/xineramaproto
# x11-proto/dmxproto
## Deps that are larger here than in configure.ac
# x11-libs/libpciaccess-0.8.0
#

DEPEND="${RDEPEND}
	!!net-dialup/dtrace
	sys-devel/flex
	>=x11-proto/bigreqsproto-1.1.0
	>=x11-proto/compositeproto-0.4
	>=x11-proto/damageproto-1.1
	>=x11-proto/fixesproto-4.1
	>=x11-proto/fontsproto-2.0.2
	>=x11-proto/glproto-1.4.11
	>=x11-proto/inputproto-1.9.99.902
	>=x11-proto/kbproto-1.0.3
	>=x11-proto/randrproto-1.2.99.3
	>=x11-proto/recordproto-1.13.99.1
	>=x11-proto/renderproto-0.11
	>=x11-proto/resourceproto-1.0.2
	>=x11-proto/scrnsaverproto-1.1
	>=x11-proto/trapproto-3.4.3
	>=x11-proto/videoproto-2.2.2
	>=x11-proto/xcmiscproto-1.2.0
	>=x11-proto/xextproto-7.0.99.3
	>=x11-proto/xf86dgaproto-2.0.99.1
	>=x11-proto/xf86rushproto-1.1.2
	>=x11-proto/xf86vidmodeproto-2.2.99.1
	>=x11-proto/xineramaproto-1.1.3
	>=x11-proto/xproto-7.0.13
	dmx? ( >=x11-proto/dmxproto-2.2.99.1 )
	!minimal? (
		>=x11-proto/xf86driproto-2.1.0
		>=x11-proto/dri2proto-2.1
		>=x11-libs/libdrm-2.3.0
	)"

PDEPEND="xorg? ( >=x11-base/xorg-drivers-$(get_version_component_range 1-2) )"

EPATCH_FORCE="yes"
EPATCH_SUFFIX="patch"

# These have been sent upstream
#UPSTREAMED_PATCHES=(
#	"${WORKDIR}/patches/"
#	)

PATCHES=(
	"${UPSTREAMED_PATCHES[@]}"
	)

pkg_setup() {
	xorg-2_pkg_setup

	use minimal || ensure_a_server_is_building

	# SDL only available in kdrive build
	if use kdrive && use sdl; then
		conf_opts="${conf_opts} --enable-xsdl"
	else
		conf_opts="${conf_opts} --disable-xsdl"
	fi

	# localstatedir is used for the log location; we need to override the default
	# from ebuild.sh
	# sysconfdir is used for the xorg.conf location; same applies
	# --enable-install-setuid needed because sparcs default off
	CONFIGURE_OPTIONS="
		$(use_enable ipv6)
		$(use_enable dmx)
		$(use_enable kdrive)
		$(use_enable tslib)
		$(use_enable tslib xcalibrate)
		$(use_enable !minimal xvfb)
		$(use_enable !minimal xnest)
		$(use_enable !minimal record)
		$(use_enable !minimal xfree86-utils)
		$(use_enable !minimal install-libxf86config)
		$(use_enable !minimal dri)
		$(use_enable !minimal dri2)
		$(use_enable !minimal glx)
		$(use_enable xorg)
		$(use_enable nptl glx-tls)
		$(use_enable udev config-udev)
		--sysconfdir=/etc/X11
		--localstatedir=/var
		--enable-install-setuid
		--with-fontdir=/usr/share/fonts
		--with-xkb-output=/var/lib/xkb
		--disable-config-hal
		--without-dtrace
		${conf_opts}"

	# (#121394) Causes window corruption
	filter-flags -fweb

	# Incompatible with GCC 3.x SSP on x86, bug #244352
	if use x86 ; then
		if [[ $(gcc-major-version) -lt 4 ]]; then
			filter-flags -fstack-protector
		fi
	fi

	# detect if we should inform user about ebuild breakage
	if ! has_version "x11-base/xorg-server" ||
			has_version "<x11-base/xorg-server-$(get_version_component_range 1-2)"; then
		INFO="yes"
	fi
}

src_configure() {
	# this is required only for configure and build time
	OLD_IMPLEM="$(eselect opengl show)"
	[[ ${OLD_IMPLEM} != ${OPENGL_DIR} ]] && eselect opengl set ${OPENGL_DIR}
	xorg-2_src_configure
}

src_compile() {
	emake # no die here intentional
	if [[ $? != 0 ]]; then
		[[ ${OLD_IMPLEM} != ${OPENGL_DIR} ]] && eselect opengl set ${OLD_IMPLEM}
		die "Compilation failed"
	fi
	[[ ${OLD_IMPLEM} != ${OPENGL_DIR} ]] && eselect opengl set ${OLD_IMPLEM}
}

src_install() {
	xorg-2_src_install

	dynamic_libgl_install

	server_based_install

	if ! use minimal &&	use xorg; then
		# Install xorg.conf.example (see bugs #151421 and #151670)
		insinto /etc/X11
		doins hw/xfree86/xorg.conf.example \
			|| die "couldn't install xorg.conf.example"
	fi
}

pkg_postinst() {
	if [[ ${INFO} = yes ]]; then
		echo
		ewarn "You must rebuild all drivers if upgrading from <xorg-server-$(get_version_component_range 1-2)"
		ewarn "because the ABI changed. If you cannot start X because"
		ewarn "of module version mismatch errors, this is your problem."

		echo
		ewarn "You can generate a list of all installed packages in the x11-drivers"
		ewarn "category using this command:"
		ewarn "emerge portage-utils; qlist -I -C x11-drivers/"
	fi
}

pkg_postrm() {
	# Get rid of module dir to ensure opengl-update works properly
	if ! has_version x11-base/xorg-server; then
		if [[ -e ${ROOT}/usr/$(get_libdir)/xorg/modules ]]; then
			rm -rf "${ROOT}"/usr/$(get_libdir)/xorg/modules
		fi
	fi
}

dynamic_libgl_install() {
	# next section is to setup the dynamic libGL stuff
	ebegin "Moving GL files for dynamic switching"
		dodir /usr/$(get_libdir)/opengl/${OPENGL_DIR}/extensions
		local x=""
		for x in "${D}"/usr/$(get_libdir)/xorg/modules/extensions/lib{glx,dri,dri2}*; do
			if [ -f ${x} -o -L ${x} ]; then
				mv -f ${x} "${D}"/usr/$(get_libdir)/opengl/${OPENGL_DIR}/extensions
			fi
		done
	eend 0
}

server_based_install() {
	if ! use xorg; then
		rm "${D}"/usr/share/man/man1/Xserver.1x \
			"${D}"/usr/$(get_libdir)/xserver/SecurityPolicy \
			"${D}"/usr/$(get_libdir)/pkgconfig/xorg-server.pc \
			"${D}"/usr/share/man/man1/Xserver.1x
	fi
}

ensure_a_server_is_building() {
	for server in ${IUSE_SERVERS}; do
		use ${server} && return;
	done
	eerror "You need to specify at least one server to build."
	eerror "Valid servers are: ${IUSE_SERVERS}."
	die "No servers were specified to build."
}
