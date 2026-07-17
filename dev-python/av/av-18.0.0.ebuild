# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_EXT=1

inherit distutils-r1 pypi

DESCRIPTION="Pythonic bindings for FFmpeg's libraries."
HOMEPAGE="
	https://pypi.org/project/av/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"
IUSE="examples"

RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	media-video/ffmpeg:=
"
BDEPEND="
	${RDEPEND}
	dev-python/cython[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
# need network access
EPYTEST_IGNORE=(
	tests/test_doctests.py
	tests/test_timeout.py
)
EPYTEST_DESELECT=(
	'tests/test_audiofifo.py::TestAudioFifo::test_data'
	'tests/test_bitstream.py::test_filter_h264_mp4toannexb'
	'tests/test_bitstream.py::test_filter_output_parameters'
	'tests/test_bitstream.py::test_filter_flush'
	'tests/test_chapters.py::test_chapters'
	'tests/test_chapters.py::test_set_chapters'
	'tests/test_chapters.py::test_set_chapters_empty'
	'tests/test_codec_context.py::TestCodecContext::test_bits_per_coded_sample'
	'tests/test_codec_context.py::TestCodecContext::test_codec_delay'
	'tests/test_codec_context.py::TestCodecContext::test_codec_tag'
	'tests/test_codec_context.py::TestCodecContext::test_parse'
	'tests/test_codec_context.py::TestCodecContext::test_parse_assigns_packet_timing'
	'tests/test_codec_context.py::TestEncoding::test_encoding_aac'
	'tests/test_codec_context.py::TestEncoding::test_encoding_dnxhd'
	'tests/test_codec_context.py::TestEncoding::test_encoding_dvvideo'
	'tests/test_codec_context.py::TestEncoding::test_encoding_h264'
	'tests/test_codec_context.py::TestEncoding::test_encoding_mjpeg'
	'tests/test_codec_context.py::TestEncoding::test_encoding_mp2'
	'tests/test_codec_context.py::TestEncoding::test_encoding_mpeg1video'
	'tests/test_codec_context.py::TestEncoding::test_encoding_mpeg4'
	'tests/test_codec_context.py::TestEncoding::test_encoding_pcm_s24le'
	'tests/test_codec_context.py::TestEncoding::test_encoding_png'
	'tests/test_codec_context.py::TestEncoding::test_encoding_tiff'
	'tests/test_codec_context.py::TestEncoding::test_encoding_xvid'
	'tests/test_colorspace.py::test_penguin_joke'
	'tests/test_colorspace.py::test_sky_timelapse'
	'tests/test_containerformat.py::test_video_codec_id'
	'tests/test_decode.py::TestDecode::test_decode_audio_sample_count'
	'tests/test_decode.py::TestDecode::test_decode_close_then_use'
	'tests/test_decode.py::TestDecode::test_decoded_motion_vectors'
	'tests/test_decode.py::TestDecode::test_decoded_motion_vectors_no_flag'
	'tests/test_decode.py::TestDecode::test_decoded_time_base'
	'tests/test_decode.py::TestDecode::test_decoded_video_enc_params'
	'tests/test_decode.py::TestDecode::test_decoded_video_enc_params_no_flag'
	'tests/test_decode.py::TestDecode::test_decoded_video_frame_count'
	'tests/test_decode.py::TestDecode::test_flush_decoded_video_frame_count'
	'tests/test_decode.py::TestDecode::test_no_side_data'
	'tests/test_decode.py::TestDecode::test_side_data'
	'tests/test_dlpack.py::test_video_plane_dlpack_export_keeps_frame_alive_after_gc'
	'tests/test_encode.py::TestBasicAudioEncoding::test_transcode'
	'tests/test_encode.py::TestSubtitleEncoding::test_subtitle_muxing'
	'tests/test_file_probing.py::TestAudioProbe::test_container_probing'
	'tests/test_file_probing.py::TestAudioProbe::test_stream_probing'
	'tests/test_file_probing.py::TestDataProbe::test_container_probing'
	'tests/test_file_probing.py::TestDataProbe::test_stream_probing'
	'tests/test_file_probing.py::TestSubtitleProbe::test_container_probing'
	'tests/test_file_probing.py::TestSubtitleProbe::test_stream_probing'
	'tests/test_file_probing.py::TestVideoProbe::test_container_probing'
	'tests/test_file_probing.py::TestVideoProbe::test_stream_probing'
	'tests/test_indexentries.py::TestIndexEntries::test_index_entries_in_bounds'
	'tests/test_indexentries.py::TestIndexEntries::test_index_entries_len_mp4'
	'tests/test_indexentries.py::TestIndexEntries::test_index_entries_len_webm'
	'tests/test_indexentries.py::TestIndexEntries::test_index_entries_matches_packet_mp4'
	'tests/test_indexentries.py::TestIndexEntries::test_index_entries_out_of_bounds'
	'tests/test_indexentries.py::TestIndexEntries::test_index_entries_search_timestamp_options_mp4'
	'tests/test_indexentries.py::TestIndexEntries::test_index_entries_slice'
	'tests/test_open.py::test_path_input'
	'tests/test_open.py::test_str_input'
	'tests/test_open.py::test_path_output'
	'tests/test_open.py::test_str_output'
	'tests/test_packet.py::TestProperties::test_is_keyframe'
	'tests/test_packet.py::TestProperties::test_is_corrupt'
	'tests/test_packet.py::TestProperties::test_is_discard'
	'tests/test_packet.py::TestProperties::test_is_disposable'
	'tests/test_packet.py::TestProperties::test_set_duration'
	'tests/test_packet.py::TestPacketSideData::test_iter'
	'tests/test_packet.py::TestPacketSideData::test_palette'
	'tests/test_packet.py::TestPacketSideData::test_buffer_protocol'
	'tests/test_packet.py::TestPacketSideData::test_skip_samples_remux'
	'tests/test_python_io.py::TestPythonIO::test_reading_from_buffer'
	'tests/test_python_io.py::TestPythonIO::test_reading_from_buffer_no_seek'
	'tests/test_python_io.py::TestPythonIO::test_reading_from_file'
	'tests/test_python_io.py::TestPythonIO::test_reading_from_pipe_readonly'
	'tests/test_python_io.py::TestPythonIO::test_reading_from_write_readonly'
	'tests/test_python_io.py::TestPythonIO::test_writing_to_custom_io_image2'
	'tests/test_remux.py::test_video_remux'
	'tests/test_remux.py::test_add_mux_stream_video'
	'tests/test_remux.py::test_add_stream_from_template_copies_time_base'
	'tests/test_seek.py::TestSeek::test_decode_half'
	'tests/test_seek.py::TestSeek::test_seek_end'
	'tests/test_seek.py::TestSeek::test_seek_float'
	'tests/test_seek.py::TestSeek::test_seek_int64'
	'tests/test_seek.py::TestSeek::test_seek_middle'
	'tests/test_seek.py::TestSeek::test_seek_start'
	'tests/test_seek.py::TestSeek::test_stream_seek'
	'tests/test_streams.py::TestStreams::test_stream_tuples'
	'tests/test_streams.py::TestStreams::test_loudnorm'
	'tests/test_streams.py::TestStreams::test_selection'
	'tests/test_streams.py::TestStreams::test_discard'
	'tests/test_streams.py::TestStreams::test_printing_video_stream'
	'tests/test_streams.py::TestStreams::test_printing_video_stream2'
	'tests/test_streams.py::TestStreams::test_attachment_stream'
	'tests/test_subtitles.py::TestSubtitle::test_movtext'
	'tests/test_subtitles.py::TestSubtitle::test_subset'
	'tests/test_subtitles.py::TestSubtitle::test_vobsub'
	'tests/test_subtitles.py::TestSubtitle::test_subtitle_flush'
	'tests/test_subtitles.py::TestSubtitle::test_subtitle_header_read'
	'tests/test_videoframe.py::test_frame_duration_matches_packet'
	'tests/test_videoframe.py::test_interpolation'

	# to be investigated
	'tests/test_encode.py::TestBasicVideoEncoding::test_encoding_with_pts'
	'tests/test_encode.py::TestMaxBFrameEncoding::test_max_b_frames'
	'tests/test_packet.py::TestDataStreams::test_data_packet_bytes'
	'tests/test_subtitles.py::TestSubtitleEncoding::test_subtitle_encode_mp4'
)
distutils_enable_tests pytest

#distutils_enable_sphinx docs dev-python/sphinx-copybutton

python_install_all() {
	if use examples; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi
	distutils-r1_python_install_all
}

# due to the generated files, we must delete the package directory
python_test() {
	rm -rf av || die

	epytest
}
