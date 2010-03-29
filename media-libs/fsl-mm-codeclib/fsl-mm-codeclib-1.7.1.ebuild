# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="A bunch of codecs provided by Freescale"
HOMEPAGE="http://does.not.exi.st"
SRC_URI="${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~arm"
IUSE=""
RESTRICT="strip mirror"

DEPEND=""
RDEPEND="${DEPEND}"

QA_TEXTRELS="usr/lib/lib_g.729ab_enc_arm9_elinux.so
	usr/lib/lib_g.729ab_dec_arm9_elinux.so
	usr/lib/lib_g.723.1_enc_arm9_elinux.so
	usr/lib/lib_wma10_dec_arm9_elinux.so
	usr/lib/lib_nb_amr_dec_arm9_elinux.so
	usr/lib/lib_WMV9MP_dec_MP_arm11_elinux.so
	usr/lib/lib_g.726_dec_arm9_elinux.so
	usr/lib/lib_bsac_dec_arm11_elinux.so
	usr/lib/lib_oggvorbis_dec_arm11_elinux.so
	usr/lib/lib_wb_amr_dec_arm9_elinux.so
	usr/lib/lib_wmdrm_arm9_elinux.so
	usr/lib/lib_mp3_enc_arm11_elinux.so
	usr/lib/lib_mpeg2_dec_arm11_elinux.so
	usr/lib/lib_MPEG4ASP_dec_arm9_elinux.so
	usr/lib/lib_g.711_enc_arm11_elinux.so
	usr/lib/lib_aacplus_dec_arm9_elinux.so
	usr/lib/lib_deinterlace_arm11_elinux.so
	usr/lib/lib_H264_dec_arm9_elinux.so
	usr/lib/lib_mp3_dec_arm11_elinux.so
	usr/lib/lib_mp3_enc_arm9_elinux.so
	usr/lib/lib_g.711_dec_arm11_elinux.so
	usr/lib/lib_nb_amr_enc_arm9_elinux.so
	usr/lib/lib_MPEG4ASP_dec_arm11_elinux.so
	usr/lib/lib_wb_amr_enc_arm12_elinux.so
	usr/lib/lib_aac_dec_arm9_elinux.so
	usr/lib/lib_H264_dec_arm11_elinux.so
	usr/lib/lib_aacplus_dec_arm11_elinux.so
	usr/lib/lib_wma10_dec_arm12_elinux.so
	usr/lib/lib_aac_dec_arm11_elinux.so
	usr/lib/lib_wb_amr_enc_arm9_elinux.so
	usr/lib/lib_sbc_enc_arm11_elinux.so
	usr/lib/lib_mp3_enc_arm12_elinux.so
	usr/lib/lib_mp3_dec_arm12_elinux.so
	usr/lib/lib_g.723.1_dec_arm9_elinux.so
	usr/lib/lib_g.711_dec_arm9_elinux.so
	usr/lib/lib_WMV789_dec_arm11_elinux.so
	usr/lib/lib_mp3_dec_arm9_elinux.so
	usr/lib/lib_wmdrm_arm11_elinux.so
	usr/lib/lib_aac_dec_arm12_elinux.so
	usr/lib/lib_flac_dec_arm11_elinux.so
	usr/lib/lib_wma8_enc_arm11_elinux.so
	usr/lib/lib_g.711_enc_arm9_elinux.so
	usr/lib/lib_g.726_enc_arm9_elinux.so
	usr/lib/lib_wma10_dec_arm11_elinux.so
	usr/lib/lib_wb_amr_dec_arm12_elinux.so"

