# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
inherit xorg-2 toolchain-funcs versionator

EGIT_REPO_URI="git://anongit.freedesktop.org/git/pixman"
DESCRIPTION="Low-level pixel manipulation routines"

KEYWORDS="~arm"
IUSE="altivec mmx sse2 simd neon"

pkg_setup() {
	xorg-2_pkg_setup
	CONFIGURE_OPTIONS="
		$(use_enable altivec vmx)
		$(use_enable simd arm-simd)
		$(use_enable neon arm-neon)
		--disable-gtk"

	local enable_mmx="$(use mmx && echo 1 || echo 0)"
	local enable_sse2="$(use sse2 && echo 1 || echo 0)"

	# this block fixes bug #260287
	if use x86; then
		if use sse2 && ! $(version_is_at_least "4.2" "$(gcc-version)"); then
			ewarn "SSE2 instructions require GCC 4.2 or higher."
			ewarn "pixman will be built *without* SSE2 support"
			enable_sse2="0"
		fi
	fi

	# this block fixes bug #236558
	case "$enable_mmx,$enable_sse2" in
	'1,1')
		CONFIGURE_OPTIONS="${CONFIGURE_OPTIONS} --enable-mmx --enable-sse2" ;;
	'1,0')
		CONFIGURE_OPTIONS="${CONFIGURE_OPTIONS} --enable-mmx --disable-sse2" ;;
	'0,1')
		ewarn "You enabled SSE2 but have MMX disabled. This is an invalid."
		ewarn "pixman will be built *without* MMX/SSE2 support."
		CONFIGURE_OPTIONS="${CONFIGURE_OPTIONS} --disable-mmx --disable-sse2" ;;
	'0,0')
		CONFIGURE_OPTIONS="${CONFIGURE_OPTIONS} --disable-mmx --disable-sse2" ;;
	esac
}

src_prepare() {
	epatch "${FILESDIR}"/0002-Fix-compilation-on-Win32.patch
	epatch "${FILESDIR}"/0003-test-Fix-tests-for-compilation-on-Windows.patch
	epatch "${FILESDIR}"/0004-test-Add-Makefile-for-Win32.patch
	epatch "${FILESDIR}"/0005-Do-not-include-unused-headers.patch
	epatch "${FILESDIR}"/0006-test-Silence-MSVC-warnings.patch
	epatch "${FILESDIR}"/0007-Main-loop-template-for-fast-single-pass-bilinear-sca.patch
	epatch "${FILESDIR}"/0008-test-check-correctness-of-bilinear_pad_repeat_get_sc.patch
	epatch "${FILESDIR}"/0009-SSE2-optimization-for-bilinear-scaled-src_8888_8888.patch
	epatch "${FILESDIR}"/0010-ARM-NEON-optimization-for-bilinear-scaled-src_8888_8.patch
	epatch "${FILESDIR}"/0011-test-In-image_endian_swap-use-pixman_image_get_forma.patch
	epatch "${FILESDIR}"/0012-test-Do-endian-swapping-of-the-source-and-destinatio.patch
	epatch "${FILESDIR}"/0013-ARM-use-prefetch-in-nearest-scaled-src_0565_0565.patch
	epatch "${FILESDIR}"/0014-ARM-common-macro-for-nearest-scaling-fast-paths.patch
	epatch "${FILESDIR}"/0015-ARM-assembly-optimized-nearest-scaled-src_8888_8888.patch
	epatch "${FILESDIR}"/0016-ARM-new-bilinear-fast-path-template-macro-in-pixman-.patch
	epatch "${FILESDIR}"/0017-ARM-NEON-common-macro-template-for-bilinear-scanline.patch
	epatch "${FILESDIR}"/0018-ARM-use-common-macro-template-for-bilinear-scaled-sr.patch
	epatch "${FILESDIR}"/0019-ARM-NEON-optimization-for-bilinear-scaled-src_8888_0.patch
	epatch "${FILESDIR}"/0020-ARM-NEON-optimization-for-bilinear-scaled-src_0565_x.patch
	epatch "${FILESDIR}"/0021-ARM-NEON-optimization-for-bilinear-scaled-src_0565_0.patch
	epatch "${FILESDIR}"/0022-ARM-a-bit-faster-NEON-bilinear-scaling-for-r5g6b5-so.patch

	# We patch Makefile.am and such, so eautoreconf!
	eautoreconf
}