QA_SONAME="usr/lib/lib_H264_dec_arm11_elinux.so
	usr/lib/lib_H264_dec_arm9_elinux.so
	usr/lib/lib_MPEG4ASP_dec_arm11_elinux.so
	usr/lib/lib_MPEG4ASP_dec_arm9_elinux.so
	usr/lib/lib_WMV789_dec_arm11_elinux.so
	usr/lib/lib_WMV9MP_dec_MP_arm11_elinux.so
	usr/lib/lib_aac_dec_arm11_elinux.so
	usr/lib/lib_aac_dec_arm12_elinux.so
	usr/lib/lib_aac_dec_arm9_elinux.so
	usr/lib/lib_aacplus_dec_arm11_elinux.so
	usr/lib/lib_aacplus_dec_arm9_elinux.so
	usr/lib/lib_asf_parser_arm11_elinux.so
	usr/lib/lib_asf_parser_arm9_elinux.so
	usr/lib/lib_avi_drm_arm11_elinux.so
	usr/lib/lib_avi_drm_arm9_elinux.so
	usr/lib/lib_avi_parser_arm11_elinux.so
	usr/lib/lib_avi_parser_arm9_elinux.so
	usr/lib/lib_bsac_dec_arm11_elinux.so
	usr/lib/lib_deinterlace_arm11_elinux.so
	usr/lib/lib_flac_dec_arm11_elinux.so
	usr/lib/lib_g.711_dec_arm11_elinux.so
	usr/lib/lib_g.711_dec_arm9_elinux.so
	usr/lib/lib_g.711_enc_arm11_elinux.so
	usr/lib/lib_g.711_enc_arm9_elinux.so
	usr/lib/lib_g.723.1_dec_arm9_elinux.so
	usr/lib/lib_g.723.1_enc_arm9_elinux.so
	usr/lib/lib_g.726_dec_arm9_elinux.so
	usr/lib/lib_g.726_enc_arm9_elinux.so
	usr/lib/lib_g.729ab_dec_arm9_elinux.so
	usr/lib/lib_g.729ab_enc_arm9_elinux.so
	usr/lib/lib_jpeg_dec_arm11_elinux.so
	usr/lib/lib_mp3_dec_arm11_elinux.so
	usr/lib/lib_mp3_dec_arm12_elinux.so
	usr/lib/lib_mp3_dec_arm9_elinux.so
	usr/lib/lib_mp3_enc_arm11_elinux.so
	usr/lib/lib_mp3_enc_arm12_elinux.so
	usr/lib/lib_mp3_enc_arm9_elinux.so
	usr/lib/lib_mp3_parser_arm11_elinux.so
	usr/lib/lib_mp3_parser_arm9_elinux.so
	usr/lib/lib_mp4_parser_arm11_elinux.so
	usr/lib/lib_mp4_parser_arm9_elinux.so
	usr/lib/lib_mpeg2_dec_arm11_elinux.so
	usr/lib/lib_mpg2_demuxer_arm11_elinux.so
	usr/lib/lib_nb_amr_dec_arm9_elinux.so
	usr/lib/lib_nb_amr_enc_arm9_elinux.so
	usr/lib/lib_oggvorbis_dec_arm11_elinux.so
	usr/lib/lib_sbc_enc_arm11_elinux.so
	usr/lib/lib_wb_amr_dec_arm12_elinux.so
	usr/lib/lib_wb_amr_dec_arm9_elinux.so
	usr/lib/lib_wb_amr_enc_arm12_elinux.so
	usr/lib/lib_wb_amr_enc_arm9_elinux.so
	usr/lib/lib_wma10_dec_arm11_elinux.so
	usr/lib/lib_wma10_dec_arm12_elinux.so
	usr/lib/lib_wma10_dec_arm9_elinux.so
	usr/lib/lib_wma8_enc_arm11_elinux.so
	usr/lib/lib_wma_muxer_arm11_ELINUX.so
	usr/lib/lib_wmdrm_arm11_elinux.so
	usr/lib/lib_wmdrm_arm9_elinux.so
	usr/lib/libmpeg4_encoder_arm11_ELINUX.so"

QA_WX_LOAD="usr/lib/lib_WMV9MP_dec_MP_arm11_elinux.so
	usr/lib/lib_sbc_enc_arm9_elinux.so
	usr/lib/lib_peq_arm11_elinux.so
	usr/lib/lib_png_dec_arm11_elinux.so
	usr/lib/lib_WMV789_dec_arm11_elinux.so"

src_install() {
	insinto /usr/share/pkgconfig
	doins "${S}"/pkgconfig/fsl-mm-core.pc
	insinto /usr/include/mm_ghdr
	doins "${S}"/ghdr/*
	insinto /usr/include/mm_ghdr/asf_parser
	doins "${S}"/ghdr/asf_parser/*
	insinto /usr/include/mm_ghdr/avi_parser_v2
	doins "${S}"/ghdr/avi_parser_v2/*
	insinto /usr/include/mm_ghdr/common
	doins "${S}"/ghdr/common/*
	insinto /usr/include/mm_ghdr/mp3_parser
	doins "${S}"/ghdr/mp3_parser/*
	insinto /usr/include/mm_ghdr/mp4_parser
	doins "${S}"/ghdr/mp4_parser/*
	insinto /usr/include/mm_ghdr/mpg2_demuxer
	doins "${S}"/ghdr/mpg2_demuxer/*
	insinto /usr/include/mm_ghdr/sbc
	doins "${S}"/ghdr/sbc/*
	insinto /usr/include/mm_ghdr/wma10_dec
	doins "${S}"/ghdr/wma10_dec/*
	insinto /usr/lib
	doins "${S}"/release/lib/*
	# Okay, now that we have everything in place, lets dump the 0byte files.
	rm ${D}/usr/lib/lib_g.723.1_{dec,enc}_arm11_elinux.so
	rm ${D}/usr/lib/lib_wb_amr_{dec,enc}_arm11_elinux.so
	rm ${D}/usr/lib/lib_jpeg_enc_arm9_elinux.so
	rm ${D}/usr/lib/lib_nb_amr_{dec,enc}_arm11_elinux.so
	rm ${D}/usr/lib/lib_gif_dec_arm9_elinux.so
}
